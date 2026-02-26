Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9177261B9B
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772109200; cv=none; b=ozAG8A1pHZrUsovZ2+9t0WNWz4ZcK+g6CskUodGea4ePeFi9TZ6gdgwwwxIibuUpJFWFP5FAEiDVX0ObpE64PD//qm4U6CQGyGtp3j1Ip4nCjrrqDqHbPy1rbkCOIG8VPgvI0ddWBskFnEn5Cj+7fo9zx7Q8ivGSc5C48FScarg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772109200; c=relaxed/simple;
	bh=lfbOAzyP1KmTSsegFPJpzEC4AdlhGFdu9O/XzGcKq+M=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Rdk13YO/ZpWh+3R9/lvaoCMj58StHt6VpyTCCZHYC74uYZi6PFRikDRvPZIC9+3uOI6L6VFcxBGpllF+Lz4EkqVdoX4GDujpVJLxfLISqjcHN8WsLu/7qLnYvwtGCshXxMPDbpjUTk4kX652G9uOC4Bc6xSHbv1XKyozej8GYys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA3QYXHb; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA3QYXHb"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12758ce1e8dso522744c88.0
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 04:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772109198; x=1772713998; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TNwG9tMm/4fmlZCy2UkHQa2sqXqWuE9MJi4kmJYeu5o=;
        b=YA3QYXHbZogcfiIbYMhc9+ujeSwsDIsELuY4YUcQlQ4aplTolI1v8xO2FlICMWy96i
         z3qAPVIkeI+GyMDYlxEa/r4a1Y3NH+qC9UeJPvhbb4e9F7hh0MRYeot+06KKpmnzsmEb
         GxdY6EkDhPN/US1gz7rX6DN5jm1QUjgjI23/isFQ4jZD418q64wNmjNgmYFwu3dt1k8T
         /ofFyRoum+X3hJ87Co9cQTi9NwOP2/fGtRU8efdgsYOj/Abr2MLW7yXoPPYl1lBVjrxf
         nZBy8xgvEtVsLuG9oGtpvrPv4NDuPinHVDonPUdJkXWz1yf/wBdL30nQgz2T8G/UNW87
         6cGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772109198; x=1772713998;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNwG9tMm/4fmlZCy2UkHQa2sqXqWuE9MJi4kmJYeu5o=;
        b=tPisB0WdKUQ4RovT3VlYmNzQ3ErNW66RvcwXuOdXFmP/IELiX+EElLR5LEIM/jNVp/
         ldcqbYmhwpQ9gn2qSEfX8sTbZWh609oVxug6rx0D2i38v9UNdExh7Dx9cTvEdYEPgamU
         0i0wQDqEvNsFdP4skCK0aPZE9yPDVPTFdE/oHDZdQrReCN1IP4HdXhsonuEoaPrjIh8Z
         PSCupXFiB4j6MTB21pA+05SrwG0sYCnLQg9yKI5KH2xlZfBPIgF1rNKUIo+QBg5AeADu
         8rFmx/XB14AH5cnrbCtXdJXQMZL0AJl3AEgw921FL1maTWV0S92rqVDFzwyPaAX6C30r
         ZK1A==
X-Gm-Message-State: AOJu0Ywx02RyXaaeQKCCL+3o8e5F1jb2csf+O7PgaXQOZtHLRw3Y7NtK
	kIdt/G0ndrJy29rbmf+gLkYsO8eAMO8TROENKsj2vn6LfmBDHU1Z7HuxL4tNeA==
