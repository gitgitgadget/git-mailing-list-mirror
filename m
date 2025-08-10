Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9351C6FE5
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754840194; cv=none; b=TtT+/nvFhQj6pY/lrIgPq2McAHqwKuqpBu7FIEDPZy8nKTbia6CS+ARLUqIqFOhHRBvW/JKbizKoe723IWmHEK38bhkITYGG+8UFeO9l8GbEQpCaWBHcNFwa8X0xHfyG8HwRRFI55nZraVXqh+X4pJ1enj4ReUoDDqxsiDL00VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754840194; c=relaxed/simple;
	bh=fO6C7SyaLyTUCjtq28aCgHaFhLcLEZzu1mIoM2US3X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMP5qOaranwmKh5FgS+Nnk9/xktC1ZGIXj0INN94nhHYtfiDFyQYz55bSJqteM10GAhBg0lXSnVO/36j2Asoy2rq7iMipO/NW3XsAzFu/Er/HUJJc/MDnbMEpauK+z2HAKFG6nUXEKWfCfLaD48ElXXotBFgtQTUdlVjpIhFNIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bk8YBoNU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bk8YBoNU"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-321895391b2so1266231a91.2
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 08:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754840192; x=1755444992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fO6C7SyaLyTUCjtq28aCgHaFhLcLEZzu1mIoM2US3X4=;
        b=bk8YBoNUDP8HB9P2yjn2+8LlrWFAT2h+CNw5r835uchdJ/ps37wMTEYqIXFwor9Db4
         4K3UEzmh6N91tt1Ktb1iMc85GfR8kBTNerK4T/M6GIZdYwrLtE8RdAVCDkwDdv+cNaFV
         tMSo1y2V6pLN/orviaPn58dnQ3rZgp5PhiT3wlPZdIn2LBk9i1Z8xrPwLeCiGpiupKGL
         uA2Blt6+5uLMTjUekB/q7GtEhu3NCt7MexpUfRlU+UY0PtxJVIcDeBmpwvyWc/V71fcY
         elHJ1GlYk9R8/JIwneYriiL7o9a4MEE9PvXT1CbT8UEzV2uXb6hrAN3P922GAa2dEC1F
         BzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754840192; x=1755444992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fO6C7SyaLyTUCjtq28aCgHaFhLcLEZzu1mIoM2US3X4=;
        b=W4QKDtNeqnsNS5wU0qh60z9ZE/3LuKby1LEYuj0M3vK5rKGLhp+qISJWOUu5Jo8E3J
         cq4YR6JsJNEd8qa/yYLJ9JfKJLRrpr1CcdZ5EaL2T9q3alnJATvmGzpCYrK6ahb6A3NC
         eUJxTIABsfWN+OnnbCMxfFKFMkFhBOVLcaBvmEC1sGpZ9hHTVlahFrSkKvxEvFLDJPRL
         PjY1yCYhmrnEsXagBUdZR3a20vdSx/OCkpJZAF6JHUQ1BeBnGytb21dKBcvFzFsvfoWY
         fQxhzTNH+uwQsKyx0yGTvr1QSUMw7UvrEPB29awEIhqpaU2ksarvd6EJBbSx0trEQyyo
         GrSg==
X-Forwarded-Encrypted: i=1; AJvYcCX6xaq3H9ZKDLL0JRWn2Dpr49GUemoRSBzT+AfviUgET0fsSQoB/0APC/dc7he4AGH1g14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKujwwk0TNIlibdFZTMxpB35seXGPtbJND/+lnjxsMpscUMZDJ
	RmCGWBYolOTRnfwKNZKPlKB5ojQ+T4+6aUmJY6dLgtIcquy/K74ygCInt8Y69AYusZ7RwaVjf6u
	hInJh2FWmxpPopxWweJX1lm0xi0pszKSEAoIuBQg=
X-Gm-Gg: ASbGncsmAsQu9TONy/LA0nn8o/GXbZmZKsluRxi5OdRgMmpvmuHOliX6/OhoNir1+Vo
	J+w9foWVCye2KMRGutSmzIHONW/mcq8ig/h0hXvRskjGFEZ4pC/kz1Rji3g3PJygbyBqgDRWiJI
	SFEVxb86T9EnJfMnbT9tXh2sXr+zIjiLpr36Auug4DUFtqVkJpog+jumac9K10a0aohVBC/mG+z
	eonB652dAmRn4mZEiimDdoKEyy7mixf/iM=
X-Google-Smtp-Source: AGHT+IHyAUvZta2PjD2t8pqaO1Ys7XMNU5hOFYjpbCWGvGJiFHiPPRjMwjdMW2+27dnvBpc+uBJseOwIY8xpdMxFqtA=
X-Received: by 2002:a17:90b:528e:b0:2ee:d371:3227 with SMTP id
 98e67ed59e1d1-32183b437f7mr15424159a91.17.1754840192112; Sun, 10 Aug 2025
 08:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603131806.14915-1-ayu.chandekar@gmail.com> <cover.1752882401.git.ayu.chandekar@gmail.com>
In-Reply-To: <cover.1752882401.git.ayu.chandekar@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Sun, 10 Aug 2025 21:06:21 +0530
X-Gm-Features: Ac12FXw79ybK3wOwxT5mKjFb8zEkIqR6wDnGdVnHCnJSwftNtItMJwjxsOh_ldE
Message-ID: <CAE7as+b2QKcPVnyEupriK54bMSSxdRAmSrMZqTvfq_KabaU-Ug@mail.gmail.com>
Subject: Re: [GSOC PATCH v6 0/3] environment: remove sparse-checkout related
 global variables
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com, git@vger.kernel.org, shyamthakkar001@gmail.com, 
	phillip.wood123@gmail.com, ps@pks.im, gitster@pobox.com, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"

Just an update, I'm still working on this patch series.

Thanks,
Ayush
