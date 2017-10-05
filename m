Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A2F020281
	for <e@80x24.org>; Thu,  5 Oct 2017 12:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbdJEMTR (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 08:19:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:59749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbdJEMTP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 08:19:15 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5tzh-1d7akR2no9-00xqsp; Thu, 05
 Oct 2017 14:19:10 +0200
Date:   Thu, 5 Oct 2017 14:19:09 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] for-each-ref: let upstream/push optionally report
 the remote name
In-Reply-To: <cover.1507205895.git.johannes.schindelin@gmx.de>
Message-ID: <964525df50e6d35847bcf57b0fe0949c99f0dbca.1507205895.git.johannes.schindelin@gmx.de>
References: <cover.1506952571.git.johannes.schindelin@gmx.de> <cover.1507205895.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ozyl58npxO9JOnOQlfXQ+EAeY4jKFraG/KM4vF9jTDiLvVbEgap
 aq+oKuOF2sPuVdPUgyLCKLKgBrLA4PFPq1LyrtUNFa3LnCn6Gpo1zn9bHYVfSBJoTdUnLAZ
 MCJ1AHr6JxV+EdzUcTtoTysuupoKOCDSqL9aGJm9Be7Lj+8iX66I5AcaZphsojUEaT2AAh+
 27bqLRW2lnK60b74chg2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mHVDQgjynlA=:x9ISdES+jLjKwabLrQxo7/
 oj87+AOH8BuDf7+wdvxWFoe2N8WV4cEIAZMeAk9+rySLT+I1ybFb+Uk0d+A9EDhz9ZANODXYx
 +MEUuOeKh8TmYTAKuZGnK568tQtnAe1I0EF0CTvEvOelh4JrB/QIfDzoPZrEs1XRpYqwKw1tI
 adVEAXp5uevqgxQTWzjeaynqOgj+q2EGxhtd3+n6fbrK/puDf7+2tXiNjwQoOicnuD0U/shz8
 bGyXcVC/yjJmnCn5ExkEbgfg5bML9XSuJ+N9fenLw09v1Cxa2St1w8tcls8z30m8ZI3bMAzz7
 SLSGCXH2CJwMx3cKIXepJ1qgXt0C0Z23UGlp5knbdl1oKTobZ4xkF5cZOzrDnW37FnPVXPSUJ
 3e3mcUl7xCaMsA67Hdp5axmvNkMszIRNeptgrX6SyASvfVUiqGDqbIeWRj4ILzlxC4ToRV6FF
 ZaVwhak64Zj2bHbTuubRzTEiyiamhGBnTmFFdtp6s5F3PsfEIHxjvgTLjyZAz+NKqgazaE0rz
 lobM/vCuq5tmY0HAWJoSnD5UkgIZliM8ID7GZ6yz85QQEMSlFQZeWYfVKB2V8o6wAs9MAwVzF
 gofcwVQYuNHjYVSLD2KinC0lkM2ZZQhDnr+aouprCsoIZR0MxJS+VgUMGDOHXWs6jG1n/i+Cn
 5TL5bf6dqrTI/XRnqeNOcWcmFvnw1BY/3tF4N4/38aWXWeoMAnHPW2cRsK9kx0PFmu59+Tudp
 l9zJUPqNNOBbPcxtVDkZASCtGeyuE1JA1Nww1ihSBkD8No1R5jTg7D3JVkXXfSq8FiBxIp/Ju
 sKQ6ksCs7Q/9L5yxZrqarxcBCG02QkywGUoXpZbMZ5CyAiRqAs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are times when e.g. scripts want to know not only the name of the
upstream branch on the remote repository, but also the name of the
remote.

