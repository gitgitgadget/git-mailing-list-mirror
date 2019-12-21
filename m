Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CFAC2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADC7206EC
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKtXiGDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfLUV52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 16:57:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33579 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfLUV5W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 16:57:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so12024243edq.0
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 13:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=29+HNaPjh/ujoDPjCFFrHwStMkfYBo9x+NVi95MwpCE=;
        b=kKtXiGDE0CRBHRsKCzqSQuBH55QQC7mr4BsoLg6MXtuniz6mCY0yGwHrwU9JO1STXB
         HAdOZszJo2qVUr/bWml05jHEpdcl47NSRrJr2Qre6CQ8yaJjuzPgd3qJxBmOX1S+2/YT
         5rkei6dpt3wfzf4/eJ6q4tQBIjivMnJuzf7U06IXWNhLLkHmU/BTmUl2NABRZplPDxmb
         ohS6ToXnr08MuRaWgtBW2/qKcyK2h1WHCKtxErB3CDf/omUgCppFuL3p+3wViWo4i6Hm
         b6mMW4mwIBYrr7TnNS53cD/DqyYfOX3gwqTeIf7SIbwMF1Trbl8rYJFxnQZYo6Rh+t+4
         fTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=29+HNaPjh/ujoDPjCFFrHwStMkfYBo9x+NVi95MwpCE=;
        b=Iw6BGt1hIZweX5JhairRqgpNwkfrF6DW+mqfakpAHzHWltG0IdP4mK1MeatiYoBFsx
         LjEe91bbXUEMk9pbd3TY7AUrPVQEQUy2JAfBQQv5PW7MG7X4eo+8DEuVOVx40BKYZKi7
         QtDfo79L7B4DGDJuP0XXnsKktFZ4YRoUfy1jjYM0AhDBpSe7apZBqeV1GYs1Yec4K761
         eM41v9lnNuXococwRotMikme05FYgq7s7/wxVg0UKmgseRC/505Qtm6Y0ulPtDiZmG5b
         bKnVkqWQ2h8SU5TP3biCTPozdePayCHs45lWBeTWI/to51tjNDsnmplxdo93yRhpGee2
         BC1Q==
X-Gm-Message-State: APjAAAVcMXp8SDRP3cf3aFT/3tc7HYq+a3aXzi2ANmF7PIF8dR+fnN71
        6PEs3uZiHfXjmf8/dWx5G27QnbDw
X-Google-Smtp-Source: APXvYqz/dGMqfcR+kec2FNoGjHuxaVAY1biMpWWd1QysrVAEOfnawe3ON1fKYqso5tyyTH1ItWiGHg==
X-Received: by 2002:a17:906:4556:: with SMTP id s22mr23205974ejq.165.1576965440912;
        Sat, 21 Dec 2019 13:57:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm1534389edx.35.2019.12.21.13.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 13:57:20 -0800 (PST)
Message-Id: <5051f37559f88fc9b75391db37f19653498de65a.1576965436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.174.v2.git.1576965436.gitgitgadget@gmail.com>
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
        <pull.174.v2.git.1576965436.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 21:57:13 +0000
Subject: [PATCH v2 4/7] built-in stash: use the built-in `git add -p` if so
 configured
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The scripted version of `git stash` called directly into the Perl script
`git-add--interactive.perl`, and this was faithfully converted to C.

However, we have a much better way to do this now: call the internal API
directly, which will now incidentally also respect the
`add.interactive.useBuiltin` setting. Let's just do this.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/stash.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 4e806176b0..2dafd97766 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -999,9 +999,9 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 {
 	int ret = 0;
 	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
-	struct child_process cp_add_i = CHILD_PROCESS_INIT;
 	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
 	struct index_state istate = { NULL };
+	char *old_index_env = NULL, *old_repo_index_file;
 
 	remove_path(stash_index_path.buf);
 
@@ -1015,16 +1015,19 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 	}
 
 	/* Find out what the user wants. */
-	cp_add_i.git_cmd = 1;
-	argv_array_pushl(&cp_add_i.args, "add--interactive", "--patch=stash",
-			 "--", NULL);
-	add_pathspecs(&cp_add_i.args, ps);
-	argv_array_pushf(&cp_add_i.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
-	if (run_command(&cp_add_i)) {
-		ret = -1;
-		goto done;
-	}
+	old_repo_index_file = the_repository->index_file;
+	the_repository->index_file = stash_index_path.buf;
+	old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
+	setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
+
+	ret = run_add_interactive(NULL, "--patch=stash", ps);
+
+	the_repository->index_file = old_repo_index_file;
+	if (old_index_env && *old_index_env)
+		setenv(INDEX_ENVIRONMENT, old_index_env, 1);
+	else
+		unsetenv(INDEX_ENVIRONMENT);
+	FREE_AND_NULL(old_index_env);
 
 	/* State of the working tree. */
 	if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
-- 
gitgitgadget

