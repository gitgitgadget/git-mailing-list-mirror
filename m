Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD04EC19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 16:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbiHCQRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiHCQRo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 12:17:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430FB20F75
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 09:17:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a11so8959857wmq.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dWFnZXP0/Yy3ASWxrKDJh5m8KZJAUMiRucHv5evvqi0=;
        b=WXi2NXUyw0HJjE1j2qqjAuXDW9ODyHe5gMrfFfsrkFVVZesQnjU486MSX+Fhy12sMx
         eB0mL1rqBgsBTssOLlOwA3h185wFKX1M/LhlK5oYiDc6QoeQoL2eTyCnkXfb2FjRN99F
         6f5GOVQfK+mxObWmwKwtg7hZPWHHk1eqabI1OfXHadMAUmIs5MvWhg+IWIGFDv09ye0+
         QxQoUrIdSJeUsy9XynPnKlg59OQTboR9a91/P0MX7AoUmhvFqut1tVZfCvosLH91dzCV
         pPCp4cPSkBcQQBWZZkBAWo6OZKW0pt3qURXVxVoWYl91ChYFS0M9jgXg7mMPds7+BiO7
         4cHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dWFnZXP0/Yy3ASWxrKDJh5m8KZJAUMiRucHv5evvqi0=;
        b=lMoy7BPnP6niGO5/aL0Njm1z4J96WXd0mp/FiZV12ISmq1FhtoJ836stCdGT/QE8dU
         UbJrZYcLp+oNPze6qRi8qMYOtlUzSbgNMMhKRa24EZN/4wNsFIgqrzjL6RRN1my50f0j
         euQd9dN3aOA5cfk7Pu5w0mHIeT9R2Aidf1zES/7TSsAGQojXbsr3cAvIugmLNHNcVgO9
         SAt+zAvvIqodju8yrzMsydfk49sj54ypbxzG5vdA01JTZeqmI8RQdnxE4iTglS57ywV0
         Zn5l8l5FpHwIy8w5o8nbylbnz/XGIyW7VoC2nctG6jfzBbyMruPku1Vwoe7tsYZV1rDo
         VO1w==
X-Gm-Message-State: ACgBeo0oEPk0hepSdsKGhwqXX9MvaDdKffpL18NKSG+uSmTKi/wZglz4
        Vno2Pg5jG+rYcqA3rdiT78330k4Uys8=
X-Google-Smtp-Source: AA6agR5QfOz0/OfPvWvnv2SV5W3QssoajvtRKIM7rND4FSa+z2YRMjxXRtl6MbgJtW/zXmjcbCCWYA==
X-Received: by 2002:a05:600c:1e1d:b0:3a4:f0b1:dd0b with SMTP id ay29-20020a05600c1e1d00b003a4f0b1dd0bmr3409489wmb.138.1659543460124;
        Wed, 03 Aug 2022 09:17:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8-20020a05600c384800b003a503a64e5esm1205075wmr.15.2022.08.03.09.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 09:17:39 -0700 (PDT)
Message-Id: <b4b5ce5a361caf08ea15a8066f6cac5b255a527d.1659543457.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
References: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Aug 2022 16:17:35 +0000
Subject: [PATCH 1/3] refs-advertise: add hook to filter advertised refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sun Chao <16657101987@163.com>, Sun Chao <sunchao9@huawei.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <sunchao9@huawei.com>

Gerrit is implemented by JGit and is known as a centralized workflow system
which supports reference-level access control for repository. If we choose
to work in centralized workflow like what Gerrit provided, reference-level
access control is needed and is possible if we add a reference advertise
filter hook just like what Gerrit did.

This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
during the reference discovery phase and the commit fetching phase,
each reference and will be filtered by this hook. The hook executes once
with no arguments for each 'git-upload-pack' and 'git-receive-pack' process
and if the exit status is non-zero, `git push` and `git fetch` will abort.

