Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61252BE64D
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311314; cv=none; b=GKvWP2c+5WiMdGXmb4BkNNWB/kL15H1FYVIdtToF+16MOAI+uUic8Xwo5k0kPFqgsq0HuF/xVa/VXw8RbwV/Rs7WV1IoMFzo3TNtr6Ynd1WZKd7N3tQw5Ok7enNAieLlAIPcPXTNlnErdEQkI0MCnjAtuYRU0+SMJnnHuwWmEO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311314; c=relaxed/simple;
	bh=ePh/N2P1kquE7x2iVTzuGw9I9QAdPVEFca3EU39eQII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVUeD6MEiOMGGkeWnhz5DiuPbjP0tfJHjbMTy9pwcAyVadTbKTvA/uRWSMFntq/SJ3mACVV0s9lVW+4iTQHX0hknKFw/jGFOgsdAdl0Lh84GL4ivI3mjpj6L2Z+aB3fpZYJCgtV9zyYnaNE8b0hcfJkBwXOrLznSt82oNfu/Fdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkQoaHpH; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkQoaHpH"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57263febd12so4056686e87.1
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758311310; x=1758916110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePh/N2P1kquE7x2iVTzuGw9I9QAdPVEFca3EU39eQII=;
        b=SkQoaHpHzzAXujYJtmdvztUZwkaqiemse2XXBMPvNZjesUo3UuLyJ03Zi2XVeVGqk+
         qr1ubMaZYoWejsPE0QbBIcTsioR07eX9X6Me0BIoIITkXNoZbLCsazXqOaU5GgAsBEn/
         q1+Fn2vg677M3xFljJa/BdYVTD3LdUc+vmGhymaidUoZjygOIKIHKqZ7f47w91CrtS1+
         NlWvHOUflE65eBX1rJ8gWqgAjyjO2hE5FP1kHEpE7mQlWrPSgUvzoOyC/01VZ6ncm0L/
         W6nbHFTDYSTDxP8rppxu4EapDlAnR2gFzQg/s/GO8ElQO3leSHaJroc6SIXO5t4Jmew5
         hR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758311310; x=1758916110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePh/N2P1kquE7x2iVTzuGw9I9QAdPVEFca3EU39eQII=;
        b=FcdIcP/d/HkoNxyXvg4vUl6QL/VA8EwOf5oPDSc614JeOicx8XlfrgotMuUMoW+WkL
         ZXNaajqCbqdHGD/dwHQ+m//lHC2eSl8OWuDm0cLVlaOLxfWgd3+I6FbcAwQERj+dsf3+
         dSnxvtHIKZEKLKfKcX7zXB8c3X12hrDkArE+DrnaZ/OFO1EcHkRIxV3LhrmY+W5U7hO6
         6/M4O/q0Z818jwlxOSL7Q/gkUO8Y49/E6qSCW8OZF2raDcayRyoD9yCnnXST7tSObLSn
         LaO79G0rstC7Nevv51LWAf0zI6iPWwTHZ+zTZ2AaA/QGsnoppRNqUdR817QIlGFQ81d9
         ErVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAcOim/6XFk8IRW1FEG6JwtpRp2skgz55nRJ+990SGlloTz2ScKHe/OIP+pBQS3Ow0e1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFzMm4Y82Xafj2QZZYJaTBerf+f+5laJfH6ECDQr4dCHZ/w6uq
	N43hb2k4KTIc/VY6sunGhhYiRuZK1w+So6J+WkmO5rzbvLnIrDMr1cIB+1mMXsgdu7JECwdsK2U
	3tHkkPOo4Y6jMsHwxHB2pCwAowsw58pk=
X-Gm-Gg: ASbGncvi/RiSppSnB2TXEI1NDXLTgiY+zzH+DP6BVd1+A9St6Tz+vPN1GzJUMfVFqwC
	3qWfzNH3w5hDbGKMju4GszdOLIQFEvaq8SIkPV2yfoQW7GxAx+/W3Rn5kOGfi+f+pwxbeFWW1nr
	HHNzqyxcHMkK6SDLQHk4pXhWnrXYq7a8CIl78gnePC0KtEDI26I6frDvNzXjksdt923fpeDCTgX
	xrPJmyS
X-Google-Smtp-Source: AGHT+IFzeTYEFwCkqwu3ALSxP/L+LZppdg6ugzcL69Sr2ZyEwF41Yp1yxh0tUnpkC5hzS/LeW7I4E+vRfxwDvQFnSow=
X-Received: by 2002:a2e:904f:0:b0:335:2d26:1408 with SMTP id
 38308e7fff4ca-3617529137dmr19184111fa.21.1758311309412; Fri, 19 Sep 2025
 12:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <7082e32c5975d2aaa277eddae7497eba0f2131e0.1758071798.git.gitgitgadget@gmail.com>
 <CAPig+cRGtMX9bQhb+7g5aXRVjpLKY-qDdQP95f9TmbY8j_BweQ@mail.gmail.com>
In-Reply-To: <CAPig+cRGtMX9bQhb+7g5aXRVjpLKY-qDdQP95f9TmbY8j_BweQ@mail.gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 19 Sep 2025 13:48:18 -0600
X-Gm-Features: AS18NWAutoqgPCaiu6jvcMqv7bQa8Iy7ZWuLNrQJTx_KCYMbrzS5O5_ahWwpyk0
Message-ID: <CAH=ZcbAOBnEVfyNy_4hdpe_dvsqDxsKVTcvurJz_iUWiqOzG3g@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] make: add -fPIE flag
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 1:45=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> The commit message explains what the patch is doing (which is obvious
> from the patch itself) but doesn't explain why this change is needed,
> hence it is very difficult for a reviewer to understand why such a
> change is necessary.

I was trying to get the rust compiler to link against libgit.a. Both
Meson and Makefile produce libgit.a. No changes were to meson.build
were necessary for that to work, but but with Makefile I would get
errors like:
relocation R_X86_64_32 against `.rodata' can not be used when making a
PIE object; recompile with -fPIE
...

I should have added this to the commit message.
