Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC05C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 09:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjCVJva (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 05:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjCVJuz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 05:50:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B3E6153E
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 02:49:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l27so8014612wrb.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 02:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679478574;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyYRsR3FhUrM6ZSK38Xr53wc2x0CxvJgEc2ZX7R85HQ=;
        b=ZGTCB1EIADT57RLCuwRooOQY5fWeCY/CZ+zQ/pDOLFWE7y6tqQrkF2TSW64n4Bfval
         uRMVKPAVAW6ewMbnayjlGgvtJKO479CYgeoU7GNFtip2c7/W5gxOGGex5bUBZRAPhgLY
         FG8pX3UQbYGzcHD8NEpf6j2bdxJ71ZKMT4x5lxH4YM1CQnLDraaA275Bu/VzH1zCgyhi
         PLRIhGFs6+TthKk/kn2n/vq8yNG7q5JSVTQ05vTYhAvPZG9qmdqJPybAIp7+cHsh/58t
         NrmfSCOkKkvnM2UI1uxwK/2v91uh2/XadN2RzIilUaSvhj1T9pkALRSlzo3Nfh5nDs0K
         TNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679478574;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyYRsR3FhUrM6ZSK38Xr53wc2x0CxvJgEc2ZX7R85HQ=;
        b=UpZ9S7OhETi7r3OL26Mj5LNmn6/bxWfHa3sWBBSjPEUx5LbGN8QMvBOJdOEyDqCqz8
         RLw5DnDmAtMU5pYzQKoyJ+ytgjqQ/+25+qM7jWJ3mrMU4bD9Z9jwWRbZT67vizRuX8xg
         SPDPt60Jik4ZXK6swQVBX9bzZ4591AQYqcVqV/cmFHhu/8eto+CwpIZ8ZXZxd6ag1uk7
         V93Q9yT+2d/IRuom78ldHePYQ8w1CD1Cuc9rxBapJ7uxha758OoA87xOp1hYqGbWQ6pA
         459YHIXb355ZFMhbJ1mWaGKjYqKpsQ4LCBithsBHYXZxa/b/yyuFEjbhKjUTKCecktOF
         b8qQ==
X-Gm-Message-State: AO0yUKVfCycNEkirSVY02qf4g50TDHd2lKu2Cr+TnDOq7xhD75w3NexV
        mu/IpGe1zAe+Iax6Epg9lbYk8R0X7Jw=
X-Google-Smtp-Source: AK7set95LkjCxTZuVXAAPNpWlvURmNef6R2Ofm/mLShQj7dD17QXbaPA+2OYU/ngJQYE3h2EkHDKNw==
X-Received: by 2002:adf:e848:0:b0:2cf:e3d8:5dff with SMTP id d8-20020adfe848000000b002cfe3d85dffmr5228376wrn.9.1679478574737;
        Wed, 22 Mar 2023 02:49:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10-20020adff00a000000b002d1bfe3269esm13428431wro.59.2023.03.22.02.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 02:49:34 -0700 (PDT)
Message-Id: <4408b518810501139a8c7d2f7e2240eabea2839d.1679478573.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
References: <pull.1471.git.git.1679153586903.gitgitgadget@gmail.com>
        <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Mar 2023 09:49:32 +0000
Subject: [PATCH v2 1/2] Update show-ref documentation for internal consistency
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Allred <allred.sean@gmail.com>

- Use inline-code syntax for options where appropriate.
- Use code blocks to clarify output format.

This patch also swaps out 'SHA-1' language for the
implementation-agnostic 'OID' term where appropriate in preparation for
supporting different hashing algorithms.

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
 Documentation/git-show-ref.txt | 40 ++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index d1d56f68b43..cb876a342a3 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -23,7 +23,7 @@ particular ref exists.
 
 By default, shows the tags, heads, and remote refs.
 
-The --exclude-existing form is a filter that does the inverse. It reads
+The `--exclude-existing` form is a filter that does the inverse. It reads
 refs from stdin, one ref per line, and shows those that don't exist in
 the local repository.
 
@@ -47,14 +47,14 @@ OPTIONS
 -d::
 --dereference::
 
-	Dereference tags into object IDs as well. They will be shown with "{caret}{}"
+	Dereference tags into object IDs as well. They will be shown with `{caret}{}`
 	appended.
 
 -s::
 --hash[=<n>]::
 
-	Only show the SHA-1 hash, not the reference name. When combined with
-	--dereference the dereferenced tag will still be shown after the SHA-1.
+	Only show the OID, not the reference name. When combined with
+	`--dereference`, the dereferenced tag will still be shown after the OID.
 
 --verify::
 
@@ -70,15 +70,15 @@ OPTIONS
 -q::
 --quiet::
 
-	Do not print any results to stdout. When combined with `--verify` this
+	Do not print any results to stdout. When combined with `--verify`, this
 	can be used to silently check if a reference exists.
 
 --exclude-existing[=<pattern>]::
 
-	Make 'git show-ref' act as a filter that reads refs from stdin of the
-	form "`^(?:<anything>\s)?<refname>(?:\^{})?$`"
+	Make `git show-ref` act as a filter that reads refs from stdin of the
+	form `^(?:<anything>\s)?<refname>(?:\^{})?$`
 	and performs the following actions on each:
-	(1) strip "{caret}{}" at the end of line if any;
+	(1) strip `{caret}{}` at the end of line if any;
 	(2) ignore if pattern is provided and does not head-match refname;
 	(3) warn if refname is not a well-formed refname and skip;
 	(4) ignore if refname is a ref that exists in the local repository;
@@ -96,7 +96,13 @@ OPTIONS
 OUTPUT
 ------
 
-The output is in the format: '<SHA-1 ID>' '<space>' '<reference name>'.
+The output is in the format:
+
+------------
+<OID> SP <reference name> LF
+------------
+
+For example,
 
 -----------------------------------------------------------------------------
 $ git show-ref --head --dereference
@@ -110,7 +116,13 @@ $ git show-ref --head --dereference
 ...
 -----------------------------------------------------------------------------
 
-When using --hash (and not --dereference) the output format is: '<SHA-1 ID>'
+When using `--hash` (and not `--dereference`), the output is in the format:
+
+------------
+<OID> LF
+------------
+
+For example,
 
 -----------------------------------------------------------------------------
 $ git show-ref --heads --hash
@@ -142,10 +154,10 @@ When using the `--verify` flag, the command requires an exact path:
 
 will only match the exact branch called "master".
 
-If nothing matches, 'git show-ref' will return an error code of 1,
+If nothing matches, `git show-ref` will return an error code of 1,
 and in the case of verification, it will show an error message.
 
-For scripting, you can ask it to be quiet with the "--quiet" flag, which
+For scripting, you can ask it to be quiet with the `--quiet` flag, which
 allows you to do things like
 
 -----------------------------------------------------------------------------
@@ -157,11 +169,11 @@ to check whether a particular branch exists or not (notice how we don't
 actually want to show any results, and we want to use the full refname for it
 in order to not trigger the problem with ambiguous partial matches).
 
-To show only tags, or only proper branch heads, use "--tags" and/or "--heads"
+To show only tags, or only proper branch heads, use `--tags` and/or `--heads`
 respectively (using both means that it shows tags and heads, but not other
 random references under the refs/ subdirectory).
 
-To do automatic tag object dereferencing, use the "-d" or "--dereference"
+To do automatic tag object dereferencing, use the `-d` or `--dereference`
 flag, so you can do
 
 -----------------------------------------------------------------------------
-- 
gitgitgadget

