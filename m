Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA8EC43381
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4926A20679
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbhAZWCy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbhAZS4s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 13:56:48 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED809C061351
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:56:06 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z3so2645547pfj.3
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TL4jzbNY79Shr0Tw7cj+NJkfnX+3vACo6r4x12NfHR0=;
        b=c6IdOvwBiMcmFHgGOKW92VtrpnUtlhRs3w9aPp5a0XaOIDUzPHG5EjYhBG3HV8HtY9
         8XrV87ryI8jBd+mpgkGzIWvuRBKtBP1lmHjFYRAQLCZPz9dKt1Ru0EZ4Pu2co8zyFMjR
         fJxBvzPTIvZwclKHXhgO0l48FszY7mGz7no2sl6HjWe6UrsPqUwxC9EHBDOMKODoHPee
         PQyQlltlh6Mu0nrCfAPXyAb7SXX3JxJRDJ6rW7kzsFUp5po2H7uTGIOD8FtOfPxBvbHJ
         bPeoSHiuvV4yZuT9SBoHaSQv4FnCYDMbijY78S/n9d4qWvlZkbhPdfFWIT8FCschkWEA
         UzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TL4jzbNY79Shr0Tw7cj+NJkfnX+3vACo6r4x12NfHR0=;
        b=Fu2agtDuN/ROjEDUVi/fH2O4GzJ1xvUCBJNnYvDDdgvxGpbCSuxewUvtgUXQa4f5iH
         XPwfYIlwc/ZVs9M0uUw15sDMZxBxpg6g2oTDfl/RMBVky5r9kym0XErDGWyC5HWoR1wN
         iPjmN4YZA2bKqe6AdW2mlSJXPrC0SmiROkcTrrf+5xaIIMUsH2NAeqD/Yb+cR/wSXsvI
         HpB0iXq5qilJSkkJ/mdaN2ugXoOPltQdtRfLBI6NtgzYfpkKeod+ATz1Z0xX1UGKvQgp
         G5ZC9GUyVWPbI6gzEdXoV0K5xV9StWM0mJSeAvn367L0dFPld/cVgHg9OrwjUreVWZe8
         O+lA==
X-Gm-Message-State: AOAM530NThqw3Wm1X+UMkpaE1E8l4c8u/XV0da9UiJ9xNcE195U2bVKj
        P8KnDIKhqvZC9KgZISXxFbFudIIzoEwd1oW7GWRRNceOr6263PIH82kXQ09MpZNJCPQWe5grAog
        hzpGu+AgjqfyqpmX8iMSKsGDRqGHdVusFqf+9/utV1U0Ow72qCnIJORfCItC8NQNuGR2LSr+8UO
        tN
X-Google-Smtp-Source: ABdhPJxhevXpwQ/OewlDqECw0z5Efu+E7Cll5oCj5Gkb1WEfKxK0/91bZupGUCEQzcZ4afW4UOU0WkD51FX+OjzjsPws
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:1d46:0:b029:1b7:fe6e:4bb4 with
 SMTP id d67-20020a621d460000b02901b7fe6e4bb4mr6561762pfd.4.1611687366335;
 Tue, 26 Jan 2021 10:56:06 -0800 (PST)
Date:   Tue, 26 Jan 2021 10:55:57 -0800
In-Reply-To: <cover.1611686656.git.jonathantanmy@google.com>
Message-Id: <922e8c229c359c15f1265876e6def87d7a18b763.1611686656.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201208013121.677494-1-jonathantanmy@google.com> <cover.1611686656.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v5 3/3] clone: respect remote unborn HEAD
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach Git to use the "unborn" feature introduced in a previous patch as
follows: Git will always send the "unborn" argument if it is supported
by the server. During "git clone", if cloning an empty repository, Git
will use the new information to determine the local branch to create. In
all other cases, Git will ignore it.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/init.txt |  2 +-
 builtin/clone.c               | 16 ++++++++++++++--
 connect.c                     | 28 ++++++++++++++++++++++++++--
 t/t5606-clone-options.sh      |  8 +++++---
 t/t5702-protocol-v2.sh        | 25 +++++++++++++++++++++++++
 transport.h                   |  8 ++++++++
 6 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/init.txt b/Documentation/config/init.txt
index dc77f8c844..79c79d6617 100644
--- a/Documentation/config/init.txt
+++ b/Documentation/config/init.txt
@@ -4,4 +4,4 @@ init.templateDir::
 
 init.defaultBranch::
 	Allows overriding the default branch name e.g. when initializing
-	a new repository or when cloning an empty repository.
+	a new repository.
diff --git a/builtin/clone.c b/builtin/clone.c
index 211d4f54b0..77fdc61f4d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1330,10 +1330,21 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		remote_head = NULL;
 		option_no_checkout = 1;
 		if (!option_bare) {
-			const char *branch = git_default_branch_name();
-			char *ref = xstrfmt("refs/heads/%s", branch);
+			const char *branch;
+			char *ref;
+
+			if (transport_ls_refs_options.unborn_head_target &&
+			    skip_prefix(transport_ls_refs_options.unborn_head_target,
+					"refs/heads/", &branch)) {
+				ref = transport_ls_refs_options.unborn_head_target;
+				transport_ls_refs_options.unborn_head_target = NULL;
+			} else {
+				branch = git_default_branch_name();
+				ref = xstrfmt("refs/heads/%s", branch);
+			}
 
 			install_branch_config(0, branch, remote_name, ref);
+			create_symref("HEAD", ref, "");
 			free(ref);
 		}
 	}
