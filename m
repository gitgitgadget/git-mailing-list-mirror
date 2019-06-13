Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E7491F462
	for <e@80x24.org>; Thu, 13 Jun 2019 21:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfFMVv4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 17:51:56 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:37752 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfFMVv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 17:51:56 -0400
Received: by mail-pf1-f201.google.com with SMTP id x18so227200pfj.4
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JxhK+NbdgJBvX9OYysVJxoFmUlB9RND4qPUaU4M2v3c=;
        b=uQpeXl6NUCHgnsiO5KRDmM4bBab9P/DD8jXFGnN+m+uKY9pAPw8AKDLjroWKrgIHy3
         3jwS7QFw/wU7l/L8L1QuMFMICEIuMmrnNB6Kmmi7wfY0MlEXdb0z73T6NdDWKTuZfa3O
         lG4GWQHPUxvRZKY23ZUw/GiwSeIX7hdYVGXjDdJ2qoD92iaT6kEeT2KVcZkX4yonwSSb
         DBi2LLvaYohGfS9HPoYwRwvpDctAiOVzJ6byPgYxIa3okpUrDmIk3KSOC1xVM0W2kA7U
         3xzN2FSJEBW4NnZAC2YwLKAqfyreBiCR/kZjZifvoczqxq2q3fAH72Y/uFpyjHeQ8LpH
         qv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JxhK+NbdgJBvX9OYysVJxoFmUlB9RND4qPUaU4M2v3c=;
        b=axy14jqRopbfZFHjgt7o3AgBJ8yk+tllkvRV/FWHmh7vOzuFXDATETgn2YAYNFyegC
         Q3ChP5f+CpMLxUriigOk8qw23GmKfP90ywxkH4zYfklcRhJ+kiVh+fXc7vgSxOsrqt8N
         g7zHw9dXGB7tay/IP/1K/CZ5wrAnSrf8NZOOtyh9/+DR5hf2duL5O18vD7I8wrJ4HRpE
         JWUlSI7c/sVUx4XtBKL7/E7ieoN0QG89EQGg4Pv8K8DyTzMyGdc+lkPE5fAA6rhKT4Hu
         33ohj8tP0T/97XmdutVOh2RBHdaMMUsCR8bh/4f4bhlMEdeEN3sCRvV91VjL8WvdMCit
         W7hA==
X-Gm-Message-State: APjAAAWc13+ZnE4rIOc7DirHfNqMoq0zdN558mbLLkWeKUkjhsCDQj4/
        tdvmQqTYPkqbIQngDfef4Wrw96pbdEgWvnzHUCkQ6yccN1I0p1X3eVQlRJ3T97w4lCOfep+bQdO
        IU5emAMkOpTfXm3cg7c8w1oaVKQpIGkx4mdBWHc8dLluIw80JDr6zTDhjcns=
X-Google-Smtp-Source: APXvYqwQbtuLgnJH0w5KK4c/rxabatEFxdcZvq32LJnXxnEaxGw9wSKRnF184eAdKUi+68tyGp+h1xM0YJpF
X-Received: by 2002:a63:234e:: with SMTP id u14mr20922445pgm.13.1560462714116;
 Thu, 13 Jun 2019 14:51:54 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:51:29 -0700
In-Reply-To: <cover.1560462201.git.matvore@google.com>
Message-Id: <23706c83ef114f0d9c89904e06e223bed3dc007a.1560462201.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1560462201.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v3 06/10] list-objects-filter-options: make filter_spec a string_list
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the filter_spec string a string_list rather than a raw C string.
The list of strings must be concatted together to make a complete
filter_spec. A future patch will use this capability to build "combine:"
filter specs gradually.

A strbuf would seem to be a more natural choice for this object, but it
unfortunately requires initialization besides just zero'ing out the
memory.  This results in all container structs, and all containers of
those structs, etc., to also require initialization. Initializing them
all would be more cumbersome that simply using a string_list, which
behaves properly when its contents are zero'd.

