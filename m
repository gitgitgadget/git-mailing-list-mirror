Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B968280330
	for <git@vger.kernel.org>; Sat, 10 May 2025 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902084; cv=none; b=M4E3C0FS8hgosQ5cTM4smdoweZQjQuxRYryiluyE4+KxAFhmTN2sqaVkexROqH1p9lNAwbWcQxc5dElaaktuUNqzDImk6rVRkosS/+S9aSQt4KgyyxgDnYxtbFuCxMLhM7aVXRo3Q3IGJWG+Xw8ZePUWxuJGvXV057ewkHKNsik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902084; c=relaxed/simple;
	bh=ZMdwLo5oYdmxAr7GFpbPQ22drVS3K6hZTNF4859l31s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVtc2mRy/EKNDMYbP4tHqkaDQKM8Davd0pYzI5dJ6dbtzjkZ38QLr2tWYjqKgKoJ+z1vJ3geLlMc0r/zxNeU999ER2SbHwSRtERHHJ1p1bMO8iRGDcwmbk+iBDCuJq52y2aGmvH/tjI3dCtnKa2FR7oVoLzCVilQ0RVIsBJH4iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERpAXtti; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERpAXtti"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e7387d4a334so2624330276.2
        for <git@vger.kernel.org>; Sat, 10 May 2025 11:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746902081; x=1747506881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5Awe1JBG/T4BPkHav1VZWGRdvHPlTRX2uwbGdrBr7g=;
        b=ERpAXttim+MGbypOGi0VYQ69+rhr02r3p9w4keWY3mfTuCCHCQu13aw54XVjmSJm0h
         gdBbJ2PT4YaO43k32R/WtIs6yfwSC0AO+I6k024oTfx/p4/Kw+HHsbU3V2mbiCZfQq7k
         feZE2UdhY3/ltdP9zJmtmHH0OvNlwjVE7zlXiA+8K97hzwYiVPVn48I6fXtqXyYwu18b
         JT8vO0G8byharm0PHDcoR62dkOWvGODXalP/9/Q1j1BZIz10DEoQsh3VP8LbQ0/gW4uM
         6kQfoDPqE663WaFog5sI7ya9sRw/rVyNAyDYeLH9bN8jMFCJHnhL9vN0d0RxxOdutjuX
         9pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746902081; x=1747506881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O5Awe1JBG/T4BPkHav1VZWGRdvHPlTRX2uwbGdrBr7g=;
        b=DY7kwTbLjsSBk1P6JAaVMmRz7HGngMx4/0iTfd4I6OXJBr40l6EXGaClCtSa32ajQH
         X4gU77u60jvv/MS55pKhbE1kwMeuuUrpUzIxnaXg9RA0khQseifTcDqJQ9QB1ZzHxtG2
         url3JpOqApprgdEI5Xjjk0z6p6iHY3TGZkCpyyEp1D+OdG/dEhoavZaWIDwMBJ6jJxnn
         Jdf7Yo9ehgUKOw0R0ItyS5R0CPBL/ruDbTr1LKEHEV5L2qslPSp2GiyB+N0+Mz35Ytxp
         EfOARv9MbVyMtsxesTrYNSR/AmF0DJQzZDLVpOsupx2igbAVdrpQVVI6HfkZS0fdsT59
         Pdzw==
X-Gm-Message-State: AOJu0YyScba22GyWrgMru4O6BvWW/f2GKJpLvtyJwT+nAbjWDHN0aSjT
	EVWh7Zom1VhveU6tb8kldM9kUt9BT+Cq0i7f4YjqneQqzIGxa0wAGDUJUTgb
X-Gm-Gg: ASbGncvIi9A7B6LeZIFT+tkYM2xJB05oCdsy1DCqAMBKEHWuKmHMBC93qZWb0EGJB07
	QaSQmb6M6CpO6X+hfkjMR2kGCBGUN77fnb1V3+zpEiTdz3XixM/3DAT+dEVPishf3i9aW6I7ZHd
	G/lXBlxeHdMu7r4L+A/Fxr6L4O0zvlrm2meFVgCrGscdY+JlvfYtKFZOztMok6agapDpc71Ykdv
	LCqoEo38FLrQxUIAxz1lv1/MmVzBTVAUuU/xKWUrkHq4warVOBtwgDj3VYgRZ0dku+48SD5dlYO
	ZIgKtGIsEVNfZsqOHD4yDqR/UjhTYXh8EGfHCzB6kP0LG+e5rJDY990I2iKbJFp0bH1jTC3MRmf
	JqkzEhYFiGi+PQoXQxxnU0JtN
X-Google-Smtp-Source: AGHT+IGbhI674shaXAnK6mlYLIxT0JRPvIuYFfC+tV+tHD+wuHQTwrl8Nt6ep5HoMoAbv7QNES0z+Q==
X-Received: by 2002:a05:6902:2412:b0:e73:2ec1:1e83 with SMTP id 3f1490d57ef6-e78fdc48bb3mr10529251276.23.1746902081109;
        Sat, 10 May 2025 11:34:41 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a6:1600:541:bcf5:33bd:f1fc])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78fd4a72f0sm1191649276.20.2025.05.10.11.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 11:34:40 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/9] t3904: adjust stash -p test to account for index states with breaking changes
Date: Sat, 10 May 2025 14:33:42 -0400
Message-ID: <20250510183358.36806-8-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510183358.36806-1-ben.knoble+github@gmail.com>
References: <20250510183358.36806-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t3904-stash-patch.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index ae313e3c70..90f6b6bc90 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -30,7 +30,7 @@
 	verify_state dir/foo work index
 '
 
-test_expect_success 'git stash -p' '
+test_expect_success !WITH_BREAKING_CHANGES 'git stash -p' '
 	test_write_lines y n y | git stash save -p &&
 	verify_state HEAD committed HEADfile_index &&
 	verify_saved_state bar &&
@@ -42,6 +42,18 @@
 	verify_state dir/foo work head
 '
 
+test_expect_success WITH_BREAKING_CHANGES 'git stash -p' '
+	test_write_lines y n y | git stash save -p &&
+	verify_state HEAD committed HEADfile_index &&
+	verify_saved_state bar &&
+	verify_state dir/foo head index &&
+	git reset --hard &&
+	git stash apply &&
+	verify_state HEAD HEADfile_work HEADfile_index &&
+	verify_state bar dummy bar_index &&
+	verify_state dir/foo work index
+'
+
 test_expect_success 'git stash -p --no-keep-index' '
 	set_state HEAD HEADfile_work HEADfile_index &&
 	set_state bar bar_work bar_index &&
-- 
2.48.1

