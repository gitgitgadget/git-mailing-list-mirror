Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7781379EFC
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463399; cv=none; b=L3S/WUxb+fEfpVK44o7V38jEW3kTYodXaRh+OvbT8Y+Nr0/faUlNi5cGotTarW2XlgdKnSZib5SrNFqdsMclqkuL66ETjwzRbkPPM++xYAnw8P6VeyVqk2jxKarZi4DA1xT6efewYO4Pzey3Sg+dikNNhAOr80Vapr9zn4HVapY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463399; c=relaxed/simple;
	bh=ZGsiMQeGWG6B+AWBLstN0vqs13peKL2HnOlhJqicmos=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aj2LThO3SpuPJ5nKoFdUmfqrScrmtlubF8EEV2RZfd1njy3T3fsghgh3euZ8blJHgv9ccWZFdPmYISvjTdGJt1DpZPVY4E5ZrFaI+uIxLqJWdHggNVYACcyWRl/rZX+6YNR1hQPSzd+CTfpFPiMPZj4jjNC0EWRqxpNS1YJbJcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETLnHGoR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETLnHGoR"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so752276f8f.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 06:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772463396; x=1773068196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=baRUV1ncOYgA3qBeQjb9KQo0SkJDLFM9yUBRWCfD2QQ=;
        b=ETLnHGoR4Ry2RF/+jrhbHb4cFJFY4g6uE0YXYkQrKmN313flFIdnXQkVr5idMRKbgb
         S0Wp663SwXqG10wWyrPkIMjJZdLazgjEs+nCQi2pkxmWiwui/nzqlr+JCS/5kM0qyo36
         UZO9g/sl5LP4KnCZMSNQwg6CVwvgFdU1uegm3CqHGJiDDIJ9l8aHhWbvbzNpPSTXTAOK
         riaeh3KaVGV54TtVE0CkRd8qdhq2OWlv36cFUm89PlOopqELfXQCfeyoRKaS6t+V09hu
         NT/EbUGn1zXbxmAAqvH4Tb1g0A4scZcIvANEANhmS2EtKXGt33vL9NYgYiNjPJMvJ8rt
         lDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772463396; x=1773068196;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=baRUV1ncOYgA3qBeQjb9KQo0SkJDLFM9yUBRWCfD2QQ=;
        b=KDGTvCQ8eWx4d1qwAOhmrmw4nBQpORx1WV5gO1gr5r+zY+g7GjyJYnVZ0KJUSbffqd
         jjTtypClN7xnSccHOYnRgKOKsLoxmXqKosjjUkan+hqMvzNWlxxNhpCDVrtfxQ4FEv/f
         lMFjCY0NMMRScm7mkjPLhnwaIhubYaOfr2BtNnlISSlYvc7/RMXRR3oI63Yr3+AcqwK9
         x3u04/ojnDPUwOrAUevXTBGdPBdefxbfF9yaA8lXsHcutQPK1F7hTAJkYEFHmvFVcxdO
         NYMiMWmZXG3fvr6KQ+XVBmdneW3M0BoYoGFzFdjvFbwVcs2pUULR/K3nLGUL4WUsqfaZ
         oR7g==
X-Forwarded-Encrypted: i=1; AJvYcCWwLTurtOC99emwwgr1eFwYsowSElZlHEMsFBrZ6XE87EDCL3Y1hqMKtjUflTeXfzjAoJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynN3mK3ZTsnEnbwmzY76JbkuUJ30l1bGy2ar3LXhZwmHTKFkkz
	nmp7wW57LtZlJPGOiTtw7lGKA3pUJHSf76qsy1iPDa/4+GGRmXU0IVm0
X-Gm-Gg: ATEYQzxE0PPjiKx1nR45U7LNzRI0r9d9JGiPVxvMImCdjbzzJwAihTkGfzmX4E1Kqu6
	bYYpZyH7/WpyOtbtCGd076jJPlGdhYfqdfg+TMZk25CLsetZyI2h5dQ8coz4R0V1C/jtcv9rHyG
	1r/+HKhOwTdbHCB4aPKk6ID95V27euHoHLRTl5IAPTzmx+KJs9Xov3IcOFmoJdGIbWHn5LCjAG8
	bOwZGdshd4l+Zlxqnh9RAYpHSg6lwjtyEZDA1PilE1ZHiClxKfB3rKtCW/H0GmRU26j7wsdoZHY
	5Htl+2n1+1LJopQVT5qaKTbPFpO+z1w+AMxXYRitdl3jFOYORz5Mrxi5Qim0OajXH72Lu+gqoIB
	sfK8k9rD0tVumBQgi1v9eSOv0U8GeRPuT7FMEyRmWZW+wlwgoyuCCENfZlpmbgKx2WsAMcm1/5K
	kGUHErptwk6SqYHoRbfPuwIVrUM2kuPv/2tETJG9igTinWIN/BfHuHJ27IRnqRq1ugxot8mtuZ9
	PVsOQ==
