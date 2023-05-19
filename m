Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17CDC77B75
	for <git@archiver.kernel.org>; Fri, 19 May 2023 04:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjESESO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 00:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjESESG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 00:18:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4339610C6
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:17:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f50020e0f8so2203775e9.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684469876; x=1687061876;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOmXZBVYK0/JUm+9xyrublcR+LkoUPIi7w9y1Zqps/U=;
        b=YKv9u1P5DQETo7K3n7TBvHVJ0GCa1IbWHs8Q8SmczB8MuUCYSIdEdIb1krMHqAHnsI
         vtuANiAUMS3K9XkqOnlUrLK6TQygqvL9j5gNyrLwNa6uhyGU4XdwBXv+RRMBLWDnNon7
         Gt3WhQtYPjiF83A7XIdsspO7ONmWO9cl8JC70ywUlDLc8mg/Mv+se0Kjzt01Tfnjct85
         UqjgeZle+U8EQSmDee49pAJVHQOJtDRbo//8hG/o3wDINOIwhA5fSvUH6oVrDnnj1kXT
         iuq8dmrpRygkYzgZ2IqpWXCaKNKSIytjjH4VDfgkOR4JRDh2hosmjhLEtKdg+RlfzwKN
         4c6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684469876; x=1687061876;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOmXZBVYK0/JUm+9xyrublcR+LkoUPIi7w9y1Zqps/U=;
        b=Ty79ZFsiHWHyuIdJGUzv5ZryXp3jiyM3Blg+Y8pan3uPahPqsl610OzhQVws0G7xWa
         v500PUPhb2lZXoYz1Ivk+I76V6wCov1wUedYW/axRndQmX1/IKQ/4muyZD3ZPwtsgay0
         97+R3TEKQe7S2FFXuMz2QgBA8Rj+mSzoMQHOTkU3hYnnHS/qL0NoDyk+gJNZ1slXqTjX
         4rxWSg7JWZJw0+8hnITr19o1RURVjiizdKzXi62kJBdaAiP6bkRWdA6qaq4LMiXjAywp
         +xXeErQY32SdjDNXjNj4ws2Xhr/8v5cmWbyDMaFJKdO03/Ye8+zCJJMv3Q/u0SMEyuwP
         gbHw==
X-Gm-Message-State: AC+VfDwTXwsOiegBuSjC+3gLeENJDayIRrVqF2bA8ErDbuWYwlxt2lzy
        eCntj2x1OFmRw95J2pZUOMR1UdqX/gg=
X-Google-Smtp-Source: ACHHUZ4LuUqVmfQFOd+mAW4sM5dFTkTCBvKwkaAS7LbOMmru0LB/14eNangyO1VazjtGUD7C/MKR1w==
X-Received: by 2002:a7b:c448:0:b0:3f4:2aeb:30d with SMTP id l8-20020a7bc448000000b003f42aeb030dmr292750wmi.4.1684469876432;
        Thu, 18 May 2023 21:17:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w19-20020a1cf613000000b003f1958eeadcsm1023781wmc.17.2023.05.18.21.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 21:17:56 -0700 (PDT)
Message-Id: <49382e81e02c4da2460eb35978044b6ed2e3049a.1684469874.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.v4.git.git.1684469874.gitgitgadget@gmail.com>
References: <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
        <pull.1471.v4.git.git.1684469874.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 May 2023 04:17:49 +0000
Subject: [PATCH v4 1/6] show-ref doc: update for internal consistency
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
- Use 'OID' (for 'object ID') instead of 'SHA-1' as we support
  different hashing algorithms these days.

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
 Documentation/git-show-ref.txt | 40 ++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index d1d56f68b43..44c7387d78f 100644
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
+<oid> LF
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

