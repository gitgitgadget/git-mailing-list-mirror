Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10A051F461
	for <e@80x24.org>; Mon,  8 Jul 2019 16:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733142AbfGHQiM (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 12:38:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39833 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730676AbfGHQiL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 12:38:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so17868354wrt.6
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 09:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HIiDotHve9IS3xSWO+oP+cT/BF0N0P0ryS3crNa3M7E=;
        b=ABUsP0cqAYVT+d3ODwMGXyf21mvcfB36NCICxiNzW4G/kC3AjFYfps5Ob8kMP16s0O
         ULA7UNQQalCZCHprZ3sMZuPUH80PRqYONy1vSmzO/yjq8INQz86P1G+Bfrelfszx8VBD
         KG2VVc4VfVB6RD69RGyy5QYj1YjXPodOtj/e8+6nRtGSkJk8EJqjHVKFMX3a+DqAs3xp
         pcQCtz+ioxcO+n8cJh8cflve5fqnXGTnRgk9I5o6t+mHKqMEGeVoLSmzmipOuxg/HXyN
         l1GmCVJb/xP1XalN/nzBy+OBSw3EUmprBgRFLH1IqUSrUIDSART4Jmrscmk/aA8J4VpH
         6pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HIiDotHve9IS3xSWO+oP+cT/BF0N0P0ryS3crNa3M7E=;
        b=bSmgZ5oNkQ3Uf060Xj+kl0AzsT7FCXiJFBVJCUPnjnpUG4NXWBMUzCxCp24R10wGbG
         d8SIaKXa57o639C1bWhZIf4njUOUy0qIIuc4nG5AppdajuAe5SgCpt25XkaH3X9SMD4T
         zNnXKATXL5LQnfOj2iC7DhUtTtpx94sufWFrBH9N7lynK5YYHbXiMaDPS4epFSQGJQL+
         aQCJIUATIpslRlJjzkc64hmKQatR2EeDggQKdyEVOvomvZPKKF54TG3mDLdxkvgPPeeS
         g/IWqD0yBwkBY9uszkuDE0qQSZ5P/PADlzr1otI2fw4o4do/u/55XQLsA+6ip4bOGXUU
         ucEg==
X-Gm-Message-State: APjAAAWr72aJ3pNSoTPWUn6CbsjRDtvCOZBih1K19nS46BwwVhS6mxuk
        5OZo+jSqXCRrBWzaCFU1zL9qxoNb
X-Google-Smtp-Source: APXvYqwJhr9FiErCwqIsWhFuM50NOxM1XTrmhAwYzXO0ADTlXLtOck2ZYxSBYAC5s+E5fYR8QDC6Cw==
X-Received: by 2002:adf:9c93:: with SMTP id d19mr16266768wre.317.1562603887878;
        Mon, 08 Jul 2019 09:38:07 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id d7sm14814219wrw.0.2019.07.08.09.38.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:38:07 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 12/14] range-diff: add section header instead of diff header
Date:   Mon,  8 Jul 2019 17:33:13 +0100
Message-Id: <20190708163315.29912-13-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190708163315.29912-1-t.gummerer@gmail.com>
References: <20190705170630.27500-1-t.gummerer@gmail.com>
 <20190708163315.29912-1-t.gummerer@gmail.com>
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

Additionally, this allows us to add these range diff section headers to
the outer diffs hunk headers using a custom userdiff pattern, which
should help making the range-diff more readable.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 range-diff.c           | 34 ++++++++++++----
 t/t3206-range-diff.sh  | 91 +++++++++++++++++++++++++++++++++++++++---
 t/t3206/history.export | 84 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 192 insertions(+), 17 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index f4a90b33b8..5f64380fe4 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -10,6 +10,7 @@
 #include "commit.h"
 #include "pretty.h"
 #include "userdiff.h"
+#include "apply.h"
 
 struct patch_util {
 	/* For the search for an exact match */
@@ -101,12 +102,35 @@ static int read_patches(const char *range, struct string_list *list)
 		}
 
 		if (starts_with(line, "diff --git")) {
+			struct patch patch = { 0 };
+			struct strbuf root = STRBUF_INIT;
+			int linenr = 0;
+
 			in_header = 0;
 			strbuf_addch(&buf, '\n');
 			if (!util->diff_offset)
 				util->diff_offset = buf.len;
-			strbuf_addch(&buf, ' ');
-			strbuf_addstr(&buf, line);
+			line[len - 1] = '\n';
+			len = parse_git_diff_header(&root, &linenr, 1, line,
+						    len, size, &patch);
+			if (len < 0)
+				die(_("could not parse git header '%.*s'"), (int)len, line);
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
@@ -122,17 +146,13 @@ static int read_patches(const char *range, struct string_list *list)
 		} else if (skip_prefix(line, "@@ ", &p)) {
 			p = strstr(p, "@@");
 			strbuf_addstr(&buf, p ? p : "@@");
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

