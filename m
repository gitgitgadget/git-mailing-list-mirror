Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675A0347A2
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744479662; cv=none; b=Iy6Ddec8rOTpp0yCC4tQfWJV9+RjTv+vvFDLIGzc3qR2Wbx0cCMZxyFdtj6RG53p1l1zh5brQlZCAXEYCh2o1LAzpfLEMVdqPK4mBV220kPES+vWfZz5Lk2o9XI9Prg4AMczZNnMKOHcdeG/JYGhkheLNbyUR50W7l48nsT2l44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744479662; c=relaxed/simple;
	bh=gpdT0AL68btDpMbWWZI6ps5+SdhXyjPNs4Bdno6GJ1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVndbpJti4nwIBLm6nxDbCDXoHv3Q2TKUgKXcTsed6OD4aJ9eoXpilp2ISrCpiTXl+H6b/45VG59CdKPmW5vlU1mVLJpZWMdeNXA0xL2X/23ut6HNGyXxqupOZp6OAWGEKhtsu2C8phxUhDaZ9YeN1fCkmOuoY+SJwyjKHbAF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvWO0Q5i; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvWO0Q5i"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-afc857702d1so2759087a12.3
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 10:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744479660; x=1745084460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaTBEJfSZkTsEYW0rNVZYgamuZu9Q7eH64+6QnRKdSQ=;
        b=HvWO0Q5iFvHfhJeSOrC85XC5ar4gq0XyUHiRTMtUJ2p8tefc2sCoM9Wj7N1+f9LJel
         J1ltaRVPROiMmdJHUEAx7+JVpURE+tmU2Db3mZ7gs1VtLTUoeLLHzgBpDGqjPX8ZjBsk
         9eJm6OzxY3jqiFJBRHypYDtQ6q/L3kggrlUk1re9lmO3Nv5DpKu/25FBvgiwb1VNcK8Z
         Ox/cWCpkuqCpYHHS2xWyGDJRGzX4TLBhm2MqArAqh7cccEKJBrby4cH28+oUSnI2Ou98
         0+RBpFhORopjGH2znoOZkhuFePfYhBhA9gVdkx2UUFaipvrdby3tXso28ekCPICT29te
         oBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744479660; x=1745084460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaTBEJfSZkTsEYW0rNVZYgamuZu9Q7eH64+6QnRKdSQ=;
        b=cphNCx7dk4Pls2g3QTAikI6xxDEz2wehw1XkL3Tl7jK36eUHe3e6LrAXH2TOzkDfbH
         31j5/J1dPevSfYNXChspBbc6fRf94anesuvPbvI3rILrAqeWS7u5xWw5Bi3CY+qmoiH5
         AeDWjo6BNAn5KAxH54Tb4Zs5M/VAibSXsdF2UHha5yh7//Xeqv/upWDHrF3hCwFeRGqO
         HvQI3h1EQtWecSVAPBgw5R4PRLwZ+HWbsL4TniY5Oa1b4CiTH0bKo1+b2Wljmbq+/UJ8
         tbFRIwQJcR56uWxYUhdN04cS65UC4lvlFRmb6n8yM0OArTRQIKh2AHkHGYs2+qFRg+K9
         OPBg==
X-Gm-Message-State: AOJu0YzGr750xQuJ06u1ZSnFpvBsYITMS6casvX92VN+PHWbycR5vC8X
	9hWDzv3W95OaR/ZeZ65G0EcGzsWA2alkJ7N3+PebEXNA9+ZxRJRrEKKlAw==
X-Gm-Gg: ASbGnctvkS+pL5+7OsxBY+8R4A5u67CYnBR9HspYmG3lytfC0wFufaY9Z+VMneIOt67
	yTGT5sF5R2CdeDm6XmN4KK9r167TuVUuIIq3iBP0uGvFqdgQoTPljxkR8KZ+T1lnB9ST1W6NQ3U
	jZ86DXNuhOyto6kJ89hk5YZURL/ad8jTsvPxR5vbAlrZ00Ae3xxQ0NnhtO7nJ2plpYd0n2wD4i0
	lJRVTsAPc//TXqR8vlezP2FWhX77iqHrJ4uEoy3SOihGAyT5NuB/VzX+7C8zaCVxWMElMvt2lRM
	XlyirWmXaTncpwJWK/LkU35q4GHueKmAseU3fXN3tShZjcl/0PbDxfQ8JC1Pfg0GQHI97nfVPC4
	=
