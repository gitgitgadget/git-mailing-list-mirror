Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96F220960
	for <e@80x24.org>; Mon, 10 Apr 2017 20:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbdDJUqb (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 16:46:31 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36509 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdDJUq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 16:46:29 -0400
Received: by mail-pf0-f174.google.com with SMTP id o126so38545759pfb.3
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 13:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=OjblE4aRwi5Tv5XuyvgwKrus8Jn16K1M9UGYrPhB9zI=;
        b=tySt3u4OurCbcz1W47ABEoKPiQMaa4gCaaWNhE/TkuMASpOhTKUJNuez54Y+Wn+Sjt
         UwykeAuPvduFFLPSshItF/kjrBjD8eXsNI3d82MFhfTdj6HwPTMl4tnxhL6cqKXV6cMy
         057mev8Y+SQlCh80jb4MpRx+t9VIbt9Mb4u8EedfYgK2yAjDliQm2B4L+jg7kJa7APtB
         oyJyA/UFyvLMlVCSZnBGys+S2n1LTreUyihCN4+zRbP5B8sGMtySjNNF9YDJwZ9ypj7m
         CT4Fn2fchQRjReVjs/y7mZtXdebm1wtbSjsHtHSsqQSQvsO5gDcOFsgQfnnMeCltjctp
         QzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=OjblE4aRwi5Tv5XuyvgwKrus8Jn16K1M9UGYrPhB9zI=;
        b=r1eopB2l2L0dRoHUASeqJIm3FI3ouvDWHYdfWePKE1Fj27I1DVX+uPOxIb2rsovjMp
         pMp4I5nz+fJA6k2PX1w5ZnJvQ45qzhbKnDzKETEByJB20qLEakV4CV5c+2bOZOmXxJcy
         LCTG5/iBm9P8efrPdqzS7bHUpMtlgqHsfp1lIwrjWhN485G9BDdMwQNdt0R1sMt3NQVv
         7fddtCu7rHtSK1pGf7GNcM9T5mE75ZVrFhcMRYsFlFim0baCeN7UQlBBx9pgurG4rM/U
         nUe6R6yAk2Xbw0btMtlhNMwqt8QECrcyB41W+UNVlp9X0y/X3KzN8Coib5D9lSDjLovn
         Q/KQ==
X-Gm-Message-State: AFeK/H3Fgzz1tDs08R1IUhBl1KMAae2O6K+uS7Vlls1sWtm4TbaiCllwIxajWL02pSjuwISg
X-Received: by 10.98.78.8 with SMTP id c8mr55751865pfb.155.1491857187923;
        Mon, 10 Apr 2017 13:46:27 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id r90sm6709414pfl.120.2017.04.10.13.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 13:46:25 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 3/4] fetch-pack: support new server endpoint
Date:   Mon, 10 Apr 2017 13:46:09 -0700
Message-Id: <40f36d5eeb984adc220a4038fc77ed6ad1398fef.1491851452.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
In-Reply-To: <cover.1491851452.git.jonathantanmy@google.com>
References: <cover.1491851452.git.jonathantanmy@google.com>
In-Reply-To: <cover.1491851452.git.jonathantanmy@google.com>
References: <cover.1491851452.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a patch to demonstrate that fetch-pack only requires a small
amount of changes to support the new server endpoint, and that things
generally work in various situations, including both stateless RPC and
non-stateless RPC (as can be seen from the tests).

Some minor issues remain:
 - Names of refs should be treated as strings (when interfacing with the
   new endpoint is requested) instead of being parsed into struct ref
   unconditionally.
 - Capability management could probably be done better instead of
   checking for "--new-way" everywhere.
 - I'm not sure how to test the upload-pack code path that sends "ACK
   ready".

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Makefile               |   1 +
 builtin/fetch-pack.c   |  10 +-
 fetch-pack.c           |  75 +++++++++++----
 fetch-pack.h           |   1 +
 t/helper/.gitignore    |   1 +
 t/helper/test-un-pkt.c |  40 ++++++++
 t/t9999-mytests.sh     | 242 +++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 349 insertions(+), 21 deletions(-)
 create mode 100644 t/helper/test-un-pkt.c
 create mode 100644 t/t9999-mytests.sh

