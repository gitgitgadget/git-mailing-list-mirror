Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBEAC4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 01:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiKTB1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 20:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiKTB13 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 20:27:29 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67535FC0
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 17:27:28 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so6724822wmi.3
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 17:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=my1QQWoFO7+/m/3OaLQ+s64mTrAYaKiHnfOWRzZ1LDM=;
        b=SpxrRYsHonczZ+K0HmZyaUDE9RPfoSd0zEoBC0w7Qw/iBGr4A1YThm6/B1/cOoG6ZQ
         TGjwbI0YQ9ja6B8A3Y2u+N3NEhLpqHiHTZy3OxoalxcImVGw+NNIo6q5avPsAelLZMis
         uZN3FmWX/dEhz3FXBBLZJs6uqBhrtk0Vy/234tneeRDbqK0ZcV4hTO9MrtWsIHxz64kY
         /kjRufsDDfAjw9V/cdAr75csEdvVnwLS39yRdavje+QSE8BSo4DichKugfl1XbHBcGP1
         vvM7R7+00/WCp7dYMjfmevBKhAo/SbnRI1Tol2bLV3S8szU5uKNWbPBfGbGTWX+AhRbQ
         XLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=my1QQWoFO7+/m/3OaLQ+s64mTrAYaKiHnfOWRzZ1LDM=;
        b=nK7w0Vw2ycW8A7ymvYLte6IWjrVZh8e1w9alCemkW5qP4Wr+jL4XXLTY9VYEuTNcLU
         2Qku5UE4id3T5dVOqh7HuPMj5lXY5DOpAXmqpWQvOXLwCguPZ3lSEQQDEpFd2m/gCJwP
         GREBpTHlM2U5i0C4nsqAJO3px4yybYsfB45jGYocSXpoSIOSiij9K+A5zVJMJXziMfeM
         sdb+sCI2pPVY5+RkI34rsEB5KxKwN0RzlJEGGUeizxPax+056se9fxkeJjhumPAvYX0p
         AzjtkI9myoMPSd+k+iF1vofuHDYZUBRXpc7+0GnPZOM6GPxWPKkLNuPatbBX8CQ0vJqd
         M58A==
X-Gm-Message-State: ANoB5pmL0Y1VU/LBbmL9pvPM2RmgO52oYVq8Hgm6Z+p4BZJpkhUwgFnv
        8wii/o8/SvHQcm18AGO7qqHY3Wq5uDI=
X-Google-Smtp-Source: AA0mqf4sANceyqE1z2NgI9TqMYmSQaI89sDNneIFKH2HEKpltL6/Ik0bTt2Diz7+qf4iQw3Wh4yicg==
X-Received: by 2002:a7b:c456:0:b0:3a5:f600:502e with SMTP id l22-20020a7bc456000000b003a5f600502emr8760271wmi.39.1668907646892;
        Sat, 19 Nov 2022 17:27:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10-20020adff48a000000b002366ded5864sm7426866wro.116.2022.11.19.17.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 17:27:26 -0800 (PST)
Message-Id: <e56858a3eb212dcd0b8f71bdbf8db96f51c5d648.1668907644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
References: <pull.1423.git.1668866540.gitgitgadget@gmail.com>
        <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
From:   "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Nov 2022 01:27:23 +0000
Subject: [PATCH v2 1/2] git-jump: add an optional argument 'stdout'
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

