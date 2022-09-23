Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676CFC07E9D
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 19:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiIWTgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 15:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiIWTgB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 15:36:01 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155FF11CB2B
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 12:36:01 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id u132so1064551pfc.6
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=c1NHcHC8WRryyN3DqgOkP8chvKVLYsPQTEmq5gDgEhA=;
        b=Qlsno4CsaGKFkjqTNgccFqNnZ9MPjP4sl8xgGX0SfFrHQZe3dPmKNsm6YD7LtWesXT
         G5Mt6FAtdy3taUMsK+m5i4l3+eKqzo7QGAMWRZdQhM1ta+VydeoXl1H+5DT4XuYk99lA
         QQQvgbblJFXv6OcGL5cXicIDxLlqF4Btca7qabL2+QOsIM77p5X/QwlF8plKb/WJYxDA
         +VtVVp9L9IOvbCKl+3hZ9h1Tu4Ts6NS/5hGVTLE5k1qldoXlFAzdY72SNvR5LvXEgBEf
         vEwABrCbxVwiwEDFL2N38UZwvkJpK9F5Yhl8kYCf+/9/Bh1cfv4kzMa3l7Ayk2IkJ+nH
         SttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=c1NHcHC8WRryyN3DqgOkP8chvKVLYsPQTEmq5gDgEhA=;
        b=0Uoe7b4R/jTPYlBIKOscEKwlvbnbJlkJ7qUIIGjN/ABLBbMaoHL+nAyI30ebgLVBTR
         Gniao7tEwwco7IaIL8OrPd6Sq8fLunrEYZXTSDwIN34T5+Ho7igzYO1zzHd7bD7kJwp+
         wBFkpA2obeUPp4koMxUScXzCFt+DihP8UVTac9VrDtCvXW2bAgE8VPUBW226PAOWb07h
         Ap4VrwFsgTLbp42zBQtILYqRop0d04+1V5OiaZPPUoXDD0eeJPGD1zCE+uoPowXVn8uU
         Y2QSq3wbucYlGsKmXMWp+cCHysc75caFXc3Cxn8GvpeAvS0zx2U4UbC+XGjOe+sqqC59
         XTPw==
X-Gm-Message-State: ACrzQf15YGZEcjSZZ0VGp0Lu0o1rjIr9DkNYPXmmqb6CUF6uYknrE5/X
        pcZ0VbXs2kkvl6ivRxdTFx8lMBQQqKPlqg==
X-Google-Smtp-Source: AMsMyM56rJTLnxt6n6JfN9UMHhDkT4UBo96XKVWw+3JFhyWVb1QOBW0C7ap2WUfgOY1Xl8HQdFW+zQ==
X-Received: by 2002:a05:6a00:3492:b0:540:b30d:8396 with SMTP id cp18-20020a056a00349200b00540b30d8396mr10766089pfb.81.1663961759814;
        Fri, 23 Sep 2022 12:35:59 -0700 (PDT)
Received: from HB2.. ([2409:4081:9e0a:3b3c:eec2:b296:a7ef:6188])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902a3c900b00177e590df96sm6316181plb.118.2022.09.23.12.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:35:59 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH] doc/cat-file: allow --use-mailmap for --batch options
Date:   Sat, 24 Sep 2022 01:05:43 +0530
Message-Id: <20220923193543.58635-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.3.g2cb248e00d.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The command git cat-file can now use the mailmap mechanism to replace
idents with their canonical versions for commit and tag objects. There
are several options like `--batch`, `--batch-check` and
`--batch-command` that can be combined with `--use-mailmap`. But, the
documentation for `--batch`, `--batch-check` and `--batch-command`
doesn't say so. This patch fixes that documentation.

Mentored-by: Christian Couder's avatarChristian Couder <christian.couder@gmail.com>
Mentored-by: John Cai's avatarJohn Cai <johncai86@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-cat-file.txt | 44 ++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index ec30b5c574..3fdafc07ce 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -89,26 +89,44 @@ OPTIONS
 --batch::
 --batch=<format>::
 	Print object information and contents for each object provided
-	on stdin.  May not be combined with any other options or arguments
-	except `--textconv` or `--filters`, in which case the input lines
-	also need to specify the path, separated by whitespace.  See the
-	section `BATCH OUTPUT` below for details.
+	on stdin.
+
+	* When used with `--textconv` or `--filters`, the input lines
+	  must specify the path, separated by whitespace. See the section
+	  `BATCH OUTPUT` below for details.
+
+	* When used with `--use-mailmap`, the info command shows the size
+	  the object, if the idents recorded in it were the ones "corrected"
+	  by the mailmap mechanism.
+	  Cannot be used with any other options.
 
 --batch-check::
 --batch-check=<format>::
-	Print object information for each object provided on stdin.  May
-	not be combined with any other options or arguments except
-	`--textconv` or `--filters`, in which case the input lines also
-	need to specify the path, separated by whitespace.  See the
-	section `BATCH OUTPUT` below for details.
+	Print object information for each object provided on stdin.
+
+	* When used with `--textconv` or `--filters`, the input lines must
+	 specify the path, separated by whitespace. See the section
+	 `BATCH OUTPUT` below for details.
+
+	* When used with `--use-mailmap`, the info command shows the size
+	  the object, if the idents recorded in it were the ones "corrected"
+	  by the mailmap mechanism.
+	  Cannot be used with any other options.
 
 --batch-command::
 --batch-command=<format>::
 	Enter a command mode that reads commands and arguments from stdin. May
-	only be combined with `--buffer`, `--textconv` or `--filters`. In the
-	case of `--textconv` or `--filters`, the input lines also need to specify
-	the path, separated by whitespace. See the section `BATCH OUTPUT` below
-	for details.
+	only be combined with `--buffer`, `--textconv`, `--use-mailmap` or
+	`--filters`.
+
+	* When used with `--textconv` or `--filters`, the input lines must
+	  specify the path, separated by whitespace. See the section
+	  `BATCH OUTPUT` below for details.
+
+	* When used with `--use-mailmap`, the info command shows the size the
+	  object, if the idents recorded in it were the ones "corrected" by the
+	  mailmap mechanism.
+
 +
 `--batch-command` recognizes the following commands:
 +
-- 
2.38.0.rc1.3.g2cb248e00d.dirty

