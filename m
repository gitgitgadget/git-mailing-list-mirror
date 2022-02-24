Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB32AC433FE
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiBXQaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiBXQaB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:30:01 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51A61B3735
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:29:28 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i19so172108wmq.5
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xmhs2CdtOvAvhvfUOSAMphSt/kTdXcaG3VFFEPRQ+jY=;
        b=cHuy2S/XZ7XUfOEXUnZu0UVqqAceN+c3OlcWzegRuRc8ORZ/uTEvVKwkj032BkXHHI
         UG8IPVhXL53BvP3YFL4eL4g4kGIT/szNu/S44ETo7VYQoGndI+hhzyc8Llqv8iWCXv2z
         FKcIpzn/rdar9qUEvQLCITTEim3hg7AkUYRcYInkk5PZisuGsAlM0neioL1ByMUD7y4c
         ocJuOOM+JG4FndI/qPd7/aYQLSIMjIGBdVL8uu3VnXDdlBvrznhPV+CU0Fzd6ZYsMw6O
         fvrOGWjCBh3Sz2Q16OTSDMqpIzzOUf9jN8aZq/GhklR1Jb2qwIIvL7N0LJ6TJltbGRy+
         QH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Xmhs2CdtOvAvhvfUOSAMphSt/kTdXcaG3VFFEPRQ+jY=;
        b=K0ccS6cnidF9swBwzJh8UpZAx9zOANCGucqfDW428iAu8Zvv4h2lS0dQ35YvyUqv9t
         XvcIvz6xKNCwCnn2FBCm+LoYWiBX+038lpYaeBWw1yfNXc31+UpA9KUCw/BP1wICMqSl
         CzLVgn+pgmWIjylBdNcml1JQYTbrV1SEWM4pCrQs2hHxH1Io82UAD5p6l5urbyJio0Dd
         RMv21jyye/1thJgdn+KAvxecP53cisy662JiwSsyf3lxTKAohejHyyc4aIRHWDYxw//k
         YKrucIX0lUfefPnCa1SLmSb4J0yMy9wKCCCfSXmdFLmELHo84bILO0fc4WGuRKuwYpQk
         QXtw==
X-Gm-Message-State: AOAM532XfxJYNUANT7rNvLzODv5o22BCuFj7nsKI1oqtHtNNwVwhSBMn
        5EtyNzI4lJVXTIzZbQ3wpBQXqA7e+I0=
X-Google-Smtp-Source: ABdhPJxML90jHa2gU6UbAbiLhbHdjNUYz4XZUVuP+UXMTQ2W8oYAf5lOj2pGBn22HwvWh02UIpHNow==
X-Received: by 2002:a05:600c:4f4f:b0:37b:d847:ef15 with SMTP id m15-20020a05600c4f4f00b0037bd847ef15mr11969470wmq.130.1645719223654;
        Thu, 24 Feb 2022 08:13:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm3329443wrn.60.2022.02.24.08.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:13:43 -0800 (PST)
Message-Id: <79c409d05422b02f7df9135af39cd0fa565f027a.1645719218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
        <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 16:13:34 +0000
Subject: [PATCH v2 4/8] fetch: add --repair option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Teach fetch and transports the --repair option to force a full fetch
without negotiating common commits with the remote. Use when applying a
new partial clone filter to refetch all matching objects.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 Documentation/fetch-options.txt |  9 +++++++++
 builtin/fetch.c                 | 15 ++++++++++++++-
 transport-helper.c              |  3 +++
 transport.c                     |  4 ++++
 transport.h                     |  4 ++++
 5 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index f9036831898..1131aaad252 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -163,6 +163,15 @@ endif::git-pull[]
 	behavior for a remote may be specified with the remote.<name>.tagOpt
 	setting. See linkgit:git-config[1].
 
+ifndef::git-pull[]
+--repair::
+	Instead of negotiating with the server to avoid transferring commits and
+	associated objects that are already present locally, this option fetches
+	all objects as a fresh clone would. Use this to reapply a partial clone
+	filter from configuration or using `--filter=` when the filter
+	definition has changed.
+endif::git-pull[]
+
 --refmap=<refspec>::
 	When fetching refs listed on the command line, use the
 	specified refspec (can be given more than once) to map the
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 79ee9591859..8e5e590dd6e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -59,7 +59,7 @@ static int prune_tags = -1; /* unspecified */
 
 static int all, append, dry_run, force, keep, multiple, update_head_ok;
 static int write_fetch_head = 1;