X-Received: by 2002:a05:6000:40c8:b0:439:b7c9:2edc with SMTP id ffacd0b85a97d-439b7c93174mr5798688f8f.48.1772463395941;
        Mon, 02 Mar 2026 06:56:35 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ab6ebe56sm16783048f8f.15.2026.03.02.06.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 06:56:35 -0800 (PST)
Message-ID: <dffc34a6-3a89-4535-9caf-95625a221797@gmail.com>
Date: Mon, 2 Mar 2026 14:56:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 4/5] commit, tag: parse --trailer with OPT_STRVEC
To: Li Chen <me@linux.beauty>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20260224070552.148591-1-me@linux.beauty>
 <20260224070552.148591-5-me@linux.beauty>
Content-Language: en-US
In-Reply-To: <20260224070552.148591-5-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Li

On 24/02/2026 07:05, Li Chen wrote:
> Now that amend_file_with_trailers() expects raw trailer lines, do not
> store argv-style "--trailer=<trailer>" strings in git commit and git
> tag.
> 
> Parse --trailer using OPT_STRVEC so trailer_args contains only the
> trailer value, and drop the temporary prefix stripping in
> amend_file_with_trailers().

This looks good. I'll stop here for today and look at the last patch 
tomorrow

Thanks

Phillip

> Signed-off-by: Li Chen <me@linux.beauty>
> ---
> v7:
> New patch.
> 
>   builtin/commit.c |  3 ++-
>   builtin/tag.c    |  4 ++--
>   trailer.c        | 21 +--------------------
>   trailer.h        |  4 ++--
>   4 files changed, 7 insertions(+), 25 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 9e3a09d532..d9983230de 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1720,7 +1720,8 @@ int cmd_commit(int argc,
>   		OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]commit"), N_("use autosquash formatted message to fixup or amend/reword specified commit")),
>   		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
>   		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
> -		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG),
> +		OPT_STRVEC(0, "trailer", &trailer_args, N_("trailer"),
> +			   N_("add custom trailer(s)")),
>   		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
>   		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
>   		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
> diff --git a/builtin/tag.c b/builtin/tag.c
> index aeb04c487f..15aee1b03a 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -499,8 +499,8 @@ int cmd_tag(int argc,
>   		OPT_CALLBACK_F('m', "message", &msg, N_("message"),
>   			       N_("tag message"), PARSE_OPT_NONEG, parse_msg_arg),
>   		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
> -		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"),
> -				  N_("add custom trailer(s)"), PARSE_OPT_NONEG),
> +		OPT_STRVEC(0, "trailer", &trailer_args, N_("trailer"),
> +			   N_("add custom trailer(s)")),
>   		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
>   		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
>   		OPT_CLEANUP(&cleanup_arg),
> diff --git a/trailer.c b/trailer.c
> index 8e87d185d9..e85c6c9fbe 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1342,40 +1342,21 @@ int amend_file_with_trailers(const char *path,
>   			     const struct strvec *trailer_args)
>   {
>   	struct strbuf buf = STRBUF_INIT;
> -	struct strvec stripped_trailer_args = STRVEC_INIT;
>   	int ret = 0;
> -	size_t i;
>   
>   	if (!trailer_args)
>   		BUG("amend_file_with_trailers called with NULL trailer_args");
>   	if (!trailer_args->nr)
>   		return 0;
>   
> -	for (i = 0; i < trailer_args->nr; i++) {
> -		const char *txt = trailer_args->v[i];
> -
> -		/*
> -		 * Historically amend_file_with_trailers() passed its arguments
> -		 * to "git interpret-trailers", which expected argv entries in
> -		 * "--trailer=<trailer>" form. Continue to accept those for
> -		 * existing callers, but pass only the value portion to the
> -		 * in-process implementation.
> -		 */
> -		skip_prefix(txt, "--trailer=", &txt);
> -		if (!*txt)
> -			die(_("empty --trailer argument"));
> -		strvec_push(&stripped_trailer_args, txt);
> -	}
> -
>   	if (strbuf_read_file(&buf, path, 0) < 0)
>   		ret = error_errno(_("could not read '%s'"), path);
>   	else
> -		amend_strbuf_with_trailers(&buf, &stripped_trailer_args);
> +		amend_strbuf_with_trailers(&buf, trailer_args);
>   
>   	if (!ret)
>   		ret = write_file_in_place(path, &buf);
>   
> -	strvec_clear(&stripped_trailer_args);
>   	strbuf_release(&buf);
>   	return ret;
>   }
> diff --git a/trailer.h b/trailer.h
> index d05dab050b..e5bd355aad 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -209,8 +209,8 @@ void amend_strbuf_with_trailers(struct strbuf *buf,
>   /*
>    * Augment a file by appending trailers specified in trailer_args.
>    *
> - * Each element of trailer_args should be an argv-style --trailer=<trailer>
> - * option (i.e., including the --trailer= prefix).
> + * Each element of trailer_args should be in the same format as the value
> + * accepted by --trailer=<trailer> (i.e., without the --trailer= prefix).
>    *
>    * Returns 0 on success or a non-zero error code on failure.
>    */

