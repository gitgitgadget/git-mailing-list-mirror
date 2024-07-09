Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A6D13211E
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 05:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503575; cv=none; b=Qi53PlGJDkySK7e3i2DorXnUGLZVPkiFJlxz7Z0RNg6ryYwvRLXhhMk9VZNqiQiyy4k/OOgH97TNn7ub3TSDeA2N+z0/SBjPftbVyaV782wfyuLq0eziBZu1yyRqEDHTTSTBExcE5PQ/WaCb+UT56jazzBRAArd07B4SMR8QDyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503575; c=relaxed/simple;
	bh=Sa/2HiYImtRrFY9FizaEfTvncKypvhdHl6djbY6lbZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohSPZkYZ6Pkkzx/wiYPlrv8aLH9mjRU7UQOubF6LKkwWQpykfEw9p85bS2/yUPcboR8aI9QvDlUF7xOGm2ZtYNJZpExOfJF6vDj/8TWIZi/B/CiP1EILy2ag6IW5cZHvkKk+rNoPk6epKSgKndQQbwtOdSTEm1RgF0YhR6X43Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNiyeQAY; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNiyeQAY"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d92bbadfd6so1351133b6e.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 22:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720503572; x=1721108372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TuNQAnHDOlUzacIPBFcgqMbfhHZm0oOlkOemNNHgIE=;
        b=QNiyeQAY3xUzvUfXoyIw9ffAQsaFPahAsNN4B2sEIvDgVJqFG926YPavoipDRYnoO1
         LswnpA8Ok/HkreckxhfMlOewDZlT5CwKkzZWYm+oWcrbNTLRsmaGWeP0J5BotiQUHnxW
         6j0KulZs8bFKQDP7hPExtS0Zcn67XGh1HW/ooUDmL/dNlG4WZRmdIq4wANBNwBcXT18d
         O0CoKIDSecrn5Us1DKJGDJmQHQNrqkMPSyqY4sD1/gX3+0DtuPVZqBE1222kNlWhSXZ8
         16pvQhBADo5TuviesyQF1IzUPplXrUfZE27U6c0HyCC1o+KxjKgOvlKg3iFLNLLC3mnv
         R6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720503572; x=1721108372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TuNQAnHDOlUzacIPBFcgqMbfhHZm0oOlkOemNNHgIE=;
        b=p1Gv0pNMWP5287XWt4bmOwTwGyzqQ/vjJ8ZWu/vbwtjMR6CG0Yylys4t0eyygF/pEa
         oYoiW32soaln1l5UW9Gu8j+LZYovPpTNw2JsPcrGG2sjDad8naqj77tqgVUgSALdEGX7
         6F0gcOkzSdHhnaGhWFpVQM1oC+EKHDjVmWyUIOJKYLNQexNtbNQpBezS+Dg0sHFM1EHV
         3ubjRmGpzGAI2EfTLl0dVX/GFHPeTAUXP6eMzLxgzsYfJYg4dv4lvBefIQUrCMPaC/wD
         CpFRMWazKkVXIw2hdS5/Lm7Xq0LyHZRTjcYiSwRbFnK6sdtfSiSp8d6Dhhxe40mFaH5f
         TMqw==
X-Gm-Message-State: AOJu0Yy++UsuvMNfZyWAtfLMXMrgbwtyHrfmWKcrlATKZ94AHiXeNKfc
	jFj8a7nc8L2UOXjbJ3cLTZuVP0T0Mag3Mq4SGcwccleVrKA6/xqVaL54sg==
X-Google-Smtp-Source: AGHT+IEjol10BH+8uCRww+MgSL0hLth4UoX6KWejrUEZ6uKGPpV3Km38LAm2yZYyHcHoG+lsgJC9mQ==
X-Received: by 2002:a05:6808:1b2c:b0:3d9:29c1:be5c with SMTP id 5614622812f47-3d93bee8ad5mr1815282b6e.12.1720503570554;
        Mon, 08 Jul 2024 22:39:30 -0700 (PDT)
Received: from Ubuntu.. ([117.96.144.60])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-77d61922ee6sm718448a12.46.2024.07.08.22.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 22:39:30 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	karthik.188@gmail.com
Subject: [PATCH v2 5/7] t-reftable-merged: add tests for reftable_merged_table_max_update_index
Date: Tue,  9 Jul 2024 10:58:44 +0530
Message-ID: <20240709053847.4453-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240709053847.4453-1-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com>
 <20240709053847.4453-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_merged_table_max_update_index() as defined by reftable/
merged.{c, h} returns the maximum update index in a merged table.
Since this function is currently unexercised, add tests for it.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index d151d6557b..ffc9bd25d2 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -236,6 +236,7 @@ static void t_merged_refs(void)
 	check(!err);
 	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
 	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
+	check_int(reftable_merged_table_max_update_index(mt), ==, 3);
 
 	while (len < 100) { /* cap loops/recursion. */
 		struct reftable_ref_record ref = { 0 };
@@ -365,6 +366,7 @@ static void t_merged_logs(void)
 	check(!err);
 	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
 	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
+	check_int(reftable_merged_table_max_update_index(mt), ==, 3);
 
 	while (len < 100) { /* cap loops/recursion. */
 		struct reftable_log_record log = { 0 };
-- 
2.45.2.404.g9eaef5822c

