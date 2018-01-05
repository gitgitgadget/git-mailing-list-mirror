Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73AFA1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeAEU20 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:28:26 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:39112 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752627AbeAEU2X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:23 -0500
Received: by mail-io0-f193.google.com with SMTP id g70so6967730ioj.6
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+YZiH8XFId0UfueAOQbGhx+2Prpvm4J8atlj7u+c/I4=;
        b=DBCWpCWt1aBRWksoNFvtxN7jiWO0GWJofC15UP/6WPgwHISMReZkhARt8BQtJUg78e
         t3lEyv38zYvfaoYlJBYWJSz3zttuxZMw1iW0uf0Rlspy2qXVSKsVnjAPl3a/ADRRgZxJ
         1POAtJ++8keqEBblZI6dgctHHQ0d64kDQ3JWGR5GRF6pSlHRmHSaJOc4ZDVOb1NP5RcU
         qnSp/DYnvgnO47yO8p7KzAH2QsNpEYVfQ30LEx+2wZA/EVovE1nqYFy6Hzl75LGcqO7G
         NMh58sCChwI+zuvX0/zRlGFkgi25vS7SBntRgmkjoprvjSu39+nNtsT11eig8otVoA7v
         o0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+YZiH8XFId0UfueAOQbGhx+2Prpvm4J8atlj7u+c/I4=;
        b=JeNtL3Zy7M2cg9nFwys5Qov87CCgtH27BVDGd73LSieCHvSpL8jyH94Q1kDFiSZM5m
         Uuo6xzy0a2/Ph+X/qSHhsSXqRKR139iD8DrCAwhbpW1wa96frkvhUAzbOi2K9U45yyGB
         UFzUKiIinav+D3ZXYiAPmnY+2IXYkZgOz5Rxo0LIC23QeHpZnJOKVoXWZvR+piswTlT7
         uU0IqsBBVUqGFg74BOmEAo+W0EV++4SA8SnpE21uYSmC36p+xjjoOWX8NCe/Lw4n29o1
         EyN6xuKzwnRWKMVD9looi1Rf1UgXwr+KPm65LvzW8OlTllbJuB79HeTYx1QcIYOP3UGx
         qvUQ==
X-Gm-Message-State: AKGB3mL355znoo+ALb6hE1XvJhecdim9x+6HNEkw1ZdYb/ClkYv/Go4s
        vI/PoaymOSJNe0IGF0HRE+zp719m
X-Google-Smtp-Source: ACJfBou/3+R7dp5tbCWaHvpzgy1H4d93v+iJUsOobI1SNYUmLvxTsfgE8G5i6CnaCI6RYD3z447cng==
X-Received: by 10.107.7.103 with SMTP id 100mr4147649ioh.75.1515184102233;
        Fri, 05 Jan 2018 12:28:22 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:21 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 02/31] directory rename detection: directory splitting testcases
Date:   Fri,  5 Jan 2018 12:26:42 -0800
Message-Id: <20180105202711.24311-3-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 143 ++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index c68ae87f1..f36493289 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -439,4 +439,147 @@ test_expect_failure '1f-check: Split a directory into two other directories' '
 #   in section 2, plus testcases 3a and 4a.
 ###########################################################################
 
+
+###########################################################################
+# SECTION 2: Split into multiple directories, with equal number of paths
+#
+# Explore the splitting-a-directory rules a bit; what happens in the
+# edge cases?
+#
+# Note that there is a closely related case of a directory not being
+# split on either side of history, but being renamed differently on
+# each side.  See testcase 8e for that.
+###########################################################################
+
+# Testcase 2a, Directory split into two on one side, with equal numbers of paths
+#   Commit O: z/{b,c}
+#   Commit A: y/b, w/c
+#   Commit B: z/{b,c,d}
+#   Expected: y/b, w/c, z/d, with warning about z/ -> (y/ vs. w/) conflict
+test_expect_success '2a-setup: Directory split into two on one side, with equal numbers of paths' '
+	test_create_repo 2a &&
+	(
+		cd 2a &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		mkdir y &&
+		mkdir w &&
+		git mv z/b y/ &&
+		git mv z/c w/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo d >z/d &&
+		git add z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '2a-check: Directory split into two on one side, with equal numbers of paths' '
+	(
+		cd 2a &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT.*directory rename split" out &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >actual \
+			:0:y/b :0:w/c :0:z/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 2b, Directory split into two on one side, with equal numbers of paths
+#   Commit O: z/{b,c}
+#   Commit A: y/b, w/c
+#   Commit B: z/{b,c}, x/d
+#   Expected: y/b, w/c, x/d; No warning about z/ -> (y/ vs. w/) conflict
+test_expect_success '2b-setup: Directory split into two on one side, with equal numbers of paths' '
+	test_create_repo 2b &&
+	(
+		cd 2b &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		mkdir y &&
+		mkdir w &&
+		git mv z/b y/ &&
+		git mv z/c w/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir x &&
+		echo d >x/d &&
+		git add x/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '2b-check: Directory split into two on one side, with equal numbers of paths' '
+	(
+		cd 2b &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 >out &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >actual \
+			:0:y/b :0:w/c :0:x/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:x/d &&
+		test_cmp expect actual &&
+		test_i18ngrep ! "CONFLICT.*directory rename split" out
+	)
+'
+
+###########################################################################
+# Rules suggested by section 2:
+#
+#   None; the rule was already covered in section 1.  These testcases are
+#   here just to make sure the conflict resolution and necessary warning
+#   messages are handled correctly.
+###########################################################################
+
 test_done
-- 
2.14.2

