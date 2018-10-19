Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8E41F453
	for <e@80x24.org>; Fri, 19 Oct 2018 16:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeJTBAB (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 21:00:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37314 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeJTBAB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 21:00:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id 63-v6so31446245ljs.4
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oXy0a0waszB5nZY6E1yIF5rqPdjzNNfn75miQiXVyvg=;
        b=tb4h1ceh5sOb4g869HvZADOOy5M2Ib7JOASUumbPA+acpJBxtJ/FSGlu7mjp5kTgNh
         K35iosIFLefDdEP4zl/WpnqGHtKFM1K+zGc1jC2KMKZTyCwNy3s9pq6ZQ0h4pvK6wdl0
         Olmc2BC+fLhEz4BipfTYPEpk8OSbt7FgWlUtXSb3tkdlFVp4ZfDLiOTQjMNw+2dC+qF6
         6hKLzPY4j8C0Ng4AOO+QH/1BCi/KgWdjLJELTMLvBel3V3PNimZcOvGMeOUs2O/07jwh
         9zhZdujaDtnsVbDjPFxnl3+GDkqa+dtOSgpaC/lRDkcyvPg5bq4xqs/IoponAjU79D8T
         Uifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oXy0a0waszB5nZY6E1yIF5rqPdjzNNfn75miQiXVyvg=;
        b=CnoPZ+J35F6/j4HyQqQ2ts/JPdFko/YOhwJta/+3yU3cWXoBT4aFygt1ZkruF68/TB
         yFjbOpqjYZ24iox9Letinh8NmrTlzfbUU/Ki6uiXDMkgESU9kxoSVjV5FOIWKIytK+5y
         fNBTj+mIQ2Z8ONAoT4DxqaKVVf9scUukg9i4J4y65zk1sJI4Q6xzGhACYHSmg9HR21bv
         rxnRJUpNmpNbTaV4zQeDVHO5vcquGROsfYW3mhMa4eRj+a9Aqpc6lzqTufRUVpNXreIy
         bclgszwCkKX6pY3LaSKrGr36ex+TX8uco/ETa5v/Pk2z152WzUhwyI4xBGWmPAacXMHw
         7DaA==
X-Gm-Message-State: ABuFfohjuED4DVPixrbRPkHXTJJQ9c3+KBqhA3yAKTCDcWoOgzPUbheg
        l6fbPPintGn48wE425R9rMgYjPt6
X-Google-Smtp-Source: ACcGV63/r8ISdQhjtqbb8ai8o32SYIGbuzj3bKHLBI18DpFBmrrNNm/ZQdKMZgfpSULIAiFJP4hBdA==
X-Received: by 2002:a2e:8589:: with SMTP id b9-v6mr23600131lji.122.1539967984611;
        Fri, 19 Oct 2018 09:53:04 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b196-v6sm382661lfb.60.2018.10.19.09.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 09:53:03 -0700 (PDT)
Date:   Fri, 19 Oct 2018 18:53:01 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 19/24] submodule.c: remove implicit dependency on
 the_index
Message-ID: <20181019165301.GA31850@duynguyen.home>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
 <20180903180932.32260-20-pclouds@gmail.com>
 <20181019162021.GA14778@sigill.intra.peff.net>
 <CACsJy8CGLRi64WzNUM-6NUm3i0JW7+ptfh7+NhiSb7J9Qb0u0w@mail.gmail.com>
 <20181019164237.GA24740@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019164237.GA24740@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 12:42:38PM -0400, Jeff King wrote:
> On Fri, Oct 19, 2018 at 06:33:30PM +0200, Duy Nguyen wrote:
> 
> > > This function doesn't actually make use of the newly added "istate" (nor
> > > does it use the_index, so there's not a spot that forgot to get
> > > converted). Is this in preparation for more refactoring, or is it just a
> > > mistake and can be dropped?
> > 
> > It's possible that it was needed at some point when I converted diff
> > api to pass index_state around. But in later iterations I think I
> > passed "struct repository *" instead because diff code needed much
> > more than the index, but did not clean this up. Sorry.
> > 
> > In this function, we still have the_repository for
> > repo_init_revisions() and it should be gone eventually. "struct
> > repository *r" could take the place of "struct index_state *istate"
> > instead and we would need to reopen the path again.
> > 
> > So I'm not sure, if it's really bad, we could remove it now. Otherwise
> > we could just leave it there, I don't think this "istate" will survive
> > very long. I already started deleting some of the_repository in "kill
> > the_index" series.
> 
> OK, that all makes sense. I need to either drop it or mark it unused to
> satisfy -Wunused-parameters.

