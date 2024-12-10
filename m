Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F972080DD
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830597; cv=none; b=MAVyZGfrnDwOmMTJ1n4BYt8Xat25N9xXR+QtGkw/MXZey8H7poMwU3Vcof2Bv03PkjNdeyK/kx/OTLtiMIPXBb3PAyNt2H6NVw/sYfbSZ/me5eNp/LJTlKrznkWwbkiDSw27via3KMBmTZE+GtjAPit/cd/auuCJ/aIaWbHjLQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830597; c=relaxed/simple;
	bh=OvQ0OR0Y5WXPzWh3oAH8iGHrcbFahFnY/NuRWuIIiX4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FkyyFbwY5JdFf3GnOiuF1+oR07kU9TvrwTbrCdFU9NtZDoZeWYabwww3v2RI4QSYplV+qgPnGDhVs8IyuutLgADL4NmSX9GiEUxSf4nkxhcSr3xEadFxOXmDbDvWIjShawm61GyLcBPcfCGhiqJfQXkuoHF5QalZxANzA0LagEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8/B6jqS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8/B6jqS"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-725f2f79ed9so1473094b3a.2
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 03:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733830595; x=1734435395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytE0n8QglSSbvsk4IgL17vDebAiFFYEMEursA2qRDL0=;
        b=J8/B6jqS6MK9o5S0Ipcb83rtwLtdHaniE9QNNCaX/mlhhxaRVdZfCTVFp+VHRx4FKK
         fM+WswMxEU+IJlCTIGPyAUH01G/IvWJd+bUUiJX2S0g16ku1t047lA79Ez8KZtGt81Ge
         XAHBblhe61uW4y4ebs4LKdb9SsdPaAdxJnQ0FwBQZxpUVXBVwpmJnq+kGlmXdUswItXR
         Yjsk6IznMIJ98BtVuhApqBLe/xeplFK5HPZh/QF7iHhwZBXmGfISAju6jNItjSddyRwY
         JAtT4/T8hHpu9O2rBO7J2xq1xBR2Yj79po7Xrcu3nCmSTBr25FC5tTOZNJ7QSBcnN4q0
         aNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830595; x=1734435395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytE0n8QglSSbvsk4IgL17vDebAiFFYEMEursA2qRDL0=;
        b=DIlotBsTidWKPJ+vf/MkUMX0m9KrGXI6sIvHmhLyeCS5jyvm/pDaiiKA+m0Lc7Kcgs
         6y0RsSWA8YnLIZdhMWhKDfTc4Sw4Eb6DDbNQfBGflhDmG+3HRFqYzsU1ykcqVAdsKJcm
         5I39ggmrWpmHZ2unsWOc8AjJ33IAIEeWGhl+6r7TaNX/6V2jlC0rKcLV5g3WbrWK/dDl
         YLMxe9oVRNlgOUGqX7LCjSYpMDwjyjr8XZenMvDos1sZRk5IDrw3Va6wZ6rKMa+In/pl
         ipuenJuuQQ/EeZ8jHdP7b8lTB4OQNhqOWQMfGCnIPo1r5dqYaePo3BICLqJZ71fLyu6x
         ugJQ==
X-Gm-Message-State: AOJu0YxWkfK3T4dhs1TUpSaLo0FkQhX9QvydYQq6CBNJg2RAMGnxWmXr
	M9fmkbVQ4/dWa+eVVZoF+PXtU0SPoYYc8y4K5bodhRzN7er+jRj+UWFsFA==
X-Gm-Gg: ASbGncslqdjkZi72lIPuSnN2vQrLrLdwVT0863gMSMqGR+6DeVjED3czMquI0UHY/X2
	NaOeE/KWF10KvSlZkYG1xFqPMwc/OkUGJo5z24xnNw8mXCWboSrAhkY+fmHgBHoi6tu/d8uF7/C
	J2wRX+GDFaOhXNW65OP6BoNOMwPCLNpocmbYBw8Oi0M4grlGTCroo7ZqXzxAoK6msTBDh1AfnhG
	iX9wvdfXD3ihClCFUpwbWm/UOLmMzrQGlA20VPmX6iVlTdxXisD2gk5yVQJGUxf40g9KA8bq1W1
	M1RO2mwFKLxZRnlkVNl6Uvq2+M74kWHqfJhO3AUbJ2SLxQ==
