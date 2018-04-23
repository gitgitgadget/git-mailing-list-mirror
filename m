Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34511F424
	for <e@80x24.org>; Mon, 23 Apr 2018 22:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932569AbeDWWqj (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 18:46:39 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:40596 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932565AbeDWWqh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 18:46:37 -0400
Received: by mail-qt0-f201.google.com with SMTP id t24-v6so11164793qtn.7
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Twt6ypFhWt3+1Gh41O14P4tytCSkdlNR5DJE9/QKWFc=;
        b=Nwl/PllpPOj7vvkfYB+NBRYNYD7y0Bc+h1W92sA+tO3DgESuZww6L2pzxYSYPBU1w+
         K11ZJF08Pyyfe9xWdHjYETVKZEkNwCe5fpsjKu0+QlJho/q+q+tJUvOKguBg+bpkugGq
         fuc012tqmnSgFSZXJN8d/q5SP7ArFftEaZY8dHvAkyRxwZdeRIEHeaCej2pve2yXLqpt
         TMRXXKTMaOVY4b3TXX7MCC7AK/3SoQ7H5FMReWntvBK9wah7kTjWhRY4c+E61ooAXbZB
         YY2tCpyE5Lx9J5wgm5KfK936E1njtl4h2dcp+0nG1LzNLRSWZDMWwSWpthHDL0H8wnGA
         iMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Twt6ypFhWt3+1Gh41O14P4tytCSkdlNR5DJE9/QKWFc=;
        b=l16e7cFCvQAVvmk1ZwWAMDbqWzi5A2JmS9dmdb97PmZbp2naGpusLDLnQbn/QzObAQ
         K2Uv92Wfo2+nxJBFVOvnnZ7mNd1qvcTp7t4ocRqr2u13jIpBleAH1SOCTK+TTP6bLBBU
         zMG5wwRtj+uujOw0ctKRG9jpnGv5qq0sTr2blxLWpz9mL8HPn3lvuSFPeDF+dnC8dfzw
         NKCddkudxDQRcJs31E3c/sgU73ewjeigTOg87D3zEbX9kW0JMkPITjv6/Vf7UOJeNzbm
         qE4yHOXeYmXuedX6TO138BEW9qZ9rGGeDQ2KViSSOr4R1RtE2gz/klfBOg7+Fl0u6A/1
         d/KA==
X-Gm-Message-State: ALQs6tDvwAB7Ro87HMj/PxDL7AXokS9m6jSl9rO8UOYhOkPAbTWtqFCo
        d8OeutSDHiP95+SFs047a9AHavzEAPyrQoRij2k/bYUW7oi2RVHq71pFsjaDtg4G7/tE48g2ouD
        aWlkUJHyLQqqmzg/msS9tg4qshp0c+VzIBRtYGE9+hYvqzmrbTD8O8mj3dA==
X-Google-Smtp-Source: AB8JxZrXM4+JeYjuhpf3aAcPase39ABRW4XpHmEIm+s+Sbtc9q4ZLa/mE2eYlZDGylqIkvbmWWApMEePs98=
MIME-Version: 1.0
X-Received: by 2002:ac8:7246:: with SMTP id l6-v6mr10664003qtp.53.1524523596137;
 Mon, 23 Apr 2018 15:46:36 -0700 (PDT)
Date:   Mon, 23 Apr 2018 15:46:23 -0700
In-Reply-To: <20180423224624.213341-1-bmwill@google.com>
Message-Id: <20180423224624.213341-3-bmwill@google.com>
References: <20180423224624.213341-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH 2/3] ls-remote: send server options when using protocol v2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach ls-remote to optionally accept server options by specifying them
on the cmdline via '-o' or '--server-option'.  These server options are
sent to the remote end when querying for the remote end's refs using
protocol version 2.

If communicating using a protocol other than v2 the provided options are
ignored and not sent to the remote end.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-ls-remote.txt |  8 ++++++++
 builtin/ls-remote.c             |  4 ++++
 connect.c                       |  9 ++++++++-
 remote.h                        |  4 +++-
 t/t5702-protocol-v2.sh          | 16 ++++++++++++++++
 transport.c                     |  2 +-
 transport.h                     |  6 ++++++
 7 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 5f2628c8f..e5defb1b2 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -60,6 +60,14 @@ OPTIONS
 	upload-pack only shows the symref HEAD, so it will be the only
 	one shown by ls-remote.
 
