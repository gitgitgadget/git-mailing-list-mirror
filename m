Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A97C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 15:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbiLVPOq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiLVPOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 10:14:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488B611A08
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:24 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i82-20020a1c3b55000000b003d1e906ca23so1422798wma.3
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqYBa7AYck1KXjiGuWcjJXZHxBlNJrFfsuzq+UJ+C08=;
        b=dfhC0cd6MjtqS7eKkGn0cctp6IeAx0nBfIeNIA1p+bUwT5zlS+kn852Gz9WwA1lgN0
         DgN7urNwe6SAeNN3wvtsaZgpZbbhijkN3CB0teNtFhXjmssJ8T8PVFM811qKyPul3nMD
         BlDCt+D/qCSH2P+OgBcLSe6F+MXfLdpmmOm9fT7J9kuWHi+XtN7wl+fOgW/QDPMIFLsO
         1dJWi5znVO+M6ltI42mWRRZYxF1y9No6+W4eBArn4CtVIAUuJZQvM+tVQ74sjBXnYaBg
         45jSw950TIjYPI0TrUp6w1H4tYiXoFNDYSPuoRta6OcyDaoV6py7+RHMTDbiSQWkHwt4
         uVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqYBa7AYck1KXjiGuWcjJXZHxBlNJrFfsuzq+UJ+C08=;
        b=58OMYesEJWanJ99oPjtNVNXBr5Zch8CjF7PSB8yUM4zNgvOUuKkwaHmS1geL4+9OAG
         tYKz74QGgIkd2zI3YiUDKbvEof9ZGkAs5SXmNo7s0uQaVnOCEJLzHf3jD2K1n8mdhL6f
         su7vXDyDgYO4QYdn+HlQmJn8/Y9bGIP08WLhMYbrRDhOHZRxPtoBwFeDsYu9J0sVLFv5
         Wrs6zOMC857RAUumTaJ/hc3W9Ef476wVllx4a76qEHqYyXCMzmPyFl2ngj5o7Hk2RvZR
         NGRRxrTyWYSRN4XAvFlKplmO2aBBKRZ3vaiP+yf594M9W3zkS1bIvYzDxAuW8Uh8Q4PI
         9kEw==
X-Gm-Message-State: AFqh2koALBlORta+hHut2jPi1y8OLE64rWL5qWjdrYVMBOx1xtQk555O
        lUz2DB5njBeTOtEHMpI5xw7o94dA4Fo=
X-Google-Smtp-Source: AMrXdXvQrltfKfcIlXGOQHFMOr+WGSwbGdPhXZU8BGkBDU4GvqfLmGPwYfog+zlx3VzgEJ8m/4sI+g==
X-Received: by 2002:a05:600c:22d9:b0:3d3:56e6:4f0d with SMTP id 25-20020a05600c22d900b003d356e64f0dmr4563669wmg.7.1671722062613;
        Thu, 22 Dec 2022 07:14:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h6-20020adffa86000000b0024246991121sm782777wrr.116.2022.12.22.07.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 07:14:22 -0800 (PST)
Message-Id: <5bf6fe55771a5687d711c59cf0460baa087603a3.1671722058.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
References: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
        <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 15:14:09 +0000
Subject: [PATCH v4 03/11] clone: request the 'bundle-uri' command when
 available
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

Set up all the needed client parts of the 'bundle-uri' protocol v2
command, without actually doing anything with the bundle URIs.

If the server says it supports 'bundle-uri' teach Git to issue the
'bundle-uri' command after the 'ls-refs' during 'git clone'. The
returned key=value pairs are passed to the bundle list code which is
tested using a different ingest mechanism in t5750-bundle-uri-parse.sh.

At this point, Git does nothing with that bundle list. It will not
download any of the bundles. That will come in a later change after
these protocol bits are finalized.

The no-op client is initially used only by 'git clone' to test the basic
functionality, and eventually will bootstrap the initial download of Git
objects during a fresh clone. The bundle URI client will not be
integrated into other fetches until a mechanism is created to select a
subset of bundles for download.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/clone.c              |  6 +++++
 connect.c                    | 44 +++++++++++++++++++++++++++++++
 remote.h                     |  5 ++++
 t/lib-bundle-uri-protocol.sh | 19 ++++++++++++++
 transport-helper.c           | 13 +++++++++
 transport-internal.h         |  7 +++++
 transport.c                  | 51 ++++++++++++++++++++++++++++++++++++
 transport.h                  | 19 ++++++++++++++
 8 files changed, 164 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 547d6464b3c..39364c25b15 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1266,6 +1266,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (refs)
 		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
 
+	/*
+	 * Populate transport->got_remote_bundle_uri and
+	 * transport->bundle_uri. We might get nothing.
+	 */
+	transport_get_remote_bundle_uri(transport);
+
 	if (mapped_refs) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 