Aha! I thought you looked deeply into this and was very confused. How
could you have found the time :D

> I think I'd lean toward the former, if
> it's not likely to be used (even if we add "struct repository" later,
> the separate index parameter would just go away then).

Or we could fix it now. Something like this? It adds three the_repository
(two technically are already there) but deletes eight, which makes me
happy. It's up to you to decide.

-- 8< --
diff --git a/builtin/pull.c b/builtin/pull.c
index 798ecf7faf..c21aa276f1 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -945,7 +945,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		int ret = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
-		    submodule_touches_in_range(&the_index, &rebase_fork_point, &curr_head))
+		    submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
 		if (!autostash) {
 			struct commit_list *list = NULL;
diff --git a/submodule.c b/submodule.c
index d9d3046689..977c050668 100644
--- a/submodule.c
+++ b/submodule.c
@@ -694,6 +694,7 @@ static struct oid_array *submodule_commits(struct string_list *submodules,
 }
 
 struct collect_changed_submodules_cb_data {
+	struct repository *repo;
 	struct string_list *changed;
 	const struct object_id *commit_oid;
 };
@@ -733,7 +734,7 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
 
-		submodule = submodule_from_path(the_repository,
+		submodule = submodule_from_path(me->repo,
 						commit_oid, p->two->path);
 		if (submodule)
 			name = submodule->name;
@@ -741,7 +742,7 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 			name = default_name_or_path(p->two->path);
 			/* make sure name does not collide with existing one */
 			if (name)
-				submodule = submodule_from_name(the_repository,
+				submodule = submodule_from_name(me->repo,
 								commit_oid, name);
 			if (submodule) {
 				warning("Submodule in commit %s at path: "
@@ -766,14 +767,14 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
  * have a corresponding 'struct oid_array' (in the 'util' field) which lists
  * what the submodule pointers were updated to during the change.
  */
-static void collect_changed_submodules(struct index_state *istate,
+static void collect_changed_submodules(struct repository *r,
 				       struct string_list *changed,
 				       struct argv_array *argv)
 {
 	struct rev_info rev;
 	const struct commit *commit;
 
-	repo_init_revisions(the_repository, &rev, NULL);
+	repo_init_revisions(r, &rev, NULL);
 	setup_revisions(argv->argc, argv->argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
@@ -781,10 +782,11 @@ static void collect_changed_submodules(struct index_state *istate,
 	while ((commit = get_revision(&rev))) {
 		struct rev_info diff_rev;
 		struct collect_changed_submodules_cb_data data;
+		data.repo = r;
 		data.changed = changed;
 		data.commit_oid = &commit->object.oid;
 
-		repo_init_revisions(the_repository, &diff_rev, NULL);
+		repo_init_revisions(r, &diff_rev, NULL);
 		diff_rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 		diff_rev.diffopt.format_callback = collect_changed_submodules_cb;
 		diff_rev.diffopt.format_callback_data = &data;
@@ -931,7 +933,7 @@ static int submodule_needs_pushing(const char *path, struct oid_array *commits)
 	return 0;
 }
 
-int find_unpushed_submodules(struct index_state *istate,
+int find_unpushed_submodules(struct repository *r,
 			     struct oid_array *commits,
 			     const char *remotes_name,
 			     struct string_list *needs_pushing)
@@ -946,14 +948,14 @@ int find_unpushed_submodules(struct index_state *istate,
 	argv_array_push(&argv, "--not");
 	argv_array_pushf(&argv, "--remotes=%s", remotes_name);
 
-	collect_changed_submodules(istate, &submodules, &argv);
+	collect_changed_submodules(r, &submodules, &argv);
 
 	for_each_string_list_item(name, &submodules) {
 		struct oid_array *commits = name->util;
 		const struct submodule *submodule;
 		const char *path = NULL;
 
-		submodule = submodule_from_name(the_repository, &null_oid, name->string);
+		submodule = submodule_from_name(r, &null_oid, name->string);
 		if (submodule)
 			path = submodule->path;
 		else
@@ -1047,7 +1049,7 @@ static void submodule_push_check(const char *path, const char *head,
 		die("process for submodule '%s' failed", path);
 }
 
-int push_unpushed_submodules(struct index_state *istate,
+int push_unpushed_submodules(struct repository *r,
 			     struct oid_array *commits,
 			     const struct remote *remote,
 			     const struct refspec *rs,
@@ -1057,7 +1059,7 @@ int push_unpushed_submodules(struct index_state *istate,
 	int i, ret = 1;
 	struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 
-	if (!find_unpushed_submodules(istate, commits,
+	if (!find_unpushed_submodules(r, commits,
 				      remote->name, &needs_pushing))
 		return 1;
 
@@ -1115,14 +1117,14 @@ void check_for_new_submodule_commits(struct object_id *oid)
 	oid_array_append(&ref_tips_after_fetch, oid);
 }
 
-static void calculate_changed_submodule_paths(struct index_state *istate)
+static void calculate_changed_submodule_paths(struct repository *r)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
 	const struct string_list_item *name;
 
 	/* No need to check if there are no submodules configured */
-	if (!submodule_from_path(the_repository, NULL, NULL))
+	if (!submodule_from_path(r, NULL, NULL))
 		return;
 
 	argv_array_push(&argv, "--"); /* argv[0] program name */
@@ -1136,14 +1138,14 @@ static void calculate_changed_submodule_paths(struct index_state *istate)
 	 * Collect all submodules (whether checked out or not) for which new
 	 * commits have been recorded upstream in "changed_submodule_names".
 	 */
-	collect_changed_submodules(istate, &changed_submodules, &argv);
+	collect_changed_submodules(r, &changed_submodules, &argv);
 
 	for_each_string_list_item(name, &changed_submodules) {
 		struct oid_array *commits = name->util;
 		const struct submodule *submodule;
 		const char *path = NULL;
 
-		submodule = submodule_from_name(the_repository, &null_oid, name->string);
+		submodule = submodule_from_name(r, &null_oid, name->string);
 		if (submodule)
 			path = submodule->path;
 		else
@@ -1163,7 +1165,7 @@ static void calculate_changed_submodule_paths(struct index_state *istate)
 	initialized_fetch_ref_tips = 0;
 }
 
-int submodule_touches_in_range(struct index_state *istate,
+int submodule_touches_in_range(struct repository *r,
 			       struct object_id *excl_oid,
 			       struct object_id *incl_oid)
 {
@@ -1172,7 +1174,7 @@ int submodule_touches_in_range(struct index_state *istate,
 	int ret;
 
 	/* No need to check if there are no submodules configured */
-	if (!submodule_from_path(the_repository, NULL, NULL))
+	if (!submodule_from_path(r, NULL, NULL))
 		return 0;
 
 	argv_array_push(&args, "--"); /* args[0] program name */
@@ -1182,7 +1184,7 @@ int submodule_touches_in_range(struct index_state *istate,
 		argv_array_push(&args, oid_to_hex(excl_oid));
 	}
 
-	collect_changed_submodules(istate, &subs, &args);
+	collect_changed_submodules(r, &subs, &args);
 	ret = subs.nr;
 
 	argv_array_clear(&args);
@@ -1352,7 +1354,7 @@ int fetch_populated_submodules(struct repository *r,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	calculate_changed_submodule_paths(r->index);
+	calculate_changed_submodule_paths(r);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
diff --git a/submodule.h b/submodule.h
index 4826601ff2..a8a4fe8d25 100644
--- a/submodule.h
+++ b/submodule.h
@@ -102,15 +102,15 @@ int add_submodule_odb(const char *path);
  * Checks if there are submodule changes in a..b. If a is the null OID,
  * checks b and all its ancestors instead.
  */
-int submodule_touches_in_range(struct index_state *istate,
+int submodule_touches_in_range(struct repository *r,
 			       struct object_id *a,
 			       struct object_id *b);
-int find_unpushed_submodules(struct index_state *istate,
+int find_unpushed_submodules(struct repository *r,
 			     struct oid_array *commits,
 			     const char *remotes_name,
 			     struct string_list *needs_pushing);
 struct refspec;
-int push_unpushed_submodules(struct index_state *istate,
+int push_unpushed_submodules(struct repository *r,
 			     struct oid_array *commits,
 			     const struct remote *remote,
 			     const struct refspec *rs,
diff --git a/transport.c b/transport.c
index f4ffbd96cb..f9343e6dde 100644
--- a/transport.c
+++ b/transport.c
@@ -1172,7 +1172,7 @@ int transport_push(struct transport *transport,
 					oid_array_append(&commits,
 							  &ref->new_oid);
 
-			if (!push_unpushed_submodules(&the_index,
+			if (!push_unpushed_submodules(the_repository,
 						      &commits,
 						      transport->remote,
 						      rs,
@@ -1197,7 +1197,7 @@ int transport_push(struct transport *transport,
 					oid_array_append(&commits,
 							  &ref->new_oid);
 
-			if (find_unpushed_submodules(&the_index,
+			if (find_unpushed_submodules(the_repository,
 						     &commits,
 						     transport->remote->name,
 						     &needs_pushing)) {
-- 8< --
