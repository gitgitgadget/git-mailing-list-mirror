Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B25AC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 22:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343697AbhLAWTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 17:19:41 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33928 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243260AbhLAWTk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 17:19:40 -0500
Received: from localhost (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B1MG4Ka012572
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Dec 2021 17:16:05 -0500
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason=20?= 
        <avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
        Anders Kaseorg <andersk@mit.edu>
Subject: [PATCH v7 1/8] fetch: lowercase error messages
Date:   Wed,  1 Dec 2021 14:15:40 -0800
Message-Id: <20211201221547.1796213-2-andersk@mit.edu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201221547.1796213-1-andersk@mit.edu>
References: <20211201221547.1796213-1-andersk@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Documentation/CodingGuidelines says “do not end error messages with a
full stop” and “do not capitalize the first word”.  Clean up existing
messages, some of which we will be touching in later steps in the
series, that deviate from these rules in this file, as a preparation for
the main part of the topic.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 builtin/fetch.c | 50 +++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f7abbc31ff..16b98523ce 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -552,7 +552,7 @@ static struct ref *get_ref_map(struct remote *remote,
 		for (i = 0; i < fetch_refspec->nr; i++)
 			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
 	} else if (refmap.nr) {
-		die("--refmap option is only meaningful with command-line refspec(s).");
+		die("--refmap option is only meaningful with command-line refspec(s)");
 	} else {
 		/* Use the defaults */
 		struct branch *branch = branch_get(NULL);
@@ -583,7 +583,7 @@ static struct ref *get_ref_map(struct remote *remote,
 		} else if (!prefetch) {
 			ref_map = get_remote_ref(remote_refs, "HEAD");
 			if (!ref_map)
-				die(_("Couldn't find remote ref HEAD"));
+				die(_("couldn't find remote ref HEAD"));
 			ref_map->fetch_head_status = FETCH_HEAD_MERGE;
 			tail = &ref_map->next;
 		}
@@ -1067,13 +1067,13 @@ static void close_fetch_head(struct fetch_head *fetch_head)
 }
 
 static const char warn_show_forced_updates[] =
-N_("Fetch normally indicates which branches had a forced update,\n"
-   "but that check has been disabled. To re-enable, use '--show-forced-updates'\n"
-   "flag or run 'git config fetch.showForcedUpdates true'.");
+N_("fetch normally indicates which branches had a forced update,\n"
+   "but that check has been disabled; to re-enable, use '--show-forced-updates'\n"
+   "flag or run 'git config fetch.showForcedUpdates true'");
 static const char warn_time_show_forced_updates[] =
-N_("It took %.2f seconds to check forced updates. You can use\n"
+N_("it took %.2f seconds to check forced updates; you can use\n"
    "'--no-show-forced-updates' or run 'git config fetch.showForcedUpdates false'\n"
-   " to avoid this check.\n");
+   "to avoid this check\n");
 
 static int store_updated_refs(const char *raw_url, const char *remote_name,
 			      int connectivity_checked, struct ref *ref_map)
@@ -1395,8 +1395,9 @@ static void check_not_current_branch(struct ref *ref_map)
 	for (; ref_map; ref_map = ref_map->next)
 		if (ref_map->peer_ref && !strcmp(current_branch->refname,
 					ref_map->peer_ref->name))
-			die(_("Refusing to fetch into current branch %s "
-			    "of non-bare repository"), current_branch->refname);
+			die(_("refusing to fetch into current branch %s "
+			      "of non-bare repository"),
+			    current_branch->refname);
 }
 
 static int truncate_fetch_head(void)
