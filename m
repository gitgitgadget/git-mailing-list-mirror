Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8193AEC7
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 01:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705626765; cv=none; b=mvNcetgF02viL2YOQygcgLtHeZdOaZkigADN3SahXZzMQLFtp/x5lmNJhB2AVfGBixV1q4fTeUjNiHZSnVfXMneTC8f5q85C/8G5wXSzO28AzD6BJ/535GVOmGwQjvWRWMb2SNTiuEoILzDRrA5zuei70r1+Rjp2ddkuNr7k+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705626765; c=relaxed/simple;
	bh=WdxBqOFyJBvMs4XG3etKOspeBLmQPNR2+yC2K4WKwAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K3/ZRAkNoHD5NnN+21VE2wwiA4L/08bug44M5f7uHxJwe8+HHwwKbj7XBTlfhqlHpu1daENN2a+kObWalXlMxE55ubktT2zviYECdRzE2x6zw69II8P1J6NwBCQr+hGekUmTq6m4D9qVmudYA61d+BZGy2nqAA5GR65xP5HJjRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XzbGYYWu; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XzbGYYWu"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6d9b8ff5643so256600b3a.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 17:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705626763; x=1706231563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mrXYmA8LUx3byYqvNPO67rVOMIfui3KHChvkA9Sficw=;
        b=XzbGYYWuF/wkaaAbTYeUiX+Y4cBboVkdKbusb3EFETHAndQpGTg1SGZZ1QQmUTYVk3
         ZCrsVS88eaHlocJCwr9iU6Ea7G0+/vQk8EmXxnIcvfNuXIPJDrj6rdCkUsUqYI1LQpko
         K33fcTRn9Je9M9A00bjod3PBYd7gzU9V7/jkHYXYXzSxgv5LjPgSEJa/CvI98onoiwdE
         Bg90Q6aGhuVkN4UssGs6WdKUTITyjxy6FN+kzkTcE63CMra+yT0xyOT4NqBeVn2lt4eH
         BTn4aJ9pRENnDJLSLGD3YwTBcLtE05FwqM9goIC5jTAmd2YPvndDz5WLq3LzouSVmk1d
         6bnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705626763; x=1706231563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mrXYmA8LUx3byYqvNPO67rVOMIfui3KHChvkA9Sficw=;
        b=VYWoW0i0b2CpUhnzo3yZRkFfQW2rIJmn/yZG6tRqh3AekLfPkdnJGwPHNNyQMGRf1J
         d0uXJMnxn0Gl/NPx3TW8GpN91h2Ss6Tc/KSGn5V/ZOz1EvBhBdMQRPbmrLisjatkxTXB
         JVucwjvY+5vEhzR7jT6oUyu8xeCzM8XwyY3Z3H+ksmKR91EJL8f4i3vvYNCQvxicI1Jj
         IudX2M7Sh4U2d/TVt0NJoJKG1tHGzgDjvbr2+tXQf6Ij3GqJTb0FX9ABnGJkH28N8IkS
         CSzjEiSnCA1O2MzhhC2ldeoFX4A62f5MtsQx4KnPsEBWNi5s/L+B/OYdeqfl0yBHtu5l
         UrXg==
X-Gm-Message-State: AOJu0YyYDH2NpdX5MKSAvEYUvJi6ZnpiT9VjsExNgmNRRYQykuK3ycoB
	HCFiKMJx/aA6vnBW/gzDTwqZnkAV42EEPSwdG9vcyYoaiEm9dWoBLDDQe0o8ERu8gQ9PdlyKQwG
	t6Q==
X-Google-Smtp-Source: AGHT+IGE6fbXb/lOFm4EO12dCylxSBoQocOQjkxloEynnat4Dd3IuFASe3wyjROuPRGd25dD1iDN1rQMUwU=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:39a8:b0:6da:53fc:b263 with SMTP id
 fi40-20020a056a0039a800b006da53fcb263mr199826pfb.5.1705626762712; Thu, 18 Jan
 2024 17:12:42 -0800 (PST)
Date: Thu, 18 Jan 2024 17:12:41 -0800
In-Reply-To: <xmqqr0ientdb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
 <d3326021fb6a63707e4ce56f166447143f4e55a2.1704869487.git.gitgitgadget@gmail.com>
 <xmqqr0ientdb.fsf@gitster.g>
