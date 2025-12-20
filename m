Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5189156678
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766227947; cv=none; b=lM3jjvVAWMPJ7uGfxbHIXXN1wETMJi3RATWOijAcIgFxZk9o+KTeFUZouYMYHuXu3h0DTyyaRE3pEo2dS28ckTb6BMBcv9lPwv49YeSRMbLZg10kqVxm/9B3xEv9DR6xSf0jFoz1UisLbiRUY4bTl0DL4KvOW41a+ZECVV/ASas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766227947; c=relaxed/simple;
	bh=wgAz8aM4bu3/Q1RiAPiHQAAYYxBOIw/nWv/Gn+qwkUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XfwAJJk1x1TFuCzkxE5aqaT/HY9qqQrHuf0RyrUkdZmIzMVHh2QHVCDkwCVRtJx/gIDrgjNmwG+k4bDaRFd7pwKJWlTUVCiiBBS6VhgQ1mwZZVnuTeo9Mb0JwXN2wxktM4q6KprNccYoLQzLGngnZChZGOVQdDYAViAeUpwGtMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUmXqqVN; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUmXqqVN"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-597d712c0a7so2640720e87.0
        for <git@vger.kernel.org>; Sat, 20 Dec 2025 02:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766227944; x=1766832744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgAz8aM4bu3/Q1RiAPiHQAAYYxBOIw/nWv/Gn+qwkUQ=;
        b=ZUmXqqVNPcaubcstFGqdvdMGPERzHETPcqbGODVCM3PGdU+G6X0+oXYxUkEIIodCaS
         0sSpyYXMDpceP/wtU+OV0ijFjp7FLjd4ijkCZ0kcRl7xVgK92PFi/rOQqIrADywiraf1
         8R4wQKbzAAKJLGsv6b+/T43RSc1Dr9QakB+oqhTf4HD90+L+ez76/xVs1ecDfLJC/h5B
         KCV0Jd72fgRXqkm3pZ3FS/BL2D7aq1nbuqsjj7U1cU5sRU73zebqtKW/hX2lilBZQAoh
         i2ElEyR/ZAJx31xxBgjTiJqcDHQU0EfzwXmMNMbyT0MEzSMvzIZrw+K2fuY8B3PjHUnQ
         +dKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766227944; x=1766832744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wgAz8aM4bu3/Q1RiAPiHQAAYYxBOIw/nWv/Gn+qwkUQ=;
        b=oNjgOkSVO+a6buc0THx2Ysg+NIZ7dV0g4gAnuEfNrhymTASkwUAwd7e7pAU50VSWml
         J6GBMSaY8SjbgyM5oktyw2947qxAIP8ies9ai/qGNhMpnzTDovCekM3DQi9Hi9qr+6dL
         QwMvwluBQI+seKeBJnTMEnS4zn7mpAP4Xz5+J52YTqHWT1rU2BrfKzk/qsSt0s0LaxJz
         7QGBxmMOsybDGAo1wrPc4/Mi3WsvpQIhs3eWlalkD+K3ox98SLQZ2jzoxQZ3UGF1EbGw
         +cSoGgBxTn2gcq65flNgVZCyi/vSKDP+/ERa7TVmUwa/m6N3NBKiGj0AUgMIGeqLBlRp
         bysw==
X-Gm-Message-State: AOJu0YyWJdUInGUS8bfMfy9l31WMY3CR+H7+1E500k5NKEMmsOVNLvPx
	L0dK51utKXCwekLQPqnBxJJ2Btp1uqM6yuP78+bjcddwp/YoijXbZKtz
X-Gm-Gg: AY/fxX700N3USM9XUc/mkSM3VT5FHCaD5a3aPMoOpNgGSLO5Ml2uk+kishScNOJCVIi
	4FCctRY7fyfjuO4QKzJTkZRk0a4UBijkzFpl41KZgmOX8FwmpeDZFBemCyVu0gDTLs3PBpXaieM
	PPZVDuS35btyKB/42zkW3OWOArsF6yhknFpXwIDHFkTi9qMmGQEzV8/iakTawGkKgPcems/w5h5
	ioY+KFMYzZqzII3V3ofCwP8d586uu6SKm3rb4mn61DZph5N5GnIBkpMME2RS+/rgulcQFrQ1d18
	Xjq6XyWChW3SY4OqqjprP0NRLqxhJLcEiPT4CblyH/vWMJkTnFUg9ziEO7cLdL/dOb1voUhCei8
	9vEi0mHOLfbyhZ2vFqvu7LgE/iC9Mlzam/t/yuMldbkUXxdGEtYIGpaYc7fj9VFkJGDRJrDLnvt
	aGYqmFS1zqsq1u+ZGdXfpEAUZO+xyN+viYb9IoaqqBobNUaxEPqTRxeylKL0nNgU1UU5BalRQ=
X-Google-Smtp-Source: AGHT+IF1BP2YV3WEi3+NnkTzL/SYT/4habEkg6si8iOdIk3c94UqdvzDPghr62qg+jAoFWgb9vKM7g==
X-Received: by 2002:a05:6512:e9e:b0:57d:b8a1:832b with SMTP id 2adb3069b0e04-59a17d9a2bemr2058917e87.24.1766227943598;
        Sat, 20 Dec 2025 02:52:23 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5ef1sm1421633e87.2.2025.12.20.02.52.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 20 Dec 2025 02:52:23 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] diff: add --no-indicators option
Date: Sat, 20 Dec 2025 11:52:22 +0100
Message-Id: <20251220105222.47651-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqzf7du1ut.fsf@gitster.g>
References: <xmqqzf7du1ut.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> That was why I asked if there are precedents, either in GNU or BSD implementations of "diff".

Hi Junio!

Got it! I did some research and it seems GNU diff has features for this and BSD diff is more barebones.

GNU diff has the option to turn off +/- indicators with `--line-format='%L'`, however it also turns of colors even if supplying `--color=always`. Git doesn't have this option yet, so maybe it's time to implement it, but be a bit smarter so colors are shown its a TTY?


Harald