@@ -1414,10 +1415,10 @@ static void set_option(struct transport *transport, const char *name, const char
 {
 	int r = transport_set_option(transport, name, value);
 	if (r < 0)
-		die(_("Option \"%s\" value \"%s\" is not valid for %s"),
+		die(_("option \"%s\" value \"%s\" is not valid for %s"),
 		    name, value, transport->url);
 	if (r > 0)
-		warning(_("Option \"%s\" is ignored for %s\n"),
+		warning(_("option \"%s\" is ignored for %s\n"),
 			name, transport->url);
 }
 
@@ -1451,7 +1452,7 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
 		old_nr = oids->nr;
 		for_each_glob_ref(add_oid, s, oids);
 		if (old_nr == oids->nr)
-			warning("Ignoring --negotiation-tip=%s because it does not match any refs",
+			warning("ignoring --negotiation-tip=%s because it does not match any refs",
 				s);
 	}
 	smart_options->negotiation_tips = oids;
@@ -1489,7 +1490,7 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 		if (transport->smart_options)
 			add_negotiation_tips(transport->smart_options);
 		else
-			warning("Ignoring --negotiation-tip because the protocol does not support it.");
+			warning("ignoring --negotiation-tip because the protocol does not support it");
 	}
 	return transport;
 }
@@ -1651,8 +1652,8 @@ static int do_fetch(struct transport *transport,
 			else
 				warning(_("unknown branch type"));
 		} else {
-			warning(_("no source branch found.\n"
-				"you need to specify exactly one branch with the --set-upstream option."));
+			warning(_("no source branch found;\n"
+				  "you need to specify exactly one branch with the --set-upstream option"));
 		}
 	}
  skip:
@@ -1790,7 +1791,7 @@ static int fetch_failed_to_start(struct strbuf *out, void *cb, void *task_cb)
 	struct parallel_fetch_state *state = cb;
 	const char *remote = task_cb;
 
-	state->result = error(_("Could not fetch %s"), remote);
+	state->result = error(_("could not fetch %s"), remote);
 
 	return 0;
 }
@@ -1845,7 +1846,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
 			if (verbosity >= 0)
 				printf(_("Fetching %s\n"), name);
 			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
-				error(_("Could not fetch %s"), name);
+				error(_("could not fetch %s"), name);
 				result = 1;
 			}
 			strvec_pop(&argv);
@@ -1906,8 +1907,8 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 	int remote_via_config = remote_is_configured(remote, 0);
 
 	if (!remote)
-		die(_("No remote repository specified.  Please, specify either a URL or a\n"
-		    "remote name from which new revisions should be fetched."));
+		die(_("no remote repository specified; please specify either a URL or a\n"
+		      "remote name from which new revisions should be fetched"));
 
 	gtransport = prepare_transport(remote, 1);
 
@@ -1942,7 +1943,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 		if (!strcmp(argv[i], "tag")) {
 			i++;
 			if (i >= argc)
-				die(_("You need to specify a tag name."));
+				die(_("you need to specify a tag name"));
 
 			refspec_appendf(&rs, "refs/tags/%s:refs/tags/%s",
 					argv[i], argv[i]);
@@ -2010,7 +2011,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	if (deepen_relative) {
 		if (deepen_relative < 0)
-			die(_("Negative depth in --deepen is not supported"));
+			die(_("negative depth in --deepen is not supported"));
 		if (depth)
 			die(_("--deepen and --depth are mutually exclusive"));
 		depth = xstrfmt("%d", deepen_relative);
@@ -2047,14 +2048,15 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		/* All arguments are assumed to be remotes or groups */
 		for (i = 0; i < argc; i++)
 			if (!add_remote_or_group(argv[i], &list))
-				die(_("No such remote or remote group: %s"), argv[i]);
+				die(_("no such remote or remote group: %s"),
+				    argv[i]);
 	} else {
 		/* Single remote or group */
 		(void) add_remote_or_group(argv[0], &list);
 		if (list.nr > 1) {
 			/* More than one remote */
 			if (argc > 1)
-				die(_("Fetching a group and specifying refspecs does not make sense"));
+				die(_("fetching a group and specifying refspecs does not make sense"));
 		} else {
 			/* Zero or one remotes */
 			remote = remote_get(argv[0]);
@@ -2075,7 +2077,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		if (gtransport->smart_options) {
 			gtransport->smart_options->acked_commits = &acked_commits;
 		} else {
-			warning(_("Protocol does not support --negotiate-only, exiting."));
+			warning(_("protocol does not support --negotiate-only, exiting"));
 			return 1;
 		}
 		if (server_options.nr)
-- 
2.34.1

