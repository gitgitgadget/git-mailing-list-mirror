Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5062F577E5B
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201010; cv=none; b=HG1TDscl+yfGy2eNHh+MSBM3lIlS6ngninkQRx7oKIqrfa+cbpe99ZJx9Sb9/hD17AG3ltxpBD01wSGPdh9n4tNoq3/0LfIDNXM4r6xytGLvrZ1BJ3eCun0DgXh2AkhaBqTMHcKc/5liffZKo8FXsPPniQxg0EhSx3TtDQ1RHRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201010; c=relaxed/simple;
	bh=XO1DSk5iUNhoe822ybSkpeCNPAxWqlM8fEhtVwilBug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByIdLq7F68GICrIs0C8352q7/VswPDueGTCvoUVeUT1Q++nu7jMvmkhYI1kEcfkkxq2UopaIYj/0RNz3Qptnf88JIhxtMYmXXHZEEuc4UambRJo4XPv2sh8we9NN7nBxiDjNamL0GZdgGGlm/yLhd0i2hsn9TCIQMg6py8OdPfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVva6Mkh; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVva6Mkh"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c6ed1de994so984997b6e.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 15:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790201008; x=1790805808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hTEmPY71yJr7NQ7ec6ziosT1ZkaqL1OI0DZjtb8sTEc=;
        b=hVva6Mkh90LjlLOFVAXKB8zrsBjkxUN9WvcsLIUWu2E9ifHrgfvA/HYTHYZ23JLB0E
         HSsqNxNCm68fEyRRQhD1qJQhXzmLrszBLIhrqd5ppm/L5AbyN3BtrZl+YuNKdXQ8pk47
         vczpiMk2bIfq8o5tjKSDnf0DVPbPqaB1jQevX9Aa6zRL6L6J+Ly/wuQEemToVXo9YKyt
         D/mgT4YMPKFptpXpi74jjgAeEK+nA0C0AEwev5z7srCTKFVE7eMB8pVQVgUSWFzFP2FN
         /OxoDKKJ305QtNnuGQ58/Vu65Ll6iHPSvHiEhpXTIlV8bHfCow2b0W6cVRTKkMZ/Z/8R
         /rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201008; x=1790805808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hTEmPY71yJr7NQ7ec6ziosT1ZkaqL1OI0DZjtb8sTEc=;
        b=EoYtAnUEOjg6DIvABCvuoDvsPa81dvx1dGuEBJoO8X4M6yGHEik6a1wOr6zicHOY8w
         FP1+HbYZuuaWtrbsI00oZbfG5m9d62nGPVlSET/5M91DLIP/s2Ixw0jvFz+8N6LAzTCs
         lLKRely3gp9F5KzzK75bwO262VwVOYoFjX+dL4E2F5VYmNt0NQl7O3/FbjLQh9aBz+FV
         EFB5P05OfVh6Umy97kgcMe6xIllTf8pnaMDn8L0CPmBsBfBX9inrLO/y34PG3eRfKSs2
         fjyJvZr4mBnoWbCEZSwDdIHMdsrKALJjMtsj3fnh/zeng0mvOlJbh37TL42apwYJwdK4
         UdZA==
X-Gm-Message-State: AFuF++kAJgEOa8yOdKdd/GxUl+ILdmDGwkywWwGOZzo3rYTcO4ZP6u8C
	BnJ6VunsXqfpyuV0dcSuA7sJnfEwhgy8vINrQx8uzmvpxnLIjlY5Klbc6qLwXQ==
X-Gm-Gg: AYBFou332DO6aBjzgG9Q669MXoMog9wW/8dwzHUbGxN9zbzRpzqeNTyN2nrgYPFzoMo
	7ZnrLEiqx8swCIXrnZ1aKfgT7BeJhR/BDA2IisRbKWf5rDInYlCxfRZi38ojwst7vqMdbj9Gj8K
	u8qQzsx4S5oS11B5zFUSpx4lvSanGVfElkLopah1xXfUgN5HtvnQI4LSt6P8VzuSe7/XxmQoArU
	MCtheZdZqGgVJgPt82bqdUXHsYpWNI5okmmEFadinvziH1Fp3VE4/4XNvZ188rcHEsRl4Og7o+a
	Mn5rR9XIjuK4VNNIy9IDLqQDL749+GglNlfJ2Dp0XLc7gKNdDjmJ4u7UaWezrStkf303apOX0N6
	jlQDktTGN6aFx4GwfAst8b/D0jIPnWsDMHq3M5yEPapMEUzCm1ViB/WPR6PF9Y604GNqOnVbzmS
	NmJPPrPIaA/+wwbhiM9mn//IDCJV9YmPT5vg9MhcOvq4j3MAeRAyO4+Dh93Gd3I4qXHLrIOviJs
	FWRrfSEfWCs5TA3Xmre7VguiJFkKtU6FyIw4upCoZRm3IhW
X-Received: by 2002:a05:6808:2228:b0:4d6:9293:9b57 with SMTP id 5614622812f47-4d72f150704mr600807b6e.63.1790201008135;
        Wed, 23 Sep 2026 15:03:28 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d5c43b74c9sm3364802b6e.9.2026.09.23.15.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:03:27 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/2] object-file: flush transaction packfile before migrating objects
Date: Wed, 23 Sep 2026 17:03:15 -0500
Message-ID: <20260923220315.569424-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260923220315.569424-1-jltobler@gmail.com>
References: <cover.1789328612.git.jltobler@gmail.com>
 <20260923220315.569424-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A "files" ODB transaction creates a temporary directory to stage newly
written objects in when configured to batch fsync loose objects. Once
the temporary directory is created, it is configured as the primary ODB
and all object are written to it accordingly. This also includes
packfiles containing blobs that exceed `core.bigFileThreshold` written
via `odb_transaction_files_write_object_stream()`.

If a "large" blob packfile is written to the ODB transaction temporary
directory after other loose objects, the ODB transaction fails to commit
as a result of the temporary directory being migrated prior to the
packfile being flushed. Fix this bug by always flushing the packfile
transaction before objects are migrated to the main ODB.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c    |  4 ++--
 t/t1050-large.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index 0f123b79fa..210984f825 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1262,6 +1262,8 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 		container_of(base, struct odb_transaction_files, base);
 	int have_packfile = !!transaction->packfile.f;
 
+	flush_packfile_transaction(transaction);
+
 	if (transaction->objdir) {
 		struct strbuf temp_path = STRBUF_INIT;
 		struct tempfile *temp;
@@ -1292,8 +1294,6 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 		transaction->objdir = NULL;
 	}
 
-	flush_packfile_transaction(transaction);
-
 	if (have_packfile)
 		odb_reprepare(transaction->base.source->odb);
 
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index d295c265c7..95233458b4 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -87,6 +87,23 @@ test_expect_success 'add a large file or two' '
 	test $count = 1
 '
 
+test_expect_success 'add large file with loose object in batch fsync' '
+	test_when_finished "rm -rf batch" &&
+	git init batch &&
+	(
+		cd batch &&
+		git config core.bigFileThreshold 5 &&
+		echo foo >1-small &&
+		echo foobar >2-large &&
+
+		git -c core.fsync=loose-object -c core.fsyncMethod=batch \
+			add 1-small 2-large &&
+
+		git cat-file -e :1-small &&
+		git cat-file -e :2-large
+	)
+'
+
 test_expect_success 'checkout a large file' '
 	large1=$(git rev-parse :large1) &&
 	git update-index --add --cacheinfo 100644 $large1 another &&
-- 
2.55.0.424.g13c7afec21