Once the hook is invoked, a version number and server process name
('git-upload-pack' or 'git-receive-pack' or 'ls-refs') should send to it in
packet-line format, followed by a flush-pkt. The hook should response with
its version number and process name list it support. If the list does not
contains the server process name, the server will close the connection with
the hook and keep going without the hook child process.

During reference discovery phase, each reference will be filtered by this
hook. In the following example, the letter 'G' stands for 'git-receive-pack'
or 'git-upload-pack' and the letter 'H' stands for this hook. The hook
decides if the reference will be advertised or not, it sends result back in
pkt-line format protocol, a response in "ok ref <ref>" format followed by a
flush-pkt means the references "<ref>" can be advertised, and "ng ref <ref>"
means not.

    # Version negotiation
    G: PKT-LINE(version=1\0git-upload-pack)
    G: flush-pkt
    H: PKT-LINE(version=1\0git-upload-pack git-receive-pack ls-refs)
    H: flush-pkt

    # Send reference filter request to hook
    G: PKT-LINE(ref <ref> <oid>)
    G: flush-pkt

    # Receive result from the hook.
    # Case 1: this reference is valid
    H: PKT-LINE(ok ref <ref>)
    H: flush-pkt
    # Case 2: this reference is filtered out
    H: PKT-LINE(ng ref <ref>)
    H: flush-pkt

During commit fetch phase of 'git-upload-pack' process, git client may send
`want <oid>` requests and 'git-upload-pack' will send object filter requests
to the hook to check if the object "<oid>" will be sent to the client or
not. In the following example, the letter 'G' stands for 'git-upload-pack'
and the letter 'H' stands for this hook.

The hook will decides if a commit will be sent to the client or not, it
sends result in pkt-line format protocol to `git-upload-pack`, a response
with "ok obj <oid>" format followed by a flush-pkt means the object "<oid>"
can be sent to client, and "ng obj <oid>" means not.

    # Version negotiation
    G: PKT-LINE(version=1\0ls-refs)
    G: flush-pkt
    H: PKT-LINE(version=1\0git-upload-pack git-receive-pack ls-refs)
    H: flush-pkt

    # Send commit filter request to hook
    G: PKT-LINE(obj <oid>)
    G: flush-pkt

    # Receive result from the hook.
    # Case 1: this object is valid
    H: PKT-LINE(ok obj <oid>)
    H: flush-pkt
    # Case 2: this object is filtered out
    H: PKT-LINE(ng obj <oid>)
    H: flush-pkt

Signed-off-by: Sun Chao <sunchao9@huawei.com>
---
 Makefile                       |   2 +
 builtin/receive-pack.c         |  12 ++
 ls-refs.c                      |  30 +++-
 refs/refs-advertise.c          | 246 +++++++++++++++++++++++++++++++++
 refs/refs-advertise.h          |  11 ++
 t/helper/test-refs-advertise.c | 202 +++++++++++++++++++++++++++
 t/helper/test-tool.c           |   1 +
 t/helper/test-tool.h           |   1 +
 upload-pack.c                  |  42 +++++-
 9 files changed, 538 insertions(+), 9 deletions(-)
 create mode 100644 refs/refs-advertise.c
 create mode 100644 refs/refs-advertise.h
 create mode 100644 t/helper/test-refs-advertise.c

diff --git a/Makefile b/Makefile
index 1624471badc..38740a52cee 100644
--- a/Makefile
+++ b/Makefile
@@ -793,6 +793,7 @@ TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-windows-named-pipe.o
 TEST_BUILTINS_OBJS += test-write-cache.o
 TEST_BUILTINS_OBJS += test-xml-encode.o
+TEST_BUILTINS_OBJS += test-refs-advertise.o
 
 # Do not add more tests here unless they have extra dependencies. Add
 # them in TEST_BUILTINS_OBJS above.
@@ -1050,6 +1051,7 @@ LIB_OBJS += refs/files-backend.o
 LIB_OBJS += refs/iterator.o
 LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
