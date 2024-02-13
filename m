Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61FB5DF18
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843957; cv=none; b=JiVLsKyVjZ09c3cQQ/lJq+b9f06F26HLd/XJltxbFFWK7otb+0YepXd8ALiu/qVTFJDYM+3sfw9+0eGyuZrJ5DSbueXd5sYpbTSClEpFRVD/LG4CEbRtzSxHzkAtkueURXgi+KXVtA5/V8j9P9Fjl4bmFAWILJlSHDifk8thVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843957; c=relaxed/simple;
	bh=kgaL/UimXWt0EyA7vzK+4hUIktiZnfYG+nFi8+P+HI8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KSg0FcL1vAAKCSwO63EWiXqwlGcIR2Xe7H9zuq2BKqUTZtOMwIoIG94O5R5GQvffuTqMAh/jEQihucPft6P27E+1195wCi+cd+rfD4W7YgP0/rnvX7ULXoxz9PsqcADv278y17p2bkjCdFPuubYuv7OqUNUWhhvZroYOCrMytUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n4dNXyJY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n4dNXyJY"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6078b764778so16037667b3.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 09:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707843954; x=1708448754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uK6BGBS6WMDqCLvNAuYgOebVPsh/P04oJQ4FQzs4iwY=;
        b=n4dNXyJYu4bqortXNV/S0RCz1gqVKBvh9fXaz5um1WZd2gisUa9Ov+d5t8Veu6aL4g
         2K40MC2HTtBsd5c2+0oG7kZ9Ri9GvFManEM2/4GoagFvlRbs117sXJKsnoA1Qi2LLyjM
         qZ7afpGT7Kv/G9fiG3Hfl7TPwELnFMPli4Zw7Pj7k+Ds7sXfMFeHfpO3xrTiOCAwEFSv
         3zX7HJNbkzBs8V1f30np+2WgKim8yYDuqwHhTXpcaWRVzm0n3nD5WtXS/+dfvda7wN4p
         F/RpZq9n0W2Py1wccBh16qMTwDsGNu7p51Jq9OCyGoQ1zpzy58X7QPDqLt+KbUYAruDh
         5j+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707843954; x=1708448754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uK6BGBS6WMDqCLvNAuYgOebVPsh/P04oJQ4FQzs4iwY=;
        b=QntI1NnKMXJAE0cl6HBuN3oHg12hGJL6WyP06yLV/xJl5+Ou0tNjmxNQVetLf+3gmJ
         XynRNkfSONYvqVDx4p6FZjlAh7NANrxbcExBx+1DtyzC9yfVggBWNlL3Ea7H0Z/RA/Zw
         yejWcpiPAZhTXlrvrmTcFCztr+v7AlEvu2mq5hIu6va1MuxFus6rgZaUMUSap7vrWg65
         jcAnRGWAJav6UJA4TCbnMW0dk1NWpBjzON/HqlBaVd8tgtNHlajJ9x4cA92AhdejpO5n
         5Ifx02EvsUXHv2pGR0SHhXeI1EDA+RcfzfXy1bVc7lI0GzZwnTcsjUXn/Kb17e0ZxKsj
         HOGQ==
X-Gm-Message-State: AOJu0YxIJAG84GSM3LcVfIWz50WbKzNlfjngvb3ZZqD3piEkGbzW6Rhb
	zjYoauhNJWneuJ3OpRivAIKZ2LXhWLN/li9dOP4W0t0OVP/z2sQksKtPQMrpEmQP+ylbYEcOdPz
	CMA==
X-Google-Smtp-Source: AGHT+IFs83zvZiFjc1h+W7zHNoPvwna7FcG2EuDRO9i49gwx3H2nJOTGMsoIvzgyXS2kGHFYBhF2+GmfDBQ=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:728:b0:dc7:53a0:83ad with SMTP id
 l8-20020a056902072800b00dc753a083admr2911530ybt.5.1707843954695; Tue, 13 Feb
 2024 09:05:54 -0800 (PST)
Date: Tue, 13 Feb 2024 09:05:53 -0800
In-Reply-To: <CAP8UFD3wMD5SmfpP20jST4YndBdPX9U9qAbKh=4TnUzLkpULRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <11f854399db2b0da5d82cad910c3b86ca9c2e0db.1707196348.git.gitgitgadget@gmail.com>
 <CAP8UFD3wMD5SmfpP20jST4YndBdPX9U9qAbKh=4TnUzLkpULRA@mail.gmail.com>
Message-ID: <owlyttmcb8ge.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 14/28] format_trailer_info(): teach it about opts->trim_empty
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

Christian Couder <christian.couder@gmail.com> writes:

>> diff --git a/trailer.c b/trailer.c
>> index f4defad3dae..c28b6c11cc5 100644
>> --- a/trailer.c
>> +++ b/trailer.c
>> @@ -162,20 +162,6 @@ static void print_tok_val(struct strbuf *out, const char *tok, const char *val)
>>                 strbuf_addf(out, "%s%c %s\n", tok, separators[0], val);
>>  }
>>
>> -static void format_trailers(const struct process_trailer_options *opts,
>> -                           struct list_head *trailers,
>> -                           struct strbuf *out)
>> -{
>> -       struct list_head *pos;
>> -       struct trailer_item *item;
>> -       list_for_each(pos, trailers) {
>> -               item = list_entry(pos, struct trailer_item, list);
>> -               if ((!opts->trim_empty || strlen(item->value) > 0) &&
>> -                   (!opts->only_trailers || item->token))
>> -                       print_tok_val(out, item->token, item->value);
>> -       }
>> -}
>
> It seems to me that this function could and should have been removed
> in the previous patch. If there is a reason why it is better to do it
> in this patch, I think it should be explained more clearly in the
> commit message.

Ah yes, the decision to delay the deletion like this was deliberate.
Will update the commit message to add something like:

    Although we could have deleted format_trailers() in the previous patch,
    we perform the deletion here like this in order to isolate
    (and highlight) in this patch the salvaging of the logic in the deleted
    code

        if ((!opts->trim_empty || strlen(item->value) > 0) && ...)
            print_tok_val(...)

    as

        if (opts->trim_empty && !strlen(item->value))
            continue;

    in the new code, which has the same effect (because we are skipping the
    formatting in the new code).

>>  static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
>>  {
>>         struct trailer_item *new_item = xcalloc(1, sizeof(*new_item));
>> @@ -1101,6 +1087,15 @@ void format_trailer_info(const struct process_trailer_options *opts,
>>                         strbuf_addstr(&tok, item->token);
>>                         strbuf_addstr(&val, item->value);
>>
>> +                       /*
>> +                        * Skip key/value pairs where the value was empty. This
>> +                        * can happen from trailers specified without a
>> +                        * separator, like `--trailer "Reviewed-by"` (no
>> +                        * corresponding value).
>> +                        */
>> +                       if (opts->trim_empty && !strlen(item->value))
>> +                               continue;
>> +
>
> Wasn't it possible to make this change in format_trailer_info() before
> using format_trailer_info() to replace format_trailers()?

It was certainly possible, but the choice to purposely time the
addition/deletion of code like this was deliberate (see my comment
above).

>>                         if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
>>                                 if (opts->separator && out->len != origlen)
>>                                         strbuf_addbuf(out, opts->separator);
