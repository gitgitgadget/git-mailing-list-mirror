Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 291D71F404
	for <e@80x24.org>; Thu, 14 Dec 2017 21:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753911AbdLNVpF (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 16:45:05 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:38877 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753069AbdLNVpB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 16:45:01 -0500
Received: by mail-it0-f47.google.com with SMTP id r6so14471578itr.3
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 13:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6DvV0P+iOTlKpFNillwH0LwsVTUEyNmc/cnnYTlu1Y4=;
        b=EFut7qlj+gN3zmyDP4LRYUL7dJQSpNOhy3j6O9vxghCU6aRX4/OAX6WIJPs1XdPKPv
         +WJsJo+p7UnyFtfTuziQ7nXlU/HZeykz4Ug+EmSUtUiLTazTq2wAMBvFaNDZwqw0Y9VL
         fLHubKCC09wnD9ubB8CSNA1beuM76eGA+sCV1CvLBPRTsap0gThKY6y61n7xRmXn5441
         lsVFcCkZFPAUANNKg7u9T+hbS4QvB5HicuPmm2TKLpRNBkbAK1x6ff3zCbyvSWkhI+uO
         FudgMtjBso9pk8VLdS1b4vg/VglBo3Mbm7AIR4HYwJjBfGkJ8qzsYaxNSnYuBQjz456v
         l3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6DvV0P+iOTlKpFNillwH0LwsVTUEyNmc/cnnYTlu1Y4=;
        b=cyblkoDeDqYwb4teeT2K2vHWZpLlJFVRcOB5DDB0gEZskAJX7MXYT/GNs3fmGnFaGw
         N5v887DsZMAWzKvncyaV26lv2p1HS0YRgI0AX+Ar2+eljkpw0Nl/Qj/Ss5pjRT2rT0eM
         fsRj69zraygxcPXr/hcJDiR/TnZrYCAeHzq5sQashJsPpws0xvu14hFRSGpEV3Ad/49R
         Ab96oThPvxyg3ybM6agYc1k/J9Fei66V2OT6NftBUabnaA6bBGGLcvjR6EQM5XoaYFRj
         MiafkU99mKoTbdvkdyTP0i7e0dnyDn4x3lHpiCnUuuB1iDEOEgXKzr8S8wBkFnOhN3RG
         xpvw==
X-Gm-Message-State: AKGB3mLQKDezWxpeVRR5/TluMLBQN7m/zniw6jTT9cSMc+jmYAHiPJjK
        biMb4Ufk8UPE923WMK9hl/6QImxmFVU=
X-Google-Smtp-Source: ACJfBotsCWXElvcoXPGgvSjEv3nRMsdhywjy1kbHqqJBW8yYNCZfeMDBHJUj41VFOJX4Te/YQFYHBg==
X-Received: by 10.107.29.11 with SMTP id d11mr9084582iod.201.1513287900289;
        Thu, 14 Dec 2017 13:45:00 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id q82sm3079498itb.7.2017.12.14.13.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Dec 2017 13:44:59 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, spearce@spearce.org
Subject: [PATCH 2/2] transport: make transport vtable more private
Date:   Thu, 14 Dec 2017 13:44:45 -0800
Message-Id: <26f276956001a120cc9105b0071762c2fd4a45c5.1513287544.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.1.32.g801bf3c5d
In-Reply-To: <cover.1513287544.git.jonathantanmy@google.com>
References: <cover.1513287544.git.jonathantanmy@google.com>
In-Reply-To: <cover.1513287544.git.jonathantanmy@google.com>
References: <cover.1513287544.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the definition of the transport-specific functions provided by
transports, whether declared in transport.c or transport-helper.c, into
an internal header. This means that transport-using code (as opposed to
transport-declaring code) can no longer access these functions (without
importing the internal header themselves), making it clear that they
should use the transport_*() functions instead, and also allowing the
interface between the transport mechanism and an individual transport to
independently evolve.

This is superficially a reversal of commit 824d5776c3f2 ("Refactor
struct transport_ops inlined into struct transport", 2007-09-19).
However, the scope of the involved variables was neither affected nor
discussed in that commit, and I think that the advantages in making
those functions more private outweigh the advantages described in that
commit's commit message. A minor additional point is that the code has
gotten more complicated since then, in that the function-pointer
variables are potentially mutated twice (once initially and once if
transport_take_over() is invoked), increasing the value of corralling
them into their own struct.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
The main evolution I see is to move all traces of the "takeover"
mechanism to transport.c, instead of having individual transports (the
builtin smart transport in transport.c and the remote helper
interface in transport-helper.c) do the connect-then-fetch etc. thing
themselves. This means that transport_vtable->connect must be allowed to
return "fallback", and we have the following vtables:
 - the one for bundles (unchanged)
 - one for builtin smart transports in which fetch and push_refs are
   NULL
 - one for remote helpers (unchanged)
 - one for the result of takeover (unchanged) (to be used when
   get_refs_list/fetch/pull is used with a connect-supporting transport)
 - one for the result of transport_connect (connect, fetch, and
   push_refs are NULL) (to be used when user code invokes
   transport_connect in order to control the stream directly)

transport_get_remote_refs() and friends will always attempt to connect
(and perform the takeover if it succeeds) before proceeding.

In this way, functionality becomes clearer:
 - Transports that do not support connect leave connect as NULL and
   implement get_refs_list/fetch/pull.
 - Transports that support connect implement connect. If connect is
   do-or-die (e.g. builtin smart transports), leave get_refs_list,
   fetch, and pull as NULL. Otherwise (e.g. remote helpers) populate
   them, and they will be used as a fallback if connect fails.
 - When transport_connect() is invoked, the vtable is switched so that
   connect/get_refs_list/fetch/pull no longer work. The user code has
   full control.
 - When transport_get_remote_refs() (or friends) is invoked, if connect
   is successful, the vtable is switched so that connect no longer
   works. get_refs_list/fetch/pull use the established connection, and
   it is clear that the user can no longer call transport_connect().

This seems feasible to me, but I haven't tried to implement it yet.
---
 transport-helper.c   | 23 +++++++++++-------
 transport-internal.h | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 transport.c          | 69 ++++++++++++++++++++++++++++++++--------------------
 transport.h          | 54 ++--------------------------------------
 4 files changed, 120 insertions(+), 87 deletions(-)
 create mode 100644 transport-internal.h

diff --git a/transport-helper.c b/transport-helper.c
index c948d5215..1a4b43ff1 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -11,6 +11,7 @@
 #include "sigchain.h"
 #include "argv-array.h"
 #include "refs.h"
+#include "transport-internal.h"
 
 static int debug;
 
@@ -650,7 +651,7 @@ static int fetch(struct transport *transport,
 
 	if (process_connect(transport, 0)) {
 		do_take_over(transport);
-		return transport->fetch(transport, nr_heads, to_fetch);
+		return transport->vtable->fetch(transport, nr_heads, to_fetch);
 	}
 
 	count = 0;
@@ -987,7 +988,7 @@ static int push_refs(struct transport *transport,
 
 	if (process_connect(transport, 1)) {
 		do_take_over(transport);
-		return transport->push_refs(transport, remote_refs, flags);
+		return transport->vtable->push_refs(transport, remote_refs, flags);
 	}
 
 	if (!remote_refs) {
@@ -1035,7 +1036,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 
 	if (process_connect(transport, for_push)) {
 		do_take_over(transport);
-		return transport->get_refs_list(transport, for_push);
+		return transport->vtable->get_refs_list(transport, for_push);
 	}
 
 	if (data->push && for_push)
@@ -1084,6 +1085,15 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 	return ret;
 }
 
+static struct transport_vtable vtable = {
+	set_helper_option,
+	get_refs_list,
+	fetch,
+	push_refs,
+	connect_helper,
+	release_helper
+};
+
 int transport_helper_init(struct transport *transport, const char *name)
 {
 	struct helper_data *data = xcalloc(1, sizeof(*data));
@@ -1095,12 +1105,7 @@ int transport_helper_init(struct transport *transport, const char *name)
 		debug = 1;
 
 	transport->data = data;
-	transport->set_option = set_helper_option;
-	transport->get_refs_list = get_refs_list;
-	transport->fetch = fetch;
-	transport->push_refs = push_refs;
-	transport->disconnect = release_helper;
-	transport->connect = connect_helper;
+	transport->vtable = &vtable;
 	transport->smart_options = &(data->transport_options);
 	return 0;
 }
diff --git a/transport-internal.h b/transport-internal.h
new file mode 100644
index 000000000..3c1a29d72
--- /dev/null
+++ b/transport-internal.h
@@ -0,0 +1,61 @@
+#ifndef TRANSPORT_INTERNAL_H
+#define TRANSPORT_INTERNAL_H
+
+struct ref;
+struct transport;
+
+struct transport_vtable {
+	/**
+	 * Returns 0 if successful, positive if the option is not
+	 * recognized or is inapplicable, and negative if the option
+	 * is applicable but the value is invalid.
+	 **/
+	int (*set_option)(struct transport *connection, const char *name,
+			  const char *value);
+	/**
+	 * Returns a list of the remote side's refs. In order to allow
+	 * the transport to try to share connections, for_push is a
+	 * hint as to whether the ultimate operation is a push or a fetch.
+	 *
+	 * If the transport is able to determine the remote hash for
+	 * the ref without a huge amount of effort, it should store it
+	 * in the ref's old_sha1 field; otherwise it should be all 0.
+	 **/
+	struct ref *(*get_refs_list)(struct transport *transport, int for_push);
+
+	/**
+	 * Fetch the objects for the given refs. Note that this gets
+	 * an array, and should ignore the list structure.
+	 *
+	 * If the transport did not get hashes for refs in
+	 * get_refs_list(), it should set the old_sha1 fields in the
+	 * provided refs now.
+	 **/
+	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
+
+	/**
+	 * Push the objects and refs. Send the necessary objects, and
+	 * then, for any refs where peer_ref is set and
+	 * peer_ref->new_oid is different from old_oid, tell the
+	 * remote side to update each ref in the list from old_oid to
+	 * peer_ref->new_oid.
+	 *
+	 * Where possible, set the status for each ref appropriately.
+	 *
+	 * The transport must modify new_sha1 in the ref to the new
+	 * value if the remote accepted the change. Note that this
+	 * could be a different value from peer_ref->new_oid if the
+	 * process involved generating new commits.
+	 **/
+	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
+	int (*connect)(struct transport *connection, const char *name,
+		       const char *executable, int fd[2]);
+
+	/** get_refs_list(), fetch(), and push_refs() can keep
+	 * resources (such as a connection) reserved for further
+	 * use. disconnect() releases these resources.
+	 **/
+	int (*disconnect)(struct transport *connection);
+};
+
+#endif
diff --git a/transport.c b/transport.c
index 8c4fc5477..31b6d4d0e 100644
--- a/transport.c
+++ b/transport.c
@@ -17,6 +17,7 @@
 #include "string-list.h"
 #include "sha1-array.h"
 #include "sigchain.h"
+#include "transport-internal.h"
 
 static void set_upstreams(struct transport *transport, struct ref *refs,
 	int pretend)
@@ -607,6 +608,15 @@ static int disconnect_git(struct transport *transport)
 	return 0;
 }
 
+static struct transport_vtable taken_over_vtable = {
+	NULL,
+	get_refs_via_connect,
+	fetch_refs_via_pack,
+	git_transport_push,
+	NULL,
+	disconnect_git
+};
+
 void transport_take_over(struct transport *transport,
 			 struct child_process *child)
 {
@@ -624,11 +634,7 @@ void transport_take_over(struct transport *transport,
 	data->got_remote_heads = 0;
 	transport->data = data;
 
-	transport->set_option = NULL;
-	transport->get_refs_list = get_refs_via_connect;
-	transport->fetch = fetch_refs_via_pack;
-	transport->push_refs = git_transport_push;
-	transport->disconnect = disconnect_git;
+	transport->vtable = &taken_over_vtable;
 	transport->smart_options = &(data->options);
 
 	transport->cannot_reuse = 1;
@@ -751,6 +757,24 @@ void transport_check_allowed(const char *type)
 		die("transport '%s' not allowed", type);
 }
 
+static struct transport_vtable bundle_vtable = {
+	NULL,
+	get_refs_from_bundle,
+	fetch_refs_from_bundle,
+	NULL,
+	NULL,
+	close_bundle
+};
+
+static struct transport_vtable builtin_smart_vtable = {
+	NULL,
+	get_refs_via_connect,
+	fetch_refs_via_pack,
+	git_transport_push,
+	connect_git,
+	disconnect_git
+};
+
 struct transport *transport_get(struct remote *remote, const char *url)
 {
 	const char *helper;
@@ -787,9 +811,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		transport_check_allowed("file");
 		ret->data = data;
-		ret->get_refs_list = get_refs_from_bundle;
-		ret->fetch = fetch_refs_from_bundle;
-		ret->disconnect = close_bundle;
+		ret->vtable = &bundle_vtable;
 		ret->smart_options = NULL;
 	} else if (!is_url(url)
 		|| starts_with(url, "file://")
@@ -804,12 +826,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		 */
 		struct git_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
-		ret->set_option = NULL;
-		ret->get_refs_list = get_refs_via_connect;
-		ret->fetch = fetch_refs_via_pack;
-		ret->push_refs = git_transport_push;
-		ret->connect = connect_git;
-		ret->disconnect = disconnect_git;
+		ret->vtable = &builtin_smart_vtable;
 		ret->smart_options = &(data->options);
 
 		data->conn = NULL;
@@ -843,9 +860,9 @@ int transport_set_option(struct transport *transport,
 		git_reports = set_git_option(transport->smart_options,
 					     name, value);
 
-	if (transport->set_option)
-		protocol_reports = transport->set_option(transport, name,
-							value);
+	if (transport->vtable->set_option)
+		protocol_reports = transport->vtable->set_option(transport,
+								 name, value);
 
 	/* If either report is 0, report 0 (success). */
 	if (!git_reports || !protocol_reports)
@@ -968,7 +985,7 @@ int transport_push(struct transport *transport,
 	*reject_reasons = 0;
 	transport_verify_remote_names(refspec_nr, refspec);
 
-	if (transport->push_refs) {
+	if (transport->vtable->push_refs) {
 		struct ref *remote_refs;
 		struct ref *local_refs = get_local_heads();
 		int match_flags = MATCH_REFS_NONE;
@@ -981,7 +998,7 @@ int transport_push(struct transport *transport,
 		if (check_push_refs(local_refs, refspec_nr, refspec) < 0)
 			return -1;
 
-		remote_refs = transport->get_refs_list(transport, 1);
+		remote_refs = transport->vtable->get_refs_list(transport, 1);
 
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
@@ -1056,7 +1073,7 @@ int transport_push(struct transport *transport,
 		}
 
 		if (!(flags & TRANSPORT_RECURSE_SUBMODULES_ONLY))
-			push_ret = transport->push_refs(transport, remote_refs, flags);
+			push_ret = transport->vtable->push_refs(transport, remote_refs, flags);
 		else
 			push_ret = 0;
 		err = push_had_errors(remote_refs);
@@ -1090,7 +1107,7 @@ int transport_push(struct transport *transport,
 const struct ref *transport_get_remote_refs(struct transport *transport)
 {
 	if (!transport->got_remote_refs) {
-		transport->remote_refs = transport->get_refs_list(transport, 0);
+		transport->remote_refs = transport->vtable->get_refs_list(transport, 0);
 		transport->got_remote_refs = 1;
 	}
 
@@ -1127,7 +1144,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 			heads[nr_heads++] = rm;
 	}
 
-	rc = transport->fetch(transport, nr_heads, heads);
+	rc = transport->vtable->fetch(transport, nr_heads, heads);
 
 	free(heads);
 	return rc;
@@ -1144,8 +1161,8 @@ void transport_unlock_pack(struct transport *transport)
 int transport_connect(struct transport *transport, const char *name,
 		      const char *exec, int fd[2])
 {
-	if (transport->connect)
-		return transport->connect(transport, name, exec, fd);
+	if (transport->vtable->connect)
+		return transport->vtable->connect(transport, name, exec, fd);
 	else
 		die("Operation not supported by protocol");
 }
@@ -1153,8 +1170,8 @@ int transport_connect(struct transport *transport, const char *name,
 int transport_disconnect(struct transport *transport)
 {
 	int ret = 0;
-	if (transport->disconnect)
-		ret = transport->disconnect(transport);
+	if (transport->vtable->disconnect)
+		ret = transport->vtable->disconnect(transport);
 	free(transport);
 	return ret;
 }
diff --git a/transport.h b/transport.h
index ab4fe7f27..731c78b67 100644
--- a/transport.h
+++ b/transport.h
@@ -30,6 +30,8 @@ enum transport_family {
 };
 
 struct transport {
+	const struct transport_vtable *vtable;
+
 	struct remote *remote;
 	const char *url;
 	void *data;
@@ -59,58 +61,6 @@ struct transport {
 	 */
 	const struct string_list *push_options;
 
-	/**
-	 * Returns 0 if successful, positive if the option is not
-	 * recognized or is inapplicable, and negative if the option
-	 * is applicable but the value is invalid.
-	 **/
-	int (*set_option)(struct transport *connection, const char *name,
-			  const char *value);
-
-	/**
-	 * Returns a list of the remote side's refs. In order to allow
-	 * the transport to try to share connections, for_push is a
-	 * hint as to whether the ultimate operation is a push or a fetch.
-	 *
-	 * If the transport is able to determine the remote hash for
-	 * the ref without a huge amount of effort, it should store it
-	 * in the ref's old_sha1 field; otherwise it should be all 0.
-	 **/
-	struct ref *(*get_refs_list)(struct transport *transport, int for_push);
-
-	/**
-	 * Fetch the objects for the given refs. Note that this gets
-	 * an array, and should ignore the list structure.
-	 *
-	 * If the transport did not get hashes for refs in
-	 * get_refs_list(), it should set the old_sha1 fields in the
-	 * provided refs now.
-	 **/
-	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
-
-	/**
-	 * Push the objects and refs. Send the necessary objects, and
-	 * then, for any refs where peer_ref is set and
-	 * peer_ref->new_oid is different from old_oid, tell the
-	 * remote side to update each ref in the list from old_oid to
-	 * peer_ref->new_oid.
-	 *
-	 * Where possible, set the status for each ref appropriately.
-	 *
-	 * The transport must modify new_sha1 in the ref to the new
-	 * value if the remote accepted the change. Note that this
-	 * could be a different value from peer_ref->new_oid if the
-	 * process involved generating new commits.
-	 **/
-	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
-	int (*connect)(struct transport *connection, const char *name,
-		       const char *executable, int fd[2]);
-
-	/** get_refs_list(), fetch(), and push_refs() can keep
-	 * resources (such as a connection) reserved for further
-	 * use. disconnect() releases these resources.
-	 **/
-	int (*disconnect)(struct transport *connection);
 	char *pack_lockfile;
 	signed verbose : 3;
 	/**
-- 
2.15.1.504.g5279b80103-goog