+LIB_OBJS += refs/refs-advertise.o
 LIB_OBJS += refspec.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace-object.o
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 31b48e728be..2f82fd05f25 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -30,6 +30,7 @@
 #include "commit-reach.h"
 #include "worktree.h"
 #include "shallow.h"
+#include "refs/refs-advertise.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
@@ -299,6 +300,10 @@ static int show_ref_cb(const char *path_full, const struct object_id *oid,
 	if (ref_is_hidden(path, path_full))
 		return 0;
 
+	if (filter_advertise_ref(path, oid)) {
+		return 0;
+	}
+
 	/*
 	 * Advertise refs outside our current namespace as ".have"
 	 * refs, so that the client can use them to minimize data
@@ -2458,6 +2463,10 @@ static int delete_only(struct command *commands)
 	return 1;
 }
 
+static void clean_refs_advertise_filter(void) {
+	clean_advertise_refs_filter();
+}
+
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int advertise_refs = 0;
@@ -2492,6 +2501,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	if (!enter_repo(service_dir, 0))
 		die("'%s' does not appear to be a git repository", service_dir);
 
+	create_advertise_refs_filter("git-receive-pack");
+	atexit(clean_refs_advertise_filter);
+
 	git_config(receive_pack_config, NULL);
 	if (cert_nonce_seed)
 		push_cert_nonce = prepare_push_cert_nonce(service_dir, time(NULL));
diff --git a/ls-refs.c b/ls-refs.c
index 98e69373c84..5a1f74abe0a 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -6,10 +6,13 @@
 #include "ls-refs.h"
 #include "pkt-line.h"
 #include "config.h"
+#include "run-command.h"
+#include "refs/refs-advertise.h"
 
 static int config_read;
 static int advertise_unborn;
 static int allow_unborn;
+static struct string_list symref = STRING_LIST_INIT_DUP;
 
 static void ensure_config_read(void)
 {
@@ -81,6 +84,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 {
 	struct ls_refs_data *data = cb_data;
 	const char *refname_nons = strip_namespace(refname);
+	const char *refname_to_filter = refname_nons;
 
 	strbuf_reset(&data->buf);
 
@@ -90,6 +94,16 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	if (!ref_match(&data->prefixes, refname_nons))
 		return 0;
 
+	if (!strcmp(refname_nons, "HEAD")) {
+		struct string_list_item *item = string_list_lookup(&symref, "HEAD");
+		if (item) {
+			refname_to_filter = (const char *)item->util;
+		}
+	}
+
+	if (filter_advertise_ref(refname_to_filter, oid))
+		return 0;
+
 	if (oid)
 		strbuf_addf(&data->buf, "%s %s", oid_to_hex(oid), refname_nons);
 	else
@@ -121,18 +135,24 @@ static int send_ref(const char *refname, const struct object_id *oid,
 
 static void send_possibly_unborn_head(struct ls_refs_data *data)
 {
+	const char *symref_target;
+	struct string_list_item *item;
 	struct strbuf namespaced = STRBUF_INIT;
 	struct object_id oid;
 	int flag;
 	int oid_is_null;
 
 	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
-	if (!resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag))
+	symref_target = resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag);
+	if (!symref_target)
 		return; /* bad ref */
 	oid_is_null = is_null_oid(&oid);
 	if (!oid_is_null ||
-	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF)))
+	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF))) {
+		item = string_list_append(&symref, "HEAD");
+		item->util = xstrdup(strip_namespace(symref_target));
 		send_ref(namespaced.buf, oid_is_null ? NULL : &oid, flag, data);
+	}
 	strbuf_release(&namespaced);
 }
 
