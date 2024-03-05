Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7212D1E6
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 22:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709676562; cv=none; b=b6dn6k+pTcTh/KwN/esojoWnaU4WsVlhu3sTHVablqhIOPBu4LRRQtQxGF7fvOXTthMwYfRrbTqAKIdTD8egn3X1v+5judE7pXk2QNwC6cNPqOzzW/kUV7fWd/M3XivFl+hCTY6t0UXNbtZSAMZdFDPxAaw+E3+UhOdrS4MLC18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709676562; c=relaxed/simple;
	bh=y19laeeNxiOyiXse2ps5dFmPXCN1fWTbUx4gvkOGQUw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cN6SVkMILIgVVl99SUQ1LC8C+e+Xbg3lwrYkozbl0i966kbKkUX6wItXPBKzgnXqZWMpw/EkupIAiwRPxnzDfJgZ4LvoCeqj0W9sfpgjDu6oe+RnLbQ4yiRBlWuxisg08CImVBD9jw54ztkTWcUKXybVHGAomottsaEUfnb5x7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWq82cXK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWq82cXK"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412ea23a750so1365355e9.0
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 14:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709676559; x=1710281359; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ID5+argLu5Pfd1ZZN3zNPIVDh35JfHbNB9d2T3GGsV8=;
        b=ZWq82cXKGogpGHBoPZ32uUSxZydoP64MSKIVhR4Z/GS/f/dbCH2ybGWwIss9zFjGKu
         avoL0J7/O2f7CzSvSr8V86GEoF2gj/NwHxAm8SmpmsTKRKCYl3whEPQhJxciA4wLY6BO
         9NmaXAik7+f4YBxguA8jISWgCeJX/RwciGFKfuRYydRnR3wkOB6kAXmwQgST0lIqfkfP
         liX1FV/FpOoRUxjPdRj0mJ/XzsMed9T7fYLhL97CChatMkEj4684fms0BhZDVih4Z583
         yGWuUjNYBKUOhnxB2454fRZIF9KZmQu1brl2tNQb4v+z3lrPb1wvJkbtS7VcZPFuDKWW
         wyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709676559; x=1710281359;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ID5+argLu5Pfd1ZZN3zNPIVDh35JfHbNB9d2T3GGsV8=;
        b=PH8cw7zlRVUyyz2n2U0pEifEwqnClP2V3KXHbvKOkdrP86BaLFiH6FXL3qiRdKZsaL
         O+uHz8Wu51heIC2IDFzDIO58ukDzzfDTRcaAwT+vzXG5i95gHcSPExbQU2UlA0X4ahLy
         0A3ZVQeB9chNVKmtyPq1w52ix/cuZKa/sqxYz3SPQwIHzFGJu1K2H3kXg9QK2HUyfFGK
         KJAovWD+0XnOv0P3raHh1Tf+v5yNRdzRq9jwymM3AobDodSNlViQM8j1z7vOIf4Us8x5
         UNtVv8/hcLp34gAiPW1fnqrjmu+oMKBLR+NG6k+Sw7khRsZ5e/WVWInfXLz/fA2Puv0r
         mrpA==
X-Gm-Message-State: AOJu0YzOXGZcGte1UuV8y1ph8XflUCUKZ3pSYI3TivmsW4WnQse6lEyF
	zycPwOhOiNevcxqtDhbWhrqxdWG5CrX6fYsp3Mb7t9dj9+5eWTeNwMc3pPhK
X-Google-Smtp-Source: AGHT+IFDFV+mHR9dm8ve7+ZaREdGEiqYm2E4aa/HbyrrYPTgRgf30akRZxYXY7j6DCRbDHz9KoB57g==
X-Received: by 2002:a05:600c:5207:b0:412:f3af:c6c6 with SMTP id fb7-20020a05600c520700b00412f3afc6c6mr343222wmb.10.1709676558670;
        Tue, 05 Mar 2024 14:09:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d5503000000b0033dabeacab2sm15885742wrv.39.2024.03.05.14.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 14:09:18 -0800 (PST)
