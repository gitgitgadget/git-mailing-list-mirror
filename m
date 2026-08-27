Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5DF3F104A
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787860608; cv=none; b=EZiSLiHnzGN41O4vcxzjWFOtpsMVSQKV8nC9l76DyggX7uw0cSzfRfNFgbWnNnMN3xcEolsBioqAOs6hpTUGZNPDcAOTLfshQ3IrRboXN4d9z83uDXMXYS8Dzb1aCc0KueSuWwsCe0w3fjPbhTM/r+7nqwZfL6EdIFA3R2lZ6WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787860608; c=relaxed/simple;
	bh=1GOHsGHvdvXIZK9JWwAqKRaLlEY+BXiyojND3R24bXg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=r2WiaCg0T8Uip2EwEJ17JRfyehsnI9nmT7tny/ilmzOJWvt+ohPnq+pXvhR9Yx1onhw9hq12Q4jqDrBeZzqhFtoXic9XVXcGhl0j4GeSZCOUp+n97xMsmOUtbJ5Qcj+M6pwVz4Dl9La1q6MMYjxI42BgcnddEGpfM6f7vlJBNLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYOCcZMN; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYOCcZMN"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c96c92c0980so211406a12.3
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 12:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787860607; x=1788465407; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1GOHsGHvdvXIZK9JWwAqKRaLlEY+BXiyojND3R24bXg=;
        b=fYOCcZMNQn/3r4ZgCzR2ZuDbo8UQH7KQDkk2/BMXhby9HPgeD7HBv1yg0FC7vOCqAT
         sPkllAcu9+wDQc/Dnjch/2GqFLg+ZmM6E63PXtUWn/ZoHC20J5Dr1TnJ7YEPvAsEdPYR
         NHU3wfGRspDTje8f0zQ+UDVl1Faq5ug71CJl2qaoxdIEpxzTgSn9my9tBWyRs2aPmAZl
         IUOIMMxezbt8BbQ+XvBHc2G1t1kuVIaokTDydG4IIrZmjsED/OutkDAa25MGbAj2ClLy
         WUaPVGNCMyZ9DKPIKi/UHuIUxERlRXCfp1OFt/VQu//h+Z0D8WDbb6/peH5TGyj6dcUl
         hQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787860607; x=1788465407;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1GOHsGHvdvXIZK9JWwAqKRaLlEY+BXiyojND3R24bXg=;
        b=ipnuCJlYelQ62qTUuVitC3TI8uydYM0qF3jBxqwHH749KPYW4DqCNxiwJ+hXo4UhVO
         eGqzA6qXTkhdEGu3d2hLCz3Sjz71nYNzppW4w/iE3D58BU4sgfX3xinBdj+dZwgzF04M
         1+p39abPRLjhBJ9V2GrH62MIbXcmnH1laIe4ml1PKpS38lQE6tiRCYhS06jSPOOIBifS
         jjlecD1WhQxBE7p0p0Xmau+R8vK4G9ruBxkJwUQndtx2gfrPimtcr9IdutBoo1OsB0Rb
         XOULrRFZoLAdrx3sl+v0KNvbhqz9cLrzbs7R8WfkYQ0Ps4SUeu04ebKQpkA2KU/iLHWz
         lUIA==
X-Gm-Message-State: AFuF++mLkmKoQgiSzlx+FrNjGPO+x/r7Ky2OnJseyxIkBtrarmopbmy/
	B62NDwuith7iDx/JQbZDgDvIqhbVfyzm1EBPM9aj08a8kHZCTDVZY7RyDAcggw==
X-Gm-Gg: AR+sD10ZiLw2z+5hWOFrhAr/SniTrmDFqkzCGDSYg5B3RFtzXoiRkgdvFHp/lIfXcSP
	3AKCRmIMlHCwL8C/JebV1+ljH3hmhGWeZ2B/nFXdQF+DI7cn4R60DhqNHKpm3RmbZ9NMr2MGQiJ
	tbGGaaMZGkFqDORgwB8CsJ99E3V4+DgTxqGlilpMCZTDCFty66bdi/l9Jxiw+IuDzkILZsrgOJp
	0jX0toO5r8MWa21eKRPc9d7LUHGBS5xXriYQaRH3iJNasffNVxUhVXHnngyO4K/6iAWuHhWHvrL
	LcdE9/lndOqNLpT8q1uQnofGUefBXMY2FcNJoEdOZt4qyiHTort3Ph9TqtBRoSSM1mApe90nlkS
	xtKK7BzjojW3S5/ebGcezu0uu/elGsYFQliDbHbSKMX+5P7PllmjJfja/yTTX4GW5BFwkGFBVfC
	0y5YyDGXvvvnCLqRssixCYyMjajh/lRfGr5CHQd6HQF3OqjRi2y6c+v8M=
X-Received: by 2002:a05:6a20:c998:b0:3c4:3767:adb2 with SMTP id adf61e73a8af0-3d26657e1dfmr2938815637.1.1787860606650;
        Thu, 27 Aug 2026 12:56:46 -0700 (PDT)
Received: from localhost ([117.213.200.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283fa89e8fsm32701819eec.8.2026.08.27.12.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 12:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 01:26:41 +0530
Message-Id: <DKZZOTND7RNF.16J4VLMEKOMLM@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] builtin: replace the_repository parameter in
 is_bare_repository()
From: "Hardik Kumar" <hardikxk@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Hardik Kumar"
 <hardikxk@gmail.com>
X-Mailer: aerc 0.22.0
References: <20260827-env-is_bare_repo-v1-1-aa99600dc213@gmail.com>
 <xmqqo6en8jof.fsf@gitster.g>
In-Reply-To: <xmqqo6en8jof.fsf@gitster.g>

On Fri Aug 28, 2026 at 12:39 AM IST, Junio C Hamano wrote:

>> The patch leaves some instances of this case that would require
>> additional changes rather than simply replacing the arguments passed to
>> the function call.
>>
>> - Only update sites that do not introduce any functional changes.
>
> How did you make sure that the places touched by this patch do not?
>
> How do you deal with repo=3D=3DNULL case in these code paths?

I verified by running the entire test suite which passed fine. In
addition to that the methods in `repository.c` should already handle
such a case if the `repo` were to ever be NULL or not initialized as the
same pointer is what is passed to all callers.

Also the repo should always be NOT NULL and then git just throws an
error about the inexistence of it.

