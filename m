Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5FC329E78
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792741; cv=none; b=WQ09gZ6Vw9LUh48dxFjJTr/oMibpjc/zihjCSHGFN+7E69Dy2vzXKScFbK8PVbNl0wEAuNXH1iWFSzOhWH5hj00gA58baXMTcMb60e9Enq6ApUzZEhzrZ1DtYrDLJyKiYAI2kMjeuIyOhoqGQLGP5u75VnEG/jZ/NYLGcmmrEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792741; c=relaxed/simple;
	bh=TFU5reHFIbno2WumEYGDpDOJsRFonyzNT9311qv8me8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S5m3YAbNZjqZMvWlz5KC91aGxin+TiZvsMd0hS6bweWoOYCUBo2ibQ8y4u1k56SYBR4eM6CGW09LsE68iSVKRXwrB3g+CWYBAL8g6TNwUFvKp8OksuXpVocXHv4c2i3gKZJKjUykLTNUBU59HjwV0boT5QuobfhI+CtJ4Jp4zcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MycJO1M4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MycJO1M4"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so12639435e9.0
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 08:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792738; x=1763397538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/Qut7+gB5XqXoUGQNWRwIv98iep7ChaF802boWlcz0=;
        b=MycJO1M4jmpcWWzS4Sw49uq9cdlAPM4EiIi9Yh+bYJ6gKgMxT8IGNJM0fdBKD1ppxY
         ZQNGM9ur3fUdxtKOTiGX2k3P0KbWc+rU0c6rxs49glWrzfASE9k4I0v3XAXq5LKVR159
         ksmbHR2Wwe0qzDeFzkzDY2yJivZUXU4c6ZBAtpO5RSg+/jJ7m+xWCBljXrHh1ub6RNKS
         dbmNE5m83CFT8Wsf57Iugdn2M39Jw165CspKCXvNCQ3f/YBMOYanYZBqdsKWx0byOAEO
         C7HoZB/PA4c7uVYBnoQmcSMqV9sns4Z/WE6LZwZoO7JHPU+dg18BlWSdgeL8dSHglDZ8
         UTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792738; x=1763397538;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/Qut7+gB5XqXoUGQNWRwIv98iep7ChaF802boWlcz0=;
        b=XMFrGGmwAejZqdSi9sY2iIALbcxM//q42htQlkz98+39R1Pnzmp+NQ8WDlBuGlcpQ3
         lSnI7jnmeKGuls36KmzpRwNCjBbPxtBVUiVyFgu7Yxm+rCGoa9KSRzzKOtgwxikKy8zF
         5kAZjPSlngm7IwO2lVTWCD/y6lKpkI3u9Pq5Qdm8eXfzuNyPbvBqMVxX7lK72kaq7nIq
         c86frIXYU9YkqVFkqHL+VHTuMTXb9c1+VNo2qcuWPzsYzNh1unduvD+NKLPWDTdspCRF
         zFv4DaaHGu1lG4A0oY8dCdxNjvcROHqk63SDE6fOMT/klLa6dKyszvnVR/NDqklJlo/T
         olBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQMTKGGZ5GeYv/HtI5wTWcu3RyFzXION3FOWjDaC5dBNRnDqfWVEloqTMy7jVL0W5YGDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKscolX1bQ0Agi05/a7wnY3f7NMnO8k8dO1ltXTetgPPsop3Ew
	ZFW7kW1/Y5xAnPApDtYRpkMtvb/5d17prPz579GFttNKVYLjX7Iaa4u5
X-Gm-Gg: ASbGncskQybLykI9iBveXlI3QWOFK3043bD5VwjEEhOd0SCiI591KiDreJPo2gXEX8F
	DWdO1hvkDqhYIdZ0VVm7Ko2IUJRpMKR/jgykWBEwEKKAbfibfwdrmGvTQhFhpHs6TZg01uSeEm0
	ZQ9c9+K7o09Ml83FiR6Wys3CiQRuHo+bP7K5WsDQdWwFAY3f1Ik21/EcJMd7AUxf3N887eyGPrf
	+gRan2/YvygsRN5SDebZ35vcoMBbBQzbHreeFUOLDrd2+mxw/ZDJItUUqMJ6KK6sxj9rjH1/wFH
	1BG4pa3AZKKxCzKVB6FnegbM1y0PpNySQd3DBoT5xwJDsxWNxv5TGOJpiDX1mzXXFa8rnCW+rvA
	MiU8PLerqHposYVG3HdRpkxTnFw/o3KmQZ8iAGkRVLalZk8EuYBQJie9Dyk/K+JFvavZclK0fOM
	TA393NHsb4tXXKCwj/mf7oxb83xP+soN1dLprCs5NHVM5sgLed3LGe
