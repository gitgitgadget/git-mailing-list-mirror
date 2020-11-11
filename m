Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9E9C4742C
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DA02168B
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BOhQ8NHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgKLBcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbgKKX3j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 18:29:39 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A073C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:37 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j10so3894808ybl.19
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=QtERscP7yWvP30c2J19Qx22bSQTBXM4wV0rIy9YIG0c=;
        b=BOhQ8NHHqC6ZKPfrtHqJdu1wAfz8RlQTWaGVoFXTot/CodaFn8BbgtGEYWtdpzRzl1
         RydmMhdRAo9rxkkfEEwqmtdswPePFJVngz+023o0cRnc6emrZVHzlg+ONjGzBwPFINOK
         57OfKMIhsoVGkr6tsr0SDAMc45FWXq18yXyqsR1Z3qwxo7C0XvqEnlQn1oIp4ZwvPuLv
         TuY+Xv453XFUdI/q6cDWw3lfgG8sn8Nle3Zbjh1k2syKxsQpjQ2KTA+USXix6ZCSj4aW
         6F6NIHqjjIG+iye5+AxaLCAdUcijcpMSWEO5S7dXCjOFWg5mVMV6bWt6N+IHJx5X3jCg
         O4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=QtERscP7yWvP30c2J19Qx22bSQTBXM4wV0rIy9YIG0c=;
        b=Yp0aOGGJr5mt3QKkEqwkd7qoOZL/k2iT5cB4es9R9UyAR0+owCgcdEJGf0mZrrCuhe
         D5Yffwl8cTPQ3J3yN20egUtW/m6okMdZvxy4D5ox/1orrmjB+FzILnoXerkwBmNGBTf4
         qB+6v+8hB5OiEvva9+m5UQpOsrcuTJu+Ym6wQdhtY/qSJScMx1UvDyM3fO5Cd+2NRv8O
         x87aDRuFKgVxuZVuQQzo2VKT7qs5hCCapIRPSlLmsjgtvnp5QwD0bAyY3j71bEVnqofx
         dcaKh+9I7qgFxRNqcPvNYomnxxYaaZ9Rfsm171AI9zZsqgvkc+VWz4Gdt62hejxUvHrp
         jH4A==
X-Gm-Message-State: AOAM530JeoaEZPUMNu1q9kXpnSLvVJ4YvYHTZkys4zGycFGpMEd+V+/X
        9cfF4HBmpEjmURNrlChNgtfsurM9qPqIvDm2HXHe+oZijlTdkzz9NipcZr5ghB2zA/GgOMoaxLu
        I1KtCCSM24DXszR2PtJ/wX4HrrsjFdDxefTn7G43O2BJ06k3GvDc46PuSIs4JZIk=
X-Google-Smtp-Source: ABdhPJzPtAVuMkw3ZOMXc4AiFoZvdKGdeMQYC1sgGIuore0Z9T28qjdAhZ4vR337OnoGXldbepcnuJZNjSqi8g==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a5b:d44:: with SMTP id
 f4mr37501292ybr.399.1605137376737; Wed, 11 Nov 2020 15:29:36 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:29:23 -0800
In-Reply-To: <cover.1604006121.git.steadmon@google.com>
Message-Id: <cover.1605136908.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v3 00/11] Advertise session ID in protocol capabilities
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to more easily debug remote operations, it is useful to be able
to identify sessions on either side of the connection. This series
allows clients and servers to provide a unique session ID via a new
"session-id" protocol capability. This session ID can be logged on each
side of the connection, allowing logs to be joined during debugging
sessions.

Changes from V2:
* De-emphasize connection to trace2
* Renamed capability from "trace2-sid" to "session-id"
* Noted (lack of) session ID structure in capability docs
* Advertise SID regardless of whether trace2 is enabled
* Simplify conditionals
* Style cleanups

Changes since V1:
* Added a public trace2_session_id() function to trace2.{h,c}. Used this
  in place of tr2_sid_get().
* Fixed a style issue regarding using NULL rather than 0.

