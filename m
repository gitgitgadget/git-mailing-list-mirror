Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE4750276
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768072024; cv=none; b=hc2Vk4w3gvzAC79+6lFB75Fw+fmPqXy0UDGq2oQUHIatVUlx+896tYS2TOTCdVligCDvvAZEDeleOLDhl8uy9KBWrutmAeIgb9AOyBDqe/ZKBzYh9st6hSKFS7AZwVpJu7yCFvX7l9P8+tDQ6wPTu8GuOGNs16e7TKS44tVFdOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768072024; c=relaxed/simple;
	bh=+ueqir27hjCHnU33ZsU30EI4HynjacgwK1m3ejQxxmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJ2dqKEqjWhz7FQvgPU8Fvlu3gAPPfW83EPTf+Kf8LtJYWZ218ibQSQEEFHzhiGc8zqzpTYMNAv1U8KrG7CHfyc3DTqABUuHt32/ZH1bQBaNHREeIp5K/v78KMnORuKXvZejE+GHHvhy992bceWDtNEjR8rDkZsfdhLk9rJ5Dfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOgXKMoC; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOgXKMoC"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38320cd563aso18886381fa.0
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 11:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768072021; x=1768676821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibZOFtTy0s0ds/8ppA9awBS2lXmqD6xRrD8fkIxBHQA=;
        b=BOgXKMoCIkGdlz752NuUvOOHMsTPLWlD/koH+8wg0PMkY4Qvy6OVUA6ME03YQnlz6I
         2RJS9gBHQYvyRW4QlgOQN/hmShPTYF2CpLDTjTivn2136BRBXjsn7dvSgYF0pOLnRn+O
         t8psZ91D24nbRRgwtH4h/fdRZSyyKCu3x4A+UkaBYvwq2rmKEVG2JPI/SZXeosiTctlq
         fO1uxz3wi9UM3kvGZ8pTe2qFoopIrjkvekKlTr/TJYtWgep6zdM7BNQx5Gxm32fr78BO
         KYQwDaC8+bmUwFW1FqDP7b/DjrEkwbjqPPuWZv0jC5JoJWUeCVma/53eIepV28Q1H1Vx
         xdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768072021; x=1768676821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ibZOFtTy0s0ds/8ppA9awBS2lXmqD6xRrD8fkIxBHQA=;
        b=iYqwCPwDhcyqdpi9c5HtP2o2PJ7ma+EAYoRcJW0IqLUVJ0Ern5WXJ8qmjWV2Oqzj2x
         xAeRZd55lIFX/MUpz6IuPjXWA4kC3s5JRGS+RCgy5TF0M0oU0oJ/vZ5rdixWB1YPi5f4
         4yOZHf3XcObet65pS24egRb/H/yAJ3g6ENXYEsHR2+n8ra24Z10HQDbBlyPs5dcDpsIl
         muIEfRKqTa9OX4t3RdF99HymyjOMlqTlxPU8OjBOLcSuYu1ivTMJt3XkP1c9LBQYDMkw
         yaAB3J+hKmLhKoV1XfnjW2BpwLPmcR8FkFEVqMeQNZGCoVr6cnAZShZbPTBVcb6SIEaV
         JkOw==
X-Gm-Message-State: AOJu0YwzPZfMSOrBe8LTXlbuPta0JeVRMIrNpltLSsZnHtms/5bARaVk
	2vDNFZ+4E/2G/N6wSixOHAZonQxN60Kb9qypWJuogG7afMtoEzkKTF1UvDd11w==
X-Gm-Gg: AY/fxX7IS6NuJyVYfd0jKdllPmjAp1wxCVrZg7lXangwZtxlOEs1VEk67FJLGcN+o4w
	r5MuHUTw6CXi4cjrx5ZDzouqmuR7O3Qo16kOtYW1s0t6aT9ADM5eiDiotIoxYJcqU1gPMIjsSdX
	PuZT2ZGWWfpF5IuotZ0au0jCIu7nJ8ZMOJJytrvi6xe4ROTdsm8GTjP+DLYHdO85X/sWtBai8hm
	z4bLHfvLQ5UdhlJhm+u1VbkOV5iZyBtgKU2FO3cZgNsDGha1yZ6UfCimFI9L0GBvuWN74fRQEWK
	GqWjtPfQsHg7pYonTwD0mAg6WiMt5W56Wtj6XV6HvuN/x06Pw3IG2YQoyEFYyvGvmDPRoXT1H8q
	Mi8KL15qD+PgUGuGiWkEJ7iw62eDZ9YE2z4hhiUu9CUZ48xrASWo4pbP3o99tHRGH4khGCDMQUr
	A05zupugzErf5xJLwIC5rAOhh3+uc7MV96R3CK3EnKN294ZzaK4nTPrwmL5dD6GTVk7MUc8NY=
X-Google-Smtp-Source: AGHT+IF0LiyMHyz5ZD/mxgDpNbNcQeFv799JKc2WVifc4DmrLg2Kg90UzfJw47SstW+lsANAc45/hA==
X-Received: by 2002:a05:6512:3f1c:b0:598:f262:15ee with SMTP id 2adb3069b0e04-59b6f02c042mr4572727e87.23.1768072020279;
        Sat, 10 Jan 2026 11:07:00 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b7025995esm2789470e87.31.2026.01.10.11.06.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Jan 2026 11:06:59 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v20 0/2] status: show comparison with push remote tracking branch
Date: Sat, 10 Jan 2026 20:06:57 +0100
Message-Id: <20260110190657.25872-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqzf6lqs9w.fsf@gitster.g>
References: <xmqqzf6lqs9w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Here is a place for you to explain what helps people to decypher the
> differences since the previous iteration in Range-diff (which is not
> very easy to read).

?

> Could you not mix the ours+theirs thing into the same step?  Either
> make it a standalone patch to clean up before or after your main 2
> patches, or leave it totally outside the series and send it after
> this series settles.

Got it, I'll revert that change.


Harald