-static int verbosity, deepen_relative, set_upstream;
+static int verbosity, deepen_relative, set_upstream, repair;
 static int progress = -1;
 static int enable_auto_gc = 1;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow, deepen;
@@ -190,6 +190,9 @@ static struct option builtin_fetch_options[] = {
 	OPT_SET_INT_F(0, "unshallow", &unshallow,
 		      N_("convert to a complete repository"),
 		      1, PARSE_OPT_NONEG),
+	OPT_SET_INT_F(0, "repair", &repair,
+		      N_("re-fetch without negotiating common commits"),
+		      1, PARSE_OPT_NONEG),
 	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
 		   N_("prepend this to submodule path output"), PARSE_OPT_HIDDEN },
 	OPT_CALLBACK_F(0, "recurse-submodules-default",
@@ -1296,6 +1299,14 @@ static int check_exist_and_connected(struct ref *ref_map)
 	if (deepen)
 		return -1;
 
+	/*
+	 * Similarly, if we need to repair, we always want to perform a full
+	 * fetch ignoring existing objects.
+	 */
+	if (repair)
+		return -1;
+
+
 	/*
 	 * check_connected() allows objects to merely be promised, but
 	 * we need all direct targets to exist.
@@ -1492,6 +1503,8 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 		set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, "yes");
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
+	if (repair)
+		set_option(transport, TRANS_OPT_REPAIR, "yes");
 	if (filter_options.choice) {
 		const char *spec =
 			expand_list_objects_filter_spec(&filter_options);
diff --git a/transport-helper.c b/transport-helper.c
index a0297b0986c..a16a9626421 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -715,6 +715,9 @@ static int fetch_refs(struct transport *transport,
 	if (data->transport_options.update_shallow)
 		set_helper_option(transport, "update-shallow", "true");
 
+	if (data->transport_options.repair)
+		set_helper_option(transport, "repair", "true");
+
 	if (data->transport_options.filter_options.choice) {
 		const char *spec = expand_list_objects_filter_spec(
 			&data->transport_options.filter_options);
diff --git a/transport.c b/transport.c
index 253d6671b1f..e9c9c35b8e5 100644
--- a/transport.c
+++ b/transport.c
@@ -243,6 +243,9 @@ static int set_git_option(struct git_transport_options *opts,
 		list_objects_filter_die_if_populated(&opts->filter_options);
 		parse_list_objects_filter(&opts->filter_options, value);
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_REPAIR)) {
+		opts->repair = !!value;
+		return 0;
 	} else if (!strcmp(name, TRANS_OPT_REJECT_SHALLOW)) {
 		opts->reject_shallow = !!value;
 		return 0;
@@ -377,6 +380,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.update_shallow = data->options.update_shallow;
 	args.from_promisor = data->options.from_promisor;
 	args.filter_options = data->options.filter_options;
+	args.repair = data->options.repair;
 	args.stateless_rpc = transport->stateless_rpc;
 	args.server_options = transport->server_options;
 	args.negotiation_tips = data->options.negotiation_tips;
diff --git a/transport.h b/transport.h
index a0bc6a1e9eb..f3621e8b43c 100644
--- a/transport.h
+++ b/transport.h
@@ -16,6 +16,7 @@ struct git_transport_options {
 	unsigned update_shallow : 1;
 	unsigned reject_shallow : 1;
 	unsigned deepen_relative : 1;
+	unsigned repair : 1;
 
 	/* see documentation of corresponding flag in fetch-pack.h */
 	unsigned from_promisor : 1;
@@ -216,6 +217,9 @@ void transport_check_allowed(const char *type);
 /* Filter objects for partial clone and fetch */
 #define TRANS_OPT_LIST_OBJECTS_FILTER "filter"
 
+/* Refetch all objects without negotiating */
+#define TRANS_OPT_REPAIR "repair"
+
 /* Request atomic (all-or-nothing) updates when pushing */
 #define TRANS_OPT_ATOMIC "atomic"
 
-- 
gitgitgadget

