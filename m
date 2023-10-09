Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4ABE95A8E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 01:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344723AbjJIBQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 21:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjJIBQK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 21:16:10 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9263DB3
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 18:16:08 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a200028437so50117287b3.1
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 18:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696814167; x=1697418967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xR218/AEDXmoIw40ifqi2PJW9fKFVTdPXF/U+trTOOs=;
        b=YZdwh3CwZYZHWb0Fh4brMKWOh9tzYovK95Fj/WpN4HEDHEob3lihg3mThlbXbp61g2
         9DBp2BSio4Zv6dBXTDvMx7kqiF0KOuaj08Q75vmw4dqJkVjMe5f8ygpa5SCp/ZXFsj6y
         6iY/Ey6sm00l+baxyyY1uVb+2/IE+d45kly0JVlzSIIgU3l0QLUwPeZ9NbE/h50OaQP0
         WQ0+0e7zPaYZWSxnj/Rb3Jtm/PiDDjA6sPHrmkYaFZsUqyTHpu3l55t433oKzEWuWgRf
         yfM7g6k+g5Nm1pSbTNkoYo98IrHmtu67ghadAzsIPKobD+9m6mx9Hdcc7xtB8c5QXucc
         zFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696814167; x=1697418967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xR218/AEDXmoIw40ifqi2PJW9fKFVTdPXF/U+trTOOs=;
        b=PRlqp3kEuVqOpAK7p8r/WdP+ygUYy/2JzUDd76n71v4OGz8gZqAMYAdpI2oNntcxLQ
         /8hR+tg9SJ6bqXNxDmWRBIBTP0/5A+g7DvhxIUF4iKUi4aZ5x0mMCzoW+2/1taOf5y7P
         DCgQC1CH4O4c7Vh41kGQufCSbybxiYZJLrd66lxbuM6Olj4s70dofcAiyXSSvszii52g
         HwyAnO1r3burl0nyQMNHymeKZPE8t2hKoj46040oKwX3mSe0pyLFzvj29XHw4QbZSc76
         6TYroZbZsiq8QsHHVgqBfyNsVp0+IHhXzuPc3yN9JlSegYG35AvEyxFi92d/OqDnT45O
         ZsYg==
X-Gm-Message-State: AOJu0Yzb76VhmdiBo+b3hAPsbX0Fha9+wHmmPjl9EJ7fICVZjcDSxXgT
        qErzNJiRd3+gRqp7UUAk1NDLNWQtIWBxklw=
X-Google-Smtp-Source: AGHT+IG2AHPqa5xeyRKiSFN9IEgMwoWrvMMuW7e3Pl29B/AOHjjqAFLHsNbZ/73AIPem13YSWewhIg==
X-Received: by 2002:a05:690c:886:b0:56c:f32d:1753 with SMTP id cd6-20020a05690c088600b0056cf32d1753mr6947347ywb.44.1696814167589;
        Sun, 08 Oct 2023 18:16:07 -0700 (PDT)
Received: from localhost.localdomain ([102.89.34.102])
        by smtp.gmail.com with ESMTPSA id t3-20020a0dea03000000b0057399b3bd26sm3303210ywe.33.2023.10.08.18.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 18:16:07 -0700 (PDT)
From:   Naomi Ibe <naomi.ibeh69@gmail.com>
To:     git@vger.kernel.org
Cc:     Naomi <naomi.ibeh69@gmail.com>
Subject: [PATCH 1/1] [OUTREACHY] Fixed add.c file to conform to guidelines when using die() listed in issue #635
Date:   Mon,  9 Oct 2023 02:15:45 +0100
Message-Id: <20231009011546.509-1-naomi.ibeh69@gmail.com>
X-Mailer: git-send-email 2.36.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Naomi <naomi.ibeh69@gmail.com>

Signed-off-by: Naomi Ibe <naomi.ibeh69@gmail.com>
---
 builtin/add.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c27254a5cd..5126d2ede3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -182,7 +182,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
 	if (repo_read_index(the_repository) < 0)
-		die(_("Could not read the index"));
+		die(_("could not read the index"));
 
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.diffopt.context = 7;
@@ -200,15 +200,15 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 		die(_("editing patch failed"));
 
 	if (stat(file, &st))
-		die_errno(_("Could not stat '%s'"), file);
+		die_errno(_("could not stat '%s'"), file);
 	if (!st.st_size)
-		die(_("Empty patch. Aborted."));
+		die(_("empty patch. aborted"));
 
 	child.git_cmd = 1;
 	strvec_pushl(&child.args, "apply", "--recount", "--cached", file,
 		     NULL);
 	if (run_command(&child))
-		die(_("Could not apply '%s'"), file);
+		die(_("could not apply '%s'"), file);
 
 	unlink(file);
 	free(file);
@@ -568,7 +568,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 finish:
 	if (write_locked_index(&the_index, &lock_file,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-		die(_("Unable to write new index file"));
+		die(_("unable to write new index file"));
 
 	dir_clear(&dir);
 	clear_pathspec(&pathspec);
-- 
2.36.1.windows.1