X-Google-Smtp-Source: AGHT+IEv3vY3r5rbQN4sUvN7btsrGvggJAeM9sLWoqMRci1p+nrPkDEsJCHSm540Away9yXzdADiEQ==
X-Received: by 2002:a05:6a21:e86:b0:1f5:7873:3052 with SMTP id adf61e73a8af0-2017979a29bmr10366537637.11.1744479660612;
        Sat, 12 Apr 2025 10:41:00 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c005:b018:5841:514c:af52:5598])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a321edf6sm6657839a12.65.2025.04.12.10.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 10:41:00 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	peff@peff.net,
	piotrsiupa@gmail.com
Subject: [PATCH] t3706: Add test for wildcard vs literal pathspec
Date: Sat, 12 Apr 2025 23:10:51 +0530
Message-ID: <20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250412094607.236382-2-jayatheerthkulkarni2005@gmail.com>
References: <20250412094607.236382-2-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When 'git add <pattern>' is run, and a file exists whose literal
name matches <pattern> (e.g., a file named "f*" when running
'git add f*'), Git should treat the pattern as a wildcard
matching multiple files, rather than just adding the literal file.

Add a test case that:
 1. Creates files 'f*', 'f**', and 'foo'.
 2. Verifies that 'git add "f\*\*"'
    correctly adds only the literal file 'f**'.
 3. Verifies that 'git add 'f*'' (quoted to prevent shell expansion)
    correctly adds 'f*', 'f**', and 'foo' by treating 'f*' as a
    wildcard.

Covering these the test adds 5 cases.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 t/meson.build                   |  1 +
 t/t3706-add-wildcard-literal.sh | 44 +++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100755 t/t3706-add-wildcard-literal.sh

diff --git a/t/meson.build b/t/meson.build
index 8b3aed14ea..e9cd9da8a2 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -417,6 +417,7 @@ integration_tests = [
   't3703-add-magic-pathspec.sh',
   't3704-add-pathspec-file.sh',
   't3705-add-sparse-checkout.sh',
+  't3706-add-wildcard-literal.sh',
   't3800-mktag.sh',
   't3900-i18n-commit.sh',
   't3901-i18n-patch.sh',
diff --git a/t/t3706-add-wildcard-literal.sh b/t/t3706-add-wildcard-literal.sh
new file mode 100755
index 0000000000..0fc27b28ac
--- /dev/null
+++ b/t/t3706-add-wildcard-literal.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description='git add: wildcard must not be shadowed by literal filename'
+
+. ./test-lib.sh
+
+test_expect_success 'setup: create files and initial commit' '
+    mkdir testdir &&
+    >testdir/f\* &&
+    >testdir/f\*\* &&
+    >testdir/foo &&
+    git add testdir &&
+    git commit -m "Initial setup with literal wildcard files"
+'
+
+test_expect_success 'clean slate before testing wildcard behavior' '
+    git rm -rf testdir &&
+    git commit -m "Clean state"
+'
+
+test_expect_success 'recreate files to test add behavior' '
+    mkdir testdir &&
+    >testdir/f\* &&
+    >testdir/f\*\* &&
+    >testdir/foo
+'
+
+test_expect_success 'quoted literal: git add "f\\*\\*" adds only f**' '
+    git reset &&
+    git add "testdir/f\\*\\*" &&
+    git ls-files >actual &&
+    echo "testdir/f**" >expected &&
+    test_cmp expected actual
+'
+
+test_expect_success 'wildcard: git add f* adds f*, f** and foo' '
+    git reset &&
+    git add '\''testdir/f*'\'' &&
+    git ls-files | sort >actual &&
+    printf "%s\n" "testdir/f*" "testdir/f**" "testdir/foo" | sort >expected &&
+    test_cmp expected actual
+'
+
+test_done
\ No newline at end of file
-- 
2.49.0

