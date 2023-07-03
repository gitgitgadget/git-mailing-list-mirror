Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FE9C001B3
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 18:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGCSqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 14:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGCSqU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 14:46:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248A610EF
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 11:46:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3112f5ab0b1so5334903f8f.0
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688409973; x=1691001973;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qYyGIsOf6k8ecuynYssDvn9hKsa/pQ+2Y8fBMONO94=;
        b=ejFMOQK4AQM/8S9YD9NTu3OIx1SRMo0p0vIQRpF5njgKfZQF3G82/uwtusa65JFe/E
         QzFucheJs9cH3GYM/ND4M94d3hlFQ6QGhC+B0MCtzABxXPbJ3sh4/HYub69MSsyWKmq+
         tH8cdk5rOUFYwf6dBMJ6cZ6vPxGJhIOuIj5EldY611yxd35cJF+xdDH3ZS4JFJIFr76C
         sX7ZqocNRNzs0FjFJIqaZ0j1Z7N7621o6y75NcYEgFCVQHuNDXEG/uw6FIXD8aYHo8VL
         lC3jRA6iiJyjpmGIqt3GFKC8Fr/h5daMw7FlVw5dYs1j6QgVX8mSXMEC9x5YH4nEfANb
         ey8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688409973; x=1691001973;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qYyGIsOf6k8ecuynYssDvn9hKsa/pQ+2Y8fBMONO94=;
        b=Tn2KZOnqU8zDX44LiUmvQz4LaeM2cR+Ld4PQ/2UELI6FwGq0hiaFm/ZIZvrXRKh2wz
         eSCN4j1KJyzJcvWoWHhkHX30wnEx3F7mZbmgDMfCNDgOymtVD+mqZfm1dtbWd2PWJ4Gd
         oMaAM1vT2Nbiw//j9PHZ0BzAZ+/Tck5pRFmibcBIneQJT1RJyiXoIy6QWfsoy2/xhwPW
         D+fEf+X2R6n7YOd1nM5ivFfV7EJxUnzAuhc9F+2EZao42m2ygWmEDNTkdcQIZd8Ifv5X
         Si3rGhg7RfJ71ReH7y1LzXmgbkgv1sjgQj1Z8xRnDaNx0lJ5r9Qw4IAjogbF/LpPHcXR
         ONhA==
X-Gm-Message-State: AC+VfDzjNvWgYQx51c4/k/ukKdq02tnpw/FmqC8oykkbaYutBK9toT3D
        sVR7yBEBDo2YGCzwf4NMRzbcA7SSp/k=
X-Google-Smtp-Source: ACHHUZ4lmgKHJE2JUCH955bdiQUcNIWnMbAIXququVxesDr1ywCmXbcwEXOjH7Lz8Y+glOOtu6yi5w==
X-Received: by 2002:a05:600c:b54:b0:3f5:ffe3:46a7 with SMTP id k20-20020a05600c0b5400b003f5ffe346a7mr8497773wmr.9.1688409973234;
        Mon, 03 Jul 2023 11:46:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14-20020a05600c138e00b003f9b3829269sm9881605wmf.2.2023.07.03.11.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:46:12 -0700 (PDT)
Message-Id: <3f0438fc0277338a917dce815ddf910826c66d66.1688409958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
        <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Jul 2023 18:45:58 +0000
Subject: [PATCH v2 10/10] gitk: allow checkout of remote branch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Jens Lidestrom <jens@lidestrom.se>,
        Jens Lidestrom <jens@lidestrom.se>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jens Lidestrom <jens@lidestrom.se>

This is a consequence of allowing checkout of detached heads (through
keyboard shortcut). It doesn't make sense to disallow checkout of
commits on remote branches if all other commits can be checked out.

Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
---
 gitk-git/gitk | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index fafff2b1a5b..99f93371482 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -9989,10 +9989,6 @@ proc headmenu {x y id head} {
     set headmenuhead $head
     array set state {0 normal 1 normal 2 normal}
     if {[string match "remotes/*" $head]} {
-        set localhead [string range $head [expr [string last / $head] + 1] end]
-        if {[info exists headids($localhead)]} {
-            set state(0) disabled
-        }
         array set state {1 disabled 2 disabled}
     }
     if {$head eq $mainhead} {
@@ -10078,17 +10074,29 @@ proc checkout {heads_on_commit id_to_checkout} {
         set ref_to_checkout $head_to_checkout
     }
 
-    # Handle remote branches
     set command [list | git checkout]
     if {[string match "remotes/*" $head_to_checkout]} {
-        set remote $head_to_checkout
+        # Handle remote branches
+        set remote_head $head_to_checkout
         set head_to_checkout [string range $head_to_checkout [expr [string last / $head_to_checkout] + 1] end]
-        set ref_to_checkout $head_to_checkout
         if {[info exists headids($head_to_checkout)]} {
-            error_popup [mc "A local branch named %s exists already" $head_to_checkout]
-            return
+            # The local branch exists
+            set id_to_checkout $headids($remote_head)
+            if {$headids($head_to_checkout) eq $id_to_checkout} {
+                # Remote and local are at the same commit
+                set ref_to_checkout $head_to_checkout
+            } else {
+                # Check out the detached head of the remote branch
+                set head_to_checkout ""
+                set ref_to_checkout $id_to_checkout
+            }
+            lappend command $ref_to_checkout
+        } else {
+            # Create local branch and checkout
+            set ref_to_checkout $head_to_checkout
+            puts $ref_to_checkout
+            lappend command -b $ref_to_checkout --track $remote_head
         }
-        lappend command -b $head_to_checkout --track $remote
     } else {
         lappend command $ref_to_checkout
     }
-- 
gitgitgadget
