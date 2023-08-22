Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9FCEE4993
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 17:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjHVRY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 13:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHVRYW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 13:24:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3650E40CDC
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 10:24:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c65820134so489018f8f.1
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 10:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692725059; x=1693329859;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh8x/243SFjyLmfjm42zZ/YZuS44+CL/FE4Wh8Zt+CI=;
        b=k6sJaUb9c0LlNt8yrghNDbjIA7kT2WyJT7FgHqWE97WA+R/AajvccIREcpwbJLiXz5
         Wlnm78ERpNDI8LXI+vGFKXKurW5JPVFRZsO8MrCZSOKiYDhqXDXYLjDbtBm7IBU7mQVz
         s4MoIGD4nd/RjpqZ6t11fZ+//EEPNkibGjwhAMRgMAizDsZPWOp3Jm45Sg+dakIveUfl
         XtXKzJNxwmpc/AnBBkUt1SbobBgemYOL/vC0iWIe2lfFkGdeQku9UrEq9/fz9XiLa7pC
         CU2Tl55yVRShqVJp1s+0rgd05ilaD8itzqYEoW8XphmUPU2EAOZwNfXT2Trw5i2B7qOP
         jYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692725059; x=1693329859;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zh8x/243SFjyLmfjm42zZ/YZuS44+CL/FE4Wh8Zt+CI=;
        b=Xa+gBkNrTUeKnJQKfctQOaxtg06liyZ11ex93wfM5t0V0L27urDuKAeyZx9HX+C+fo
         Nh884EuYPL4LqGU6sVBiIZQDStqcSUTZyNMjFvREYXVvhdOwPwt4qQdgX20tw4tubhLu
         1XvARFoXFQUy/cdvv1MkWGDmihdog0W0pM0WZO7uYO3rxEl5lgy8UJi4ee5w0JxCPVHR
         CVOsnfLL6qf7p8npSqgxyQgHeXD1QKntScMqXfmDSoCdlvSG8LasinZXQNiG1k0IrAcZ
         1uJ34IOTquWMxe+ge0XzGvz6X+5sLHMRPLGzQGHgGs4qF1uED/dw2R+fFlERv8W4wvZG
         vphA==
X-Gm-Message-State: AOJu0YyLiYpqW9UqI5F7C+U1X1BuKn7vkTpuk80UghNK0W5QCSvgKzKa
        R67QyLMWx4/YTXpjLriYBSX97GdkORI=
X-Google-Smtp-Source: AGHT+IGq17w94AK+1/+hovgvoLDliC0DSaxfRMiKYtxpw+GjoyEXU1nBKpLqYv+iHMnMjT3Kr3PYrw==
X-Received: by 2002:a5d:58cd:0:b0:318:7bb:e9af with SMTP id o13-20020a5d58cd000000b0031807bbe9afmr7228599wrf.55.1692725059261;
        Tue, 22 Aug 2023 10:24:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020adfe790000000b003188358e08esm16346558wrm.42.2023.08.22.10.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 10:24:18 -0700 (PDT)
Message-ID: <7ac7311863d2e05c3dc8e26cb821fe8a7c4b6804.1692725056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
        <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Aug 2023 17:24:15 +0000
Subject: [PATCH v2 3/3] scalar reconfigure: help users remove buggy repos
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
 scalar.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/scalar.c b/scalar.c
index 02a38e845e1..54df0fdbb9f 100644
--- a/scalar.c
+++ b/scalar.c
@@ -664,6 +664,7 @@ static int cmd_reconfigure(int argc, const char **argv)
 	git_config(get_scalar_repos, &scalar_repos);
 
 	for (i = 0; i < scalar_repos.nr; i++) {
+		int succeeded = 0;
 		const char *dir = scalar_repos.items[i].string;
 
 		strbuf_reset(&commondir);
@@ -674,27 +675,51 @@ static int cmd_reconfigure(int argc, const char **argv)
 
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
+		case GIT_DIR_DISCOVERED:
+			succeeded = 1;
+			break;
+
+		default:
+			warning(_("repository not found in '%s'"), dir);
+			break;
+		}
+
+		git_config_clear();
+
+		the_repository = &r;
+		r.commondir = commondir.buf;
+		r.gitdir = gitdir.buf;
 
-			the_repository = &r;
-			r.commondir = commondir.buf;
-			r.gitdir = gitdir.buf;
+		if (set_recommended_config(1) >= 0)
+			succeeded = 1;
 
-			if (set_recommended_config(1) < 0)
-				res = -1;
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
