Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122D413C3EE
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720046190; cv=none; b=N5cMUD5dvuflP2MKPzWFo8QrSwBHLyFkALRp0SU325w5U9KudyTLt1ZbaFE18ewXeNTqjVaRa6P5NvNDSB5vSmgk3BglxUDphUqZDOz1Cd19NffdCXkM7XCxNkJ6zNPI6KDUwWJIiTreb0LR7qQL1k8SvmL+P1Vtr1ulsFAozn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720046190; c=relaxed/simple;
	bh=YFpJuvuQcI295JNvQjbw6t7EjoFraq4m+FhxVi9GiGk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=aNsc5opMU4hgDk6+O20iBQ4RPkqXAFX08Y/fRmywreRKUme6D4glSNG/A1jP6mXwTrQdnSfmX5jxwRfQvUl189tS2+S7w9FHUgNOIuZuKnWMu+2GxDnznPZW+qVSdpzeP2yjaCd+cXK3/wRifD93YCmJObMxUvPgX4bMTiIYeW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt+4AFGo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt+4AFGo"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42562e4b5d1so41422135e9.1
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 15:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720046187; x=1720650987; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Aqwzu6hxiTwDmX5GPwPbmFodvOgXVJJzg9RQF9eRO4g=;
        b=Gt+4AFGoua1BptavsMdKRqe7LaLX0QRnp5jtQRukzSukxF1BPJDgGDVVHE1XoKUg5D
         u1CLGN1/NG4WGkSMPFUwLDIE5cxLSABKXH1+gtuvMlGKTRkpipQT1QzVN1BcVUGVv+5T
         EjR7bKVwSzryItOlWilclbtBXi5qbPX9Xy1VKvLI78NnSEae/e67JUsgzoWT+YSctxkQ
         AnY6gI+ha7WA6crnQnzSK9orlx0ijyRExEuVg37aQdLrBkOQajK9bXDIhLe3VZXkn62p
         gl7HLDEjliwl2AWBi403mTAoppFx7aEgISbgXZeEc3OPsXtbnq/lbERjKp0r5+lPMa2i
         K7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720046187; x=1720650987;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aqwzu6hxiTwDmX5GPwPbmFodvOgXVJJzg9RQF9eRO4g=;
        b=vJ7LCEmse/teD08XFWP0f9LMCnMSWG6UigEldoqgdxYmNoQgsvJ1kpYvVYSg6tDy4H
         Kl0D02bf61oxtIRKZOokCfoOtTC7NiyvIr5OKWUbHB9n9v6YY51d/2+AFHxHokxIjGeL
         uETsqexA3r5hBkjhtPSu7JXyh89PcCaJVLx7rzbxAjL+PQZPgDblz7eki88fOtqCoy2m
         zFn5wiEnV0BZQGTByseyGzE4Fk8RtZl3hW7J4r1wsGw6a+SSdy8sfeiismobmJtya80w
         g6ZzDUuxNiznXJQ0ZvRJ1AyTYE4Xx+o964wgti1d9OknbMx3q3HosJ5q6BEI0p4sLrTW
         Pnnw==
X-Gm-Message-State: AOJu0YwtDRqNiFoQ2Mdbv7HmjRh0AYa7ppAfWZmxU8htGIpaaUyIeQ++
	fgQeZBGfMw0yZbIGermEFNU1ej0LJ8zm2j8UUieTQP+aVd3N965NSUhrqg==
X-Google-Smtp-Source: AGHT+IEpYArb5jtK8d7E8Chk41uiiqB01m0qrswuXcPSHN12Ki/Jxt43S4frduRiK0ygnnQzzojj2Q==
X-Received: by 2002:a7b:cd87:0:b0:424:a822:7845 with SMTP id 5b1f17b1804b1-4264a3e2cddmr219335e9.10.1720046186849;
        Wed, 03 Jul 2024 15:36:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1f2391sm979695e9.25.2024.07.03.15.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 15:36:26 -0700 (PDT)
Message-Id: <pull.1757.git.1720046185710.gitgitgadget@gmail.com>
From: "wonda-tea-coffee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Jul 2024 22:36:25 +0000
Subject: [PATCH] doc: fix the max number of git show-branches shown
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
Cc: wonda-tea-coffee <lagrange.resolvent@gmail.com>,
    wonda-tea-coffee <lagrange.resolvent@gmail.com>

From: wonda-tea-coffee <lagrange.resolvent@gmail.com>

Contrary to the number listed in the current document,
only 26 are actually shown.

Signed-off-by: wonda-tea-coffee <lagrange.resolvent@gmail.com>
---
    doc: fix the max number of git show-branches shown

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1757%2Fwonda-tea-coffee%2Fupdate-git-show-branch-description-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1757/wonda-tea-coffee/update-git-show-branch-description-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1757

 Documentation/git-show-branch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index c771c897707..bc31d8b6d33 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -22,7 +22,7 @@ Shows the commit ancestry graph starting from the commits named
 with <rev>s or <glob>s (or all refs under refs/heads
 and/or refs/tags) semi-visually.
 
-It cannot show more than 29 branches and commits at a time.
+It cannot show more than 26 branches and commits at a time.
 
 It uses `showbranch.default` multi-valued configuration items if
 no <rev> or <glob> is given on the command line.

base-commit: 06e570c0dfb2a2deb64d217db78e2ec21672f558
-- 
gitgitgadget
