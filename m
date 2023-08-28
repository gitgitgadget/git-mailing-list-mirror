Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D39EC83F17
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 13:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjH1NxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 09:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjH1Nwe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 09:52:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068FBBA
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 06:52:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31dcd553fecso624936f8f.2
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693230750; x=1693835550;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htJOzMSrygmxl2J+Ne8ipkhQPCgbWi+D8lekxfgQSDc=;
        b=XHlN4Ts6lFgTglEt1SDyW+cqUwaJE0EITaDLBt9Diu5Ew7dsmdQxpohXaAlwoycaDv
         0k2PfoaWCYDG2FXIhtU98SGc12hyaGIiU00izXPf34cEORQbhcxHmaC70clIZnzJKc0b
         9PtVAtfgbdSzTTdAbtvWnRcZoclXpnjgqMrdThBli32FEWPOQNIqZ5bQWIN65paDZqBS
         q4oiAeIzXvYT5e+BV449udD3iecpNaNoR5W9PCTtwbjInESMzYqw6TSZwIwzBbspl78K
         4ImTXXyPXaNmCZPgI8aJJ5dvgOq0NZB5+gWU91jiSROBGPe6TDmj8RVuc1YLGISgnnop
         7DCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693230750; x=1693835550;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htJOzMSrygmxl2J+Ne8ipkhQPCgbWi+D8lekxfgQSDc=;
        b=QJXGGgFFF6bJ+uVmKdtQgw+ReW5SMdK9RZXBOL9o+PvCgJjDPLcrN6mGJ5l/BbjT02
         rpa1bBvYzCJpEtUyG7W3WCTwd5W+xziSaSt7E8gXacO+Bq2Er++ELkpldgA9wlgYrozn
         xdnARZai+m7I09oMSz7U8seqz20r/LeIZKZONvZsuBh/a+0E5TDTHaM8ZQ67uFpEXfQx
         cOODpTGShNXcjBztMGNsRoHZ6gLhGXd2MJaiEsuAIuDhSwb9FLl9x0Lq7c0KJx1fLZOT
         LchVFoAy0jG14eJHSoQFcF+uVuQ6v3A/Bi2OqdKJC/TTshX3oAY4Ce2O7MCYaWGr/vu+
         BKYg==
X-Gm-Message-State: AOJu0YzDwgNYMKuJ9a3ckf9MCb1WcRtlu/yvOoU7fFZP7DnCf0E0fkDs
        SA/MW6xZs2Tn1Rk4OQafxUeeYH2QP/Y=
X-Google-Smtp-Source: AGHT+IGtCtpw0ihHrbGnfoYq5BA++0/uuc+jxQLZTlJOIPmEdVzKXxWD2WlelCtdnvfW7pq3iav8vw==
X-Received: by 2002:a5d:630d:0:b0:31a:c6b2:8c63 with SMTP id i13-20020a5d630d000000b0031ac6b28c63mr17360752wru.21.1693230750181;
        Mon, 28 Aug 2023 06:52:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10-20020adfdb4a000000b0031980294e9fsm10550224wrj.116.2023.08.28.06.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:52:29 -0700 (PDT)
Message-ID: <ac234b157558e6142d0d06f6baf80e1e80f063b5.1693230746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1569.v3.git.1693230746.gitgitgadget@gmail.com>
References: <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
        <pull.1569.v3.git.1693230746.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Aug 2023 13:52:26 +0000
Subject: [PATCH v3 3/3] scalar reconfigure: help users remove buggy repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
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
 scalar.c | 59 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/scalar.c b/scalar.c
index 938bb73f3ce..fb2940c2a00 100644
--- a/scalar.c
+++ b/scalar.c
@@ -664,6 +664,7 @@ static int cmd_reconfigure(int argc, const char **argv)
 	git_config(get_scalar_repos, &scalar_repos);
 
 	for (i = 0; i < scalar_repos.nr; i++) {
+		int succeeded = 0;
 		const char *dir = scalar_repos.items[i].string;
 
 		strbuf_reset(&commondir);
@@ -674,30 +675,56 @@ static int cmd_reconfigure(int argc, const char **argv)
 
 			if (errno != ENOENT) {
 				warning_errno(_("could not switch to '%s'"), dir);
-				res = -1;
-				continue;
+				goto loop_end;
 			}
 
 			strbuf_addstr(&buf, dir);
 			if (remove_deleted_enlistment(&buf))
-				res = error(_("could not remove stale "
-					      "scalar.repo '%s'"), dir);
-			else
-				warning(_("removing stale scalar.repo '%s'"),
+				error(_("could not remove stale "
+					"scalar.repo '%s'"), dir);
+			else {
+				warning(_("removed stale scalar.repo '%s'"),
 					dir);
+				succeeded = 1;
+			}
 			strbuf_release(&buf);
-		} else if (discover_git_directory(&commondir, &gitdir) < 0) {
-			warning_errno(_("git repository gone in '%s'"), dir);
-			res = -1;
-		} else {
-			git_config_clear();
+			goto loop_end;
+		}
+
+		switch (discover_git_directory_reason(&commondir, &gitdir)) {
+		case GIT_DIR_INVALID_OWNERSHIP:
+			warning(_("repository at '%s' has different owner"), dir);
+			goto loop_end;
+
+		case GIT_DIR_INVALID_GITFILE:
+		case GIT_DIR_INVALID_FORMAT:
+			warning(_("repository at '%s' has a format issue"), dir);
+			goto loop_end;
+
+		case GIT_DIR_DISCOVERED:
+			succeeded = 1;
+			break;
+
+		default:
+			warning(_("repository not found in '%s'"), dir);
+			break;
+		}
 
-			the_repository = &r;
-			r.commondir = commondir.buf;
-			r.gitdir = gitdir.buf;
+		git_config_clear();
 
-			if (set_recommended_config(1) < 0)
-				res = -1;
+		the_repository = &r;
+		r.commondir = commondir.buf;
+		r.gitdir = gitdir.buf;
+
+		if (set_recommended_config(1) >= 0)
+			succeeded = 1;
+
+loop_end:
+		if (!succeeded) {
+			res = -1;
+			warning(_("to unregister this repository from Scalar, run\n"
+				  "\tgit config --global --unset --fixed-value scalar.repo \"%s\""),
+				dir);
 		}
 	}
 
-- 
gitgitgadget
