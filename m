Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4579C20248
	for <e@80x24.org>; Sun, 10 Mar 2019 08:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfCJIIx (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 04:08:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37435 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfCJIIx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 04:08:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id q206so1593708pgq.4
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 00:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TY9bxYLwHs3kQaqbgkibToZOxdWnO82qbZzaYM+EyRo=;
        b=nd95K1okLXDy44PK2OKqWXvTD7PMS+d0HTcJs/whE13rOeQNThkBsLfIWdFsoF6z6N
         RV+Wyfgi+NSPOHU7dYcpR1/9k7M1pBZh4+cq0NIH5hznAbEa8DE+YltnOWyzjJMdghE7
         RemTYbHtuZNZeqetlQIKQn0RZnHNrcJpLFsSVF4wkS89v/CHKo0a+eZPpNiLF2o2xnD/
         Q50LF9bR8PwG/0fZ8D0zLdE0HDSsQFR9cXDa9DYPmn6Sx4EGYCpBaC3WCy2GT6FrAVOt
         TV2ADYef5b81tbI39cSk4iG6us6HMwX83fZ/iR42Jhs/xoXMiFTfkYO1KMd8JApQRSRW
         fRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TY9bxYLwHs3kQaqbgkibToZOxdWnO82qbZzaYM+EyRo=;
        b=OVFeo3m+2j2DZRQG0fn6mKkM4Uf6YlBtW577lpl9hWUcP+Zv4Nki+AV2eSooPQUrzo
         W+Bs0ARc3ME2BTF4pQXWIYrkuDyAwSccUbcxaqedxg5G7rdhksdw732vheJUY1U8pHTE
         lOVLDdo9oxbg7W2DKce75tXro0iwzQDDUtm/4EPPt6xVSe/BgF65JhBdCNmaWd1qE1uX
         BfyLlWnd3njpRZPQV1HtVbOl7fzRm51Nmc7pyV6Z2iWvW5fdMnDDYaxLru0msMD/bwA2
         NSmDEcB4dBOwqIy3+SX5LNsNu1Aw1+unO+f1cEbRghV0dWxaxiCkoPhYW6nmHfyKjz+6
         WM1A==
X-Gm-Message-State: APjAAAVbAcRffynRyT/hyOUyJZ85wfYJXrhKSp0L2r4QuGphWGNt8igW
        NkbSpFLF0RkOObd64gUbr5XtSfsi
X-Google-Smtp-Source: APXvYqwZm37+IwDvEBbG8EDXwdMq1FpFoj5dSYlgLn/HZBgVvGItYYstE+8+Ojpfo3R4Mu4/AKHFcw==
X-Received: by 2002:a63:69c2:: with SMTP id e185mr24701203pgc.4.1552205332042;
        Sun, 10 Mar 2019 00:08:52 -0800 (PST)
Received: from localhost.localdomain (cloudream.m3.ntu.edu.tw. [140.112.244.5])
        by smtp.gmail.com with ESMTPSA id v1sm3591328pff.9.2019.03.10.00.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Mar 2019 00:08:51 -0800 (PST)
From:   Jonathan Chang <ttjtftx@gmail.com>
Cc:     Jonathan Chang <ttjtftx@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>
Subject: [GSoC][PATCH v2 2/5] t0000-basic: avoid using pipes
Date:   Sun, 10 Mar 2019 16:08:41 +0800
Message-Id: <20190310080841.64082-1-ttjtftx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190310080739.63984-1-ttjtftx@gmail.com>
References: <20190310080739.63984-1-ttjtftx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exit code of the upstream in a pipe is ignored thus we should avoid
using it. By writing out the output of the git command to a file, we can
test the exit codes of both the commands.

Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>

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

