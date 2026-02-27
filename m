Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C82355F3D
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173890; cv=none; b=qBn5b610u0KRQF5AMTeKddEvKjiB0RbHg1NO3UfFwEgvf7NznMUEUwjKG2QZ+GFDm2CcK5+ppfdpH/cCd59g1bR327r+XKaiWirEbyTwVFEYFk4VfAWTRrYlWqSA/NG9APi78FWBtjSvaapqpFbqFJHp8Of3R6hwE/cGZq6yWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173890; c=relaxed/simple;
	bh=uYek8nLlBkSBbBlR7PiEIFgjDiuD24mr/Gmr6nMB9F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bG8YTF5qlRn50F4QaEdJGTKElqfzhLF1scSgaAmX00fumXgxC2O5OEX7jvFroSBZ8mjQWPyILoRz3qD4FL+Wwe7cOimByf98BHhoMr2O1UOR02WVFzsHnOr4+1t/Z+531IQtx9n11XbkCahrUCcokbyuDY1LShKQBXorHK+t8+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IG8jWjbb; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG8jWjbb"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c6e2355739dso637417a12.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 22:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772173887; x=1772778687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBTa0ax37FO5l/n5sGjKfxuc3wNTMTI2sW6ZcSI/F1o=;
        b=IG8jWjbbns4cbFbwYl/E8Nh5NgLo7h65yJN2XMt9ja8c/+2IDrpwdFjOTGSzxEoNIi
         mkFLrxx3PPvTlb5xr/az/OB5KglsTxw3u4uHC2s2ebJ3XMnj14RKNmaJp6EpiTbbiZ6G
         TbU+UvmeLjuTx//lcXxA70kSwcJoikSPTqQaIwuGWlWsuaRlaa5BLGx8qC6mhbI+70nt
         lsIenv4CCNCRGowTLiAc3Rqhl4BR0/cnVKXzBp4ObIlQXBOUrePBrQF8Gv09lX6CNvPI
         FXHzuNVe36JCvKj/cMp/EwHbEpopep1siws6nDmWtgCHAtwvNpXrhQ9sREG9h82mYXcU
         MKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772173887; x=1772778687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBTa0ax37FO5l/n5sGjKfxuc3wNTMTI2sW6ZcSI/F1o=;
        b=OBvspLldB23Swe/CZ6j9bvj6zV8i0IZAyTSM1za7w6ibq1t6uLJo/xkNQD8OTPN9Cz
         fh6jdvx65v7674e9LHKUibWAHHwq+ENtJfXMOGpH3tBeusKXGMv0dE3OOlwW139vjYpT
         gxMSDCRLR5lZXoxokJ5RlOAwP8abSsYCjrSSC/ulQ0bMe3IWpQrvsWBraXMu3UulEUQv
         8SgDhTmDRpEaHWEY+8PDmZK5YFM83nFll4huBZAYZVtBnHPXDzYgPgrwHFYls3iJTwET
         i/yAYYDgeHyjQsey5D3Mz38J1BXPKKtXcdaSZDjrHsKba4c3OfodD63jkrDazo8IrjmD
         bGvw==
X-Gm-Message-State: AOJu0YzvKk5pJ8P4OSYe7rSPVlX49w0H/7/TsyHoE7Zt38CjO5JzpnaG
	MQKUy7hkG/8FFN2s0NZ8a+SKwRZArjQb5mnGERLAuIU4u51GamN+56trC+MnYA==
X-Gm-Gg: ATEYQzzmKIjLZfqmjJS6R1vgyKVuIsATmp/19R6Z/o7SOiqF5x6VZQuQHgynB3Hy0iH
	z0N05dlez4xPXle5rNMnq48FgohL2L+koTE3vsACoYVn4JehW1lR/hIs7dD/hnSbuOOaRorhcFF
	EUZwzKkWyAQCj/WCGTo2OM37xQnxqYoMFr7mIXlgy4XzLuTOfiNYIlgH1rss0DmasrfQQbQTJPC
	5o3EGDGWnDLRI0g0DkptyANwcwRjwm7te8GJR/KYP6GoYbctMVNDYKU89OwydTiUm8HF9rL4yYa
	UvqTpM0dfSEtkULI1NeHYzLfEcQ+ueHlYjGhw1cK9grhAyRnFCrYTbn0RErQMnLpFOH2jgds6KR
	j02o0co8t4Y/ywTgGi4yGc+bmFjUjhHHqzUbdw8W/bYvk1ZhJC/wVUzzlPAbANedOV3dIhALNeA
	EPidTHlC3z76aYHZSC705RBI2JRZrSplRgityZbH9njV6SfzmudNqutL8D1ARb1oIOYyJKVM7lI
	x3KRSuvKQ==
X-Received: by 2002:a17:903:11cd:b0:2a0:a33f:3049 with SMTP id d9443c01a7336-2ae2e3e10b6mr14555405ad.4.1772173887015;
        Thu, 26 Feb 2026 22:31:27 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c243esm48217515ad.29.2026.02.26.22.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:31:26 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v6 04/10] fsmonitor: use pthread_cond_timedwait for cookie wait
Date: Thu, 26 Feb 2026 23:31:25 -0700
Message-ID: <20260227063125.9111-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqv7fk8qvq.fsf@gitster.g>
References: <xmqqv7fk8qvq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Is this a complete sentence?  Or perhaps something like "see" ->
> "check"?

Fixed, changed to "observe".

Thanks,
Paul
