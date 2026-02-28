Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBDC25A659
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 04:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772251562; cv=none; b=TSCDU3rY5B9tNEU++G4AG2yAjB7HXJ0aQa7m8jip9sj01Kd56zXvdAZYUIW3IZ2Bj9jXZsrRcYOYXHNj5bjOrI1iqk8OJlliunafyIgOpf6+e73EUuMeB9XeQ/qUSGpFhoRX2jtCJbXDY1cjYCe+NO+c0j7dbpBG4/+1itktm94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772251562; c=relaxed/simple;
	bh=sfVO5aaEpHjzsKK0YGpK31oUWRKGhSw3T3wAKG7Lv3E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fyWvgAyhI723jyZr/uRzy3NmVgjsdtb9TbtkZIjei1M51+i92rjZQQ7PwmuFDboMGy/N+rd+jOWJVj5g2KRE6X4ksaOEpF5zCMLA2+LXQNGXIyExUl+nDPNXrCfb7prLsVQ7YZdTznf9xCDeefFciHKqkxnslXFFeBpW/YSlenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeeVzCj/; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeeVzCj/"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb20bcff5aso265213785a.3
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 20:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772251559; x=1772856359; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZGkdldeVJYHQxlqV2XPuQJhHPP1dScBCutaxrxIchs=;
        b=CeeVzCj/lSDDZPx65oMNY53ExJoAYTa544fPUePJqt7NVmf5vWdJn7a1gBOm7JsCzW
         wb+3DbIu21d9C39IuzUeso3Ch1HQx6bqUVmKn593lctFyHg68hsUI5JZi9g3DtKswNy0
         FlT0SW4nXaesZwM7guoSHhtsPwdQUNztBnpGZP1tNWH9TNEvkO4mfNqFINaUQRy4BHK5
         gH9lcHjAjF81WfkhawoqbRYAomxGZzkX+tf9ZDjmzjy4geRJDH5tQlVz4JKoToSvzlCd
         WUcamRcCrMqAva3TaLkiZu8vU9+hKznaPXfqOR1SpkkH28hPEQ6rzAxegg2v/yAOCkaQ
         +Zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772251559; x=1772856359;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mZGkdldeVJYHQxlqV2XPuQJhHPP1dScBCutaxrxIchs=;
        b=Ic7M9b6Q1zNCFKLbI+7aNy0Q+7FpB0VehTBojLdONg55Gnhrxgwv4q529lemXDSqdz
         wpWENoFMujBPqZTNGOT8WcoVpWfa1eJze4774cw+QBgHuqAd2KWQ1SAxfLdXzufQMxa+
         tKZ/gWfKmOqNhOJdStp4RvTxnee/bJOZh/ICJqGHSFsElnzhQmZ0w27jrog3FfD+LftN
         XknrE3kJi9h0Hx2ImbnKWi5zH5DAvqhPbu/IhUnMydT4TiGoIUMoXzUPWJ/I8mQg8YxA
         MNnqST+yNotULGsh2RQQi0pHZ2bnfk8waw001lSF0XeuhYu2OIMGGyZgxA0wyvLd7jx8
         rT7A==
X-Gm-Message-State: AOJu0YxIcbVnS/d9eoY5XlPjVgqELkBNGcYqmbaiIJ8HN+ihrtqdgiDM
	AEG5b7LQP1AGwyNPLv2hq/hqgNguvEg2zxswRRuvxWrdZWR4fVnW5QCrN0GEgg==
X-Gm-Gg: ATEYQzwhkx1+p0ZdFxzGZqGfm84EpbmF8h3+OPH0U2bhmPe8oyxhzAnrU9kObyZkjJl
	qpgIdcFdw94HHS5MM63X5aLJn1+Gck9MgtsF9E+oK2is8W+9r9cxV8ls6vvhoVkMWU09Phz14AL
	w5Yx02y790oXAOc9M/ZS0ucVY0/n1x8IxOdTKWt6sN2wcjIQH+9OXEGKUdDOxx+/xUBTK51lYUu
	K6w1ZLILW3gBS41G6fQGcCL3/ih/xmV3y4O0dW+IQo695WOs80fgMRd5W4YNjgQAA0Gx5ZJ2oIk
	pc921vukl1JGZM+fqYjuDFdFCMyaDk2aildbeOiMAukYBeZNdYrzGOvYNM53+3XNxV9TCEKljAq
	6uzQ+7PBOrQr/BQVzQVIU8A3Hi8ANwhMsz50d2Xo5TCVDRpQwVUtiSEkT35Ys6pnm6YibtvWRGm
	bqBMO5s4V8AHNDOlrp0WtnyV0GJw==