X-Google-Smtp-Source: AGHT+IFkr6peThRbjEBReUgYnL2nVHddW7vW/6HWunnm7L3y48mWxLhNQrhKcyC0LSrrw+BNh1uzUw==
X-Received: by 2002:a05:600c:4ecc:b0:475:de05:661f with SMTP id 5b1f17b1804b1-4777329400bmr77231695e9.41.1762792737761;
        Mon, 10 Nov 2025 08:38:57 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e170ecsm112327385e9.2.2025.11.10.08.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:38:56 -0800 (PST)
Message-ID: <ef12ada7-13ae-4df0-a823-6f428c797223@gmail.com>
Date: Mon, 10 Nov 2025 16:38:55 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 3/4] trailer: append trailers in-process and drop the
 fork to `interpret-trailers`
To: Li Chen <me@linux.beauty>, phillipwood <phillip.wood@dunelm.org.uk>,
 git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20251105142944.73061-1-me@linux.beauty>
 <20251105142944.73061-4-me@linux.beauty>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20251105142944.73061-4-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Li

On 05/11/2025 14:29, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 0243f17d53..67070d6a54 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1719,7 +1719,7 @@ int cmd_commit(int argc,
>   		OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]commit"), N_("use autosquash formatted message to fixup or amend/reword specified commit")),
>   		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
>   		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
> -		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG),

We have OPT_STRVEC to handle this. The commit message should explain why 
we're doing this (because we only want to pass the value to 
amend_file_with_trailers()). Alternatively we could use skip_prefix() in 
amend_file_with_trailers() to skip the "--trailer=" prefix in this patch 
and then clean it in a separate patch.

> +		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, parse_opt_strvec),
>   		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
>   		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
>   		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index bce2e791d6..268a43372b 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> 
> @@ -142,21 +110,15 @@ static void interpret_trailers(const struct process_trailer_options *opts,
>   {
>   	struct strbuf sb = STRBUF_INIT;
>   	struct strbuf out = STRBUF_INIT;
> -	FILE *outfile = stdout;
> -
> -	trailer_config_init();

Why is this being moved?
>   	read_input_file(&sb, file);
>   
> -	if (opts->in_place)
> -		outfile = create_in_place_tempfile(file);
> -
>   	process_trailers(opts, new_trailer_head, &sb, &out);
>   
> -	fwrite(out.buf, out.len, 1, outfile);
>   	if (opts->in_place)
> -		if (rename_tempfile(&trailers_tempfile, file))
> -			die_errno(_("could not rename temporary file to %s"), file);
> +		write_file_buf(file, out.buf, out.len);

This truncates the existing file which means that if there is a error 
while writing the new version the user is now left with garbage rather 
than the original file which does not seem like a good idea.

 > diff --git a/trailer.c b/trailer.c> index b735ec8a53..f5838f5699 100644
> --- a/trailer.c
> +++ b/trailer.c
> 
> @@ -1224,18 +1226,66 @@ void trailer_iterator_release(struct trailer_iterator *iter)
>   	strbuf_release(&iter->key);
>   }
>   
> -int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)
> +static int amend_strbuf_with_trailers(struct strbuf *buf,
> +				      const struct strvec *trailer_args)
>   {
> -	struct child_process run_trailer = CHILD_PROCESS_INIT;
> -
> -	run_trailer.git_cmd = 1;
> -	strvec_pushl(&run_trailer.args, "interpret-trailers",
> -		     "--in-place", "--no-divider",
> -		     path, NULL);
> -	strvec_pushv(&run_trailer.args, trailer_args->v);
> -	return run_command(&run_trailer);
> +	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
> +	LIST_HEAD(new_trailer_head);
> +	struct strbuf out = STRBUF_INIT;
> +	size_t i;
> +
> +	opts.no_divider = 1;
> +
> +	for (i = 0; i < trailer_args->nr; i++) {
> +		const char *text = trailer_args->v[i];
> +		struct new_trailer_item *item;
> +
> +		if (!*text)
> +			continue;

Isn't it an error to pass an empty argument to "--trailer"?

> +		item = xcalloc(1, sizeof(*item));
> +		INIT_LIST_HEAD(&item->list);

I don't think we need this as "item->prev" and "item->next" are set by 
list_add_tail() below.

We initialize "where", "if_exists" and "if_missing" to zero which 
matches what builtin/interpret-trailers.c does if the user does not 
specify any of those options - good.

> +		item->text = text;
> +		list_add_tail(&item->list, &new_trailer_head);
> +	}
> +
> +	process_trailers(&opts, &new_trailer_head, buf, &out);
> +
> +	strbuf_swap(buf, &out);
> +	strbuf_release(&out);
> +	while (!list_empty(&new_trailer_head)) {
> +		struct new_trailer_item *item =
> +			list_first_entry(&new_trailer_head, struct new_trailer_item, list);
> +		list_del(&item->list);
> +		free(item);

We have free_trailers() to do this for us.

> +	}
> +	return 0;
>   }
>   
> +int amend_file_with_trailers(const char *path,
> +			     const struct strvec *trailer_args)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	if (!trailer_args || !trailer_args->nr)
> +		return 0;