@@ -146,6 +166,10 @@ static int ls_refs_config(const char *var, const char *value, void *data)
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
+static void clean_refs_advertise_filter(void) {
+	clean_advertise_refs_filter();
+}
+
 int ls_refs(struct repository *r, struct packet_reader *request)
 {
 	struct ls_refs_data data;
@@ -156,6 +180,8 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 
 	ensure_config_read();
 	git_config(ls_refs_config, NULL);
+	create_advertise_refs_filter("ls-refs");
+	atexit(clean_refs_advertise_filter);
 
 	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
 		const char *arg = request->line;
diff --git a/refs/refs-advertise.c b/refs/refs-advertise.c
new file mode 100644
index 00000000000..0dcced78716
--- /dev/null
+++ b/refs/refs-advertise.c
@@ -0,0 +1,246 @@
+#include "../cache.h"
+#include "../config.h"
+#include "../strbuf.h"
+#include "../hook.h"
+#include "../sigchain.h"
+#include "../pkt-line.h"
+#include "../refs.h"
+#include "../run-command.h"
+#include "connect.h"
+#include "ref-cache.h"
+#include "refs-advertise.h"
+
+struct advertise_refs_filter {
+	struct child_process proc;
+	struct packet_reader reader;
+};
+
+static struct advertise_refs_filter *hook_filter = NULL;
+
+void create_advertise_refs_filter(const char *command) {
+	struct advertise_refs_filter *filter;
+	struct child_process *proc;
+	struct packet_reader *reader;
+	const char *hook_path;
+	int command_support = 0;
+	int version = 0;
+	int code;
+
+	if (hook_filter != NULL)
+		return;
+
+	hook_path = find_hook("refs-advertise");
+	if (!hook_path) {
+		return;
+	}
+
+	filter = (struct advertise_refs_filter *) xcalloc (1, sizeof (struct advertise_refs_filter));
+	proc = &filter->proc;
+	reader = &filter->reader;
+
+	child_process_init(proc);
+	strvec_push(&proc->args, hook_path);
+	proc->in = -1;
+	proc->out = -1;
+	proc->trace2_hook_name = "refs-advertise";
+	proc->err = 0;
+
+	code = start_command(proc);
+	if (code)
+		die("can not run hook refs-advertise");
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	/* Version negotiaton */
+	packet_reader_init(reader, proc->out, NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_GENTLE_ON_EOF);
+	code = packet_write_fmt_gently(proc->in, "version=1%c%s", '\0', command);
+	if (!code)
+		code = packet_flush_gently(proc->in);
+
+	if (!code)
+		for (;;) {
+			int linelen;
+			enum packet_read_status status;
+
+			status = packet_reader_read(reader);
+			if (status != PACKET_READ_NORMAL) {
+				/* Check whether refs-advertise exited abnormally */
+				if (status == PACKET_READ_EOF)
+					die("can not read version message from hook refs-advertise");
+				break;
+			}
+
+			if (reader->pktlen > 8 && starts_with(reader->line, "version=")) {
+				version = atoi(reader->line + 8);
+				linelen = strlen(reader->line);
+				if (linelen < reader->pktlen) {
+					const char *command_list = reader->line + linelen + 1;
+					if (parse_feature_request(command_list, command)) {
+						command_support = 1;
+					}
+				}
+			}
+		}
+
+	if (code)
+		die("can not read version message from hook refs-advertise");
+
+	switch (version) {
+	case 0:
+		/* fallthrough */
+	case 1:
+		break;
+	default:
+		die(_("hook refs-advertise version '%d' is not supported"), version);
+	}
+
+	sigchain_pop(SIGPIPE);
+
+	if (!command_support) {
+		close(proc->in);
+		close(proc->out);
+		kill(proc->pid, SIGTERM);
+		finish_command_in_signal(proc);
+		free(filter);
+
+		return;
+	}
+
+	hook_filter = filter;
+	return;
+}
+
+void clean_advertise_refs_filter(void) {
+	struct child_process *proc;
+
+	if (!hook_filter) {
+		return;
+	}
+
+	proc = &hook_filter->proc;
+
+	close(proc->in);
+	close(proc->out);
+	kill(proc->pid, SIGTERM);
+	finish_command_in_signal(proc);
+	FREE_AND_NULL(hook_filter);
+}
+
+static int do_filter_advertise_ref(const char *refname, const struct object_id *oid) {
+	struct child_process *proc;
+	struct packet_reader *reader;
+	struct strbuf buf = STRBUF_INIT;
+	char *oid_hex;
+	int code;
+
+	proc = &hook_filter->proc;
+	reader = &hook_filter->reader;
+	if (oid)
+		oid_hex = oid_to_hex(oid);
+	else
+		oid_hex = oid_to_hex(null_oid());
+
+	code = packet_write_fmt_gently(proc->in, "ref %s %s", refname, oid_hex);
+	if (code)
+		die("hook refs-advertise died abnormally");
+
+	code = packet_flush_gently(proc->in);
+	if (code)
+		die("hook refs-advertise died abnormally");
+
+	for (;;) {
+		enum packet_read_status status;
+
+		status = packet_reader_read(reader);
+		if (status != PACKET_READ_NORMAL) {
+			/* Check whether refs-advertise exited abnormally */
+			if (status == PACKET_READ_EOF)
+				die("hook refs-advertise died abnormally");
+			break;
+		}
+
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, reader->line);
+	}
+
+	if (strncmp("ok ref ", buf.buf, 7))
+		return -1;
+
+	if (strcmp(refname, buf.buf + 7))
+		return -1;
+
+	return 0;
+}
+
+int filter_advertise_ref(const char *refname, const struct object_id *oid) {
+	int result;
+
+	if (!hook_filter) {
+		return 0;
+	}
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+	result = do_filter_advertise_ref(refname, oid);
+	sigchain_pop(SIGPIPE);
+
+	return result;
+}
+
+static int do_filter_advertise_object(const struct object_id *oid) {
+	struct child_process *proc;
+	struct packet_reader *reader;
+	struct strbuf buf = STRBUF_INIT;
+	char *oid_hex;
+	int code;
+
+	proc = &hook_filter->proc;
+	reader = &hook_filter->reader;
+	oid_hex = oid_to_hex(oid);
+
+	code = packet_write_fmt_gently(proc->in, "obj %s", oid_hex);
+	if (code)
+		die("hook refs-advertise died abnormally");
+
+	code = packet_flush_gently(proc->in);
+	if (code)
+		die("hook refs-advertise died abnormally");
+
+	for (;;) {
+		enum packet_read_status status;
+
+		status = packet_reader_read(reader);
+		if (status != PACKET_READ_NORMAL) {
+			/* Check whether refs-advertise exited abnormally */
+			if (status == PACKET_READ_EOF)
+				die("hook refs-advertise died abnormally");
+			break;
+		}
+
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, reader->line);
+	}
+
+	if (strncmp("ok obj ", buf.buf, 7))
+		return -1;
+
+	if (strcmp(oid_hex, buf.buf + 7))
+		return -1;
+
+	return 0;
+}
+
+int filter_advertise_object(const struct object_id *oid) {
+	int result;
+
+	if (!hook_filter || !oid) {
+		return 0;
+	}
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+	result = do_filter_advertise_object(oid);
+	sigchain_pop(SIGPIPE);
+
+	return result;
+}
diff --git a/refs/refs-advertise.h b/refs/refs-advertise.h
new file mode 100644
index 00000000000..615469eaddb
--- /dev/null
+++ b/refs/refs-advertise.h
@@ -0,0 +1,11 @@
+#ifndef REFS_REFS_ADVERTISE_H
+#define REFS_REFS_ADVERTISE_H
+
+#include "../hash.h"
+
+void create_advertise_refs_filter(const char *command);
+void clean_advertise_refs_filter(void);
+int filter_advertise_ref(const char *refname, const struct object_id *oid);
+int filter_advertise_object(const struct object_id *oid);
+
+#endif
diff --git a/t/helper/test-refs-advertise.c b/t/helper/test-refs-advertise.c
new file mode 100644
index 00000000000..c6bcf4e681f
--- /dev/null
+++ b/t/helper/test-refs-advertise.c
@@ -0,0 +1,202 @@
+#include "cache.h"
+#include "hash.h"
+#include "config.h"
+#include "connect.h"
+#include "parse-options.h"
+#include "pkt-line.h"
+#include "sigchain.h"
+#include "test-tool.h"
+
+static const char *refs_advertise_usage[] = {
+	"test-tool refs-advertise [<options>...]",
+	NULL
+};
+
+static int can_upload_pack;
+static int can_receive_pack;
+static int can_ls_refs;
+static int die_read_version;
+static int die_write_version;
+static int die_read_first_ref;
+static int die_read_second_ref;
+static int die_filter_refs;
+static int upload_pack;
+static int receive_pack;
+static int ls_refs;
+static int verbose;
+static int version = 1;
+static int first_ref;
+static int second_ref;
+static int hash_size = GIT_SHA1_HEXSZ;
+static struct string_list returns = STRING_LIST_INIT_NODUP;
+
+struct command {
+	struct command *next;
+	const char *error_string;
+	unsigned int skip_update:1,
+		     did_not_exist:1;
+	int index;
+	struct object_id old_oid;
+	struct object_id new_oid;
+	char ref_name[FLEX_ARRAY]; /* more */
+};
+
+static void refs_advertise_verison(struct packet_reader *reader) {
+	int server_version = 0;
+
+	if (die_read_version)
+		die("die with the --die-read-version option");
+
+	for (;;) {
+		int linelen;
+
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
+			break;
+
+		/* Ignore version negotiation for version 0 */
+		if (version == 0)
+			continue;
+
+		if (reader->pktlen > 8 && starts_with(reader->line, "version=")) {
+			server_version = atoi(reader->line+8);
+			if (server_version != 1)
+				die("bad protocol version: %d", server_version);
+			linelen = strlen(reader->line);
+			if (linelen < reader->pktlen) {
+				const char *feature_list = reader->line + linelen + 1;
+				if (parse_feature_request(feature_list, "git-upload-pack"))
+					upload_pack = 1;
+				if (parse_feature_request(feature_list, "git-receive-pack"))
+					receive_pack = 1;
+				if (parse_feature_request(feature_list, "ls-refs"))
+					ls_refs = 1;
+			}
+		}
+	}
+
+	if (die_write_version)
+		die("die with the --die-write-version option");
+
+	if (can_upload_pack || can_receive_pack || can_ls_refs)
+		packet_write_fmt(1, "version=%d%c%s%s%s\n",
+				version, '\0',
+				can_upload_pack ? "git-upload-pack ": "",
+				can_receive_pack? "git-receive-pack ": "",
+				can_ls_refs? "ls-refs ": "");
+	else
+		packet_write_fmt(1, "version=%d\n", version);
+
+	packet_flush(1);
+
+	if ((upload_pack && !can_upload_pack) ||
+		(receive_pack && !can_receive_pack) ||
+		(ls_refs && !can_ls_refs)) {
+			exit(0);
+	}
+}
+
+static void refs_advertise_read_refs(struct packet_reader *reader)
+{
+	const char *p;
+	struct strbuf buf = STRBUF_INIT;
+	enum packet_read_status status;
+	int filter_ok = 0;
+
+	if (!first_ref) {
+		if (die_read_first_ref)
+			die("die with the --die-read-first-ref option");
+
+		first_ref = 1;
+	}
+
+	if (first_ref && !second_ref) {
+		if (die_read_second_ref)
+			die("die with the --die-read-second-ref option");
+
+		second_ref = 1;
+	}
+
+	for (;;) {
+		status = packet_reader_read(reader);
+		if (status == PACKET_READ_EOF)
+			exit(0);
+
+		if (status != PACKET_READ_NORMAL)
+			break;
+
+		p = reader->line;
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, reader->line);
+	}
+
+	p = buf.buf;
+
+	if (unsorted_string_list_has_string(&returns, p)) {
+		filter_ok = 1;
+	}
+
+	// if it's a ref filter request, we response without the commit id
+	if ((buf.len > (hash_size + 1)) && (strncmp("obj ", buf.buf, 4)))
+		strbuf_setlen(&buf, buf.len - (hash_size + 1));
+
+	if (filter_ok) {
+		packet_write_fmt(1, "%s %s\n", "ok", p);
+	} else {
+		packet_write_fmt(1, "%s %s\n", "ng", p);
+	}
+
+	if (die_filter_refs)
+		die("die with the --die-filter-refs option");
+
+	packet_flush(1);
+}
+
+int cmd__refs_advertise(int argc, const char **argv) {
+	int nongit_ok = 0;
+	struct packet_reader reader;
+	const char *value = NULL;
+	struct option options[] = {
+		OPT_BOOL(0, "can-upload-pack", &can_upload_pack,
+			 "support upload-pack command"),
+		OPT_BOOL(0, "can-receive-pack", &can_receive_pack,
+			 "support upload-pack command"),
+		OPT_BOOL(0, "can-ls-refs", &can_ls_refs,
+			 "support ls-refs command"),
+		OPT_BOOL(0, "die-read-version", &die_read_version,
+			 "die when reading version"),
+		OPT_BOOL(0, "die-write-version", &die_write_version,
+			 "die when writing version"),
+		OPT_BOOL(0, "die-read-first-ref", &die_read_first_ref,
+			 "die when reading first reference"),
+		OPT_BOOL(0, "die-read-second-ref", &die_read_second_ref,
+			 "die when reading second reference"),
+		OPT_BOOL(0, "die-filter-refs", &die_filter_refs,
+			 "die when filtering refs"),
+		OPT_STRING_LIST('r', "return", &returns, "ref<SP>$refname<SP>$oid|obj<SP>$oid",
+				"refs or objects that can advertise"),
+		OPT__VERBOSE(&verbose, "be verbose"),
+		OPT_INTEGER('V', "version", &version,
+			    "use this protocol version number"),
+		OPT_END()
+	};
+
+	setup_git_directory_gently(&nongit_ok);
+
+	argc = parse_options(argc, argv, "test-tools", options, refs_advertise_usage, 0);
+	if (argc > 0)
+		usage_msg_opt("Too many arguments.", refs_advertise_usage, options);
+
+	packet_reader_init(&reader, 0, NULL, 0, PACKET_READ_CHOMP_NEWLINE | PACKET_READ_GENTLE_ON_EOF);
+
+	if (!git_config_get_value("extensions.objectformat", &value)) {
+		if (!strcmp(value, "sha256"))
+			hash_size = GIT_SHA256_HEXSZ;
+	}
+
+	refs_advertise_verison(&reader);
+	for (;;) {
+		refs_advertise_read_refs(&reader);
+	}
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 318fdbab0c3..10795e4eed6 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -69,6 +69,7 @@ static struct test_cmd cmds[] = {
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
+	{ "refs-advertise", cmd__refs_advertise },
 	{ "run-command", cmd__run_command },
 	{ "scrap-cache-tree", cmd__scrap_cache_tree },
 	{ "serve-v2", cmd__serve_v2 },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index bb799271631..8f651e5cf9e 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -58,6 +58,7 @@ int cmd__reftable(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
 int cmd__repository(int argc, const char **argv);
 int cmd__revision_walking(int argc, const char **argv);
+int cmd__refs_advertise(int argc, const char **argv);
 int cmd__run_command(int argc, const char **argv);
 int cmd__scrap_cache_tree(int argc, const char **argv);
 int cmd__serve_v2(int argc, const char **argv);
diff --git a/upload-pack.c b/upload-pack.c
index 09f48317b02..86714986d5f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -27,6 +27,7 @@
 #include "commit-graph.h"
 #include "commit-reach.h"
 #include "shallow.h"
+#include "refs/refs-advertise.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -1118,7 +1119,7 @@ static void receive_needs(struct upload_pack_data *data,
 		}
 
 		o = parse_object(the_repository, &oid_buf);
-		if (!o) {
+		if ((!o) || (filter_advertise_object(&oid_buf))) {
 			packet_writer_error(&data->writer,
 					    "upload-pack: not our ref %s",
 					    oid_to_hex(&oid_buf));
@@ -1164,6 +1165,12 @@ static int mark_our_ref(const char *refname, const char *refname_full,
 		o->flags |= HIDDEN_REF;
 		return 1;
 	}
+
+	if (filter_advertise_ref(refname, oid)) {
+		o->flags |= HIDDEN_REF;
+		return 1;
+	}
+
 	o->flags |= OUR_REF;
 	return 0;
 }
@@ -1183,8 +1190,10 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
 
 	if (!symref->nr)
 		return;
-	for_each_string_list_item(item, symref)
-		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
+	for_each_string_list_item(item, symref) {
+		if (!filter_advertise_ref((char *)item->util, NULL))
+			strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
+	}
 }
 
 static void format_session_id(struct strbuf *buf, struct upload_pack_data *d) {
@@ -1198,11 +1207,19 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow deepen-since deepen-not"
 		" deepen-relative no-progress include-tag multi_ack_detailed";
-	const char *refname_nons = strip_namespace(refname);
 	struct object_id peeled;
 	struct upload_pack_data *data = cb_data;
+	const char *refname_nons = strip_namespace(refname);
+	const char *refname_to_filter = refname_nons;
 
-	if (mark_our_ref(refname_nons, refname, oid))
+	if (!strcmp(refname_nons, "HEAD")) {
+		struct string_list_item *item = string_list_lookup(&data->symref, "HEAD");
+		if (item) {
+			refname_to_filter = (const char *)item->util;
+		}
+	}
+
+	if (mark_our_ref(refname_to_filter, refname, oid))
 		return 0;
 
 	if (capabilities) {
@@ -1342,12 +1359,19 @@ static void get_upload_pack_config(struct upload_pack_data *data)
 	git_protected_config(upload_pack_protected_config, data);
 }
 
+static void clean_refs_advertise_filter(void) {
+	clean_advertise_refs_filter();
+}
+
 void upload_pack(const int advertise_refs, const int stateless_rpc,
 		 const int timeout)
 {
 	struct packet_reader reader;
 	struct upload_pack_data data;
 
+	create_advertise_refs_filter("git-upload-pack");
+	atexit(clean_refs_advertise_filter);
+
 	upload_pack_data_init(&data);
 	get_upload_pack_config(&data);
 
@@ -1421,7 +1445,7 @@ static int parse_want(struct packet_writer *writer, const char *line,
 		else
 			o = parse_object(the_repository, &oid);
 
-		if (!o) {
+		if ((!o) || (filter_advertise_object(&oid))) {
 			packet_writer_error(writer,
 					    "upload-pack: not our ref %s",
 					    oid_to_hex(&oid));
@@ -1453,7 +1477,8 @@ static int parse_want_ref(struct packet_writer *writer, const char *line,
 
 		strbuf_addf(&refname, "%s%s", get_git_namespace(), refname_nons);
 		if (ref_is_hidden(refname_nons, refname.buf) ||
-		    read_ref(refname.buf, &oid)) {
+		    read_ref(refname.buf, &oid) ||
+			filter_advertise_ref(refname_nons, &oid)) {
 			packet_writer_error(writer, "unknown ref %s", refname_nons);
 			die("unknown ref %s", refname_nons);
 		}
@@ -1701,6 +1726,9 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
 
 	clear_object_flags(ALL_FLAGS);
 
+	create_advertise_refs_filter("git-upload-pack");
+	atexit(clean_refs_advertise_filter);
+
 	upload_pack_data_init(&data);
 	data.use_sideband = LARGE_PACKET_MAX;
 	get_upload_pack_config(&data);
-- 
gitgitgadget

