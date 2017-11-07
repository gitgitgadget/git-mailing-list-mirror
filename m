Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22FD2202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 16:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbdKGQbS (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 11:31:18 -0500
Received: from mout.gmx.net ([212.227.17.22]:55830 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752763AbdKGQbR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 11:31:17 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGRhs-1ePKCj3LrU-00DJyV; Tue, 07
 Nov 2017 17:31:09 +0100
Date:   Tue, 7 Nov 2017 17:31:08 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     J Wyman <jwyman@microsoft.com>, Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>
Subject: [PATCH v3 2/3] for-each-ref: let upstream/push report the remote
 ref name
In-Reply-To: <cover.1510072200.git.johannes.schindelin@gmx.de>
Message-ID: <00a24074edbb6ac09344b1685bf7664cc2e10bd6.1510072200.git.johannes.schindelin@gmx.de>
References: <cover.1507205895.git.johannes.schindelin@gmx.de> <cover.1510072200.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6fjW7UIypPhIfgiMg8p0SXMh8MQ3hEN/4Ka6jnHUQIqwD4sox4l
 RgTQI+nSH/9WFAiLiycolepFL1drc4k1XKO1g3ek+p7aUP37cyEfkx9RfLR/b7QvI7nKG+H
 UG8hkI/KJHgWgE1BTXrngXHkWByTYtl3xKtxw/2aFSbaUutIFdCZDcR2WhMy0+4hpb788qV
 H6yCwhn9gmMaPv9mQUf9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DHrdSbKJs8o=:duf/FzzZns2jcYaHy9MBy4
 z4ognwIiwboOgtMTb6dU4EboGMV28HqelCulV5ivFtoZ+rP+MK52rK2xAr56BAtG/qRDgUTWs
 vIG59j69em6+SuwtNwgfRhVbahSh/2YJeiGUcfidEjfG1B82xhRJw8Piq8O0m2nDGZrTFeIuQ
 L9mp/9Md5/U0Yeg6lf9md/0ya7I5IKV7m5UqGyMWH7Zej8qtB6cQmRxDrrTrQLOwtxEWgRVfT
 NLttxzHSVquqd0oq0GCk3VHSBDhWr+IhnWKi9xlmVz0CgHLlvwUQoDKlbvt/VblClLCT3wwqw
 eEmOtRALutF8P5r2OpD9wM4NEdgzPeWm/Du+1yP1bYHDDjV5bQbCNLEurXewyMr/+rngswSs7
 tSCFDDxK0AG1SAycD/SUqBbmTX1cQ8rXJVQxdvinjKMPTJ5MkxJkKFSMl41AeQAYLQHbD8sbx
 1eYr1i1CFcjLrviscvULrMwpHkBu+E6IpOueKO61fGLEpVgVs0cCwaXrz0jLEUA0rXVfNl2BN
 hbyZror2Dfyxwcfj8ftGGkZeL7HMm1896upXOkBsoo9fWc3GgvfAQypDaMOs+vzkVA7Rchj5i
 XAW/O6LsxZ6kQh6w4yHZEFHDcLrJuNSF/ZLQQLtV9m6Znhd2MqVYaeLA0AUC09T+qQl83s7Du
 GBFBDm+8oQGg7gr6ypgK/GHHreEGuFfBaQKEnCMQBIMb8sqAXMDKKb+/U/mEwMD3UUoAwb0wx
 32NryB/i008L1MISiKpwx66b6uknamMYWY8AzlqZfcOKMyC+uCmGkLnNW93D1gGuwsXylSA63
 zB//fyDvmYjNKj0LcD7RX8VwN+6VYoVABEPEbsAdMymgctP8QY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: J Wyman <jwyman@microsoft.com>

There are times when scripts want to know not only the name of the
push branch on the remote, but also the name of the branch as known
by the remote repository.

An example of this is when a tool wants to push to the very same branch
from which it would pull automatically, i.e. the `<remote>` and the `<to>`
in `git push <remote> <from>:<to>` would be provided by
`%(upstream:remotename)` and `%(upstream:remoteref)`, respectively.

This patch offers the new suffix :remoteref for the `upstream` and `push`
atoms, allowing to show exactly that. Example:

	$ cat .git/config
	...
	[remote "origin"]
		url = https://where.do.we.come/from
		fetch = refs/heads/*:refs/remote/origin/*
	[branch "master"]
		remote = origin
		merge = refs/heads/master
	[branch "develop/with/topics"]
		remote = origin
		merge = refs/heads/develop/with/topics
	...

	$ git for-each-ref \
		--format='%(push) %(push:remoteref)' \
		refs/heads
	refs/remotes/origin/master refs/heads/master
	refs/remotes/origin/develop/with/topics refs/heads/develop/with/topics

Signed-off-by: J Wyman <jwyman@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-for-each-ref.txt | 14 +++++++++-----
 ref-filter.c                       | 15 ++++++++++++++-
 remote.c                           | 30 ++++++++++++++++++++++++++++++
 remote.h                           |  2 ++
 4 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 288b11aaeed..dffa14a7950 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -147,8 +147,12 @@ upstream::
 	encountered. Append `:track,nobracket` to show tracking
 	information without brackets (i.e "ahead N, behind M").
 +
-Also respects `:remotename` to state the name of the *remote* instead of
-the ref.
+For any remote-tracking branch `%(upstream)`, `%(upstream:remotename)`
+and `%(upstream:remoteref)` refer to the name of the remote and the
+name of the tracked remote ref, respectively. In other words, the
+remote-tracking branch can be updated explicitly and individually by
+using the refspec `%(upstream:remoteref):%(upstream)` to fetch from
+`%(upstream:remotename)`.
 +
 Has no effect if the ref does not have tracking information associated
 with it.  All the options apart from `nobracket` are mutually exclusive,
@@ -157,9 +161,9 @@ but if used together the last option is selected.
 push::
 	The name of a local ref which represents the `@{push}`
 	location for the displayed ref. Respects `:short`, `:lstrip`,
-	`:rstrip`, `:track`, `:trackshort` and `:remotename` options as
-	`upstream` does. Produces an empty string if no `@{push}` ref is
-	configured.
+	`:rstrip`, `:track`, `:trackshort`, `:remotename`, and `:remoteref`
+	options as `upstream` does. Produces an empty string if no `@{push}`
+	ref is configured.
 
 HEAD::
 	'*' if HEAD matches current ref (the checked out branch), ' '
diff --git a/ref-filter.c b/ref-filter.c
index cde8b97dcb0..3f9161707e6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -77,7 +77,7 @@ static struct used_atom {
 		struct align align;
 		struct {
 			enum {
-				RR_REF, RR_TRACK, RR_TRACKSHORT, RR_REMOTE_NAME
+				RR_REF, RR_TRACK, RR_TRACKSHORT, RR_REMOTE_NAME, RR_REMOTE_REF
 			} option;
 			struct refname_atom refname;
 			unsigned int nobracket : 1, push : 1, push_remote : 1;
@@ -165,6 +165,9 @@ static void remote_ref_atom_parser(const struct ref_format *format, struct used_
 		else if (!strcmp(s, "remotename")) {
 			atom->u.remote_ref.option = RR_REMOTE_NAME;
 			atom->u.remote_ref.push_remote = 1;
+		} else if (!strcmp(s, "remoteref")) {
+			atom->u.remote_ref.option = RR_REMOTE_REF;
+			atom->u.remote_ref.push_remote = 1;
 		} else {
 			atom->u.remote_ref.option = RR_REF;
 			refname_atom_parser_internal(&atom->u.remote_ref.refname,
@@ -1285,6 +1288,16 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 			*s = xstrdup(remote);
 		else
 			*s = "";
+	} else if (atom->u.remote_ref.option == RR_REMOTE_REF) {
+		int explicit;
+		const char *merge;
+
+		merge = remote_ref_for_branch(branch, atom->u.remote_ref.push,
+					      &explicit);
+		if (explicit)
+			*s = xstrdup(merge);
+		else
+			*s = "";
 	} else
 		die("BUG: unhandled RR_* enum");
 }
diff --git a/remote.c b/remote.c
index 685e776a65e..4e93753e198 100644
--- a/remote.c
+++ b/remote.c
@@ -675,6 +675,36 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit)
 	return remote_for_branch(branch, explicit);
 }
 
+const char *remote_ref_for_branch(struct branch *branch, int for_push,
+				  int *explicit)
+{
+	if (branch) {
+		if (!for_push) {
+			if (branch->merge_nr) {
+				if (explicit)
+					*explicit = 1;
+				return branch->merge_name[0];
+			}
+		} else {
+			const char *dst, *remote_name =
+				pushremote_for_branch(branch, NULL);
+			struct remote *remote = remote_get(remote_name);
+
+			if (remote && remote->push_refspec_nr &&
+			    (dst = apply_refspecs(remote->push,
+						  remote->push_refspec_nr,
+						  branch->refname))) {
+				if (explicit)
+					*explicit = 1;
+				return dst;
+			}
+		}
+	}
+	if (explicit)
+		*explicit = 0;
+	return "";
+}
+
 static struct remote *remote_get_1(const char *name,
 				   const char *(*get_default)(struct branch *, int *))
 {
diff --git a/remote.h b/remote.h
index 2ecf4c8c74c..1f6611be214 100644
--- a/remote.h
+++ b/remote.h
@@ -223,6 +223,8 @@ struct branch {
 struct branch *branch_get(const char *name);
 const char *remote_for_branch(struct branch *branch, int *explicit);
 const char *pushremote_for_branch(struct branch *branch, int *explicit);
+const char *remote_ref_for_branch(struct branch *branch, int for_push,
+				  int *explicit);
 
 int branch_has_merge_config(struct branch *branch);
 int branch_merge_matches(struct branch *, int n, const char *);
-- 
2.15.0.windows.1


