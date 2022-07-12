Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E356C43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 13:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiGLNIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiGLNHo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 09:07:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB9AB4BF4
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a5so11085535wrx.12
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2KVJeDGWag5MCo4N9w8Xpl9YBSFpoYksJacS7Qs+Frw=;
        b=fyOWwtiX+kHFAlmQEIwXsAZggPDKQpUo83hrWmivlk49tKEFbxW/B6woax6/QrCQjR
         LpBXr/RlUOPLyKeJ5COSjmNJdh57Xvp47c+fMhjbKGOa1I5P+GtM8NkyCr03jdlx/p2p
         3ttGcF2wbQsi+Jw1f7jvFo6d1YzIRlncO3x4MCdN3//Ro50STsnqNcMg+C/1FsL0j9u4
         aTGhFAC04D1OJYw6xDlUfjpkZRGvE+lXUkEdBFKiNaFG348xYCRAgQYJlaJX32kQSv0c
         yxJuGUNCtLFr3SQNlKqwhavnghTnuGEhCVh+izUAzy09uBNWJ6yWRucGui1U2AsD5u72
         tiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2KVJeDGWag5MCo4N9w8Xpl9YBSFpoYksJacS7Qs+Frw=;
        b=D3cRGk06O5Tdg4SZyYyYga2cJPiSvN6/YW25wZ9FYcahuIpLwmIks0HgHYm9OeU0Lr
         nE1qCGukfUrVdE0Jw9tSmGSd4UFCwmrexW0WvB+faxorimmPuEA4ENzfI8uJ5yOjrtr+
         G5ngT0E2ZikqRxIymxqb3S+GGGF8ljvIeSHZkB5HckL+TBnuyT+bh1cwD2NmLGj+NlB5
         9CnCHbaXKIQeDvoDEg/4ySZ9VhRMOSZ6SsaGaPQQMEwpCku8k7f3dpNP4As4GIS7z3h8
         CiBdFvE6XGqr0EiFv1vot1i7BVsDpuVzsuWwcUkG6xrq61rkTLQ/oPpN9T1dn6j4ONmf
         xGIw==
X-Gm-Message-State: AJIora/gG52wMiMB7i9VFD+ye6jvwfGio53ypiylYc+ln+/92HU8U4KD
        da2n2ZFgSI6Vh8LM5ZUe+udCib9oN3E=
X-Google-Smtp-Source: AGRyM1u9qWRh6PhMmBrECagMlqGM7sXaH5HzfkYEe7yQhil+4qZmF62mZFxh2j9PQqhUoA4YKJug5Q==
X-Received: by 2002:a5d:4f02:0:b0:21d:63f6:380c with SMTP id c2-20020a5d4f02000000b0021d63f6380cmr22025295wru.635.1657631246505;
        Tue, 12 Jul 2022 06:07:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6-20020a1c7506000000b003a1a02c6d7bsm12718558wmc.35.2022.07.12.06.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:07:25 -0700 (PDT)
Message-Id: <d5cd4b49e46bc2c186c6e89333360a975700c99a.1657631226.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jul 2022 13:07:05 +0000
Subject: [PATCH v4 12/12] sequencer: notify user of --update-refs activity
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When the user runs 'git rebase -i --update-refs', the end message still
says only

  Successfully rebased and updated <HEAD-ref>.

Update the sequencer to collect the successful (and unsuccessful) ref
updates due to the --update-refs option, so the end message now says

  Successfully rebased and updated <HEAD-ref>.
  Updated the following refs with --update-refs:
	refs/heads/first
	refs/heads/third
  Failed to update the following refs with --update-refs:
	refs/heads/second

To test this output, we need to be very careful to format the expected
error to drop the leading tab characters. Also, we need to be aware that
the verbose output from 'git rebase' is writing progress lines which
don't use traditional newlines but clear the line after every progress
item is complete. When opening the error file in an editor, these lines
are visible, but when looking at the diff in a terminal those lines
disappear because of the characters that delete the previous characters.
Use 'sed' to clear those progress lines and clear the tabs so we can get
an exact match on our expected output.

Reported-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sequencer.c                   | 40 +++++++++++++++++++++++++++++------
 t/t3404-rebase-interactive.sh | 35 +++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 82ef062d497..bdc67c66f3e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4257,17 +4257,20 @@ static int do_update_ref(struct repository *r, const char *refname)
 	return 0;
 }
 