X-Gm-Gg: ATEYQzy2zFR++waSZ1WBG9h+TSV9I1yWB0Vw9YREHqnH/kuT6vOcXjKEGxeBCHpBnzI
	F8jLi6RFLxry9g7+UtwF0VIZBpYaJMq0PmjhkBFBDuPvShDQS1Q9t1HlvDks8JJe+gcDy6mj0/y
	qbW09npPDmAxG25P/wTPvfiACqlbYtKu6J9+4921ndC3eqhlaaVzohK2GbCyFdlPM8yOXXkWlzk
	SkDRj9RDlTh+9Gof9aA6JevwBg5HqF5AomoOUGC9vJ5ZPk4R/VRGZfmp/ELHVzOZpc5q4Ya5si5
	abjQJ+9HIxr5F+z+h0iFEHPnHBXphvASXzuJ3Cl3FcHoYmU4f/99s3/uOFL+y+c1vaLGEguwi0Q
	eFGQfonBi54fiuz7XzcKXF6Gyd0MmJ6gnWBNLaRv5ChL8xhmaptbHUjXRFMfwHDDMFd73b9+8IE
	dR5lbHvLJ8wWcV6GZpAOb5ZsT2
X-Received: by 2002:a05:7022:619e:b0:11b:88a7:e1b0 with SMTP id a92af1059eb24-1276ad628dcmr8413873c88.26.1772109197494;
        Thu, 26 Feb 2026 04:33:17 -0800 (PST)
Received: from [127.0.0.1] ([20.168.119.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f4658esm1691023eec.25.2026.02.26.04.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 04:33:16 -0800 (PST)
Message-Id: <pull.2217.git.git.1772109195114.gitgitgadget@gmail.com>
From: "Gary Wang via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 12:33:15 +0000
Subject: [PATCH] gitk: support config the color of linkfgcolor via Gitk
 Preferences
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
Cc: Gary Wang <git@blumia.net>,
    Wang Zichong <wangzichong@deepin.org>

From: Wang Zichong <wangzichong@deepin.org>

As a dark-theme user, I use the Preferences dialog to set colors
for gitk, the only color I cannot change via that dialog is the
link foreground color, which will lead me to use the default link
color on a dark background that make it not really readable.

This patch makes the link foreground color also configurable in the
Gitk Preferences dialog's Color tab, so user won't need to dig into
the code/manual to know if the link color is configurable and can
simply set the color there.

CC: Mark Levedahl <mlevedahl@gmail.com>, Paul Mackerras <paulus@samba.org>
Signed-off-by: Wang Zichong <wangzichong@deepin.org>
---
    gitk: support config the color of linkfgcolor via Gitk Preferences

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2217%2FBLumia%2Fgitk-linkfgcolor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2217/BLumia/gitk-linkfgcolor-v1
Pull-Request: https://github.com/git/git/pull/2217

 gitk-git/gitk | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index cbaaee994e..b60f140636 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11796,7 +11796,7 @@ proc prefspage_general {notebook} {
 
 proc prefspage_colors {notebook} {
     global bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
-    global diffbgcolors
+    global diffbgcolors linkfgcolor
     global themeloader
 
     set page [create_prefs_page $notebook.colors]
@@ -11873,6 +11873,11 @@ proc prefspage_colors {notebook} {
         -command [list choosecolor selectbgcolor {} $page [mc "background"]]
     grid x $page.selbgbut $page.selbgsep -sticky w
 
+    label $page.linkfg -padx 40 -relief sunk -background $linkfgcolor
+    ttk::button $page.linkfgbut -text [mc "Link color"] \
+        -command [list choosecolor linkfgcolor {} $page [mc "link color"]]
+    grid x $page.linkfgbut $page.linkfg -sticky w
+
     grid columnconfigure $page 2 -weight 1
 
     return $page
@@ -11880,7 +11885,7 @@ proc prefspage_colors {notebook} {
 
 proc prefspage_set_colorswatches {page} {
     global bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
-    global diffbgcolors
+    global diffbgcolors linkfgcolor
 
     $page.bg configure -background $bgcolor
     $page.fg configure -background $fgcolor
@@ -11891,6 +11896,7 @@ proc prefspage_set_colorswatches {page} {
     $page.hunksep configure -background [lindex $diffcolors 2]
     $page.markbgsep configure -background $markbgcolor
     $page.selbgsep configure -background $selectbgcolor
+    $page.linkfg configure -background $linkfgcolor
 }
 
 proc prefspage_fonts {notebook} {

base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
-- 
gitgitgadget
