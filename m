Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498431E0DD8
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737379554; cv=none; b=FJ1l8VGnd5c0Qun/hFHGfjTDUf0zGtr+J0cXy43KG010Ep9uEg9iHcRCz/yRjgHyf0UeFjbLSgGe2oaHqRej5rzPbTr0JCYTHgWOUpS7wdBtuvUaaSeetsaY51Hl06nYXJKG4yfmM1Iq/960BM4r6I4P/7yqoAtwwx/pWPcRX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737379554; c=relaxed/simple;
	bh=c7677mio5rVC2SZul9TC4nBl8szOYKOe3+G76uZc3vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9Ao1xFn61yrLQBS+1cTebFTR5QgvcWLBAClJJztyNZ1j7tpJlsgqFtd+p7VsalQREVSZq/cvCWp1v21ppueSIcG8Q28zqzbRkYDLYq+re4bBcfzvfkOgm2ehvsIj/L16t6LxpP28RD/8sdQXZKeuIRxWXpXebFl38QB26WudYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atN5QUlv; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atN5QUlv"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eba583fbe8so1340935b6e.3
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 05:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737379552; x=1737984352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3rbcd3GgaluhsJCd5+AXwFkAzWVwEhMm4e8nwVEe3hw=;
        b=atN5QUlvLDinMZ0k+YmS5KtCZ8AGH1Uxl5HB6m4uzO1TOlxHjTDhNNQtFh/hs5n5Bx
         q362BsJIkUz+rj2HdSpeFTtEz6igM4J9mV0vGt+p8xi8R9qPKVuQkU3U96D/xybXNRxq
         W3IU33EvoX1atKya6OdwzEynxCn36euZfeLpHPsydq5Hjje5xXneQgilp4/rvUxsHyRi
         KQ14l0Kcc0UVdomtWDn0r776h68WX8YelIDyrKpmOPO/fu0ME9VraTpcLaENkdl5z6d7
         vy0nEH3g1Rp6CgK8McZpeSZaVuqZeVPXHseY+aMpV7QcO2iRVj+QhIQk+tFgoXv5vPN9
         oPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737379552; x=1737984352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rbcd3GgaluhsJCd5+AXwFkAzWVwEhMm4e8nwVEe3hw=;
        b=WdmLwwEFcEXvMyt9p7JdALJ5FRRD4/7gOiA17xIA87rPm5ActlkX5VPsXqH5rhY8pA
         uixLuaJTEiyXjItvBLDMQPu+kCO9NdXLihXCEv0Mo0cjbgzJ/ZhH68Ns8bSdwkPHm3EG
         7FGb/ty0nNvaOENq7CpeVb1Wkr/rvsb5mP15+GfVCIwy/xw+W9TSzo3W7g5KFcE/JigL
         lqfGohhPICQE2kJLHl4ICdobEGJO5DuU1BEx+RU+qQwpj4kiEzZ9rXh+4CZJne0usle1
         IlUnjwB6shvL/vaR1R/Rpp0Uy2+WRM6inf2T5V/qJOypUTteSdvib5rEMPNV1+YuZmyu
         FgXQ==
X-Gm-Message-State: AOJu0YwWfKkhQDIPCmbWLf2zGfpXP2AteU5wi55JlZs7kcnRYAsMVGiT
	oCm6Im4P6A9XhBjIKVu5IVJO5Cjn7ErO0pxKttsHGZvYZdrqVLMK
X-Gm-Gg: ASbGncslrEdI9kf4qDFcuEQM17ncUQOqG4DYQUK13zA1dBKMnCgpCQm1YcdQ5vNDciH
	T8lx0QV1sbUVoXb7kvPr3DMbsB5ciTy2eoPBwDGYSWXGpYiJcdRXrA0JYI7XuPqnQs6MHJ8K246
	dDXcgGjMNeqUfZ8Rp6ZmMvxBPv7xuQVriGhbpaAJJTnugmEkdpoPKRmd88MjXohvV8JuBrsvUyT
	Cvr4jNt33tiSB2nEGdZpAOr7WqfdcTOb0VZb6/Gd3Nu/Obr
X-Google-Smtp-Source: AGHT+IE01qtnks0Qu7eyZywlYJjfMq+FuBl2Dm600CdNwnJdquU6H8TnEXI+p/GYqauiBlUGs8+jpg==
X-Received: by 2002:a05:6808:3a13:b0:3eb:4f4d:c292 with SMTP id 5614622812f47-3f19fc2a63bmr8991213b6e.18.1737379552043;
        Mon, 20 Jan 2025 05:25:52 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3f19da450fdsm2403558b6e.3.2025.01.20.05.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 05:25:50 -0800 (PST)
Date: Mon, 20 Jan 2025 21:27:11 +0800
From: shejialuo <shejialuo@gmail.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: Git in GSoC 2025
Message-ID: <Z45PL3YEfX1NfM6O@ArchLinux>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>

On Sun, Jan 19, 2025 at 03:43:29PM +0530, Kaartic Sivaraam wrote:
> Hello everyone,
> 
> It is that time of year. GSoC Org Applications for 2025 are open now[1].
> They are due before Tuesday, February 11 at 1800 UTC. It's good to see that
> few contributors have already started working on microprojects this year :-)
> 
> I could help as an Org Admin like previous years. I prefer not to
> volunteer as a mentor this time owing to other commitments, though.
> 

Thanks for volunteering again just like previous year.

> There are no noticeable changes to the program this year.
> 
> The GSoC contributor application period is March 24 - April 8, so
> (co-)mentors and org admins are already welcome to volunteer. As usual,
> we also need project ideas to refresh our idea page from last year
> (https://git.github.io/SoC-2024-Ideas/). Feel free to share your
> thoughts and discuss. It would be great if we could come up with a good mix
> of small, medium and large projects.
> 

I'd like to mentor for GSoC this year. However, I think I could only
co-mentor with others due to the following two reasons:

1. I am still learning the internal things of Git.
2. I could mentor the student during my off-work hours.

Thanks,
Jialuo
