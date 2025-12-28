Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BEA2417C2
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766913373; cv=none; b=Vfuw5ZKedyuK6f9tvHahnfxfU/mHXAJoyXwftjJHzE9osVmzkP/zFMh9NHsPOlUCeQt+UlAFKArw+WCXz2LV1k/YfkeEVsOMCvsEURpmzaTI2hZ0FxwlhOSlCA7ESrYB2h9I9itzW3YJD+58v/D0I6Kif1zBRJBXaJFFlwEoSLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766913373; c=relaxed/simple;
	bh=F7rdMJ108U55hcfUJQyJtFaPGIK9Uv8n36o7CVAMuWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ARfyBGDWURByjok6NQKSDMswfDij9R0Bu2lPgy4duFPDN0UHzX1wFNgamSbzfweEGAfOQNjWZVRunk/Sgr7J3xVtG+Q+E4duiVYqi2YBaLhEPwQdsHdVXICZtOrcAk4+mOhcbfXnQW6UbbuKD7HqGBdqvEgqnA3VVF8d9diSkW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA8E/40f; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA8E/40f"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59911cb8c3cso9165639e87.2
        for <git@vger.kernel.org>; Sun, 28 Dec 2025 01:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766913369; x=1767518169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7rdMJ108U55hcfUJQyJtFaPGIK9Uv8n36o7CVAMuWg=;
        b=KA8E/40fJndBBoOazJg+Wqe078TqDI3vzmRuSzVIOgz11nMDqN84q0aBbOBYuri/7C
         d55Dho56YX5ZYdlMh57RISejW7cTZU7bPGLXJ61R0eJumBfyL1EOEFJiHI3Mz9vpQRHK
         oR2GjO9ukifIwSKZYPD15HDnICq0W5yTcm1bp1vqTlT5NZfAOlxJRNK1TmEh7abzlJ0C
         UybdQ3QDPQf53+VFDQGeYCmUKSlE68WBcmjSZ6eHObfCWhUfxrtkeNRmlLP26ae2yK34
         eSUJhYkJeLesqFOICvEFsgB1R7pNUH2P63JlTv84PfoRRM8zvs6rRxLMnOEPgkP5j/xK
         rsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766913369; x=1767518169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F7rdMJ108U55hcfUJQyJtFaPGIK9Uv8n36o7CVAMuWg=;
        b=Xi8hPZK2TqD84xi0D1hAID4om7RV8z464+nV8wTX7qDcmyGslb2fKbQx8XWUqp73MK
         nxPOmIhnWDHZ4/GWBkAnJvU7bJ51O0DRv8iKl1WSfJGsgbc7q+CYXG2qGksHToeHL9NQ
         TfjuvgD/QwbOjHie3OPA3L6sos58ik72mQDz43HEn6XhGEQscfYi/dQDr+cJyq7u1zIw
         21IpNxZLDXfkolcoybQK8d2IsASC7O1KptnT/GMw+RATHC1jSu3BDo3Ru3Ggq95z66w9
         zs0yR3cx7PgQbhVoCsscD/K2Hkqv9vG30zi5StpDEisjWuZLg60hTi/wLbbhjQdmL4di
         FKTw==
X-Gm-Message-State: AOJu0YzMeL9ehQfR4bWh8+Ffn8eZSnwgdQwOZo2oS1j5SbL5Kb/aEgNq
	ALcIm5NIgfGHpHBwa/8X84juBnB6l4GqDD+pSMQiebWaQzcLj4SkEJmf
X-Gm-Gg: AY/fxX5jsIcyS0tFbrBWh+IOZrZJmKHD1frOxAWlW6qw3vSZuOJaekEAsQ+DvO90n5v
	WlUVuHtWlPGtmctRgKxAH7pC17u2icj+nz7Mdnjfqyi1N21wxcW/4XmB/T8333RfoI8PArMdvyA
	8CXuUnkGkogqTXt7/z6apgFD8T6VaisVcizKUYSKiGFOL7x5ed7a3et4CIYaCLHkJmD4MOxNoq1
	Wn0CcUC51PRCWiGpSEMP+l4kcKT0Bay9mSB7T9bV6IQ+ROCP/4zugedxl4D3VXpoZ//PO8CBMbu
	f2jnciNRiFZUNdXnMjXRopwmXNtA2lnsvJ105ebjiggv1IQrx5KiMZh4dLbCj0iQ2WncAnjl9dy
	gT+22I04W3p2YVNGfzY3t3h5AFDnViPHZ6bqwgU9XhL/E50/8dcl1fmETU4Vo/nKb8wnkbSvTjY
	Nz/VdR3KN6FBR1NVZupeOUK9YD2OaXOjhBJYLyMBvHfg10NPwYQit1a+5CFatT+qaUZCAP2bE=
X-Google-Smtp-Source: AGHT+IHiNt8Bsvqz7Yd2wKta0AdGfekJeWUJCFOFQheV2my31KSpMcjaXlXYHW1cX6shUdRV5wp5HQ==
X-Received: by 2002:a05:6512:2390:b0:594:34c4:a325 with SMTP id 2adb3069b0e04-59a17d66a47mr8973201e87.46.1766913369080;
        Sun, 28 Dec 2025 01:16:09 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18618a35sm8287972e87.66.2025.12.28.01.16.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Dec 2025 01:16:08 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitgitgadget@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ychin.macvim@gmail.com,
	chris.torek@gmail.com,
	sandals@crustytoothpaste.net,
	haraldnordgren@gmail.com
Subject: Code review?
Date: Sun, 28 Dec 2025 10:16:07 +0100
Message-Id: <20251228091607.14896-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <pull.2138.v8.git.git.1766666006561.gitgitgadget@gmail.com>
References: <pull.2138.v8.git.git.1766666006561.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

Could I get some code review on this? Maybe it's ready to be merged?


Harald
