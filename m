Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927B4C7EE23
	for <git@archiver.kernel.org>; Mon, 15 May 2023 12:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbjEOMNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 08:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241385AbjEOMNk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 08:13:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900C21BF6
        for <git@vger.kernel.org>; Mon, 15 May 2023 05:13:17 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f50020e0f8so49433595e9.0
        for <git@vger.kernel.org>; Mon, 15 May 2023 05:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684152796; x=1686744796;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wqUfnFSVgSGtMqbFzJtE6fjkpqa7mDc9RPSfZp97QM=;
        b=h8SlBbz1XcixuSiRfoThJdN7GPLY42OnfzScc75ciIJdHFx+qMCOFO1ghvvQdFk/0j
         DBEzkbjwLJvOKEeIwDVu5fDGRqDYj/Gy8DT1uo1jNJMvoM3k2VETDqvA2rycPDrE30XZ
         CvF47bauvQR9f+GfsoZ+cOix3PRH03+PI5m+5C/PQUO10cZR4FvVyEGSIw6DcCBCF4yv
         P4rdHJIdo/54b3BcIJ9Ye/5BTayOkcVNtuzqNXr+GuaEOe3oAfiuk0/R/Qsu5ro9+/t3
         S1L053GeZ30a6AB+HGPZ8pOZe7UCZ07ONNlBcfywS/ywJbGrc5gndxRLjAlUnjvHAfqA
         vk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684152796; x=1686744796;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wqUfnFSVgSGtMqbFzJtE6fjkpqa7mDc9RPSfZp97QM=;
        b=EAc5KT28vPUq8xDccsryxbyrTUaynHvh+usYhzKrvWTVk/HRKKzN2t7jcs/FLAF7hL
         vDiJinz8PCCaKY2DHRn3eg4KkRMg8gOBXS87gBQ1cDVJpDhOgVwSaVll1e4yXWHOdu7Q
         H31ZTypXZnuHUQaPECNd+ydlWXidGONtsgany0e185crBZ6cjvCIEwdLlA8AtTTVe9fB
         oI42LnkfYwgtozahRzn4AnezOn2ObVRz9f2cAJ68vZZa1t2A675az3CT5CIYf9nyzkMr
         sObJmqwc3a0yKAAk8WvzpszZPQnyQXr6vTTvw0SZuuUTv3TaR5eh+aaJH49Mw9wpmNop
         c/2w==
X-Gm-Message-State: AC+VfDwtVHEDvMzh3Th2CcPuuctNS3RXkyFEsZi5JT0QMfnDgqX8cjZr
        bqvHNlXPKryU1TLf7JSC8HXYwtyY3CE=
X-Google-Smtp-Source: ACHHUZ58r25IYB5n8KUChfWA2qLpFw28U6Y7+Kc5bkv1xvkEG//avr1XlJ5URncm08Rgs4ngno+Krw==
X-Received: by 2002:adf:dfc7:0:b0:307:c0c4:1094 with SMTP id q7-20020adfdfc7000000b00307c0c41094mr12777020wrn.34.1684152795342;
        Mon, 15 May 2023 05:13:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d400a000000b00307a3045d65sm20478473wrp.46.2023.05.15.05.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:13:15 -0700 (PDT)
Message-Id: <fe442c2041b01985a4ecb0f2e9651231af2a439b.1684152793.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
References: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
        <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 May 2023 12:13:08 +0000
Subject: [PATCH v3 1/6] show-ref doc: update for internal consistency
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Allred <allred.sean@gmail.com>

- Use inline-code syntax for options where appropriate.
- Use code blocks to clarify output format.

This patch also swaps out 'SHA-1' language for the implementation-
agnostic 'OID' term where appropriate in preparation for supporting
different hashing algorithms.

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
 Documentation/git-show-ref.txt | 40 ++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index d1d56f68b43..be048bf1816 100644
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
+<oid> SP <ref> LF
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

