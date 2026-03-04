Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841773D412B
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648267; cv=none; b=G8nMsm2GafEfrEm8lb8Z3mjx+QOg6x8xy/0qbMkFud/CBPUd20mP8B5fCB5wVyvXh6M7Q2aMxVWPFlgApOD5P52dGcqtwzmVFFh1OkTVW1ZvIzV8sHKlR36iySachWhetqyaRtCM6k/BfFnsqmAMRLwG+h3unJmgwo7a90Fms1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648267; c=relaxed/simple;
	bh=jCMprtjJQ/qTH6d0YB4NRVs9Ulkw4gZrqLScrcXxRhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwL0bnUI2holm4QzXLxvfvKoiSpBeY/fLOQ45fT7VfBPcjMm0I54wOeOexcKw7ygs4zrBL66xpgkmrVSx5AEfoWnasIjaWzhRBOTwDsmYFEaieUXKX7p7Y0xQjRgNRKJWRiHG91rs+8g+Zepu3nC+oPOn/XtANWYqLAs/jIlYZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkMhGslU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkMhGslU"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8274843810cso4134891b3a.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648266; x=1773253066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCMprtjJQ/qTH6d0YB4NRVs9Ulkw4gZrqLScrcXxRhU=;
        b=WkMhGslU0g8ZlvNUA3FicN+2oXP6BoDk3yWQp4DyG+KyeoffAGdbetP0pKPNCgtYTX
         aKFKd+4kAOv7BQtGJ7H1SMAz165eBl3UEiMCUgo9YiDkP8NcBiHupARqY/Fnw7/90xMX
         qz6t/SfxntgcSOl+wnQm2dPdLMGE97JMDU7baWMabZPJfqUaAdYzXqcXUaAcXO4pyY4f
         lEbOofc7+1PEonWVJHzl2zB3HF8EHTDUcxdNfeFcIQMXOQheLvL33VjVcuaue7YXik03
         3Vm95VVTHOkQpTxX1F/3J2Y1jfV9CbezXXBz7I+dYkhLvNBtXEICj4rHfDEJGObZYUJS
         23Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648266; x=1773253066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCMprtjJQ/qTH6d0YB4NRVs9Ulkw4gZrqLScrcXxRhU=;
        b=hPH86n9ZrZp46hw6utzDY3KDZBWv5dwSWJfc0XLgivMasV89PujCatWdgdkEM3N9Is
         VG1SaY7j2YTmwuHXbNOyP6zreTN4oUqSTDxbZ7BWE1a1dJzoPikizMZ5glVYXcYd32Qe
         4YklWpLKEEkbkZdbRd7W5HDyEhYuJPg2v8tHuL5Ve/gDvcfZ59vwXFrB3ixRcb3MubjV
         roEldidMdawcVqq2FI8d3AVpwETyatnZojP+dbY4Br9WGJWgDInVRuGpzawjgPILTmi8
         eA7yAQj0sKFZN/3mhWctAObMyN+9msTQ6G5G5oH370DIrZ5swGJiE2RE1PTvQJA5x4mB
         W8WQ==
X-Gm-Message-State: AOJu0Yz+u0EJv4w+MDpoLh2mC1JkW3p4ztiaAd+2HtmVjBzVlAmyj2XX
	zD+B59hx/xE0V0TjvF0XftGVIAk3tQWFd2eJCZXlLE8C7IILMQTJ466nsPNkpg==
X-Gm-Gg: ATEYQzzCyIK57EIAPsuQQkPMrNmNdN9TOqO2GSfh9AtAxhfaJDDjJY532mUT55VZ76L
	bELDo2r3edVQ5BC5fsCVRqn5ODrZwVJP66VK7xZ3SawbhO/BzILfToKTEpgFannJdXpFVl6zGhA
	hKI2dAXuWx9AHGD1zuuUQf7d+JWcrYRLC2aQg1nltHGcqveYlGj0OyTg3i4cQgy5SJFg0Apz5TG
	AWwV/4ORkayrX+B8roMOwzpa2uoLxjlsNKwSETT/KIA2CMxzPsWgQHeyP34MvvdMVaDPzO3jej+
	jU77lrniVEnJjXjrClDjMcg92fs8PeaVVKuGKPTQPm42iBGZK23pgdetdeYM3PXi8klO1sPKL4b
	VCxRRi2xubLjvgf/Vv61/fLiDRNifqBy+3t9C2z8dOc3F/b+XL4Xklo/W2n8uBibM48v89Zei63
	tw3vxfEWEJWzsOc/S093ZeO6eN1Chwe1qoMJZTZ8nS5pGnb0Hhl8A0JhkyiaRE4hl9TNSd9ym+z
	7BzTrSLDA==
X-Received: by 2002:a05:6a20:5681:b0:394:6328:210f with SMTP id adf61e73a8af0-3982df078d7mr2524163637.28.1772648265676;
        Wed, 04 Mar 2026 10:17:45 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa8479aasm17785696a12.31.2026.03.04.10.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:17:45 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	paul@paultarjan.com
Subject: Re: [PATCH v7 03/10] compat/win32: add pthread_cond_timedwait
Date: Wed,  4 Mar 2026 11:17:44 -0700
Message-ID: <20260304181744.25653-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aafieD42pMaYsnRw@pks.im>
References: <aafieD42pMaYsnRw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Mar 4, 2026, Patrick Steinhardt wrote:
> So I guess it's safe to return ETIMEDOUT directly here?

Yep, that matches the POSIX spec. Fixed in v8.

> Wouldn't it make sense to extend `err_win_to_posix()` instead?

err_win_to_posix() currently maps ERROR_TIMEOUT to EBUSY, not
ETIMEDOUT. Changing that mapping could affect other callers, so it
seemed safer to handle WAIT_TIMEOUT explicitly in this function.
