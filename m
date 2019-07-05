Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 040B31F461
	for <e@80x24.org>; Fri,  5 Jul 2019 17:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfGERHN (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 13:07:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33750 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfGERHM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 13:07:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so10642047wru.0
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rKS8urdBItbRr0HeEgG8ThxZLrSHodQXAYOsBJNUTt8=;
        b=upe+g2qjRpBYRb04XcdKdc2j1aEnQD7J9/BZ96ko8TPpvLmrq/4DxYOoPXEF8Ecxbs
         2JK74PrNmOTN4WIcLPGEQ0bFSPE1hLe8GE1e7YrI8P7hZ5iYB6ZpKxHYK2xFg035G8uC
         M+P1t82mK21zUGyMsmRnKx3zQFv9gN373MK7yXcZ3dhHICP0m/reQb9zOEt1uhCLe8HD
         GY2O+dgWm1AM1gNcOUG/gs1ecdrTpd5HtjO5AhPnLVlQ+YFZoBw2tUoWJSEZ7Y0/FV7u
         XEd56eYqtksE2fEHyTnzqUEICt9DHt8K85DlSK1bNA6APidB+e5JNmsW4J4ONIRUcnY7
         JjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rKS8urdBItbRr0HeEgG8ThxZLrSHodQXAYOsBJNUTt8=;
        b=mMeS07vrjrFO6O7mgescfpbd/5aE93+ODMMGWQRF/wm0/e5m82bb6j11023HD1zpnM
         8SxZYn8yD3TqXQd7fJU0veyi9QON7jfs69A38QTS/mOmBeB1Ms8pD5Ip9/3zoFZeDUDJ
         z02h0+3eLsFj46jLPnMM2Ft3izvjtG96xZ4k5Qw0YQtUfD8LMs0fcEQbW1I6moazrZoX
         pn5tF841a76m5zNrcfWuW6oZaNQk3YXQ4dIOZUbn8v7Wm684uywMI/m6SoQBOKtANP3M
         3Iq4T9LAzpJY6khqmvmxYCouXwnvVOJ+HZMPldyO7gcTx6n4trz/1ujr2yicPWQ4vGAu
         jNLw==
X-Gm-Message-State: APjAAAUNtyRdLJ8JZi+MdAISqzEH3JRLIXtxepYqClneyxp2ajOnH6VS
        2QOwa+YJezqOZWwHXfZmyesXteU1
X-Google-Smtp-Source: APXvYqxBWnxUAuRYXg5BU7M16OaYnAPU4CpHqKpgpY7/SV7VMBt2LsarnfHk0uLy/EQXh4By03/nPw==
X-Received: by 2002:adf:db07:: with SMTP id s7mr4687456wri.10.1562346429233;
        Fri, 05 Jul 2019 10:07:09 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id o11sm9144796wmh.37.2019.07.05.10.07.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 10:07:08 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 12/14] range-diff: add section header instead of diff header
Date:   Fri,  5 Jul 2019 18:06:28 +0100
Message-Id: <20190705170630.27500-13-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190705170630.27500-1-t.gummerer@gmail.com>
References: <20190414210933.20875-1-t.gummerer@gmail.com/>
 <20190705170630.27500-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently range-diff keeps the diff header of the inner diff
intact (apart from stripping lines starting with index).  This diff
header is somewhat useful, especially when files get different
names in different ranges.

However there is no real need to keep the whole diff header for that.
The main reason we currently do that is probably because it is easy to
do.

Introduce a new range diff hunk header, that's enclosed by "##",
similar to how line numbers in diff hunks are enclosed by "@@", and
give human readable information of what exactly happened to the file,
including the file name.

This improves the readability of the range-diff by giving more concise
information to the users.  For example if a file was renamed in one
iteration, but not in another, the diff of the headers would be quite
noisy.  However the diff of a single line is concise and should be
easier to understand.

Additionaly, this allows us to add these range diff section headers to
the outer diffs hunk headers using a custom userdiff pattern, which
should help making the range-diff more readable.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 range-diff.c           | 35 ++++++++++++----
 t/t3206-range-diff.sh  | 91 +++++++++++++++++++++++++++++++++++++++---
 t/t3206/history.export | 84 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 193 insertions(+), 17 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index b31fbab026..cc01f7f573 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -10,6 +10,7 @@
 #include "commit.h"
 #include "pretty.h"
 #include "userdiff.h"
