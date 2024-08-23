Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED23185955
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414766; cv=none; b=kLURrUuTMT9FccGWt06B8TY5oUyXGrkAj+9QpzrEDT3hBI7Pd00BOpVN9McG3kH47bZvQD2G2DQwqQINV9VurncAR7uG1kl0qz+aFpdhmc3MQ+UkCp15gVFvIIusvA3Y2kcWgr9U0zXuo2HTFQq33F1s+laXNnkH1j1JNv+fNfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414766; c=relaxed/simple;
	bh=bRnoCf08wuKbdcvuBDl7e2UVVnfk9pykU9V1eH1Auhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlfmN2StMcz5CtVEZQ2HIM7WPAHFSJJ2WUcVo9VFVaYkFBuToawO2RyoSNVbwI0QhziqHB13YipF3mePxbq1yZvocqGolN9eO5C2tmdklrfaFEoyjY7+4bBF3oe+u9DayKqkNIXcC1uIRBGTanAyPOuDLaBrTNj9MFiEVyrdXNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvP5Pg5g; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvP5Pg5g"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2021537a8e6so16909545ad.2
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 05:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724414764; x=1725019564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUD82v6xJYeKtHtgrLDgxQ2sDCwVk4m/NKYwNh5qy4I=;
        b=LvP5Pg5gFoalFDzdY0uSFYzxN/VUN50bNAdzU2z0vuupZ6IY82ZNwHpUpU31ROXhIT
         FGZ46XTmx/kH/dueUPqdITmdC/DAD3eIosSkRpLjg+cSu6WFX8vUyHSlYwwqdDAU0caM
         5ORufUGeVLvuN5Twmt5MvVv8x+XTSgaJ9sA6/Sloxsl81y2kL2FTd0CK8OOaX21w7bUA
         2bnWElEjJNpGo7Yq6D36UpOrw4nNy/kID19oFes4BVPdRtXTDd48dy+JdQqBh4K/xH1X
         4owzaTEyhHrHdJnRaBymLiP7Dc2lXMENgmHi91Vzp5y5RC90WYmkVLFA8/kwxMD4KVQo
         myfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414764; x=1725019564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUD82v6xJYeKtHtgrLDgxQ2sDCwVk4m/NKYwNh5qy4I=;
        b=Sf7sw1P00otRybxGcBSA/oWysFnPHCPXUk9TNC9DIdl+DFkOQRkzFPKt53BLVrkGO9
         zTlMo470DZsXEjFBSEQM6tVNFh3Yhitun5NMzMdJcYauqvzR3zIm/JecE8nGbu1Ysz+5
         MWxLLufFcxCFDN1BXrIa4//RCHg4iHMqcq9xsNDb/XGgch6OP/JF6boWlfARfNsOMXM7
         mQnMLTmpgNL5ByRBmmjsSx/Bj1nk7ylIkLIQliXGTilDNqiKhtzpRHU9j0RpooRleh2V
         wfstRFNYpsdIJN4q0wOinNOLEuA04yVb3I8Dw/l96t38WszcV6ok/N0vJQM32sWwY3zC
         mcKw==
X-Gm-Message-State: AOJu0YxE7nzsVFmd7tUDwzrBk942FMxF4pm30vQFSbyQT5H4rqygdIFs
	gqO80AVnE2HpiYHYqwWvHCuNIcdJbyEJYVdNsvHwj91LBE7/E5CGkZBrMQ==
X-Google-Smtp-Source: AGHT+IECd1C/BLSAi7oQLU7qhU+7+YjvWy6ee5Xd4tu0Dz+Tb07JRkWlqn5N2wWF8YWnVxynSQlHNQ==
X-Received: by 2002:a17:903:41d2:b0:202:1547:66b2 with SMTP id d9443c01a7336-2039e4a04dbmr20449925ad.28.1724414763393;
        Fri, 23 Aug 2024 05:06:03 -0700 (PDT)
Received: from Ubuntu.. ([27.59.94.77])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-203855ddb10sm27171925ad.177.2024.08.23.05.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:06:03 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/6] t-reftable-stack: use Git's tempfile API instead of mkstemp()
Date: Fri, 23 Aug 2024 17:18:48 +0530
Message-ID: <20240823120514.11070-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240823120514.11070-1-chandrapratap3519@gmail.com>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
 <20240823120514.11070-1-chandrapratap3519@gmail.com>
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

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index c0acd7502c..917d059fca 100644
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