diff --git a/Makefile b/Makefile
index 0d3813772..0b4510d3f 100644
--- a/Makefile
+++ b/Makefile
@@ -641,6 +641,7 @@ TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-submodule-config
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
+TEST_PROGRAMS_NEED_X += test-un-pkt
 TEST_PROGRAMS_NEED_X += test-urlmatch-normalization
 TEST_PROGRAMS_NEED_X += test-wildmatch
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 2a1c1c213..4bd83c4ff 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -143,6 +143,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.update_shallow = 1;
 			continue;
 		}
+		if (!strcmp("--new-way", arg)) {
+			args.new_way = 1;
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
 	if (deepen_not.nr)
@@ -193,7 +197,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		if (!conn)
 			return args.diag_url ? 0 : 1;
 	}
-	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
+	if (!args.new_way)
+		get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
 
 	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
 			 &shallow, pack_lockfile_ptr);
@@ -219,7 +224,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	 * remote no-such-ref' would silently succeed without issuing
 	 * an error.
 	 */
-	ret |= report_unmatched_refs(sought, nr_sought);
+	if (!args.new_way)
+		ret |= report_unmatched_refs(sought, nr_sought);
 
 	while (ref) {
 		printf("%s %s\n",
diff --git a/fetch-pack.c b/fetch-pack.c
index 74771a283..4cbdada7b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -251,7 +251,7 @@ static void consume_shallow_list(struct fetch_pack_args *args, int fd)
 	}
 }
 
