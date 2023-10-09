Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C99E95A8F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 01:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344862AbjJIBRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 21:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJIBRS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 21:17:18 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28688F
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 18:17:17 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59c215f2f4aso48960767b3.1
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 18:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696814237; x=1697419037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xR218/AEDXmoIw40ifqi2PJW9fKFVTdPXF/U+trTOOs=;
        b=ab3V786SVNBflgahcy4q/J+vXI8go3o+TFZcBuokNjMb/rq16oUt5Cdp3cU4b+hx8e
         zEjPlPfGLuPb75rfwh71Pu2mo6bs0vZPHgWT0HplbTDGxYjud4lAQWSOeBRKicZGI7CU
         57paGGe7ROHaUNVeO0xYbOZpLKc0eCiQmKDlUVAFMGhxSwm3sGn3UDw+taW9q1VFwSTK
         SAhHi8bDoigVsHuMauA3doWp7dnCur7Bu162DcKj9loPg8Nn+U+aXKxu/Go6dulnbdeq
         rOu0uvOZqLt59PohnA9NQzDiVKYVlCP5Fhu7Jez/iBVwNnw2p5Vs40EZzi11aXz7wLkI
         Ao1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696814237; x=1697419037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xR218/AEDXmoIw40ifqi2PJW9fKFVTdPXF/U+trTOOs=;
        b=UeICVZjNjxXlsPdcZZdOZ8bYTvue0vfOslCwZzbf3LhYtibThyfAcTnrOF3PaIQQS1
         kzKtvgOAmRg8N1jafQekW3mDguwHhkCdw9DkgNU+95w3Xgo6By85yINdHGs0RESIKytP
         iUKYIeu9Fh6oHfZlotzTTYc0fYEiYn4/eR9iiEtLcX77/KXtVc7hz2MB9DH3pMZA5nEJ
         zPp0rPBDC/xdpu7hbDWjxxft+Gfxg06+9xN0JJY4XQvPkxaPZA5sh51tRb/SKYbrcQRt
         blTIHl5rAUC/C7h6tcnd4AA+ZabK+XAjpl2FFFZpIaRj5pQAC/jpM5Z3pqegsnuECg3f
         fycw==
X-Gm-Message-State: AOJu0YwRU0TMK6Nyrjg/asA7EvKorWHL+Xo5StD2oAzJdp4eopNa+LMb
        nHJiR+ZVMx9De4FwwsUTqEKsEUXQCIctQRQ=
X-Google-Smtp-Source: AGHT+IEAHhbFG3M98/dq4focf8ebWx31mG+/MZWjx9CANQxoY4YwT83E/YhYOFMlvklsONa998nh4Q==
X-Received: by 2002:a81:9106:0:b0:59b:e666:1fb4 with SMTP id i6-20020a819106000000b0059be6661fb4mr14922484ywg.9.1696814236700;
        Sun, 08 Oct 2023 18:17:16 -0700 (PDT)
Received: from localhost.localdomain ([102.89.32.84])
        by smtp.gmail.com with ESMTPSA id q65-20020a0de744000000b0059bdac3fd08sm3292338ywe.48.2023.10.08.18.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 18:17:16 -0700 (PDT)
From:   Naomi Ibe <naomi.ibeh69@gmail.com>
To:     git@vger.kernel.org
Cc:     Naomi <naomi.ibeh69@gmail.com>
Subject: [PATCH 1/1] [OUTREACHY] Fixed add.c file to conform to guidelines when using die() listed in issue #635
Date:   Mon,  9 Oct 2023 02:16:51 +0100
Message-Id: <20231009011652.1791-1-naomi.ibeh69@gmail.com>
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

