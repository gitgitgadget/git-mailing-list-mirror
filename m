Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94FD61F428
	for <e@80x24.org>; Sat, 28 Apr 2018 22:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752540AbeD1Wor (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 18:44:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:40657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752502AbeD1Woq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 18:44:46 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MSHax-1ep4YT07x5-00TSlr; Sun, 29 Apr 2018 00:44:42 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v7 06/12] replace: introduce --convert-graft-file
Date:   Sun, 29 Apr 2018 00:44:35 +0200
Message-Id: <7bf28028005b483e4d1b22b7e68bdbc042dfcf9d.1524955439.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
MIME-Version: 1.0
In-Reply-To: <cover.1524955439.git.johannes.schindelin@gmx.de>
References: <cover.1524865158.git.johannes.schindelin@gmx.de> <cover.1524955439.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:R9SBBC1Q3KWOayq0YkgwMMnR7zYOk9C+0V8qpAkMfs6mm6kvzbm
 kECM7b/4p9F7Zssf85CACDSRbaeatGr1JgC9BCZIrt/cXzH47I5w3yBNtaOzQBvaaQKtO5E
 JwMu9QpNpUTNxYA58kJ6SDkhgCaTfvlRGgqayRuSQ5iyVE33qhZnIJtvUX7emrNjyx7D02m
 XVrOa66+xn7udLyLBIN0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YkuSqDUMuCc=:u5XFoi+StvXNs1lhasR2yU
 ImmFxuN96RQ/13gbPRoAWKRuWrLS81lklwIgEX343CLDTDmccORcYUqoRyVw6M7LEQ+6tfrWv
 Lse7PXGLc+JBfiGhEbnaCipPa9uS1tiWrZ+9xUHai0aj6GL3CxleySbY7xonEB/BkDZ9X94qo
 15+QwWAauoLHU41yq+fYP4nhQQc2iH6G8/cXdnZkGOIH8NDe0/BNAUdHIp2dZG3mYLQ9L+ApE
 Lc0TwCQj78lOqNmIWQiY1yRLDdhbogDOmcsK+jIfbIReQmxquElAh849IftcKvb/iWj6piTOl
 EV/TQWinGFvuInWjxulzV3osv6plULuSlenfk9WL/+pTWnFfZGI7ivkT8seW8azh/BMqIGGa1
 eDEJPnBjZ57P+9eFQIvl++ynHPcPwHxcXjadB8GTJzcGuDjPKqr9L95hLFplWzTjty5zV2g8B
 g41/EAwdgSGaV43ugbVg+suGlO6MfiHVSgfc2iBK/CtzVeKJdWQBsWDhlnZjOpNFEFCedhymw
 IWzedene8O+3kVc1LRJIcsBvuT6JNrUB59F7LeMmpMsg1nw4DM/FJrjy3HEgtgLP6ngw8UZEG
 woUFlFTG8zCgXmQC5Kx9jyZXBnS7R0UdQQDgZ4mo6xEzy9I+L2FoMCog4Yzdr5Dt6sYmMo8va
 9vgw9j0Aoqp1FCMQfpvdt67O2A6qWDi1mQ/U1Vi9aGx0WO6dOrhCCV8UNWh2bMCJQCFuBUPK2
 jawOiTw2zU99Dw2Icx5SWMjT+MU4B4eF8zbp8dihWXlKEwTX9IsOHCuX41XgQ5q6ucgoM0/GW
 /d8U72Y
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
index 64f58112701..a87fca045be 100644
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
@@ -481,6 +482,38 @@ static int create_graft(int argc, const char **argv, int force, int gentle)
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
+		if (args.argc && create_graft(args.argc, args.argv, force, 1))
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
@@ -492,6 +525,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		MODE_DELETE,
 		MODE_EDIT,
 		MODE_GRAFT,
+		MODE_CONVERT_GRAFT_FILE,
 		MODE_REPLACE
 	} cmdmode = MODE_UNSPECIFIED;
 	struct option options[] = {
@@ -499,6 +533,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete replace refs"), MODE_DELETE),
 		OPT_CMDMODE('e', "edit", &cmdmode, N_("edit existing object"), MODE_EDIT),
 		OPT_CMDMODE('g', "graft", &cmdmode, N_("change a commit's parents"), MODE_GRAFT),
+		OPT_CMDMODE(0, "convert-graft-file", &cmdmode, N_("convert existing graft file"), MODE_CONVERT_GRAFT_FILE),
 		OPT_BOOL_F('f', "force", &force, N_("replace the ref if it exists"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "raw", &raw, N_("do not pretty-print contents for --edit")),
@@ -521,7 +556,8 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 	if (force &&
 	    cmdmode != MODE_REPLACE &&
 	    cmdmode != MODE_EDIT &&
-	    cmdmode != MODE_GRAFT)
+	    cmdmode != MODE_GRAFT &&
+	    cmdmode != MODE_CONVERT_GRAFT_FILE)
 		usage_msg_opt("-f only makes sense when writing a replacement",
 			      git_replace_usage, options);
 
@@ -554,6 +590,12 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 				      git_replace_usage, options);
 		return create_graft(argc, argv, force, 0);
 
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
2.17.0.windows.1.36.gdf4ca5fb72a


