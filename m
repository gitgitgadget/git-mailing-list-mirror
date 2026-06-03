Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547CD449EA4
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485091; cv=none; b=Qf3phyxaPcCcF6ksO94+Iw9oXGD5VHZi43IHwjRBjir5IZJsha57x/nRCGZF2C4yQekt7mWYOi5fuUHLqmpBPq2RF8QuBYE6/EynmOIq31b/1ViPKhfHs+zKRq+dyr5uGCCg5EuKCLBfDG9aY9xtOl40STyGD7wmnmAko3+B3ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485091; c=relaxed/simple;
	bh=ykDIQCrVX/qXvywUqdVdUs/9idBaA+qC2MSMJSRCMvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dzvd7bE0Lvmd+GKhXHgWybwESpEXNL8FAx6neBGtdT84LKWXAa9W0lTC4lAWt5Zlr7cScCpVwnuAdFfUdyquaiA9gAvffANEpiwHfXEIA9gntQr3KwbCBZ7/sdvGgxVJLrKoT0dc7QJmBC9+2MrgvE8u8OvPAzhIJvJ6hdD2C0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY+PbMKM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY+PbMKM"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-842273a2c4dso2963237b3a.3
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 04:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780485089; x=1781089889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GbVzViarSxJY8pa/SBXvqjJZvbUHdLtHAg1SR24dEog=;
        b=hY+PbMKMNaZfkmp61/Yr6FjFlEVwBDHwBn1B96n7okxq59QZPB4pX5nt5nzgqW51Ix
         F5x5OH3HdWCPWXLFgZ3PPjjlIbuDl3ezbxUsrZFVPrKICi/G4utjbrick2WwqYnvWcLU
         6yAYmAMRAI2/c0UOQs1ll3dcoI6VVZdgCqI7qGIFYz/0gVKI2Lk7z3Am5ZPb4Wf+sNLE
         1UklwK+V1aaojOAKI34g0U/OASqGtQE7t62QelCqv1v3ozJ4Aycn3JsPossFi4D5DCQQ
         quCL16p5oY7mpFZ0btC7Vw+qU7qMDBJIcmqGUwWb/NM3WCbTh9YmhZRgfIcUcAZCblqM
         ql9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780485089; x=1781089889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbVzViarSxJY8pa/SBXvqjJZvbUHdLtHAg1SR24dEog=;
        b=FNwvuL6gZ4Iw3Oigtg1iU3IoEdKG7YH7Kc5kvLzyRuz0y7HkTgTLJHOhhnKRwZhDAL
         uSvCNWsG1LbsA3A3J1py60LJrUIENGBx/dRIHL/KN2geBzGY50uCQFgO33LI4uWo6AYs
         LdLQzvqWgTs/vBqO0hgGjCBk+afJkK5FwhYrtK8w7wyxdltt/3l+UXvmA1ZCbco5zx9T
         z4XA9LbwaDbGP5WZl4me2cTsqeIipgycBeZ5+9Mn+lWvdrsOnr6ZJeVUd/stCp4E+ZK/
         4c47qqIugyGE9xqIeS6sV0FpEmXSIuDsVSlqRcrZCi8BQIe4bIDjJRLKcJPUkgrjyhvR
         SDAA==
X-Gm-Message-State: AOJu0Yw9EBYkFCBMza4l6KHAsqwIPeswhVknrg9AYiMfLQARlOpkVDAL
	2VopNTP25INYMC9ghS5DHzAsd/wZBJv02xR5IFdrl1IDnyb0YskJOLo7+aizSA==
X-Gm-Gg: Acq92OEHPxoPPh4MK/hXiO59QmaNjVmz/Kgx4YhoKcSVRZxXufysiCV61SIhCxzuTIL
	SrmEDVfBtrLVgxQKITYLnMm88/Dd43jfQ0kjyNGdbn2DjxuJw7ctkctL16Qw1TyQ1csxGMVj8rM
	Mrm5sefwLh4miBwy1FBNoQOlxspoc3+0PC7/JjnojCEvpsBJCB0ATvMrJafpchuU3xLg3Cc5hd9
	QAzUGjQ7FxPtswCjT50TbOouvtZKgFczW62wTL3Y9uR2RUzBEZF/8bO1Khm05n5l5m7CJf7OQ1U
	z1H6qzYmUt2MST90Yq4hxAqkTaPhqwZOuXQ7BRHzzT4EFkPYSRYSCLQ8TfXA5jKmDvnrXU/91vl
	eIDMvg0x1IQOW82IaUS1VWM6W9r1VaK1myEjaAEsrf14TluMBdkaU2IFauGctK//RHERjWgkQ2f
	eudQFbIrcOWzNgljEIEkysfkQ+V0GDO0GQdT+52BegwNwRBnAoeaL+M8sY76JbBG0RovNN3CDp9
	4P959yEyUhsSuBHn2UAkpJHcJQZN8Mb3kREm9lqrNGQIim17vrR8W7e6TEmzWGOZ27s4b4=
X-Received: by 2002:a05:6a00:928d:b0:842:6004:3fce with SMTP id d2e1a72fcca58-84284ee92a7mr2777697b3a.26.1780485089415;
        Wed, 03 Jun 2026 04:11:29 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:88fa:8837:5c6c:ee92:51c2:81c6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282372502sm2972578b3a.16.2026.06.03.04.11.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Jun 2026 04:11:28 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	toon@iotcl.com,
	jn.avila@free.fr,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH 0/2] parse-options: introduce die_for_required_opt() helper
Date: Wed,  3 Jun 2026 16:40:42 +0530
Message-ID: <20260603111044.39116-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many built-in commands in Git manually check for option prerequisites 
(i.e., option X relies on option Y being present) using explicit 
conditional blocks and duplicated error message strings.

This short series comes out of a discussion with Christian about 
localization and code duplication. To address these issues, it 
introduces a centralized API helper that handles simple option 
prerequisites safely.

- Patch 1 introduces the `die_for_required_opt()` helper function 
  inside parse-options.
  
- Patch 2 cleans up `builtin/add.c` as a proof-of-concept by migrating 
  its manual prerequisite checks for '--ignore-missing' and 
  '--pathspec-file-nul' over to the new helper.

If this initial approach looks good, we can later extend the helper 
to handle more complex multi-option dependencies.

Siddharth Shrimali (2):
  parse-options: introduce die_for_required_opt()
  builtin/add: use die_for_required_opt() helper

 builtin/add.c   | 7 +++----
 parse-options.c | 7 +++++++
 parse-options.h | 3 +++
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.54.0