For the purposes of code simplification, change behavior in how filter
specs are conveyed over the protocol: do not normalize the tree:<depth>
filter specs since there should be no server in existence that supports
tree:# but not tree:#k etc.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Matthew DeVore <matvore@google.com>
---
 builtin/clone.c                     |  8 ++---
 builtin/fetch.c                     |  9 ++----
 builtin/rev-list.c                  |  6 ++--
 fetch-pack.c                        | 20 ++++--------
 list-objects-filter-options.c       | 50 ++++++++++++++++++++---------
 list-objects-filter-options.h       | 27 +++++++++++-----
 t/t6112-rev-list-filters-objects.sh |  7 ----
 transport-helper.c                  | 10 ++----
 upload-pack.c                       | 11 +++----
 9 files changed, 78 insertions(+), 70 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 85b0d3155d..81e6010779 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1135,27 +1135,25 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 
 	if (option_upload_pack)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
 
 	if (server_options.nr)
 		transport->server_options = &server_options;
 
 	if (filter_options.choice) {
-		struct strbuf expanded_filter_spec = STRBUF_INIT;
-		expand_list_objects_filter_spec(&filter_options,
-						&expanded_filter_spec);
+		const char *spec =
+			expand_list_objects_filter_spec(&filter_options);
 		transport_set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER,
-				     expanded_filter_spec.buf);
+				     spec);
 		transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
-		strbuf_release(&expanded_filter_spec);
 	}
 
 	if (transport->smart_options && !deepen && !filter_options.choice)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
 
 	argv_array_push(&ref_prefixes, "HEAD");
 	refspec_ref_prefixes(&remote->fetch, &ref_prefixes);
 	if (option_branch)
 		expand_ref_prefix(&ref_prefixes, option_branch);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4ba63d5ac6..dee89e1a19 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1181,27 +1181,24 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 	if (deepen && deepen_since)
 		set_option(transport, TRANS_OPT_DEEPEN_SINCE, deepen_since);
 	if (deepen && deepen_not.nr)
 		set_option(transport, TRANS_OPT_DEEPEN_NOT,
 			   (const char *)&deepen_not);
 	if (deepen_relative)
 		set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, "yes");
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
 	if (filter_options.choice) {
-		struct strbuf expanded_filter_spec = STRBUF_INIT;
-		expand_list_objects_filter_spec(&filter_options,
-						&expanded_filter_spec);
-		set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER,
-			   expanded_filter_spec.buf);
+		const char *spec =
+			expand_list_objects_filter_spec(&filter_options);
+		set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER, spec);
 		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
-		strbuf_release(&expanded_filter_spec);
 	}
 	if (negotiation_tip.nr) {
 		if (transport->smart_options)
 			add_negotiation_tips(transport->smart_options);
 		else
 			warning("Ignoring --negotiation-tip because the protocol does not support it.");
 	}
 	return transport;
 }
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 9f31837d30..823e87c1c9 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -459,22 +459,24 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			show_progress = arg;
 			continue;
 		}
 
 		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
 			parse_list_objects_filter(&filter_options, arg);
 			if (filter_options.choice && !revs.blob_objects)
 				die(_("object filtering requires --objects"));
 			if (filter_options.choice == LOFC_SPARSE_OID &&
 			    !filter_options.sparse_oid_value)
-				die(_("invalid sparse value '%s'"),
-				    filter_options.filter_spec);
+				die(
+					_("invalid sparse value '%s'"),
+					list_objects_filter_spec(
+						&filter_options));
 			continue;
 		}
 		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
 			list_objects_filter_set_no_filter(&filter_options);
 			continue;
 		}
 		if (!strcmp(arg, "--filter-print-omitted")) {
 			arg_print_omitted = 1;
 			continue;
 		}
