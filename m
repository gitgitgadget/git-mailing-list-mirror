Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722E7C4727F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 22:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 289D720717
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 22:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvfcEvrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgIYWBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 18:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgIYWBA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 18:01:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7075DC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 15:01:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k15so5481233wrn.10
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GcUqZjKAvBw+9MmZ6JSXD4u25Zwd61Oj0EyWd4xJ7BQ=;
        b=WvfcEvrcE3NiLTufQ2OGZUWX0rGzy3hstttM8pSR2pRt9/i/iDpjyVvey7XbNysJyD
         mk2T3eU4LXPHEReqB/6KXFpwmf4TJN5l8Nz3RYxP/HhAoY6b4zTKowrnBHIjPG93apth
         EDFCuu7s8VVO6eY+20xWMKb5SJK+UFRZhlz/GNUtNTgPWKaG42Bu/eUi7Buxd9hA6fSh
         jGd4YDaYOT7jGGZzFk9b1m18+0HLjkZ+jXa5JUUWYWYZmM6EoOaKeMlDVmT7YUmIVbF8
         w82hUmEojgi779jpLvY7mliX3WvK4azc8QEj3c8fHeE8rt8t2B10UF7yMKx+GDliBpH3
         jpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GcUqZjKAvBw+9MmZ6JSXD4u25Zwd61Oj0EyWd4xJ7BQ=;
        b=XAcTHhghcJHfIfIuOJgOITmgscZUibNLE0uQou4avpHSSwgJJKgemmtQWKjrTXiWFi
         VO1atHbawhxKpfHi1nJh8qP19+QAFLCuZq3pVTIoCC1RhWLdjVyBM8BoBJsf8+OPGz0H
         1rWJIWFZY/VT5dgji8yZBnOu7RbCepBhA+YE+uZOPSK4GgpDaI11rpX92STq6iHDSpEy
         U8CK0CUiVTP9tr8EA6kPiVzcVkriXUaMvaP/Q7Wx3J7TpZVTEU5Wbe/yEBZMlBAB9Hrq
         ZrNVUQtY1SvpRYhrnApGoS6EmjKF40K0iYGQRoIR9HQTfu++d8jLKpxEPJxTkVGBtGDF
         o7jg==
X-Gm-Message-State: AOAM5336kZdkIgiGBzFoRT5Fd+tM0a63jsj8eS8Y4p0JBEKz3/E61sI2
        3unsbX8ugENYKTv9btpPifziLQKcmJvBY+8F
X-Google-Smtp-Source: ABdhPJxAvKLzfixPGsTSquqAJw1yYDUVIfCBq6HsMdmK9TXVlszN7BwrcKQFeeC6esP2gSC58l+Bkw==
X-Received: by 2002:adf:828f:: with SMTP id 15mr6439632wrc.49.1601071258740;
        Fri, 25 Sep 2020 15:00:58 -0700 (PDT)
Received: from localhost.localdomain (91EC7F95.dsl.pool.telekom.hu. [145.236.127.149])
        by smtp.gmail.com with ESMTPSA id w7sm354659wmc.43.2020.09.25.15.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 15:00:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=81kos=20Uzonyi?= <uzonyi.akos@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81kos=20Uzonyi?= <uzonyi.akos@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 1/2] completion: use "prev" variable instead of introducing "prevword"
Date:   Fri, 25 Sep 2020 23:11:23 +0200
Message-Id: <20200925211124.1673337-1-uzonyi.akos@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In both _git_checkout and _git_switch a new "prevword" variable were
introduced, however the "prev" variable already contains the last word.

The "prevword" variable is replaced with "prev", and the case is moved
to the beginning of the function, like it's done in many other places
(e.g. _git_commit). Also the indentaion of the case is fixed.

Signed-off-by: Ákos Uzonyi <uzonyi.akos@gmail.com>
---
 contrib/completion/git-completion.bash | 66 +++++++++++++-------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8be4a0316e..3d02bd4de7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1508,6 +1508,22 @@ _git_checkout ()
 {
 	__git_has_doubledash && return
 
+	local dwim_opt="$(__git_checkout_default_dwim_mode)"
+
+	case "$prev" in
+	-b|-B|--orphan)
+		# Complete local branches (and DWIM branch
+		# remote branch names) for an option argument
+		# specifying a new branch name. This is for
+		# convenience, assuming new branches are
+		# possibly based on pre-existing branch names.
+		__git_complete_refs $dwim_opt --mode="heads"
+		return
+		;;
+	*)
+		;;
+	esac
+
 	case "$cur" in
 	--conflict=*)
 		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
@@ -1516,23 +1532,6 @@ _git_checkout ()
 		__gitcomp_builtin checkout
 		;;
 	*)
-		local dwim_opt="$(__git_checkout_default_dwim_mode)"
-		local prevword prevword="${words[cword-1]}"
-
-		case "$prevword" in
-			-b|-B|--orphan)
-				# Complete local branches (and DWIM branch
-				# remote branch names) for an option argument
-				# specifying a new branch name. This is for
-				# convenience, assuming new branches are
-				# possibly based on pre-existing branch names.
-				__git_complete_refs $dwim_opt --mode="heads"
-				return
-				;;
-			*)
-				;;
-		esac
-
 		# At this point, we've already handled special completion for
 		# the arguments to -b/-B, and --orphan. There are 3 main
 		# things left we can possibly complete:
@@ -2392,6 +2391,22 @@ _git_status ()
 
 _git_switch ()
 {
+	local dwim_opt="$(__git_checkout_default_dwim_mode)"
+
+	case "$prev" in
+	-c|-C|--orphan)
+		# Complete local branches (and DWIM branch
+		# remote branch names) for an option argument
+		# specifying a new branch name. This is for
+		# convenience, assuming new branches are
+		# possibly based on pre-existing branch names.
+		__git_complete_refs $dwim_opt --mode="heads"
+		return
+		;;
+	*)
+		;;
+	esac
+
 	case "$cur" in
 	--conflict=*)
 		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
@@ -2400,23 +2415,6 @@ _git_switch ()
 		__gitcomp_builtin switch
 		;;
 	*)
-		local dwim_opt="$(__git_checkout_default_dwim_mode)"
-		local prevword prevword="${words[cword-1]}"
-
-		case "$prevword" in
-			-c|-C|--orphan)
-				# Complete local branches (and DWIM branch
-				# remote branch names) for an option argument
-				# specifying a new branch name. This is for
-				# convenience, assuming new branches are
-				# possibly based on pre-existing branch names.
-				__git_complete_refs $dwim_opt --mode="heads"
-				return
-				;;
-			*)
-				;;
-		esac
-
 		# Unlike in git checkout, git switch --orphan does not take
 		# a start point. Thus we really have nothing to complete after
 		# the branch name.
-- 
2.28.0

