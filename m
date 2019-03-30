Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63D8A20248
	for <e@80x24.org>; Sat, 30 Mar 2019 14:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbfC3O2Q (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 10:28:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38359 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbfC3O2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 10:28:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so2569530pgl.5
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 07:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ua7GU9e+lcPXFSlkukWUOKdfxnwfISLn4oQsyLldfa8=;
        b=lUxKlzzkU9yg363tEJKyr0vGmo3VcmCKZRHbK4OtrLAFTlr0lE/4NmUgGAF35v4i25
         Wg2iYdLYuyz8T0vTb0IBQU1esA0QX/pq3ByMdjY+DmNVVNn3jFyhqh4vDciwFsKYGKdR
         osw4Q+y58RivTeA7AQWCgk5mwc9ZgdRas6lLN2FEKS4Bs185Mnc93EjEjrt+xh6dOh05
         +alGSy+t8LalUF1YEoBrw+8w9IGJmmZwZoT9/ZtxG2em2fKcpQ9vnOUlvwq2e/skxVM9
         BSsSvUbZzUGworfcu0orN46JVRY2tlXCBUMoc/w1YwJd0VgCi8Sy/jf5Pg5u/t6k8vN5
         jevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ua7GU9e+lcPXFSlkukWUOKdfxnwfISLn4oQsyLldfa8=;
        b=HLnZWkmMDBYcbDd+HgiG0G/UlvPGpRkC7vYVRZjSfZ56Qi03KdsXsnq0CtTY0uMbFo
         m0o0ZHDufUgDoTHNSq/0qF1a4uxX4vXqu3Mw27L4u0MVufYaoY5kh+wOrM2HHBPRFegG
         d0RcNhCOmuoI8qHbipUC5Va411M74cDt4DgvJUXQEUPxayiv86O8KqIok7krrnRK9UWy
         G6HhvFAfWf5GLU4FMa9e1kdHOsGyhRN3D7ZNOA6uvdM0KqvdekDOPjIcIF1Nm22/CIqh
         4ie/kglQUl+Gw349voIPK+sqXU3HtrAynoUDV317TPoHCEm9aj2O4s+eK43cqLV1vpb4
         3GUg==
X-Gm-Message-State: APjAAAUXf9ZREt7OvRcqZlEywkzJlDm+KFRX0Y07ycReHVlXUTPExb3c
        Lm+1US4I2UYRQP6zSSKU1VbiD+fBX+k=
X-Google-Smtp-Source: APXvYqwA01E4e68EpKkwylZXX8ajnpL3xZy/EYMcJRg+iQMKHDs5/f9MelfQ9hXLLptjOh8K8uzRrQ==
X-Received: by 2002:aa7:83ca:: with SMTP id j10mr52541433pfn.50.1553956095278;
        Sat, 30 Mar 2019 07:28:15 -0700 (PDT)
Received: from localhost.localdomain (cloudream.m3.ntu.edu.tw. [140.112.244.5])
        by smtp.gmail.com with ESMTPSA id v12sm6621737pfe.148.2019.03.30.07.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Mar 2019 07:28:14 -0700 (PDT)
From:   Jonathan Chang <ttjtftx@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jonathan Chang <ttjtftx@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [GSoC][PATCH v4 2/5] t0000: avoid using pipes
Date:   Sat, 30 Mar 2019 22:27:55 +0800
Message-Id: <1ca1168f91daaef5936c97179715ca8e8d4fb6ef.1553954776.git.ttjtftx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553954776.git.ttjtftx@gmail.com>
References: <cover.1553954776.git.ttjtftx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exit code of the upstream in a pipe is ignored thus we should avoid
using it. By writing out the output of the git command to a file, we can
test the exit codes of both the commands.

This commit doesn't make any additional simplifications, such as using
the test_line_count function for counting the lines in the output. These
simplifications will be made in subsequent commits.

Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
---
 t/t0000-basic.sh | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 53821f5817..47666b013e 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1118,27 +1118,25 @@ P=$(test_oid root)
 
 test_expect_success 'git commit-tree records the correct tree in a commit' '
 	commit0=$(echo NO | git commit-tree $P) &&
-	tree=$(git show --pretty=raw $commit0 |
-		 sed -n -e "s/^tree //p" -e "/^author /q") &&
+	git show --pretty=raw $commit0 >actual &&
+	tree=$(sed -n -e "s/^tree //p" -e "/^author /q" actual) &&
 	test "z$tree" = "z$P"
 '
 
 test_expect_success 'git commit-tree records the correct parent in a commit' '
 	commit1=$(echo NO | git commit-tree $P -p $commit0) &&
-	parent=$(git show --pretty=raw $commit1 |
-		sed -n -e "s/^parent //p" -e "/^author /q") &&
+	git show --pretty=raw $commit1 >actual &&
+	parent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual) &&
 	test "z$commit0" = "z$parent"
 '
 
 test_expect_success 'git commit-tree omits duplicated parent in a commit' '
 	commit2=$(echo NO | git commit-tree $P -p $commit0 -p $commit0) &&
-	parent=$(git show --pretty=raw $commit2 |
-		sed -n -e "s/^parent //p" -e "/^author /q" |
-		sort -u) &&
+	git show --pretty=raw $commit2 >actual &&
+	parent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | sort -u) &&
 	test "z$commit0" = "z$parent" &&
-	numparent=$(git show --pretty=raw $commit2 |
-		sed -n -e "s/^parent //p" -e "/^author /q" |
-		wc -l) &&
+	git show --pretty=raw $commit2 >actual &&
+	numparent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | wc -l) &&
 	test $numparent = 1
 '
 
@@ -1147,7 +1145,8 @@ test_expect_success 'update-index D/F conflict' '
 	mv path2 path0 &&
 	mv tmp path2 &&
 	git update-index --add --replace path2 path0/file2 &&
-	numpath0=$(git ls-files path0 | wc -l) &&
+	git ls-files path0 >actual &&
+	numpath0=$(wc -l <actual) &&
 	test $numpath0 = 1
 '
 
@@ -1162,12 +1161,13 @@ test_expect_success 'very long name in the index handled sanely' '
 	>path4 &&
 	git update-index --add path4 &&
 	(
-		git ls-files -s path4 |
-		sed -e "s/	.*/	/" |
+		git ls-files -s path4 >actual &&
+		sed -e "s/	.*/	/" actual |
 		tr -d "\012" &&
 		echo "$a"
 	) | git update-index --index-info &&
-	len=$(git ls-files "a*" | wc -c) &&
+	git ls-files "a*" >actual &&
+	len=$(wc -c <actual) &&
 	test $len = 4098
 '
 
-- 
2.21.0

