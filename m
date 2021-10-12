Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885F8C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7199760F3A
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhJLRoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhJLRom (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 13:44:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6764AC061746
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 10:42:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q193-20020a252aca000000b005ba63482993so212509ybq.0
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=LYW6LVrfeBCSlrGae4y9Zw+nz2Abnt85V453VO/I4CM=;
        b=edStZw6kYmgftVgQOORILv+KKYZmByXPr/q8WLnxMWhxyh/GrU+jKJned+ittozkTw
         ZJ8A0Y/3PRvXfKFa0anJ3fFhSZ8d4+2M5TKi+NTvXF54lMllWbSkqN78/YRKDdjTO7ze
         JMkGbERSQPuctHbA+F1S9Wt/lJuOXVE5QOSFA53eBdA/lPQT/6huPGl4OSqOVxCnTdiS
         I9YHY7sUNM82qj+rUtaoj4B9q7uuIfxuOTg57ts9viXIF6t5/U5gG0SACDzb11rKHlPp
         TFEGfBPkbZugMeoj7Z7GdkIbMZwRB1uWwdakbkgP1Zx9l+Vha/HD45abu6z2n/eNUHEZ
         hYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=LYW6LVrfeBCSlrGae4y9Zw+nz2Abnt85V453VO/I4CM=;
        b=ZcTb5R7qUQnx82EwSuTU5VmJeH+TE0XHVE19Mt9tEb9jU69ZI7cTafx7t8/F5R+D2W
         i+CcB9WG5YjBXM+0HTkrBtlYev597oxhR7BgA/FwnpIL5vvoHVRxjkxVowukocJyN4lv
         LKl5IaH7kMEBL4ct39xYUTNWDy1V5aLlVpW73vgoevAE9ApU1wIal8AzIc84B718bwNl
         MQO4+4ZW7YO2KiUz5t2HunxP14UpPlJv+J0Ixv7tTl8sUnEKu1Yf4/x7SmLRNURXj26Z
         mnib2TU41OtyWtsk201PIvym3L9slb98zIOk+oIvaxst6LTwILssM1OUMiYNv8WwSUrx
         zWjg==
X-Gm-Message-State: AOAM530tKaUobnbwiEGcTfEz2p9eqOLCmHpU9KbEdCiIewfBEJ+yPoyI
        DEqf7jy+IBKO7FjsOCUvEHutrqbdPQagvBPyk6cC1FEQTTdJbFHebdCtR+tPPvkuKpobb/YTRYK
        1qL16BzRt2m7I1YCKuIUUAIcYUt4WpdXmp2B34mxJQ6xM1nqn8agricJaRxPvc90=
X-Google-Smtp-Source: ABdhPJyr0Fio+wTA9IgSd6PtFFRmX8JUCM48R8EV7aWVE4atBj9Hlc/jZ+ADPpdaN/PGBiON5GlPNYOe+m4nqw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:3620:: with SMTP id
 d32mr29797836yba.46.1634060559481; Tue, 12 Oct 2021 10:42:39 -0700 (PDT)
Date:   Tue, 12 Oct 2021 10:42:06 -0700
In-Reply-To: <20211012174208.95161-1-chooglen@google.com>
Message-Id: <20211012174208.95161-2-chooglen@google.com>
Mime-Version: 1.0
References: <20211005001931.13932-1-chooglen@google.com> <20211012174208.95161-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v4 1/3] fsck: verify commit graph when implicitly enabled
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>
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
disable GIT_TEST_COMMIT_GRAPH for tests that use fsck in ways that
assume that commit-graph checking is disabled (t/t3800-mktag.sh,
t/t0410-partial-clone.sh).

Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/fsck.c           |  3 ++-
 t/t0410-partial-clone.sh |  6 +++++-
 t/t3800-mktag.sh         |  5 +++++
 t/t5318-commit-graph.sh  | 23 ++++++++++++++++++++++-
 4 files changed, 34 insertions(+), 3 deletions(-)

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
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 0544d58a6e..27fb15c83b 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -6,6 +6,11 @@ test_description=3D'git mktag: tag object verify test'
=20
 . ./test-lib.sh
=20
+# When enabled, some commands will automatically write commit-graphs.
+# This will cause the mktag tests to fail because fsck will attempt to
+# verify the out-of-sync commit graph.
+GIT_TEST_COMMIT_GRAPH=3D0
+
 ###########################################################
 # check the tag.sig file, expecting verify_tag() to fail,
 # and checking that the error message matches the pattern
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 295c5bd94d..4e4450af1e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -693,12 +693,33 @@ test_expect_success 'detect incorrect chunk count' '
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
2.33.0.882.g93a45727a2-goog

