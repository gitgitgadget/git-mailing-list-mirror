Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F60101FF
	for <git@vger.kernel.org>; Sat, 24 May 2025 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748058051; cv=none; b=u/wpfHjXhxItr5Zf8YRiVUzbpLg7R4eeqe3uTbc1ZHSv5bkZXfHmvL3hH3g03BWSqBGQyvfkpkC42YVfK96FFOD6LatgS+KPW1uWokKcQLXY5iHiN9HPqgZ+Akhuz/6YWs/3OdR0aYQbz7ZhO9GbO68MYdHMtFjyPsg9ceiEVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748058051; c=relaxed/simple;
	bh=96CgxlCG+sgfISgF8zo/zX2ng6rQhGyOnrDhAkcmn64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQGeLKy9cK0Or4WVZCQ1MxKdBv+GwgQx2izwGreOZ92bwfmaHGEjP5Hhj6op37ROu6P04ZlldWUU2zO4kitXdoVDXUC5iBD4nUaS5ECXF6mjqlzcGPMPjib90sxmMjyIq55SWDLHhFENT1SbW7KZcZYBQBVBLm6s3xW1FXJpfyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I9kku5Ll; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I9kku5Ll"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-476ac73c76fso6154831cf.0
        for <git@vger.kernel.org>; Fri, 23 May 2025 20:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748058049; x=1748662849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdgWeV0ruU8FqhAVhx3V935BVOO/Jzv6RmPhV4eVXqI=;
        b=I9kku5Llc/7RvvpJspI6WG5LsKsM7I7UYbIE1WbOHb7DLzHkvqewv+FcodYk6gl0X2
         nJ9QULYgsYn4aptObXLX2TECgx34T1z5G3PCuaPSAzAxrHwLmuAFYeoJGwVKpEn9b8nh
         f7R/c7Zttru9AZAXRBmV3a49Crh4Adlp6uIAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748058049; x=1748662849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdgWeV0ruU8FqhAVhx3V935BVOO/Jzv6RmPhV4eVXqI=;
        b=Uhxx8gO/Q6wHzMK47ONQPSSkOOeRA3JXDTFd1mMi3SWp+PgrI45d+N8BW/v+ZWaDZT
         W8ZUGr7snh3y6rdeuHV+USvXn+ZXxmMmnMWkXTf5Wh6X7NbLNJDrM7p64Ij2PTkqAgjn
         sjEOV0V8wa+Af7ULAMZuwmdE2iPRwCMj32ShQXWRe1wixOKfRM6pLLx8AU+0FTlS97rD
         UIdc+GnxDw7Mpr18/zP43to2G1KW/ykN5xt7jrmEIb2hcHiCaCAaSgBMmR8LPD6xbnkr
         jQRe4l+K5rO6HX/FInYrzBicF9OlczuoiDLfH1t23I+GQduQ9Dy6gzZUdjWe2U8ikBRE
         oAeQ==
X-Gm-Message-State: AOJu0YziGCXAb6GGE3Q4Plpzb9+9xK57piemCU/cp1i5hswDZslFNB9q
	M5AHUpIGhvpS9GliAsYZJf69A2ngHx8tAg0TCZJFYhZE1JZ+5JfXcsEje3u5VJ9XoFts9W0qfRP
	rfExVzw==
X-Gm-Gg: ASbGnctv2swl/otBe1d/l7jLoOQuTkBmtFwgsrsZgQtcn1bgiMcZ/XcK03bPvuwYSwl
	DjtjWiYX/JqEe/yO37SWxsTGcuWnfOV3n43QnZ0CaMhtn8B0fLY+lhQJKwiS9au8R5KiEobdr/0
	2Q01fW1DWAwTTSsyJobOMDJC2GJF++YuRJ/hTRfKYaRpZeRYxAGEByQVJAsjl7VIaHC3u1vXQ46
	GZtA8RlIyDVv4595KTM+VFBffBdFNgqs3elBe189hRe4E6x3AlOFb/TUjWAHkBlCc3CSv6vWZYH
	27Z+n1Q8Z23CTjpTdBz7lPoTrCbP913+vrNmksnGBKwZtE7bY8JvAyI/XK+PThcN1KwEK+s=
X-Google-Smtp-Source: AGHT+IGPN3h2gpS1CavMrhoj41E1hMjm+9jR+hetf7aO6Q7RmoQpRZa/quPwcsR9doQRqlCJ5ik+ng==
X-Received: by 2002:a05:622a:4a12:b0:478:f747:1b7d with SMTP id d75a77b69052e-49f460571damr23662071cf.6.1748058048822;
        Fri, 23 May 2025 20:40:48 -0700 (PDT)
