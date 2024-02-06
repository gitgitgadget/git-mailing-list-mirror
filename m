Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F4A4A06
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181316; cv=none; b=AZxnxO1cJAqgZNwsm/VDGo2y9OXdicT2gCkC3KERW1eR4SpRc9ISA0KGy9Nprt5gvD6ANyB8YR5T98GUdpfBggHRJ6DCuTPdl5LRtttZRfqbDhTuGzNCmjKRqCrXSLFGBDQR4elXX4tITIoiRa0acN+sAMg5thZuSPTvJfj5SDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181316; c=relaxed/simple;
	bh=xXE0DR+xqfURa8yxzvw148oMJ18tp7YX+Y/QgENpjBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lG64u1VE2hCJoTINY71i6xYeiuZm5MlfruNTl9zr9b8Gk/H7qoifBJwwd3DTwsa1/UDeLqt/TWH69WD5hlfGqD8GlmjoeFKOdeuNGqX6e7wpFqXU35nEEFNwGpuL7Rok8+IDkhJwECdxS9gCv1uSWNMDOvGqJlNcOXzpJk8pKY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tpq2UEZk; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpq2UEZk"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6e6bc4aa3so472255276.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 17:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707181314; x=1707786114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LJlFho+4JxMSaSCANCNYX55RrIZioXoWjZZUfScw974=;
        b=tpq2UEZkaDKRmThBssBU9G3NHZP55aFxsZ0/1ZkaX2kHXk0kjPQoxGrIfjjkNZWRGl
         QZ/NkAeQWKtl3GhTYKFHQDEjmYetrbLXlvZRuf8DfzW3A99XIjEqeZDgbOSV+m8xtGsP
         KdOBLKw6cd03nHK7f1XrIpNObu8PbrNxjqKFdlaDjs8dAxI/+79h0rv3u0O6Laui029n
         DBZfV/r4EVScqgqBXftK6XnGWkVS7ixmQKKr/8o/LBRM+JPMsAFYqwmIzuuKGjfQbVnt
         7+2+/818hx1rJbejaNyUbNo0mfk+45Bjm37Abcfi0XHvc7PZfp0lF5NpFeoGQ4+qrFTP
         icaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707181314; x=1707786114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJlFho+4JxMSaSCANCNYX55RrIZioXoWjZZUfScw974=;
        b=bJhCboi6R2Cc8J8fTBnGXiA8MKbPcrQbytJz9Vr49tya3qTvCM9ck8WDzczKNBfy2/
         Mc4f/i1/em+E2fDb2ApWef9dkxGUSh8ShVM7CDwD2YpZgwSpswsNd4rPG7fil03B3jHP
         Ysac3DOXvFuY5PuBj9jERLZrRxOzMK1Semnhok8seXUqNhvIESBI6fIJ1FbTqFo2lIjH
         XCk/uh4Lxc5gv1rpaTALt4oZBcGujAOW/YpxpV1TofRlYXaY7CDF0Abx+fItehuuRxnB
         cG0kGOhiANxbi8IiPWPBYt7b949d4tRGes7DO0B8ti45+lvlhSXihBNIOakznKH5l09s
         7cxA==
X-Gm-Message-State: AOJu0YyalEWYoDmkGmU9jXVBsC5vlreF5QFCm5dD5FOlXsmx+4hqX3IY
	KxJ7l9UL+GKZRHYgpCbz9ppuMlotToveHZufFv0k39y50DmC0gjHdu0UbNRRtV0Ym4S8Ibr//IB
	gFw==
X-Google-Smtp-Source: AGHT+IG6p7PScC8NTN33WTT84yYZfEHzw3nP38hq77S2j1MFEkNGy2829M2GkXZknkejvisZdnHVDhyIMTM=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:e01:b0:dc6:b768:2994 with SMTP id
 df1-20020a0569020e0100b00dc6b7682994mr5502ybb.0.1707181313889; Mon, 05 Feb
 2024 17:01:53 -0800 (PST)
Date: Mon, 05 Feb 2024 17:01:51 -0800
In-Reply-To: <xmqqttmrx1ro.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
 <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com> <465dc51cdcba28d235241021bc52369f6082d329.1706664145.git.gitgitgadget@gmail.com>
 <xmqqttmrx1ro.fsf@gitster.g>
Message-ID: <owlyzfwemmm8.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 08/10] trailer: move arg handling to interpret-trailers.c
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
>> index 9f0ba39b317..9a902012912 100644
>> --- a/builtin/interpret-trailers.c
>> +++ b/builtin/interpret-trailers.c
>> @@ -45,23 +45,17 @@ static int option_parse_if_missing(const struct option *opt,
>>  	return trailer_set_if_missing(opt->value, arg);
>>  }
>>  
>> -static void free_new_trailers(struct list_head *trailers)
>> -{
>> -	struct list_head *pos, *tmp;
>> -	struct new_trailer_item *item;
>> -
>> -	list_for_each_safe(pos, tmp, trailers) {
>> -		item = list_entry(pos, struct new_trailer_item, list);
>> -		list_del(pos);
>> -		free(item);
>> -	}
>> -}
>> +static char *cl_separators;
>
> It somehow feels ugly and goes backward to depend on a new global,
> especially when you are aiming to libify more things.

Removed in the next reroll (we can just use a regular stack variable,
not a global).

