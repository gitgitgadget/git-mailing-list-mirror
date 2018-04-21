Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409D91F424
	for <e@80x24.org>; Sat, 21 Apr 2018 09:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbeDUJsj (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 05:48:39 -0400
Received: from mout.gmx.net ([212.227.17.20]:35325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbeDUJsi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 05:48:38 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mcyxq-1erkHb12kU-00IGp9; Sat, 21
 Apr 2018 11:48:33 +0200
Date:   Sat, 21 Apr 2018 11:48:17 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 05/11] replace: introduce --convert-graft-file
In-Reply-To: <cover.1524303776.git.johannes.schindelin@gmx.de>
Message-ID: <fd4ea54ad8da5e4e93fafd558e104b0a19f6268c.1524303776.git.johannes.schindelin@gmx.de>
References: <cover.1524262793.git.johannes.schindelin@gmx.de> <cover.1524303776.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YtPx/O76qnfeYZQJ3eIi82rs3JemV+wlAFu9MSDR/7EXuJyMb3C
 CT5EjwviTtyHjcyenAPYlSKHfIcQlIjABr4EM3umVSxzJINS0NOH/ot1yXt+rtWT/oAZGo9
 4njnUR/F36zdECFZIVcUgZqq9xRBtE/+mEzHAb6hEV6hp52tBPEOUCpxlaJNadFVkO34YOh
 Kgm2qbHHtARgq6+Ms2wEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2u+JWpLJDT8=:uitvZD6aDTyr1KxzspP+MT
 4T/hWd2qxd1MzYo3RudpfBLxemMrCiIx2cFhYJKs+cGMdADH7R2Mz3e0YeYZe0ts2qh1Xn4/C
 rgQIh5Zp+zr885fWr5RfNuJxoO/hDn5H/R6Hpm16Ui06IuuAuJ4k17u0714MYFHiYM1r3sbWm
 Ya0x8n+WJaS+dyli8uP9MgpA9bkEvSrycg9yCIo9FmH2uoJz22SCuzhsxf7GL+UpB7f0Omb+T
 5mU3GB8COdgS/3QCREqh0jnuntXhV1UcjMyzKhNNBMNXCmk6m+rzQGfKFOd+Tf4JbxDwHj96j
 DikN7nzHBiX5EQpNyLyyUkgDigk/UGTEPdu+LdR9K5pHWtMLHU5g/arb8J8JwYq7LQIjokuSh
 4OUwWiRuzQ01Vv+NtLlmsRqTcyq4Q5TeL4pw/auZeJlkxrlJ6CSvMPJbREMN0RXT5Z98u4zDA
 Jburzx2UuUA6G7KhHYObp+MINiPuw/Yjx6CMb5Vcgospn9Vf81w33s+EoNrtM17aWJwn3uV7n
 1iR/F39SoT2jD25i+hD8QYWSaK1ALXTzp1lN5fzl86V4EqfgAOQy2oDqdsFlyBuP63CEKu1bS
 mKUjareGCHsy+AJheL3M6xHil2YHtYIiiZvtmUdeicCz80DI6T/C+fTd3RZ54FB2HXO1PSHiB
 ehoVHUX3bqMJ84h+EIseGxtaMsSTugJ7VqQuC4XCX/v3YpRSIfRcS5/J08Jy6a2f4PuLy0Ji8
 VORO2eFI/o1aHHe55gTV1fvZ2mbYKoUQD6rASNCTyOZKR3UK58pYm6g+8WQYWdBI6h7vXpsFj
 dJQ77Ee2Ty6INlYAthG9E0T+UO28EwOI5N8HmkcvcU/4Zof+e0=
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
index f63df405fd0..6b3e0301e90 100644
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
@@ -454,6 +455,38 @@ static int create_graft(int argc, const char **argv, int force)
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
+
+	strbuf_release(&buf);
+	argv_array_clear(&args);
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
@@ -465,6 +498,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		MODE_DELETE,
 		MODE_EDIT,
 		MODE_GRAFT,
+		MODE_CONVERT_GRAFT_FILE,
 		MODE_REPLACE
 	} cmdmode = MODE_UNSPECIFIED;
 	struct option options[] = {
@@ -472,6 +506,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete replace refs"), MODE_DELETE),
 		OPT_CMDMODE('e', "edit", &cmdmode, N_("edit existing object"), MODE_EDIT),
 		OPT_CMDMODE('g', "graft", &cmdmode, N_("change a commit's parents"), MODE_GRAFT),
+		OPT_CMDMODE(0, "convert-graft-file", &cmdmode, N_("convert existing graft file"), MODE_CONVERT_GRAFT_FILE),
 		OPT_BOOL_F('f', "force", &force, N_("replace the ref if it exists"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "raw", &raw, N_("do not pretty-print contents for --edit")),
@@ -494,7 +529,8 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 	if (force &&
 	    cmdmode != MODE_REPLACE &&
 	    cmdmode != MODE_EDIT &&
-	    cmdmode != MODE_GRAFT)
+	    cmdmode != MODE_GRAFT &&
+	    cmdmode != MODE_CONVERT_GRAFT_FILE)
 		usage_msg_opt("-f only makes sense when writing a replacement",
 			      git_replace_usage, options);
 
@@ -527,6 +563,12 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
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
2.17.0.windows.1.15.gaa56ade3205