@@ -1385,5 +1396,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	junk_mode = JUNK_LEAVE_ALL;
 
 	strvec_clear(&transport_ls_refs_options.ref_prefixes);
+	free(transport_ls_refs_options.unborn_head_target);
 	return err;
 }
diff --git a/connect.c b/connect.c
index 328c279250..879669df93 100644
--- a/connect.c
+++ b/connect.c
@@ -376,7 +376,8 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 }
 
 /* Returns 1 when a valid ref has been added to `list`, 0 otherwise */
-static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
+static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
+			  char **unborn_head_target)
 {
 	int ret = 1;
 	int i = 0;
@@ -397,6 +398,25 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 		goto out;
 	}
 
+	if (!strcmp("unborn", line_sections.items[i].string)) {
+		i++;
+		if (unborn_head_target &&
+		    !strcmp("HEAD", line_sections.items[i++].string)) {
+			/*
+			 * Look for the symref target (if any). If found,
+			 * return it to the caller.
+			 */
+			for (; i < line_sections.nr; i++) {
+				const char *arg = line_sections.items[i].string;
+
+				if (skip_prefix(arg, "symref-target:", &arg)) {
+					*unborn_head_target = xstrdup(arg);
+					break;
+				}
+			}
+		}
+		goto out;
+	}
 	if (parse_oid_hex_algop(line_sections.items[i++].string, &old_oid, &end, reader->hash_algo) ||
 	    *end) {
 		ret = 0;
@@ -461,6 +481,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	const char *hash_name;
 	struct strvec *ref_prefixes = transport_options ?
 		&transport_options->ref_prefixes : NULL;
+	char **unborn_head_target = transport_options ?
+		&transport_options->unborn_head_target : NULL;
 	*list = NULL;
 
 	if (server_supports_v2("ls-refs", 1))
@@ -490,6 +512,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	if (!for_push)
 		packet_write_fmt(fd_out, "peel\n");
 	packet_write_fmt(fd_out, "symrefs\n");
+	if (server_supports_feature("ls-refs", "unborn", 0))
+		packet_write_fmt(fd_out, "unborn\n");
 	for (i = 0; ref_prefixes && i < ref_prefixes->nr; i++) {
 		packet_write_fmt(fd_out, "ref-prefix %s\n",
 				 ref_prefixes->v[i]);
@@ -498,7 +522,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 
 	/* Process response from server */
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
-		if (!process_ref_v2(reader, &list))
+		if (!process_ref_v2(reader, &list, unborn_head_target))
 			die(_("invalid ls-refs response: %s"), reader->line);
 	}
 
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 7f082fb23b..0111d4e8bd 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -102,11 +102,13 @@ test_expect_success 'redirected clone -v does show progress' '
 '
 
 test_expect_success 'chooses correct default initial branch name' '
-	git init --bare empty &&
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+	git -c init.defaultBranch=foo init --bare empty &&
+	test_config -C empty lsrefs.allowUnborn true &&
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
 	git -c init.defaultBranch=up clone empty whats-up &&
-	test refs/heads/up = $(git -C whats-up symbolic-ref HEAD) &&
-	test refs/heads/up = $(git -C whats-up config branch.up.merge)
+	test refs/heads/foo = $(git -C whats-up symbolic-ref HEAD) &&
+	test refs/heads/foo = $(git -C whats-up config branch.foo.merge)
 '
 
 test_expect_success 'guesses initial branch name correctly' '
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 7d5b17909b..a8ef92b644 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -209,6 +209,31 @@ test_expect_success 'clone with file:// using protocol v2' '
 	grep "ref-prefix refs/tags/" log
 '
 
+test_expect_success 'clone of empty repo propagates name of default branch' '
+	test_when_finished "rm -rf file_empty_parent file_empty_child" &&
+
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+	git -c init.defaultBranch=mydefaultbranch init file_empty_parent &&
+
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+	git -c init.defaultBranch=main -c protocol.version=2 \
+		clone "file://$(pwd)/file_empty_parent" file_empty_child &&
+	grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD
+'
+
+test_expect_success '...but not if explicitly forbidden by config' '
+	test_when_finished "rm -rf file_empty_parent file_empty_child" &&
+
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+	git -c init.defaultBranch=mydefaultbranch init file_empty_parent &&
+	test_config -C file_empty_parent lsrefs.allowUnborn false &&
+
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+	git -c init.defaultBranch=main -c protocol.version=2 \
+		clone "file://$(pwd)/file_empty_parent" file_empty_child &&
+	! grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD
+'
+
 test_expect_success 'fetch with file:// using protocol v2' '
 	test_when_finished "rm -f log" &&
 
diff --git a/transport.h b/transport.h
index 1f5b60e4d3..24e15799e7 100644
--- a/transport.h
+++ b/transport.h
@@ -243,6 +243,14 @@ struct transport_ls_refs_options {
 	 * provided ref_prefixes.
 	 */
 	struct strvec ref_prefixes;
+
+	/*
+	 * If unborn_head_target is not NULL, and the remote reports HEAD as
+	 * pointing to an unborn branch, transport_get_remote_refs() stores the
+	 * unborn branch in unborn_head_target. It should be freed by the
+	 * caller.
+	 */
+	char *unborn_head_target;
 };
 #define TRANSPORT_LS_REFS_OPTIONS_INIT { STRVEC_INIT }
 
-- 
2.30.0.280.ga3ce27912f-goog

