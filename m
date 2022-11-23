Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F072C433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 07:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbiKWHEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 02:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiKWHEU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 02:04:20 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18533F2412
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 23:04:18 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so638611wmi.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 23:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG7afdG0COHOmfVOMrCXQbc2WjB03eSnuN/yf/YSMAs=;
        b=XnL2WmY9qaCwawjNGnwUVQn2IgY79iahJ1BRcUFTVa+zSxxV/HpSBcqFBVfVsVh+2K
         h5Zaej2mD/ljv3hZUTu7u86JeQM7BqcWhIp0Ho/ZMM3tYi9sHwK4ty+bNFPtLsbpDjb0
         VElyGT8dOeZCI1tbSCmSl4/BUJiGtzxPg81AqCHNXS+b1HX11b2/gLO06hZ9eCnoRJcT
         N6q2Rfmiiyo6xRpnA4WFN6+NrFTnZb/ukQclJOuTPWjI+kKyrW/6pOQvCGdU7lA5aIUg
         lcikOqPq+SS2GtVGRoDMgAWNjhW4or83ykCfvOsQsXUm2ML+gMHi/YBHxIkllnK6V3d5
         fWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hG7afdG0COHOmfVOMrCXQbc2WjB03eSnuN/yf/YSMAs=;
        b=LLL6Wb3WURq47AcFg5hoaT3KBR1dyMyzA3cDZIVV/UQePMAXl6V913eIOFYo/gGo38
         N31UXTdKf+cFfDnEmry0Wtaslqk2tt0BmG3OKwlQjMS7TKDsBcsi4uzjrQiSrX3kOJDx
         gzNElSddVQpclkHQAwgfB4iaCJdKaLP/0SrmhUiCNRLtIYcR81AeiLydQZg4JE9ghd+v
         DUkC+/9WMS7qW2uzyrhCQcVkUDomCyNT/o4QTXtt8FMPYhO5UIeKuRXKmX1D/bcFqN0I
         HEep/+5SwaNOuxoUZbM6tFUF1JpvrJxzmfpMI27B8rGOSBwDw9jbQWA/MOtnmEibza3U
         LJqA==
X-Gm-Message-State: ANoB5pn8dX0NCnPdbkr7Ey7RUAZxhKzgZD7PiLizGRXOHSiexOysz/Tr
        1m6LRzBuU7Z0oTirbUA64eddV5Q/+O8=
X-Google-Smtp-Source: AA0mqf6B0J4nUiSKM9977WG/9tfZ+S6ci/tkcQLyf/eVIMNhni4COGsft1h7OCPK0iugItFwJcwGjw==
X-Received: by 2002:a7b:c8d0:0:b0:3cf:ca91:7094 with SMTP id f16-20020a7bc8d0000000b003cfca917094mr18834606wml.24.1669187056221;
        Tue, 22 Nov 2022 23:04:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi14-20020a05600c3d8e00b003cf6e1df4a8sm1169889wmb.15.2022.11.22.23.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 23:04:15 -0800 (PST)
Message-Id: <446777d300d73498bd7da709fad75731a13d0d59.1669187053.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v5.git.1669187053.gitgitgadget@gmail.com>
References: <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
        <pull.1423.v5.git.1669187053.gitgitgadget@gmail.com>
From:   "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Nov 2022 07:04:11 +0000
Subject: [PATCH v5 1/3] git-jump: add an optional argument '--stdout'
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

