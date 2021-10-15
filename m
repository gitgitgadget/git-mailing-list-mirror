Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DBCC433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 20:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8497D61181
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 20:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbhJOUSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 16:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhJOUSp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 16:18:45 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AD8C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 13:16:38 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id e6-20020a637446000000b002993ba24bbaso5572877pgn.12
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 13:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=cv3x/QXRYjD/0tk/79Nk+zelrBdXTVLZVBfgQcyJsn4=;
        b=QuJpn/KBI3vXXSmdvGsUtkbDoxM5PrSV+aMmTvFWWTah3HYa/UjE0LePFN9gTdQLzP
         9FdFNngd/Egf8v/e/8efdz3eY0Wg7xCE0OREVMF7qP/9jBy2FI57wnM7yQdBMaH19+Yq
         LqTMvUJcOjnHQuCaODmnV/dvBW5wDqKA9ySsZtE1MzBrubPSacZ/JYPUYmKAKnbi7D0K
         RtjCGwnXfBiXdEBODqsyqeZ28kF7tlx5g+8y0iIRg1DVZLyq1djpjqYJTSuU/dFL5LOT
         XpeoWk2B3Xk2SilDBTJvMw9ks9yjqr4fcChXD3E7I3GRlbAa4L4BgPEl0nmvI27vEFjh
         B70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=cv3x/QXRYjD/0tk/79Nk+zelrBdXTVLZVBfgQcyJsn4=;
        b=WhvONL6MnJUAMvfGwk1dhcJ7Jde5hwFFCo4Xhvv4x7GGZDjpMyZnI2ZUAbpJzectbo
         lISBQe7L4sVuFhiSEkFciG6nWWhNG74BCX6HKTJMo6in9Ru90/Y6VPutz1sJT9TC5/tu
         CZ4A+iWrxZN3oj/R3Dha3OnUPSt+U2y95u3cg6//clJG2gQPj6sRLOZRqf/MLl99V1NI
         8tAyi8vMZQL7x9rO35us0T2nEDPSWK5bQUwmgbdbGF3sqBCLwdLI+s+jNkfdHswqJ6Za
         qrgmlsXm5xBpFPmJe7J/KjSLPp0KHY5uk0OnyHqvLbVWbTCHRKZakU1FF8m9DvQDZlbV
         4nAw==
X-Gm-Message-State: AOAM532LbXOsPIZnWdTOOoP91NLFw9cR9KyCdBYLb5zDGM4S4SC7Z3SP
        zzEhDSqgBkGtOsRxK/SACWzSf1f0XIlavs+mxosflZS3Vxhf7GfZYjvm2nCqMrXvm9LPspCpQEl
        STvAj7HC89OOx3ka6KBbJBrX1fDHW3TU7JHX8B/BgE/otIH3JVdolqqJI6ap2VBI=
X-Google-Smtp-Source: ABdhPJzEAitzAn73H6Sd0kii6U2vd32L0Xd0btqbSzmMMhd2JjKULZiCzw43Y/Hvpaolljd3lN/TBe0bkoD6TA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:8042:0:b0:44c:78ec:c9a9 with SMTP id
 y2-20020aa78042000000b0044c78ecc9a9mr13602270pfm.45.1634328997882; Fri, 15
 Oct 2021 13:16:37 -0700 (PDT)
Date:   Fri, 15 Oct 2021 13:16:29 -0700
In-Reply-To: <20211015201631.91524-1-chooglen@google.com>
Message-Id: <20211015201631.91524-2-chooglen@google.com>
Mime-Version: 1.0
References: <20211012174208.95161-1-chooglen@google.com> <20211015201631.91524-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 1/3] fsck: verify commit graph when implicitly enabled
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change fsck to check the "core_commit_graph" variable set in
"repo-settings.c" instead of reading the "core.commitGraph" variable.
This fixes a bug where we wouldn't verify the commit-graph if the
config key was missing. This bug was introduced in
31b1de6a09 (commit-graph: turn on commit-graph by default, 2019-08-13),
where core.commitGraph was turned on by default.

Add tests to "t5318-commit-graph.sh" to verify that fsck checks the
commit-graph as expected for the 3 values of core.commitGraph. Also,
disable GIT_TEST_COMMIT_GRAPH in t/t0410-partial-clone.sh because some
test cases use fsck in ways that assume that commit-graph checking is
disabled.

Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/fsck.c           |  3 ++-
 t/t0410-partial-clone.sh |  6 +++++-
 t/t5318-commit-graph.sh  | 23 ++++++++++++++++++++++-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index b42b6fe21f..1c4e485b66 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -803,6 +803,7 @@ int cmd_fsck(int argc, const char **argv, const char *p=
refix)
 		fsck_enable_object_names(&fsck_walk_options);
=20
 	git_config(git_fsck_config, &fsck_obj_options);
+	prepare_repo_settings(the_repository);
=20
 	if (connectivity_only) {
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
@@ -908,7 +909,7 @@ int cmd_fsck(int argc, const char **argv, const char *p=
refix)
=20
 	check_connectivity();
=20
-	if (!git_config_get_bool("core.commitgraph", &i) && i) {
+	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify =3D CHILD_PROCESS_INIT;
 		const char *verify_argv[] =3D { "commit-graph", "verify", NULL, NULL, NU=
LL };
=20
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index bba679685f..c76485b1b6 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -6,6 +6,10 @@ test_description=3D'partial clone'
=20
 # missing promisor objects cause repacks which write bitmaps to fail
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=3D0
+# When enabled, some commands will write commit-graphs. This causes fsck
+# to fail when delete_object() is called because fsck will attempt to
+# verify the out-of-sync commit graph.
+GIT_TEST_COMMIT_GRAPH=3D0
=20
 delete_object () {
 	rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
@@ -322,7 +326,7 @@ test_expect_success 'rev-list stops traversal at missin=
g and promised commit' '
=20
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "arbitrary string" &&
-	GIT_TEST_COMMIT_GRAPH=3D0 git -C repo -c core.commitGraph=3Dfalse rev-lis=
t --exclude-promisor-objects --objects bar >out &&
+	git -C repo rev-list --exclude-promisor-objects --objects bar >out &&
 	grep $(git -C repo rev-parse bar) out &&
 	! grep $FOO out
 '
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 84d122a7ae..f516fda7cc 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -694,12 +694,33 @@ test_expect_success 'detect incorrect chunk count' '
 		$GRAPH_CHUNK_LOOKUP_OFFSET
 '
=20
-test_expect_success 'git fsck (checks commit-graph)' '
+test_expect_success 'git fsck (checks commit-graph when config set to true=
)' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git fsck &&
 	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
 		"incorrect checksum" &&
 	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
+	test_must_fail git -c core.commitGraph=3Dtrue fsck
+'
+
+test_expect_success 'git fsck (ignores commit-graph when config set to fal=
se)' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git fsck &&
+	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
+		"incorrect checksum" &&
+	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
+	git -c core.commitGraph=3Dfalse fsck
+'
+
+test_expect_success 'git fsck (checks commit-graph when config unset)' '
+	cd "$TRASH_DIRECTORY/full" &&
+	test_when_finished "git config core.commitGraph true" &&
+
+	git fsck &&
+	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
+		"incorrect checksum" &&
+	test_unconfig core.commitGraph &&
+	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
 	test_must_fail git fsck
 '
=20
--=20
2.33.0.1079.g6e70778dc9-goog

