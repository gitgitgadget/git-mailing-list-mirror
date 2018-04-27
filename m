Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D8F1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759311AbeD0Vjw (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:39:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:60331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759084AbeD0Vju (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 17:39:50 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MCfcc-1f2rgW00Xa-009T3s; Fri, 27 Apr 2018 23:39:46 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v6 05/11] replace: introduce --convert-graft-file
Date:   Fri, 27 Apr 2018 23:39:45 +0200
Message-Id: <66157d25f78f596d87c8b9eb1e568c896411e764.1524865158.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524865158.git.johannes.schindelin@gmx.de>
References: <cover.1524650028.git.johannes.schindelin@gmx.de> <cover.1524865158.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:czAArioyeRfrmK4WbOtTer4AcTTzyDfh73QsDI3CgHOjHfDGicM
 tDMU3scr99H3R65So3c/2Cz+oKLpv0uIyb3SbrP5sAf5EGFTIJA/THJiFbEGYOwIL2EZqUS
 KVo1R5uNF4qJa7gWRgqN7NMs/dFudGvL7oZ/n6Yv9abP2cuCagaX1iMQIWvzTxSEighLZyn
 RxmbvoVG0Q7KeLzwh5nig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nUjHGCsWslA=:laA93s+lLB/odeKNFJT8zH
 DZJNKHAQ79Z9E79pZtbupq5m0Lk8ITEn60AFhbcKbk2JUd+CC8k+YWaQ+0jn8WFz09s40opft
 tojPUVSx9fH0SzzUKWpZIeopKSTAEPaSD3D0TsRMq5SunM18XvE35g6xUAHKOw0hzy2CsF/5X
 AS0tXFeFdSsWaubomstI76yMwtkMQnbktDpwnPi7mGULhkY+sWcRWprBw4rCabiGDE1vgDLFY
 glyVv9kODlFIfwCVOhI5iRMAUIJqdI786GUlt9lbVQOrIn1rNI+DEXexKqdUILxRkOiyBhaMI
 bjfxql/efDCEospYxlZdM+p3OY64W8Sj63/HPXr7vtmOlogB85giYJKxiDBcGeVeHLixfF9Sr
 W3rpuKe3QdfxmAHZl1Kwo1fdb9w5Z0UxHbMnvWvZvNXh7V49CAXfIESzGyNWPPT0EUB0yi316
 j58O/qQmDfYsM3wu1dte/XC+1zaK8cXsFILoJAdWdl57WQmF0QyiJ7NU7FeonBwYGHonG7KnW
 BVjynu14CUxb0lJbgoU0n0AEYWAJeWGVWYRX6KWx03oAxnQ9ISifv8m2xyaXt2NaPGed1FCHJ
 bcagngOKSZwsmFaW+LNi0wT1a0ytm0GrTNYvAXixK7UkDNYIzXfiTSw2emYeHY8KA/nAiCaLe
 6qOMV3YhrJgbhFjLw7gvA0/Cwr0sTTO+yKK4qTtyV+BGsgELOnOhKCUmBwKQhv7wGhWT5chTz
 6yTZfDXzf0f3zzuwyrzy6pT8oi6Wu9tLsiVED2n8BCYcNw6rH7HnHwJ7BoKFqq5yP/BmmIWpj
 GCVBSmt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option is intended to help with the transition away from the
now-deprecated graft file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-replace.txt | 11 ++++++---
 builtin/replace.c             | 44 ++++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index e5c57ae6ef4..246dc9943c2 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 'git replace' [-f] <object> <replacement>
 'git replace' [-f] --edit <object>
 'git replace' [-f] --graft <commit> [<parent>...]
+'git replace' [-f] --convert-graft-file
 'git replace' -d <object>...
 'git replace' [--format=<format>] [-l [<pattern>]]
 
@@ -87,9 +88,13 @@ OPTIONS
 	content as <commit> except that its parents will be
 	[<parent>...] instead of <commit>'s parents. A replacement ref
 	is then created to replace <commit> with the newly created
-	commit. See contrib/convert-grafts-to-replace-refs.sh for an
-	example script based on this option that can convert grafts to
-	replace refs.
+	commit. Use `--convert-graft-file` to convert a
+	`$GIT_DIR/info/grafts` file and use replace refs instead.
+
+--convert-graft-file::
+	Creates graft commits for all entries in `$GIT_DIR/info/grafts`
+	and deletes that file upon success. The purpose is to help users
+	with transitioning off of the now-deprecated graft file.
 
 -l <pattern>::
 --list <pattern>::
diff --git a/builtin/replace.c b/builtin/replace.c
index e57d3d187ed..35394ec1874 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -20,6 +20,7 @@ static const char * const git_replace_usage[] = {
 	N_("git replace [-f] <object> <replacement>"),
 	N_("git replace [-f] --edit <object>"),
 	N_("git replace [-f] --graft <commit> [<parent>...]"),
+	N_("git replace [-f] --convert-graft-file"),
 	N_("git replace -d <object>..."),
 	N_("git replace [--format=<format>] [-l [<pattern>]]"),
 	NULL
@@ -476,6 +477,38 @@ static int create_graft(int argc, const char **argv, int force)
 	return replace_object_oid(old_ref, &old_oid, "replacement", &new_oid, force);
 }
 
+static int convert_graft_file(int force)
+{
+	const char *graft_file = get_graft_file();
+	FILE *fp = fopen_or_warn(graft_file, "r");
+	struct strbuf buf = STRBUF_INIT, err = STRBUF_INIT;
+	struct argv_array args = ARGV_ARRAY_INIT;
+
+	if (!fp)
+		return -1;
+
+	while (strbuf_getline(&buf, fp) != EOF) {
+		if (*buf.buf == '#')
+			continue;
+
+		argv_array_split(&args, buf.buf);
+		if (args.argc && create_graft(args.argc, args.argv, force))
+			strbuf_addf(&err, "\n\t%s", buf.buf);
+		argv_array_clear(&args);
+	}
+	fclose(fp);
+
+	strbuf_release(&buf);
+
+	if (!err.len)
+		return unlink_or_warn(graft_file);
+
+	warning(_("could not convert the following graft(s):\n%s"), err.buf);
+	strbuf_release(&err);
+
+	return -1;
+}
+
 int cmd_replace(int argc, const char **argv, const char *prefix)
 {
 	int force = 0;
@@ -487,6 +520,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		MODE_DELETE,
 		MODE_EDIT,
 		MODE_GRAFT,
+		MODE_CONVERT_GRAFT_FILE,
 		MODE_REPLACE
 	} cmdmode = MODE_UNSPECIFIED;
 	struct option options[] = {
@@ -494,6 +528,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete replace refs"), MODE_DELETE),
 		OPT_CMDMODE('e', "edit", &cmdmode, N_("edit existing object"), MODE_EDIT),
 		OPT_CMDMODE('g', "graft", &cmdmode, N_("change a commit's parents"), MODE_GRAFT),
+		OPT_CMDMODE(0, "convert-graft-file", &cmdmode, N_("convert existing graft file"), MODE_CONVERT_GRAFT_FILE),
 		OPT_BOOL_F('f', "force", &force, N_("replace the ref if it exists"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "raw", &raw, N_("do not pretty-print contents for --edit")),
@@ -516,7 +551,8 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 	if (force &&
 	    cmdmode != MODE_REPLACE &&
 	    cmdmode != MODE_EDIT &&
-	    cmdmode != MODE_GRAFT)
+	    cmdmode != MODE_GRAFT &&
+	    cmdmode != MODE_CONVERT_GRAFT_FILE)
 		usage_msg_opt("-f only makes sense when writing a replacement",
 			      git_replace_usage, options);
 
@@ -549,6 +585,12 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 				      git_replace_usage, options);
 		return create_graft(argc, argv, force);
 
+	case MODE_CONVERT_GRAFT_FILE:
+		if (argc != 0)
+			usage_msg_opt("--convert-graft-file takes no argument",
+				      git_replace_usage, options);
+		return !!convert_graft_file(force);
+
 	case MODE_LIST:
 		if (argc > 1)
 			usage_msg_opt("only one pattern can be given with -l",
-- 
2.17.0.windows.1.33.gfcbb1fa0445