> Even if you plan to later make this function callable from outside
> the context of parse_options() callback, and if you do not want "CLI
> allows '=' as well" for such new callers, we should be able to have
> a shared helper function that is the bulk of this function but takes
> additional parameter to tweak its behaviour slightly depending on
> the needs of the callers?

I'll refrain from exploring this possibility in this series (and just
make do with the non-global variable as described above) because of the
additional pending changes around trailer configuration handling in the
larger series. FWIW even in the larger series I don't think there's a
need to have such a helper function.

>> +		trailer_conf_set(where, if_exists, if_missing, conf_current);
>
> I am getting an impression that the use of and the introduction of
> the new helper, mixed with movement of the responsibility, makes
> reviewing the change unnecessarily more cumbersome.  An equivalent
> series with a few more steps, each of them focusing on a small
> change (like, "updating the conf_current members is done with
> assignments that appear as a pattern very often---introduce a helper
> to reduce boilerplate") would have been more enticing to reviewers.

I've broken this patch down into smaller steps (along with the other
notable patches in this series).

>> +		trailer_add_arg_item(strbuf_detach(&tok, NULL),
>> +				     strbuf_detach(&val, NULL),
>> +				     conf_current,
>> +				     trailers);
>> +	} else {
>> +		struct strbuf sb = STRBUF_INIT;
>> +		strbuf_addstr(&sb, arg);
>> +		strbuf_trim(&sb);
>> +		error(_("empty trailer token in trailer '%.*s'"),
>> +			(int) sb.len, sb.buf);
>> +		strbuf_release(&sb);
>> +	}
>> +
>> +	free(conf_current);
>> +
>>  	return 0;
>>  }
>>  
>> @@ -135,7 +148,7 @@ static void read_input_file(struct strbuf *sb, const char *file)
>>  }
>>  
>>  static void interpret_trailers(const struct process_trailer_options *opts,
>> -			       struct list_head *new_trailer_head,
>> +			       struct list_head *arg_trailers,
>>  			       const char *file)
>>  {
>>  	LIST_HEAD(head);
>> @@ -144,8 +157,6 @@ static void interpret_trailers(const struct process_trailer_options *opts,
>>  	struct trailer_block *trailer_block;
>>  	FILE *outfile = stdout;
>>  
>> -	trailer_config_init();
>> -
>>  	read_input_file(&sb, file);
>>  
>>  	if (opts->in_place)
>> @@ -162,12 +173,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
>>  
>>  
>>  	if (!opts->only_input) {
>> -		LIST_HEAD(config_head);
>> -		LIST_HEAD(arg_head);
>> -		parse_trailers_from_config(&config_head);
>> -		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
>> -		list_splice(&config_head, &arg_head);
>> -		process_trailers_lists(&head, &arg_head);
>> +		process_trailers_lists(&head, arg_trailers);
>>  	}
>
> So, the bulk of the parsing is no longer responsibility of this
> function.  Instead, the caller (e.g., cmd_interpret_trailers()) is
> expected to do that before they call us.

Yup. This movement of "parsing responsibility" logic should be easy to
see in the next reroll (as it will be broken out separately).

>> ...
>>  	git_config(git_default_config, NULL);
>> +	trailer_config_init();
>> +
>> +	if (!opts.only_input) {
>> +		parse_trailers_from_config(&configured_trailers);
>> +	}
>
> By the way, until we add more statements in this block, lose the
> unnecessary {} around it.

Oops. Done.

>> @@ -424,6 +429,25 @@ int trailer_set_if_missing(enum trailer_if_missing *item, const char *value)
>>  	return 0;
>>  }
>>  
>> +void trailer_conf_set(enum trailer_where where,
>> +		      enum trailer_if_exists if_exists,
>> +		      enum trailer_if_missing if_missing,
>> +		      struct trailer_conf *conf)
>> +{
>> +	if (where != WHERE_DEFAULT)
>> +		conf->where = where;
>> +	if (if_exists != EXISTS_DEFAULT)
>> +		conf->if_exists = if_exists;
>> +	if (if_missing != MISSING_DEFAULT)
>> +		conf->if_missing = if_missing;
>> +}
>
> So, this is such a helper function. It is curious that it
> deliberately lacks the ability to reset what has already been
> configured back to the default.
>
> For example, we earlier saw this original code ...
>
>> -	item = xmalloc(sizeof(*item));
>> -	item->text = arg;
>> -	item->where = where;
>> -	item->if_exists = if_exists;
>> -	item->if_missing = if_missing;
>
> ... gets replaced with this call.
>
>> +	struct trailer_conf *conf_current = new_trailer_conf();
>> ...
>> +		trailer_conf_set(where, if_exists, if_missing, conf_current);
>
> For this conversion to be correct, we require that the value of the
> *_DEFAULT macro to be 0 and/or these three values getting assigned
> are not *_DEFAULT values.  Maybe that may happen to be the case in
> today's code, but such an unwritten assumption makes me feel nervous.
>
> I am not sure if it is worth the confusion factor to make a function
> whose name is $anything_set() to be making a conditional assignment.
> If such a conditional assignment *also* happens often and deserves
> to have its own helper, it is fine to have such a helper for
> conditional assignment, but calling it $anything_set() is probably a
> mistake.

Agreed. I've split this out into separate helpers that do not have
conditionals built into them.

> Other than that, the main thrust of this step seems sensible.

Ack.

Overall, for the next reroll I have the commits broken down and it is
mostly the same. I just need to wait for CI to pass and update the cover
letter, before sending it (as v4). Should be ready later tonight.
Thanks.
