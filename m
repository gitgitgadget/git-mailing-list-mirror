Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658722CCC0
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750956062; cv=none; b=s6G89Y/wY/lYT0yGMRO03FbFg6cL2TCbEX2Cjgj69ebtTfK+57J4CfEzu+23pVHaWSZTDidD54qwvDlLIxrVutGrfxAoIb4VdEAVop083zH+Encdkcd1FuOb3rqDlimuxAuaUrBh2tqXrdmP0Cv4ny7gdwcbDtz9kDekXJNYxuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750956062; c=relaxed/simple;
	bh=3rUPIQPQ6X3gggyaWh2iDsflbdw5aSn0ck4NhNS2QFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCSmVA6/hNYdjlPB7oSDnmWJlETa5Hhy9YJAzYXCniw4ZtGu5k7lAsZ4EtLAgthHk8oxdw7N9+7abuZFkzrRyatuD+VhX7BgEG2tbOOwn/5jCmy/U7I9jY34VNDs3I/r3e0S7udAS1fm3y8hf+rbOprAPs2Sc4inTqDBMiHtzTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZpuvEDQ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZpuvEDQ"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-735b9d558f9so320791a34.2
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750956060; x=1751560860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iBav5TcVKY+VvjaldD7SnQ3/dhR2KkMyj9aZGVE0AVI=;
        b=dZpuvEDQ2NRuLrPCktQsVCz8/RW1Kfwe310/tgf3/Fea9eA2VJGVPDp8FdYoCeRI4k
         xZQ+JLXimndJR1P/o8tKKF3WPqFRE0ebbajYyoe31nI57pFAGu5Hl+D8ZdyiWEm2YS2l
         SNQgp7I/vH6yXMU5leWgi3h3jlF1uJCG9b+uwACSdsiPPLbpaN5nPwVJzIgZOT3u/Bx1
         KN/160s15QA7cVkyYlS8sD3iR+4DsqBXH7WupVYZwQYXEd2dda7dyKCiQ/FF6YlF3v59
         vXwrM5e2vV/rdTKdkCnkPMfhIu5ZfLg5t5vQ5v6TYaT+9/v83QNm0du5VJSlk0r7KK3r
         VZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750956060; x=1751560860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBav5TcVKY+VvjaldD7SnQ3/dhR2KkMyj9aZGVE0AVI=;
        b=I28kzr/U07osmKNsM9vnw6WXb4asWtBqx4t4eIysXjU50q1hJ39O8d8OBchqyRC9/2
         JY1LkwviPBPM+rszzIladC+UCHji8wOnPtSOY06TRgCGeZ44QTyY+Ts5dAcu9kQymiq0
         AlOTJC4ZRzDkrcADuqd9h/WW2IN9dUru+3AtKtD2hzqwVdZYoJ1gC5UUSe1GmNI6YFsI
         //7EIZouBiUWHz5L9yc8VT0MpfuYms6K8JtrS/XgoFCtRbjQtbUNJxXldN+witIj21yR
         2C8sSkR/B+V440cGwymHXUlRsJBULWxGkBmgZkpqQCDgH1v+I0XzXfUAdKQ1tSp4sEFJ
         MSiA==
X-Gm-Message-State: AOJu0YwQAGM8vRshqmftGrn1BbqshXqWorUIpgRoprmRUb2UwnmorjLl
	MXb2UClWcMqnhGwXasoatm0eM2T8KPQhoOV1xscG1OvUAOpJ1J6uEu6S
X-Gm-Gg: ASbGncvvsql9jUXClb+sl1jYTw9B2ix4a9txctp5+hXKfOw/SaMAqAv4/vqPCBYKC7A
	ixTisCqJ+guQlu3UYckYthm3hyUisw1obIc8WW+5OMWzyQVVRYMAQaPcv77CjReDu+LgZ1a1hRC
	b/Mba282eKIuZBUsOmDFTSDwaFxuWtFqJH5pzTtGclvy7DM4aPKwk9+sGDCyGMTPFFpJMZDpEZb
	WJeAijx1XdbPHQFdevXZfgYGHrmYxunPuWX0RAfX74ik00VHsaUm42CbpqnyfbegNuL5aWomrSO
	lYoPDfXigv+ue2hwDwf1fwsebUNnzuKw96L3z2r7IdqItc/Fsl+i0bY=
X-Google-Smtp-Source: AGHT+IFyArDglBHQc1zSvjjBYMgowVl9RT5FUJhknHl2eU/EYjDX8sLvR4d2g/L4bBwCCWYx4dL43Q==
X-Received: by 2002:a05:6830:6c12:b0:735:51b9:4688 with SMTP id 46e09a7af769-73afaca28e2mr440167a34.19.1750956060304;
        Thu, 26 Jun 2025 09:41:00 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73afb122b39sm35619a34.64.2025.06.26.09.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 09:40:59 -0700 (PDT)
Date: Thu, 26 Jun 2025 11:35:37 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/4] meson: add rule to run 'git clang-format'
Message-ID: <iutm4xxkhchcpfygtqo2s4nit42sclzen63465ljtovzgdsebr@okpj5jtw62r6>
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
 <20250625-525-make-clang-format-more-robust-v1-4-67a49ecc2fd5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-525-make-clang-format-more-robust-v1-4-67a49ecc2fd5@gmail.com>

On 25/06/25 06:43PM, Karthik Nayak wrote:
> The Makefile has a 'style' rule to run 'git clang-format'. While Meson
> intrinsically supports a 'clang-format' target, which can be run when
> using the ninja backend by running 'ninja clang-format', this runs the
> formatting on all existing files.
> 
> Our Meson build doesn't yet support a way to run 'git clang-format',
> which runs the formatter between the working directory and commit
> provided. Add a new 'style' target to Meson to mimic the target in the
> Makefile.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  meson.build | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 7fea4a34d6..578db26df2 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2144,6 +2144,18 @@ if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
>    alias_target('check-headers', hdr_check)
>  endif
>  
> +clang_format = find_program('clang-format', required: false)

Should we be checking for `git-clang-format` instead?

> +if clang_format.found()
> +  run_target('style',
> +    command: [
> +      'git', 'clang-format',
> +      '--style', 'file',
> +      '--diff',
> +      '--extensions', 'c,h'
> +    ]
> +  )
> +endif
> +
>  foreach key, value : {
>    'DIFF': diff.full_path(),
>    'GIT_SOURCE_DIR': meson.project_source_root(),
> 
> -- 
> 2.49.0
> 
> 
