Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21649C148
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352213; cv=none; b=iSjLO6dCzvXBeaiz/cpU19XF+hO5V4iKkLsA9uuWmg9K6kwStKvwpUBR5ipu+31H/zypajrEehWQJQ8+IVh98nGvvxXB9px48d3AABCtCxSNQdVW/KnCc/0K9BHotwgKkd+SXP0qVHG6dHW/8gsWoCOaS70KIrNG2JXy0Gnt/Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352213; c=relaxed/simple;
	bh=de9bIPPI88C3yj+xfZZCiOuTpiblDyEfqHT1/cQMsyY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=gMQto7XTmGnDU9EmhJnEj2+hiqsAvlZjA5dTyvk1K5fY17YnO+STrrWJyTgjr5j9F9dzFfr+XjAkagP0zmPqjkNKUihy8MsvO4tM/GiaxtVjw2Glz8jRrFbZcWAgTQOTaGozSXPL9BI8ksUPM65PXYZmjGf2fypfDy9tL0yKfC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWXXAaHe; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWXXAaHe"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781206cce18so286206b3a.0
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 13:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759352211; x=1759957011; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lh08vWRcS48CIdDW1HczTk9Gp8uevIqP/JVrhH0IPXw=;
        b=AWXXAaHeUK2eJxgjbRU85jndkXva+L6VVGgaBkbBUabOmd6uYS90P9+4+GTkzG3Odv
         amG9wau3H9Hh/TqgPgwuUFH3miQOnsSASpCCxRrIHuCFqnG47qsWGZz2xstPiStiEWQO
         S1pM/jjAlSzAEwPDptccingfTmf/I6HV8du6Du4lKnC1DGe1G+S1XxkLtoZI4FLoYToT
         xtK5LKp4XouP3TMFnyu8SnxridyZDAwtmtoHGtiqOV0wqckAmvSvoiUwtqLhEEPjHEF7
         XlwHbB6gLx1qtydwtZoFkf2x/iEDCvAj3uzE58NpdNsJw6CWuhaItTKHAOE60pvN0K8x
         q6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759352211; x=1759957011;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lh08vWRcS48CIdDW1HczTk9Gp8uevIqP/JVrhH0IPXw=;
        b=PZGTybgvfTnRLC3WpHvS/MgXSybRrJs2pQMCM/wfHNjNUSf9rtC+sKI804SXlcAFM8
         eCLmJ04G1XVSUBDtT2tnHheLi6PaHuqMNtxYCYeqeaHP/VeTsUCKagBlojMtzRm7xW/W
         9Lzwb9AjmevdTYgThZy/3H1KNzArXugxqh/Cew08ILiMPSa7XHistZc1wq7mQbH32Zy/
         /oJvb1AQRb24DWvRBvVC7o3h0/dAo3ZKSfoxuf6qgk6ovTl3l8LFxX7V9HJscDYRXY1b
         2EhkfwEQAcWhccOi8kqaOxLF1gd3CQvCwaLG2YM4wOhp5bESeJzMafxmv1yey+JNW0lG
         5q1g==
X-Gm-Message-State: AOJu0Yy0rIJQY4ZFhA88wjhopVrKwHkFZaKyxI2ExEWqBekjWxfZEPV4
	oWkR4o4og+su6HXAXn4f/GS8NLZ4uT/CLAjlqjW3bJARCraeieqf6t1bWLi5NQ==
X-Gm-Gg: ASbGncvbdf7DEX0SsrBOfsiNRVnsPpqjYB6hyzxnW74uolHgHnxeH2nQ24cY1p56y7C
	PhBG80t164kW10l/JoNfjqV6Ro7v0lFS7jq36DQbUziQC7xNH04RobrSlunbuUMk6g3jGuy6ryC
	ZvUutX16oD6d4u6G+tee5v6duvT6tkaDNYmOHlq03NcFlmsYc2ueN73C0F6sciW6/8Rh+/1jVwh
	rqZuoIe9u8tu3/z2Y8c6+FgDwbNFlAGtjxbibdNaDYTPIk+Udbga+LvApVxUXu2WCH1pY03KsPk
	K1dj0lyNQKk3PAzUr4gypxXhe5IaLObQxqtLOtF4eB/zin3nW1RSeLm2UbkZ0S9YABJz40TsqED
	09w5dpX4ZVsL/idaQdmSPSQ9V1M2JTVPu01Y31v1dPgd68+PLPg==