diff --git a/fetch-pack.c b/fetch-pack.c
index 1c10f54e78..72e13b0a1d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -332,26 +332,23 @@ static int find_common(struct fetch_negotiator *negotiator,
 		packet_buf_write(&req_buf, "deepen-since %"PRItime, max_age);
 	}
 	if (args->deepen_not) {
 		int i;
 		for (i = 0; i < args->deepen_not->nr; i++) {
 			struct string_list_item *s = args->deepen_not->items + i;
 			packet_buf_write(&req_buf, "deepen-not %s", s->string);
 		}
 	}
 	if (server_supports_filtering && args->filter_options.choice) {
-		struct strbuf expanded_filter_spec = STRBUF_INIT;
-		expand_list_objects_filter_spec(&args->filter_options,
-						&expanded_filter_spec);
-		packet_buf_write(&req_buf, "filter %s",
-				 expanded_filter_spec.buf);
-		strbuf_release(&expanded_filter_spec);
+		const char *spec =
+			expand_list_objects_filter_spec(&args->filter_options);
+		packet_buf_write(&req_buf, "filter %s", spec);
 	}
 	packet_buf_flush(&req_buf);
 	state_len = req_buf.len;
 
 	if (args->deepen) {
 		const char *arg;
 		struct object_id oid;
 
 		send_request(args, fd[1], &req_buf);
 		while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
@@ -1092,21 +1089,21 @@ static int add_haves(struct fetch_negotiator *negotiator,
 		ret = 1;
 	}
 
 	/* Increase haves to send on next round */
 	*haves_to_send = next_flush(1, *haves_to_send);
 
 	return ret;
 }
 
 static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
-			      const struct fetch_pack_args *args,
+			      struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
 			      int *haves_to_send, int *in_vain,
 			      int sideband_all)
 {
 	int ret = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
 	if (server_supports_v2("fetch", 1))
 		packet_buf_write(&req_buf, "command=fetch");
 	if (server_supports_v2("agent", 0))
@@ -1133,27 +1130,24 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 
 	/* Add shallow-info and deepen request */
 	if (server_supports_feature("fetch", "shallow", 0))
 		add_shallow_requests(&req_buf, args);
 	else if (is_repository_shallow(the_repository) || args->deepen)
 		die(_("Server does not support shallow requests"));
 
 	/* Add filter */
 	if (server_supports_feature("fetch", "filter", 0) &&
 	    args->filter_options.choice) {
-		struct strbuf expanded_filter_spec = STRBUF_INIT;
+		const char *spec =
+			expand_list_objects_filter_spec(&args->filter_options);
 		print_verbose(args, _("Server supports filter"));
-		expand_list_objects_filter_spec(&args->filter_options,
-						&expanded_filter_spec);
-		packet_buf_write(&req_buf, "filter %s",
-				 expanded_filter_spec.buf);
-		strbuf_release(&expanded_filter_spec);
+		packet_buf_write(&req_buf, "filter %s", spec);
 	} else if (args->filter_options.choice) {
 		warning("filtering not recognized by server, ignoring");
 	}
 
 	/* add wants */
 	add_wants(args->no_dependents, wants, &req_buf);
 
 	if (args->no_dependents) {
 		packet_buf_write(&req_buf, "done");
 		ret = 1;
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 5ff5135a91..c9dd41cd06 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -174,73 +174,90 @@ static int parse_combine_filter(
 	}
 	return result;
 }
 
 int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
 			      const char *arg)
 {
 	struct strbuf buf = STRBUF_INIT;
 	if (filter_options->choice)
 		die(_("multiple filter-specs cannot be combined"));
-	filter_options->filter_spec = strdup(arg);
+	string_list_append(&filter_options->filter_spec, xstrdup(arg));
 	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
 		die("%s", buf.buf);
 	return 0;
 }
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset)
 {
 	struct list_objects_filter_options *filter_options = opt->value;
 
 	if (unset || !arg) {
 		list_objects_filter_set_no_filter(filter_options);
 		return 0;
 	}
 
 	return parse_list_objects_filter(filter_options, arg);
 }
 
