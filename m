Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEFD1CBEBD
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623110; cv=none; b=W33r46+tfP+BbtaJ9kDeukKMmm7TjaACjvSQZPwAKm7RWlOqKOXbUgtIV4whQ4FI7anu7o02dHj653UdQf2jVZ66CnISYIGoTSOXxvMXM9xPUNzcGVmMLlBh1XxAVcRoSR6y2OyV2QwNzad5lazX1LMjYpC4zFlRpmr80uK8E+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623110; c=relaxed/simple;
	bh=TsMvFL4U9+5UyIyYVCImm0fS2IZ67sFAT/aKluJvfQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=age97q5Z3MnTqs6/zh3G3ARlr152AN5DoxbtYTEkZRWf7OqIUVGjpaQdHgDsFU0ETvFvGig//vqy0qzwrUvj3ywM6P+6wFWUxR/xrAmgbEh95ll9D3WNSA4Xdgha5eh1IGeDIO5Thsnqmjar5hrmlxea4t9692BpANwfiggFrxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgNan2uj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgNan2uj"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20570b42f24so24832405ad.1
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 04:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725623108; x=1726227908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/+APfLOUfy3c0+yTvKXFD8HfIE0XAttjpIAsE8KVp0=;
        b=RgNan2ujOgXxfm+kJxg5+s9st068OpfPUeeYeTqy8UvstgIeJ351Aa4sJ05CTJVrf9
         LFcahNQCa0LTvg4XaCukenjtDoyCjMP2PZOlICkfDJRqEl0gsXD6IL64wXWeIBZOYhbR
         d6XqHXaullMD/MUsgu1dP/VNXdcE+ibWW5NvZoAGkJ+y6XoxNECHlU4eURlDAPTgUW8k
         rSJrlirmF2EvKt1TaFwIwIhjHx0dw+gZA6C9TZnIxaYvCJbWulZnMH2t60nK9SiCKTCR
         d250fXCvfrVFViNQz2jS33UgNzcKb/2bv/FcOyrn/ZN40vdGiLLm9hf5QnU78yZWlhZs
         VQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725623108; x=1726227908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/+APfLOUfy3c0+yTvKXFD8HfIE0XAttjpIAsE8KVp0=;
        b=UTImvrh56062w4p3OM5BHRgtGG1YP0gbpaINtovOxszmVjHMj7fOSRRiXNfuXAI37b
         OkRx0eML2cHfkP3PYxwsOHWuUn4hzZhsihKtGPA2r2Oohj2oKXrMWwEIrOXdx7qGJB9r
         2wEsKhRjYsNb+/F19CE8wbT68wBbcwacc/RbZm+YU/RxH7Gwk9jZm+h5fjM2IVqCzq9M
         +8vhO6HRdvAQL8Y4ANtIEkLgIZ19Avb7CfAGgn9PdOfU1Bs3bw7Qi87Bd0DwtdjzF2Tm
         /sOJDv0SeLXc72jPhaIQ9BwhMrG0bDo4afdnXyDdZ7dDhADcxat/m6uAeLY0UwRdvbza
         N3jA==
X-Gm-Message-State: AOJu0Yx5wqhEiq23xvnt/ZyLGtCpXyr7JlcJe+T0avnWUc4x0UJUXCyk
	jwvrDhxLEOIU/UAQER9CkZSqTWahskfcxiurq3xDYhNWsyK9drF4Xrfs7NWu
X-Google-Smtp-Source: AGHT+IE/s0IpyqJm7zDQ/EJ55RJnr3azj7INqHJmb38eijt+Ljr7UDN9zZoQRJirg9D8ViuxH/Vx/g==
X-Received: by 2002:a17:902:ea07:b0:202:49e:6a35 with SMTP id d9443c01a7336-206f04f9c6bmr23306455ad.19.1725623107055;
        Fri, 06 Sep 2024 04:45:07 -0700 (PDT)
Received: from Ubuntu.. ([106.221.74.130])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206ae91371bsm41903685ad.26.2024.09.06.04.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:45:06 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 3/7] t-reftable-stack: use Git's tempfile API instead of mkstemp()
Date: Fri,  6 Sep 2024 16:59:12 +0530
Message-ID: <20240906113746.8903-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240906113746.8903-1-chandrapratap3519@gmail.com>
References: <20240904150132.11567-1-chandrapratap3519@gmail.com>
 <20240906113746.8903-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git's tempfile API defined by $GIT_DIR/tempfile.{c,h} provides
a unified interface for tempfile operations. Since reftable/stack.c
uses this API for all its tempfile needs instead of raw functions
like mkstemp(), make the ported stack test strictly use Git's
tempfile API as well.

A bigger benefit is the fact that we know to clean up the tempfile
in case the test fails because it gets registered and pruned via a
signal handler.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index c74660a1e2..8047e25c48 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -76,7 +76,8 @@ static char *get_tmp_dir(int linenumber)
 static void t_read_file(void)
 {
 	char *fn = get_tmp_template(__LINE__);
-	int fd = mkstemp(fn);
+	struct tempfile *tmp = mks_tempfile(fn);
+	int fd = get_tempfile_fd(tmp);
 	char out[1024] = "line1\n\nline2\nline3";
 	int n, err;
 	char **names = NULL;
@@ -95,6 +96,7 @@ static void t_read_file(void)
 		check_str(want[i], names[i]);
 	free_names(names);
 	(void) remove(fn);
+	delete_tempfile(&tmp);
 }
 
 static int write_test_ref(struct reftable_writer *wr, void *arg)
-- 
2.45.GIT