-static enum ack_type get_ack(int fd, unsigned char *result_sha1)
+static enum ack_type get_ack(int fd, unsigned char *result_sha1, struct ref **ref, struct sha1_array *shallow)
 {
 	int len;
 	char *line = packet_read_line(fd, &len);
@@ -261,6 +261,23 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 		die(_("git fetch-pack: expected ACK/NAK, got EOF"));
 	if (!strcmp(line, "NAK"))
 		return NAK;
+	if (ref && skip_prefix(line, "wanted ", &arg)) {
+		struct object_id oid;
+		if (!get_sha1_hex(arg, oid.hash) && arg[40] == ' ' && arg[41]) {
+			struct ref *new_ref = alloc_ref(arg + 41);
+			oidcpy(&new_ref->old_oid, &oid);
+			new_ref->next = *ref;
+			*ref = new_ref;
+			return get_ack(fd, result_sha1, ref, shallow);
+		}
+	}
+	if (shallow && skip_prefix(line, "shallow ", &arg)) {
+		struct object_id oid;
+		if (!get_sha1_hex(arg, oid.hash)) {
+			sha1_array_append(shallow, oid.hash);
+			return get_ack(fd, result_sha1, ref, shallow);
+		}
+	}
 	if (skip_prefix(line, "ACK ", &arg)) {
 		if (!get_sha1_hex(arg, result_sha1)) {
 			arg += 40;
@@ -370,7 +387,7 @@ static char *get_wants(const struct fetch_pack_args *args, struct ref *refs)
 
 static int find_common(struct fetch_pack_args *args,
 		       int fd[2], unsigned char *result_sha1,
-		       char *wants)
+		       char *wants, struct ref **ref, struct sha1_array *shallow)
 {
 	int count = 0, flushes = 0, flush_at = INITIAL_FLUSH, retval;
 	const unsigned char *sha1;
@@ -475,7 +492,7 @@ static int find_common(struct fetch_pack_args *args,
 
 			consume_shallow_list(args, fd[0]);
 			do {
-				ack = get_ack(fd[0], result_sha1);
+				ack = get_ack(fd[0], result_sha1, NULL, NULL);
 				if (ack)
 					print_verbose(args, _("got %s %d %s"), "ack",
 						      ack, sha1_to_hex(result_sha1));
@@ -544,7 +561,7 @@ static int find_common(struct fetch_pack_args *args,
 	if (!got_ready || !no_done)
 		consume_shallow_list(args, fd[0]);
 	while (flushes || multi_ack) {
-		int ack = get_ack(fd[0], result_sha1);
+		int ack = get_ack(fd[0], result_sha1, ref, shallow);
 		if (ack) {
 			print_verbose(args, _("got %s (%d) %s"), "ack",
 				      ack, sha1_to_hex(result_sha1));
@@ -878,22 +895,22 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 struct shallow_info *si,
 				 char **pack_lockfile)
 {
-	struct ref *ref = copy_ref_list(orig_ref);
+	struct ref *ref;
 	unsigned char sha1[20];
 	const char *agent_feature;
 	int agent_len;
+	int find_common_result;
 
-	sort_ref_list(&ref, ref_compare_name);
-	QSORT(sought, nr_sought, cmp_ref_by_name);
-
-	if ((args->depth > 0 || is_repository_shallow()) && !server_supports("shallow"))
-		die(_("Server does not support shallow clients"));
+	if (!args->new_way) {
+		if ((args->depth > 0 || is_repository_shallow()) && !server_supports("shallow"))
+			die(_("Server does not support shallow clients"));
+	}
 	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen = 1;
-	if (server_supports("multi_ack_detailed")) {
+	if (server_supports("multi_ack_detailed") || args->new_way) {
 		print_verbose(args, _("Server supports multi_ack_detailed"));
 		multi_ack = 2;
-		if (server_supports("no-done")) {
+		if (server_supports("no-done") || args->new_way) {
 			print_verbose(args, _("Server supports no-done"));
 			if (args->stateless_rpc)
 				no_done = 1;
@@ -936,22 +953,42 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 			print_verbose(args, _("Server version is %.*s"),
 				      agent_len, agent_feature);
 	}
-	if (server_supports("deepen-since"))
+	if (server_supports("deepen-since") || args->new_way)
 		deepen_since_ok = 1;
 	else if (args->deepen_since)
 		die(_("Server does not support --shallow-since"));
-	if (server_supports("deepen-not"))
+	if (server_supports("deepen-not") || args->new_way)
 		deepen_not_ok = 1;
 	else if (args->deepen_not)
 		die(_("Server does not support --shallow-exclude"));
 	if (!server_supports("deepen-relative") && args->deepen_relative)
 		die(_("Server does not support --deepen"));
 
-	if (everything_local(args, &ref, sought, nr_sought)) {
-		packet_flush(fd[1]);
-		goto all_done;
+	if (args->new_way) {
+		struct strbuf wants = STRBUF_INIT;
+		int i;
+		struct sha1_array shallow = SHA1_ARRAY_INIT;
+
+		ref = NULL;
+		multi_ack = 2;
+		use_sideband = 2;
+
+		packet_buf_write(&wants, "fetch-refs\n");
+		for (i = 0; i < nr_sought; i++)
+			packet_buf_write(&wants, "want %s\n", sought[i]->name);
+		find_common_result = find_common(args, fd, sha1, strbuf_detach(&wants, NULL), &ref, &shallow);
+		prepare_shallow_info(si, &shallow);
+	} else {
+		ref = copy_ref_list(orig_ref);
+		sort_ref_list(&ref, ref_compare_name);
+		QSORT(sought, nr_sought, cmp_ref_by_name);
+		if (everything_local(args, &ref, sought, nr_sought)) {
+			packet_flush(fd[1]);
+			goto all_done;
+		}
+		find_common_result = find_common(args, fd, sha1, get_wants(args, ref), NULL, NULL);
 	}
-	if (find_common(args, fd, sha1, get_wants(args, ref)) < 0)
+	if (find_common_result < 0)
 		if (!args->keep_pack)
 			/* When cloning, it is not unusual to have
 			 * no common commit.
@@ -1128,7 +1165,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 	if (nr_sought)
 		nr_sought = remove_duplicates_in_refs(sought, nr_sought);
 
-	if (!ref) {
+	if (!args->new_way && !ref) {
 		packet_flush(fd[1]);
 		die(_("no matching remote head"));
 	}
diff --git a/fetch-pack.h b/fetch-pack.h
index a2d46e6e7..ab7a80696 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -29,6 +29,7 @@ struct fetch_pack_args {
 	unsigned cloning:1;
 	unsigned update_shallow:1;
 	unsigned deepen:1;
+	unsigned new_way:1;
 };
 
 /*
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index d6e8b3679..cce5069cb 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -29,5 +29,6 @@
 /test-submodule-config
 /test-subprocess
 /test-svn-fe
+/test-un-pkt
 /test-urlmatch-normalization
 /test-wildmatch
diff --git a/t/helper/test-un-pkt.c b/t/helper/test-un-pkt.c
new file mode 100644
index 000000000..6dcf87980
--- /dev/null
+++ b/t/helper/test-un-pkt.c
@@ -0,0 +1,40 @@
+/*
+ * This program takes payloads in pkt-line format (one or more pkt-lines
+ * followed by a flush pkt) and runs the given command once per payload.
+ */
+#include "cache.h"
+#include "pkt-line.h"
+#include "run-command.h"
+
+int cmd_main(int argc, const char **argv)
+{
+	struct child_process *cmd = NULL;
+	char buffer[LARGE_PACKET_MAX];
+	int size;
+
+	while ((size = packet_read(0, NULL, NULL, buffer, sizeof(buffer),
+				   PACKET_READ_GENTLE_ON_EOF)) >= 0) {
+		if (size > 0) {
+			if (!cmd) {
+				cmd = xmalloc(sizeof(*cmd));
+				child_process_init(cmd);
+				cmd->argv = argv + 1;
+				cmd->git_cmd = 1;
+				cmd->in = -1;
+				cmd->out = 0;
+				if (start_command(cmd))
+					die("could not start command");
+			}
+			write_in_full(cmd->in, buffer, size);
+		} else if (cmd) {
+			close(cmd->in);
+			if (finish_command(cmd))
+				die("could not finish command");
+			free(cmd);
+			cmd = NULL;
+			if (size < 0)
+				break;
+		}
+	}
+	return 0;
+}
diff --git a/t/t9999-mytests.sh b/t/t9999-mytests.sh
new file mode 100644
index 000000000..9bb4e85e3
--- /dev/null
+++ b/t/t9999-mytests.sh
@@ -0,0 +1,242 @@
+#!/bin/sh
+
+test_description='my tests'
+
+. ./test-lib.sh
+
+test_expect_success 'fetch-pack --new-way basic' '
+	rm -rf server &&
+	git init server &&
+	(
+		cd server &&
+		test_commit 0 &&
+
+		git checkout -b one
+		test_commit 1 &&
+		git checkout master &&
+
+		git checkout -b two
+		test_commit 2 &&
+		git checkout master &&
+
+		git checkout -b dont_fetch_this
+		test_commit 3 &&
+		git checkout master
+	) &&
+	git fetch-pack --new-way --exec=git-server-endpoint server refs/heads/one refs/heads/two\* >actual &&
+
+	grep "$(printf "%s refs/heads/one" $(git -C server rev-parse --verify one))" actual &&
+	grep "$(printf "%s refs/heads/two" $(git -C server rev-parse --verify two))" actual &&
+	! grep dont_fetch_this actual
+'
+
+test_expect_success 'fetch-pack --new-way hideRefs' '
+	rm -rf server &&
+	git init server &&
+	test_config -C server transfer.hideRefs refs/heads/b2 &&
+	(
+		cd server &&
+		test_commit 0 &&
+
+		git checkout -b b1
+		test_commit 1 &&
+		git checkout master &&
+
+		git checkout -b b2
+		test_commit 2 &&
+		git checkout master
+	) &&
+	git fetch-pack --new-way --exec=git-server-endpoint server refs/heads/b\* >actual &&
+
+	grep "$(printf "%s refs/heads/b1" $(git -C server rev-parse --verify 1))" actual &&
+	! grep refs/heads/b2 actual
+'
+
+test_expect_success 'fetch-pack --new-way long negotiation' '
+	rm -rf server client &&
+	git init server &&
+	test_commit -C server 0 &&
+
+	git clone server client &&
+
+	test_commit -C server 1 &&
+
+	git -C client checkout -b sidebranch &&
+	for i in $(seq 2 32)
+	do
+		test_commit -C client $i
+	done &&
+
+	git -C client fetch-pack --new-way --exec=git-server-endpoint ../server refs/heads/master >actual &&
+
+	grep "$(printf "%s refs/heads/master" $(git -C server rev-parse --verify 1))" actual
+'
+
+test_expect_success 'fetch-pack --new-way with shallow client' '
+	rm -rf server &&
+	git init server &&
+	(
+		cd server &&
+		test_commit 0 &&
+		test_commit 1
+	) &&
+	rm -rf client &&
+	git clone --depth=1 "file://$(pwd)/server" client &&
+	(
+		cd server &&
+		git checkout -b two 0 &&
+		test_commit 2
+	) &&
+
+	# check that the shallow clone does not include this parent commit
+	test_must_fail git -C client cat-file -e $(git -C server rev-parse 0) &&
+
+	git -C client fetch-pack --new-way --exec=git-server-endpoint ../server refs/heads/two >actual &&
+	# 0 is the parent of 2, so it must be included now
+	git -C client cat-file -e $(git -C server rev-parse 0)
+'
+
+test_expect_success 'fetch-pack --new-way --depth' '
+	rm -rf server &&
+	git init server &&
+	(
+		cd server &&
+		test_commit 0
+	) &&
+	rm -rf client &&
+	git clone server client &&
+	(
+		cd server &&
+		test_commit 1 &&
+		test_commit 2
+	) &&
+
+	git -C client fetch-pack --new-way --exec=git-server-endpoint --depth=1 ../server refs/heads/master >actual &&
+	git -C client cat-file -e $(git -C server rev-parse 2) &&
+	test_must_fail git -C client cat-file -e $(git -C server rev-parse 1)
+'
+
+test_expect_success 'fetch-pack --new-way --shallow-since' '
+	rm -rf server &&
+	git init server &&
+	(
+		cd server &&
+		test_commit 0
+	) &&
+	rm -rf client &&
+	git clone server client &&
+	(
+		cd server &&
+		test_commit 1 &&
+		test_commit 2
+	) &&
+	DATE=$(git -C server log --format="format:%at" --no-walk 2) &&
+
+	git -C client fetch-pack --new-way --exec=git-server-endpoint --shallow-since=$DATE ../server refs/heads/master >actual &&
+	git -C client cat-file -e $(git -C server rev-parse 2) &&
+	test_must_fail git -C client cat-file -e $(git -C server rev-parse 1)
+'
+
+test_expect_success 'fetch-pack --new-way --shallow-exclude' '
+	rm -rf server &&
+	git init server &&
+	(
+		cd server &&
+		test_commit 0
+	) &&
+	rm -rf client &&
+	git clone server client &&
+	(
+		cd server &&
+		test_commit 1 &&
+		test_commit 2
+	) &&
+
+	git -C client fetch-pack --new-way --exec=git-server-endpoint --shallow-exclude=1 ../server refs/heads/master >actual &&
+	git -C client cat-file -e $(git -C server rev-parse 2) &&
+	test_must_fail git -C client cat-file -e $(git -C server rev-parse 1)
+'
+
+test_expect_success PIPE 'fetch-pack --new-way --stateless-rpc' '
+	rm -rf server &&
+	git init server &&
+	(
+		cd server &&
+		test_commit 0 &&
+
+		git checkout -b one
+		test_commit 1 &&
+		git checkout master &&
+
+		git checkout -b two
+		test_commit 2 &&
+		git checkout master &&
+
+		git checkout -b dont_fetch_this
+		test_commit 3 &&
+		git checkout master
+	) &&
+	rm -rf client &&
+	git init client &&
+
+	mkfifo se-out &&
+
+	git -C client fetch-pack --new-way --stateless-rpc ../server refs/heads/one refs/heads/two\* <se-out | test-un-pkt server-endpoint server --stateless-rpc >se-out &&
+
+	git -C client cat-file -e $(git -C server rev-parse 1) &&
+	git -C client cat-file -e $(git -C server rev-parse 2) &&
+	test_must_fail git -C client cat-file -e $(git -C server rev-parse 3)
+'
+
+test_expect_success 'fetch-pack --new-way --stateless-rpc long negotiation' '
+	rm -rf server client &&
+	git init server &&
+	test_commit -C server 0 &&
+
+	git clone server client &&
+
+	test_commit -C server 1 &&
+
+	git -C client checkout -b sidebranch &&
+	for i in $(seq 2 32)
+	do
+		test_commit -C client $i
+	done &&
+
+	rm -f se-out &&
+	mkfifo se-out &&
+
+	git -C client fetch-pack --new-way --stateless-rpc ../server refs/heads/master <se-out | test-un-pkt server-endpoint server --stateless-rpc >se-out &&
+
+	git -C client cat-file -e $(git -C server rev-parse 1)
+'
+
+test_expect_success 'fetch-pack --new-way --stateless-rpc namespaces' '
+	rm -rf server &&
+	git init server &&
+	(
+		cd server &&
+		test_commit 0 &&
+
+		git checkout -b mybranch
+		test_commit 1 &&
+		git checkout master &&
+
+		git checkout -b mybranch_ns
+		test_commit 2 &&
+		git checkout master &&
+		git update-ref refs/namespaces/ns/refs/heads/mybranch mybranch_ns
+	) &&
+	rm -rf client &&
+	git init client &&
+
+	rm -f se-out &&
+	mkfifo se-out &&
+
+	git -C client fetch-pack --new-way --stateless-rpc ../server refs/heads/mybranch <se-out | GIT_NAMESPACE=ns test-un-pkt server-endpoint server --stateless-rpc >se-out &&
+
+	git -C client cat-file -e $(git -C server rev-parse 2) &&
+	test_must_fail git -C client cat-file -e $(git -C server rev-parse 1)
+'
+
+test_done
-- 
2.12.2.715.g7642488e1d-goog

