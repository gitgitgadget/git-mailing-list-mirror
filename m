Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D89C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 07:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjDRHBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 03:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjDRHAz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 03:00:55 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B19CD
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 00:00:54 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-541b61d166aso203667eaf.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 00:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681801253; x=1684393253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuyHjlPxVmoFJyFLqtCF0y6pFnecF7mjQTJHJJxaN5o=;
        b=G7gFrMNB0N7+Nk281YhpRnNo+KqV8kqLSQGKG9/6g8S2TyK2urfoP25lOmcRJIy0qO
         ORWsvuLUSicCspInxGwdAPY74Nxiiw4CLlU6PfEjfxNE110AL1V+xrzn77YzsZI38L11
         4LK6EYYsd4NcFlYD1FsNJdMqY4oSaWs+P/CkpuuJnKJEaFlyb368NuEn2TnWzuZDNvKk
         PgcocxX/yCemtdJkpVsf+HpMX2wHM5UXCZxU0v0lDSgaTnBqWFHRFG9UwR5/5GYef1L9
         YnZ4cLpHl280U0oajGDDhRpT5scyPqg3LlUVcGiO7RS2NI/28wo3HM/nTZlfD19GZ74E
         bPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681801253; x=1684393253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuyHjlPxVmoFJyFLqtCF0y6pFnecF7mjQTJHJJxaN5o=;
        b=JG80hF7w5/SQa6qTYvZ+CYXmDrZ1OSLGzJsSBO4/unwaZHoIiMnHuUKLJ9K7OTGpEO
         ZGajfxt5UwTHtBMAnYMWA2bYT7xPWMiUxHrXxg1tGLQ/BMfO+lvxS9m3mmoNaiYcgz9o
         aHoJD3pj3lBwAyKF9vTFUczo7zMaKw02TijUqWxTE/oReNowbA6fO12eBZ8VOU00fW0T
         031iB6Ic7b7z3k4+2ZMCKuoHZW7zufZ9pNFNT7Vo6vikcpavsiZigyllTqQJiLbG7MOx
         7IGQgF2wahA9z1bDqSS0EgmWqLijfBoduNKUgpN0z6jQMxtjmko+Pl/rM0MYYNRQS3FG
         sA/Q==
X-Gm-Message-State: AAQBX9cfdiBbQLMZsSRIhB6ewpjlX2dmUg1Vv2LTASmttx2dSGLmp/zv
        qyjE+fZa0/KaI6YctPlNSZ+YTbNgsJI=
X-Google-Smtp-Source: AKy350ZiuwgY1MRJFIoKLO21ewzPwKF2y2Drb12eofx7uEv+J2lkX1aXNgJSlOiRCb5ldMHHiWhnxA==
X-Received: by 2002:a05:6870:15c8:b0:183:cf64:1527 with SMTP id k8-20020a05687015c800b00183cf641527mr735081oad.19.1681801253069;
        Tue, 18 Apr 2023 00:00:53 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id u5-20020a056870b0c500b00172ac40356csm5270230oag.50.2023.04.18.00.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 00:00:52 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] doc: git-checkout: reorganize examples
Date:   Tue, 18 Apr 2023 01:00:48 -0600
Message-Id: <20230418070048.2209469-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230418070048.2209469-1-felipe.contreras@gmail.com>
References: <20230418070048.2209469-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The examples are an ordered list, however, they are complex enough that
a callout is inside example 1, and that confuses the parsers as the list
continuation (`+`) is unclear (are we continuing the previous list item,
or the previous callout?).

We could use an open block as the asciidoctor documentation suggests,
but that has a tiny formatting issue (a newline is missing).

To simplify things for everyone (the reader, the writer, and the parser)
let's use subsections.

After this change, the HTML documentation generated with asciidoc has
the right indentation.

Cc: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-checkout.txt | 50 +++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 8ddeec63dd..4af0904f47 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -516,10 +516,12 @@ to checkout these paths out of the index.
 EXAMPLES
 --------
 
-. The following sequence checks out the `master` branch, reverts
-  the `Makefile` to two revisions back, deletes `hello.c` by
-  mistake, and gets it back from the index.
-+
+=== 1. Paths
+
+The following sequence checks out the `master` branch, reverts
+the `Makefile` to two revisions back, deletes `hello.c` by
+mistake, and gets it back from the index.
+
 ------------
 $ git checkout master             <1>
 $ git checkout master~2 Makefile  <2>
@@ -529,70 +531,74 @@ $ git checkout hello.c            <3>
 <1> switch branch
 <2> take a file out of another commit
 <3> restore `hello.c` from the index
-+
+
 If you want to check out _all_ C source files out of the index,
 you can say
-+
+
 ------------
 $ git checkout -- '*.c'
 ------------
-+
+
 Note the quotes around `*.c`.  The file `hello.c` will also be
 checked out, even though it is no longer in the working tree,
 because the file globbing is used to match entries in the index
 (not in the working tree by the shell).
-+
+
 If you have an unfortunate branch that is named `hello.c`, this
 step would be confused as an instruction to switch to that branch.
 You should instead write:
-+
+
 ------------
 $ git checkout -- hello.c
 ------------
 
-. After working in the wrong branch, switching to the correct
-  branch would be done using:
-+
+=== 2. Merge
+
+After working in the wrong branch, switching to the correct
+branch would be done using:
+
 ------------
 $ git checkout mytopic
 ------------
-+
+
 However, your "wrong" branch and correct `mytopic` branch may
 differ in files that you have modified locally, in which case
 the above checkout would fail like this:
-+
+
 ------------
 $ git checkout mytopic
 error: You have local changes to 'frotz'; not switching branches.
 ------------
-+
+
 You can give the `-m` flag to the command, which would try a
 three-way merge:
-+
+
 ------------
 $ git checkout -m mytopic
 Auto-merging frotz
 ------------
-+
+
 After this three-way merge, the local modifications are _not_
 registered in your index file, so `git diff` would show you what
 changes you made since the tip of the new branch.
 
-. When a merge conflict happens during switching branches with
-  the `-m` option, you would see something like this:
-+
+=== 3. Merge conflict
+
+When a merge conflict happens during switching branches with
+the `-m` option, you would see something like this:
+
 ------------
 $ git checkout -m mytopic
 Auto-merging frotz
 ERROR: Merge conflict in frotz
 fatal: merge program failed
 ------------
-+
+
 At this point, `git diff` shows the changes cleanly merged as in
 the previous example, as well as the changes in the conflicted
 files.  Edit and resolve the conflict and mark it resolved with
 `git add` as usual:
-+
+
 ------------
 $ edit frotz
 $ git add frotz
-- 
2.40.0+fc1

