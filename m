Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FEAA202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 16:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbdKGQbJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 11:31:09 -0500
Received: from mout.gmx.net ([212.227.17.20]:65082 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751824AbdKGQbG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 11:31:06 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVJze-1ekgo63NPi-00YhDs; Tue, 07
 Nov 2017 17:31:00 +0100
Date:   Tue, 7 Nov 2017 17:30:58 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>
Subject: [PATCH v3 1/3] for-each-ref: let upstream/push optionally report
 the remote name
In-Reply-To: <cover.1510072200.git.johannes.schindelin@gmx.de>
Message-ID: <9fac9476c73f83f2e688d3e12abc175f40f67c3e.1510072200.git.johannes.schindelin@gmx.de>
References: <cover.1507205895.git.johannes.schindelin@gmx.de> <cover.1510072200.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sF4lNRIUJumarMwR8NsBxKIavfbQtaRcLIeAT6yLBo7fHqEVCpy
 N5zRcJF/M3GiC+FAu8TCzC6y6xqCyj64hpvcV7KiAB9lwkzT+u/aXA+ruBF+KimE3rrBfqq
 mPOUIm/r0MM+0Tdc526Aa/eSUUWfFGGm1zcReRsUuA8G1zaGmQ7aMwIc41Q7RBkVKmi3Syv
 /YK2OOCq8bCnPoVaSW7KA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xThIDXcPETE=:MJq5rHvUQiAOhavIK9bM4g
 G10v7XribcSfNUHlqbEBnrgfmiW82R72lMf4NdGdgI64QxMx4jgP+quKtejS7dylpnwtur0X/
 K/EZxzwqrw2pwuJgXKZnv/xFRSABwbJewXiFN6nUZo02mUHR0IEruOW3d4lkqt+k7WxGvOQOu
 WC42Hecgv3IU00sjrmRnrOAf3pAwavBzQ+lM3fzi3yPCAe6RKNG/MUPbETZP7uV9DNfCLEN9G
 Gx4cTPTaw5GGXWMK8a+p9b/fyMyUq+gH+jRj88TqpdHhVpMh/ZnYmJxm0hB34Kxbila1MItJz
 z57wdxC5zwPVaxugw6W2D4zkWRwf/llVvOz6eOPVPe+TctAEuoywy9r8RIM5mMz0A9rW9rxvx
 KUauMgl9lHUOPwAh4FRupl2zA+SuBQUV0kCEFGEBaXW0jxKTXkPhwbCU18HHNQy5eT7xMcMox
 d/yKVrQFTam8j0u/cekmO7WzIaNg5K0SNh+sZluatual2ae+129L4tJiqpAy1HDqdvf1pzjxZ
 iJcigBAHvdLoeQkG445jMsEC8Qf91Mtk+Kh+tUPUh9ciTcZEjS3PWeAErylEOGRTuMWBJn0ZU
 1jBRlgfesQLXshmXMU6f7i2qvPvMjEYo6wfCq3bMwiLXdrkZolFklNdfdhrK4dQ3IBuRdTnIN
 cEX2OuvGQhmKGRWJVV1cv1nSYW2fwPmPHwFVpAYw4wb52eKYlbmoChhffaZnUiASXqKVnb5mU
 U4+Pc/i8umevp+t0o+bWNeSssN8+se7Hcsg6vsCGqRChyMiKnfRFo6S0D/1hHekOTNGs6Qj6r
 T5Fjws5wVV+iUVlL6RXragM5BKxyg8sPrYFNAOXaLOUPCW/nuM=
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
	  --format='%(upstream) %(upstream:remotename) %(push:remotename)' \
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
index 1d420e4cde8..288b11aaeed 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -145,17 +145,20 @@ upstream::
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
index e728b15b3ae..cde8b97dcb0 100644
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
@@ -138,6 +140,9 @@ static void remote_ref_atom_parser(const struct ref_format *format, struct used_
 	struct string_list params = STRING_LIST_INIT_DUP;
 	int i;
 
+	if (!strcmp(atom->name, "push") || starts_with(atom->name, "push:"))
+		atom->u.remote_ref.push = 1;
+
 	if (!arg) {
 		atom->u.remote_ref.option = RR_REF;
 		refname_atom_parser_internal(&atom->u.remote_ref.refname,
@@ -157,7 +162,10 @@ static void remote_ref_atom_parser(const struct ref_format *format, struct used_
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
@@ -1268,6 +1276,15 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
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
@@ -1377,16 +1394,20 @@ static void populate_value(struct ref_array_item *ref)
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
2.15.0.windows.1


