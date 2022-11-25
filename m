Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB09C433FE
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 03:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKYDhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 22:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKYDhH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 22:37:07 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE822B181
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 19:37:06 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bs21so4977876wrb.4
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 19:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG7afdG0COHOmfVOMrCXQbc2WjB03eSnuN/yf/YSMAs=;
        b=Y6CPvZkIqNKmNPNsqW+Y7QhSxe7sW9px4gyH+DnpcwPp6xrzpwfSFtSH7liRiBwE0A
         h6w00QRcMvRlfkwQbAcCYCrnvEyVBc4YgShEIuJIn0AbF+cRw2L2sU6GdXMQtB4v/dqT
         Iw0rCUvVOesV4E+xaZmbgMC5L5/qX8C2z3Zr7ojAalyAKZ6Eg+3+AeROjOWh4Cl4Ffvf
         pLi/QX4ojqm8wpo6AO5Dy5Bdyl0NLFLOEdw8ozb+TC6jsMD2J6tTlqGQN5TvHtrc60mH
         0BD0N+NPVrQfdVN+halaeyl2XzWzd+qqU8gHjB9EXfvRCqqer40bIYBUaZTEFAWPtSWP
         p5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hG7afdG0COHOmfVOMrCXQbc2WjB03eSnuN/yf/YSMAs=;
        b=nfaq1C2yCNmYjcXzO52CqhtgaEIuHq3o57jzijLkVGqMkYQL5rJrJGCHJFdq4YADXI
         sjKGV1oIYm9eWqgqfuMi/MXR6NU2NIbgE80HQ54134kjMu16DZ5O2bh3f/f7lwX0R+7y
         nbEvKZW9R6e5IdV1olgx/gDQ+MpUosSwjEkH3rkQ5+7xtLsAG8DMDx7mp0/ND83gWjYd
         dSYDtoEP8WvSrP/WMLHmO8tWGxLjb2Oa8OsBqLj9sXeN9QdAFZq+k4eQqpJeHkkMFKsV
         7KV1wEp2xzmOgxErkVI0sUUTSWKl8IbqeSj5GlVg2Qb+TzQnGNnLVGlwC1vIYG5qJHk4
         eRgA==
X-Gm-Message-State: ANoB5pmWTmRoprvRbOKKdENCe3QkA/9XktFIZ3MCmbly4O3xMGgUh/Cw
        GUmgiaLJR90yOdVk9nCcdZXFVu7volE=
X-Google-Smtp-Source: AA0mqf6lUynq7j97DE/VBdebKNJY8QZQVBpemLraK3sg1fVIsIrI37PTwyz9k1N+24NfO/hBaz6pUg==
X-Received: by 2002:a5d:5948:0:b0:241:e929:fc44 with SMTP id e8-20020a5d5948000000b00241e929fc44mr7452742wri.27.1669347424685;
        Thu, 24 Nov 2022 19:37:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b003cffd3c3d6csm4074950wmq.12.2022.11.24.19.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 19:37:04 -0800 (PST)
Message-Id: <446777d300d73498bd7da709fad75731a13d0d59.1669347422.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
References: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
        <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
From:   "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Nov 2022 03:36:59 +0000
Subject: [PATCH v7 1/3] git-jump: add an optional argument '--stdout'
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
 contrib/git-jump/README   | 10 +++++++++-
 contrib/git-jump/git-jump | 25 ++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 8bcace29d21..3211841305f 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -79,6 +79,14 @@ git jump grep -i foo_bar
 git config jump.grepCmd "ag --column"
 --------------------------------------------------
 
+You can use the optional argument '--stdout' to print the listing to
+standard output instead of feeding it to the editor. You can use the
+argument with M-x grep on Emacs:
+
+--------------------------------------------------
+# In Emacs, M-x grep and invoke "git jump --stdout <mode>"
+M-x grep<RET>git jump --stdout diff<RET>
+--------------------------------------------------
 
 Related Programs
 ----------------
@@ -100,7 +108,7 @@ Limitations
 -----------
 
 This script was written and tested with vim. Given that the quickfix
-format is the same as what gcc produces, I expect emacs users have a
+format is the same as what gcc produces, I expect other tools have a
 similar feature for iterating through the list, but I know nothing about
 how to activate it.
 
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 92dbd4cde18..babb3b5c68d 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -2,7 +2,7 @@
 
 usage() {
 	cat <<\EOF
-usage: git jump <mode> [<args>]
+usage: git jump [--stdout] <mode> [<args>]
 
 Jump to interesting elements in an editor.
 The <mode> parameter is one of:
@@ -15,6 +15,9 @@ grep: elements are grep hits. Arguments are given to git grep or, if
       configured, to the command in `jump.grepCmd`.
 
 ws: elements are whitespace errors. Arguments are given to diff --check.
+
+If the optional argument `--stdout` is given, print the quickfix
+lines to standard output instead of feeding it to the editor.
 EOF
 }
 
@@ -64,11 +67,31 @@ mode_ws() {
 	git diff --check "$@"
 }
 
+use_stdout=
+while test $# -gt 0; do
+	case "$1" in
+	--stdout)
+		use_stdout=t
+		shift
+		;;
+	--*)
+		usage >&2
+		exit 1
+		;;
+	*)
+		break
+		;;
+	esac
+done
 if test $# -lt 1; then
 	usage >&2
 	exit 1
 fi
 mode=$1; shift
+if test "$use_stdout" = "t"; then
+	"mode_$mode" "$@"
+	exit 0
+fi
 
 trap 'rm -f "$tmp"' 0 1 2 3 15
 tmp=`mktemp -t git-jump.XXXXXX` || exit 1
-- 
gitgitgadget

