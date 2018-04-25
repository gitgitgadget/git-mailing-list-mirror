Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEA6C1F404
	for <e@80x24.org>; Wed, 25 Apr 2018 09:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeDYJyZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 05:54:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:57165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751808AbeDYJyU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 05:54:20 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MT74k-1emUzG26xK-00S8m6; Wed, 25 Apr 2018 11:54:16 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v5 05/11] replace: introduce --convert-graft-file
Date:   Wed, 25 Apr 2018 11:54:15 +0200
Message-Id: <f9ee6d8248d9a3fb0f48ae4e3fd82b2655380168.1524650029.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524650028.git.johannes.schindelin@gmx.de>
References: <cover.1524303776.git.johannes.schindelin@gmx.de> <cover.1524650028.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:Io//sp1wI8+X5zY2GcLRoG5zJUBFsbhJAb16iEo8ESwdItn6365
 Odu7kBFCYMEqdKHl+zn23Cw0SJfU3EpE6WheVueBA6uK7ytaYjrOAZOa54Ri7SquWQHfQPr
 +QuXCFj4ksfksDqhEsxyjsmt+aeuXLW77hOITy++o+rFExR3tQoAMEvOH3KErIUGrrUd6BO
 fgNj72fHZzk8tcKWJVDuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ocRpz5Jlp+4=:vkl7w8rpGtJRiqSew9C+a7
 IyoM7U6oBSsfQyrtZ7RbLl+xZdt2+YHr54mI5auBllUtQRqQl43GqLdQu+V6IDEY6VVeQ6SGz
 JGjYe3qUUnKvkoM6ekk+3JuZYS9nHxMY+VrNifuGvKZ829oIqyOug2e/XNfuHujEg7sk2QXND
 CNJeIN/KixO2pJol5A7ffJeaKMBO4ivpfr0baYz22YgfP9V50kF2AbMKp+mAE9RCAeVr3DDZW
 nTLoFYeOES/JD4pDde1Pi5HbnwQYSzxQXwW+smSdr6WUqEIInRvtN2lQRslhRihfjq/ws2t0l
 ItwOHxdUOhwO3AcXqVJD1F2qLz1d91JkXNXBCNReMPDAC7IwckcGgQbRlTQNWbX60PhTksh2R
 m/tHchzVOInJl5a0Ehp4rlWcxAv1upmiNjWbYpX27ySaUErSTQ482l+nRNo45532gYxXq19bA
 OKgl0krio5oDRGoyoJl+niUMv1QPZKBwqFgCmP9w59s9iJZov+UNSO6EBigDG5Ei+bIYY063a
 2w+1HAKsplCTqLXcaWg6dQxI7VkICe2tFQMldZuex9jEUkSf2CCGXAQpyILM8HdnDI4vqFW3b
 gtH/sx5hFkiOgjzlciOc6/D6HyVEuyEq9AkVGLp7Q5U3MYQbS9RJjbdQZDwBhETTdCyId0VD6
 gCn2KLliGZjbF0vl/BN2zBBzrvKczKilcp/6g/cOQ88jSYcEGMOUJfu4yxn1ehoDhYwhkVP0a
 rNMSy650FeZufyC7IEYorZNZOYNgqi10fA9EnAgnz4x6Wed8KP3/KtQ2JPh4JDXKTVWzMUGbi
 TnDQPdTGZm2yxv+2bHoRfLmJHYa6AOI95EhBA7xSgbtRIjOxbyz25TTEvcBhwjjNv8Db42D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option is intended to help with the transition away from the
now-deprecated graft file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-replace.txt | 11 ++++++---
 builtin/replace.c             | 45 ++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 4 deletions(-)

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
index e92f364e29a..fdd12c5ffc0 100644
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
@@ -471,6 +472,39 @@ static int create_graft(int argc, const char **argv, int force)
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
@@ -482,6 +516,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		MODE_DELETE,
 		MODE_EDIT,
 		MODE_GRAFT,
+		MODE_CONVERT_GRAFT_FILE,
 		MODE_REPLACE
 	} cmdmode = MODE_UNSPECIFIED;
 	struct option options[] = {
@@ -489,6 +524,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete replace refs"), MODE_DELETE),
 		OPT_CMDMODE('e', "edit", &cmdmode, N_("edit existing object"), MODE_EDIT),
 		OPT_CMDMODE('g', "graft", &cmdmode, N_("change a commit's parents"), MODE_GRAFT),
+		OPT_CMDMODE(0, "convert-graft-file", &cmdmode, N_("convert existing graft file"), MODE_CONVERT_GRAFT_FILE),
 		OPT_BOOL_F('f', "force", &force, N_("replace the ref if it exists"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "raw", &raw, N_("do not pretty-print contents for --edit")),
@@ -511,7 +547,8 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 	if (force &&
 	    cmdmode != MODE_REPLACE &&
 	    cmdmode != MODE_EDIT &&
-	    cmdmode != MODE_GRAFT)
+	    cmdmode != MODE_GRAFT &&
+	    cmdmode != MODE_CONVERT_GRAFT_FILE)
 		usage_msg_opt("-f only makes sense when writing a replacement",
 			      git_replace_usage, options);
 
@@ -544,6 +581,12 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
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


