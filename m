Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F68200C4
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709246030; cv=none; b=Imm4OdNLjxJizzSlQZYcPv26gxA04v7mKHMBTNkSFQRZSfMl9BmtGzOj/CKibg4mzdH++9g7ZjG8dDtKV3y2h1b+DVEWhqjTa4orCviDK96CP9yB4j3jPrfmozpdMXuWXUuHmCsaRB/DnE0N+cbXnrCl6U/jy+70Hpi4kpvlVrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709246030; c=relaxed/simple;
	bh=pcF8T2InIz/XbkBihms17eCwme1+JR3dnTFZ6/pkzaQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QFzbvOgbwdzHl1xialrZfFNBMRjyEWR6CX9w3RRQGhiUyu3T5Jead3IR/k0kSn3tlMstK+xZnxv9LMXRcmQlo3RGC+u0A/EGIXF13Q++TDRzoZqFRQW/PUmWQ6e1hTFiN4XytDS/WVezFCs0TiJyZB4e5KCkWg70BqUD/LSGWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CFE2jZL1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFE2jZL1"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607e8e8c2f1so24920727b3.3
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 14:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709246028; x=1709850828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clL/yH34SoQlIx2Z9mqkOqogbiJdQHNi7CLkQrTezig=;
        b=CFE2jZL1NM6cvfamCGb/QFQ2iG9RyJpYrMMGmuA3t3aRJcg1Z1fxCkOOmU9PGxDX7N
         nKQ8Dhse/MH/nUN1vFPGFA79UKOFS+0XPkZZfTgYaSDkxggz7J688DKClv8idslZCY1q
         k58ILHesHdDX2gGlM1LVz5uP5gy+UWqn2BB+je5n20kg9W+py+uUaK2CHnlUcr8Pi6ZH
         hTeRJJLqHihKeuCmPZ8eFWs38J8gmHolrqUDC7blEqGGzHR66fYSas8rQryoMZCyBZpI
         pDwhIZ2cXJERPgLcPD/E4sJqAXFLzU+zVwoLmcwEDz5zPh7DCTbFCFceMtoqaIzZ6m5a
         OfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709246028; x=1709850828;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=clL/yH34SoQlIx2Z9mqkOqogbiJdQHNi7CLkQrTezig=;
        b=V2IzcP7yi2Y4tdW0UgdxAte3LcZft8gBNsdEKirQUzwrHLZqqYvbbb4eJbF9MFhu97
         yupxD8f1tV1cF0aU8cYiczpZJhLmzUcEgipfGuOGOKPKcUcWIBFoEjCcTAS54m+9pdIn
         AOTV+KVUDd/OPxyNpzB9szBvFk3BU+TTl/jPxo2eQSUbTq2FUyAQiTYKfLyF1OdM9UR/
         nKO3mFxXh7YM3FwHLNNOaZoD9PWtzj529kp4BlrmC815pF2Ge8Oc6wyGtDVmf76lFFtr
         saiPVxkXCkbNzKWxCySxLU4X3OftUhERW71SquKvuMtD+MivS8voyAeAQtolvTzDaXVM
         FTxw==
X-Gm-Message-State: AOJu0YwcWa62HrK8xq2FNPj6QTseylQUMBRCSMwp89rnQnO/eYcS/xMN
	oN4LVcUCLh9QCU1ehhPtiqVN/730gsZhqNdg0BzCKNC8rpIeNdn4HIuikeSj40BVS6ZZ9TfiUxw
	JBw==
X-Google-Smtp-Source: AGHT+IG1wuOfpvOhyjvK4y+aEBx0YqoUPt0wTKjeUvYkeugNQCUR8eajJv9h9Uz8zVP1raBDBZ4bJNRgoqI=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:114c:b0:dc2:5456:d9ac with SMTP id
 p12-20020a056902114c00b00dc25456d9acmr179323ybu.5.1709246028065; Thu, 29 Feb
 2024 14:33:48 -0800 (PST)
