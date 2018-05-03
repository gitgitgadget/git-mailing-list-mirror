Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06061200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeECPa7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:30:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:34573 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbeECPa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:30:56 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LvlWS-1eI9KB3jtE-017XDO; Thu, 03 May 2018 17:30:52 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/18] branch-diff: adjust the output of the commit pairs
Date:   Thu,  3 May 2018 17:30:51 +0200
Message-Id: <40471263d3cbf5b3a3b195ecfe51921dfd53a7c6.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gYTeKFe/SD9K+GJM24ontMc7g3ZI9mCtEmFfHlH7cB8wHfr18Zb
 WsaDjD3AipieTxy4xLYAQ/xfDSdd1tndGZZRSvRHNH3cU/7xZWeJlExc69TXhBeIJS0lYIo
 ulPz4Lxp8LmhaMJ/1VzgB34NBSFh3yO7M3pHTXoCR7iAgSbPLvRBW+i7EV6qG0JjtHY2d+s
 WZMY6pwLGbydl9QcrVpuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VdbVG0CUlcc=:PvnvydcWUq27nfX3RsbLHm
 gzf2XHJppZWeXevFN+K7cN0E3dtyC8J7xnFUsZVw+ZMSGUrEXiIvIyhk3YN9TMhnYNQZ5t3dC
 wpYkIHQ4EPTyaQATzbyCYWNtXDAYyb+SqaEPGKvIr5SyZmQ/9Ra6Dwww8k22L+yHUynGDKJcy
 uWVVDEp4n1lQELRji/c64rbfUsBPTUgowOxwnlk7AlsiCtmjJQSxzVzlMcBZ0hXnRewqpd1mb
 ///UHTByjLwuX1TV4U09f7Drb5ziz1oIfkQDL5kFMcdUqXXWieg7WxmwBff68pyqkk1j0oNn4
 m2OuIuX2pvIOaUgGeMQLkUG67u6+h/fPr6okjKottiXQmpjuB/OLRxFYy80BjVuCNRToHq7u6
 t68glWk8ylSSliO3PMSanYPACL+jen+a5xJa76Ix8RNp9U6hosnQcOkySgmMnVF5Et2gUT1O/
 BJj/gfhRUmpsAZgYlvk8dftfamQw/FRr5JjHTfmyYpHQrIYHsW439DkhfwmS00bjX5lzmdTD7
 wASXojMi1mS6Q78nxd/P1C2E8rnS++TfjhNm3AhwmB6JEKQEmKwrmcjmr3U9pW3Orov+D15ID
 andIU8bRPl6f2SnFj9NcxujqNOGA+c2hijqOXL5Dl8KizL/o3BWuiiiMxX05pARnzD5yEeJOY
 gdUKipdqli2GRt7p4XPl7OqIpPzbMvRiEr/Js9FNCzaDWtlCT1R43fjYK8cBfMFNF9804EKf7
 sQhQL3hNuaROBBsmMvFZYZFL+yVSWhmEJNLrqYLu1VJvM1v62MqEPI2na410Osel8zCoMqBNI
 YqkWKuh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change brings branch-diff yet another step closer to feature parity
with tbdiff: it now shows the oneline, too, and indicates with `=` when
the commits have identical diffs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch-diff.c | 67 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index 9edc5a0e89b..0a0564b8ec2 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -8,6 +8,8 @@
 #include "hungarian.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "commit.h"
+#include "pretty.h"
 
 static const char * const builtin_branch_diff_usage[] = {
 	N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
@@ -267,9 +269,57 @@ static int get_correspondences(struct string_list *a, struct string_list *b,
 	return res;
 }
 
-static const char *short_oid(struct patch_util *util)
+static void output_pair_header(struct strbuf *buf,
+			       int i, struct patch_util *a_util,
+			       int j, struct patch_util *b_util)
 {
-	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
+	static char *dashes;
+	struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
+	struct commit *commit;
+
+	if (!dashes) {
+		char *p;
+
+		dashes = xstrdup(find_unique_abbrev(oid, DEFAULT_ABBREV));
+		for (p = dashes; *p; p++)
+			*p = '-';
+	}
+
+	strbuf_reset(buf);
+	if (i < 0)
+		strbuf_addf(buf, "-:  %s ", dashes);
+	else
+		strbuf_addf(buf, "%d:  %s ", i + 1,
+			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
+
+	if (i < 0)
+		strbuf_addch(buf, '>');
+	else if (j < 0)
+		strbuf_addch(buf, '<');
+	else if (strcmp(a_util->patch, b_util->patch))
+		strbuf_addch(buf, '!');
+	else
+		strbuf_addch(buf, '=');
+
+	if (j < 0)
+		strbuf_addf(buf, " -:  %s", dashes);
+	else
+		strbuf_addf(buf, " %d:  %s", j + 1,
+			    find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));
+
+	commit = lookup_commit_reference(oid);
+	if (commit) {
+		const char *commit_buffer = get_commit_buffer(commit, NULL);
+		const char *subject;
+
+		find_commit_subject(commit_buffer, &subject);
+		strbuf_addch(buf, ' ');
+		format_subject(buf, subject, " ");
+		unuse_commit_buffer(commit, commit_buffer);
+	}
+	strbuf_addch(buf, '\n');
+
+	fwrite(buf->buf, buf->len, 1, stdout);
 }
 
 static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
@@ -303,6 +353,7 @@ static void patch_diff(const char *a, const char *b,
 static void output(struct string_list *a, struct string_list *b,
 		   struct diff_options *diffopt)
 {
+	struct strbuf buf = STRBUF_INIT;
 	int i = 0, j = 0;
 
 	/*
@@ -324,25 +375,22 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched LHS commit whose predecessors were shown. */
 		if (i < a->nr && a_util->matching < 0) {
-			printf("%d: %s < -: --------\n",
-			       i + 1, short_oid(a_util));
+			output_pair_header(&buf, i, a_util, -1, NULL);
 			i++;
 			continue;
 		}
 
 		/* Show unmatched RHS commits. */
 		while (j < b->nr && b_util->matching < 0) {
-			printf("-: -------- > %d: %s\n",
-			       j + 1, short_oid(b_util));
+			output_pair_header(&buf, -1, NULL, j, b_util);
 			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
 
 		/* Show matching LHS/RHS pair. */
 		if (j < b->nr) {
 			a_util = a->items[b_util->matching].util;
-			printf("%d: %s ! %d: %s\n",
-			       b_util->matching + 1, short_oid(a_util),
-			       j + 1, short_oid(b_util));
+			output_pair_header(&buf,
+					   b_util->matching, a_util, j, b_util);
 			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
 				patch_diff(a->items[b_util->matching].string,
 					   b->items[j].string, diffopt);
@@ -350,6 +398,7 @@ static void output(struct string_list *a, struct string_list *b,
 			j++;
 		}
 	}
+	strbuf_release(&buf);
 }
 
 int cmd_branch_diff(int argc, const char **argv, const char *prefix)
-- 
2.17.0.395.g6a618d6010f.dirty