This patch offers the new suffix :remotename for the upstream and for
the push atoms, allowing to show exactly that. Example:

	$ cat .git/config
	...
	[remote "origin"]
		url = https://where.do.we.come/from
		fetch = refs/heads/*:refs/remote/origin/*
	[remote "hello-world"]
		url = https://hello.world/git
		fetch = refs/heads/*:refs/remote/origin/*
		pushURL = hello.world:git
		push = refs/heads/*:refs/heads/*
	[branch "master"]
		remote = origin
		pushRemote = hello-world
	...

	$ git for-each-ref \
		--format='%(upstream) %(upstream:remote) %(push:remote)' \
		refs/heads/master
	refs/remotes/origin/master origin hello-world

The implementation chooses *not* to DWIM the push remote if no explicit
push remote was configured; The reason is that it is possible to DWIM this
by using

	%(if)%(push:remotename)%(then)
		%(push:remotename)
	%(else)
		%(upstream:remotename)
	%(end)

while it would be impossible to "un-DWIM" the information in case the
caller is really only interested in explicit push remotes.

While `:remote` would be shorter, it would also be a bit more ambiguous,
and it would also shut the door e.g. for `:remoteref` (which would
obviously refer to the corresponding ref in the remote repository).

Note: the dashless, non-CamelCased form `:remotename` follows the
example of the `:trackshort` example.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-for-each-ref.txt | 17 ++++++++++-------
 ref-filter.c                       | 35 ++++++++++++++++++++++++++++-------
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 66b4e0a4050..39f50bd53eb 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -140,17 +140,20 @@ upstream::
 	(behind), "<>" (ahead and behind), or "=" (in sync). `:track`
 	also prints "[gone]" whenever unknown upstream ref is
 	encountered. Append `:track,nobracket` to show tracking
-	information without brackets (i.e "ahead N, behind M").  Has
-	no effect if the ref does not have tracking information
-	associated with it.  All the options apart from `nobracket`
-	are mutually exclusive, but if used together the last option
-	is selected.
+	information without brackets (i.e "ahead N, behind M").
++
+Also respects `:remotename` to state the name of the *remote* instead of
+the ref.
++
+Has no effect if the ref does not have tracking information associated
+with it.  All the options apart from `nobracket` are mutually exclusive,
+but if used together the last option is selected.
 
 push::
 	The name of a local ref which represents the `@{push}`
 	location for the displayed ref. Respects `:short`, `:lstrip`,
-	`:rstrip`, `:track`, and `:trackshort` options as `upstream`
-	does. Produces an empty string if no `@{push}` ref is
+	`:rstrip`, `:track`, `:trackshort` and `:remotename` options as
+	`upstream` does. Produces an empty string if no `@{push}` ref is
 	configured.
 
 HEAD::
diff --git a/ref-filter.c b/ref-filter.c
index 55323620ab2..4819707d032 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -76,9 +76,11 @@ static struct used_atom {
 		char color[COLOR_MAXLEN];
 		struct align align;
 		struct {
-			enum { RR_REF, RR_TRACK, RR_TRACKSHORT } option;
+			enum {
+				RR_REF, RR_TRACK, RR_TRACKSHORT, RR_REMOTE_NAME
+			} option;
 			struct refname_atom refname;
-			unsigned int nobracket : 1;
+			unsigned int nobracket : 1, push : 1, push_remote : 1;
 		} remote_ref;
 		struct {
 			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
@@ -137,6 +139,9 @@ static void remote_ref_atom_parser(const struct ref_format *format, struct used_
 	struct string_list params = STRING_LIST_INIT_DUP;
 	int i;
 
+	if (!strcmp(atom->name, "push") || starts_with(atom->name, "push:"))
+		atom->u.remote_ref.push = 1;
+
 	if (!arg) {
 		atom->u.remote_ref.option = RR_REF;
 		refname_atom_parser_internal(&atom->u.remote_ref.refname,
@@ -156,7 +161,10 @@ static void remote_ref_atom_parser(const struct ref_format *format, struct used_
 			atom->u.remote_ref.option = RR_TRACKSHORT;
 		else if (!strcmp(s, "nobracket"))
 			atom->u.remote_ref.nobracket = 1;
-		else {
+		else if (!strcmp(s, "remotename")) {
+			atom->u.remote_ref.option = RR_REMOTE_NAME;
+			atom->u.remote_ref.push_remote = 1;
+		} else {
 			atom->u.remote_ref.option = RR_REF;
 			refname_atom_parser_internal(&atom->u.remote_ref.refname,
 						     arg, atom->name);
@@ -1245,6 +1253,15 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 			*s = ">";
 		else
 			*s = "<>";
+	} else if (atom->u.remote_ref.option == RR_REMOTE_NAME) {
+		int explicit;
+		const char *remote = atom->u.remote_ref.push ?
+			pushremote_for_branch(branch, &explicit) :
+			remote_for_branch(branch, &explicit);
+		if (explicit)
+			*s = xstrdup(remote);
+		else
+			*s = "";
 	} else
 		die("BUG: unhandled RR_* enum");
 }
@@ -1354,16 +1371,20 @@ static void populate_value(struct ref_array_item *ref)
 			if (refname)
 				fill_remote_ref_details(atom, refname, branch, &v->s);
 			continue;
-		} else if (starts_with(name, "push")) {
+		} else if (atom->u.remote_ref.push) {
 			const char *branch_name;
 			if (!skip_prefix(ref->refname, "refs/heads/",
 					 &branch_name))
 				continue;
 			branch = branch_get(branch_name);
 
-			refname = branch_get_push(branch, NULL);
-			if (!refname)
-				continue;
+			if (atom->u.remote_ref.push_remote)
+				refname = NULL;
+			else {
+				refname = branch_get_push(branch, NULL);
+				if (!refname)
+					continue;
+			}
 			fill_remote_ref_details(atom, refname, branch, &v->s);
 			continue;
 		} else if (starts_with(name, "color:")) {
-- 
2.14.2.windows.1.2.gdc85205db4d