Josh Steadmon (11):
  docs: new capability to advertise session IDs
  docs: new transfer.advertiseSID option
  trace2: add a public function for getting the SID
  upload-pack: advertise session ID in v0 capabilities
  receive-pack: advertise session ID in v0 capabilities
  serve: advertise session ID in v2 capabilities
  transport: log received server session ID
  fetch-pack: advertise session ID in capabilities
  upload-pack, serve: log received client session ID
  send-pack: advertise session ID in capabilities
  receive-pack: log received client session ID

 Documentation/config/transfer.txt             |  4 +
 .../technical/protocol-capabilities.txt       | 17 +++-
 Documentation/technical/protocol-v2.txt       | 13 ++++
 builtin/receive-pack.c                        | 15 ++++
 fetch-pack.c                                  |  9 +++
 send-pack.c                                   |  7 ++
 serve.c                                       | 18 +++++
 t/t5705-session-id-in-capabilities.sh         | 78 +++++++++++++++++++
 trace2.c                                      |  5 ++
 trace2.h                                      |  2 +
 transport.c                                   | 10 +++
 upload-pack.c                                 | 23 +++++-
 12 files changed, 198 insertions(+), 3 deletions(-)
 create mode 100755 t/t5705-session-id-in-capabilities.sh

Range-diff against v2:
 1:  d04028c3c7 <  -:  ---------- docs: new capability to advertise trace2 SIDs
 2:  5d5097b671 <  -:  ---------- docs: new trace2.advertiseSID option
 -:  ---------- >  1:  184cabb6f5 docs: new capability to advertise session IDs
 -:  ---------- >  2:  937534065a docs: new transfer.advertiseSID option
 3:  7f42aacd2b =  3:  227c709ba5 trace2: add a public function for getting the SID
 4:  4912af5f2b !  4:  612957b9d5 upload-pack: advertise trace2 SID in v0 capabilities
    @@ Metadata
     Author: Josh Steadmon <steadmon@google.com>
     
      ## Commit message ##
    -    upload-pack: advertise trace2 SID in v0 capabilities
    +    upload-pack: advertise session ID in v0 capabilities
     
    -    When trace2 is enabled and trace2.advertiseSID is true, advertise
    -    upload-pack's trace2 session ID via the new trace2-sid capability.
    +    When transfer.advertiseSID is true, advertise upload-pack's session ID
    +    via the new session-id capability.
     
     
    @@ upload-pack.c: struct upload_pack_data {
      	unsigned done : 1;					/* v2 only */
      	unsigned allow_ref_in_want : 1;				/* v2 only */
      	unsigned allow_sideband_all : 1;			/* v2 only */
    -+	unsigned advertise_trace2_sid : 1;
    ++	unsigned advertise_sid : 1;
      };
      
      static void upload_pack_data_init(struct upload_pack_data *data)
    @@ upload-pack.c: static void upload_pack_data_init(struct upload_pack_data *data)
      	packet_writer_init(&data->writer, 1);
      
      	data->keepalive = 5;
    -+	data->advertise_trace2_sid = 0;
    ++	data->advertise_sid = 0;
      }
      
      static void upload_pack_data_clear(struct upload_pack_data *data)
    @@ upload-pack.c: static void format_symref_info(struct strbuf *buf, struct string_
      		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
      }
      
    -+static void format_trace2_info(struct strbuf *buf, struct upload_pack_data *d) {
    -+	if (d->advertise_trace2_sid && trace2_is_enabled())
    -+		strbuf_addf(buf, " trace2-sid=%s", trace2_session_id());
    ++static void format_session_id(struct strbuf *buf, struct upload_pack_data *d) {
    ++	if (d->advertise_sid)
    ++		strbuf_addf(buf, " session-id=%s", trace2_session_id());
     +}
     +
      static int send_ref(const char *refname, const struct object_id *oid,
    @@ upload-pack.c: static int send_ref(const char *refname, const struct object_id *
      
      	if (capabilities) {
      		struct strbuf symref_info = STRBUF_INIT;
    -+		struct strbuf trace2_info = STRBUF_INIT;
    ++		struct strbuf session_id = STRBUF_INIT;
      
      		format_symref_info(&symref_info, &data->symref);
     -		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s object-format=%s agent=%s\n",
    -+		format_trace2_info(&trace2_info, data);
    ++		format_session_id(&session_id, data);
     +		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s%s object-format=%s agent=%s\n",
      			     oid_to_hex(oid), refname_nons,
      			     0, capabilities,
    @@ upload-pack.c: static int send_ref(const char *refname, const struct object_id *
      			     data->stateless_rpc ? " no-done" : "",
      			     symref_info.buf,
      			     data->allow_filter ? " filter" : "",
    -+			     trace2_info.buf,
    ++			     session_id.buf,
      			     the_hash_algo->name,
      			     git_user_agent_sanitized());
      		strbuf_release(&symref_info);
    -+		strbuf_release(&trace2_info);
    ++		strbuf_release(&session_id);
      	} else {
      		packet_write_fmt(1, "%s %s\n", oid_to_hex(oid), refname_nons);
      	}
    @@ upload-pack.c: static int upload_pack_config(const char *var, const char *value,
      		data->allow_sideband_all = git_config_bool(var, value);
      	} else if (!strcmp("core.precomposeunicode", var)) {
      		precomposed_unicode = git_config_bool(var, value);
    -+	} else if (!strcmp("trace2.advertisesid", var)) {
    -+		data->advertise_trace2_sid = git_config_bool(var, value);
    ++	} else if (!strcmp("transfer.advertisesid", var)) {
    ++		data->advertise_sid = git_config_bool(var, value);
      	}
      
      	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
 5:  7003189c81 !  5:  32fe78f3e9 receive-pack: advertise trace2 SID in v0 capabilities
    @@ Metadata
     Author: Josh Steadmon <steadmon@google.com>
     
      ## Commit message ##
    -    receive-pack: advertise trace2 SID in v0 capabilities
    +    receive-pack: advertise session ID in v0 capabilities
     
    -    When trace2 is enabled and trace2.advertiseSID is true, advertise
    -    receive-pack's trace2 session ID via the new trace2-sid capability.
    +    When transfer.advertiseSID is true, advertise receive-pack's session ID
    +    via the new session-id capability.
     
     
    @@ builtin/receive-pack.c: static int receive_unpack_limit = -1;
      static int transfer_unpack_limit = -1;
      static int advertise_atomic_push = 1;
      static int advertise_push_options;
    -+static int advertise_trace2_sid;
    ++static int advertise_sid;
      static int unpack_limit = 100;
      static off_t max_input_size;
      static int report_status;
    @@ builtin/receive-pack.c: static int receive_pack_config(const char *var, const ch
      		return 0;
      	}
      
    -+	if (strcmp(var, "trace2.advertisesid") == 0) {
    -+		advertise_trace2_sid = git_config_bool(var, value);
    ++	if (strcmp(var, "transfer.advertisesid") == 0) {
    ++		advertise_sid = git_config_bool(var, value);
     +		return 0;
     +	}
     +
    @@ builtin/receive-pack.c: static void show_ref(const char *path, const struct obje
      			strbuf_addf(&cap, " push-cert=%s", push_cert_nonce);
      		if (advertise_push_options)
      			strbuf_addstr(&cap, " push-options");
    -+		if (advertise_trace2_sid && trace2_is_enabled())
    -+			strbuf_addf(&cap, " trace2-sid=%s", trace2_session_id());
    ++		if (advertise_sid)
    ++			strbuf_addf(&cap, " session-id=%s", trace2_session_id());
      		strbuf_addf(&cap, " object-format=%s", the_hash_algo->name);
      		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
      		packet_write_fmt(1, "%s %s%c%s\n",
 6:  9573428cc0 !  6:  fe6731cc09 serve: advertise trace2 SID in v2 capabilities
    @@ Metadata
     Author: Josh Steadmon <steadmon@google.com>
     
      ## Commit message ##
    -    serve: advertise trace2 SID in v2 capabilities
    +    serve: advertise session ID in v2 capabilities
     
    -    When trace2 is enabled and trace2.advertiseSID is true, advertise the
    -    server's trace2 session ID for all protocol v2 connections via the new
    -    trace2-sid capability.
    +    When transfer.advertiseSID is true, advertise the server's session ID
    +    for all protocol v2 connections via the new session-id capability.
     
     
    @@ serve.c
      #include "serve.h"
      #include "upload-pack.h"
      
    -+static int advertise_trace2_sid;
    ++static int advertise_sid;
     +
      static int always_advertise(struct repository *r,
      			    struct strbuf *value)
    @@ serve.c: static int object_format_advertise(struct repository *r,
      	return 1;
      }
      
    -+static int trace2_advertise(struct repository *r, struct strbuf *value)
    ++static int session_id_advertise(struct repository *r, struct strbuf *value)
     +{
    -+	if (!advertise_trace2_sid || !trace2_is_enabled())
    ++	if (!advertise_sid)
     +		return 0;
     +	if (value)
     +		strbuf_addstr(value, trace2_session_id());
    @@ serve.c: static struct protocol_capability capabilities[] = {
      	{ "fetch", upload_pack_advertise, upload_pack_v2 },
      	{ "server-option", always_advertise, NULL },
      	{ "object-format", object_format_advertise, NULL },
    -+	{ "trace2-sid", trace2_advertise, NULL },
    ++	{ "session-id", session_id_advertise, NULL },
      };
      
      static void advertise_capabilities(void)
    @@ serve.c: static int process_request(void)
      /* Main serve loop for protocol version 2 */
      void serve(struct serve_options *options)
      {
    -+	git_config_get_bool("trace2.advertisesid", &advertise_trace2_sid);
    ++	git_config_get_bool("transfer.advertisesid", &advertise_sid);
     +
      	if (options->advertise_capabilities || !options->stateless_rpc) {
      		/* serve by default supports v2 */
 7:  21bdbf23f3 !  7:  014cae8dc1 transport: log received server trace2 SID
    @@ Metadata
     Author: Josh Steadmon <steadmon@google.com>
     
      ## Commit message ##
    -    transport: log received server trace2 SID
    +    transport: log received server session ID
     
    -    When a client receives a trace2-sid capability from a protocol v0, v1,
    +    When a client receives a session-id capability from a protocol v0, v1,
         or v2 server, log the received session ID via a trace2 data event.
     
     
    - ## t/t5705-trace2-sid-in-capabilities.sh (new) ##
    + ## t/t5705-session-id-in-capabilities.sh (new) ##
     @@
     +#!/bin/sh
     +
    -+test_description='trace2 SID in capabilities'
    ++test_description='session ID in capabilities'
     +
     +. ./test-lib.sh
     +
     +REPO="$(pwd)/repo"
     +LOCAL_PRISTINE="$(pwd)/local_pristine"
     +
    -+test_expect_success 'setup repos for trace2 SID capability tests' '
    ++test_expect_success 'setup repos for session ID capability tests' '
     +	git init "$REPO" &&
     +	test_commit -C "$REPO" a &&
     +	git clone "file://$REPO" "$LOCAL_PRISTINE" &&
    @@ t/t5705-trace2-sid-in-capabilities.sh (new)
     +
     +for PROTO in 0 1 2
     +do
    -+	test_expect_success "trace2 session IDs not advertised by default (fetch v${PROTO})" '
    ++	test_expect_success "session IDs not advertised by default (fetch v${PROTO})" '
     +		test_when_finished "rm -rf local tr2-client-events" &&
     +		cp -r "$LOCAL_PRISTINE" local &&
     +		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
    @@ t/t5705-trace2-sid-in-capabilities.sh (new)
     +		test -z "$(grep \"key\":\"server-sid\" tr2-client-events)"
     +	'
     +
    -+	test_expect_success "trace2 session IDs not advertised by default (push v${PROTO})" '
    ++	test_expect_success "session IDs not advertised by default (push v${PROTO})" '
     +		test_when_finished "rm -rf local tr2-client-events" &&
     +		cp -r "$LOCAL_PRISTINE" local &&
     +		git -C local pull --no-rebase origin &&
    @@ t/t5705-trace2-sid-in-capabilities.sh (new)
     +done
     +
     +test_expect_success 'enable SID advertisement' '
    -+	git -C "$REPO" config trace2.advertiseSID true &&
    -+	git -C "$LOCAL_PRISTINE" config trace2.advertiseSID true
    ++	git -C "$REPO" config transfer.advertiseSID true &&
    ++	git -C "$LOCAL_PRISTINE" config transfer.advertiseSID true
     +'
     +
     +for PROTO in 0 1 2
     +do
    -+	test_expect_success "trace2 session IDs advertised (fetch v${PROTO})" '
    ++	test_expect_success "session IDs advertised (fetch v${PROTO})" '
     +		test_when_finished "rm -rf local tr2-client-events" &&
     +		cp -r "$LOCAL_PRISTINE" local &&
     +		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
    @@ t/t5705-trace2-sid-in-capabilities.sh (new)
     +		grep \"key\":\"server-sid\" tr2-client-events
     +	'
     +
    -+	test_expect_success "trace2 session IDs advertised (push v${PROTO})" '
    ++	test_expect_success "session IDs advertised (push v${PROTO})" '
     +		test_when_finished "rm -rf local tr2-client-events" &&
     +		cp -r "$LOCAL_PRISTINE" local &&
     +		git -C local pull --no-rebase origin &&
    @@ transport.c: static struct ref *handshake(struct transport *transport, int for_p
      	struct ref *refs = NULL;
      	struct packet_reader reader;
     +	int sid_len;
    -+	const char *server_trace2_sid;
    ++	const char *server_sid;
      
      	connect_setup(transport, for_push);
      
    @@ transport.c: static struct ref *handshake(struct transport *transport, int for_p
      	data->version = discover_version(&reader);
      	switch (data->version) {
      	case protocol_v2:
    -+		if (server_feature_v2("trace2-sid", &server_trace2_sid))
    -+			trace2_data_string("trace2", NULL, "server-sid", server_trace2_sid);
    ++		if (server_feature_v2("session-id", &server_sid))
    ++			trace2_data_string("transfer", NULL, "server-sid", server_sid);
      		if (must_list_refs)
      			get_remote_refs(data->fd[1], &reader, &refs, for_push,
      					ref_prefixes,
    @@ transport.c: static struct ref *handshake(struct transport *transport, int for_p
      				 for_push ? REF_NORMAL : 0,
      				 &data->extra_have,
      				 &data->shallow);
    -+		server_trace2_sid = server_feature_value("trace2-sid", &sid_len);
    -+		if (server_trace2_sid) {
    -+			char *server_sid = xstrndup(server_trace2_sid, sid_len);
    -+			trace2_data_string("trace2", NULL, "server-sid", server_sid);
    -+			free(server_sid);
    ++		server_sid = server_feature_value("session-id", &sid_len);
    ++		if (server_sid) {
    ++			char *sid = xstrndup(server_sid, sid_len);
    ++			trace2_data_string("transfer", NULL, "server-sid", sid);
    ++			free(sid);
     +		}
      		break;
      	case protocol_unknown_version:
 8:  11b5b1b54f !  8:  fc9f6c9286 fetch-pack: advertise trace2 SID in capabilities
    @@ Metadata
     Author: Josh Steadmon <steadmon@google.com>
     
      ## Commit message ##
    -    fetch-pack: advertise trace2 SID in capabilities
    +    fetch-pack: advertise session ID in capabilities
     
    -    When trace2 is enabled, the server sent a trace2-sid capability, and
    -    trace2.advertiseSID is true, advertise fetch-pack's own session ID back
    -    to the server.
    +    When the server sent a session-id capability and transfer.advertiseSID
    +    is true, advertise fetch-pack's own session ID back to the server.
     
     
    @@ fetch-pack.c: static int fetch_fsck_objects = -1;
      static int transfer_fsck_objects = -1;
      static int agent_supported;
      static int server_supports_filtering;
    -+static int server_sent_trace2_sid;
    -+static int advertise_trace2_sid;
    ++static int advertise_sid;
      static struct shallow_lock shallow_lock;
      static const char *alternate_shallow_file;
      static struct strbuf fsck_msg_types = STRBUF_INIT;
    @@ fetch-pack.c: static int find_common(struct fetch_negotiator *negotiator,
      			if (deepen_not_ok)      strbuf_addstr(&c, " deepen-not");
      			if (agent_supported)    strbuf_addf(&c, " agent=%s",
      							    git_user_agent_sanitized());
    -+			if (advertise_trace2_sid && server_sent_trace2_sid && trace2_is_enabled())
    -+				strbuf_addf(&c, " trace2-sid=%s", trace2_session_id());
    ++			if (advertise_sid)
    ++				strbuf_addf(&c, " session-id=%s", trace2_session_id());
      			if (args->filter_options.choice)
      				strbuf_addstr(&c, " filter");
      			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
    @@ fetch-pack.c: static struct ref *do_fetch_pack(struct fetch_pack_args *args,
      				      agent_len, agent_feature);
      	}
      
    -+	if (server_supports("trace2-sid"))
    -+		server_sent_trace2_sid = 1;
    ++	if (!server_supports("session-id"))
    ++		advertise_sid = 0;
     +
      	if (server_supports("shallow"))
      		print_verbose(args, _("Server supports %s"), "shallow");
    @@ fetch-pack.c: static int send_fetch_request(struct fetch_negotiator *negotiator,
      		packet_buf_write(&req_buf, "command=fetch");
      	if (server_supports_v2("agent", 0))
      		packet_buf_write(&req_buf, "agent=%s", git_user_agent_sanitized());
    -+	if (advertise_trace2_sid && server_supports_v2("trace2-sid", 0) && trace2_is_enabled())
    -+		packet_buf_write(&req_buf, "trace2-sid=%s", trace2_session_id());
    ++	if (advertise_sid && server_supports_v2("session-id", 0))
    ++		packet_buf_write(&req_buf, "session-id=%s", trace2_session_id());
      	if (args->server_options && args->server_options->nr &&
      	    server_supports_v2("server-option", 1)) {
      		int i;
    @@ fetch-pack.c: static void fetch_pack_config(void)
      	git_config_get_bool("repack.usedeltabaseoffset", &prefer_ofs_delta);
      	git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
      	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
    -+	git_config_get_bool("trace2.advertisesid", &advertise_trace2_sid);
    ++	git_config_get_bool("transfer.advertisesid", &advertise_sid);
      	if (!uri_protocols.nr) {
      		char *str;
      
 9:  23f44bc904 !  9:  bde9c1d97a upload-pack, serve: log received client trace2 SID
    @@ Metadata
     Author: Josh Steadmon <steadmon@google.com>
     
      ## Commit message ##
    -    upload-pack, serve: log received client trace2 SID
    +    upload-pack, serve: log received client session ID
     
         When upload-pack (protocol v0/v1) or a protocol v2 server receives a
    -    trace2-sid capability from a client, log the received session ID via a
    +    session-id capability from a client, log the received session ID via a
         trace2 data event.
     
    @@ serve.c: static int process_request(void)
      
      	check_algorithm(the_repository, &keys);
      
    -+	if (has_capability(&keys, "trace2-sid", &client_sid))
    -+		trace2_data_string("trace2", NULL, "client-sid", client_sid);
    ++	if (has_capability(&keys, "session-id", &client_sid))
    ++		trace2_data_string("transfer", NULL, "client-sid", client_sid);
     +
      	command->command(the_repository, &keys, &reader);
      
      	strvec_clear(&keys);
     
    - ## t/t5705-trace2-sid-in-capabilities.sh ##
    -@@ t/t5705-trace2-sid-in-capabilities.sh: test_expect_success 'setup repos for trace2 SID capability tests' '
    + ## t/t5705-session-id-in-capabilities.sh ##
    +@@ t/t5705-session-id-in-capabilities.sh: test_expect_success 'setup repos for session ID capability tests' '
      for PROTO in 0 1 2
      do
    - 	test_expect_success "trace2 session IDs not advertised by default (fetch v${PROTO})" '
    + 	test_expect_success "session IDs not advertised by default (fetch v${PROTO})" '
     -		test_when_finished "rm -rf local tr2-client-events" &&
     +		test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
      		cp -r "$LOCAL_PRISTINE" local &&
    @@ t/t5705-trace2-sid-in-capabilities.sh: test_expect_success 'setup repos for trac
     +		test -z "$(grep \"key\":\"client-sid\" tr2-server-events)"
      	'
      
    - 	test_expect_success "trace2 session IDs not advertised by default (push v${PROTO})" '
    -@@ t/t5705-trace2-sid-in-capabilities.sh: test_expect_success 'enable SID advertisement' '
    + 	test_expect_success "session IDs not advertised by default (push v${PROTO})" '
    +@@ t/t5705-session-id-in-capabilities.sh: test_expect_success 'enable SID advertisement' '
      for PROTO in 0 1 2
      do
    - 	test_expect_success "trace2 session IDs advertised (fetch v${PROTO})" '
    + 	test_expect_success "session IDs advertised (fetch v${PROTO})" '
     -		test_when_finished "rm -rf local tr2-client-events" &&
     +		test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
      		cp -r "$LOCAL_PRISTINE" local &&
    -+		git -C local config trace2.advertiseSID true &&
      		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
     -		git -c protocol.version=$PROTO -C local fetch origin &&
     -		grep \"key\":\"server-sid\" tr2-client-events
    @@ t/t5705-trace2-sid-in-capabilities.sh: test_expect_success 'enable SID advertise
     +		grep \"key\":\"client-sid\" tr2-server-events
      	'
      
    - 	test_expect_success "trace2 session IDs advertised (push v${PROTO})" '
    + 	test_expect_success "session IDs advertised (push v${PROTO})" '
     
      ## upload-pack.c ##
     @@ upload-pack.c: static void receive_needs(struct upload_pack_data *data,
    @@ upload-pack.c: static void receive_needs(struct upload_pack_data *data,
      		reset_timeout(data->timeout);
      		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
     @@ upload-pack.c: static void receive_needs(struct upload_pack_data *data,
    - 		if (data->allow_filter &&
      		    parse_feature_request(features, "filter"))
      			data->filter_capability_requested = 1;
    -+		if ((arg = parse_feature_value(features, "trace2-sid", &feature_len, NULL)))
    -+		{
    + 
    ++		arg = parse_feature_value(features, "session-id", &feature_len, NULL);
    ++		if (arg) {
     +			char *client_sid = xstrndup(arg, feature_len);
    -+			trace2_data_string("trace2", NULL, "client-sid", client_sid);
    ++			trace2_data_string("transfer", NULL, "client-sid", client_sid);
     +			free(client_sid);
     +		}
    - 
    ++
      		o = parse_object(the_repository, &oid_buf);
      		if (!o) {
    + 			packet_writer_error(&data->writer,
10:  c0b1ffc6d8 ! 10:  012949e7da send-pack: advertise trace2 SID in capabilities
    @@ Metadata
     Author: Josh Steadmon <steadmon@google.com>
     
      ## Commit message ##
    -    send-pack: advertise trace2 SID in capabilities
    +    send-pack: advertise session ID in capabilities
     
    -    When trace2 is enabled, the server sent a trace2-sid capability, and
    -    trace2.advertiseSID is true, advertise send-pack's own session ID back
    -    to the server.
    +    When the server sent a session-id capability and transfer.advertiseSID
    +    is true, advertise send-pack's own session ID back to the server.
     
     
    @@ send-pack.c: int send_pack(struct send_pack_args *args,
      	int use_sideband = 0;
      	int quiet_supported = 0;
      	int agent_supported = 0;
    -+	int server_sent_trace2_sid = 0;
    -+	int advertise_trace2_sid = 0;
    ++	int advertise_sid = 0;
      	int use_atomic = 0;
      	int atomic_supported = 0;
      	int use_push_options = 0;
    @@ send-pack.c: int send_pack(struct send_pack_args *args,
      	const char *push_cert_nonce = NULL;
      	struct packet_reader reader;
      
    -+	git_config_get_bool("trace2.advertisesid", &advertise_trace2_sid);
    ++	git_config_get_bool("transfer.advertisesid", &advertise_sid);
     +
      	/* Does the other end support the reporting? */
      	if (server_supports("report-status-v2"))
    @@ send-pack.c: int send_pack(struct send_pack_args *args,
      		quiet_supported = 1;
      	if (server_supports("agent"))
      		agent_supported = 1;
    -+	if (server_supports("trace2-sid"))
    -+		server_sent_trace2_sid = 1;
    ++	if (!server_supports("session-id"))
    ++		advertise_sid = 0;
      	if (server_supports("no-thin"))
      		args->use_thin_pack = 0;
      	if (server_supports("atomic"))
    @@ send-pack.c: int send_pack(struct send_pack_args *args,
      		strbuf_addf(&cap_buf, " object-format=%s", the_hash_algo->name);
      	if (agent_supported)
      		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
    -+	if (advertise_trace2_sid && server_sent_trace2_sid && trace2_is_enabled())
    -+		strbuf_addf(&cap_buf, " trace2-sid=%s", trace2_session_id());
    ++	if (advertise_sid)
    ++		strbuf_addf(&cap_buf, " session-id=%s", trace2_session_id());
      
      	/*
      	 * NEEDSWORK: why does delete-refs have to be so specific to
11:  c47eddd9df ! 11:  ea2a318f2b receive-pack: log received client trace2 SID
    @@ Metadata
     Author: Josh Steadmon <steadmon@google.com>
     
      ## Commit message ##
    -    receive-pack: log received client trace2 SID
    +    receive-pack: log received client session ID
     
    -    When receive-pack receives a trace2-sid capability from the client, log
    +    When receive-pack receives a session-id capability from the client, log
         the received session ID via a trace2 data event.
     
    @@ builtin/receive-pack.c: static struct command *read_head_info(struct packet_read
      		if (linelen < reader->pktlen) {
      			const char *feature_list = reader->line + linelen + 1;
      			const char *hash = NULL;
    -+			const char *client_trace2_sid;
    ++			const char *client_sid;
      			int len = 0;
      			if (parse_feature_request(feature_list, "report-status"))
      				report_status = 1;
    @@ builtin/receive-pack.c: static struct command *read_head_info(struct packet_read
      			}
      			if (xstrncmpz(the_hash_algo->name, hash, len))
      				die("error: unsupported object format '%s'", hash);
    -+			client_trace2_sid = parse_feature_value(feature_list, "trace2-sid", &len, NULL);
    -+			if (client_trace2_sid) {
    -+				char *client_sid = xstrndup(client_trace2_sid, len);
    -+				trace2_data_string("trace2", NULL, "client-sid", client_sid);
    -+				free(client_sid);
    ++			client_sid = parse_feature_value(feature_list, "session-id", &len, NULL);
    ++			if (client_sid) {
    ++				char *sid = xstrndup(client_sid, len);
    ++				trace2_data_string("transfer", NULL, "client-sid", client_sid);
    ++				free(sid);
     +			}
      		}
      
      		if (!strcmp(reader->line, "push-cert")) {
     
    - ## t/t5705-trace2-sid-in-capabilities.sh ##
    -@@ t/t5705-trace2-sid-in-capabilities.sh: do
    + ## t/t5705-session-id-in-capabilities.sh ##
    +@@ t/t5705-session-id-in-capabilities.sh: do
      	'
      
    - 	test_expect_success "trace2 session IDs not advertised by default (push v${PROTO})" '
    + 	test_expect_success "session IDs not advertised by default (push v${PROTO})" '
     -		test_when_finished "rm -rf local tr2-client-events" &&
     +		test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
     +		test_when_finished "git -C local push --delete origin new-branch" &&
    @@ t/t5705-trace2-sid-in-capabilities.sh: do
      	'
      done
      
    -@@ t/t5705-trace2-sid-in-capabilities.sh: do
    +@@ t/t5705-session-id-in-capabilities.sh: do
      	'
      
    - 	test_expect_success "trace2 session IDs advertised (push v${PROTO})" '
    + 	test_expect_success "session IDs advertised (push v${PROTO})" '
     -		test_when_finished "rm -rf local tr2-client-events" &&
     +		test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
     +		test_when_finished "git -C local push --delete origin new-branch" &&
-- 
2.29.2.222.g5d2a92d10f8-goog