+#include "apply.h"
 
 struct patch_util {
 	/* For the search for an exact match */
@@ -95,12 +96,36 @@ static int read_patches(const char *range, struct string_list *list)
 		}
 
 		if (starts_with(line, "diff --git")) {
+			struct patch patch;
+			struct strbuf root = STRBUF_INIT;
+			int linenr = 0;
+
 			in_header = 0;
 			strbuf_addch(&buf, '\n');
 			if (!util->diff_offset)
 				util->diff_offset = buf.len;
-			strbuf_addch(&buf, ' ');
-			strbuf_addstr(&buf, line);
+			memset(&patch, 0, sizeof(patch));
+			line[len - 1] = '\n';
+			len = parse_git_header(&root, &linenr, 1, line,
+					       len, size, &patch);
+			if (len < 0)
+				die(_("could not parse git header"));
+			strbuf_addstr(&buf, " ## ");
+			if (patch.is_new > 0)
+				strbuf_addf(&buf, "%s (new)", patch.new_name);
+			else if (patch.is_delete > 0)
+				strbuf_addf(&buf, "%s (deleted)", patch.old_name);
+			else if (patch.is_rename)
+				strbuf_addf(&buf, "%s => %s", patch.old_name, patch.new_name);
+			else
+				strbuf_addstr(&buf, patch.new_name);
+
+			if (patch.new_mode && patch.old_mode &&
+			    patch.old_mode != patch.new_mode)
+				strbuf_addf(&buf, " (mode change %06o => %06o)",
+					    patch.old_mode, patch.new_mode);
+
+			strbuf_addstr(&buf, " ##");
 		} else if (in_header) {
 			if (starts_with(line, "Author: ")) {
 				strbuf_addstr(&buf, line);
@@ -117,17 +142,13 @@ static int read_patches(const char *range, struct string_list *list)
 			if (!(p = strstr(p, "@@")))
 				die(_("invalid hunk header in inner diff"));
 			strbuf_addstr(&buf, p);
-		} else if (!line[0] || starts_with(line, "index "))
+		} else if (!line[0])
 			/*
 			 * A completely blank (not ' \n', which is context)
 			 * line is not valid in a diff.  We skip it
 			 * silently, because this neatly handles the blank
 			 * separator line between commits in git-log
 			 * output.
-			 *
-			 * We also want to ignore the diff's `index` lines
-			 * because they contain exact blob hashes in which
-			 * we are not interested.
 			 */
 			continue;
 		else if (line[0] == '>') {
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 9f89af7178..c277756057 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -181,6 +181,85 @@ test_expect_success 'changed commit with sm config' '
 	test_cmp expected actual
 '
 
+test_expect_success 'renamed file' '
+	git range-diff --no-color --submodule=log topic...renamed-file >actual &&
+	sed s/Z/\ /g >expected <<-EOF &&
+	1:  4de457d = 1:  f258d75 s/5/A/
+	2:  fccce22 ! 2:  017b62d s/4/A/
+	    @@
+	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
+	    Z
+	    -    s/4/A/
+	    +    s/4/A/ + rename file
+	    Z
+	    - ## file ##
+	    + ## file => renamed-file ##
+	    Z@@
+	    Z 1
+	    Z 2
+	3:  147e64e ! 3:  3ce7af6 s/11/B/
+	    @@
+	    Z
+	    Z    s/11/B/
+	    Z
+	    - ## file ##
+	    + ## renamed-file ##
+	    Z@@ A
+	    Z 8
+	    Z 9
+	4:  a63e992 ! 4:  1e6226b s/12/B/
+	    @@
+	    Z
+	    Z    s/12/B/
+	    Z
+	    - ## file ##
+	    + ## renamed-file ##
+	    Z@@ A
+	    Z 9
+	    Z 10
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'file added and later removed' '
+	git range-diff --no-color --submodule=log topic...added-removed >actual &&
+	sed s/Z/\ /g >expected <<-EOF &&
+	1:  4de457d = 1:  096b1ba s/5/A/
+	2:  fccce22 ! 2:  d92e698 s/4/A/
+	    @@
+	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
+	    Z
+	    -    s/4/A/
+	    +    s/4/A/ + new-file
+	    Z
+	    Z ## file ##
+	    Z@@
+	    @@
+	    Z A
+	    Z 6
+	    Z 7
+	    +
+	    + ## new-file (new) ##
+	3:  147e64e ! 3:  9a1db4d s/11/B/
+	    @@
+	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
+	    Z
+	    -    s/11/B/
+	    +    s/11/B/ + remove file
+	    Z
+	    Z ## file ##
+	    Z@@ A
+	    @@
+	    Z 12
+	    Z 13
+	    Z 14
+	    +
+	    + ## new-file (deleted) ##
+	4:  a63e992 = 4:  fea3b5c s/12/B/
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'no commits on one side' '
 	git commit --amend -m "new message" &&
 	git range-diff master HEAD@{1} HEAD
@@ -197,9 +276,9 @@ test_expect_success 'changed message' '
 	    Z
 	    +    Also a silly comment here!
 	    +
-	    Z diff --git a/file b/file
-	    Z --- a/file
-	    Z +++ b/file
+	    Z ## file ##
+	    Z@@
+	    Z 1
 	3:  147e64e = 3:  b9cb956 s/11/B/
 	4:  a63e992 = 4:  8add5f1 s/12/B/
 	EOF
@@ -216,9 +295,9 @@ test_expect_success 'dual-coloring' '
 	:     <RESET>
 	:    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<RESET>
 	:    <REVERSE><GREEN>+<RESET>
-	:      diff --git a/file b/file<RESET>
-	:      --- a/file<RESET>
-	:      +++ b/file<RESET>
+	:      ## file ##<RESET>
+	:    <CYAN> @@<RESET>
+	:      1<RESET>
 	:<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
 	:    <REVERSE><CYAN>@@<RESET>
 	:      9<RESET>
diff --git a/t/t3206/history.export b/t/t3206/history.export
index b8ffff0940..7bb3814962 100644
--- a/t/t3206/history.export
+++ b/t/t3206/history.export
@@ -22,8 +22,8 @@ data 51
 19
 20
 
-reset refs/heads/removed
-commit refs/heads/removed
+reset refs/heads/renamed-file
+commit refs/heads/renamed-file
 mark :2
 author Thomas Rast <trast@inf.ethz.ch> 1374424921 +0200
 committer Thomas Rast <trast@inf.ethz.ch> 1374484724 +0200
@@ -599,6 +599,82 @@ s/12/B/
 from :46
 M 100644 :28 file
 
-reset refs/heads/removed
-from :47
+commit refs/heads/added-removed
+mark :48
+author Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
+committer Thomas Gummerer <t.gummerer@gmail.com> 1556574151 +0100
+data 7
+s/5/A/
+from :2
+M 100644 :3 file
+
+blob
+mark :49
+data 0
+
+commit refs/heads/added-removed
+mark :50
+author Thomas Rast <trast@inf.ethz.ch> 1374485024 +0200
+committer Thomas Gummerer <t.gummerer@gmail.com> 1556574177 +0100
+data 18
+s/4/A/ + new-file
+from :48
+M 100644 :5 file
+M 100644 :49 new-file
+
+commit refs/heads/added-removed
+mark :51
+author Thomas Rast <trast@inf.ethz.ch> 1374485036 +0200
+committer Thomas Gummerer <t.gummerer@gmail.com> 1556574177 +0100
+data 22
+s/11/B/ + remove file
+from :50
+M 100644 :7 file
+D new-file
+
+commit refs/heads/added-removed
+mark :52
+author Thomas Rast <trast@inf.ethz.ch> 1374485044 +0200
+committer Thomas Gummerer <t.gummerer@gmail.com> 1556574177 +0100
+data 8
+s/12/B/
+from :51
+M 100644 :9 file
+
+commit refs/heads/renamed-file
+mark :53
+author Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
+committer Thomas Gummerer <t.gummerer@gmail.com> 1556574309 +0100
+data 7
+s/5/A/
+from :2
+M 100644 :3 file
+
+commit refs/heads/renamed-file
+mark :54
+author Thomas Rast <trast@inf.ethz.ch> 1374485024 +0200
+committer Thomas Gummerer <t.gummerer@gmail.com> 1556574312 +0100
+data 21
+s/4/A/ + rename file
+from :53
+D file
+M 100644 :5 renamed-file
+
+commit refs/heads/renamed-file
+mark :55
+author Thomas Rast <trast@inf.ethz.ch> 1374485036 +0200
+committer Thomas Gummerer <t.gummerer@gmail.com> 1556574319 +0100
+data 8
+s/11/B/
+from :54
+M 100644 :7 renamed-file
+
+commit refs/heads/renamed-file
+mark :56
+author Thomas Rast <trast@inf.ethz.ch> 1374485044 +0200
+committer Thomas Gummerer <t.gummerer@gmail.com> 1556574319 +0100
+data 8
+s/12/B/
+from :55
+M 100644 :9 renamed-file
 
-- 
2.22.0.510.g264f2c817a

