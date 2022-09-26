Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF669C6FA82
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 09:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbiIZJQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 05:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiIZJPI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 05:15:08 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1937815FCC
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 02:14:56 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d10so4937492pfh.6
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 02:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bMUZYHswL+8Vyo2D+Y2QFShoKHi94qXLecaQbeSF9Os=;
        b=SgcnBOWZMPnKB3v7QVb6rBR4Nfe2sK+FksS8oh5wZ5UOvEnX1HILxVei7tewqiJ+M8
         NratdY0XbZ76uKA4L+OHzs5vgIRtC+pdoYFtIN15dxEIcyo472Cpt27ITNxsJ/ZiAzDj
         S/GsUAWcpaHHoogp6p1DOFELzRq5E4Vims6dqneHnw+StLWGnNi90cSWaRQvjACO4ERp
         PuroNX6I9VO6AJ1JxeoaXwLYDTF1JewLD6BFueFglMCtc/rmVj2fqbsr60/ppzuOnNo/
         ceqHhF0+tiuwOer3kvcn3/T5hf/HuYk2lOfV02fehCQ39RnnFq/l9XiuTDjXVD6z8wP1
         UO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bMUZYHswL+8Vyo2D+Y2QFShoKHi94qXLecaQbeSF9Os=;
        b=t+QAqr5cdH28ddpZhYLuc/wTXB1AfWzcbzii5oBU5HxVQlkJlYVuMuvtYSJciQlDfp
         8z5S8h+g7u0HldL7p/1j3dNo/NYfeTiYyth+N89Y3GX2EdbXf4ufGQ7H7O0txlo1GUjn
         jCFdmO8piszQYIeMjf4SdtFA0jsc4XlUO7TlHFUsZg24tHqaQsVrSeAKZHuUG2fOm/Bx
         x41VYU/zETJHx6NiJBX6KR50Bf/0kZ9ChnmTwTxokDE/N8auUFsyMm+Z9BswAW9cUtEx
         nCRvWzpgKMIR9wPvJJrRJQuuXk+rUGzReA/G9ngAQOXupVjdT8l5Y2NF4zSFEbfprQnA
         FEVw==
X-Gm-Message-State: ACrzQf0H2MWPU8amqPfrENEIF/fVlKCYakjlIHcxqsdx0UWlsAaDJ5rk
        GTibW866gHAlfWvkET120Mqnwvni8m7SAQ==
X-Google-Smtp-Source: AMsMyM4jXEHmO7bdX70cZf1N/lZpaLheEz0xAtNn3VY0nBd96Ry7Bs3HDVzgXyeX4yZMjXScYjwdVA==
X-Received: by 2002:a05:6a00:17a2:b0:540:f501:ab76 with SMTP id s34-20020a056a0017a200b00540f501ab76mr22840667pfg.42.1664183695391;
        Mon, 26 Sep 2022 02:14:55 -0700 (PDT)
Received: from HB2.. ([2409:4081:9e0a:3b3c:baa6:3f:18b6:80cf])
        by smtp.gmail.com with ESMTPSA id e2-20020aa79802000000b00551fa0e2b2dsm11592079pfl.206.2022.09.26.02.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 02:14:54 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH] doc/cat-file: allow --use-mailmap for --batch options
Date:   Mon, 26 Sep 2022 14:44:42 +0530
Message-Id: <20220926091442.222876-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.4.g29ac4cf309.dirty
In-Reply-To: <20220923193543.58635-1-siddharthasthana31@gmail.com>
References: <20220923193543.58635-1-siddharthasthana31@gmail.com>
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

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---

This patch was previously sent as the first patch of a 3 patch series for 
adding the mailmap support in git cat-file options:
https://lore.kernel.org/git/20220916205946.178925-2-siddharthasthana31@gmail.com/

Changes in v2:
- Fixed the names in trailers in the commit message
- Updated the documentation to clearly state that the `--batch-check`,
  `--batch-command` and `--batch` options can only be used with
  `--textconv`, `--filters` or `--use-mailmap`.
- Fixed formating

 Documentation/git-cat-file.txt | 45 ++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index ec30b5c574..2a8f050a29 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -89,26 +89,45 @@ OPTIONS
 --batch::
 --batch=<format>::
 	Print object information and contents for each object provided
-	on stdin.  May not be combined with any other options or arguments
-	except `--textconv` or `--filters`, in which case the input lines
-	also need to specify the path, separated by whitespace.  See the
-	section `BATCH OUTPUT` below for details.
+	on stdin. May not be combined with any other options or arguments
+	except --textconv, --filters or --use-mailmap.
+	+
+	* When used with `--textconv` or `--filters`, the input lines
+	  must specify the path, separated by whitespace. See the section
+	  `BATCH OUTPUT` below for details.
+	+
+	* When used with `--use-mailmap`, the info command shows the size
+	  the object, if the idents recorded in it were the ones "corrected"
+	  by the mailmap mechanism.
 
 --batch-check::
 --batch-check=<format>::
-	Print object information for each object provided on stdin.  May
-	not be combined with any other options or arguments except
-	`--textconv` or `--filters`, in which case the input lines also
-	need to specify the path, separated by whitespace.  See the
-	section `BATCH OUTPUT` below for details.
+	Print object information for each object provided on stdin. May not be
+	combined with any other options or arguments except --textconv, --filters
+	or --use-mailmap.
+	+
+	* When used with `--textconv` or `--filters`, the input lines must
+	 specify the path, separated by whitespace. See the section
+	 `BATCH OUTPUT` below for details.
+	+
+	* When used with `--use-mailmap`, the info command shows the size
+	  the object, if the idents recorded in it were the ones "corrected"
+	  by the mailmap mechanism.
 
 --batch-command::
 --batch-command=<format>::
 	Enter a command mode that reads commands and arguments from stdin. May
-	only be combined with `--buffer`, `--textconv` or `--filters`. In the
-	case of `--textconv` or `--filters`, the input lines also need to specify
-	the path, separated by whitespace. See the section `BATCH OUTPUT` below
-	for details.
+	only be combined with `--buffer`, `--textconv`, `--use-mailmap` or
+	`--filters`.
+	+
+	* When used with `--textconv` or `--filters`, the input lines must
+	  specify the path, separated by whitespace. See the section
+	  `BATCH OUTPUT` below for details.
+	+
+	* When used with `--use-mailmap`, the info command shows the size the
+	  object, if the idents recorded in it were the ones "corrected" by the
+	  mailmap mechanism.
+
 +
 `--batch-command` recognizes the following commands:
 +
-- 
2.38.0.rc1.4.g29ac4cf309.dirty

