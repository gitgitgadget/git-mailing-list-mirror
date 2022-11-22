Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF9DC4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 14:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiKVOSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 09:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiKVOS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 09:18:29 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E69E58BDB
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:18:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z4so10339378wrr.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG7afdG0COHOmfVOMrCXQbc2WjB03eSnuN/yf/YSMAs=;
        b=fUmdCwowRYqmyln/CIWg2BNxhRCi7MB3JjTSCFTtzYzM5qb7B3NjjoO+kRcI/m2Lu2
         InUKKdQJ6A+4zzpFMdD4Dhb4iZMybKEP5ZOw1G0uJMwnI+Te7i/skEklG3VUGsCUV9pP
         f/axRg12Y6406umM7xR+WtjXxpSWZ8CbXGeer/J3B9xxBtGdz8Z6JYNua5Ozs0XxDAba
         19jESiXoAYXAePEb6pb5htQaoxSLOroFFcE0LzQqDtz4Tttd26/RN9F+v39YDcUNN6rB
         3d3uTSZkDA4hAB4G56UyhEyqBiylOP8BN3sirzjuH2q3ufNXBJLyN0oJGoVg9KrWbVrj
         ih1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hG7afdG0COHOmfVOMrCXQbc2WjB03eSnuN/yf/YSMAs=;
        b=Q0hFi/vsra7GZUZ0jzf/OW1TgCCJ1PmpasX70ee+W2fmOhpAfVzy4fzPH43CL1I/Vs
         lbojgsyvnQ8qce+JADtIX6LACCFa+QgzAXlPJ7oLSLFKpvYPR6oqUBh0oulug8Jn6Wgn
         Af/NOen+7HVrBdF7vLjwzmFn/A2hEB9GHfR0qXMerc73RHpAIQ2eJReqm2lrD8u7vqWX
         vXwyECdGZzM5/B4Yc7kGlmLJ1wk/EbfEmo5fVA/Hyi4yBYFheSQl+tK0xuX+49tET+IF
         KLDxf6V62sBWWcnlJ6Gejgdk75BFuy17ya5veNPYAl96PaWIKixNh5L/K8LYbo/qPQrv
         foWA==
X-Gm-Message-State: ANoB5pmFXnrPBJ3eE6UkD/WXoiuKtvuduNf8eVean9SLRYmbrSuU4Mxp
        onIgr/yzIordAzGI87StiPWVJnjuTdQ=
X-Google-Smtp-Source: AA0mqf5ei9pPsFyY31u5yPl2mh1YJFYk3ORxgyXQrofiHHfjOjJF2x5Zimbf0wF58A+ZAl0R+GFovg==
X-Received: by 2002:a5d:558b:0:b0:241:d71b:fd4c with SMTP id i11-20020a5d558b000000b00241d71bfd4cmr6163308wrv.435.1669126706525;
        Tue, 22 Nov 2022 06:18:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d490b000000b0023691d62cffsm12385406wrq.70.2022.11.22.06.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:18:25 -0800 (PST)
Message-Id: <446777d300d73498bd7da709fad75731a13d0d59.1669126703.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
References: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
        <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
From:   "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Nov 2022 14:18:22 +0000
Subject: [PATCH v4 1/2] git-jump: add an optional argument '--stdout'
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

