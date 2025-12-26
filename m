Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F132192E4
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766775453; cv=none; b=aWtJaAZPnjbtLDETVjTfAKpnMtCObXaRF8aROLLDB885en87I86ue6GPET4MtLNPgRwKHoQX6nekaehG5VhGJ7TJDxKCH4gHoZ376QCmssqLUx6CVf8w50jS1IJO1YzUCJaPz+wlrNpK5N5bTMFepoQViptqzAGhmUeJnWCWBVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766775453; c=relaxed/simple;
	bh=jomqV4k73+yIvk5O8Q1uiTLcpQhpVIMCbT9wqqnNoYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDyIw4yeVJVGTtS/3nnTAIF7pFMeTHtOhejZukuX5fnZlMfWTBe9m3MwQ0OlLUNin5WggZ2Gdi5HmaMOOQtxm/AZtDXo84zy7YUeorOq8Jdaw9MU8AOsdq2V6qXdvL2yANEdk4TYjENZeFQpdA7pVcr/F8tE521Gi6ZWB0spisw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1S78bJy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1S78bJy"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a099233e8dso61394565ad.3
        for <git@vger.kernel.org>; Fri, 26 Dec 2025 10:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766775450; x=1767380250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jomqV4k73+yIvk5O8Q1uiTLcpQhpVIMCbT9wqqnNoYA=;
        b=c1S78bJyX3y/MbRTLkqnMbc/drxYNCcDiB5sM5x3Yjk9JJmZ6jp3VTP2tZDvZtjZRj
         b2UEnTah6b3bo7OFw7QbGHGczSF3gWCgyxDC3ezms330xGX73nbYIfM6a7zAsYubM+x8
         xw77chT5Ujyjjq8baQC1FrKbQWHArsjwoRoV5a8uxOCoX4JcB6WQmjpOn9YTbmuwHejt
         wr2u7h9ahQY9hA3l4X27XgVJZc96FgqJu2abDtO68nqj7axc1vDiwwTCZbLzI8DzcI5J
         7sC8WJ3R7cxzI357uDcioPPO2J5XUYs8goZFnDv6AJPLvmmGX5DcnwvA/oLsZm0+OVNa
         vLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766775450; x=1767380250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jomqV4k73+yIvk5O8Q1uiTLcpQhpVIMCbT9wqqnNoYA=;
        b=auulH57B8pMJqhD3NOdZnY1IfA76aDANLeOsy4QVYm8XIDxnhWymcjquj7+MKPt/pe
         Kbq9owtxCQKYLrK13NEGa72UegqkF+O6IWUkVLhPMRF3DWzsUW7QRymwI6nTn8pyjsQj
         xWhLcB8wPPzcfkCKrGn7zvRhCUeS1wj4YjqX2r06y/ssAfm73GLDjVQfK89+NG6+Diwm
         UflVXKROFr2D9v+iTO6EPCf55MRcbQN2anXjhuUEZcHI192XxtAxlsp0mQUyAh5mgZzZ
         KrEzcWDJ8RNy03CJYZTJ1aBrV64k2xwoUHUcFYIL0Oknb0bkkyspDyoSo62gVaAUtGev
         7ZwA==
X-Gm-Message-State: AOJu0YyDaay8k0INfWIHYmXPAk4asVm/dmBgaJ6u5p64eNloPua8uG6m
	86fTE+RQ8TpgBExqiF3l+7xAIvlDtDv8bRO1ck4Oecn4iWYWEj1kHtxw
X-Gm-Gg: AY/fxX4qizKw3Qx+kQLvTAq0GQzxTmWFd4DanepfwJ8S+BP/xbhBq4mRimEbbvn27Me
	aGZWliyFWu2e8qH5T8nK4K12atf1lf6TOU40gRmKMEm0XLMQvK30WL8qvRP2pRJrVg1+ivHPhKV
	29DHtsiO/ra4rP+Ja8h3ltV0mikT3X8R+f0aFaJNtI08+bfGu78D4m9+vjiPgU+iD/whYmNlazy
	MIYR/rdVikih/WPUIw/QJyQBfWJ5yiFN8tmZF6CbjY8Gjnl06Ye8MGdCGRjwfS5aKYqM9ONAZKs
	CUNYWe5CBJlaaMmirJy1lCUSTP5ZD22sk0za4NJ/hS0cnPu0wq/6rhuWYUYmgEHH2MkRw73utig
	WOC9dlwGrmppXIZ9I5tEknEA0OveRsCEXm1EpnYf+rJ8NJ3aJBgKwC72HSwHvY9wfFMO3BmHq5v
	fg/stUYneixFsiv1497Mqx8BwXDVP7ju5QflJ4LsS083fkp4rXIuk=
X-Google-Smtp-Source: AGHT+IFO3S+ArbXSjlcNDYm+ME8hDT0eCEL8g63dl/R8H9kxJDbbPBmvcD9cvOqVyKOKQ4qoW6ycaA==
X-Received: by 2002:a17:903:244f:b0:29f:3042:407f with SMTP id d9443c01a7336-2a2f2227091mr225271995ad.21.1766775449854;
        Fri, 26 Dec 2025 10:57:29 -0800 (PST)
Received: from archlinux ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c8279esm207528675ad.28.2025.12.26.10.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 10:57:29 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org
Subject: Re: [Bug] With "[remotes] group = a b c", "git push group" does not work
Date: Sat, 27 Dec 2025 00:27:25 +0530
Message-ID: <20251226185725.51201-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <xmqqiki0ivgy.fsf@gitster.g>
References: <xmqqiki0ivgy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Junio,

I will be working on this.

Best,
Usman Akinyemi