-static int do_update_refs(struct repository *r)
+static int do_update_refs(struct repository *r, int quiet)
 {
 	int res = 0;
 	struct string_list_item *item;
 	struct string_list refs_to_oids = STRING_LIST_INIT_DUP;
 	struct ref_store *refs = get_main_ref_store(r);
+	struct strbuf update_msg = STRBUF_INIT;
+	struct strbuf error_msg = STRBUF_INIT;
 
 	sequencer_get_update_refs_state(r->gitdir, &refs_to_oids);
 
 	for_each_string_list_item(item, &refs_to_oids) {
 		struct update_ref_record *rec = item->util;
+		int loop_res;
 
 		if (oideq(&rec->after, the_hash_algo->null_oid)) {
 			/*
@@ -4277,13 +4280,38 @@ static int do_update_refs(struct repository *r)
 			continue;
 		}
 
-		res |= refs_update_ref(refs, "rewritten during rebase",
-				       item->string,
-				       &rec->after, &rec->before,
-				       0, UPDATE_REFS_MSG_ON_ERR);
+		loop_res = refs_update_ref(refs, "rewritten during rebase",
+					   item->string,
+					   &rec->after, &rec->before,
+					   0, UPDATE_REFS_MSG_ON_ERR);
+		res |= loop_res;
+
+		if (quiet)
+			continue;
+
+		if (loop_res)
+			strbuf_addf(&error_msg, "\t%s\n", item->string);
+		else
+			strbuf_addf(&update_msg, "\t%s\n", item->string);
+	}
+
+	if (!quiet &&
+	    (update_msg.len || error_msg.len)) {
+		fprintf(stderr,
+			_("Updated the following refs with %s:\n%s"),
+			"--update-refs",
+			update_msg.buf);
+
+		if (res)
+			fprintf(stderr,
+				_("Failed to update the following refs with %s:\n%s"),
+				"--update-refs",
+				error_msg.buf);
 	}
 
 	string_list_clear(&refs_to_oids, 1);
+	strbuf_release(&update_msg);
+	strbuf_release(&error_msg);
 	return res;
 }
 
@@ -4804,7 +4832,7 @@ cleanup_head_ref:
 		strbuf_release(&head_ref);
 	}
 
-	do_update_refs(r);
+	do_update_refs(r, opts->quiet);
 
 	/*
 	 * Sequence of picks finished successfully; cleanup by
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4b7b77a4123..ef902b5431f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1836,12 +1836,26 @@ test_expect_success '--update-refs updates refs correctly' '
 	test_commit extra2 fileX &&
 	git commit --amend --fixup=L &&
 
-	git rebase -i --autosquash --update-refs primary &&
+	git rebase -i --autosquash --update-refs primary 2>err &&
 
 	test_cmp_rev HEAD~3 refs/heads/first &&
 	test_cmp_rev HEAD~3 refs/heads/second &&
 	test_cmp_rev HEAD~1 refs/heads/third &&
-	test_cmp_rev HEAD refs/heads/no-conflict-branch
+	test_cmp_rev HEAD refs/heads/no-conflict-branch &&
+
+	cat >expect <<-\EOF &&
+	Successfully rebased and updated refs/heads/update-refs.
+	Updated the following refs with --update-refs:
+		refs/heads/first
+		refs/heads/no-conflict-branch
+		refs/heads/second
+		refs/heads/third
+	EOF
+
+	# Clear "Rebasing (X/Y)" progress lines and drop leading tabs.
+	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
+		<err >err.trimmed &&
+	test_cmp expect err.trimmed
 '
 
 test_expect_success 'respect user edits to update-ref steps' '
@@ -1980,7 +1994,22 @@ test_expect_success '--update-refs: check failed ref update' '
 	git rev-parse third >.git/refs/heads/second &&
 
 	git rebase --continue 2>err &&
-	grep "update_ref failed for ref '\''refs/heads/second'\''" err
+	grep "update_ref failed for ref '\''refs/heads/second'\''" err &&
+
+	cat >expect <<-\EOF &&
+	Updated the following refs with --update-refs:
+		refs/heads/first
+		refs/heads/no-conflict-branch
+		refs/heads/third
+	Failed to update the following refs with --update-refs:
+		refs/heads/second
+	EOF
+
+	# Clear "Rebasing (X/Y)" progress lines and drop leading tabs.
+	tail -n 6 err >err.last &&
+	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
+		<err.last >err.trimmed &&
+	test_cmp expect err.trimmed
 '
 
 # This must be the last test in this file
-- 
gitgitgadget
