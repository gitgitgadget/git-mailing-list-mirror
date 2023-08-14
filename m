Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32196C04FE1
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 15:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjHNPMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 11:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjHNPM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 11:12:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883D51708
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 08:12:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-317716a4622so3922925f8f.1
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692025941; x=1692630741;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51dI2tivwgeKa9JyBbrBM77QQNcKKmUn35cLx5RYQ38=;
        b=guyuck2Ow/lEJHrC3HxDW2z1psqm4lbFSrzq5xi7Ajo63hDUHh92uf4uz9ofr8UwS5
         VkdS3/TgJDZZP3j72TwTwu6L+NIhZ9crXOqxrpGq1QWttV8wcoS9hLubZ1v/GyuMjGsG
         Za8G70JJUCb3BOIfzvIAIWZqrXpfQ7qZEwmZNZJJ4GXcSuaDly6D6BOuklfVfq1JEWNR
         oHuJvk6dTRpm0rcayQc0WdWDo+3WWn/6cUgUbU8ompj/zLiv+3mBqABa1HoIXwKtOO8O
         u0tNkrPSYHP1zdLN/SYY1Dk3C8Rjf2pY71qrNJo6JSb3+sWBSGsp/g8kLpDqrcwfv4IM
         PiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025941; x=1692630741;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51dI2tivwgeKa9JyBbrBM77QQNcKKmUn35cLx5RYQ38=;
        b=fj2H2UsreTMgMRg5NaS8hIU3bk3/XXb/4YtFiqhLEsv9OcgffETBGXJ98uyKjRD+8Z
         rP+mvodH7thQ1spl75Q3PqwRjavQlPRk0MoOgBJQtKg+rR1NQDKvKqdla9WQQ00YdAv4
         pIYH6z6BgXkqOEmwFkpAjIXwkoGHPdkUygOyjHrB4edwZpLZT+RaRHX0TBb5fdJ+Hzu+
         xhhKW6RRQJCIPa0EbbqVQxSbFKP0dbyhk19RR5t3ASG0qiHCz7SjYerCJAeQ33NzwZHl
         LqG0HBZojRfkzHJuviqDmvqQUH7MK0+VmrC+idnueRtT7UMlJA326+FmwSBc+dPW0JSN
         V4Lg==
X-Gm-Message-State: AOJu0YyXSTik1nSuBirX7+LAUKpnPThJK9f82fCbYLtA7bCClzwX//W1
        4QYnaLDQUa+h+O14X6KyjBhBdfgKzHU=
X-Google-Smtp-Source: AGHT+IGpjlW9QxsSRLYcybNCnR9lTDSjpzffMxgQyFsFKwB4TsCkzTyX7xasahG4H0HISa21sZkd4A==
X-Received: by 2002:a5d:420e:0:b0:313:e48a:d173 with SMTP id n14-20020a5d420e000000b00313e48ad173mr7681031wrq.68.1692025940777;
        Mon, 14 Aug 2023 08:12:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d444d000000b00317f29ad113sm14611425wrr.32.2023.08.14.08.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:12:20 -0700 (PDT)
Message-ID: <907410f76c4a5d7ef325545f52696a9a0c00b6b3.1692025937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Aug 2023 15:12:17 +0000
Subject: [PATCH 3/3] scalar reconfigure: help users remove buggy repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When running 'scalar reconfigure -a', Scalar has warning messages about
the repository missing (or not containing a .git directory). Failures
can also happen while trying to modify the repository-local config for
that repository.

These warnings may seem confusing to users who don't understand what
they mean or how to stop them.

Add a warning that instructs the user how to remove the warning in
future installations.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 scalar.c | 56 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/scalar.c b/scalar.c
index 938bb73f3ce..7d87d7ea724 100644
--- a/scalar.c
+++ b/scalar.c
@@ -664,6 +664,7 @@ static int cmd_reconfigure(int argc, const char **argv)
 	git_config(get_scalar_repos, &scalar_repos);
 
 	for (i = 0; i < scalar_repos.nr; i++) {
+		int failed = 0;
 		const char *dir = scalar_repos.items[i].string;
 
 		strbuf_reset(&commondir);
@@ -674,30 +675,51 @@ static int cmd_reconfigure(int argc, const char **argv)
 
 			if (errno != ENOENT) {
 				warning_errno(_("could not switch to '%s'"), dir);
-				res = -1;
-				continue;
+				failed = -1;
+				goto loop_end;
 			}
 
 			strbuf_addstr(&buf, dir);
 			if (remove_deleted_enlistment(&buf))
-				res = error(_("could not remove stale "
-					      "scalar.repo '%s'"), dir);
+				failed = error(_("could not remove stale "
+						 "scalar.repo '%s'"), dir);
 			else
-				warning(_("removing stale scalar.repo '%s'"),
+				warning(_("removed stale scalar.repo '%s'"),
 					dir);
 			strbuf_release(&buf);
-		} else if (discover_git_directory(&commondir, &gitdir) < 0) {
-			warning_errno(_("git repository gone in '%s'"), dir);
-			res = -1;
-		} else {
-			git_config_clear();
-
-			the_repository = &r;
-			r.commondir = commondir.buf;
-			r.gitdir = gitdir.buf;
-
-			if (set_recommended_config(1) < 0)
-				res = -1;
+			goto loop_end;
+		}
+
+		switch (discover_git_directory_reason(&commondir, &gitdir)) {
+		case GIT_DIR_INVALID_OWNERSHIP:
+			warning(_("repository at '%s' has different owner"), dir);
+			failed = -1;
+			goto loop_end;
+
+		case GIT_DIR_DISCOVERED:
+			break;
+
+		default:
+			warning(_("repository not found in '%s'"), dir);
+			failed = -1;
+			break;
+		}
+
+		git_config_clear();
+
+		the_repository = &r;
+		r.commondir = commondir.buf;
+		r.gitdir = gitdir.buf;
+
+		if (set_recommended_config(1) < 0)
+			failed = -1;
+
+loop_end:
+		if (failed) {
+			res = failed;
+			warning(_("to unregister this repository from Scalar, run\n"
+				  "\tgit config --global --unset --fixed-value scalar.repo \"%s\""),
+				dir);
 		}
 	}
 
-- 
gitgitgadget
