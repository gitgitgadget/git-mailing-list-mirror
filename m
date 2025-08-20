Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C22BEC27
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755726640; cv=none; b=DlQTKm75Kly7f/x6ZiF8O+bNSEjBew572rqnWXFZAuN+pC7ikbO+vKmZhGDOdW0S6YY0ehNhEAUEo7E6839c6MD/IYX2auv0QOOEzjNEeXZEHE2B3PPUavI9F8pOOYlcuanJPns8FwMWV9JREbuvdW5xZdYKBYRASqeZ592MeDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755726640; c=relaxed/simple;
	bh=23MT01YOqB360krtyIvrCyRdJ0QBi5W69J2LKE0XNzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaK+sdz641pbQUCBr/eA9rBKzML2SlwhooDUe0UhYoFhAAnI1oI2s/kHGU377uorcFMrJaD4meuO4ES1/0E1yE990fbx4YvXVtkbj/tIEMC1gCFo+B2iurRgfV4KMhbzRyNZte60eqAZe1AfLFLmeoMvv1fVIPFiEYjbPD8z4Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nDd/euP8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDd/euP8"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-242d3be5bdfso23195ad.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 14:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755726638; x=1756331438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iblgXQqldfLzWCJ/jKHNbwhlNg1Xo0e4KQivW+3bHJU=;
        b=nDd/euP8wQr+JVCoqhYqS/tFaU1vwQSVxqynho2OTTADktjqfnTraECItccXdRo6te
         +ITjXFPdE+1KJYFe33ebGkAPmMt8paJ3QDRm9bu2GBtxO7RD2liJ2lPuGuK350RA/SIy
         3rmDeYYhQ8sgJlWMyPW6IjRbyfzW3r11S7FBDyffIATWltisH6KEaNujMB4o/+LIxZyq
         Hm/Q2dnPP9YMWk9jTyEDQw8WKVUkgEMztR4UGadtwfvMlvdAqBCgVgndDXWuDwMOZ1pe
         z8Jyj7l2dA1SS6vmxSEmY7D43leZQ4SygKsCtbmLGjMhDFO/xxvgTmgEkjSCP22SAVC2
         Lygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755726638; x=1756331438;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iblgXQqldfLzWCJ/jKHNbwhlNg1Xo0e4KQivW+3bHJU=;
        b=wet5j9as9yoHJdjXKE2lYBGsbknFRwEBOGmeB5ZTGukhwIp0cgAOq2EgnmQlg9RH6k
         x63yFsJZbouwwZsW2YZU8NaO9D3ZJjnuomOjlq8lSK+UkBRF78zNfqF8tQUogTncfUt2
         t0HD04qR06kC9nHn4mRcH2kgGFaB5w7Gv9QUjw+XlFre9OdYWlxfSME7imVwmRXEBwtS
         +9TlumzkSFAlwWzL18sE4jsjdpNAemzA3GfO8uaiFSEINIU/oNVveCxGPpuQp/zwkZqe
         UggUNqXIJ/BtK0hAwG7lyq6FS+auhvO/9A7EQfpDI3MdcuTsXu9KhqnIwLESx5iriS5v
         5yaw==
X-Gm-Message-State: AOJu0YwVlSYPM79TLdiMVXwS9fYohjErk3cqXoU3F6Kc52a5VPhXKt0y
	2pUvx++7UJo1LvXaVWHTkzGWzcfNaxAoX2vLHkvyY7/7uatrQ91JBm4M2HWOwF8vSg==
X-Gm-Gg: ASbGnctK4INkZ3Hc6gFTAKfcpShZIMnt5CJ2pIWO8PpTwATndsIEzThZx7EAR4RrOdu
	SLINOl6SrFfU2bSHk3sWeF6MiH/JPKnCP+7MbEp/O9n79ni7KXBRVzRxL5o/K6jWvdJSRiPQQ43
	AhYM9CztyGM8i0WlCc51PztQrmlD7MsE40PS8PRur9UBwAktvdUasG1Fgmoum3ebYIFaxOQ/WPb
	bufdmyvfpfCcv8Q9M3qgPMmEbdfT70l9eXTd4V9FuFw4y/xfQ+YzO4CQ4ozHRD9olHWDkCJ3mm1
	7iwQLyqc6sLti9DWSG1CVIryGhKD0Foh/6ZqKFcP7MXdhd/htvEojWYkuSU8IecVojmnEtfX3yd
	BJWy71YirsHCGcfVQpA+FgRiE3Ro=
X-Google-Smtp-Source: AGHT+IHPsX/BwRs+lsA9Qj11r7AhK7YhZe9r1NeC0athBxG9O7DKjJBfxV5SOFB46xV3pamzvkjScA==
X-Received: by 2002:a17:902:cece:b0:236:7079:fb10 with SMTP id d9443c01a7336-246022813dcmr305935ad.3.1755726637768;
        Wed, 20 Aug 2025 14:50:37 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:23b5:65e6:69f5:ee81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e843bb510sm5302294b3a.53.2025.08.20.14.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 14:50:37 -0700 (PDT)
Date: Wed, 20 Aug 2025 14:50:31 -0700
From: Josh Steadmon <steadmon@google.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 3/9] submodule: add gitdir path config override
Message-ID: <km4qhwxpmwld2qw4ihmzjtk7o5yeblfhhm6hqsh4nmzdbkdyyc@mwqb7a76liop>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-4-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816213642.3517822-4-adrian.ratiu@collabora.com>

On 2025.08.17 00:36, Adrian Ratiu wrote:
> This adds an ability to override gitdir paths via config files
> (not .gitmodules), such that any encoding scheme can be changed
> and JGit & co don't need to exactly match the default encoding.
> 
> A new test and a helper are added. The helper will be used by
> further tests exercising gitdir paths & encodings.
> 
> Based-on-patch-by: Brandon Williams <bmwill@google.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  builtin/submodule--helper.c           | 17 +++++++++++++++++
>  submodule.c                           | 11 +++++++++++
>  t/lib-verify-submodule-gitdir-path.sh | 15 +++++++++++++++
>  t/t7400-submodule-basic.sh            | 15 +++++++++++++++
>  4 files changed, 58 insertions(+)
>  create mode 100644 t/lib-verify-submodule-gitdir-path.sh

Sorry to keep sending piecemeal feedback. You should also document the
new config option in `Documentation/config/submodule.adoc`
