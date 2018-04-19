Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF6A71F424
	for <e@80x24.org>; Thu, 19 Apr 2018 08:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeDSISO (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 04:18:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:47461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751957AbeDSISM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 04:18:12 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYKGj-1ew6LG06Hx-00V8xk; Thu, 19
 Apr 2018 10:18:07 +0200
Date:   Thu, 19 Apr 2018 10:17:50 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 2/7] replace: introduce --convert-graft-file
In-Reply-To: <cover.1524125760.git.johannes.schindelin@gmx.de>
Message-ID: <cecb82973f80fdd2db940410db2a7c3b23107c4b.1524125760.git.johannes.schindelin@gmx.de>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de> <cover.1524125760.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TXphj7wqwEjL/C5Xvco89wpzICsMsl8gWTpr3BGMejCFvPGR2qY
 EhMIWTzdtMhSEjgKyJbUnUIaRQroSJy2rPeKdIeZWS4rDZnhNqiw6GVlHaXX1B+ozGZIk/X
 3rsWHbszln4pFwPpz5Kj9Ol8jyYKpSCz703C9fDUq2HQTVULRX9S5RKmWERegXj0ho2uIC5
 mN5RspYwos18j6a7HbHvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0Yje2ph0MYo=:RQF/1+jyAHGDL98l3tcUam
 8TxFm/eCRYwP2AYa0/mggAEoiE2YbsW/Mflh5OWzF5bEBpl6ykLU0WBAxGlKNcwXoixYgITid
 WdR6ZpXzzG0ty2rDaH+uXQdSzRZIIYp2ojWMKXj980V+CJxZmHj27wxa7McNoeuc/mr2LtHUN
 xFqU9IHkMktf7vSUH1AX1rhqQFQnVviMscrJA9oc6hfVFLjteFfYwySD7dNSFbHluyiqSEWna
 p71za/NITgxZrc3zMuG5YAmrvxsIpiue3M6O4MjYvN7xPm82VA86NnTFBpLUNKaQ83A0In2ca
 dozQgb82Z85prcy3X5BkO1IIicTsbsKlolY0bMKerz4vWDaAAIgkld3J48h7rMtz2T6Dm12Yy
 JCXxAg2GakOv6rp8M/9m+7gX9znu/uFK9WxqEh4oVHlRgOskmReNRYsdzd5D9xnMO7rhMqxTd
 W5xiXXADCRxpD8gU7OZ/FQmrAhGWGWw8WnOX86om+lp05qZ51F7LpHDOpgIS4srOY/0Wx3A2s
 4tktZ3heeg6aCmcG8F+YHAm4kHPXQG9WRbUzakGNqJ2Lfm6hiZnRq6QViCZW+EHnx84m8GaZ9
 eF7DKCv3jbVemVcg4Od4gZl2dvs/q2fPiF9dSmFo1zOkeIX/gyBwmt6M1LBQg9eqfox2zB78q
 z+R9wWpYyXbVNGhtHXSWP5koKIzyl7sCXWNM+RdxC15j1vKnwNwRAK2mVIC6HRXDbHe0sPTDq
 dVJJEFjh4KrsVcfAey9n+oUbzflm1QMNhQ3VJHYcDMKyEhEQCaMiHh/+OJNcwh3graxXlVGxP
 DTEb8jYwAX+bIOZJPKIq9T1sF1tfidy0EwzhnVuRHnhffWZUWw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option is intended to help with the transition away from the
now-deprecated graft file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-replace.txt | 11 +++++--
 builtin/replace.c             | 59 ++++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index e5c57ae6ef4..4dc0686f7d6 100644
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
+	`$GIT_DIR/info/grafts` file use replace refs instead.
+
+--convert-graft-file::
+	Creates graft commits for all entries in `$GIT_DIR/info/grafts`
+	and deletes that file upon success. The purpose is to help users
+	with transitioning off of the now-deprecated graft file.
 
 -l <pattern>::
 --list <pattern>::
diff --git a/builtin/replace.c b/builtin/replace.c
index 43264f0998e..4cdc00a96df 100644
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
@@ -423,6 +424,53 @@ static int create_graft(int argc, const char **argv, int force)
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
+		int i = 0, j;
+
+		while (i != buf.len) {
+			char save;
+
+			for (j = i; j < buf.len && !isspace(buf.buf[j]); j++)
+				; /* look further */
+			save = buf.buf[j];
+			buf.buf[j] = '\0';
+			argv_array_push(&args, buf.buf + i);
+			buf.buf[j] = save;
+
+			while (j < buf.len && isspace(buf.buf[j]))
+				j++;
+			i = j;
+		}
+
+		if (create_graft(args.argc, args.argv, force))
+			strbuf_addf(&err, "\n\t%s", buf.buf);
+
+		argv_array_clear(&args);
+		strbuf_reset(&buf);
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
@@ -434,6 +482,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		MODE_DELETE,
 		MODE_EDIT,
 		MODE_GRAFT,
+		MODE_CONVERT_GRAFT_FILE,
 		MODE_REPLACE
 	} cmdmode = MODE_UNSPECIFIED;
 	struct option options[] = {
@@ -441,6 +490,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete replace refs"), MODE_DELETE),
 		OPT_CMDMODE('e', "edit", &cmdmode, N_("edit existing object"), MODE_EDIT),
 		OPT_CMDMODE('g', "graft", &cmdmode, N_("change a commit's parents"), MODE_GRAFT),
+		OPT_CMDMODE(0, "convert-graft-file", &cmdmode, N_("convert existing graft file"), MODE_CONVERT_GRAFT_FILE),
 		OPT_BOOL_F('f', "force", &force, N_("replace the ref if it exists"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "raw", &raw, N_("do not pretty-print contents for --edit")),
@@ -463,7 +513,8 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 	if (force &&
 	    cmdmode != MODE_REPLACE &&
 	    cmdmode != MODE_EDIT &&
-	    cmdmode != MODE_GRAFT)
+	    cmdmode != MODE_GRAFT &&
+	    cmdmode != MODE_CONVERT_GRAFT_FILE)
 		usage_msg_opt("-f only makes sense when writing a replacement",
 			      git_replace_usage, options);
 
@@ -496,6 +547,12 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
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
2.17.0.windows.1.4.g7e4058d72e3


