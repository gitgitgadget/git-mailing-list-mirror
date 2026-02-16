Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACAA2FFDF7
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248225; cv=none; b=Fy6is76BhCW1B1c8qsF2xQXE9jwFox4y5N2oXBq199Res8JhjRgst0ZTBFUyMRkIzpx0tZqwRyIZKG4uCtQGtHjPaX84ovUoYKX2YEYnlui0jggWCsDMDkkiCwdqD2ZM6SiBLnSwWSmsIbpSXf0Z8JLCzzg84jReLiOmPWrNtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248225; c=relaxed/simple;
	bh=lHiBzCEjurSwvy+qBZccXciGddw01f8o01NmWYKIVVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWIL9brrnw++KgGeC/4zcO2iK1wxG9qOwXftA2TmG0GHXZ/QkvW9oTYsFzuFbhsdJADw4oL+PjLlFYTWegwk1SnnfQwW6kI8Gq1+rdGxJWOiY8tdX5E0ebYKCAvrFNfkgw4Z9hA2qogp6EZopRkL+DRNyiGw9kZekaUlgRw9dJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYqT8YK7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYqT8YK7"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4834826e555so32756085e9.2
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 05:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771248221; x=1771853021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAvEURMMSLwqGzjE1jFmjSY0VMRCvMTTo4SkJikrg4Y=;
        b=GYqT8YK7tCXre8Um567hKQ61TSLkPygtRPBQQ51P67VLos9VFivDUCB8omxIz908Pq
         E8pn6UJGXvDwW3Dv9dv2JZiJuZm8YR6kqAK7tp18hkfOd3yPvD2bC7yFhh2XTVEEpCmq
         Rtng7ImfRzXJ1MM4quNAibF1ASeCPO9E5vD3OyomWsxVNWd45IiMotNj40e7IR9riX4/
         yhl1u/V3/Tlczg6628Id+/jW54m5TtQspthA38QGg8xB218PzJQuWgEZBXu+w5HZN0jU
         byNAkOmbF2yRfn7q7fg2g4ntToLqeoA59mj1EIoCAhK+/l9shjw4t605X9wOOfPqjFTK
         aqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771248221; x=1771853021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lAvEURMMSLwqGzjE1jFmjSY0VMRCvMTTo4SkJikrg4Y=;
        b=mFfJGPW6qg8OW8MOlw8NZ1Ocj/7pmXCC5HwkjztcPLOkfcMmsNhaZo8wElnbfl96p1
         aALt4Fbhu5csEjISooWBKaiH83GncHt00YXjCVfQo1ODhIa9bqqEQZexLnXqxGqNY0Vs
         E1fG6+nkG1azu8C0WXCtUMGOi2fVdL7CGEBzxgxqL3qHmZqEMNsAJmWNm0mbWywRNPEp
         9DoNH2We+eaa4UFAgzcZZy9pWBPsz079e438fb21tPUGD5Jrut+E6c/MByF42uXtI2mb
         1sCaQob6nwN0FYgwBec7aqg947MdKjYN41lUNUVQ3AqiUndFKCb97lbJaSia1UZDh73c
         qGVg==
X-Gm-Message-State: AOJu0YzBmUJcjlkOzfjodOcKV2AH6j8LAq5fpkIc57zgp9Wo/YRLly2n
	bLWncjaD8WFGAgMcNwGTFqUWPa/xeNkMDw/wc98a8pbWgEyiGpiQTlsD6ow8BA==
X-Gm-Gg: AZuq6aJIgxeXb4Cgi5/ie+cbECLeF4fPY/oT4opjBzsUZy5NCcHTDL7AYndvV8B/Q1v
	OLDFFT8sjchpRHsQumf1bhu3J6A4B9YqdW/1nqNByQRI0/q1VXBdIO/5kjvPeTFZC8WqgQGMSSD
	PGz0YYEbuVz9dXNXZ6v5W+TvZOpwUs4xwgptDwQ9s6UGn8k/w4oOmd7RY+5pQ6dcGtd4LpZyVyA
	/FAlR2t7EzLM5v09VtdFe1PRaL7JPkZruUi6NQV/51DIpkmEapsgC56zO5aus0tHN0B+8AO3wBU
	ia671JIiCKV/+EuH7aPgVYOdeN7BagV4sIUlS5qRPyvd/9im5vHguIhq02QNsMHi8u1Q2l6gHBy
	EQGg/kFd5NPg40xklUzozubAKhz1rc5G4KmWcU3EPZmorgBtGXYF7fys3+TQbdDCmWbgRzAkVFZ
	pJs6cDbI9kK4lPnEru51a/MvnnwmCzTrcDWntTBPdtmNzHELxftzVjtbD+oY8lEOSCZeCVsF5hx
	qaU9MaDn83nJBEJQ2kXOyWJLO/gI948dAn1scw=
X-Received: by 2002:a05:600c:c491:b0:47d:3ffa:5f03 with SMTP id 5b1f17b1804b1-48379be825emr140436465e9.21.1771248221286;
        Mon, 16 Feb 2026 05:23:41 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370ac3564sm235688025e9.5.2026.02.16.05.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 05:23:40 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 4/9] fetch: make filter_options local to cmd_fetch()
