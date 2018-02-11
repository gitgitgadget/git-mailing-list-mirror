Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E52301F404
	for <e@80x24.org>; Sun, 11 Feb 2018 00:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753007AbeBKAKb (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 19:10:31 -0500
Received: from mout.gmx.net ([212.227.15.19]:47819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753000AbeBKAK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 19:10:29 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0LgYuT-1f5Cix46Rp-00nyeI; Sun, 11 Feb 2018 01:10:23 +0100
Date:   Sun, 11 Feb 2018 01:10:22 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 06/12] sequencer: fast-forward merge commits, if
 possible
In-Reply-To: <cover.1518307771.git.johannes.schindelin@gmx.de>
Message-ID: <45cb7777b89da2e22a144496530be74846700040.1518307772.git.johannes.schindelin@gmx.de>
References: <cover.1517266437.git.johannes.schindelin@gmx.de> <cover.1518307771.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CF4zA+Ot2NpzNkQaFAjiOOxX9Ur3Z05CCudJO42fF/SY33QLPTg
 xG245xl4Zl5ohgLlCUATmVxeoh8y0QuUr6stwkUtpTsAcVcstKbkdw4YGl2PEa4BxYIFGxP
 7WFdab6aifcn65eoCo+A4xl1QTitMUlYd6lwMmhv3clZ6rdsj74wlwJKtsrr+jctrwji4ef
 YvNbInPLwDw/nTpKubuBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:93f/sF44W18=:x7t1KMnBXsJ8P4fUpSEXa0
 qeVxWHtGOS1h55vl6HbWKmpZVM+04XoDwqWKy1rqpp2bfO6ceVxQv2b2vF0DHzlomVnh8P295
 DZwDrY49Z1NTbom2ZZmseIfkzhN0fK/YwPXx8K9MY9jop5/f1qcKTGLdDyFEpoQaloXA77MPr
 YgWFToaTUI4VqEtY+LGrBoVIZAVPQAS5c7byeLiy/LaCGuQ0pLqidid/v597NncXHQYSx5k1w
 QBabOPRZCZh/prAjdwx6zcuNqOQVxQ1hDRIuBJA2/yl9CX/rK+LIRLkbpIFtC6yjwyW1Msgx7
 XbC9eVD14ngagKKCuZqafCZNkLIQEU29GzFQdw553Pz+q8/I0ooJjUx9Y0ZFTgmxl+GmSndtG
 zvakeBoj5n3X/wowjy00OotIh+TJ9XI++x8kpSo6wmRyDfnuifBxp/u/4KC5MG7AAKObhdhCM
 b2KTXS+UqnfNyOBq3CpE0EPL7ZxMaEXfBOzvAyUgqhqwJ13XgQyAMVlBNA2FEp56l+UNw9D6/
 JEAyCfAXrSgXSNcQWlW6tgq8tRnLBAHzR4q8IDJ1DLkRpntYyOGv0mY9THfgl3xkmDWipPTO+
 CPTeiHtlsCVGMpMEN5P62bIGCIHfQS1Uzm1c1UsIFzny6Rs5fKA4YblqjkXnlMXxDrkul0uCY
 Xrjdy7e351zTdQywJeOHG4C4pwztJqqO3d5WQ7fRhBqFidciLEihVTIgcHIhLBg+JI68sy7Qa
 fghic06fu0PVl3miNtlSkX6n5QF9zSUheYLPYdNXttkUdENJEH0ApRIHZ419sDr+0tOpYO5qm
 ijCPmmAiUPQD4WGkLeDF6knNoq+ybt9png0QK8DkEFdOSJ4cnM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like with regular `pick` commands, if we are trying to recreate a
merge commit, we now test whether the parents of said commit match HEAD
and the commits to be merged, and fast-forward if possible.

This is not only faster, but also avoids unnecessary proliferation of
new objects.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index e577c213494..27d582479d1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2123,7 +2123,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	struct commit *head_commit, *merge_commit, *i;
 	struct commit_list *common, *j, *reversed = NULL;
 	struct merge_options o;
-	int ret;
+	int can_fast_forward, ret;
 	static struct lock_file lock;
 
 	for (merge_arg_len = 0; merge_arg_len < arg_len; merge_arg_len++)
@@ -2191,6 +2191,14 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		strbuf_release(&buf);
 	}
 
+	/*
+	 * If HEAD is not identical to the parent of the original merge commit,
+	 * we cannot fast-forward.
+	 */
+	can_fast_forward = opts->allow_ff && commit && commit->parents &&
+		!oidcmp(&commit->parents->item->object.oid,
+			&head_commit->object.oid);
+
 	strbuf_addf(&ref_name, "refs/rewritten/%.*s", merge_arg_len, arg);
 	merge_commit = lookup_commit_reference_by_name(ref_name.buf);
 	if (!merge_commit) {
@@ -2204,6 +2212,17 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		rollback_lock_file(&lock);
 		return -1;
 	}
+
+	if (can_fast_forward && commit->parents->next &&
+	    !commit->parents->next->next &&
+	    !oidcmp(&commit->parents->next->item->object.oid,
+		    &merge_commit->object.oid)) {
+		strbuf_release(&ref_name);
+		rollback_lock_file(&lock);
+		return fast_forward_to(&commit->object.oid,
+				       &head_commit->object.oid, 0, opts);
+	}
+
 	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
 		      git_path_merge_head(), 0);
 	write_message("no-ff", 5, git_path_merge_mode(), 0);
-- 
2.16.1.windows.1


