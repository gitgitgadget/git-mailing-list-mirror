Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0321EEA35
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501065; cv=none; b=t/EVHSK21mGR4Tg8BoTWmOis88KLw5bRkG9iBDcM3Gd7VaWpW/dXj1kOyO+8HIwfclYb09Z7BFLW0DcTxsN3h3blzeq/FMGO1lxNTT3ulDkajDXQrDadnBxeSeuQvSJTqCZMK/t7z1jv/mubcqabfWsxope5XKq/hBMt4Sna/GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501065; c=relaxed/simple;
	bh=rd4SElun13auZeZCGaX/qNuR9VsExqtyFDWghJ7NaIg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwPT2YO5Wv2etMs7osXVHshjE0++8imFLAPiCLI9N/8K6RIMXgK4mpCiDvdTCv6lWnnNZnx/G1Gjzr2nwQ7dHbx30qPNlLbETDCr2nC6FeKLltM+FFYeU5+u5zSSQdFwDAq5docnxDDV4SrnXPC8JaziUt63S5OZeaPGfaF1Lco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyH1OsnN; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyH1OsnN"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86feb848764so2405729241.0
        for <git@vger.kernel.org>; Tue, 01 Apr 2025 02:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743501062; x=1744105862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W12wylHtoG2hPHz7T0P4A2uQhB6WTBR4gLVBs9irxQQ=;
        b=XyH1OsnN08qWP6w3Tu6RQWqSek5pzHnsdEIwKTefPqjzcsxVkaYPHWb8HRE67eYYDe
         9SO6RhcFBujWAyOWln+ICHKy9Ac1usnytkiC6ixOASnmxfuibjUoIrX9ZddazM8Z43gR
         4+qA7yngB0ytYSbZTLE4llMhsyQpAyWdpLiNXFlYNvi4+S4ps9V1pBMGpM2PcY88m9F9
         YMLj6e3IgsRkaYkcA0rfhPlOHJ53Vumv2lgMl3vMpj0HV2lzJ4JPZY8xDNvwFACPVDvl
         P0z590qpUeKbxAmRinUI/thEvm4YY8m2VlorSSc+GBbrm9HVV/AFLWJMNWCsjRqdpsG9
         hmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743501062; x=1744105862;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W12wylHtoG2hPHz7T0P4A2uQhB6WTBR4gLVBs9irxQQ=;
        b=NpfbbJr9RteXHxFdyBvS2fVhLbHsTfZdjEXyi+qFmkFP+ZnyTGwIa8BJSXO8fJMUP1
         KsifrXVJ4MHlP8u6lnjoP6D+h2juKCEBQnb+LF2kaHE3hl0DbdCfvSHV7n1CYxkPSpWX
         tqY21gU+C20YIvcQd+75iDNrhQZhRgJHs7XnUk8IlEnMacIG6n6+F8l/QAJtXVl9kNLb
         1yw2jBhIrCikRCqRtH3xKtun5YZC7BaY6bXVMqAZOTs3iFiJzMLvGe3CqSSnNr3turrx
         kJSaoedx4ZfDcNFNBcrO5qFHQaxlS8bc7M20xAr27Mlp1gHUBm4nRgtj/KL1f7U+1+vL
         X50Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEkj7lW068Dx4KMkZ5YEedK1Itvc0WGvULizbkrIJxhtxRhvHHAjusD40n0tPN6pXxYJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18S0C099UiqbtTq+9bJWQ7K45EQ/zQKGAAv1OtskwW37Pk2kw
	pFixgDUObkBFkCEbGiieUVWPbqYEhsD5Ty0csbKGxLzC0HG2VnXr0CCDGhei/6QzHUk/0j7p2sR
	UPIZh/nOMVUCUZGXiXLGyp3f/pUHcdUBP
X-Gm-Gg: ASbGncu9cqPwM6yryu1EJFhH6ySmA0cPgCPnFj2bkGmkOUvZK48fS4enVyJK1QQg6F7
	2sgSB9d0Xo6ZvPGPDycSc4avSRrjutMahHXxDqVPDesejYiiqTNEeAngaQXME+De3lfaVawITG4
	mDHwcsA+UFCOS8Xk/RLWtFlVqg2cNql1JVCCRncPJbYQZO7kiNol7asi1iO3EtVCXGCH7R7g==