Date: Mon, 16 Feb 2026 14:23:10 +0100
Message-ID: <20260216132317.15894-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.77.g4627d513d6
In-Reply-To: <20260216132317.15894-1-christian.couder@gmail.com>
References: <20260212100843.883623-1-christian.couder@gmail.com>
 <20260216132317.15894-1-christian.couder@gmail.com>
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
index a3bc7e9380..8fbf3557ce 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -97,7 +97,6 @@ static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *gtransport;
 static struct transport *gsecondary;
 static struct refspec refmap = REFSPEC_INIT_FETCH;
-static struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
 static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
 
@@ -1562,7 +1561,8 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
 	smart_options->negotiation_tips = oids;
 }
 
-static struct transport *prepare_transport(struct remote *remote, int deepen)
+static struct transport *prepare_transport(struct remote *remote, int deepen,
+					   struct list_objects_filter_options *filter_options)
 {
 	struct transport *transport;
 
@@ -1586,9 +1586,9 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
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
@@ -1607,7 +1607,8 @@ static int backfill_tags(struct display_state *display_state,
 			 struct ref *ref_map,
 			 struct fetch_head *fetch_head,
 			 const struct fetch_config *config,
-			 struct ref_update_display_info_array *display_array)
+			 struct ref_update_display_info_array *display_array,
+			 struct list_objects_filter_options *filter_options)
 {
 	int retcode, cannot_reuse;
 
@@ -1621,7 +1622,7 @@ static int backfill_tags(struct display_state *display_state,
 	cannot_reuse = transport->cannot_reuse ||
 		deepen_since || deepen_not.nr;
 	if (cannot_reuse) {
-		gsecondary = prepare_transport(transport->remote, 0);
+		gsecondary = prepare_transport(transport->remote, 0, filter_options);
 		transport = gsecondary;
 	}
 
@@ -1834,7 +1835,8 @@ static int commit_ref_transaction(struct ref_transaction **transaction,
 
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
-		    const struct fetch_config *config)
+		    const struct fetch_config *config,
+		    struct list_objects_filter_options *filter_options)
 {
 	struct ref_transaction *transaction = NULL;
 	struct ref *ref_map = NULL;
@@ -1997,7 +1999,7 @@ static int do_fetch(struct transport *transport,
 			 * the transaction and don't commit anything.
 			 */
 			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
-					  &fetch_head, config, &display_array))
+					  &fetch_head, config, &display_array, filter_options))
 				retcode = 1;
 		}
 
@@ -2339,20 +2341,21 @@ static int fetch_multiple(struct string_list *list, int max_children,
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
@@ -2361,8 +2364,8 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * filter-spec as the default for subsequent fetches to this
 	 * remote if there is currently no default filter-spec.
 	 */
-	if (filter_options.choice) {
-		partial_clone_register(remote->name, &filter_options);
+	if (filter_options->choice) {
+		partial_clone_register(remote->name, filter_options);
 		return;
 	}
 
@@ -2371,14 +2374,15 @@ static inline void fetch_one_setup_partial(struct remote *remote)
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
@@ -2390,7 +2394,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 		die(_("no remote repository specified; please specify either a URL or a\n"
 		      "remote name from which new revisions should be fetched"));
 
-	gtransport = prepare_transport(remote, 1);
+	gtransport = prepare_transport(remote, 1, filter_options);
 
 	if (prune < 0) {
 		/* no command line request */
@@ -2445,7 +2449,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack_atexit);
 	sigchain_push(SIGPIPE, SIG_IGN);
-	exit_code = do_fetch(gtransport, &rs, config);
+	exit_code = do_fetch(gtransport, &rs, config, filter_options);
 	sigchain_pop(SIGPIPE);
 	refspec_clear(&rs);
 	transport_disconnect(gtransport);
@@ -2470,6 +2474,7 @@ int cmd_fetch(int argc,
 	const char *submodule_prefix = "";
 	const char *bundle_uri;
 	struct string_list list = STRING_LIST_INIT_DUP;
+	struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
 	struct remote *remote = NULL;
 	int all = -1, multiple = 0;
 	int result = 0;
@@ -2735,7 +2740,7 @@ int cmd_fetch(int argc,
 		trace2_region_enter("fetch", "negotiate-only", the_repository);
 		if (!remote)
 			die(_("must supply remote when using --negotiate-only"));
-		gtransport = prepare_transport(remote, 1);
+		gtransport = prepare_transport(remote, 1, &filter_options);
 		if (gtransport->smart_options) {
 			gtransport->smart_options->acked_commits = &acked_commits;
 		} else {
@@ -2757,12 +2762,12 @@ int cmd_fetch(int argc,
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
@@ -2868,5 +2873,6 @@ int cmd_fetch(int argc,
 
  cleanup:
 	string_list_clear(&list, 0);
+	list_objects_filter_release(&filter_options);
 	return result;
 }
-- 
2.53.0.77.g4627d513d6

