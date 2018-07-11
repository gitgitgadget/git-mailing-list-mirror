Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 831D01F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 03:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbeGKD7Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 23:59:25 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:47095 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732394AbeGKD7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 23:59:25 -0400
Received: by mail-yb0-f195.google.com with SMTP id s14-v6so9495500ybp.13
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 20:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E9elZoDof4jOaMwO7Y5LZGbC8wRPCZhM6aQ20bCs8cE=;
        b=V3B4ppV6nPI4hOBbwdP52zAzLJ4QO5FVtDJZY7YDIuCVj47LN4wMZDJ4GKDFDTK5T3
         mGykWkGXtOrzjT2tbzxbrGqWN7GCTSMCDw+BRVm9i5xOhFIfgoi4BbMJOvZVWVfEvbaB
         PLJ+7cCpZUtmaek52sb4SvYX1kD0X1fjhoEDjkoyNH1bGNYkAJwYbnBhvfgadhG4w5lG
         Lg0C9IYM59Ue9mqZ/EzTCLiy4EPLAdjDj/5SCzp9o3ewkT9RrAY8ax9CydPIEOXDehci
         xGmB/rXAte1a553EqasD1gYL0crsn6U1KU+StGqmllHXbUk3GLJPgctbXd1PQ8p/aCXW
         2avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E9elZoDof4jOaMwO7Y5LZGbC8wRPCZhM6aQ20bCs8cE=;
        b=g02CyBKlgmOoRR1W2obd6Fmimg8fCBVPTDbM30Ioz/r7cXUwCvIemHX1G7JbQkHfjv
         dur4dL8LfK6893aKBQYPl0dAk8kxprem+RDbNbIKr2aO5qfU7m914dUsR2i7ZBm7Zf8n
         TlX6mfM+f7QI62Wn+Hh9quN/otxj/k75sW1GN+slH+B2cOA9lbK29ZLSNsqW45v3myp1
         z2V2fOSShwhC10ALeXxk6Zi81XZEhDU9li/ZyL7oQ8wB7VQEeV73NN5f/MapnxAf265b
         NdI52dYNRkW4BZp1FRTUVUQM/nmga4NKEh6/Xiir9xN4v4k/gWVXcIs8tfXww8LKzHdt
         GB+w==
X-Gm-Message-State: APt69E2bD/ukSmg6Dwl/qEaSHnZC7N1iCqMoKVsrGbUggW+ZAnAoU1FM
        U8gGfO+zRAOShihxXz3xu1k=
X-Google-Smtp-Source: AAOMgpeSG1O4n+9aK/XfUpYJU088wz9Zh7uvN4TMnmmNUpvpiGge6UjwzsVyETJEJ+9pQ90Wq1xmFg==
X-Received: by 2002:a25:49c4:: with SMTP id w187-v6mr14509256yba.274.1531281429013;
        Tue, 10 Jul 2018 20:57:09 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id a62-v6sm1938699ywf.79.2018.07.10.20.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 20:57:08 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 2/3] t7405: add a directory/submodule conflict
Date:   Tue, 10 Jul 2018 20:56:58 -0700
Message-Id: <20180711035659.27352-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.132.g6e63b23f4
In-Reply-To: <20180711035659.27352-1-newren@gmail.com>
References: <20180707204404.7208-1-newren@gmail.com>
 <20180711035659.27352-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For a directory/submodule conflict, we want contents from both the
directory and the submodule to be present for the user to use to resolve
the conflict, but we do not want paths under the directory being written
into the submodule and we do not want the merge being confused by paths
under the submodule being in the way.  Add testcases for these situations.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7405-submodule-merge.sh | 88 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 62888c2c5..45d1779d2 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -333,4 +333,92 @@ test_expect_failure 'file/submodule conflict' '
 	)
 '
 
+# Directory/submodule conflict
+#   Commit O: <empty>
+#   Commit A: path (submodule), with sole tracked file named 'world'
+#   Commit B1: path/file
+#   Commit B2: path/world
+#
+#   Expected from merge of A & B1:
+#     Contents under path/ from commit B1 are renamed elsewhere; we do not
+#     want to write files from one of our tracked directories into a submodule
+#
+#   Expected from merge of A & B2:
+#     Similar to last merge, but with a slight twist: we don't want paths
+#     under the submodule to be treated as untracked or in the way.
+
+test_expect_success 'setup directory/submodule conflict' '
+	test_create_repo directory-submodule &&
+	(
+		cd directory-submodule &&
+
+		git commit --allow-empty -m O &&
+
+		git branch A &&
+		git branch B1 &&
+		git branch B2 &&
+
+		git checkout B1 &&
+		mkdir path &&
+		echo contents >path/file &&
+		git add path/file &&
+		git commit -m B1 &&
+
+		git checkout B2 &&
+		mkdir path &&
+		echo contents >path/world &&
+		git add path/world &&
+		git commit -m B2 &&
+
+		git checkout A &&
+		test_create_repo path &&
+		test_commit -C path hello world &&
+		git submodule add ./path &&
+		git commit -m A
+	)
+'
+
+test_expect_failure 'directory/submodule conflict; keep submodule clean' '
+	test_when_finished "git -C directory-submodule reset --hard" &&
+	(
+		cd directory-submodule &&
+
+		git checkout A^0 &&
+		test_must_fail git merge B1^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 1 out &&
+
+		# path/ is still a submodule
+		test_path_is_dir path/.git &&
+
+		echo Checking if contents from B1:path/file showed up &&
+		# Would rather use grep -r, but that is GNU extension...
+		git ls-files -co | xargs grep -q contents 2>/dev/null &&
+
+		# However, B1:path/file should NOT have shown up at path/file,
+		# because we should not write into the submodule
+		test_path_is_missing path/file
+	)
+'
+
+test_expect_failure 'directory/submodule conflict; should not treat submodule files as untracked or in the way' '
+	test_when_finished "git -C directory-submodule/path reset --hard" &&
+	test_when_finished "git -C directory-submodule reset --hard" &&
+	(
+		cd directory-submodule &&
+
+		git checkout A^0 &&
+		test_must_fail git merge B2^0 >out 2>err &&
+
+		# We do not want files within the submodule to prevent the
+		# merge from starting; we should not be writing to such paths
+		# anyway.
+		test_i18ngrep ! "refusing to lose untracked file at" err
+
+	)
+'
+
 test_done
-- 
2.18.0.132.g6e63b23f4

