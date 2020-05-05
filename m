Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED326C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 10:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC9D20658
	for <git@archiver.kernel.org>; Tue,  5 May 2020 10:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2hiJzLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgEEKxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 06:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728726AbgEEKxe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 06:53:34 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8E0C061A10
        for <git@vger.kernel.org>; Tue,  5 May 2020 03:53:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 188so1773722wmc.2
        for <git@vger.kernel.org>; Tue, 05 May 2020 03:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fSN7mYoft9OAeOp4Ef6yNbBYnwPx3kW783N6g+E/bKM=;
        b=W2hiJzLr8HyBvsFLGdcN8fDgMhRx0MeGc38sL+arJ2Ka53vTaNX44yxevA4b/trC1I
         wMUx+p2/h1Ale/apn7FOibXRcu1H2VMOtQeVoVfw8kHd9kg6qkmZOqBpPv0VBB8yZFJf
         LTVDeahPz3xd9J4s9vOktUk4SYETPSRERsJ1z5rQBCAeoGaQ1T6G/5WesOWba6WnoEve
         Ad7H0u66sXI1S0Wstx7KaPnFLnuHOojOALYvOAl51gqsC7RVixmaeCaJrkuMwnVU1Gjh
         jmIKZZmeH2VT/mrP754nVOOhPADb+1rQloJBHXhtY6/RoCxr9zoYnzsZ3N1p9NZKn4vs
         wsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fSN7mYoft9OAeOp4Ef6yNbBYnwPx3kW783N6g+E/bKM=;
        b=bDigFVJS6B65GPxusoTA5d3k1YzncPg5mA3uyMFyvstE2mJSMtTTfQv0iCh5BaTT3C
         t+q1a4EEReoyjWvnXK5717KphyBpFBZRZQU3hUdgi/SJqMzlj7X+JW+BE1/PTvgq6gib
         TX1jZ8iq28qxkjU6GnPdFf070uU2KZs3rVbq9njwPq4VVV1Wm30LEzOYoGAXf7AXlGbk
         4zuyrdf4PtAN4jP+nyJYlXR+nFpYB1/U8BZNd1Q2A3z16g5V3sLu1WLZb0RXpKX9RnyD
         rDIVZmHIkRldzz6dywVoi8bNWZN/AWeYa3RGR4r1uJFdJaSLYvdI6QcrBzY9BpZBhiSQ
         4NYA==
X-Gm-Message-State: AGi0PuZRDDmqoT6OGOix2kJCYAo90Kg4zVwK2yc2xMxfeeI6y1hwAeOT
        WPPWcn67Uv7Uuk2QBeafXWiY5TW5
X-Google-Smtp-Source: APiQypIEmXFMpkVwybP8ZXvj4L69jise7VPHO4by0GWAu64IlX+XyFT4za5GSKQFpBRCPOqo0uAcBA==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr2773329wmc.59.1588676011977;
        Tue, 05 May 2020 03:53:31 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-654-1-289-61.w86-199.abo.wanadoo.fr. [86.199.72.61])
        by smtp.googlemail.com with ESMTPSA id b85sm3170326wmb.21.2020.05.05.03.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 03:53:31 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 2/6] stash: remove the second index in stash_working_tree()
Date:   Tue,  5 May 2020 12:48:45 +0200
Message-Id: <20200505104849.13602-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505104849.13602-1-alban.gruin@gmail.com>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes the second index used in stash_working_tree() to simplify
the code.  It also help to avoid issues with the split-index: when
stash_working_tree() is called, the index is at `i_tree', and this tree
is extracted in a second index for use in a subcommand.  This is not a
problem in the non-split-index case, but in the split-index case, if the
shared index file has expired and is removed by a subcommand, the main
index contains a reference to a file that no longer exists.

The calls to set_alternative_index_output() are dropped to extract
`i_tree' to the main index, and `GIT_INDEX_FILE' is no longer set before
starting `update-index'.  When it exits, the index has changed, and must
be discarded.

The call to reset_tree() becomes useless: the only caller of
stash_working_tree() is do_create_stash(), which creates `i_tree' from
its index, calls save_untracked_files() if requested (but as it also
works on a second index, it is unaffected), then calls
stash_working_tree().  But when save_untracked_files() will be modified
to stop using another index, it won't reset the tree, because
stash_patch() wants to work on a different tree (`b_tree') than
stash_working_tree().

At the end of the function, the tree is reset to `i_tree'.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/stash.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 9baa8b379e..2535335275 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1059,17 +1059,14 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	struct rev_info rev;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
 	struct strbuf diff_output = STRBUF_INIT;
-	struct index_state istate = { NULL };
 
 	init_revisions(&rev, NULL);
 	copy_pathspec(&rev.prune_data, ps);
 
-	set_alternate_index_output(stash_index_path.buf);
 	if (reset_tree(&info->i_tree, 0, 0)) {
 		ret = -1;
 		goto done;
 	}
-	set_alternate_index_output(NULL);
 
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = add_diff_to_buf;
@@ -1091,8 +1088,6 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	argv_array_pushl(&cp_upd_index.args, "update-index",
 			 "--ignore-skip-worktree-entries",
 			 "-z", "--add", "--remove", "--stdin", NULL);
-	argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
 
 	if (pipe_command(&cp_upd_index, diff_output.buf, diff_output.len,
 			 NULL, 0, NULL, 0)) {
@@ -1100,19 +1095,16 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 		goto done;
 	}
 
-	if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
-				NULL)) {
+	discard_cache();
+	if (write_cache_as_tree(&info->w_tree, 0, NULL) ||
+	    reset_tree(&info->i_tree, 0, 1))
 		ret = -1;
-		goto done;
-	}
 
 done:
-	discard_index(&istate);
 	UNLEAK(rev);
 	object_array_clear(&rev.pending);
 	clear_pathspec(&rev.prune_data);
 	strbuf_release(&diff_output);
-	remove_path(stash_index_path.buf);
 	return ret;
 }
 
-- 
2.26.2