-void expand_list_objects_filter_spec(
-	const struct list_objects_filter_options *filter,
-	struct strbuf *expanded_spec)
+const char *list_objects_filter_spec(struct list_objects_filter_options *filter)
 {
-	strbuf_init(expanded_spec, strlen(filter->filter_spec));
-	if (filter->choice == LOFC_BLOB_LIMIT)
-		strbuf_addf(expanded_spec, "blob:limit=%lu",
+	if (!filter->filter_spec.nr)
+		BUG("no filter_spec available for this filter");
+	if (filter->filter_spec.nr != 1) {
+		struct strbuf concatted = STRBUF_INIT;
+		strbuf_add_separated_string_list(
+			&concatted, "", &filter->filter_spec);
+		string_list_clear(&filter->filter_spec, /*free_util=*/0);
+		string_list_append(
+			&filter->filter_spec, strbuf_detach(&concatted, NULL));
+	}
+
+	return filter->filter_spec.items[0].string;
+}
+
+const char *expand_list_objects_filter_spec(
+	struct list_objects_filter_options *filter)
+{
+	if (filter->choice == LOFC_BLOB_LIMIT) {
+		struct strbuf expanded_spec = STRBUF_INIT;
+		strbuf_addf(&expanded_spec, "blob:limit=%lu",
 			    filter->blob_limit_value);
-	else if (filter->choice == LOFC_TREE_DEPTH)
-		strbuf_addf(expanded_spec, "tree:%lu",
-			    filter->tree_exclude_depth);
-	else
-		strbuf_addstr(expanded_spec, filter->filter_spec);
+		string_list_clear(&filter->filter_spec, /*free_util=*/0);
+		string_list_append(
+			&filter->filter_spec,
+			strbuf_detach(&expanded_spec, NULL));
+	}
+
+	return list_objects_filter_spec(filter);
 }
 
 void list_objects_filter_release(
 	struct list_objects_filter_options *filter_options)
 {
 	size_t sub;
 
 	if (!filter_options)
 		return;
-	free(filter_options->filter_spec);
+	string_list_clear(&filter_options->filter_spec, /*free_util=*/0);
 	free(filter_options->sparse_oid_value);
 	free(filter_options->sparse_path_value);
 	for (sub = 0; sub < filter_options->sub_nr; sub++)
 		list_objects_filter_release(&filter_options->sub[sub]);
 	free(filter_options->sub);
 	memset(filter_options, 0, sizeof(*filter_options));
 }
 
 void partial_clone_register(
 	const char *remote,
-	const struct list_objects_filter_options *filter_options)
+	struct list_objects_filter_options *filter_options)
 {
 	/*
 	 * Record the name of the partial clone remote in the
 	 * config and in the global variable -- the latter is
 	 * used throughout to indicate that partial clone is
 	 * enabled and to expect missing objects.
 	 */
 	if (repository_format_partial_clone &&
 	    *repository_format_partial_clone &&
 	    strcmp(remote, repository_format_partial_clone))
@@ -249,32 +266,33 @@ void partial_clone_register(
 	git_config_set("core.repositoryformatversion", "1");
 	git_config_set("extensions.partialclone", remote);
 
 	repository_format_partial_clone = xstrdup(remote);
 
 	/*
 	 * Record the initial filter-spec in the config as
 	 * the default for subsequent fetches from this remote.
 	 */
 	core_partial_clone_filter_default =
-		xstrdup(filter_options->filter_spec);
+		xstrdup(expand_list_objects_filter_spec(filter_options));
 	git_config_set("core.partialclonefilter",
 		       core_partial_clone_filter_default);
 }
 
 void partial_clone_get_default_filter_spec(
 	struct list_objects_filter_options *filter_options)
 {
 	struct strbuf errbuf = STRBUF_INIT;
 
 	/*
 	 * Parse default value, but silently ignore it if it is invalid.
 	 */
 	if (!core_partial_clone_filter_default)
 		return;
 
-	filter_options->filter_spec = strdup(core_partial_clone_filter_default);
+	string_list_append(&filter_options->filter_spec,
+			   core_partial_clone_filter_default);
 	gently_parse_list_objects_filter(filter_options,
 					 core_partial_clone_filter_default,
 					 &errbuf);
 	strbuf_release(&errbuf);
 }
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 8f08ed74a1..1786c80eb4 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -1,15 +1,15 @@
 #ifndef LIST_OBJECTS_FILTER_OPTIONS_H
 #define LIST_OBJECTS_FILTER_OPTIONS_H
 
 #include "parse-options.h"
-#include "strbuf.h"
+#include "string-list.h"
 
 /*
  * The list of defined filters for list-objects.
  */
 enum list_objects_filter_choice {
 	LOFC_DISABLED = 0,
 	LOFC_BLOB_NONE,
 	LOFC_BLOB_LIMIT,
 	LOFC_TREE_DEPTH,
 	LOFC_SPARSE_OID,
@@ -18,22 +18,24 @@ enum list_objects_filter_choice {
 	LOFC__COUNT /* must be last */
 };
 
 struct list_objects_filter_options {
 	/*
 	 * 'filter_spec' is the raw argument value given on the command line
 	 * or protocol request.  (The part after the "--keyword=".)  For
 	 * commands that launch filtering sub-processes, or for communication
 	 * over the network, don't use this value; use the result of
 	 * expand_list_objects_filter_spec() instead.
+	 * To get the raw filter spec given by the user, use the result of
+	 * list_objects_filter_spec().
 	 */
-	char *filter_spec;
+	struct string_list filter_spec;
 
 	/*
 	 * 'choice' is determined by parsing the filter-spec.  This indicates
 	 * the filtering algorithm to use.
 	 */
 	enum list_objects_filter_choice choice;
 
 	/*
 	 * Choice is LOFC_DISABLED because "--no-filter" was requested.
 	 */
@@ -71,35 +73,44 @@ int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset);
 
 #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
 	{ OPTION_CALLBACK, 0, CL_ARG__FILTER, fo, N_("args"), \
 	  N_("object filtering"), 0, \
 	  opt_parse_list_objects_filter }
 
 /*
  * Translates abbreviated numbers in the filter's filter_spec into their
  * fully-expanded forms (e.g., "limit:blob=1k" becomes "limit:blob=1024").
+ * Returns a string owned by the list_objects_filter_options object.
  *
- * This form should be used instead of the raw filter_spec field when
- * communicating with a remote process or subprocess.
+ * This form should be used instead of the raw list_objects_filter_spec()
+ * value when communicating with a remote process or subprocess.
  */
-void expand_list_objects_filter_spec(
-	const struct list_objects_filter_options *filter,
-	struct strbuf *expanded_spec);
+const char *expand_list_objects_filter_spec(
+	struct list_objects_filter_options *filter);
+
+/*
+ * Returns the filter spec string more or less in the form as the user
+ * entered it. This form of the filter_spec can be used in user-facing
+ * messages.  Returns a string owned by the list_objects_filter_options
+ * object.
+ */
+const char *list_objects_filter_spec(
+	struct list_objects_filter_options *filter);
 
 void list_objects_filter_release(
 	struct list_objects_filter_options *filter_options);
 
 static inline void list_objects_filter_set_no_filter(
 	struct list_objects_filter_options *filter_options)
 {
 	list_objects_filter_release(filter_options);
 	filter_options->no_filter = 1;
 }
 
 void partial_clone_register(
 	const char *remote,
-	const struct list_objects_filter_options *filter_options);
+	struct list_objects_filter_options *filter_options);
 void partial_clone_get_default_filter_spec(
 	struct list_objects_filter_options *filter_options);
 
 #endif /* LIST_OBJECTS_FILTER_OPTIONS_H */
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index a87341e051..4523c8f066 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -596,18 +596,11 @@ test_expect_success 'rev-list W/ missing=allow-any' '
 # Test expansion of filter specs.
 
 test_expect_success 'expand blob limit in protocol' '
 	git -C r2 config --local uploadpack.allowfilter 1 &&
 	GIT_TRACE_PACKET="$(pwd)/trace" git -c protocol.version=2 clone \
 		--filter=blob:limit=1k "file://$(pwd)/r2" limit &&
 	! grep "blob:limit=1k" trace &&
 	grep "blob:limit=1024" trace
 '
 
-test_expect_success 'expand tree depth limit in protocol' '
-	GIT_TRACE_PACKET="$(pwd)/tree_trace" git -c protocol.version=2 clone \
-		--filter=tree:0k "file://$(pwd)/r2" tree &&
-	! grep "tree:0k" tree_trace &&
-	grep "tree:0" tree_trace
-'
-
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index cec83bd663..d6313ef9f5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -675,27 +675,23 @@ static int fetch(struct transport *transport,
 	    data->transport_options.check_self_contained_and_connected)
 		set_helper_option(transport, "check-connectivity", "true");
 
 	if (transport->cloning)
 		set_helper_option(transport, "cloning", "true");
 
 	if (data->transport_options.update_shallow)
 		set_helper_option(transport, "update-shallow", "true");
 
 	if (data->transport_options.filter_options.choice) {
-		struct strbuf expanded_filter_spec = STRBUF_INIT;
-		expand_list_objects_filter_spec(
-			&data->transport_options.filter_options,
-			&expanded_filter_spec);
-		set_helper_option(transport, "filter",
-				  expanded_filter_spec.buf);
-		strbuf_release(&expanded_filter_spec);
+		const char *spec = expand_list_objects_filter_spec(
+			&data->transport_options.filter_options);
+		set_helper_option(transport, "filter", spec);
 	}
 
 	if (data->transport_options.negotiation_tips)
 		warning("Ignoring --negotiation-tip because the protocol does not support it.");
 
 	if (data->fetch)
 		return fetch_with_fetch(transport, nr_heads, to_fetch);
 
 	if (data->import)
 		return fetch_with_import(transport, nr_heads, to_fetch);
diff --git a/upload-pack.c b/upload-pack.c
index 24298913c0..a74d293fef 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -133,32 +133,31 @@ static void create_pack_file(const struct object_array *have_obj,
 
 	argv_array_push(&pack_objects.args, "--stdout");
 	if (shallow_nr)
 		argv_array_push(&pack_objects.args, "--shallow");
 	if (!no_progress)
 		argv_array_push(&pack_objects.args, "--progress");
 	if (use_ofs_delta)
 		argv_array_push(&pack_objects.args, "--delta-base-offset");
 	if (use_include_tag)
 		argv_array_push(&pack_objects.args, "--include-tag");
-	if (filter_options.filter_spec) {
-		struct strbuf expanded_filter_spec = STRBUF_INIT;
-		expand_list_objects_filter_spec(&filter_options,
-						&expanded_filter_spec);
+	if (filter_options.choice) {
+		const char *spec =
+			expand_list_objects_filter_spec(&filter_options);
 		if (pack_objects.use_shell) {
 			struct strbuf buf = STRBUF_INIT;
-			sq_quote_buf(&buf, expanded_filter_spec.buf);
+			sq_quote_buf(&buf, spec);
 			argv_array_pushf(&pack_objects.args, "--filter=%s", buf.buf);
 			strbuf_release(&buf);
 		} else {
 			argv_array_pushf(&pack_objects.args, "--filter=%s",
-					 expanded_filter_spec.buf);
+					 spec);
 		}
 	}
 
 	pack_objects.in = -1;
 	pack_objects.out = -1;
 	pack_objects.err = -1;
 
 	if (start_command(&pack_objects))
 		die("git upload-pack: unable to fork git-pack-objects");
 
-- 
2.21.0

