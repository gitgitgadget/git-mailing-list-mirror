Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FF917579
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443733; cv=none; b=lzyJBEEeLIPZAyJqbd/ED98gm9C1jWu1CM4GsRt1SHqAKwY5iyZWqtRvBZUWUr+1frz0Le1no4BMxIODO6zjzFwq06rtsjGw3t1funKcm1YF6xBkbhemhWam6acGW3O1g05zhM9GNyTuRrO6emLAY+mFnBUxrimZ4EtXqqA1NI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443733; c=relaxed/simple;
	bh=urBErKvEoiFPjSjdO+7/R2lL/c49KWf/ZzjyD4ja6+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G++ViMo0RKhhNfj0CEGVAaGfHKX6jXc2YBRJIVsiVlvhh9voXr7Gr3WBZtfzDk/uo4meYW2Z8WgUW4oJ8SLIAZzAR0FETJKLPXsPYe4pvHVwp3PRHTnU5aQAd6/CDgMe3YDe0DpSqpEvWNfpXM/ENOi6rhBF90GY2BNCH2Z65Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BxTHX43L; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BxTHX43L"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b7a3773a95so33632976d6.2
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 09:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722443731; x=1723048531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKW5s04kave8kz36D3Xv3fnZkio2l1zSrXZlhehu8Nc=;
        b=BxTHX43LkCt5D28Tmujf2Ze5pABhl5kehp+gcwEj4LjsXu/Mw35U2rDPB5FIDbubTd
         AKOjLx9mPe62otRzddQzBYfZLZlY5SGQefMCqxbm2h6gqrU1GuyovdAHdA4b3fwCxT84
         IIm8F7J1GmXsT2SCb8YlXJLLc70N+TLAo3fZKtNqmXhi4pxnWpzxPtFkcX8U0vUvXc/J
         dk9Jz1PgXu3+F3FDKfn9f4TgtxGu+u94C/oozb0fViWnYwlvQosreXFCYtplk0VJ4xRD
         mkiDhEzLyDXxDcpo2+Nx9zv0DRfjI/Ul/j3RQibEHb6O6mfPk8NK5rc5xQ7VMWBYVoVu
         Ajrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722443731; x=1723048531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKW5s04kave8kz36D3Xv3fnZkio2l1zSrXZlhehu8Nc=;
        b=WeQyVRgqsAicQuAsy1HzSamVE2iLwcSoyIYA9/BCfGt+YRtRg0hAGLPxVyqvY2cQvG
         +zInlP71Za/Uj9Gvk6PJNBHDqXDbkKp4o/3vGp8Y0t9E+Q86fOiKOBalIVdKXNfccFRa
         QaMrWJGRb8e8GCYFqBOo9CHHHSHT9lQ6Yg1bmKZzfZBjxfgMS7PYqZEcZjpzUdNEZsGn
         kOOGhI47Pp+rjhylWMgxzM70OpOB9V3O/GyTto5NZn9+KfGUkVxtyuOH4kBHL6utMT3K
         6xWoaWNUm+avlLHxxmVxcq/2+3b3WM0mrdyAH6yCvHffOnGMSFt62KYiCdZWR59O7OY9
         CRQg==
X-Gm-Message-State: AOJu0YyKsLw6y7f/NEW06vcQsiGILeYlGNpgEyBjHqyWY7Y9y7/DVjkX
	Ud63cIGJpKqtNJBZWfcasbSI6Udy0hdufAIhtcC7DW0fSaf80zh8YJjg7Q8vqXsdy1Hl5zgv63W
	b
X-Google-Smtp-Source: AGHT+IEiK7uxmcp+cryU9jajD80oSRCSlan9B/jbH39OuzNOqvEvVXRyNVGSHuove0jnbLNQdbYXoQ==
X-Received: by 2002:a05:6214:2246:b0:6b7:a3f3:8b68 with SMTP id 6a1803df08f44-6bb55a4ba8amr224775506d6.31.1722443730985;
        Wed, 31 Jul 2024 09:35:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d828bsm75345946d6.24.2024.07.31.09.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:35:30 -0700 (PDT)