Date: Thu, 29 Feb 2024 14:33:46 -0800
In-Reply-To: <CAP8UFD1dE2EiSxohose6U9SGn+zeHPyVB=KZ2xdQi-v-a8d1XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
 <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com> <4372af244f02b71cc70f3a8e1b5591b3b9fec93a.1708124951.git.gitgitgadget@gmail.com>
 <CAP8UFD1dE2EiSxohose6U9SGn+zeHPyVB=KZ2xdQi-v-a8d1XQ@mail.gmail.com>
Message-ID: <owlyttlq529h.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v5 3/9] trailer: prepare to expose functions as part of API
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Feb 17, 2024 at 12:09=E2=80=AFAM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Linus Arver <linusa@google.com>
>>
>> In the next patch, we will move "process_trailers" from trailer.c to
>> builtin/interpret-trailers.c. That move will necessitate the growth of
>> the trailer.h API, forcing us to expose some additional functions in
>> trailer.h.
>
> Nit: actually this patch renames process_trailers() to
> interpret_trailers() so the function that will be moved will be
> interpret_trailers().

Oops, fixed locally.

> Nit: this patch and the next one will become commits, so perhaps:
>
> s/In the next patch/In a following commit/

TBH I've always wondered whether "patch" or "commit" matters --- I've
seen examples of patch series that referred to "commits" instead of
"patches", and vice versa. I was hoping to hear an opinion on this, so
I'm happy to see (and apply) your suggestion. Thanks.

>> Rename relevant functions so that they include the term "trailer" in
>> their name, so that clients of the API will be able to easily identify
>> them by their "trailer" moniker, just like all the other functions
>> already exposed by trailer.h.
>
> Except that "process_trailers()" already contains "trailer" but will
> still be renamed by this patch to "interpret_trailers()". So I think
> it might be nice to explain a bit why renaming process_trailers() to
> interpret_trailers() makes sense too.

I will add something like:

    Rename process_trailers() to interpret_trailers(), because it
    matches the name for the builtin command of the same name
    (git-interpret-trailers), which is the sole user of
    process_trailers().

> Also I think the subject, "trailer: prepare to expose functions as
> part of API" could be more explicit about what the patch is actually
> doing, like perhaps "trailer: rename functions to use 'trailer'".

Applied.

> In general, when there is a patch called "prepare to do X", then we
> might expect a following patch called something like "actually do X".
> But there isn't any patch in the series named like "trailer: expose
> functions as part of API".

Sounds like a very sensible rule. IOW, leave the detailed explanation to
the commit message and use the subject line only for the most obvious
explanation of what's going on in the patch. +1

>> Take the opportunity to start putting trailer processing options (opts)
>> as the first parameter. This will be the pattern going forward in this
>> series.
>
> It's interesting to know that this will be the pattern going forward
> in the series, but that doesn't quite tell why it's a good idea to do
> it.
>
> So I think it might be nice to repeat an explanation similar to the
> one you give in "trailer: start preparing for formatting unification"
> for format_trailers_from_commit():
>
> "Reorder parameters for format_trailers_from_commit() to prefer
>
>     const struct process_trailer_options *opts
>
> as the first parameter, because these options are intimately tied to
> formatting trailers."
>
> And maybe also say that parameters like `FILE *outfile` should be last
> because they are some kind of 'out' parameters.

SGTM, will do.

>> diff --git a/trailer.c b/trailer.c
>> index f74915bd8cd..916175707d8 100644
>> --- a/trailer.c
>> +++ b/trailer.c
>> @@ -163,12 +163,12 @@ static void print_tok_val(FILE *outfile, const cha=
r *tok, const char *val)
>>                 fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
>>  }
>>
>> -static void print_all(FILE *outfile, struct list_head *head,
>> -                     const struct process_trailer_options *opts)
>> +static void format_trailers(const struct process_trailer_options *opts,
>> +                           struct list_head *trailers, FILE *outfile)
>
> This also renames `struct list_head *head` to `struct list_head
> *trailers`. I think it would be nice if the commit message could talk
> a bit about these renames too.

Ah nice catch. Will do.

Really appreciate the quality of your reviews, thanks so much! :)
