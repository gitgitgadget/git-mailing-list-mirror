Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5131C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 14:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiKSOC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 09:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiKSOCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 09:02:25 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1652863BAA
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 06:02:25 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i12so9590144wrb.0
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 06:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=my1QQWoFO7+/m/3OaLQ+s64mTrAYaKiHnfOWRzZ1LDM=;
        b=JG2biBqN6Ce8SKDtSV84seHiVDymlVanQGyHkQCm6Wkbe6//4MFCpBL+DR/IY9VOWz
         hZHVZfDNnWGPZbRwYYDnVbQL/RVKG2fFwY4ET2A++QHBbYP+Nr4gkP0W3wIcGi2VnZUn
         FcmoGFLiIBvU7QCJ5QI9LtgIQCGzGWmuiIZYQPHrZCkzfr9IwKFqQTndXhAJDvQEGMcw
         OvwSAJo+8WD7sTAfC7XSgD/crPXmddBW3mf/oHK2pm2OMwdQQFUgmLfHfXSLowwcSbe1
         5kRG6Rx/mJ16Wr3RWhrPjZNdQSL6Nmll56Jbv3oultNCiQ4c146YHUna/Ez01O2Gg8zi
         lE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=my1QQWoFO7+/m/3OaLQ+s64mTrAYaKiHnfOWRzZ1LDM=;
        b=cOuxBOuK7x/oveSTxz36JLeka6DqiQPzjo5k1h+/EGDO/gfW/jG1t22n4Hjo+GVJO8
         k3lZ1e4d3hPce5Lbme5wv8Ook3xogr9hiSmACcGBxKLIGNpRb1Nx4yf/GVQb6Ffh5uPW
         3sF4tSu43AGusc5Qmy7ES4dpC5EqQSbtdgUvKgZQPBAOWSMhAaY7Xu56dCJ9k0HmSnrA
         ah68/m9t8F1T3Wk5GSZ/R6lm21ftCNPmDCC1z25zQ7Q0vtFsigyRP/RSp/8/2jBZkPYl
         dZqiL1XIm7J23cq69wmsSweA8rFnWqgVFP/pknnURLq5PDb9PLmdb4DKAYwlxrIKwu65
         HUGg==
X-Gm-Message-State: ANoB5pleyCmptw42g72KW4JPdXWrhBTM4N/PIAUbVleqF+pdK0hc85oS
        P2VXXa3Wf1U0i/bhEHf7l7e363R7RFc=
X-Google-Smtp-Source: AA0mqf6wqcDwF2tkO1oQQDvkmcLr4rNxJu2ootDtVrWruHVJrX/xBlzLbnZpn65/DJ6BFmRJdUzIeQ==
X-Received: by 2002:a5d:4526:0:b0:236:8425:7571 with SMTP id j6-20020a5d4526000000b0023684257571mr6915444wra.244.1668866543175;
        Sat, 19 Nov 2022 06:02:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s23-20020a1cf217000000b003c6c5a5a651sm7615941wmc.28.2022.11.19.06.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 06:02:22 -0800 (PST)
Message-Id: <e56858a3eb212dcd0b8f71bdbf8db96f51c5d648.1668866540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.git.1668866540.gitgitgadget@gmail.com>
References: <pull.1423.git.1668866540.gitgitgadget@gmail.com>
From:   "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Nov 2022 14:02:19 +0000
Subject: [PATCH 1/2] git-jump: add an optional argument 'stdout'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
        Yoichi Nakayama <yoichi.nakayama@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Yoichi Nakayama <yoichi.nakayama@gmail.com>

It can be used with M-x grep on Emacs.

Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>
---
 contrib/git-jump/README   |  9 ++++++++-
 contrib/git-jump/git-jump | 11 ++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 8bcace29d21..6aaa6a928d2 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -79,6 +79,13 @@ git jump grep -i foo_bar
 git config jump.grepCmd "ag --column"
 --------------------------------------------------
 
+You can use the optional argument 'stdout' to print the listing to
+standard output. You can use it with M-x grep on Emacs.
+
+--------------------------------------------------
+# In Emacs, M-x grep and invoke "git jump stdout <mode>"
+Run grep (like this): git jump stdout diff
+--------------------------------------------------
 
 Related Programs
 ----------------
@@ -100,7 +107,7 @@ Limitations
 -----------
 
 This script was written and tested with vim. Given that the quickfix
-format is the same as what gcc produces, I expect emacs users have a
+format is the same as what gcc produces, I expect other tools have a
 similar feature for iterating through the list, but I know nothing about
 how to activate it.
 
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 92dbd4cde18..a907f69304d 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -2,7 +2,7 @@
 
 usage() {
 	cat <<\EOF
-usage: git jump <mode> [<args>]
+usage: git jump [stdout] <mode> [<args>]
 
 Jump to interesting elements in an editor.
 The <mode> parameter is one of:
@@ -15,6 +15,9 @@ grep: elements are grep hits. Arguments are given to git grep or, if
       configured, to the command in `jump.grepCmd`.
 
 ws: elements are whitespace errors. Arguments are given to diff --check.
+
+If the optional argument `stdout` is given, print the quickfix
+lines to standard output.
 EOF
 }
 
@@ -69,6 +72,12 @@ if test $# -lt 1; then
 	exit 1
 fi
 mode=$1; shift
+if test "$mode" = "stdout"; then
+	mode=$1; shift
+	type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
+	"mode_$mode" "$@" 2>/dev/null
+	exit 0
+fi
 
 trap 'rm -f "$tmp"' 0 1 2 3 15
 tmp=`mktemp -t git-jump.XXXXXX` || exit 1
-- 
gitgitgadget