Isn't it a bug to pass a NULL trailer_args?

> +	if (strbuf_read_file(&buf, path, 0) < 0)
> +		return error_errno("could not read '%s'", path);
> +
> +	if (amend_strbuf_with_trailers(&buf, trailer_args)) {
> +		strbuf_release(&buf);
> +		return error("failed to append trailers");
> +	}
> +
> +	if (write_file_buf_gently(path, buf.buf, buf.len)) {
> +		strbuf_release(&buf);
> +		return -1;
> +	}
> +
> +	strbuf_release(&buf);
> +	return 0;
> + }

This looks like a faithful conversion of the original with the caveat 
that it expects to be passed an array of trailer arguments without the 
"--trailer=" prefix. Good

I'll take a look at patch 4 tomorrow but so far these version is looking 
much nicer than the last round.

Thanks

Phillip

>   void process_trailers(const struct process_trailer_options *opts,
>   		      struct list_head *new_trailer_head,
>   		      struct strbuf *sb, struct strbuf *out)
> diff --git a/trailer.h b/trailer.h
> index 44d406b763..daea46ca5d 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -196,9 +196,8 @@ int trailer_iterator_advance(struct trailer_iterator *iter);
>   void trailer_iterator_release(struct trailer_iterator *iter);
>   
>   /*
> - * Augment a file to add trailers to it by running git-interpret-trailers.
> - * This calls run_command() and its return value is the same (i.e. 0 for
> - * success, various non-zero for other errors). See run-command.h.
> + * Augment a file to add trailers to it (similar to 'git interpret-trailers').
> + * Returns 0 on success or a non-zero error code on failure.
>    */
>   int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
>   
> diff --git a/wrapper.c b/wrapper.c
> index 3d507d4204..1f12dbb2fa 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -688,6 +688,22 @@ void write_file_buf(const char *path, const char *buf, size_t len)
>   		die_errno(_("could not close '%s'"), path);
>   }
>   
> +int write_file_buf_gently(const char *path, const char *buf, size_t len)
> +{
> +	int fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
> +
> +	if (fd < 0)
> +		return error_errno(_("could not open '%s'"), path);
> +	if (write_in_full(fd, buf, len) < 0) {
> +		int ret = error_errno(_("could not write to '%s'"), path);
> +		close(fd);
> +		return ret;
> +	}
> +	if (close(fd))
> +		return error_errno(_("could not close '%s'"), path);
> +	return 0;
> +}
> +
>   void write_file(const char *path, const char *fmt, ...)
>   {
>   	va_list params;
> diff --git a/wrapper.h b/wrapper.h
> index 44a8597ac3..e5f867b200 100644
> --- a/wrapper.h
> +++ b/wrapper.h
> @@ -56,6 +56,12 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
>    */
>   void write_file_buf(const char *path, const char *buf, size_t len);
>   
> +/**
> + * Like write_file_buf(), but report errors instead of exiting. Returns 0 on
> + * success or a negative value on error after emitting a message.
> + */
> +int write_file_buf_gently(const char *path, const char *buf, size_t len);
> +
>   /**
>    * Like write_file_buf(), but format the contents into a buffer first.
>    * Additionally, write_file() will append a newline if one is not already

