Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5DA3E8C7F
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203322; cv=none; b=b5gWhzOZveIVhQymfoKfwW7gBs74BATyWveTnNausMhgVe51GT79i5QtRUXhoZTh+cnrpu6njKD7ltPywZUfNKYqVd9vLeFYE0B3mvKNWfj70fYPT40vIXr5UPOQVPeSwvqjaSYBLafNH5QZz/fTbMQfpduWYs/mun+nudKLKOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203322; c=relaxed/simple;
	bh=0AavYfnJjyK1mW0mGGELEzgmktIZkjraIkPz12ceAeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjbZmB/8LWdzOy1XVG8dC8eDIATawVzyTpV5BjVINfgSZHE5B7KluhvxXpZwEGvdj8d9IlJCOpYNqY+HGsCjIuYXNOJgXKetaMSMBk4FeEbNcniD9X7MPYPJIRzFFDimbkM4JHGxJS0d7gz+FnxBPzIeDtq84oM4to5xOWHC4/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTOBTEi0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTOBTEi0"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbc305914so6008503f8f.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 03:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770203320; x=1770808120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meEIkblsG/yTjHX5+nTSI/aCHE2xypCWUC4CthaeeVA=;
        b=gTOBTEi0ksqFDfvAkxDF0mDW1rGc3Gl3MxSgou5VcrpeKVanQ/dO/Vqz0U/6MrlDaE
         pD+W8iVrlPQjx7f7lxSuQorZ6mvVrWjhgs/b+G71tmnH7T6Mestbi/fYwxhgo4bwjcWx
         9K9rtYKXtRAv1Sahsm3LGBrLSzOrI/FGeOJOo4XkZvZxZYhZ1CcdqxER9blimW5a1S7P
         EIb0hbdH+u3JmKp1mVEW5i1hDqUM6TPcGq0qw2bPhuEdqne/eY90hGEW46iHzimhPV8R
         Po1WQjJg789jGmNxXk2ReXtx0PM4HJcUDlrdcxbKYl8IqwfrWXQr2Q2d6YwyPhJAyeu5
         IDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203320; x=1770808120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=meEIkblsG/yTjHX5+nTSI/aCHE2xypCWUC4CthaeeVA=;
        b=bXU2EhJBxdjtau1i0wosKgPuWn4QlXlDSb3/BOPe3Jn469xgTWPNVpuxoUk3gN3cuM
         uPal62+nBKzne0O/5CQQSwkr+9GjA02qzvhWJ7XW/Ua8AF5p+L2iB0hOdH4a+DiaaF2J
         nmJe7Kx8RPD96LkRF8JR3/LAqqsL3UL/Hx5K1MZqLQt4PteVEbf7cj0Ti7r7KwSVR/Hr
         vMswxZg3j6txCpj0VJmDVzdMZI2kiplSCz1iP6WTAoOg8o1U6NBWed0T0/2sFihHI/hG
         Spg0n79UDjxigGbyw+95yLvcK6xARY+0gDB/qSA0Mli/BnRT761slDOGl1qtRCjeMLqp
         FBbA==
X-Gm-Message-State: AOJu0YwLTdnru80NStReGD74iI8FgHORwssB7k9AuqmFWLOSJE5juydf
	Iefk7o67EMn3j5yoBSdScdlHinrUZLfFnsGsGQgYQXdnOUVrU+4EJsFDIVB+Ig==
X-Gm-Gg: AZuq6aLhsQtzyHEMRRvwW2Ru17Mm2y+AtohHKdjegnQBHPxQPCrZR4dhwDqn6dMJSeQ
	s/iZTJ125BcesB7A2zHZjB4BAj/5bEpGka9eCfpwXFh126bA/CJIr95IS9ARvffCuo6LNCWaAaV
	Z9P4gjZmxzwmAQgbYKk+a2zmOl51S7KnGYHMPPEEXgGkyYq5WnnddZFNeleanYHX449nZcnMvHZ
	JcHRuJCvNsuVXKcdEypNss4SK6kWgjcf/F3gC/cAB/jr0QS3MqY29R5kNe6XdIdmXjs0XZ8wMFE
	1Wl0OQZjLV8Jr0Itjpz0uqbAUNWf8WN26x71igsZGqc0RX7EGq5ZQeolRUupOCBHMWQ+8khwQwv
	BARLpBqoasD81nCXzmEPNdqCpCRoqHn6BNBBIw217SLKsz4eXzJsF0XIaSGX91Aszxpz56Vv0om
	HhOB1Hye5Vl5ilYzmQjhqynGypjVdZi4M5kJklRTai3BjbjlqOn77eoHzcEDG7TAOo0E7XQCZx2
	1KulPQ/K1BtYGHMwYRFr9OGsYQ=
