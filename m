Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA4B3A1E86
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 21:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766872201; cv=none; b=LiWMgvha1MoM9GU/OppVeCq/BGtAL3Mi8Kkllel9XI3KZ+bMtiBMPVItjXMeREUvutZCkbSLWogu/OsxH/cyz/+IJfAsSZrDwq3kEQk045KouYdQc4CoT5RY+2W7p/m+HJVuRpnkO+HqFuK3o1ET0BCruTIkZVZtsE2Y1huPIAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766872201; c=relaxed/simple;
	bh=e2ZoGF3rl/AfuF2adgB9KLB5zYjXSgpuz2Hmgw7LdH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVcqfInfgiIfAmCi8dkItTqZyk1nDUuCm+zjymSdwYLqmKSgGpKjZYsNgb8MySl9526c4kds546kCNrlU+pin0hrIjMSMnwo+/JnSUPh3aaI6s3tUR5xSU77nxfWTIq6V58cruP+BmfG8UEOAu3CwgNoZmhIhdjhycXtVC4AcdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMOcjeVW; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMOcjeVW"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7277324204so1212236466b.0
        for <git@vger.kernel.org>; Sat, 27 Dec 2025 13:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766872197; x=1767476997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdvWBLVXLi5AxckRe3pJIlkePErHkq2IH0ov2uHBLxQ=;
        b=PMOcjeVWBARYkwXNuS+jLJsVfzzI1VYeTptfeGlRvEWv7lKDGr2Thnm0v+vy8OCaJI
         vaEFVCxhtNMw+M3lVs4pAzygcjC+nDtVXZUeyGQRWdRuS8CnqpegKmKwKcjPiepRpKVa
         BgmZwqws8jhtJYACNUTaKeXDW3p3NSnSkcZ1N651WUC1Kf5oR4Hzj/G6Oyr4wYcjOPBz
         wX49FvMPo47YvTttPd1QZBuZicVZtZ71N4jxL/01F5zzBL/dWhEdtjKJ5hf7AJz3jfoV
         EWIFLkOGGjkyMZVsg8ib9/kjD0AuBvC2ut6dJYFg3BMsDTkgEXzxjkYumykYwcpPeqcd
         LbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766872197; x=1767476997;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdvWBLVXLi5AxckRe3pJIlkePErHkq2IH0ov2uHBLxQ=;
        b=rY4LS5XvaynQmj2dpgVNfse//rAxJJjvymMezHEp3BEy2dAZ+N1J/NyGLQIeGZuGdv
         m2PdJd3uRf8cbo/OuSTd6hbbEt1U89tNknKKIz+RgzoCRmH7KIi7NuQX7KYP0QUq/zOn
         6grYgaKlZZ7iZo8QsDrMGHqjl+Lfqzm9LVzgvHjPMX1Osx5x3+RQXDGafpBelzSNdORR
         B0YFC0YsC+auXKXWvggtdB92yPLNS8vPL46iHbwtvlMUbMztD0XcaaZ43LD+aokwIJin
         ROySIUebz7wP60q2G0hOdNv6OqnAZ358Fk7bHSX5Op4RrCWG1wR+/ehV0KlZtdqFGRZG
         d70Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJKBYtlHNyFO2RjOVgDwf3qAdlTOG8q+DWtCTWqv3TLCr70Oo2csJbPCGV53RxRQXxOwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXnia2Ua4W9CbzJv1LVcOye3Rfi4jutcr5SkVHdJYnYHMZmDLZ
	8W+JuhkM4K7Aecnayztb1WHhjr33hh649J2YjGS6pHmrPRMYxuWfduFj+D7D8g==
X-Gm-Gg: AY/fxX4UXwkVjlm2FnwZVEbl9A34U+Z7NCCSsUGuiONEFWpcL52JIfs5+xrN3SkTGhJ
	0cQtorrTtge1WXB54PFJn3t9C3IgDBb+Gf2dmvQLJEyUd4hMys6sgsuJ96ViGCMNeSTpOa4A0Dq
	sPJjYkUP97aM30FALQuWrACU2+JeRddN1xsnxxjEFg13QLR/robsBJf3WXtjdoe35GmsbMY/Ehl
	HM625LEPkADDdeEtqW8gdLzmSP2EHzSiOBYnf4/U20GTfeJl4XHSocSVEE4G0qsrL7AayVuIDVT
	oCUvBrGYYwxRwr849WtjIx1Y7CcWH6gaftI7yiYvEO61MWbrH686HP8IHF6c37gg8oMRJQx92T4
	eUXFlGTuy7+LEQ/uLcwVFj8nw32hNzyZZI22w/5ibUaj7SGkEDChOrojbRAA9rYt1AS7ZO9x0z6
	lesiEII4Buvis95RvmpTcFE8LTkXhII3uRW30syyoZvEaCG3ou
X-Google-Smtp-Source: AGHT+IEe+/BENpMkqO1rybrn9PdkiWVFTuuygyVzEPqEP+kSe6D3/OWFUXWIJxQodxw2pttTlRSjzw==
X-Received: by 2002:a17:907:7638:b0:b80:6ddc:7dcd with SMTP id a640c23a62f3a-b806ddc842amr1567497366b.31.1766872197259;
        Sat, 27 Dec 2025 13:49:57 -0800 (PST)
Received: from raspi.lan (94-21-109-218.pool.digikabel.hu. [94.21.109.218])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9ef904bcsm26363918a12.22.2025.12.27.13.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 13:49:56 -0800 (PST)
Date: Sat, 27 Dec 2025 22:49:55 +0100
From: Gabor Gombas <gombasgg@gmail.com>
To: Hadmut Danisch <hadmut@danisch.de>
Cc: rsbecker@nexbridge.com,
	'Michal =?iso-8859-2?Q?Such=E1nek'?= <msuchanek@suse.de>,
	git@vger.kernel.org
Subject: Re: Git destroys u+s and g+s directory modes
Message-ID: <aVBUg289AKC0HIVx@lan>
Mail-Followup-To: Hadmut Danisch <hadmut@danisch.de>,
	rsbecker@nexbridge.com,
	'Michal =?iso-8859-2?Q?Such=E1nek'?= <msuchanek@suse.de>,
	git@vger.kernel.org
References: <eb36360d-f539-4f77-b175-57330ef05eac@danisch.de>
 <aU_lqe2Z47STv68O@kitsune.suse.cz>
 <008901dc773c$f05508c0$d0ff1a40$@nexbridge.com>
 <74793560-49ae-494e-afff-9b833dd25d1c@danisch.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74793560-49ae-494e-afff-9b833dd25d1c@danisch.de>

On Sat, Dec 27, 2025 at 03:40:11PM +0100, Hadmut Danisch wrote:

> This does not solve the problem, since ACLs do not propagate into newly
> created subdirectories, as group ownership with S_ISGID flag does.
> 
> 
> Please try to understand the problem before trying to solve it.

Well, default ACLs may very well be the solution to your problem,
because git does not understand ACLs, so it would leave them alone. Of
coure, managing ACLs at scale have their fair share of problems, so
YMMV. The problem with the permission bits is git trying to be clever
and thinking it can manage them - but as often, trying to be clever ends
up not being clever at all. Unfortunately, there does not seem to be a
configuration option to tell git to leave permission bits alone.
core.filemode is the closest one, but what you want is the opposite
behavior - what you want is not ignoring the executable bit, but
ignoring everything _except_ the executable bit. Maybe you can try to
make a patch...

Regards,
Gabor
