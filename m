Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE3BC38142
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 11:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjAXLX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 06:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjAXLXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 06:23:25 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D85F65B6
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 03:23:23 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o17-20020a05600c511100b003db021ef437so10668308wms.4
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 03:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnCzvczZAyQXJIi0Ueuiqk8/+5AhTp5dyI+rRNCUP9U=;
        b=QrMXAdm8KF6t/+g/6gReXgwUtL1U6ge6eWLF+kdhC9smwG2ppNyDrpB4huXmvu4BeF
         ccP2P+c6HKNftGlpzVoRJnWdWw4nCInED31mfnvAZGEQK7Ldk5BqV+cAlOhOhD9i4UEE
         R2jt1Bmzqa8+aAMcCmyQrq4UiybvC3qYNo5MSfJmI9k6iqe8iSkUvNgYr3BlnORt/EWD
         yKZDBuS/toeL2iKvadcIirjpvI63ql3ZSfNSRtbHn58dW3/qJQuYIm2kNI/5tbePVfLY
         +uyN3BDzjvic1N1ks6EXw1VWPXp2jvUdxx3llrt/chw8bhMSX/lpazbOIbYDnrjbRi0n
         EGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnCzvczZAyQXJIi0Ueuiqk8/+5AhTp5dyI+rRNCUP9U=;
        b=3PIisOikxVTRn+Qps8H/naYnpsYkNbKs9lAsdXcVRJg9u5FbtKAqqz0ipBUBEOX7jE
         b47iklOCnlRIWG+TZOBDohAl4OtYzONbo6WqNvhWzNxSNFXoxc+TgI5F+nv4bDq678Om
         sHk8HkRSGgvihu4WFATPHiA22RrVmZVnQ/XYg2WSlZ/7OsztSy9fpFRminzUSxVaWJ6t
         4Zve79NZUDWu5u7UJCwWFc7gm2KWCDE3HpBd0u1ur+BkHVo0PKB0Ii9ae2Q6H4C9Bc0m
         JYPVao7VoupT2gtFLJwBCsdEV3sKiWmUOrtFMASirWBDduzibBuL0jR/qPQd7GRYcpL/
         0kGg==
X-Gm-Message-State: AFqh2kqf6K2LsS7MnZVUcgRoum7OANG/Gu/cpD6JNvICx59qivP7sIrS
        HnGAOt0cG034GvratfoBysS1gqsa5pQ=
X-Google-Smtp-Source: AMrXdXt9JAZcrv1+DDysf5NfyrDtsy75CbcT05lHNrqju8skHuRRUFv/Kkqzxaj3D2o4f6knKzWGDw==
X-Received: by 2002:a05:600c:4d98:b0:3d3:5c7d:a5f3 with SMTP id v24-20020a05600c4d9800b003d35c7da5f3mr35310151wmp.37.1674559401415;
        Tue, 24 Jan 2023 03:23:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15-20020a5d4e0f000000b002bdc39849d1sm1660411wrt.44.2023.01.24.03.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 03:23:20 -0800 (PST)
Message-Id: <89fe0380cd3a373e7e23d663b506466fd6cb5fb6.1674559397.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1469.git.1674559397.gitgitgadget@gmail.com>
References: <pull.1469.git.1674559397.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Jan 2023 11:23:16 +0000
Subject: [PATCH 1/2] gitk: prevent overly long command lines
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To avoid running into command line limitations, some of Git's commands
support the `--stdin` option.

Let's use exactly this option in the three rev-list/log invocations in
gitk that would otherwise possibly run the danger of trying to invoke a
too-long command line.

While it is easy to redirect either stdin or stdout in Tcl/Tk scripts,
what we need here is both. We need to capture the output, yet we also
need to pipe in the revs/files arguments via stdin (because stdin does
not have any limit, unlike the command line). To help this, we use the
neat Tcl feature where you can capture stdout and at the same time feed
a fixed string as stdin to the spawned process.

One non-obvious aspect about this change is that the `--stdin` option
allows to specify revs, the double-dash, and files, but *no* other
options such as `--not`. This is addressed by prefixing the "negative"
revs with `^` explicitly rather than relying on the `--not` option
(thanks for coming up with that idea, Max!).

This fixes https://github.com/git-for-windows/git/issues/1987

Analysis-and-initial-patch-by: Max Kirillov <max@max630.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 gitk | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 0ae7d685904..92375ca6a2a 100755
--- a/gitk
+++ b/gitk
@@ -405,14 +405,16 @@ proc start_rev_list {view} {
         if {$revs eq {}} {
             return 0
         }
-        set args [concat $vflags($view) $revs]
+        set args $vflags($view)
     } else {
+        set revs {}
         set args $vorigargs($view)
     }
 
     if {[catch {
         set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
-                        --parents --boundary $args "--" $files] r]
+                        --parents --boundary $args --stdin \
+                        "<<[join [concat $revs "--" $files] "\\n"]"] r]
     } err]} {
         error_popup "[mc "Error executing git log:"] $err"
         return 0
@@ -554,13 +556,19 @@ proc updatecommits {} {
             set revs $newrevs
             set vposids($view) [lsort -unique [concat $oldpos $vposids($view)]]
         }
-        set args [concat $vflags($view) $revs --not $oldpos]
+        set args $vflags($view)
+        foreach r $oldpos {
+                lappend revs "^$r"
+        }
     } else {
+        set revs {}
         set args $vorigargs($view)
     }
     if {[catch {
         set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
-                        --parents --boundary $args "--" $vfilelimit($view)] r]
+                        --parents --boundary $args --stdin \
+                        "<<[join [concat $revs "--" \
+                                $vfilelimit($view)] "\\n"]"] r]
     } err]} {
         error_popup "[mc "Error executing git log:"] $err"
         return
@@ -10231,10 +10239,16 @@ proc getallcommits {} {
             foreach id $seeds {
                 lappend ids "^$id"
             }
+            lappend ids "--"
         }
     }
     if {$ids ne {}} {
-        set fd [open [concat $cmd $ids] r]
+        if {$ids eq "--all"} {
+            set cmd [concat $cmd "--all"]
+        } else {
+            set cmd [concat $cmd --stdin "<<[join $ids "\\n"]"]
+        }
+        set fd [open $cmd r]
         fconfigure $fd -blocking 0
         incr allcommits
         nowbusy allcommits
-- 
gitgitgadget