X-Received: by 2002:a05:6000:2481:b0:430:f742:fbb8 with SMTP id ffacd0b85a97d-43617e3c8damr3521915f8f.21.1770203319729;
        Wed, 04 Feb 2026 03:08:39 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436180640f2sm5340096f8f.39.2026.02.04.03.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:08:38 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/8] fetch: make filter_options local to cmd_fetch()
Date: Wed,  4 Feb 2026 12:08:09 +0100
Message-ID: <20260204110818.2919273-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.10.g12663a1c75.dirty
In-Reply-To: <20260204110818.2919273-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260204110818.2919273-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `struct list_objects_filter_options filter_options` variable used
in "builtin/fetch.c" to store the parsed filters specified by
`--filter=<filterspec>` is currently a static variable global to the
file.

As we are going to use it more in a following commit, it could become a
bit less easy to understand how it's managed.

To avoid that, let's make it clear that it's owned by cmd_fetch() by
moving its definition into that function and making it non-static.

This requires passing a pointer to it through the prepare_transport(),
do_fetch(), backfill_tags(), fetch_one_setup_partial(), and fetch_one()
functions, but it's quite straightforward.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fetch.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 288d3772ea..b984173447 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -97,7 +97,6 @@ static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *gtransport;
 static struct transport *gsecondary;
 static struct refspec refmap = REFSPEC_INIT_FETCH;
-static struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
 static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
 
@@ -1449,7 +1448,8 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
 	smart_options->negotiation_tips = oids;
 }
 
-static struct transport *prepare_transport(struct remote *remote, int deepen)
+static struct transport *prepare_transport(struct remote *remote, int deepen,
+					   struct list_objects_filter_options *filter_options)
 {
 	struct transport *transport;
 
@@ -1473,9 +1473,9 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
 	if (refetch)
 		set_option(transport, TRANS_OPT_REFETCH, "yes");
-	if (filter_options.choice) {
+	if (filter_options->choice) {
 		const char *spec =
-			expand_list_objects_filter_spec(&filter_options);
+			expand_list_objects_filter_spec(filter_options);
 		set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER, spec);
 		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
 	}
@@ -1493,7 +1493,8 @@ static int backfill_tags(struct display_state *display_state,
 			 struct ref_transaction *transaction,
 			 struct ref *ref_map,
 			 struct fetch_head *fetch_head,
-			 const struct fetch_config *config)
+			 const struct fetch_config *config,
+			 struct list_objects_filter_options *filter_options)
 {
 	int retcode, cannot_reuse;
 
@@ -1507,7 +1508,7 @@ static int backfill_tags(struct display_state *display_state,
 	cannot_reuse = transport->cannot_reuse ||
 		deepen_since || deepen_not.nr;
 	if (cannot_reuse) {
-		gsecondary = prepare_transport(transport->remote, 0);
+		gsecondary = prepare_transport(transport->remote, 0, filter_options);
 		transport = gsecondary;
 	}
 
@@ -1713,7 +1714,8 @@ static int commit_ref_transaction(struct ref_transaction **transaction,
 
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
-		    const struct fetch_config *config)
+		    const struct fetch_config *config,
+		    struct list_objects_filter_options *filter_options)
 {
 	struct ref_transaction *transaction = NULL;
 	struct ref *ref_map = NULL;
@@ -1873,7 +1875,7 @@ static int do_fetch(struct transport *transport,
 			 * the transaction and don't commit anything.
 			 */
 			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
-					  &fetch_head, config))
+					  &fetch_head, config, filter_options))
 				retcode = 1;
 		}
 
