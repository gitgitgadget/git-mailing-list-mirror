Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05F3C0C
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757528160; cv=none; b=q0shRkloDSJ9cUZPYWry2ot8LWhPVWbml72bANANX5ZtAYKz46e0fzaz3RejRKRtchn8gO2QSGUmLP1pnzKgxxhJAb/IO+vowIx+ZMV6j1IWZzjyXoOxjPqkBMQRL/Qc9yUrc4H6Ddp8lK76ISgkK0d6C2mUwb+vuG55ESLydSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757528160; c=relaxed/simple;
	bh=F10jbLmHBiz073m1Z3Yyg7CrOrCOGahH/kw+GrsORBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWf7sPV1QJRL1UIYsonRwMYJa87SZ/z/9CDGcDS1p1q8kgARby/P38KAzdgzoSCV9iLFst85dIXbtv5nKVlPgnYy+MbuyUC55tiZuz/Gv5LtPtxWDcCKzDAhF67zix6UMRzDqScti7OouESvJnn6jxowURbfEksULmqXWbcFgSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4H4c7/K; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4H4c7/K"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4c738ee2fbso5674190a12.3
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 11:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757528158; x=1758132958; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mKi2ZdCQSqTMV9fSOuTliY/0BRorG4zqTDz7qa4mTrM=;
        b=O4H4c7/KoA/QI1eRdxIDXuIKKBImB25qRv7OFxWKfn9XDQe+JUopqbhuhf+l5jfldU
         dCJ9ZDaN4pXdbwI4aJKy4E3DpjcuMWnZ6NuJh7tMkdXNECiP3Io40b8yAvF+pR5amdE8
         qiEQFGsa19pAbbnY47nZYkwUn9vomlkilYxibm+PE7up0DQ3Xie6+gREedGGnNQecYMV
         joJOKC8DBeCaEIP9rfLRIMp7gGOCdXgUg+HytLhVRQFphTGf9mtXzE//GhjfaXa0w2qw
         IB7Q9+UCWOExRXhEAX0gVOEHtr26cErQ/JUS46Lw+VY9Jp9k0eNrRi3RD+9mjRR/P5xQ
         8FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757528158; x=1758132958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKi2ZdCQSqTMV9fSOuTliY/0BRorG4zqTDz7qa4mTrM=;
        b=teNdF1WYKB3ogX7J2TKL6DxupIQ6iffb6XnAoPGKLOiUR/kMKg+qfSy8oNXl3L9xUz
         1J65CuGZaua3tPrMt6u6Xd5sDbsEDw6MLYrclXPROOfBUR5P/wDpeGEpFR998aKHi5Sa
         y5Yh2dN8ES+6o+dsf+anIQCw84vjIp7L4DSXn1z6cTaSd9+67oXAb+vPVKpMHqH/LinS
         vxI4ZahOmD86wozFOgEsQVtZWSFPhEO22O9ki8OQUw0QJhsWK9lFpxR+7bn3H0hPN78C
         TjeziR9VubcN06vTAjrzXXDq4Q7M0HFFTCkS83H50IvMkbP6qe2GEZzoBpFEKqLwsSwL
         RQCw==
X-Gm-Message-State: AOJu0YwSEDID1ZYXKfHNKyMFwO7f2kmR/mrYugTLYJw4pgg/Epj5PeZO
	5703Q7xJT77Q/k1Aurl5F5n5a38vGwQuUrFM5WAon6gTQ79z6b/tOuv+
X-Gm-Gg: ASbGnctWZJZf9/m77OPh82GUwDS5O4DeVyaSJmBuTPA5MUyJTKFktmva4C/mVaiM0H7
	axRGKGxUTeYP+DUxk8SX11QeN9pcqUfisfmGzTtJQpzUFQ7gHw6oR9b0UJP5A9zZo4xt1Xh6XWB
	1T/VEHy7rC04P2oydkqU4pMrem7Pd46uy2Ir45EJOIZFTm+DluJoBdN0gP3YaQkeBH5oMysmcJr
	2OUrsnLlC5Ls0wLLrqfTRdvdUpQn6AhnhdyfOmrwHIoBqBps3J1xaMKbgm9VzCAoictqwgTlvfm
	/M2FEnws+Y8OuCUnt0vMupU46eBzMJ50tdSQ4/x/38qu8Okr+PBrzDwiP0R4v/8cuwA2tlLV/d9
	Ir7A/zBKWfyBftvQ1V5w+Q0dodvlDdEa7eRr3S8hcbUNMUi1EGPmEV7YLT+0+6hF/wDm65SdHmh
	lgob4/N69apWqCnzw=