X-Google-Smtp-Source: AGHT+IGCWYd8hhBvGXRa9AcY+X06zoKWRMNEJCjK7himXHVVYcRKNyMFY9oA52/I2otWwK2qjSLAeQ==
X-Received: by 2002:a05:6300:6308:b0:1e1:bdae:e04a with SMTP id adf61e73a8af0-1e1bdaee397mr630111637.39.1733830595117;
        Tue, 10 Dec 2024 03:36:35 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd54aa2399sm2554532a12.39.2024.12.10.03.36.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:36:34 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/8] t5504: modernize test by moving heredocs into test bodies
Date: Tue, 10 Dec 2024 19:36:21 +0800
Message-Id: <4e509ef20465dc2a818f479b34e11df415e39906.1733830410.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1733830410.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com> <cover.1733830410.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Steinhardt <ps@pks.im>

We have several heredocs in t5504 located outside of any particular test
bodies. Move these into the test bodies to match our modern coding
style.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5504-fetch-receive-strict.sh | 35 +++++++++++++++------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 53dbc8ce3a..488310c340 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -64,12 +64,6 @@ test_expect_success 'fetch with transfer.fsckobjects' '
 	)
 '
 
-cat >exp <<EOF
-To dst
-!	refs/heads/main:refs/heads/test	[remote rejected] (missing necessary objects)
-Done
-EOF
-
 test_expect_success 'push without strict' '
 	rm -rf dst &&
 	git init dst &&
@@ -78,6 +72,11 @@ test_expect_success 'push without strict' '
 		git config fetch.fsckobjects false &&
 		git config transfer.fsckobjects false
 	) &&
+	cat >exp <<-EOF &&
+	To dst
+	!	refs/heads/main:refs/heads/test	[remote rejected] (missing necessary objects)
+	Done
+	EOF
 	test_must_fail git push --porcelain dst main:refs/heads/test >act &&
 	test_cmp exp act
 '
@@ -94,11 +93,6 @@ test_expect_success 'push with !receive.fsckobjects' '
 	test_cmp exp act
 '
 
-cat >exp <<EOF
-To dst
-!	refs/heads/main:refs/heads/test	[remote rejected] (unpacker error)
-EOF
-
 test_expect_success 'push with receive.fsckobjects' '
 	rm -rf dst &&
 	git init dst &&
@@ -107,6 +101,10 @@ test_expect_success 'push with receive.fsckobjects' '
 		git config receive.fsckobjects true &&
 		git config transfer.fsckobjects false
 	) &&
+	cat >exp <<-EOF &&
+	To dst
+	!	refs/heads/main:refs/heads/test	[remote rejected] (unpacker error)
+	EOF
 	test_must_fail git push --porcelain dst main:refs/heads/test >act &&
 	test_cmp exp act
 '
@@ -129,15 +127,14 @@ test_expect_success 'repair the "corrupt or missing" object' '
 	git fsck
 '
 
-cat >bogus-commit <<EOF
-tree $EMPTY_TREE
-author Bugs Bunny 1234567890 +0000
-committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
-
-This commit object intentionally broken
-EOF
-
 test_expect_success 'setup bogus commit' '
+	cat >bogus-commit <<-EOF &&
+	tree $EMPTY_TREE
+	author Bugs Bunny 1234567890 +0000
+	committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
+
+	This commit object intentionally broken
+	EOF
 	commit="$(git hash-object --literally -t commit -w --stdin <bogus-commit)"
 '
 
-- 
2.47.0.rc1.21.g81e7bd6151