@@ -2198,20 +2200,21 @@ static int fetch_multiple(struct string_list *list, int max_children,
  * Fetching from the promisor remote should use the given filter-spec
  * or inherit the default filter-spec from the config.
  */
-static inline void fetch_one_setup_partial(struct remote *remote)
+static inline void fetch_one_setup_partial(struct remote *remote,
+					   struct list_objects_filter_options *filter_options)
 {
 	/*
 	 * Explicit --no-filter argument overrides everything, regardless
 	 * of any prior partial clones and fetches.
 	 */
-	if (filter_options.no_filter)
+	if (filter_options->no_filter)
 		return;
 
 	/*
 	 * If no prior partial clone/fetch and the current fetch DID NOT
 	 * request a partial-fetch, do a normal fetch.
 	 */
-	if (!repo_has_promisor_remote(the_repository) && !filter_options.choice)
+	if (!repo_has_promisor_remote(the_repository) && !filter_options->choice)
 		return;
 
 	/*
@@ -2220,8 +2223,8 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * filter-spec as the default for subsequent fetches to this
 	 * remote if there is currently no default filter-spec.
 	 */
-	if (filter_options.choice) {
-		partial_clone_register(remote->name, &filter_options);
+	if (filter_options->choice) {
+		partial_clone_register(remote->name, filter_options);
 		return;
 	}
 
@@ -2230,14 +2233,15 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * explicitly given filter-spec or inherit the filter-spec from
 	 * the config.
 	 */
-	if (!filter_options.choice)
-		partial_clone_get_default_filter_spec(&filter_options, remote->name);
+	if (!filter_options->choice)
+		partial_clone_get_default_filter_spec(filter_options, remote->name);
 	return;
 }
 
 static int fetch_one(struct remote *remote, int argc, const char **argv,
 		     int prune_tags_ok, int use_stdin_refspecs,
-		     const struct fetch_config *config)
+		     const struct fetch_config *config,
+		     struct list_objects_filter_options *filter_options)
 {
 	struct refspec rs = REFSPEC_INIT_FETCH;
 	int i;
@@ -2249,7 +2253,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 		die(_("no remote repository specified; please specify either a URL or a\n"
 		      "remote name from which new revisions should be fetched"));
 
-	gtransport = prepare_transport(remote, 1);
+	gtransport = prepare_transport(remote, 1, filter_options);
 
 	if (prune < 0) {
 		/* no command line request */
@@ -2304,7 +2308,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack_atexit);
 	sigchain_push(SIGPIPE, SIG_IGN);
-	exit_code = do_fetch(gtransport, &rs, config);
+	exit_code = do_fetch(gtransport, &rs, config, filter_options);
 	sigchain_pop(SIGPIPE);
 	refspec_clear(&rs);
 	transport_disconnect(gtransport);
@@ -2329,6 +2333,7 @@ int cmd_fetch(int argc,
 	const char *submodule_prefix = "";
 	const char *bundle_uri;
 	struct string_list list = STRING_LIST_INIT_DUP;
+	struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
 	struct remote *remote = NULL;
 	int all = -1, multiple = 0;
 	int result = 0;
@@ -2594,7 +2599,7 @@ int cmd_fetch(int argc,
 		trace2_region_enter("fetch", "negotiate-only", the_repository);
 		if (!remote)
 			die(_("must supply remote when using --negotiate-only"));
-		gtransport = prepare_transport(remote, 1);
+		gtransport = prepare_transport(remote, 1, &filter_options);
 		if (gtransport->smart_options) {
 			gtransport->smart_options->acked_commits = &acked_commits;
 		} else {
@@ -2616,12 +2621,12 @@ int cmd_fetch(int argc,
 	} else if (remote) {
 		if (filter_options.choice || repo_has_promisor_remote(the_repository)) {
 			trace2_region_enter("fetch", "setup-partial", the_repository);
-			fetch_one_setup_partial(remote);
+			fetch_one_setup_partial(remote, &filter_options);
 			trace2_region_leave("fetch", "setup-partial", the_repository);
 		}
 		trace2_region_enter("fetch", "fetch-one", the_repository);
 		result = fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs,
-				   &config);
+				   &config, &filter_options);
 		trace2_region_leave("fetch", "fetch-one", the_repository);
 	} else {
 		int max_children = max_jobs;
@@ -2727,5 +2732,6 @@ int cmd_fetch(int argc,
 
  cleanup:
 	string_list_clear(&list, 0);
+	list_objects_filter_release(&filter_options);
 	return result;
 }
-- 
2.53.0.rc2.10.g12663a1c75.dirty

