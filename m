Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED2319FA82
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560310; cv=none; b=W0ORjD5TCwCg5ail4lbZm95WRUy4AQ0D5sayDoFPFX/sB7uIlc4xEnrDePIdZNNy+S+gAI4Rm2hZZsnApP9M3Z1SXJON8QA7iJ8AKoomc/xbjWOYwJKV/GrfRxKDzGorH5aL1m0mOZ1LC59Vo2UtXyW662z8JP8VWi4SLGNEP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560310; c=relaxed/simple;
	bh=yH9fmeIqsXecJpYyo0jkQn8kR7eh/t5Mtz7aSlVqssg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ra8hdGzSlQPkTdwXc+u1S9Kuvjy7RiAaz2LzMxuA4Lf9sMUQyaBVcZxPogUqN/Kr0P9h0xfUupxYlt/BpEBex1JDPuH37yoZNNNkKerFYRisHIhSfaJjNqRreTyQdW2ZrGdgjIau/Ux/qTuINfFC1D0OC4mfPb5mlzVMg0mRcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YncPjOVg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YncPjOVg"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc692abba4so47125485ad.2
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 07:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723560307; x=1724165107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy3ET2wBOg8y4F76auip+bBR85/ZEBFlsakrKp0ZMgo=;
        b=YncPjOVgDgw0Ljm5tpxMt7ekek2ifc3ytLdqSd8AFQ+NZhC1j4wTVnRablsu2Py/cR
         dXt1qLL4QozOJTNnUoM6FW200h4dSlXPkfBIizpCho2ETfr2P/gXMiI/mZUtuxXcELC9
         gsiaL47ko3qqiWRkbqCYdKHdjZnL8hEs54nEzQg97Gbn/mioSNAkrqgfdKx1BJjSHKDK
         ZYvPIEIIIAFSX3JqDBDyRTdon/kJ5TlFsxR2dl2OYskQ+URKi8uy2WpfWU8fCpDSOLhR
         jTWfoSfNVjUPpuw+qMlUc1LSys0nL+MNsQPCK9AogOekufOZuNpvWH2zjsW7u1PhHEtW
         Ql9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723560307; x=1724165107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yy3ET2wBOg8y4F76auip+bBR85/ZEBFlsakrKp0ZMgo=;
        b=BuskQY/o8/kUAWOKBXE9j9d/alyKl23wiC68tTVsEahuEo9c6L2V6hmH/iqSbGRyOU
         XcKcN1Wd2DTErSvjivi0XvKl7cHnfIiIAxnf2hrwpJ0f84CqwHyUp1vM+QgHqtd33gt1
         jH5hF1mEVTI9Egzg9cPVJBav2K5z3CGzI9cBexP1Z27a247GYIygI41dbVSV0MaCXfEU
         1ZDfpAAhOIKR/4lrJvEED6E2tspM0oOinRHSA1VaAeYXU9yXAOMq4fGlU3AHM9mPSXoL
         fJVBmm+Xsn4inRno0Ypy6a6xxY40ef02mFdZmXNY3vSqGdJ18FXLJSOL6gPMy4GbQtYw
         l9DA==
X-Gm-Message-State: AOJu0YwVlXm8Ou/2qvp6egfwXgTwLKL1ov2LQo5fxCVOh1PvNH2s247w
	bI7hHV22tdaxDpy5iFftLr+gxlBCELQ2/Dr6KBu80VRgXT7M36ZLyAgzTex8LPo=
X-Google-Smtp-Source: AGHT+IHOBQZfLKFaEtDP9ADAfaFcXCBcZ81aXSWX+84NyPoEvdiB7QiL3Wz5YlQTyhiV+wGqt2rOOw==
X-Received: by 2002:a17:902:e80b:b0:1ff:493:8de1 with SMTP id d9443c01a7336-201ca12b0c9mr53579155ad.1.1723560307122;
        Tue, 13 Aug 2024 07:45:07 -0700 (PDT)
Received: from Ubuntu.. ([27.61.226.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201cd14b1c8sm14388805ad.78.2024.08.13.07.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:45:06 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/4] t-reftable-readwrite: use free_names() instead of a for loop
Date: Tue, 13 Aug 2024 20:04:48 +0530
Message-ID: <20240813144440.4602-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240813144440.4602-1-chandrapratap3519@gmail.com>
References: <20240809111312.4401-1-chandrapratap3519@gmail.com>
 <20240813144440.4602-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_names() as defined by reftable/basics.{c,h} frees a NULL
terminated array of malloced strings along with the array itself.
Use this function instead of a for loop to free such an array.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-readwrite.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index d0eb85fc38..8e546b0dd6 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -7,6 +7,7 @@ license that can be found in the LICENSE file or at
 */
 
 #include "test-lib.h"
+#include "reftable/basics.h"
 #include "reftable/blocksource.h"
 #include "reftable/reader.h"
 #include "reftable/reftable-error.h"
@@ -413,7 +414,6 @@ static void t_table_read_api(void)
 	struct reftable_reader rd = { 0 };
 	struct reftable_block_source source = { 0 };
 	int err;
-	int i;
 	struct reftable_log_record log = { 0 };
 	struct reftable_iterator it = { 0 };
 
@@ -432,10 +432,8 @@ static void t_table_read_api(void)
 	check_int(err, ==, REFTABLE_API_ERROR);
 
 	strbuf_release(&buf);
-	for (i = 0; i < N; i++)
-		reftable_free(names[i]);
+	free_names(names);
 	reftable_iterator_destroy(&it);
-	reftable_free(names);
 	reader_close(&rd);
 	strbuf_release(&buf);
 }
@@ -498,9 +496,7 @@ static void t_table_read_write_seek(int index, int hash_id)
 	reftable_iterator_destroy(&it);
 
 	strbuf_release(&buf);
-	for (i = 0; i < N; i++)
-		reftable_free(names[i]);
-	reftable_free(names);
+	free_names(names);
 	reader_close(&rd);
 }
 
-- 
2.45.GIT

