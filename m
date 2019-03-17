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
	by dcvr.yhbt.net (Postfix) with ESMTP id 61E1E20248
	for <e@80x24.org>; Sun, 17 Mar 2019 15:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfCQPYY (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 11:24:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46287 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfCQPYY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 11:24:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id a22so9603133pgg.13
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FbSfoIbbRzolUEZKlMwkcWYPGUKxE8StdvFF9CBHr4I=;
        b=pGjQP/0v7mw9gR4xr6LkFEcofET2v9zpQriY2Rmmq4Jah8iMBEAGc5T2+pZaA2wQ/B
         KjXgmXvPUMgAWcAUSo1ITemP2l5b7XQri9icA9+WXOcS0zXgkGRuKT/sw3lTmz5bqmE9
         +Suw71/030pSw6T/ib4Nu6etqfxAKvXHrivdItoTajb9QjnB3wtd5rfqkrI4OcxNLRZg
         YXvdAiuoYZQlPbz97F47TiPT2LChHnIFh3rABhs22IaW395k3gGYKKG4zSb3aLVuzXAj
         /VXjSqqjo4U2GRbVJZxXPAyv4azBftNtxxl4azQPLHFjqzp8AiJKQGaMBghw20aNGn2S
         wJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FbSfoIbbRzolUEZKlMwkcWYPGUKxE8StdvFF9CBHr4I=;
        b=IlT5klaRklfjqHuLDE1JxL6771mAJOdpXnuLumx0SWTOYKGhVPfRhRGroBEc8xeYBQ
         i41+feTHGo9USxFzUpLahhVcvI1aTsOzvsDDlcwGdFUMvGKYAi73ZEPKnZ6sjT8Bwb2q
         FCRV/uDKsq9ahQ13EZSRJ3FUV3Cqt5piuhLtD5/LI3W4k/+xgyqfWC/1c8ifP+hRHRCS
         wO/0DsPhaiRMThgts4bGmbaFmoiJ5Ozyxv0892im5KA9XTutEQ63/CQ7AqV8Ci3OzfKn
         XimR/ScxtwsA/YnmxPvUGh/hDLcLGGI0a8F1U8doZ2tTliKxtVeAAs1kBtoWWAhi9L6j
         a/Nw==
X-Gm-Message-State: APjAAAWZq/K+mhPjHH6p8SnzR4Li3uRfjpQSr/LdfCHOnTa/tNRBIH+H
        T/LmpgIKa0VhoEzS221xdUAZK4Hg
X-Google-Smtp-Source: APXvYqz+9DC9iWmclnZeJoR0u2KHmbQVcLstXJrXheBkWS/ce9potNMvwVWJv0sVIHkracfgzp0t8w==
X-Received: by 2002:a17:902:848b:: with SMTP id c11mr14422925plo.279.1552836262993;
        Sun, 17 Mar 2019 08:24:22 -0700 (PDT)
Received: from localhost.localdomain (cloudream.m3.ntu.edu.tw. [140.112.244.5])
        by smtp.gmail.com with ESMTPSA id z15sm10357978pgc.25.2019.03.17.08.24.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Mar 2019 08:24:22 -0700 (PDT)
From:   Jonathan Chang <ttjtftx@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jonathan Chang <ttjtftx@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [GSoC][PATCH v3 2/3] t0000: avoid using pipes
Date:   Sun, 17 Mar 2019 23:23:37 +0800
Message-Id: <5a3c6e24eb901c830e8e43608d81aef5d7b60315.1552835153.git.ttjtftx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1552835153.git.ttjtftx@gmail.com>
References: <cover.1552835153.git.ttjtftx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exit code of the upstream in a pipe is ignored thus we should avoid
using it. By writing out the output of the git command to a file, we can
test the exit codes of both the commands.

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