diff --git a/connect.c b/connect.c
index 5ea53deda23..624a10f18ee 100644
--- a/connect.c
+++ b/connect.c
@@ -15,6 +15,7 @@
 #include "version.h"
 #include "protocol.h"
 #include "alias.h"
+#include "bundle-uri.h"
 
 static char *server_capabilities_v1;
 static struct strvec server_capabilities_v2 = STRVEC_INIT;
@@ -491,6 +492,49 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 	}
 }
 
+int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
+			  struct bundle_list *bundles, int stateless_rpc)
+{
+	int line_nr = 1;
+
+	/* Assert bundle-uri support */
+	server_supports_v2("bundle-uri", 1);
+
+	/* (Re-)send capabilities */
+	send_capabilities(fd_out, reader);
+
+	/* Send command */
+	packet_write_fmt(fd_out, "command=bundle-uri\n");
+	packet_delim(fd_out);
+
+	packet_flush(fd_out);
+
+	/* Process response from server */
+	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
+		const char *line = reader->line;
+		line_nr++;
+
+		if (!bundle_uri_parse_line(bundles, line))
+			continue;
+
+		return error(_("error on bundle-uri response line %d: %s"),
+			     line_nr, line);
+	}
+
+	if (reader->status != PACKET_READ_FLUSH)
+		return error(_("expected flush after bundle-uri listing"));
+
+	/*
+	 * Might die(), but obscure enough that that's OK, e.g. in
+	 * serve.c we'll call BUG() on its equivalent (the
+	 * PACKET_READ_RESPONSE_END check).
+	 */
+	check_stateless_delimiter(stateless_rpc, reader,
+				  _("expected response end packet after ref listing"));
+
+	return 0;
+}
+
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
 			     struct transport_ls_refs_options *transport_options,
diff --git a/remote.h b/remote.h
index 1c4621b414b..1ebbe42792e 100644
--- a/remote.h
+++ b/remote.h
@@ -234,6 +234,11 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     const struct string_list *server_options,
 			     int stateless_rpc);
 
