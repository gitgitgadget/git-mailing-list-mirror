Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8854903
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 04:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720670994; cv=none; b=ogJ8DNKzBpkRLqCcPajBved/nQZeCAXT/RRqQHD2sZ8zG2lkQQ7hLI/neba4pVIG2A0toUISuorhQTe6YtuSksuNnKqASQr6H1PnUilSR9rOmPu4VDc3YGWKIeGYKRW6XyIhvGZ058HcFcETnx+yUyEOXuZgc3V9aQOpe6MlydE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720670994; c=relaxed/simple;
	bh=l5uqwurD+3TOp7t7S3q28Z/Pfk66dmXTC1ZyMCMOlKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRlQ2+3A+B6FDWXG8zgLKccO9PFayro1+TGHI4fwsyoSEA0mKsiSVrncZ9z4X9tmief/muaachgp3xdDiUWUrkLVu1XIr+8WgLM/ZVSZ7FmUB9EAPDnCWD+0R85bfIoxjlNlf8wcoTCr27I4gawlbcatik84UT2ZMFB4J7bSURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hK/6vOHd; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK/6vOHd"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7594c490b04so266412a12.3
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 21:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720670992; x=1721275792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVhbZ210atv7iBD7UCwbY0VDecl1P8xa+7T0BYoV9xs=;
        b=hK/6vOHdsTdKGl+e+H23O1ggu5X0A0WNLHebtc5tut4jcJdYYkqDxQHdEf5f42N0pD
         D/X2E2EFyHT7vPXNJdn8+QkFtOR4blxx75XVkh4vJ6shvv35yOv9bGIOmHt2NiCfyaHf
         f7t17bnhk5b+c8u7bq8M1aIThzKN7aKnUjV5EAKiyvGpj9ISddpFWdLyO3v1xz1Th1j8
         7psZ+BD0N41oaOVyrbhPJBe28Fr6y34x2LQ5DOgpy8EoiBb2Y54H4GQ0ycw4RqwII83F
         68f3s0dnWfaOyLFvRzEWBvcTu3hlZc7MrqppxOxQcQkGPMMZrr9bUmDIoljhISt0DpWG
         npUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720670992; x=1721275792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVhbZ210atv7iBD7UCwbY0VDecl1P8xa+7T0BYoV9xs=;
        b=L9nK19DFPO2CAFnjSsX4AybR1pMDy7tjbW+uR9iHHoYRe+Tp0bkuCddkA7kY6aJzI8
         G8IsYcDHMWcXJD57HfpFdMR4EMoEuhv5oz3IXiVWj1x5rkS2GvWV2UsrS9SaAiJDKdgL
         /Y0sd8fv32Qh0Jq94eHOKaZJlNte84QV5XBMgq43QjMubCnnG2bYd01/AbsLHbOII9/q
         5PMsOxQ6UMbH8ngDD1tGoPjlUB0MLPrDoTl8FT79Ul7xQuARN0hU0B1Zw9E32UOVoLj7
         1E+YsLsIkCzht6UiIlEjXtyEgfzGa03mrFC2L2eL35IrjaTk35sg5IzipGrjFnb+2bym
         HEQQ==
X-Gm-Message-State: AOJu0Yx+SXmCTJXzxNfhNPk4JbrfbjxSoDBTsOUt9JsADqBvBKY6qnF/
	4lSoFOmyROIEHikO9Pi7nPZ+epK8s/mLWZ27ZdAcfv3Qhzyi4OuzYUxjMOtx
X-Google-Smtp-Source: AGHT+IEE2UcEIZWGffXMhzttDE0jOWuG+0MT6tImKa/rCEjtzZLB8BgLMfTZXXL1pq4IDm4jE+lsRQ==
X-Received: by 2002:a05:6a20:748d:b0:1c0:f267:11ad with SMTP id adf61e73a8af0-1c29821d031mr10466415637.19.1720670992071;
        Wed, 10 Jul 2024 21:09:52 -0700 (PDT)
Received: from Ubuntu.. ([106.206.206.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fbb6abf738sm40808595ad.198.2024.07.10.21.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 21:09:51 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v3 7/7] t-reftable-merged: add test for REFTABLE_FORMAT_ERROR
Date: Thu, 11 Jul 2024 09:28:36 +0530
Message-ID: <20240711040854.4602-8-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240711040854.4602-1-chandrapratap3519@gmail.com>
References: <20240709053847.4453-1-chandrapratap3519@gmail.com>
 <20240711040854.4602-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When calling reftable_new_merged_table(), if the hash ID of the
passed reftable_table parameter doesn't match the passed hash_id
parameter, a REFTABLE_FORMAT_ERROR is thrown. This case is
currently left unexercised, so add a test for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index e0054e379e..50047aa90b 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -11,6 +11,7 @@ license that can be found in the LICENSE file or at
 #include "reftable/constants.h"
 #include "reftable/merged.h"
 #include "reftable/reader.h"
+#include "reftable/reftable-error.h"
 #include "reftable/reftable-generic.h"
 #include "reftable/reftable-merged.h"
 #include "reftable/reftable-writer.h"
@@ -440,6 +441,8 @@ static void t_default_write_opts(void)
 	check_int(hash_id, ==, GIT_SHA1_FORMAT_ID);
 
 	reftable_table_from_reader(&tab[0], rd);
+	err = reftable_new_merged_table(&merged, tab, 1, GIT_SHA256_FORMAT_ID);
+	check_int(err, ==, REFTABLE_FORMAT_ERROR);
 	err = reftable_new_merged_table(&merged, tab, 1, GIT_SHA1_FORMAT_ID);
 	check(!err);
 
-- 
2.45.GIT

