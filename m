Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8E285C8B
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219339; cv=none; b=fOXIpSaPgBaBCwqDB6E0bwhC2UwXIcCv6+x9mKVHHCtZwGzt61PlYFUCbnVjcpynK/M6iX5ublbFtcMMvuBaQTuZJalCVpbcv3LzABW6YqUjlZ3HPDoZwwCTKD6AkvOIyEN/i4DNxj7WAAyKTr6+zDnwOx9YdFynTmfsnCiEwBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219339; c=relaxed/simple;
	bh=KZ55bHDqHNUFWUY2SmNavjkYI3lWiOzzRgpPHVq8LoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciIjeXOK0SsOmltdcRh09OG6VbYOzJ4vfzI+viZh863l02k1j5hwi8gJIMKUg15Ju7TgZ8wovVjROki0Im9PHEOVqO9bw+4SIu04ed3cR2B7ed8IX6ED2DyUmE/ZzdAaJALkP5paESZTlEwQdRTJzxUFMhOScAXKHXRm7xn7PwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=On5lj0lM; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On5lj0lM"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-301704710a9so2354250fac.3
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 14:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753219337; x=1753824137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdxOvJWZy4oI20K5yi7DLtrHL/QY6BIMsoOuEdsJdG8=;
        b=On5lj0lMmhERNJtAItAH4VCg/3GgBGUQdgdH5+THDmSar/7yG53O3BYltyoM2nPhyi
         2Q4e79PeAHI46DTm7ghp+vEU4CLOS2hSwPuN7axSWVtwQvThdUVFHQQErbxuTDzxlIgl
         3r2V68Q1ROOhS2UNEhfxBjva93FYCN++acSBltcUY0vMjnGwxehVJSFQkXdr/DxwX804
         xvCuBZOGiYPHsrqHzhTaZPjVN3Ze+WdD1+pa4E03JQnqyALICDmvQYK3WV8CQMIrfPHW
         lPTgxjUAcq2+L4FPW6APxKANL6+a571z8eO0NcgZw9r3gTOf5mTHWuiChfWiszELans6
         eIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219337; x=1753824137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdxOvJWZy4oI20K5yi7DLtrHL/QY6BIMsoOuEdsJdG8=;
        b=ppqiaBp/WaBQGKWUr2JE9YU2QhcQtdvxbYWiyvGCNdcSGktACccLxKHG6dTgg44cJS
         EGAJEyYXGtcxFbVb8OF0xoDINyZpVuBouQFNtqkIvZOT3TJb2POWIQGqfG/+yT72cmDF
         KpJJtt+POqU41+1P/d79g6LlISa2s8EknY7BKHqy3tCOHlFprh5spPbEiUp6YIqF07oA
         Y7YVEZUCGdsf38gHhx8yQ8NY63jfQcaIKL2/Yya5U+RqWG5IrEZc9cbRc7ZPZ8xtPxZo
         FkVzKrLP36p5V8UWYQAViNIo9wAOtytYHdJ8IFFQJXaRwQhGrGryV6TzpUI12aB2me5s
         7BMQ==
X-Gm-Message-State: AOJu0YwxxJJ/aEnqwOxPFLW9b7FMXrM4HlwmlG+CEy0LsmBJ7C1ueeHJ
	mPGS7+5mOGtIdfYkDZ4uFBvKGTVWNN8dZUgouUDWINmDJ/bI3oFytoXrMVtmHQ==
X-Gm-Gg: ASbGncvxRzmUah5+wmzh3j3+w9xrng5X/OUU1b1HELxu5JAzj6IWl4MNscgUKuxYSkc
	/K6yRG2zmnDHIB1KUe+qS1+ZxWOiO++ouAowmJ74l86f9O/P/RWrjT6q56If1im+58SMgkVeVLv
	CTTZe1O3YTSnmlWAthy74VMBJY4SxyV2rlO075cKT6jxqzERUgLkbVBlKj9fFerdZS/luvH0dF8
	osVMcUQZUenwsyLPneEQBl1IDS9CrdblrcCOFiSU87Q10sBIaIHhDs3uba9wrJn2f3Tezp6IsGu
	SPfxO79YTf/9PPZTeb/5Fl+YP4nCxgP5VMeJGqXiKAVxcfWQyhUZT4J5+BR8Mzyw/tGmVlm3Eyu
	zKWyIRl6LgUj/9bw=
X-Google-Smtp-Source: AGHT+IHkw/6gvF6po6CUk/zdFNp+24AMbkLy/YQLraP2gO23WwbmJk1+YPrbv2TQSfVDX2vg5iMIPw==
X-Received: by 2002:a05:6871:810a:b0:2ff:9776:1231 with SMTP id 586e51a60fabf-306c6f69828mr376395fac.1.1753219336961;
        Tue, 22 Jul 2025 14:22:16 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-30101cd81b0sm4726238fac.16.2025.07.22.14.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:22:16 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:16:27 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 1/2] builtin: remove merge short flag for switch and
 restore
Message-ID: <hjvkryax5gq7im6m6jnlczykfctntnqf73xicbrfehe2j2c3rt@62m3urrkecg7>
References: <20250722180818.1043014-1-jltobler@gmail.com>
 <20250722180818.1043014-2-jltobler@gmail.com>
 <xmqq1pq8rlo5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pq8rlo5.fsf@gitster.g>

On 25/07/22 01:54PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> I doubt that this particular one is a sensible change, though.
> 
> "git checkout -m <another-branch>" is one of the most frequently
> used operation in my daily workflow, and having to type "git switch
> --merge" (not having to learn to do so) would be a major annoyance.

In general, I think it is best to reserve short flags for relavitely
common operations. That way, if a new super useful option were to be
introduced that we want a short flag for, there is a better chance a
good flag choice will be available.

That being said, I incorrectly assumed `--merge` was an uncommon option.
If there are workflows that make frequent use of this option, we should
drop this patch and keep the short flag available.

> > The `--conflict` flag is also now defined
> > explicitly for each command as to remain alongside its related `--merge`
> > companion.
> 
> I doubt this is a wise move.  Unless we are planning to make the
> option diverge across these three commands, that is.
> 
> The main logic that implements the "move to a different branch,
> while merging local changes into the new base" does use these two
> things together in the same code path (in merge_working_tree()).
> The same for "check out a single path out to the working tree",
> which does use these two things together in the same code path (in
> checkout_merged()).  I actually think keeping it in the common part
> would help the readers of the code even more---by making it clear
> that these three commands parse the option exactly the same way.

That's fair. If we do want to keep this patch, we could still keep it as
part of `builtin/checkout.c:add_common_options()`, but add an argument
to toggle short flag usage. This way it is at least clear to readers of
the code that it is same option.

Thanks,
-Justin