X-Google-Smtp-Source: AGHT+IE2l1d/LCmusRpzy9Pl1PzPWYwR7kUmIXzXO0OVlh1xm0VcsqM2p4BWyx7aY3OeWWlbZ8ZuIw==
X-Received: by 2002:a05:6a20:549c:b0:248:ef8:66df with SMTP id adf61e73a8af0-32a2728446fmr1231219637.30.1759352211029;
        Wed, 01 Oct 2025 13:56:51 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.153.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f5990csm381144a12.38.2025.10.01.13.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 13:56:50 -0700 (PDT)
Message-Id: <pull.1979.git.1759352209657.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Oct 2025 20:56:49 +0000
Subject: [PATCH] docs/gitcredentials: describe URL prefix matching
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
Cc: sandals@crustytoothpaste.net,
    Johannes.Schindelin@gmx.de,
    M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

Documentation was inaccurate since 9a121b0d226 (credential: handle
`credential.<partial-URL>.<key>` again, 2020-04-24)

Add tests for documented behaviour.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    docs/gitcredentials: describe URL prefix matching

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1979%2Fhickford%2Furl-prefix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1979/hickford/url-prefix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1979

 Documentation/gitcredentials.adoc | 15 +++++++--------
 t/t0300-credentials.sh            | 19 +++++++++++++++----
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/Documentation/gitcredentials.adoc b/Documentation/gitcredentials.adoc
index 3337bb475d..60c2cc4ade 100644
--- a/Documentation/gitcredentials.adoc
+++ b/Documentation/gitcredentials.adoc
@@ -150,9 +150,8 @@ pattern in the config file. For example, if you have this in your config file:
 	username = foo
 --------------------------------------
 
-then we will match: both protocols are the same, both hosts are the same, and
-the "pattern" URL does not care about the path component at all. However, this
-context would not match:
+then we will match: both protocols are the same and both hosts are the same.
+However, this context would not match:
 
 --------------------------------------
 [credential "https://kernel.org"]
@@ -166,11 +165,11 @@ match: Git compares the protocols exactly.  However, you may use wildcards in
 the domain name and other pattern matching techniques as with the `http.<URL>.*`
 options.
 
-If the "pattern" URL does include a path component, then this too must match
-exactly: the context `https://example.com/bar/baz.git` will match a config
-entry for `https://example.com/bar/baz.git` (in addition to matching the config
-entry for `https://example.com`) but will not match a config entry for
-`https://example.com/bar`.
+If the "pattern" URL does include a path component, then this must match
+as a prefix path: the context `https://example.com/bar` will match a config
+entry for `https://example.com/bar/baz.git` but will not match a config entry for
+`https://example.com/other/repo.git` or `https://example.com/barry/repo.git`
+(even though it is a string prefix).
 
 
 CONFIGURATION OPTIONS
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index cb3a85c7ff..07aa834d33 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -991,18 +991,24 @@ test_expect_success 'url parser not confused by encoded markers' '
 
 test_expect_success 'credential config with partial URLs' '
 	echo "echo password=yep" | write_script git-credential-yep &&
-	test_write_lines url=https://user@example.com/repo.git >stdin &&
+	test_write_lines url=https://user@example.com/org/repo.git >stdin &&
 	for partial in \
 		example.com \
+		example.com/org/repo.git \
 		user@example.com \
+		user@example.com/org/repo.git \
 		https:// \
 		https://example.com \
 		https://example.com/ \
+		https://example.com/org \
+		https://example.com/org/ \
+		https://example.com/org/repo.git \
 		https://user@example.com \
 		https://user@example.com/ \
-		https://example.com/repo.git \
-		https://user@example.com/repo.git \
-		/repo.git
+		https://user@example.com/org \
+		https://user@example.com/org/ \
+		https://user@example.com/org/repo.git \
+		/org/repo.git
 	do
 		git -c credential.$partial.helper=yep \
 			credential fill <stdin >stdout &&
@@ -1012,7 +1018,12 @@ test_expect_success 'credential config with partial URLs' '
 
 	for partial in \
 		dont.use.this \
+		example.com/o \
+		user@example.com/o \
 		http:// \
+		https://example.com/o \
+		https://user@example.com/o \
+		/o \
 		/repo
 	do
 		git -c credential.$partial.helper=yep \

base-commit: 821f583da6d30a84249f75f33501504d597bc16b
-- 
gitgitgadget