+-o <option>::
+--server-option=<option>::
+	Transmit the given string to the server when communicating using
+	protocol version 2.  The given string must not contain a NUL or LF
+	character.
+	When multiple `--server-option=<option>` are given, they are all
+	sent to the other side in the order listed on the command line.
+
 <repository>::
 	The "remote" repository to query.  This parameter can be
 	either a URL or the name of a remote (see the GIT URLS and
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 380c18027..3150bfb92 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -45,6 +45,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	const char *uploadpack = NULL;
 	const char **pattern = NULL;
 	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
+	struct string_list server_options = STRING_LIST_INIT_DUP;
 
 	struct remote *remote;
 	struct transport *transport;
@@ -67,6 +68,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			      2, PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "symref", &show_symref_target,
 			 N_("show underlying ref in addition to the object pointed by it")),
+		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
 		OPT_END()
 	};
 
@@ -107,6 +109,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	transport = transport_get(remote, NULL);
 	if (uploadpack != NULL)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
+	if (server_options.nr)
+		transport->server_options = &server_options;
 
 	ref = transport_get_remote_refs(transport, &ref_prefixes);
 	if (transport_disconnect(transport))
diff --git a/connect.c b/connect.c
index 54971166a..3000768c7 100644
--- a/connect.c
+++ b/connect.c
@@ -408,7 +408,8 @@ static int process_ref_v2(const char *line, struct ref ***list)
 
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
-			     const struct argv_array *ref_prefixes)
+			     const struct argv_array *ref_prefixes,
+			     const struct string_list *server_options)
 {
 	int i;
 	*list = NULL;
@@ -419,6 +420,12 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	if (server_supports_v2("agent", 0))
 		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
 
+	if (server_options && server_options->nr &&
+	    server_supports_v2("server-option", 1))
+		for (i = 0; i < server_options->nr; i++)
+			packet_write_fmt(fd_out, "server-option=%s",
+					 server_options->items[i].string);
+
 	packet_delim(fd_out);
 	/* When pushing we don't want to request the peeled tags */
 	if (!for_push)
diff --git a/remote.h b/remote.h
index 2b3180f94..93dd97e25 100644
--- a/remote.h
+++ b/remote.h
@@ -153,6 +153,7 @@ void free_refs(struct ref *ref);
 struct oid_array;
 struct packet_reader;
 struct argv_array;
+struct string_list;
 extern struct ref **get_remote_heads(struct packet_reader *reader,
 				     struct ref **list, unsigned int flags,
 				     struct oid_array *extra_have,
@@ -161,7 +162,8 @@ extern struct ref **get_remote_heads(struct packet_reader *reader,
 /* Used for protocol v2 in order to retrieve refs from a remote */
 extern struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 				    struct ref **list, int for_push,
-				    const struct argv_array *ref_prefixes);
+				    const struct argv_array *ref_prefixes,
+				    const struct string_list *server_options);
 
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 56f7c3c32..71ef1aee1 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -154,6 +154,22 @@ test_expect_success 'ref advertisment is filtered with ls-remote using protocol
 	test_cmp actual expect
 '
 
+test_expect_success 'server-options are sent when using ls-remote' '
+	test_when_finished "rm -f log" &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
+		ls-remote -o hello -o world "file://$(pwd)/file_parent" master >actual &&
+
+	cat >expect <<-EOF &&
+	$(git -C file_parent rev-parse refs/heads/master)$(printf "\t")refs/heads/master
+	EOF
+
+	test_cmp actual expect &&
+	grep "server-option=hello" log &&
+	grep "server-option=world" log
+'
+
+
 test_expect_success 'clone with file:// using protocol v2' '
 	test_when_finished "rm -f log" &&
 
diff --git a/transport.c b/transport.c
index 4d8beaaab..42fd468f3 100644
--- a/transport.c
+++ b/transport.c
@@ -218,7 +218,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	switch (data->version) {
 	case protocol_v2:
 		get_remote_refs(data->fd[1], &reader, &refs, for_push,
-				ref_prefixes);
+				ref_prefixes, transport->server_options);
 		break;
 	case protocol_v1:
 	case protocol_v0:
diff --git a/transport.h b/transport.h
index e783cfa07..73a7be3c8 100644
--- a/transport.h
+++ b/transport.h
@@ -71,6 +71,12 @@ struct transport {
 	 */
 	const struct string_list *push_options;
 
+	/*
+	 * These strings will be passed to the remote side on each command
+	 * request, if both sides support the server-option capability.
+	 */
+	const struct string_list *server_options;
+
 	char *pack_lockfile;
 	signed verbose : 3;
 	/**
-- 
2.17.0.484.g0c8726318c-goog

