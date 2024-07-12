Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D2200CD
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763495; cv=none; b=C+3h2NS6C29gNgtxCUjUkxqgG5Bi/lLdIFGNEwYar2xtPa+4uuKDM6sLtkGDBVugUoiueFg86QyVLR81WkRHdIAj14eWHfDYCHI36Uk0ywYd0R/e8wfqrcfLzfZaosQRUhMfHD2ESmo03E9UeicO3IdBwkeXR5PquFwgEDKKbME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763495; c=relaxed/simple;
	bh=JR5r7iQVSvxLkCgajtMpc1PczwyxUN3Wq9L1J5Nly8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2cCE06cXdB/EsO1yHJ1fX1Nhqly/Bwt2sTKBP8jPUzVw1c82DXCYiB45FktwKBg3GK8G1b17Xrot9uKFdh1K68DU91VB6OigQl3ZgpqispYQ/ZGEMq+i7c3NHh/0wrvZwQnyv0BVCOSOf++spJvJse1sxgMPbXKZfNCXC5K7yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7RgrYU2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7RgrYU2"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70af8128081so1352064b3a.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 22:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720763493; x=1721368293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tes2rrEt5jimF66l6Qoi63X1Ls4v0R/Vf22NjZjjtY4=;
        b=M7RgrYU2UZlk9do6Zl/5KVTcANuYCVHIAeEVwE4kDn5ZM5XI/DtJff83GahUHSfAIU
         v+oFW9vf+CuWovi7JvSNq4/KmWQFHLCHII0kNdC6SspzmL/eAO05MdujWwD5KPFxF9LI
         wYOizorcL2GwIRdsvpdb0J2Uw+HbC4NSPlhokWT0VhBkLyibj3uK74kXOBRzMLwSGCeZ
         3cu0BY7zifFXZsddZuH31SN8Oz7evN+1sIlUsc7Bq089w/etJrsev4ItMoNDbpArdp3x
         MGFJCKH6GQHTbevtBP5C3iI7QpYhqmxWQGYC1iWaL972maF/HG1p6wQQTuL6fNGr9F2+
         FxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720763493; x=1721368293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tes2rrEt5jimF66l6Qoi63X1Ls4v0R/Vf22NjZjjtY4=;
        b=jKN363YymzmE5oSvE2Lce2lcWvyih/e7NW8/kjpBbVt7wf3P+H5Z+SqwgjU+0Bjh2E
         4sX1qCyiN6oj/747nHz6zICqjFrab0efABRyWs8KtMB/7aiw1FwKGHp/TWCfKJy8fg3o
         ABJaI2M/ksNTkPlF4Nps5RUoOjbmXgbXM6LQQf+YOT5bRlagWzUCqtr+OEFHWSaQdTWu
         JSztW/5Pfc2hfgyxKVkVm8yDwn57ZFwz4+DZXXI20p0yePHCqsidYKOhbifygKuCqEmv
         ZGvkmkKQwTSiCx8rwrSHH/dZw6M1g7DJRQlk9MtHtBLuSobYPaLsDJfjeU2qZHnFvqOo
         rVGQ==
X-Gm-Message-State: AOJu0YxsIr0ztqLXx0O87Va2Via9LYcmEOItM29AVKykoDuw8RzUnLhK
	WuXmdbPgSvDVTofk08MtXtDTzdzgwEm6nqac8+2kFagdyE1OEEK1HZoU4A==
X-Google-Smtp-Source: AGHT+IGJZRjlwoIxgiNYrMuYF5EZtRO5V9jvriFKCNNjWRGEiKqtT6wxgqJHvMjqF2c6G83E8PCq1A==
X-Received: by 2002:a05:6a00:17a1:b0:70a:ffa5:41ec with SMTP id d2e1a72fcca58-70b43632379mr13676194b3a.25.1720763492788;
        Thu, 11 Jul 2024 22:51:32 -0700 (PDT)
Received: from Ubuntu.. ([117.96.148.106])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70b4397f475sm6604651b3a.150.2024.07.11.22.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:51:32 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v4 7/7] t-reftable-merged: add test for REFTABLE_FORMAT_ERROR
Date: Fri, 12 Jul 2024 11:09:03 +0530
Message-ID: <20240712055041.6476-8-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240712055041.6476-1-chandrapratap3519@gmail.com>
References: <20240711040854.4602-1-chandrapratap3519@gmail.com>
 <20240712055041.6476-1-chandrapratap3519@gmail.com>
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
index 9f9275f871..b6263ee8b5 100644
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