X-Google-Smtp-Source: AGHT+IGCEzJZH03plPVy6C2MqCzBHFU/ASUCXZi3fO6jsUVqn/AfVto68DTIUlg1UGw3m7QaOxtFBHjvb5J7xETMGLI=
X-Received: by 2002:a05:6102:2d0b:b0:4c4:dead:59ab with SMTP id
 ada2fe7eead31-4c6d37fedbamr7360399137.5.1743501062389; Tue, 01 Apr 2025
 02:51:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Apr 2025 02:51:01 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250327-pks-cat-file-object-type-filter-v2-1-4bbc7085d7c5@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
 <20250327-pks-cat-file-object-type-filter-v2-1-4bbc7085d7c5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 1 Apr 2025 02:51:01 -0700
X-Gm-Features: AQ5f1JoUt2-6yb4Nj3OqwyJqc9vjvfcrxcjfkz4kv4HFE94s2GFlD2rrR-rE14Y
Message-ID: <CAOLa=ZTukdPiciDSyH1oGwYN_bdCw+vYjsHaV9AwHEpxJ5hBgQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] builtin/cat-file: rename variable that tracks usage
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000007d7ee80631b4799d"

--0000000000007d7ee80631b4799d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The usage strings for git-cat-file(1) that we pass to `parse_options()`
> and `usage_msg_optf()` are stored in a variable called `usage`. This
> variable shadows the declaration of `usage()`, which we'll want to use
> in a subsequent commit.
>
> Rename the variable to `builtin_catfile_usage`, which is in line with
> how the variable is typically called in other builtins.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/cat-file.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index b13561cf73b..8e40016dd24 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -941,7 +941,7 @@ int cmd_cat_file(int argc,
>  	int input_nul_terminated = 0;
>  	int nul_terminated = 0;
>
> -	const char * const usage[] = {
> +	const char * const builtin_catfile_usage[] = {

Nit: Style: we use a right pointer alignment, while it is not part of
your code change, would be nice to fix.

>  		N_("git cat-file <type> <object>"),
>  		N_("git cat-file (-e | -p) <object>"),
>  		N_("git cat-file (-t | -s) [--allow-unknown-type] <object>"),
> @@ -1007,7 +1007,7 @@ int cmd_cat_file(int argc,
>
>  	batch.buffer_output = -1;
>
> -	argc = parse_options(argc, argv, prefix, options, usage, 0);
> +	argc = parse_options(argc, argv, prefix, options, builtin_catfile_usage, 0);
>  	opt_cw = (opt == 'c' || opt == 'w');
>  	opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
>
> @@ -1021,7 +1021,7 @@ int cmd_cat_file(int argc,
>  	/* Option compatibility */
>  	if (force_path && !opt_cw)
>  		usage_msg_optf(_("'%s=<%s>' needs '%s' or '%s'"),
> -			       usage, options,
> +			       builtin_catfile_usage, options,
>  			       "--path", _("path|tree-ish"), "--filters",
>  			       "--textconv");
>
> @@ -1029,19 +1029,19 @@ int cmd_cat_file(int argc,
>  	if (batch.enabled)
>  		;
>  	else if (batch.follow_symlinks)
> -		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
> +		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage, options,
>  			       "--follow-symlinks");
>  	else if (batch.buffer_output >= 0)
> -		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
> +		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage, options,
>  			       "--buffer");
>  	else if (batch.all_objects)
> -		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
> +		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage, options,
>  			       "--batch-all-objects");
>  	else if (input_nul_terminated)
> -		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
> +		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage, options,
>  			       "-z");
>  	else if (nul_terminated)
> -		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
> +		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage, options,
>  			       "-Z");
>
>  	batch.input_delim = batch.output_delim = '\n';
> @@ -1063,9 +1063,9 @@ int cmd_cat_file(int argc,
>  			batch.transform_mode = opt;
>  		else if (opt && opt != 'b')
>  			usage_msg_optf(_("'-%c' is incompatible with batch mode"),
> -				       usage, options, opt);
> +				       builtin_catfile_usage, options, opt);
>  		else if (argc)
> -			usage_msg_opt(_("batch modes take no arguments"), usage,
> +			usage_msg_opt(_("batch modes take no arguments"), builtin_catfile_usage,
>  				      options);
>
>  		return batch_objects(&batch);
> @@ -1074,22 +1074,22 @@ int cmd_cat_file(int argc,
>  	if (opt) {
>  		if (!argc && opt == 'c')
>  			usage_msg_optf(_("<rev> required with '%s'"),
> -				       usage, options, "--textconv");
> +				       builtin_catfile_usage, options, "--textconv");
>  		else if (!argc && opt == 'w')
>  			usage_msg_optf(_("<rev> required with '%s'"),
> -				       usage, options, "--filters");
> +				       builtin_catfile_usage, options, "--filters");
>  		else if (!argc && opt_epts)
>  			usage_msg_optf(_("<object> required with '-%c'"),
> -				       usage, options, opt);
> +				       builtin_catfile_usage, options, opt);
>  		else if (argc == 1)
>  			obj_name = argv[0];
>  		else
> -			usage_msg_opt(_("too many arguments"), usage, options);
> +			usage_msg_opt(_("too many arguments"), builtin_catfile_usage, options);
>  	} else if (!argc) {
> -		usage_with_options(usage, options);
> +		usage_with_options(builtin_catfile_usage, options);
>  	} else if (argc != 2) {
>  		usage_msg_optf(_("only two arguments allowed in <type> <object> mode, not %d"),
> -			      usage, options, argc);
> +			      builtin_catfile_usage, options, argc);
>  	} else if (argc) {
>  		exp_type = argv[0];
>  		obj_name = argv[1];
>
> --
> 2.49.0.472.ge94155a9ec.dirty

Nit: Some of these lines could potentially be wrapped. But I think are
wrapping rules are a bit too strict. So I'd let it be as is.

The changes look good.

--0000000000007d7ee80631b4799d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e75bb59e4e41d4ad_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mcnR3TVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHUxQy85N0ppNE5vSmV5NE4wK0VpMmJVZEtTNDJFdApXODlPa2FzZzZz
cmVzUEhweldoekd6V3gwMkhkQ1FYaDI5Q2VZNTNET24wT0RFdmYrWHhqbkx3SEN4ZllCZFBwCnZr
NTR6VnR6R0ZSa1FDdmhlMXFMQlNianU1WlZlYnNBU2MwMDhxdlg4SXFGTmlhL3RrdGtSeitHaFF6
RG0rcUsKM2E5OHhKUWZBbXZYMm9hdjdvOTBhM0M3TEtrVnVCdHJCUXE2a2V5Z2VzSlJLRVBLMkd6
SEpIc09uWnJEU3NjdQo3N256R0I5cW1pOWdmcmhJUURDZWgyZFl5M1F5S0VsUlc1TTB0OEFxb0Jw
bGxJeVFBQ1RQak53UEhqQkdyMkt6CnNIQ1I1Nk1tK1RONjkyNWFSSFZnZWtLMWN0cUVFakZNZXpD
c3g3S3pDNnY2enpxSmJEYytSemJMQlkwOWpCbysKMy9Sbi92OHlRckhlaERYM0RJbXRPS3FzSEFD
NmwrV2FaL0I1VTd2OExQRFJEU21xNEQ2NlJMcWdHTTJ5czNjSwprSndCck5lUjRkaXB4enJ6bnU1
aEs3QVNZcmNHWkE2NFNFQjc1bm8zSkVFb3c2ekVlVFJmOWZkajl1V1l4QklaCjk2WGRlZlVxelp3
MkNhRnBPOXB5VHlEL0Y0KzhyQjZ2UmVreThDTT0KPWhRQncKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007d7ee80631b4799d--