+/* Used for protocol v2 in order to retrieve refs from a remote */
+struct bundle_list;
+int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
+			  struct bundle_list *bundles, int stateless_rpc);
+
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 
 /*
diff --git a/t/lib-bundle-uri-protocol.sh b/t/lib-bundle-uri-protocol.sh
index 2da22a39cb8..d44c6e10f9e 100644
--- a/t/lib-bundle-uri-protocol.sh
+++ b/t/lib-bundle-uri-protocol.sh
@@ -83,3 +83,22 @@ test_expect_success "connect with $BUNDLE_URI_PROTOCOL:// using protocol v2: hav
 	# Server advertised bundle-uri capability
 	grep "< bundle-uri" log
 '
+
+test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: request bundle-uris" '
+	test_when_finished "rm -rf log cloned" &&
+
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		clone "$BUNDLE_URI_REPO_URI" cloned \
+		>actual 2>err &&
+
+	# Server responded using protocol v2
+	grep "< version 2" log &&
+
+	# Server advertised bundle-uri capability
+	grep "< bundle-uri" log &&
+
+	# Client issued bundle-uri command
+	grep "> command=bundle-uri" log
+'
diff --git a/transport-helper.c b/transport-helper.c
index e95267a4ab5..3ea7c2bb5ad 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1267,9 +1267,22 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 	return ret;
 }
 
+static int get_bundle_uri(struct transport *transport)
+{
+	get_helper(transport);
+
+	if (process_connect(transport, 0)) {
+		do_take_over(transport);
+		return transport->vtable->get_bundle_uri(transport);
+	}
+
+	return -1;
+}
+
 static struct transport_vtable vtable = {
 	.set_option	= set_helper_option,
 	.get_refs_list	= get_refs_list,
+	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs,
 	.push_refs	= push_refs,
 	.connect	= connect_helper,
diff --git a/transport-internal.h b/transport-internal.h
index c4ca0b733ac..90ea749e5cf 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -26,6 +26,13 @@ struct transport_vtable {
 	struct ref *(*get_refs_list)(struct transport *transport, int for_push,
 				     struct transport_ls_refs_options *transport_options);
 
+	/**
+	 * Populates the remote side's bundle-uri under protocol v2,
+	 * if the "bundle-uri" capability was advertised. Returns 0 if
+	 * OK, negative values on error.
+	 */
+	int (*get_bundle_uri)(struct transport *transport);
+
 	/**
 	 * Fetch the objects for the given refs. Note that this gets
 	 * an array, and should ignore the list structure.
diff --git a/transport.c b/transport.c
index e7b97194c10..b6f279e92cb 100644
--- a/transport.c
+++ b/transport.c
@@ -22,6 +22,7 @@
 #include "protocol.h"
 #include "object-store.h"
 #include "color.h"
+#include "bundle-uri.h"
 
 static int transport_use_color = -1;
 static char transport_colors[][COLOR_MAXLEN] = {
@@ -359,6 +360,32 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	return handshake(transport, for_push, options, 1);
 }
 
+static int get_bundle_uri(struct transport *transport)
+{
+	struct git_transport_data *data = transport->data;
+	struct packet_reader reader;
+	int stateless_rpc = transport->stateless_rpc;
+
+	if (!transport->bundles) {
+		CALLOC_ARRAY(transport->bundles, 1);
+		init_bundle_list(transport->bundles);
+	}
+
+	/*
+	 * "Support" protocol v0 and v2 without bundle-uri support by
+	 * silently degrading to a NOOP.
+	 */
+	if (!server_supports_v2("bundle-uri", 0))
+		return 0;
+
+	packet_reader_init(&reader, data->fd[0], NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_GENTLE_ON_EOF);
+
+	return get_remote_bundle_uri(data->fd[1], &reader,
+				     transport->bundles, stateless_rpc);
+}
+
 static int fetch_refs_via_pack(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
@@ -902,6 +929,7 @@ static int disconnect_git(struct transport *transport)
 
 static struct transport_vtable taken_over_vtable = {
 	.get_refs_list	= get_refs_via_connect,
+	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs_via_pack,
 	.push_refs	= git_transport_push,
 	.disconnect	= disconnect_git
@@ -1054,6 +1082,7 @@ static struct transport_vtable bundle_vtable = {
 
 static struct transport_vtable builtin_smart_vtable = {
 	.get_refs_list	= get_refs_via_connect,
+	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs_via_pack,
 	.push_refs	= git_transport_push,
 	.connect	= connect_git,
@@ -1068,6 +1097,9 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	ret->progress = isatty(2);
 	string_list_init_dup(&ret->pack_lockfiles);
 
+	CALLOC_ARRAY(ret->bundles, 1);
+	init_bundle_list(ret->bundles);
+
 	if (!remote)
 		BUG("No remote provided to transport_get()");
 
@@ -1482,6 +1514,23 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 	return rc;
 }
 
+int transport_get_remote_bundle_uri(struct transport *transport)
+{
+	const struct transport_vtable *vtable = transport->vtable;
+
+	/* Check config only once. */
+	if (transport->got_remote_bundle_uri)
+		return 0;
+	transport->got_remote_bundle_uri = 1;
+
+	if (!vtable->get_bundle_uri)
+		return error(_("bundle-uri operation not supported by protocol"));
+
+	if (vtable->get_bundle_uri(transport) < 0)
+		return error(_("could not retrieve server-advertised bundle-uri list"));
+	return 0;
+}
+
 void transport_unlock_pack(struct transport *transport, unsigned int flags)
 {
 	int in_signal_handler = !!(flags & TRANSPORT_UNLOCK_PACK_IN_SIGNAL_HANDLER);
@@ -1512,6 +1561,8 @@ int transport_disconnect(struct transport *transport)
 		ret = transport->vtable->disconnect(transport);
 	if (transport->got_remote_refs)
 		free_refs((void *)transport->remote_refs);
+	clear_bundle_list(transport->bundles);
+	free(transport->bundles);
 	free(transport);
 	return ret;
 }
diff --git a/transport.h b/transport.h
index b5bf7b3e704..85150f504fb 100644
--- a/transport.h
+++ b/transport.h
@@ -62,6 +62,7 @@ enum transport_family {
 	TRANSPORT_FAMILY_IPV6
 };
 
+struct bundle_list;
 struct transport {
 	const struct transport_vtable *vtable;
 
@@ -76,6 +77,18 @@ struct transport {
 	 */
 	unsigned got_remote_refs : 1;
 
+	/**
+	 * Indicates whether we already called get_bundle_uri_list(); set by
+	 * transport.c::transport_get_remote_bundle_uri().
+	 */
+	unsigned got_remote_bundle_uri : 1;
+
+	/*
+	 * The results of "command=bundle-uri", if both sides support
+	 * the "bundle-uri" capability.
+	 */
+	struct bundle_list *bundles;
+
 	/*
 	 * Transports that call take-over destroys the data specific to
 	 * the transport type while doing so, and cannot be reused.
@@ -281,6 +294,12 @@ void transport_ls_refs_options_release(struct transport_ls_refs_options *opts);
 const struct ref *transport_get_remote_refs(struct transport *transport,
 					    struct transport_ls_refs_options *transport_options);
 
+/**
+ * Retrieve bundle URI(s) from a remote. Populates "struct
+ * transport"'s "bundle_uri" and "got_remote_bundle_uri".
+ */
+int transport_get_remote_bundle_uri(struct transport *transport);
+
 /*
  * Fetch the hash algorithm used by a remote.
  *
-- 
gitgitgadget

