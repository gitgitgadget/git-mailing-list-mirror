Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D0246BD2
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767352842; cv=none; b=kYsalBPSA8cAcj7l5K43urxovbUJzyFSXnriKPYrBRt8+70HOA+IIIaIDdYZGK6Cj9+A8+uoIGq7q94jGlzIXxPbQYDqoyxNQl0BwCJFVgXtF/WNXB+lax+7c5esyzm9tZOdizWwHNHQMpDUhNicr7unI8enoRyb/H4IJ5VSZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767352842; c=relaxed/simple;
	bh=2U8mwDs1Y56DI2RKQ54lc5wR8+UNR/hSiIc617wW8WA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sR5d3Hv8sUHiNOGPsZGLnPxSuidnshX57z7UpZUQSOxILphospjx65DPJzrlAcL5BgG7gC/oDLdFPJWaPWebYkttwwMCDTa7wFUa6c4PXVVK2FDcZgWNjnUTcb3ox42jaOgBSWNmetrIguSQAm28Z39dNEri1Hz6rL9MKTqjnRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcIr6wW3; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcIr6wW3"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-598f59996aaso14255822e87.1
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 03:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767352839; x=1767957639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2U8mwDs1Y56DI2RKQ54lc5wR8+UNR/hSiIc617wW8WA=;
        b=HcIr6wW3vGzHzuOle9IgyCadRik/wQB62KRdUGMkofIUmHU2hC0ctavl/7IfhNl/YA
         TnLtPuXQHT5ENIq3xHvCO8e7B+rdcQPGlGA5pN/VRuOHZguBIXVAqw7HmBX3BNMw9d24
         ezZDkJ13BwGmLSHR5Jb/QR/hb+ZGC1Zx2Ze1LNkbwV2e6mco+74WeC4s46zM9HE4oIXU
         rd59UAYc2arYz7rLEGQuSmYcNJzEKxWMSkxyYNNh4f9NfVAPUnLlsqkIT04ZZpC/Rw6B
         3LiI08zdWz7RQaZajW54XOfzcB2IMp4bY9Ug1Hl/x1RaUgeeGaQSmtF3XZFFPPoz81r7
         mzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767352839; x=1767957639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2U8mwDs1Y56DI2RKQ54lc5wR8+UNR/hSiIc617wW8WA=;
        b=ZA54La7vtLZ9XFQOHi1sixGyPMxV+Jcp3mbJUNMWw31T9g/4lCUUZ3OBIX1+Q13cIj
         jWyLM8OH7/O6TUHSWeFgzDidIQmpLI9eNB3wMrTtyQ0lgMgq/kjmuJU/ieJhAHE+teys
         T381++RK/De75wkxtzJK7TI3ygi1adOvoTej0aA198ys7m3od26GVOS7BrmrYtdCuXkv
         0x64g5sWqsWkrjgBWg6XjTJFu+RYdjn1gJQWq41OwHT7RZv0Ye5xMKutfYswrqUZ5Yeg
         HqgDk2I/pHtz384Lu/Pd9pTqNeLYc3J1+ir3xBDjmwVn6XRXWGwOpbiOIcg9tGxK7jXV
         85Xw==
X-Gm-Message-State: AOJu0YzeZwlKzxZJkKaArue4B2Euq9+Ha64E0RQX6Z8cziOKjj4aPZEZ
	lgOaQURROCSCvBsoM5T//1A9LjVxg3EJjpvLCCAfivUnFIdTF8zxFGNp
X-Gm-Gg: AY/fxX7IMgQzxLtNaRpuQuHBdJVSesT2Bx+Br5fL24bGE9xtyym0/lq6tkrE1NYSLWh
	9g9P6otVpcYV2Vc9l1iGyEQcYJ4yQhVjrVAnoui6PAU2gRDjrXDPNNtUeuoMCHbiXtu3Zu0raBe
	KMq3z0fHxEeNSSrpc1EeCMmx39JtboV5bT4Xdu714ySO/xSxfB1SY1QORfkxNxg2akYFXb7PNRC
	dIhZS6FQq3JJDva7cKgIXBlDUrcAo0hZXG08nD7f3YcDMpFL9GGiFfpVYilBbjFIiFqSXp1aarc
	HOsxrNoNfN9Vm6pe27QR/q6YyQUP5iEb/UbXu0dXjD8jSbf43ISvHVjpREB9TIg6WGL7DhxNQST
	CCrZWVg821nd30GjYre6tCiC3v1cxRHQo+AWq+qMDAW/uS7DK/Nm1DSgPXPvW/OEMOuQBMfBWyV
	IuQR+mBgko6WCMUHLFaQTilMEJuCRyJ7kPazkhKd/p9gRriTrEiMuSXtvTwsNdrZJ2ivN/Ryk=
X-Google-Smtp-Source: AGHT+IEHzFtXZHkUF+GGbVJB2XDrAeytQbohVF5n1oRScHd/0dZ6gzQlWhChv6HNrfzzrtwPDChCMA==
X-Received: by 2002:a05:6512:ad3:b0:594:4b7f:f946 with SMTP id 2adb3069b0e04-59a17d3dd13mr13858572e87.33.1767352838635;
        Fri, 02 Jan 2026 03:20:38 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185dd7d3sm12068610e87.27.2026.01.02.03.20.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Jan 2026 03:20:38 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com
Subject: Another look?
Date: Fri,  2 Jan 2026 12:20:37 +0100
Message-Id: <20260102112037.35360-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <757d6df5-7834-4ff2-8302-8edd8e990970@app.fastmail.com>
References: <757d6df5-7834-4ff2-8302-8edd8e990970@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for an interesting discussion, always nice to talk about Git
strategy!

Did you have some time to also look at the code? Would be nice to move this
along if possible.


Harald