Received: from redacted ([2600:4040:9ce0:6400:e585:dc50:f5e1:64e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-497ae224a4bsm99001731cf.76.2025.05.23.20.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 20:40:48 -0700 (PDT)
From: Mark Mentovai <mark@chromium.org>
To: Git Development <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3 1/2] t4129: test that git apply warns for unexpected mode changes
Date: Fri, 23 May 2025 23:40:45 -0400
Message-ID: <20250524034046.2619-2-mark@chromium.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250524034046.2619-1-mark@chromium.org>
References: <20250523172154.93810-1-mark@chromium.org>
 <20250524034046.2619-1-mark@chromium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no test covering what commit 01aff0a (apply: correctly reverse
patch's pre- and post-image mode bits, 2023-12-26) addressed. Prior to
that commit, git apply was erroneously unaware of a file's expected mode
while reverse-patching a file whose mode was not changing.

Add the missing test coverage to assure that git apply is aware of the
expected mode of a file being patched when the patch does not indicate
that the file's mode is changing. This is achieved by arranging a file
mode so that it doesn't agree with patch being applied, and checking git
apply's output for the warning it's supposed to raise in this situation.
Test in both reverse and normal (forward) directions.

Signed-off-by: Mark Mentovai <mark@chromium.org>
---
 t/t4129-apply-samemode.sh | 70 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 5 deletions(-)

diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index 2149ad5da44c..bf4e7609dc33 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -102,15 +102,23 @@ test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
 	)
 '
 
+test_file_mode_staged () {
+	git ls-files --stage -- "$2" >ls-files-output &&
+	test_grep "^$1 " ls-files-output
+}
+
+test_file_mode_HEAD () {
+	git ls-tree HEAD -- "$2" >ls-tree-output &&
+	test_grep "^$1 " ls-tree-output
+}
+
 test_expect_success 'git apply respects core.fileMode' '
 	test_config core.fileMode false &&
 	echo true >script.sh &&
 	git add --chmod=+x script.sh &&
-	git ls-files -s script.sh >ls-files-output &&
-	test_grep "^100755" ls-files-output &&
+	test_file_mode_staged 100755 script.sh &&
 	test_tick && git commit -m "Add script" &&
-	git ls-tree -r HEAD script.sh >ls-tree-output &&
-	test_grep "^100755" ls-tree-output &&
+	test_file_mode_HEAD 100755 script.sh &&
 
 	echo true >>script.sh &&
 	test_tick && git commit -m "Modify script" script.sh &&
@@ -126,7 +134,59 @@ test_expect_success 'git apply respects core.fileMode' '
 	test_grep ! "has type 100644, expected 100755" err &&
 
 	git apply --cached patch 2>err &&
-	test_grep ! "has type 100644, expected 100755" err
+	test_grep ! "has type 100644, expected 100755" err &&
+	git reset --hard
+'
+
+test_expect_success 'setup: git apply [--reverse] warns about incorrect file modes' '
+	test_config core.fileMode false &&
+
+	>mode_test &&
+	git add --chmod=-x mode_test &&
+	test_file_mode_staged 100644 mode_test &&
+	test_tick && git commit -m "add mode_test" &&
+	test_file_mode_HEAD 100644 mode_test &&
+	git tag mode_test_forward_initial &&
+
+	echo content >>mode_test &&
+	test_tick && git commit -m "append to mode_test" mode_test &&
+	test_file_mode_HEAD 100644 mode_test &&
+	git tag mode_test_reverse_initial &&
+
+	git format-patch -1 --stdout >patch &&
+	test_grep "^index .* 100644$" patch
+'
+
+test_expect_success 'git apply warns about incorrect file modes' '
+	test_config core.fileMode false &&
+	git reset --hard mode_test_forward_initial &&
+
+	git add --chmod=+x mode_test &&
+	test_file_mode_staged 100755 mode_test &&
+	test_tick && git commit -m "make mode_test executable" &&
+	test_file_mode_HEAD 100755 mode_test &&
+
+	git apply --index patch 2>err &&
+	test_grep "has type 100755, expected 100644" err &&
+	test_file_mode_staged 100755 mode_test &&
+	test_tick && git commit -m "redo: append to mode_test" &&
+	test_file_mode_HEAD 100755 mode_test
+'
+
+test_expect_success 'git apply --reverse warns about incorrect file modes' '
+	test_config core.fileMode false &&
+	git reset --hard mode_test_reverse_initial &&
+
+	git add --chmod=+x mode_test &&
+	test_file_mode_staged 100755 mode_test &&
+	test_tick && git commit -m "make mode_test executable" &&
+	test_file_mode_HEAD 100755 mode_test &&
+
+	git apply --index --reverse patch 2>err &&
+	test_grep "has type 100755, expected 100644" err &&
+	test_file_mode_staged 100755 mode_test &&
+	test_tick && git commit -m "undo: append to mode_test" &&
+	test_file_mode_HEAD 100755 mode_test
 '
 
 test_expect_success POSIXPERM 'patch mode for new file is canonicalized' '
-- 
2.49.0

