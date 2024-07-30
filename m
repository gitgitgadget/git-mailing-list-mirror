Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27C1A2553
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352228; cv=none; b=FzQXFgV+owPfblqRjFbfy8M0zNdXdatndbwdnRI1hCpAkUAqg8eHmA+foH7cVPu13NB2fKK0VGVgDcZCZxH+ZmZvSpIuvfBZVUvn7gb22WDdSD+ttxKcypfufGhyLbG0rggn9kDmlmuMqzxKMGkiMykwYshhXKPHRRsW9c7nHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352228; c=relaxed/simple;
	bh=uGhkjXD08RfgyTotTcKahoPxr9bGg5udN2yoP7jST0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV/qmyajijtiB2yJxy34/27ZU45JcmzbJHm2eUiautjaphN0SEnJO8b5GemLFQY8WtUdRy1mn3xJilzFtkny2c+Q0jtTYpbMQl1BBVkR+nJHkI8vwEZSXGmJQMw9vqRLDhiMf/qRz8ammqTqpFLbp79YTZNnOb7T+hrYahV7qBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+L8krq6; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+L8krq6"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d1d818c42so2873528b3a.1
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722352227; x=1722957027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yx980Kn5fsiwwMSgI2C81LOuLXbdQ+Lo7vL7nLrdyJ8=;
        b=g+L8krq6BFLiIkQgtEcdLCdSIqxisi77oxSefl0vaPgMRZlizml1lRkf5DLDPHBZdq
         Sq2RnkghJluYnfTitT4Pw7fgiSq+KQiYt5bDR3DkG9roaz63z50yf/oZyvbHCLtigdiT
         P3dDtZPGNBWn9YiTe1mC34jENjS0Hop0a304a0L8+bLcbZldUoH1rUX82wGDKkDwzvVD
         a8uSpaJAs4L+u0HTkqWVQhkUpR4rpdabGsewzzh3iNt2w4OUTT2Nc1ippL+QjWjU5HeZ
         MK+vWilSJWr2EZM3EhniZUE81mScGWnJK/Ge/sag2oU1I71KlVl4O5tg8HyavKxLkhi3
         1nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722352227; x=1722957027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx980Kn5fsiwwMSgI2C81LOuLXbdQ+Lo7vL7nLrdyJ8=;
        b=mT9p82x7/Buu4iQfcufqLeg+muuqIGhiUvFSxAOq8lO23hrGgbTRmFMJ4UVKYTFRSH
         s/usJX4rYxjfZ7AX6oaxgsKLY8ehmQAwuB6ena3UP3TNt7h3If0VJvZqsMVfWPp1Ijwk
         TCiyj9tDgFEwj64kIGntE711ZdHlTsGN2CLuj6mDdo9wF5Fn2BEbDCF/inMT5r9qxXkk
         8YJZYEat68ayGmgMz0VCOXexi+iK7OIkTVtlKYp8TBbXPP5A5MwnR5Ef20vwdK5p6gX7
         nGNx/xYWsTgajHv6R53FVm0mx6blhDkq/rHJpSoAud/gvJ0Q1tthIQP7ALUCIdqCim7G
         2g1A==
X-Gm-Message-State: AOJu0YyT0+9WVE/YSQDYMD5i0kTlnG9IDYRujQ962FtejCmIiaOBIiHd
	2VSweV5hhuIolYsKFnf9mWQPFTe9dtWnpInlYK2YSql/7pQxhRRK
X-Google-Smtp-Source: AGHT+IHbm8awIhdjYHiCpIvNBtR7UHc5iUK6Hej6Jp2EcltsKiTkAz1CZPIYtp1EB9Mm5FDAzbedQw==
X-Received: by 2002:a05:6a00:1954:b0:705:b284:d65b with SMTP id d2e1a72fcca58-70eceda95d2mr11840330b3a.20.1722352224985;
        Tue, 30 Jul 2024 08:10:24 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e0f8fsm8589060b3a.38.2024.07.30.08.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:10:24 -0700 (PDT)
Date: Tue, 30 Jul 2024 23:10:46 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 05/10] refs: set up ref consistency check
 infrastructure
Message-ID: <ZqkCds6C8adxrrIX@ArchLinux>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqeYptLyOxAfKwDi@ArchLinux>
 <Zqik5Lwya6bvxxl1@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqik5Lwya6bvxxl1@tanuki>

On Tue, Jul 30, 2024 at 10:31:32AM +0200, Patrick Steinhardt wrote:
> On Mon, Jul 29, 2024 at 09:27:02PM +0800, shejialuo wrote:
> > The interfaces defined in the `ref_storage_be` are carefully structured
> > in semantic. It's organized as the five parts:
> > 
> > 1. The name and the initialization interfaces.
> > 2. The ref transaction interfaces.
> > 3. The ref internal interfaces (pack, rename and copy).
> > 4. The ref filesystem interfaces.
> > 5. The reflog related interfaces.
> > 
> > To keep consistent with the git-fsck(1), add a new interface named
> > "fsck_refs_fn" to the end of "ref_storage_be". This semantic cannot be
> > grouped into any above five categories. Explicitly add blank line to
> > make it different from others.
> > 
> > Last, implement placeholder functions for each ref backends.
> 
> You're carefully explaining what you are doing and where you are placing
> the new callback functions. But you never explain why you add those
> functions in the first place, which I would think is much more important
> than explaining the placement of the new callbacks.
> 

Thanks, I will improve this in the next version.

> Other than that this patch looks good to me.
> 
> Patrick


