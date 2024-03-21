Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880C1134414
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049969; cv=none; b=AgwEcNifN88MPsu8Z1tO+6X8ye0Osp3vQ/ZZ8u/pgGlPRz2kbKy99ARweJKWWpmZh/kQtAbILAZu8FwIQbLBjC5pJZPoY+ugu0yytyH1eAxWVYNCRCvBIT41ckEegTYwXuBob9CHSShiHmoI/Vsisw46GDwublUmNTSxWz+p31s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049969; c=relaxed/simple;
	bh=TGhdwus/VX5J85zeAR/7/1Y5HkTTqocOu67CB4CQrw4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RQR9qmqjbopnWWnOXOSd/VxidxYde8vXrd6gOzWT46enHqfcGegDol5KNf4Dsv+yU1DMf6eKcDypTAkFV/FkZtaLqX+VTV7W7Y1CdS33qdfhLLQzTAS2z+b4PVgDrGBbg+u3jDpPP0qJ7CXnV7BBeiOjo6X4dfhIFSV0VKSnIwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEhn9F47; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEhn9F47"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41477211086so6321935e9.1
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711049965; x=1711654765; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfzqRUpikjr4tFiZDQnD+q7FE5fMKcEiqXBSb22F80M=;
        b=lEhn9F47LPIsrg4ybNolJAcbfhaQdd0bAxotv5cWGTm/YYGnfqiwM5hzvFfT3//llk
         ggPSfHAxNqw2vNhdXJo7vGkRjZUfUQR2MfUrFXD/wSmJ9ho9/8X/FsSJ8Zab7MnRXE29
         jbL22hIhdRpTfxEqwOMw3iGGIk/KpG7K7Q6Ma5Gj4SPmG1vh04/OSyhqVTETyyAjfR/M
         AS9QXvV/aZTmZEruAQddQ75fYJpDHidyeJaQXWqrnHEdNvJDRE8m1A7D1zZ8K7n3arSa
         /P2SYK6FMNWEjNWOsJoVHNaT572d8QnEj04RZETCbT4hxNkDld4NgtJF17UjK1j4zAKN
         FL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711049965; x=1711654765;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfzqRUpikjr4tFiZDQnD+q7FE5fMKcEiqXBSb22F80M=;
        b=nqRcqwx1oOZC4nTtBIaTJICvFxCiS3KdNPSBsLFlvjGSN3+5RfkSLKqHDFFPfc+mr3
         pd5Qb8WgMLKOYjgW/v6XsRYQKKHEXRvPyH1SZXoPSwNxFXNqbqMP5BL5oad56wsnYm4E
         yvzaBsxXwmvnVRxLCBP1AyW5FGNzFqm3LV/g816xeIEVkeyNi/SbY62r78VpyctSlVdV
         BEi4RMhhmquWdcKHaEjOb1WhjN/JbxLO/MgWGWz287GoVMj4Cl6leAVI6CK8I/knqD+e
         8SSZMa5d2oAPVz1NTJSE52q2CDZpgjNfaFSrwxb9afGKCVVPdQlqlAwPmtmJ8jahP7YY
         Rtjw==
X-Gm-Message-State: AOJu0YyCLL+FK9jMdyq3EGDsOXIi7VBMCc0rIo/N8NOxrQtLic/sjz2z
	beWy8hYjqO+bIl7pkrrMRr0DSrIhVspOrTUOa7MVXFHKPekfJDjv1kE2bY+J
X-Google-Smtp-Source: AGHT+IFQfcvDFJpkLlFCh3jzKIEYNKrjL2yQmE7ylP5JP2p2rl27m38nPks4SZ2tZeGteu2m/W/Lfw==
X-Received: by 2002:a05:600c:5116:b0:413:1606:ba64 with SMTP id o22-20020a05600c511600b004131606ba64mr97785wms.26.1711049965182;
        Thu, 21 Mar 2024 12:39:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n39-20020a05600c3ba700b0041409cabb39sm6522913wms.18.2024.03.21.12.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 12:39:24 -0700 (PDT)
Message-ID: <b541ce7a49cedee5a3044af8b52bf1d155496211.1711049963.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1691.git.git.1711049963.gitgitgadget@gmail.com>
References: <pull.1691.git.git.1711049963.gitgitgadget@gmail.com>
From: "sanchit1053 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Mar 2024 19:39:22 +0000
Subject: [PATCH 1/2] t9803-git-p4-shell-metachars.sh: update to use
 test_path_* functions
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
Cc: Sanchit Jindal <sanchit1053@gmail.com>,
    sanchit1053 <sanchit1053@gmail.com>

From: sanchit1053 <sanchit1053@gmail.com>

Signed-off-by: sanchit1053 <sanchit1053@gmail.com>
---
 t/t9803-git-p4-shell-metachars.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t9803-git-p4-shell-metachars.sh b/t/t9803-git-p4-shell-metachars.sh
index 2913277013d..4905ed2ae9e 100755
--- a/t/t9803-git-p4-shell-metachars.sh
+++ b/t/t9803-git-p4-shell-metachars.sh
@@ -33,8 +33,8 @@ test_expect_success 'shell metachars in filenames' '
 	(
 		cd "$cli" &&
 		p4 sync ... &&
-		test -e "file with spaces" &&
-		test -e "foo\$bar"
+		test_path_exists "file with spaces" &&
+		test_path_exists "foo\$bar"
 	)
 '
 
@@ -52,8 +52,8 @@ test_expect_success 'deleting with shell metachars' '
 	(
 		cd "$cli" &&
 		p4 sync ... &&
-		test ! -e "file with spaces" &&
-		test ! -e foo\$bar
+		test_path_is_missing "file with spaces" &&
+		test_path_is_missing foo\$bar
 	)
 '
 
@@ -100,8 +100,8 @@ test_expect_success 'branch with shell char' '
 		git p4 clone --dest=. --detect-branches //depot@all &&
 		git log --all --graph --decorate --stat &&
 		git reset --hard p4/depot/branch\$3 &&
-		test -f shell_char_branch_file &&
-		test -f f1
+		test_path_is_file shell_char_branch_file &&
+		test_path_is_file f1
 	)
 '
 
-- 
gitgitgadget