Message-ID: <pull.1675.v3.git.1709676557639.gitgitgadget@gmail.com>
In-Reply-To: <pull.1675.v2.git.1709243831190.gitgitgadget@gmail.com>
References: <pull.1675.v2.git.1709243831190.gitgitgadget@gmail.com>
From: "Aryan Gupta via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Mar 2024 22:09:17 +0000
Subject: [PATCH v3] tests: modernize the test script t0010-racy-git.sh
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Patrick Steinhardt [ ]" <ps@pks.im>,
    "Michal =?UTF-8?Q?Such=C3=A1nek?= [ ]" <msuchanek@suse.de>,
    "=?UTF-8?Q?Jean-No=C3=ABl?= AVILA [ ]" <jn.avila@free.fr>,
    Kristoffer Haugsbakk <[code@khaugsbakk.name]>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Aryan Gupta <garyan447@gmail.com>,
    Aryan Gupta <garyan447@gmail.com>

From: Aryan Gupta <garyan447@gmail.com>

Modernize the formatting of the test script to align with current
standards and improve its overall readability.

Signed-off-by: Aryan Gupta <garyan447@gmail.com>
---
    [GSOC][PATCH] Modernize a test script

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1675%2Faryangupta701%2Ftest-modernize-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1675/aryangupta701/test-modernize-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1675

Range-diff vs v2:

 1:  fa381d0b57a ! 1:  05ee9e8a458 tests: modernize the test script t0010-racy-git.sh
     @@ Commit message
          Signed-off-by: Aryan Gupta <garyan447@gmail.com>
      
       ## t/t0010-racy-git.sh ##
     -@@
     - #!/bin/sh
     +@@ t/t0010-racy-git.sh: TEST_PASSES_SANITIZE_LEAK=true
       
     --test_description='racy GIT'
     -+test_description='racy git'
     - 
     - TEST_PASSES_SANITIZE_LEAK=true
     - . ./test-lib.sh
     -@@ t/t0010-racy-git.sh: do
     - 	echo xyzzy >infocom
     - 
     - 	files=$(git diff-files -p)
     + for trial in 0 1 2 3 4
     + do
     +-	rm -f .git/index
     +-	echo frotz >infocom
     +-	git update-index --add infocom
     +-	echo xyzzy >infocom
     +-
     +-	files=$(git diff-files -p)
      -	test_expect_success \
      -	"Racy GIT trial #$trial part A" \
      -	'test "" != "$files"'
     +-
      +	test_expect_success "Racy git trial #$trial part A" '
     -+		test "" != "$files"
     ++		rm -f .git/index &&
     ++		echo frotz >infocom &&
     ++		git update-index --add infocom &&
     ++		echo xyzzy >infocom &&
     ++
     ++		git diff-files -p >out &&
     ++		test_file_not_empty out
      +	'
     - 
       	sleep 1
     - 	echo xyzzy >cornerstone
     - 	git update-index --add cornerstone
     +-	echo xyzzy >cornerstone
     +-	git update-index --add cornerstone
       
     - 	files=$(git diff-files -p)
     +-	files=$(git diff-files -p)
      -	test_expect_success \
      -	"Racy GIT trial #$trial part B" \
      -	'test "" != "$files"'
     --
      +	test_expect_success "Racy git trial #$trial part B" '
     -+		test "" != "$files"
     ++		echo xyzzy >cornerstone &&
     ++		git update-index --add cornerstone &&
     + 
     ++		git diff-files -p >out &&
     ++		test_file_not_empty out
      +	'
       done
       


 t/t0010-racy-git.sh | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/t/t0010-racy-git.sh b/t/t0010-racy-git.sh
index 837c8b7228b..84172a37390 100755
--- a/t/t0010-racy-git.sh
+++ b/t/t0010-racy-git.sh
@@ -10,25 +10,24 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 for trial in 0 1 2 3 4
 do
-	rm -f .git/index
-	echo frotz >infocom
-	git update-index --add infocom
-	echo xyzzy >infocom
-
-	files=$(git diff-files -p)
-	test_expect_success \
-	"Racy GIT trial #$trial part A" \
-	'test "" != "$files"'
-
+	test_expect_success "Racy git trial #$trial part A" '
+		rm -f .git/index &&
+		echo frotz >infocom &&
+		git update-index --add infocom &&
+		echo xyzzy >infocom &&
+
+		git diff-files -p >out &&
+		test_file_not_empty out
+	'
 	sleep 1
-	echo xyzzy >cornerstone
-	git update-index --add cornerstone
 
-	files=$(git diff-files -p)
-	test_expect_success \
-	"Racy GIT trial #$trial part B" \
-	'test "" != "$files"'
+	test_expect_success "Racy git trial #$trial part B" '
+		echo xyzzy >cornerstone &&
+		git update-index --add cornerstone &&
 
+		git diff-files -p >out &&
+		test_file_not_empty out
+	'
 done
 
 test_done

base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
-- 
gitgitgadget