Message-ID: <owlyplxygm7q.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 03/10] trailer: unify trailer formatting machinery
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Linus Arver <linusa@google.com>
>>
>> Currently have two functions for formatting trailers exposed in
>> trailer.h:
>>
>>     void format_trailers(FILE *outfile, struct list_head *head,
>>                         const struct process_trailer_options *opts);
>>
>>     void format_trailers_from_commit(struct strbuf *out, const char *msg,
>>                                     const struct process_trailer_options *opts);
>>
>> and previously these functions, although similar enough (even taking the
>> same process_trailer_options struct pointer), did not build on each
>> other.
>>
>> Make format_trailers_from_commit() rely on format_trailers(). Teach
>> format_trailers() to process trailers with the additional
>> process_trailer_options fields like opts->key_only which is only used by
>> format_trailers_from_commit() and not builtin/interpret-trailers.c.
>
> Yay.  It feels a bit disappointing to see the diffstat and learn
> that we are not deleting substantial number of lines.

Indeed ;)

>> ---
>>  builtin/interpret-trailers.c |   5 +-
>>  pretty.c                     |   2 +-
>>  ref-filter.c                 |   2 +-
>>  trailer.c                    | 105 +++++++++++++++++++++++++++++------
>>  trailer.h                    |  21 +++----
>>  5 files changed, 102 insertions(+), 33 deletions(-)
>
>> diff --git a/pretty.c b/pretty.c
>> index cf964b060cd..f0721a5214f 100644
>> --- a/pretty.c
>> +++ b/pretty.c
>> @@ -1759,7 +1759,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>>  				goto trailer_out;
>>  		}
>>  		if (*arg == ')') {
>> -			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
>> +			format_trailers_from_commit(msg + c->subject_off, &opts, sb);
>
> I am curious (read: no objection---merely wondering if there is a
> guiding principle behind the choice of the new order) why this new
> parameter ordering.

Glen Choo told me a while ago [1] that we usually put "out parameters"
at the end, and somehow that stuck with me.

> I suspect it was originally written with a
> strbuf-centric worldview and having sb at the beginning may have
> made sense,

Having gotten more familiar with the strbuf.h functions since this patch
was originally written, I agree.

> but if we are moving them around, wouldn't it make more
> sense to have &opts as the first parameter, as this is primarily a
> "trailers" function?  Unsure until I read through to the end, but
> that is my gut reaction.

I simply (mechanically) moved "sb" from the beginning of the parameters
to the end, and didn't think much beyond that adjustment.

Your ordering seems fine to me. Noted for the next reroll, but I will
wait until you're done reviewing the other patches before going with the
new ordering (in case you change your mind).

>>  static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
>>  {
>>  	struct trailer_item *new_item = xcalloc(1, sizeof(*new_item));
>> @@ -984,6 +971,78 @@ static void unfold_value(struct strbuf *val)
>>  	strbuf_release(&out);
>>  }
>>  
>> +void format_trailers(struct list_head *head,
>> +		     const struct process_trailer_options *opts,
>> +		     struct strbuf *out)
>> +{
>> +	struct list_head *pos;
>> +	struct trailer_item *item;
>> +	int need_separator = 0;
>> +
>> +	list_for_each(pos, head) {
>> +		item = list_entry(pos, struct trailer_item, list);
>> +		if (item->token) {
>> +			char c;
>> + ...
>> +			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
>> +				if (opts->unfold)
>> +					unfold_value(&val);
>> +
>> +				if (opts->separator && need_separator)
>> +					strbuf_addbuf(out, opts->separator);
>> +				if (!opts->value_only)
>> +					strbuf_addbuf(out, &tok);
>> +				if (!opts->key_only && !opts->value_only) {
>> +					if (opts->key_value_separator)
>> +						strbuf_addbuf(out, opts->key_value_separator);
>> +					else {
>> +						c = last_non_space_char(tok.buf);
>> +						if (c) {
>> +							if (!strchr(separators, c))
>> +								strbuf_addf(out, "%c ", separators[0]);
>> +						}
>> +					}
>
> That's an overly deep nesting.  I wonder if a small file-scope
> helper function is in order?
>
> 	static add_separator(struct process_trailer_options *opts,
>         		     const char *token
> 			     struct strbuf *out)
> 	{
> 		if (opts->key_value_separator)
> 			strbuf_addbuf(out, opts->key_value_separator);
> 		else
> 			strbuf_addstr(out, ": ");
> 	}
>
> Or perhaps inside the context of the loop to go over the list of
> trailer items, one iteration of the list_for_each() loop can become
> one call to a small helper function format_one_trailer() and that
> may make the result easier to follow?

This is actually what I've already done (introducing helper functions to
make this more readable and reduce nesting), but in the larger series
(not in this patch series). I think in this patch I tried to avoid
introducing new functions in order to keep the original "shape" of the
existing refactored functions, including all of the nesting that they
originally had. I wanted to keep the original shape because I thought
that would make review simpler.

> In any case, I didn't see anything glaringly wrong so far in this
> series.  Let me keep reading.
>
> Thanks.

Thank you for reviewing!

[1] https://lore.kernel.org/git/kl6l5y5qa34v.fsf@chooglen-macbookpro.roam.corp.google.com/ 
