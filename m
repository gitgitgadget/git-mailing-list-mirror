Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE4724E016
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778460; cv=none; b=K7y6Z3yopOHv1Lp/G7zMQL0lgKZMjs+yvbFaixAi0b8e55DdHXDh/bV6SXLlDWHSja21gnLpgM4h0HJU86YcZQus++5osoo63/r2ddFaJVPl0eERFs9srKRtphvHnEUzZHHkrZZRl+YAI4yja/xnp4xK3K3aY8t7suOeEDt9BoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778460; c=relaxed/simple;
	bh=SgY6aHhB26REaofKAH7VeNYwoQItq65zr4VmF5CFnkY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JE2QvOrpgIKH2ELNXLgmkvWxcv4Cv4iymIbVGEJpztnwh/Ue8xCY5vXHvvgMaKqgZMVuo7wA7CSTCLpcML7bJhr16Hn1Llq7qus5r3NFEb6O4xESq9jhJpjAtM2+ruMD8McMQhDhfLwaC5O6kpnT/OhO8dqB4RRfEG5mIUnTHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=m201APk7; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="m201APk7"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-42486ed0706so26660835ab.0
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 12:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759778458; x=1760383258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TPyrb3oFQpcT1nAiOpxhpGMORKyAvdNibUsAg6nxEs0=;
        b=m201APk7pDjBpcxvsgAW4TKRMk3x6BVJFU7pIccogF7nKEANdmdcnnvXEfJKNNkPEk
         4uqwJPpOx7Lz8+Q/ozSrzzZRnmrmIjLw1NsrCq/cYSebwySqnw55lzJj6tjsUeph6KND
         gH9ZUu+g4Dpgx4f3d5yGV2EiYDD/aZzoTCmPO8a9Id+UjztmusaXjTPFOoKWuoMs+7zL
         9ixJNWbaoziVBWO7f397FyNj0OTzXryW60B07zm59GEfCylSO6KeZ/Iwo285weLKGqr4
         8RXHdDcejK+uuVzzuJZBrb4DXt47pao9ePO2kVd2yZU4KtLPGFtJfrD8Gq8tOK/ha8uR
         vaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778458; x=1760383258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPyrb3oFQpcT1nAiOpxhpGMORKyAvdNibUsAg6nxEs0=;
        b=sFKlyFzO/p7N02AH6ODTp73AbCwriJ+gfM568gr+QcgB0cZv4ekNIENAhm7aSBKWoP
         eEofkxEocA3S4xAhEcMDnQp0YgFZiumk0Eh6QdNVQ8tdGYcpQW+rv/dzc0oBJ7C87Yvj
         AS8THRX3LG9QK+ERwpAk4l98oEasmMeQLG7pC7SKo0UyTLgJspuL8FIlGRtcP52/KgWK
         Co7hr/IuQ22NJKYoOU+2mATm2XM2vY4xC/tAKKxLxHhQuE0cwLFGBkNNeACOuSOXLLry
         DatRgoUoYF8axBQhrTjfUeZ4lSqkBead6/GCtnf6+fE2voAb0CjVufSrvbZGyL9wE4rT
         FfRw==
X-Gm-Message-State: AOJu0YyNh8NkMTUrH9se+U6ezMtcEbsDXkJvEIy/ny24ToS90enkMziF
	VgJRJmp0yb7pa9TuYsIUT9rixl5sgXsMO71h9FYdDdnuAiwgWH3SunxSd9YhQf3rlX5RTajB3k+
	FLZqxMoGOcw==
X-Gm-Gg: ASbGnctSPcOV5aV6yLKcHoVidOX+fYvIoH/te+NpjwSXx/yE8qa+fbne5usJ0wlRo7h
	yzg9tEA0l2u5MY7rlaj5BvcM/3wvEOUz5YIZ3K8/L2uyguxzypojtEy391rrtEoClHWaUDtsBNi
	5OK38Fx2dJHpfNO2ovrIkmZjXRHu4ISG7SudJmhCr6dMubEle/Xt51Y81E0zcVSh7YZnHl5VP7G
	e8YEewVj7iFrL7KwA7nMggJWN5LveSoaLqhKfWYoa05Jyuqmj+Vcu9dCXYWsyVBuALyNLbYR6BV
	hToEJRj3PYHHUl9vzdVkqKT6Fd4hy37tdSaFdzO/Fl05LJP+qhB5GfPyM2GhoEpZkMVcqMXDbT6
	boB1xZnRRaKO5CXCH8wj75JPHsU6WWPMO0qUaLDs3+MkykeHIkN0nV9wR1eMpVJE3wMsPnKBqft
	XyEjpVmOIOmUDS5HEa6fJLmcN1CjnjB9YlsUdbvS6uzlbCxlk+dg==
X-Google-Smtp-Source: AGHT+IFVZzn18a4LvsOD58cdqJ92gVnIDSjr2tFIWYLJrjdSd6e/CzvotwjAwWxMsT37b+6DPNwjzQ==
X-Received: by 2002:a05:6e02:1886:b0:425:9500:ec46 with SMTP id e9e14a558f8ab-42e7ad039d4mr188355475ab.14.1759778457855;
        Mon, 06 Oct 2025 12:20:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-57b5ebc8433sm5233071173.41.2025.10.06.12.20.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:20:57 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:20:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [NOTES 11/11] Conservancy 2025 updates
Message-ID: <aOQWmFAZ05vZCp/M@nand.local>
References: <aOQVeVYY6zadPjln@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOQVeVYY6zadPjln@nand.local>

Topic: Conservancy 2025 updates
Leader: Taylor Blau


* More trademark requests than typical this year
* Asked Perforce to stop using a very similar logo to the git logo
* Git holds a fairly restrictive trademark policy, but often doesn't enforce it.
	Some risk the trademark office could flag that.
* Git project has a significant amount of money that could be spent ($100k?).
	 * Emily: Could sponsor git-related projects (ex: gitoxide)
* Outreachy costs money per-intern
	 * Not guaranteed that GitHub or GitLab would always be able to sponsor all
		 the interns the Git project desires. Could use $ for this. Also depends on
		 the future of Outreachy.
* Git ambassador program, with stipends?
	 * Needs someone with interest and skills to organize