X-Received: by 2002:a05:620a:2846:b0:8ca:3175:cc9f with SMTP id af79cd13be357-8cbc8d836f0mr656558985a.7.1772251559413;
        Fri, 27 Feb 2026 20:05:59 -0800 (PST)
Received: from [127.0.0.1] ([145.132.102.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6592desm625931385a.2.2026.02.27.20.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 20:05:58 -0800 (PST)
Message-Id: <pull.2217.v2.git.git.1772251558434.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.git.git.1772109195114.gitgitgadget@gmail.com>
References: <pull.2217.git.git.1772109195114.gitgitgadget@gmail.com>
From: "Gary Wang via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Feb 2026 04:05:58 +0000
Subject: [PATCH v2] gitk: support link color in the Preferences dialog
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
for gitk. The only color I cannot change via that dialog is the
link foreground color, which leads to using the default link color
on a dark background that makes it hard to read.

Make the link foreground color also configurable in the Gitk
Preferences dialog's Color tab, so users won't need to dig into
the code/manual to check if it is configurable and can simply set
the color there.

CC: Mark Levedahl <mlevedahl@gmail.com>
CC: Paul Mackerras <paulus@samba.org>
CC: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Wang Zichong <wangzichong@deepin.org>
---
    gitk: support config the color of linkfgcolor via Gitk Preferences

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2217%2FBLumia%2Fgitk-linkfgcolor-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2217/BLumia/gitk-linkfgcolor-v2
Pull-Request: https://github.com/git/git/pull/2217

Range-diff vs v1:

 1:  d5d8897fbb ! 1:  f533af7ac5 gitk: support config the color of linkfgcolor via Gitk Preferences
     @@ Metadata
      Author: Wang Zichong <wangzichong@deepin.org>
      
       ## Commit message ##
     -    gitk: support config the color of linkfgcolor via Gitk Preferences
     +    gitk: support link color in the Preferences dialog
      
          As a dark-theme user, I use the Preferences dialog to set colors
     -    for gitk, the only color I cannot change via that dialog is the
     -    link foreground color, which will lead me to use the default link
     -    color on a dark background that make it not really readable.
     +    for gitk. The only color I cannot change via that dialog is the
     +    link foreground color, which leads to using the default link color
     +    on a dark background that makes it hard to read.
      
     -    This patch makes the link foreground color also configurable in the
     -    Gitk Preferences dialog's Color tab, so user won't need to dig into
     -    the code/manual to know if the link color is configurable and can
     -    simply set the color there.
     +    Make the link foreground color also configurable in the Gitk
     +    Preferences dialog's Color tab, so users won't need to dig into
     +    the code/manual to check if it is configurable and can simply set
     +    the color there.
      
     -    CC: Mark Levedahl <mlevedahl@gmail.com>, Paul Mackerras <paulus@samba.org>
     +    CC: Mark Levedahl <mlevedahl@gmail.com>
     +    CC: Paul Mackerras <paulus@samba.org>
     +    CC: Johannes Sixt <j6t@kdbg.org>
          Signed-off-by: Wang Zichong <wangzichong@deepin.org>
     +    ---
     +    Changelog (v2):
     +
     +      * reword commit message as suggesed by Johannes
     +      * Rename button text from "link color" to "link" as suggested
     +        by Johannes
      
       ## gitk-git/gitk ##
      @@ gitk-git/gitk: proc prefspage_general {notebook} {
     @@ gitk-git/gitk: proc prefspage_colors {notebook} {
           grid x $page.selbgbut $page.selbgsep -sticky w
       
      +    label $page.linkfg -padx 40 -relief sunk -background $linkfgcolor
     -+    ttk::button $page.linkfgbut -text [mc "Link color"] \
     -+        -command [list choosecolor linkfgcolor {} $page [mc "link color"]]
     ++    ttk::button $page.linkfgbut -text [mc "Link"] \
     ++        -command [list choosecolor linkfgcolor {} $page [mc "link"]]
      +    grid x $page.linkfgbut $page.linkfg -sticky w
      +
           grid columnconfigure $page 2 -weight 1


Changelog (v2):

  * reword commit message as suggesed by Johannes
  * Rename button text from "link color" to "link" as suggested
    by Johannes
---
 gitk-git/gitk | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index cbaaee994e..1c289174d5 100755
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
+    ttk::button $page.linkfgbut -text [mc "Link"] \
+        -command [list choosecolor linkfgcolor {} $page [mc "link"]]
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
