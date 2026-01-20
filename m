Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF511335066
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768898153; cv=none; b=cNlqNuALYu/xcQ3SMx0ayzVOXlJ4jLYIGf58iXkVcwvmtiTFlDNpLTf6Filxr481Oza611zlxMOvYuHz2uC45ne901j+60OXz6FPVwrbGwas36lJEi5nI3MbuEq7etm8IjAxXxQ5iBKt1LxSpUJ+pnBWvyxcpa73M+JhN8vyCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768898153; c=relaxed/simple;
	bh=52wspkaYb/xvEn6kM7yLp4RUzAoGxAGY1afjgpW9yPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWfqhp9xIv7QZ9gmdFs6PUtrpsAzAIcekEh9knmC8XI5BiykUiorPKv3p6N0VWvrW8icGO8FkhjuKGBMWBC1AVyn5iQFtdcqOEyd35d0cU/+LQDFjtjWSPtHsAiZ19fFgVCyHVZRMoDIAseN4E0wLxUb4LYQ1JM6A8RNpgXnC/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mwc+WaFU; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mwc+WaFU"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3831c18b23bso39992301fa.2
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 00:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768898150; x=1769502950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52wspkaYb/xvEn6kM7yLp4RUzAoGxAGY1afjgpW9yPo=;
        b=Mwc+WaFUx7p4fSd6QfWk8lx6F+0LAuhlh8drMSXe2sQhyE3J2/Ry30YB05/0O2BINy
         mft1bRmgcjjsHAj3uY+Ri4ZYDwg+0iHtm/3z9RgDI4glBUs0sQL9FP08jwBLm3HVbOHd
         KId1tRDaJjuyihbtV/Z9s1ZKDHHJyBDVLLCDS+oaxcIm0zeNkQKlnP82Es3LxGtXW6Aq
         103g8LuUxc3xHn2uajcc3xffexymQj4IENqwmdgympxeyHyKrC+6jmCVrDpGB27xe2+t
         22lYTu9zC5rf1xTzJU4Mw4Lf+161mp0JL2nZqTBq4/8J/Vmg1YIEdCqd+I8dZJKtNSDC
         PlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768898150; x=1769502950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=52wspkaYb/xvEn6kM7yLp4RUzAoGxAGY1afjgpW9yPo=;
        b=UY6e9T+4Q6P25fQREHu9+XQPbZ7sZzupRwWoUOlaIK/rXaZ3XKdGqIoU9/hpMe7Kq/
         VTekiMWZGeosEULIKZUSCsrBzhbCTgfpENxqrGY9p09qv6jeGTPxdkDWl6gfAgWajUYk
         d5WSSTMcr3dzaQ7NY494aG3jYVhoItJ+FpsGIA49+4hT+md1/zoYWeR3fFiPwTnA1wND
         bGhHzM4aqWnG2HBcSRV0poyLbM7AvRHF+R7D9O9ShDrvryoeeFnLF+VohdkAHNY9Ceoc
         Sc4KG7re5S3Q91nhdPOVYPPhPqWTHwCo4nZf/rD5gZzESo7nys6ZoaNlfR2eUSwUNqzh
         oZhg==
X-Forwarded-Encrypted: i=1; AJvYcCVHalETKaqF8uMvv6yrsVZSvrVTfcwehbQagMTalYzlGUZNg158shcVvyfZWolOGteSTeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYHLKwVmZ4Bm4XVqGAzOvZNLkJtriqBwMK15YVKwxxI4WaedFB
	LJkW1cUylkrzaI2uByjm+6siDDgdaJ8/S6w5A50IoT6Dfz8YWVgOiofK
X-Gm-Gg: AZuq6aIIXT4bjF1SG/P6LPEj+v70AkfbSI781HeJtuOZXRcBymxnpcZq0eaOUVCR+zo
	yaw2z452Tdw6XH9jyOYp+mnb6qfPEyYTwDgODUabEiGQpgWvDQqxNYozX/v43b+mBeCTqXUeGnh
	nNgtiLYuEdZGMnygD+2BSeSNTVQ6nlSIWbOxnslBBY72ygvvt/m5RsBISGp8UnMPNRNonVhWrQw
	ZLWtniV7n3qYzUMo9Qa4co/haeNOdGj9dtlZ/aDXwCXA4Z44aqtCTDRM0GSgg7hwoXxv+lAxzVI
	ACpGGDyGKcAw6w1yMUVMCEfaI1bZ5fy8YZ54E0tTj/rGZm/78O8euLw9LS2VZDnxzk/XPpCIS49
	oAC9inGK2/qitMMkz/nugsJl81KIe/onGrLDgMQTfVwlroNYwMjZMMoJkUealn6IdsZLuuGzazX
	iBFKaEqTy+5w+WoM1a/9Sv4v5mnmYd3gjFanGJQROWPqskIIcZYd/gB9NtVdsThF/FnFlGATci3
	PcDDvitE8w7D9w=
X-Received: by 2002:a05:651c:b0b:b0:37f:cf97:491a with SMTP id 38308e7fff4ca-385a5400edfmr5987301fa.7.1768898149452;
        Tue, 20 Jan 2026 00:35:49 -0800 (PST)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384fa3b74sm40832921fa.42.2026.01.20.00.35.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Jan 2026 00:35:49 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: chris.torek@gmail.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com,
	peff@peff.net
Subject: Triangular workflow
Date: Tue, 20 Jan 2026 09:35:47 +0100
Message-ID: <20260120083547.60416-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAPx1Gvdpyfcioot5V9Q8=Yg-aPSPeVKaE4Z2_Xt3-SZ2WhVMog@mail.gmail.com>
References: <CAPx1Gvdpyfcioot5V9Q8=Yg-aPSPeVKaE4Z2_Xt3-SZ2WhVMog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> I favor something similar to what Junio described but also including
>> @{push} by default (and ignoring it if non-existent), so that folks
>> discovering triangular workflows for the first time are easily able to
>> see what is happening.

> This also seems to me likely to be the right default. It's useful for a lot of
> GitHub and similar forges, where you send fixes upstream by first forking
> some official repository and then cloning your fork (e.g., to a laptop), setting
> up your local clone (on laptop) to have two remotes: the official repository,
> and your fork, both on the same forge.

I agree with this too, would like to make '@{upstream} @{push}' the
default.


Harald
