Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332EF19BBE
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lbUD/DJc"
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F70DB
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 11:37:17 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7789cb322deso343020785a.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 11:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698691036; x=1699295836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hFW/GEtskfav+Tymy97QFhtJG8WwYhQFZ8pWK4mu+F8=;
        b=lbUD/DJcCrn/rXvxDlwu2l6WuCRSFCc8X2TASO9od+XNjIQ/rcgMZXETvSWRowAIXb
         TtzdgD4+kXCnn1ekQQkmA0PgOVDF/jLaXXgadPCr9hqEzOdQlLFBB8bm5+1hP1EmPDCk
         zeGTLeq3AQmWrdSe+X3PY9LqUWU9J76dHQEHvEAXjn5vDer6HBGYpdXpxAbiyMn8Lgbm
         LCRcXyiq6UiwdB783NWwoXqc/PEyywRZbwmPAdMnWkZj0f8zwpL4wIjkKjrFC3/lGVrx
         55me9Rh0k+sQ3+gwlgzvvliC7rBlSdCgawik7Kc+JDV5KwYBqCXLjlHWH+q8f+AThtFj
         WmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698691036; x=1699295836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFW/GEtskfav+Tymy97QFhtJG8WwYhQFZ8pWK4mu+F8=;
        b=vL6V1hM7rv+TeuR2TDhUtlA0RVA1qI7mgadHRQiLHIpLJM/B9qwIUE+MyYn7eySw/S
         SJMFO+4GRkmeUs60Dy+dS0wnFYSJJNoLmBcnQxTrnGx9ObysZRY4+iJgs+E2Cao5kdKz
         ZE709DMRWfG/vFp5YwrNBQI9vAnuEezqwdaxDy5jVscA9u5ssTix79HtYZnPfEfXvRQf
         eOdpYiZbF3VxF5fyJVI6GJi786lofGAGp4TCziVSS6dG6UF8H4yxsczT/cwGbTKy81T1
         dipTruDdJjfEMCA3AeCl2qpTrdQbUMAc6KNVTUvEgprNpvVvfr4YYFO8ncmewJIBdgVc
         z6mw==
X-Gm-Message-State: AOJu0Yzmo3Quqyj2o0KGP0/PLj0x7ezoE173s6lhyNkSJZBXCSGy5Jp+
	Lg1a4TSOhOV6X9ulorbWfWH+FA==
X-Google-Smtp-Source: AGHT+IERDMQkb6PZgpFt3gpxkBV12CpcaPI59+/gBH12cPE9xYVU8ljvR+qe2VMSbeX4mQzKj6A55A==
X-Received: by 2002:a05:620a:8111:b0:774:f7b:f0a with SMTP id os17-20020a05620a811100b007740f7b0f0amr10354554qkn.76.1698691035755;
        Mon, 30 Oct 2023 11:37:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a14a400b00775bb02893esm3541286qkj.96.2023.10.30.11.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:37:15 -0700 (PDT)
Date: Mon, 30 Oct 2023 14:37:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 05/12] builtin/show-ref: refactor `--exclude-existing`
 options
Message-ID: <ZT/32jI62GQKPlcp@nand.local>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
 <bed2a8a07696371e07c0b2d1282ed51c0b1b9fee.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bed2a8a07696371e07c0b2d1282ed51c0b1b9fee.1698314128.git.ps@pks.im>

On Thu, Oct 26, 2023 at 11:56:37AM +0200, Patrick Steinhardt wrote:
> It's not immediately obvious options which options are applicable to
> what subcommand in git-show-ref(1) because all options exist as global
> state. This can easily cause confusion for the reader.
>
> Refactor options for the `--exclude-existing` subcommand to be contained
> in a separate structure. This structure is stored on the stack and
> passed down as required. Consequently, it clearly delimits the scope of
> those options and requires the reader to worry less about global state.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

All makes sense, but...

> @@ -19,8 +19,7 @@ static const char * const show_ref_usage[] = {
>  };
>
>  static int deref_tags, show_head, tags_only, heads_only, found_match, verify,
> -	   quiet, hash_only, abbrev, exclude_arg;
> -static const char *exclude_existing_arg;
> +	   quiet, hash_only, abbrev;
>
>  static void show_one(const char *refname, const struct object_id *oid)
>  {
> @@ -95,6 +94,11 @@ static int add_existing(const char *refname,
>  	return 0;
>  }
>
> +struct exclude_existing_options {
> +	int enabled;

...do we need an .enabled here? I think checking whether or not .pattern
is NULL is sufficient, but perhaps there is another use of .enabled
later on in the series...

Thanks,
Taylor
