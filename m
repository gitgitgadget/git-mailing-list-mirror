Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64328191493
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206507; cv=none; b=rkKGh3IdrPXA3jrWxN7rxwpUfklPAA1jl4btOG+XrK7bfuWEjtNL076pY88rbMU3nxBOrq+tqywETSoLI9vH+kwlKEvAuCXgX6D0mXrJEFjMt4N+ul45KwNliDdynR6ubCBA4NVN0Tsfa5T0dcm/tvUeOEp6PqzvtZHkJFMujTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206507; c=relaxed/simple;
	bh=MrJiiAEzpflU2U97t0hybLdlEy3Hq6q+yTTsOtDHlmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FErIZqoXb4R0Si3BZRaLGSun/iE/Ra+cTWurZT/h0lgDPRlhOVGQ3Gs8HS4fX/IiRMZGM5Xo7pdhHBkyUpw0zLaseexRXCX9C2R/HafahnY8P1SsORZ6b/MWsH9kXIUdVlv7Ntct+k2dBPSNdksZWK54oeJNT2jzHP9izCka3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEoPdpV+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEoPdpV+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2349f096605so66694055ad.3
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 10:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753206505; x=1753811305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e+nihSqlUQ1Xq2FafczO0iWubG8FnrB8v2HGx9t8Zxs=;
        b=UEoPdpV++d1HMa6D2dsrXD3JO5pU7qqhPoPLrtf/KCl/peGtmcIQEM96L/QKCQ+Y9h
         V1x0y7BTFD0U5H1RM40IAw8eIJNAMWBrWKXiC7nOi9KmwCMhYnFCWNqRdYd1Io53ATqx
         puZZ48dDstAqNgA+PhcvKUa/HFbCpbr+svwbhxZW78i1TnWTUDiOS0ym0/33OXsNAeKm
         KeASaw43z01XxOL4yxjMZkWM4MFpIkRpchyCaEdbcfmabkXDfsMvPo73xUdUupRfjQBa
         y4UfhFd7LQdcKvSOO0Zu+Q/RQckTcwqIZclAayOeBqeuLkgpWe9MlvRAA8RegAYFakKl
         m86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753206505; x=1753811305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+nihSqlUQ1Xq2FafczO0iWubG8FnrB8v2HGx9t8Zxs=;
        b=GAhb90SXyQPy9JjoKNGGT98hHCKl98lUAsGiT3eNhWH2GznKOzNk6wmLS/f4YeqWrV
         MBXNeBKkW+S1DCHrFpeOftJLfoQngqoWGjTZAmszEfKqRn38T/38jv6hMJFkb3CO2iOS
         8EUGt6IvFT9VKEP1D41mbWFMQJ/DwtFF+ZqhQibaFIw9UWL1lEN9McIPuDp7m8GdISuR
         SrOpbE+XuBcVSF/Jva9erUtllTlJPZydfd8l/k0nR0pU4rqz4VUEKbAUnGO/MNwFrVKU
         W0xcvl5gkDbUo4idNZ3HAIUjMkqGeNaul8iT6H9aRF6kBlDSsll+bjl7FGZmBz3uJSoi
         S4lg==
X-Gm-Message-State: AOJu0YxfrubMjOsrhf7QPuPmlJ8qa0kisYJ6Cw8kWrHJquEKdb74g6+1
	UgBIqr/lMGePm5/GK41FjuTOnJJ1GqjBUfoACjw2d0aJWknvlqLGr7pgG8v49g==
X-Gm-Gg: ASbGncuyW11SG5awEmyVupnzxeDibJq2He587jYYSpbyzx6aiN12M2Hp6coD1wvxwDJ
	KWk2XOscIEi+nz8AiIQ70p8yWTt+e4lnyJPuNlIiLhK//+NlKpYdhj3J/uAhu1M5512B4pRgmN+
	qoWESpBH3NMB6DX1c/D+4fU30SziU79zk5YnqQkSf+Sgw7Yd6DlO59TURWEUsJRsgd6fOMrYUzm
	Cv6GHkump0LHEp6I1zyJBWW2ym+XsEGeMVlFBqVcdKjT4YUat2JMM2v7B7RSx4ugcMjX7l0N0AI
	bIHdshRWrNaur4UJrSU+Jv1bBLPvZJ5MSWQxn1bf8RrobV2aeJ9E5v7WiEk5G3Z8fkXa4jj6RON
	o83ix8esATe7DKVqlpIJ07EgPaYZIj1mwkg==
X-Google-Smtp-Source: AGHT+IHZQoOfkVROsCXsi8M9pcBpZeDypPj8w18UpgmYe8MPz83r1FnxV3tBjfTkivWBCn9vZfjwLQ==
X-Received: by 2002:a17:902:f68a:b0:234:ba75:836 with SMTP id d9443c01a7336-23e25693676mr319443245ad.7.1753206505486;
        Tue, 22 Jul 2025 10:48:25 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3bdfe68csm79764745ad.183.2025.07.22.10.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 10:48:25 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH v3 0/2] fix resource leaks in test helpers
Date: Tue, 22 Jul 2025 17:48:16 +0000
Message-Id: <20250722174816.2125811-1-lhywkd22@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2:
- Dropped the second patch (`builtin/archive.c`) as discussed.
- Combined both resource leak fixes in `t/helper/test-delta.c` into a
  single patch using a unified cleanup path via `goto`.
- Ensured file descriptor is safely initialized and closed only when needed.

Thanks for the detailed and thoughtful reviews. Your comments helped me better understand how resource cleanup should be handled, especially when dealing with early program termination.

I especially appreciate your in-depth explanation regarding the difference between true resource leaks and stack-unwinding cases. The example you gave was very insightful, and it clarified how automated tools and reviewers should assess whether a resource is truly leaked. Thank you for taking the time to provide such a clear and instructive explanation.

Hoyoung Lee (2):
  t/helper/test-truncate: close file descriptor after truncation
  t/helper/test-delta: fix possible resource leak and ensure safe
    cleanup

 t/helper/test-delta.c    | 9 +++++----
 t/helper/test-truncate.c | 3 +++
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.34.1

