Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D765BC433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B722F20724
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E50T0OKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389348AbgF3PQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389334AbgF3PQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:16:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353DEC03E979
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:16:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 22so19190895wmg.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUA0POsVVJ22ojoGFsyScNlZG8/SiQ8wYyZG/EocrrU=;
        b=E50T0OKzVHViX2vsuv7pSBGs0xkUFQMq3Ry4AXkGAmRUy4ULNph4eFYPTLpMI1hXQS
         Lj5RJ+pVCs2EnN5tlpmDCR0VI5W8D+DAOAP+X8sgoGdmLf0ZZwuTMNUGS3QilyG2eFPL
         QUp4B2HUPKOcvtrLKERSy5m37F9Tm0mHlx/CSSGzVgCY+u2FvF65g0Td6C+y5T2kAbyU
         y6NLjiO6ApNSe/rXKo8pkzwNicfw1tFeDP9iakhwH4r/ygvbYpnpLoCaxvpy1oCc/BdF
         hdhLWL/flzu4WqnVY6r3zEXIBx21hALPH8dtf9bbCsRVYLz54Lf9ZxqFAz8ifwEy7nFQ
         YQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUA0POsVVJ22ojoGFsyScNlZG8/SiQ8wYyZG/EocrrU=;
        b=YSCZ+H4uLuZ5wMs9ejYpi+mhLhzA9pAtfu0iYuhsDMSsuv6lRg8CNvLgbFNDKELQ3K
         cpORIWzQGk7++FlaodDBG9UgJzab3zy/ULQt133CzvGxTyUK3wbOdloyhubxRVjkhfzY
         c1TN0CA8fImQFI4ow29tponzvJP7mfhlxd1OqnF/bGrxo7e5k+1qINYRa+HG7HreTEdM
         12moJFrEytVIunskXMEX2OiqHn2CMHAMVo0IOZTTkw+r6s3DMunCbSTjo194HcXTz1eV
         rVYRvfXK0cSLJKXAz1v0rYo7YhkVmalAwHnEnoM1sLhJLY4qA9T/RH4vhHFKTPBPIy5/
         DBAA==
X-Gm-Message-State: AOAM532S5NTd7frbaN5rIW6d1hyOdxEyZ/XY6+UFdrQx4saTBBYSUMyw
        6KiIe+vInbw12pY8ROZBEEpY5C7P
X-Google-Smtp-Source: ABdhPJx5dx7x8jImpjwMqs7O/2vg0//s0TmbfRGBMjyI25NnDXO/dUid3Eteil0TWht5DGvj1EsaaQ==
X-Received: by 2002:a1c:7413:: with SMTP id p19mr21689743wmc.60.1593530187625;
        Tue, 30 Jun 2020 08:16:27 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-323-12.w86-199.abo.wanadoo.fr. [86.199.210.12])
        by smtp.googlemail.com with ESMTPSA id 63sm4263911wra.86.2020.06.30.08.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:16:27 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 3/6] stash: remove the second index in stash_patch()
Date:   Tue, 30 Jun 2020 17:15:55 +0200
Message-Id: <20200630151558.20975-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630151558.20975-1-alban.gruin@gmail.com>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
 <20200630151558.20975-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes the second index used in stash_patch().

This function starts by resetting the index (which is set at `i_tree')
to HEAD, which has been stored in `b_commit' by do_create_stash(), and
the call to `read-tree' is replaced by reset_tree().  The index is
discarded after run_add_interactive(), but not `diff-tree' as this
command should not change it.

Since the index has been changed, and subsequent code might be sensitive
to this, it is reset to `i_tree' at the end of the function.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/stash.c | 47 ++++++++++-------------------------------------
 1 file changed, 10 insertions(+), 37 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 2535335275..eaeb7bc8c4 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -995,51 +995,24 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 		       struct strbuf *out_patch, int quiet)
 {
 	int ret = 0;
-	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
 	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
-	struct index_state istate = { NULL };
-	char *old_index_env = NULL, *old_repo_index_file;
 
-	remove_path(stash_index_path.buf);
-
-	cp_read_tree.git_cmd = 1;
-	argv_array_pushl(&cp_read_tree.args, "read-tree", "HEAD", NULL);
-	argv_array_pushf(&cp_read_tree.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
-	if (run_command(&cp_read_tree)) {
-		ret = -1;
-		goto done;
-	}
+	if (reset_tree(&info->b_commit, 0, 1))
+		return -1;
 
 	/* Find out what the user wants. */
-	old_repo_index_file = the_repository->index_file;
-	the_repository->index_file = stash_index_path.buf;
-	old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
-	setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
-
 	ret = run_add_interactive(NULL, "--patch=stash", ps);
 
-	the_repository->index_file = old_repo_index_file;
-	if (old_index_env && *old_index_env)
-		setenv(INDEX_ENVIRONMENT, old_index_env, 1);
-	else
-		unsetenv(INDEX_ENVIRONMENT);
-	FREE_AND_NULL(old_index_env);
-
 	/* State of the working tree. */
-	if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
-				NULL)) {
-		ret = -1;
-		goto done;
-	}
+	discard_cache();
+	if (write_cache_as_tree(&info->w_tree, 0, NULL))
+		return -1;
 
 	cp_diff_tree.git_cmd = 1;
 	argv_array_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
 			 oid_to_hex(&info->w_tree), "--", NULL);
-	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
-		ret = -1;
-		goto done;
-	}
+	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0))
+		return -1;
 
 	if (!out_patch->len) {
 		if (!quiet)
@@ -1047,9 +1020,9 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 		ret = 1;
 	}
 
-done:
-	discard_index(&istate);
-	remove_path(stash_index_path.buf);
+	if (reset_tree(&info->i_tree, 0, 1))
+		return -1;
+
 	return ret;
 }
 
-- 
2.20.1

