Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A3310FD
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 03:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020596; cv=none; b=E4K09haLjHGBn3lkyDX+OMRz3tGtKtqU4wtTvgNmKs/JlgZbCScEPh6HJD1DyewUI2Sr/IhsBRZDfkR4bPVaTBuVqLgMCbokW+7JP7WhL+woaHdf9Z011HHtkhVYYbFeIy4yeAXOOjUcRNHQZ164+S+7HBSe8KVN6Qgb6vCasCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020596; c=relaxed/simple;
	bh=o/YSWcHLruJDnNTUOPhf0fYSY5T54dRrf/TrGXuCPak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oewf4XS9at/Uy6iGOVuECS0+9L7ocDu0FPNcWI/dFzqjrCbBTgVtAMX7/48P788B9SUQoXHzAZap8jVdLcL1V5aRvyHmGl0IV4qotxX+qTisyTVqJeWnaM7Db0NwnEGU3xqEjkJdvd8eG63e6AGXcTvzBe08+wg0ECz26YsMWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=U7KmgBEX; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="U7KmgBEX"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc4418c0e1so2712521a91.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 19:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740020593; x=1740625393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/YSWcHLruJDnNTUOPhf0fYSY5T54dRrf/TrGXuCPak=;
        b=U7KmgBEXKrEQfCfcFwS7YoSWiD0dxe03TXqyEAY330i1jxu3YTAe0uHosOEGvd8MyS
         cUfCRVxSSVMNU244DZ6FfunVQCx+zgvKneyQWPFzV64zeNVk1Otivb8UJo9VKfv0Eiqp
         TI4GRaI+ZfLkxpDbfE/KvBPE3RWfdT82yrlteUO9tOKG8IW5peFqQg14FEMNR+bfZ3f6
         mWpOCs0fIvczQFC3XPtlzwWjbaxizn9jnkpcImgwACJSYyh6owIiqQRFm9lUouSZ8Fi+
         Dw4JKJmDwouDUsB6noI0XdFCRPGF1gWWQ9gt3kHYIDwwKHWvjb1oXSDcxrFjTA2se2VG
         LYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740020593; x=1740625393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/YSWcHLruJDnNTUOPhf0fYSY5T54dRrf/TrGXuCPak=;
        b=fzDj3fjnujnKKlvLCnpFiEudT7RZ+S5d/rXDF2BfRW5sXjlTQ+wFv68aEt8VZo8fqr
         0Uu90ZxNW73qGeAWHxfVtPbkJneRg2DLm2bHkHUaWQs4DeeCOUyQ46EkP+VBZWkErQOT
         hCPrZNV/AQnOxcwHify2dQP3/UrQv1oQ7GppP6p894ss+tC5GWcgN+MPYEOHdKe3lgmi
         8SJAvjDrSff9JzyAH2VCYYBhEk6h2JpMDSgw1sdf+0OPJnpSt0TdLpIkmPvkiVB5bnJV
         dAEH3TrdyS1F8OcI9dET52x0HnsWuu48SkxnXd5NLS7XDAYfzafYIuo/G71NZZuHS9Pw
         vguQ==
X-Gm-Message-State: AOJu0YwR/0WRYaDFhePMCQ7XJlWy5rLPBD40qC6lIMhtxve7/0M5hcBk
	v495pVitHZUXUH/Q3j2MDK5tqMPcJV9ngfSt0SpQ8bsGLX7V1nArfpvZTXhtKQBbzyfwNN5LKM6
	1hUoSMI/yeEYUxIroc62xHKrxRGHXJs/VCWeg4w==
X-Gm-Gg: ASbGncs1FxEM5rcxXzgQbhBj5Vv2gJ6TKQ3WlQ4g2r95qSrZfHJcnFm1zY9xU4HYDdI
	ICqJ36dTUf7CTuhT0POH/V6s1t9HBpaQ/Z6CSFQR9pdd9HoJ8zR8VZ/IP0TpEKDXJW0ckQPjKZx
	g=
X-Google-Smtp-Source: AGHT+IHMCfoQxvusQ008RN+75Vclr5EK55aRw0RXsCStrigYDMssfdtPg7K62fpC9aE0cbI4BQ903JRQuOJAB12/MUI=
X-Received: by 2002:a17:90b:3883:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-2fccc0f838amr2636739a91.3.1740020593406; Wed, 19 Feb 2025
 19:03:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1524b9a5-6f8b-4537-ba6b-bdfdd4b1bdcb@cendio.se>
In-Reply-To: <1524b9a5-6f8b-4537-ba6b-bdfdd4b1bdcb@cendio.se>
From: Han Young <hanyang.tony@bytedance.com>
Date: Thu, 20 Feb 2025 11:03:01 +0800
X-Gm-Features: AWEUYZk5j6gqxZKix6Sr5XwagNDECZIESUcLyP_5IuWHtb5Eyx8V77SpvVkxnw0
Message-ID: <CAG1j3zGmA30w545+-6qFV6x+3HvM+fueYH-rv-_gaSTpZStMHg@mail.gmail.com>
Subject: Re: [External] git keeps recreating packs, exploding backup increments
To: Pierre Ossman <ossman@cendio.se>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 5:58=E2=80=AFPM Pierre Ossman <ossman@cendio.se> wr=
ote:
> We tried gc.bigPackThreshold in the hope it would force it to reuse
> packs better. But all we got instead was duplication. It still creates
> new packs with everything. It just stopped removing the old ones.

Is the repo partially cloned? git-repack will always pack promisor
packs even if it's a keep pack. This patch would fix it
https://lore.kernel.org/git/2728513.vuYhMxLoTh@mintaka.ncbr.muni.cz/

Thanks