Date: Wed, 31 Jul 2024 12:35:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/23] builtin/ls-remote: fix leaking `pattern` strings
Message-ID: <Zqpn0bLD+aLgY9PN@nand.local>
References: <cover.1721995576.git.ps@pks.im>
 <d42152654bf91e90b8b417316f255746a3a75155.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d42152654bf91e90b8b417316f255746a3a75155.1721995576.git.ps@pks.im>

On Fri, Jul 26, 2024 at 02:15:24PM +0200, Patrick Steinhardt wrote:
> Users can pass patterns to git-ls-remote(1), which allows them to filter
> the list of printed references. We assemble those patterns into an array
> and prefix them with "*/", but never free either the array nor the
> allocated strings.
>
> Fix those leaks.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/ls-remote.c          | 11 +++++++----
>  t/t5535-fetch-push-symref.sh |  1 +
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index debf2d4f88..500f76fe4c 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -47,7 +47,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  	int status = 0;
>  	int show_symref_target = 0;
>  	const char *uploadpack = NULL;
> -	const char **pattern = NULL;
> +	char **pattern = NULL;
>  	struct transport_ls_refs_options transport_options =
>  		TRANSPORT_LS_REFS_OPTIONS_INIT;
>  	int i;
> @@ -96,9 +96,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  	if (argc > 1) {
>  		int i;
>  		CALLOC_ARRAY(pattern, argc);
> -		for (i = 1; i < argc; i++) {
> +		for (i = 1; i < argc; i++)
>  			pattern[i - 1] = xstrfmt("*/%s", argv[i]);
> -		}

Instead of xstrfmt()-ing these strings directly, it may be more
ergonomic to use a strvec here and call strvec_pushf(). That would save
you explicitly CALLOC'ing the array, and would also save you the
explicit free() on each element of pattern below.

>  	}
>
>  	if (flags & REF_TAGS)
> @@ -136,7 +135,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  		struct ref_array_item *item;
>  		if (!check_ref_type(ref, flags))
>  			continue;
> -		if (!tail_match(pattern, ref->name))
> +		if (!tail_match((const char **) pattern, ref->name))

You could also drop the const cast here as well. The resulting patch on
top of this one simplifies things a bit:

--- 8< ---
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 500f76fe4c..b59ac98d81 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -47,7 +47,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	int status = 0;
 	int show_symref_target = 0;
 	const char *uploadpack = NULL;
-	char **pattern = NULL;
+	struct strvec pattern = STRVEC_INIT;
 	struct transport_ls_refs_options transport_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
 	int i;
@@ -93,12 +93,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)

 	packet_trace_identity("ls-remote");

-	if (argc > 1) {
-		int i;
-		CALLOC_ARRAY(pattern, argc);
-		for (i = 1; i < argc; i++)
-			pattern[i - 1] = xstrfmt("*/%s", argv[i]);
-	}
+	for (int i = 1; i < argc; i++)
+		strvec_pushf(&pattern, "*/%s", argv[i]);

 	if (flags & REF_TAGS)
 		strvec_push(&transport_options.ref_prefixes, "refs/tags/");
@@ -135,7 +131,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		struct ref_array_item *item;
 		if (!check_ref_type(ref, flags))
 			continue;
-		if (!tail_match((const char **) pattern, ref->name))
+		if (!tail_match(pattern.v, ref->name))
 			continue;
 		item = ref_array_push(&ref_array, ref->name, &ref->old_oid);
 		item->symref = xstrdup_or_null(ref->symref);
@@ -158,8 +154,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		status = 1;
 	transport_ls_refs_options_release(&transport_options);

-	for (i = 1; i < argc; i++)
-		free(pattern[i - 1]);
-	free(pattern);
+	strvec_clear(&pattern);
 	return status;
 }
--- >8 ---

Thanks,
Taylor
