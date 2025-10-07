Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C3723BCF8
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 20:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868676; cv=none; b=KsmPy+/ntVl5sbgGJ526UO6WpoB4dNShoQERb0JV7fIUnYOEL/LHiTjLAtLXxr10hKr/5yu9gmGOVF2/dKZeZbaNGITVw6VUdigzZW1AwhaKZw/QoI+kWtXomK4MFQvhxTkQEcAwzYq40tlaaM2MhQ4f6EXjSrl8pRovt6bumX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868676; c=relaxed/simple;
	bh=laguT2irXXDInBzCbRd4vIvcEQv2DwtKZ6W4vsDZoN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHLoBpPbjCh74E4iF1LhHs8iqJZ0Re2BSpgKLXbiJug/dXq6xNcIaKp/PwRwP1cFr2yVvFjKTXib3r5fh9+gNdtArss3weNwxK7XDsUlpKL78IUC6/hI5GNv6F5fphCsVGuTHhzTDCmTNNIUoWH256oWEc514bjhJh2IyfMenWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ZtUEpVKH; arc=none smtp.client-ip=209.85.166.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ZtUEpVKH"
Received: by mail-io1-f65.google.com with SMTP id ca18e2360f4ac-937b40137b4so10971839f.0
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 13:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759868673; x=1760473473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=laguT2irXXDInBzCbRd4vIvcEQv2DwtKZ6W4vsDZoN4=;
        b=ZtUEpVKHFl7qNKdbti6UtTP9dsCKjGOv9O+uqh5oeGnnDIQv5Gw5k2UwbAErsTtzGe
         uzRmjGIVgssuU33dFMM1RfdrkzZmdv2wfMxQQ8J2APmP1Q3qTFnZ9VL1ZvYysEd2V3BO
         YCKdVtz/nmLvmMuOzFJZv12mL1JxAYKUa5Xn6Ntzx63roFHDuH3CvB0vAnQUXErxoDuI
         bnrPxwcDZaSTflkstZaLoWF3IEVwqMMiyGP1K5ljtkeBkXZfZx6kdF5S630ksz83h+zf
         DrIk6Smdrpe3pOEQf1670GuugoQXAtjmA/Sq1/XIU1stYrDyaGW/eOZlUsSYQ6mD7Ngv
         JqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759868673; x=1760473473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laguT2irXXDInBzCbRd4vIvcEQv2DwtKZ6W4vsDZoN4=;
        b=hiS1yR89cYjGDhbPKKGJkauCp+1L+WLSRri/HPG39UAq4Ku6YyjrRNCU2I3xA0wYNR
         1hoSiodFz1Oft9usv0bRHmiOND64x6cgf1GopoNoyXLdxGmBmesC8S8WqVloXCYxhZiN
         uJnWTniVA0jGvWISSAnSrO58MIsx7sigu91ykyicuMG9T3GsQkAREbQDmI+6YZNyKBcD
         t2pjwSKlojdaP02K7ZOg57XaVmWWXSMZAxCb0jFx/XHG16T0R2CFH6ynnKi8ZnKYukOU
         dV2TfVmm0J/Zq0fSoXn/tMOdk8rVeQiwFO7H3we35rfbuU/M8DbMh2bwnvRBgQ+KVwb1
         4QQw==
X-Gm-Message-State: AOJu0Yyoorp0cSbKXNIvPuUSC/EeCLUPHsxdJg3y8M+Z24U7B9+Csp4h
	3ULC/u3CpHcLs9+hQQk7z+8LR5G3+cW4nqMyoPbk0/kybSRFl4GSh/U15N7j+JnYsZzCmRZciKX
	YVXYAOnPNAuG6
X-Gm-Gg: ASbGncs9iIzHtmHKnddf+LiawzeGIuibJ1rKEZkLX8AakaDMEbQfWVW/aPUp000Bk78
	qJreghGwOEciI3rNifAcsC2NxS8bLvW0R6pa2VjbvetJSZNsc15jqsghTJgcvaCzIh9aCXyzKoI
	guHY+NI+idVizEQA200Kl9DV1u6Wh89mxxtRfgnu3JTN9HxA0VRdwcQ55jagSKgjbrCUvNpkEww
	gqxpZhOem7YCiTb1bKy8vu0CS7HZtxt7CNzi8762+MxsR/72aVmMlhpLoJmymtE2IwTYmlKG1SH
	/68r09wwZj8QKo/W2TdrHz8UXjv8OJ3Q9/tqh+2HYnZC8/DnFdmLfr6aefhNVODCtvRjkkozI4M
	XA6zoCbBjw0/WBHUCfl2cYVUcNdZWspYt8oEs9ojNwNWUUvT0JotYHp7MpsPSIM+ijP57rMldg0
	M96qtP+30v0/tWc0vjmdz6V65hQf+1QR6zuxHJOrSRsXo+dAuSyQ==
X-Google-Smtp-Source: AGHT+IF1lHZbkes0L2gI93xxh+hDzwc5/uaW4Dh314nkzgESOOLnTp0tQITHLc5KbyoQ6PzlESgDWw==
X-Received: by 2002:a05:6e02:1688:b0:424:7128:a06a with SMTP id e9e14a558f8ab-42f87417ff1mr7860955ab.7.1759868672967;
        Tue, 07 Oct 2025 13:24:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-42f8229fbe9sm7034645ab.4.2025.10.07.13.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 13:24:32 -0700 (PDT)
Date: Tue, 7 Oct 2025 16:24:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 19/49] repack: remove 'existing_packs' API from the
 builtin
Message-ID: <aOV2/6rZFPbOgqct@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <ae267fcc820dc19497f9f897bc5915b2040739e5.1759097191.git.me@ttaylorr.com>
 <aNsUhEVUmzmZ5gp3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNsUhEVUmzmZ5gp3@pks.im>

On Tue, Sep 30, 2025 at 01:21:40AM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 28, 2025 at 06:08:23PM -0400, Taylor Blau wrote:
> > The repack builtin defines an API for keeping track of which packs
> > were found in the repository at the beginning of the repack operation.
> > This is used to classify what state a pack was in (kept, non-kept, or
> > cruft), and is also used to mark which packs to delete (or keep) at the
> > end of a repack operation.
> >
> > Now that the prerequisite refactoring is complete, this API is isolated
> > enough that it can be moved out to repack.ch and removed from the
>
> Tiniest nit, sorry: I found the spelling of "repack.ch" a bit confusing
> at first, as it looked like a typo. Maybe say "repack.{c,h}" or
> "repack.[ch]"?

Ah, sorry, I usually try and write ".[ch]", but I must have missed it
here. I'll adjust it locally and include it in the next round (if any).

Thanks,
Taylor
