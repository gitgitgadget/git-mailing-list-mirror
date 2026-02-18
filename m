Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A6626CE39
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 05:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771391949; cv=none; b=YP900f2aiMsTiLjfinIguefcxF3LveaGPCShryng4+HX2wngsv9kpTids46XdcrFq2R0Iv+BXFEVW0RIkX2TakQ0hSubSEaCEqOt5lzaKFKoFv00e8c8BTlSiGtIpBBLaUIMod9DDbeDSSHIONODiOfBvoMzme8WWqvyQbROQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771391949; c=relaxed/simple;
	bh=ehoNzl3qFKjJyGw4chyWKvRPkXsZWJ6LZdIiQk7qt/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9c75K+/9aR3dvErW1vLmeh0dvSiFy+/WtXsvMYyQRuum5XaHMRTBu0civDvsTnTTOc71HP2SOaOQ9eh/S2OaSHWDSLOYtaFJbdORuKd+xZ8CPhd5QrHWaNiE9Lx8GauHXI0RUk848eOl10Z1AR/LpaQwDJhSlOh7ZbfSADwk5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReDkgPc7; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReDkgPc7"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8218237420eso635478b3a.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 21:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771391947; x=1771996747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHkUGoVcSp7OEe/qAFpRXdUSiddWpV9xVWCjFig7m0I=;
        b=ReDkgPc7KericE6uTR7Yq6ZIpa1K9GaFBRKHVaCNMh8AsDwwZPE89zHdnDiiGNTj2C
         5f6qInPhMs+akYdVXkk7oBM9WU6oZCcwZdebG4XDNQoalkm9cZlyvUk3uPWSIcfbsU8S
         NGVz0Pc+rqsyWhDwFvXwy3fOrest8+meTAeGDNBVAt7QFOyxz1V0zv65qRqO/RFqgc7P
         T5MuN19J/R2aGSu4jm/QBLN0lrRB/bCgmk7axvtmDeRXLqQu4gR74LPlkzN8U85fIh2C
         m8607ZLAVsvVkGZGeC+ChYYk8UoVOSVls9CyrH9T0q+WA/vL54UItQxkh9hRuTOlXWaP
         8z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771391947; x=1771996747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mHkUGoVcSp7OEe/qAFpRXdUSiddWpV9xVWCjFig7m0I=;
        b=A27vSMyx/ZXkolf1CR9SDXwkuaC5QR8Lz22y8Ypr/MWaPdx6YpQJ30zpflxwckIPIu
         xa/l/ErTPKeSjeIYVrtzx1FFrr6fa0nOKu0uzR2Jp75ZLuOgaI6EO8XIjxLTjoNb5Pql
         4yBROgsBmcbBgW8fvhO1yOF+pGVOmNQiEYVYyJJF/tzX03AFBXiR/su5vBupb/3JlQyE
         bbV8WUfJ/G21zvPz2Qma4yPWAAXoG1PTaX0I2odplpJ3sBSbSDJty26zXHWVyf7u1ox/
         n+RLI7HKe871CWkR2h4uVlrfV8akmJ7Cfk0xjfyTnn4BHsUiI/lg/SyvgRjQl5iFKPGi
         r+Ww==
X-Gm-Message-State: AOJu0Ywm9qLXcCgrlqVGfJmRRjCE63dO7wNHNwEfK44M/qRN8MNpa4yP
	sADxVGL/3IujhTXiAqtAvRo6lEdm2RcE+5O8N8KuyaUUFxXT6Lh0CbYN+Ybbxg==
X-Gm-Gg: AZuq6aIqO2SeteWa1UFDLyPwzWN2xiNUyKu7ZHY2c+STD5abdrWkyPRQZnLPKdvkq6l
	nx1wWKWE2DQvtinYzhFiCKaw99gsnL253qaoppreZN++9alOWVR721YyAl7SxoMRnfcW+Witn9P
	DWciOvwo9RHCV72E/0EfL5sqX4OD8MfP29MU1AoWqpQZX3+OugLg/n2/PKtFS3RWze8gXFOsCj9
	eVWwAXqgZABotXCZIYZhHhf2RKKy+/J2NsUMXaoSOtvOnnjKgA5Ij0qAQmIBFOjl3fTw5H5Uq6T
	DbI1V7griNa7B+3dCuJOm6sSHRfu6kDb2ECiWcQQ2k0v2pkG6glOu5UmRUxH9bkCSxXtaKee/tQ
	lEoN2SAEUVZBIwEQ90LaaMH4IcosWaeSUd0PghpeD/KJOXJqha4Q/Md0QRrx91N9covKFLCTEUQ
	MkWw7MjobDyPeCPQWptsm2FNJ3bHXYTOMrFJA7DS0=
X-Received: by 2002:a05:6a00:21d2:b0:7b7:90de:e18d with SMTP id d2e1a72fcca58-824c5ef3100mr10747203b3a.6.1771391947074;
        Tue, 17 Feb 2026 21:19:07 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b9a661sm15047688b3a.50.2026.02.17.21.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 21:19:06 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com
Subject: [PATCH v5 0/2] setup.c: v5 reroll
Date: Wed, 18 Feb 2026 13:18:48 +0800
Message-ID: <20260218051850.164972-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217084124.150366-1-a3205153416@gmail.com>
References: <20260217084124.150366-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Karthik, Junio,

Here is the v5 patch.

Bases on the feedback, I have split the changed into two separate
patches to isolate the refactoring from the logic change.

Patch 1/2: Refactors read_gitfile_* functions to correctly distinguish
ENOENT from other stat() failures.

Patch 2/2: Switches lstat() to stat() to support symlinks, while adding
checks for benign and fatal cases. Also includes the new test script
t0009-git-dir-validation.sh (name has been changed as suggested by
Karthik).

Changes since v4:

1. Split into 2 commits.
2. read_gitfile_error_die() now handles happy/fatal cases internally.
3. Renamed the test script.
4. Updates t/meson.build.

If there are any further issues, please feel free to bring them to my
attention. Thanks for guiding me towards this cleaner structure!

Regards,

Yuchen

---

Tian Yuchen (2):
  setup: distingush ENOENT from other stat errors
  setup: allow cwd/.git to be a symlink to a directory

 setup.c                       | 35 ++++++++++-------
 setup.h                       |  2 +
 t/meson.build                 |  1 +
 t/t0009-git-dir-validation.sh | 72 +++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 14 deletions(-)
 create mode 100755 t/t0009-git-dir-validation.sh

-- 
2.43.0