X-Google-Smtp-Source: AGHT+IE/8C6n5wYBlcsMhtnqT1nedf/D9AI5Tf1Tcaz+Ec2aQTRwrHV+yYEw8StYQ0aJLO5k/C/fWw==
X-Received: by 2002:a17:903:985:b0:249:2ba0:7f7f with SMTP id d9443c01a7336-2516ef5132cmr167278105ad.9.1757528157807;
        Wed, 10 Sep 2025 11:15:57 -0700 (PDT)
Received: from localhost (20014C4D24CD0A006665B6F100DB6694.dsl.pool.telekom.hu. [2001:4c4d:24cd:a00:6665:b6f1:db:6694])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2ab0d88asm33067555ad.111.2025.09.10.11.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 11:15:57 -0700 (PDT)
Date: Wed, 10 Sep 2025 20:15:40 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 06/10] submodule: encode gitdir paths to avoid
 conflicts
Message-ID: <aMHATMvn4Sdcz7mJ@szeder.dev>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-7-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908140117.262205-7-adrian.ratiu@collabora.com>

On Mon, Sep 08, 2025 at 05:01:13PM +0300, Adrian Ratiu wrote:
> diff --git a/submodule.c b/submodule.c
> index bf78636195..8e0fd077db 100644
> --- a/submodule.c
> +++ b/submodule.c

> @@ -2588,30 +2593,26 @@ int submodule_to_gitdir(struct repository *repo,
>  	return ret;
>  }
>  
> +static void strbuf_addstr_case_encode(struct strbuf *dst, const char *src)
> +{
> +	for (; *src; src++) {
> +		unsigned char c = *src;
> +		if (c >= 'A' && c <= 'Z') {
> +			strbuf_addch(dst, '_');
> +			strbuf_addch(dst, c - 'A' + 'a');
> +		} else {
> +			strbuf_addch(dst, c);
> +		}
> +	}
> +}
> +
>  void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
>  			      const char *submodule_name)
>  {
> -	/*
> -	 * NEEDSWORK: The current way of mapping a submodule's name to
> -	 * its location in .git/modules/ has problems with some naming
> -	 * schemes. For example, if a submodule is named "foo" and
> -	 * another is named "foo/bar" (whether present in the same
> -	 * superproject commit or not - the problem will arise if both
> -	 * superproject commits have been checked out at any point in
> -	 * time), or if two submodule names only have different cases in
> -	 * a case-insensitive filesystem.
> -	 *
> -	 * There are several solutions, including encoding the path in
> -	 * some way, introducing a submodule.<name>.gitdir config in
> -	 * .git/config (not .gitmodules) that allows overriding what the
> -	 * gitdir of a submodule would be (and teach Git, upon noticing
> -	 * a clash, to automatically determine a non-clashing name and
> -	 * to write such a config), or introducing a
> -	 * submodule.<name>.gitdir config in .gitmodules that repo
> -	 * administrators can explicitly set. Nothing has been decided,
> -	 * so for now, just append the name at the end of the path.
> -	 */
> +	struct strbuf encoded_sub_name = STRBUF_INIT, tmp = STRBUF_INIT;
> +	size_t base_len, encoded_len;
>  	char *gitdir_path, *key;
> +	long name_max;

Some of these new variables are not used or are only written:

  submodule.c: In function ‘submodule_name_to_gitdir’:
  submodule.c:2615:14: error: unused variable ‘name_max’ [-Werror=unused-variable]
   2615 |         long name_max;
        |              ^~~~~~~~
  submodule.c:2613:26: error: unused variable ‘encoded_len’ [-Werror=unused-variable]
   2613 |         size_t base_len, encoded_len;
        |                          ^~~~~~~~~~~
  submodule.c:2613:16: error: variable ‘base_len’ set but not used [-Werror=unused-but-set-variable]
   2613 |         size_t base_len, encoded_len;
        |                ^~~~~~~~
  cc1: all warnings being treated as errors
  make: *** [Makefile:2815: submodule.o] Error 1

