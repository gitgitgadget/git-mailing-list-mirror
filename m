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
	by dcvr.yhbt.net (Postfix) with ESMTP id C3FA51F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfKOBBK (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:10 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:41130 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfKOBBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:01:09 -0500
Received: by mail-pf1-f180.google.com with SMTP id p26so5466909pfq.8
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uzrsn/+Efj+Ey+0jxyEWfRPrbH76H+d62MPSEsSJucs=;
        b=Hrqnq/9fAJ8NdYmewYaW6DB+9aPL6bwYj7C60gYUMygeLv5t0OQ5KLW7oVFHNC5eC5
         Fo+Dv6rOpeH6rdqLaeUgCQHiwND+0Zbr+xpcelJanWt9pgqywJCtYp9ma3572a0W7YoS
         +6szSPINY1AtEG8Kx3OmCRTZKan9rFOka4juvlk5+ok13t7ooFKXI9p3NgCtnjQ9elx7
         X2ynUanScpK1ppTAYlwCY2SwMq0KiTH4umDe2WHxizQYfVxM8f3HbAnQdBYrJrqgX0cR
         saZLbl5O9iBCZaYwcuINROWwMOBOslT6Y9dLcFhBWaljbnuy+9dLrRr8ewhADn025AQ4
         /zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uzrsn/+Efj+Ey+0jxyEWfRPrbH76H+d62MPSEsSJucs=;
        b=boMuqwC9HeIHLYyGnvHTZNE2Lusbv8uyA1nAu5/DiIUEsXNHsprOOHx4aeQT5J01Os
         n8sixyXbwP9qz72jcZUn9eLx9RYWsInWcDViTtrPX2hyJtzgqwbn9b2NzP8XL9OcDiM6
         jpwAqTWpO4Mp6F4R065knhIaMybrD43KcfxE8UsMi6jfv8IN1UKsDwY2OWTRMdYtGLb4
         cMIcQQEupXjejQz4nvYpFuwZu7YMgnKPdPLQQh4CRA+jCCQaXcNSp/EREDVT8cSt0dDT
         E7I1TKr8grplB/UQcbtQOUb02RpxecL1xUbwczzVoH8UnF8uWC/W2ZV/teF2TRqHFFYl
         S80w==
X-Gm-Message-State: APjAAAW42QJu7m5MTPWqs4dlYnZTnfmgowAPmZmZGbHrk8su8tFyBN/k
        d1r93vTQe6ijQ4/6t0IKZax81wm3
X-Google-Smtp-Source: APXvYqz5Vg5tHpxJdz4YxClksxrAFQXpB2bzue6FN55a4t0WSMz32sGpzHqH08V5fRGIuJFZ3iGcYA==
X-Received: by 2002:a65:609a:: with SMTP id t26mr13658882pgu.349.1573779668235;
        Thu, 14 Nov 2019 17:01:08 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id q18sm7406222pgv.84.2019.11.14.17.01.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:01:07 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:01:06 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 15/27] t7501: stop losing return codes of git commands
Message-ID: <f6dc7b7a97783d03900eba2e4607b2a38e963256.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a pipe, only the return code of the last command is used. Thus, all
other commands will have their return codes masked. Rewrite pipes so
that there are no git commands upstream so that we will know if a
command fails.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7501-commit-basic-functionality.sh | 69 +++++++++++++++------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 5765d33c53..110b4bf459 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -285,9 +285,8 @@ test_expect_success 'overriding author from command line' '
 '
 
 test_expect_success PERL 'interactive add' '
-	echo 7 |
-	git commit --interactive |
-	grep "What now"
+	echo 7 | test_must_fail git commit --interactive >out &&
+	grep "What now" out
 '
 
 test_expect_success PERL "commit --interactive doesn't change index if editor aborts" '
@@ -362,10 +361,10 @@ test_expect_success 'amend commit to fix author' '
 	oldtick=$GIT_AUTHOR_DATE &&
 	test_tick &&
 	git reset --hard &&
-	git cat-file -p HEAD |
+	git cat-file -p HEAD >commit &&
 	sed -e "s/author.*/author $author $oldtick/" \
-		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" > \
-		expected &&
+		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" \
+		commit >expected &&
 	git commit --amend --author="$author" &&
 	git cat-file -p HEAD >current &&
 	test_cmp expected current
@@ -377,10 +376,10 @@ test_expect_success 'amend commit to fix date' '
 	test_tick &&
 	newtick=$GIT_AUTHOR_DATE &&
 	git reset --hard &&
-	git cat-file -p HEAD |
+	git cat-file -p HEAD >commit &&
 	sed -e "s/author.*/author $author $newtick/" \
-		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" > \
-		expected &&
+		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" \
+		commit >expected &&
 	git commit --amend --date="$newtick" &&
 	git cat-file -p HEAD >current &&
 	test_cmp expected current
@@ -409,12 +408,13 @@ test_expect_success 'sign off (1)' '
 	echo 1 >positive &&
 	git add positive &&
 	git commit -s -m "thank you" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
 	(
 		echo thank you &&
 		echo &&
-		git var GIT_COMMITTER_IDENT |
-		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
+		git var GIT_COMMITTER_IDENT >ident &&
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /" ident
 	) >expected &&
 	test_cmp expected actual
 
@@ -428,13 +428,14 @@ test_expect_success 'sign off (2)' '
 	git commit -s -m "thank you
 
 $existing" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
 	(
 		echo thank you &&
 		echo &&
 		echo $existing &&
-		git var GIT_COMMITTER_IDENT |
-		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
+		git var GIT_COMMITTER_IDENT >ident &&
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /" ident
 	) >expected &&
 	test_cmp expected actual
 
@@ -448,13 +449,14 @@ test_expect_success 'signoff gap' '
 	git commit -s -m "welcome
 
 $alt" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
 	(
 		echo welcome &&
 		echo &&
 		echo $alt &&
-		git var GIT_COMMITTER_IDENT |
-		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
+		git var GIT_COMMITTER_IDENT >ident &&
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /" ident
 	) >expected &&
 	test_cmp expected actual
 '
@@ -468,15 +470,16 @@ test_expect_success 'signoff gap 2' '
 
 We have now
 $alt" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
 	(
 		echo welcome &&
 		echo &&
 		echo We have now &&
 		echo $alt &&
 		echo &&
-		git var GIT_COMMITTER_IDENT |
-		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
+		git var GIT_COMMITTER_IDENT >ident &&
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /" ident
 	) >expected &&
 	test_cmp expected actual
 '
@@ -489,7 +492,8 @@ test_expect_success 'signoff respects trailer config' '
 
 non-trailer line
 Myfooter: x" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
 	(
 		echo subject &&
 		echo &&
@@ -506,7 +510,8 @@ Myfooter: x" &&
 
 non-trailer line
 Myfooter: x" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
 	(
 		echo subject &&
 		echo &&
@@ -538,7 +543,8 @@ test_expect_success 'multiple -m' '
 	>negative &&
 	git add negative &&
 	git commit -m "one" -m "two" -m "three" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
 	(
 		echo one &&
 		echo &&
@@ -555,10 +561,10 @@ test_expect_success 'amend commit to fix author' '
 	oldtick=$GIT_AUTHOR_DATE &&
 	test_tick &&
 	git reset --hard &&
-	git cat-file -p HEAD |
+	git cat-file -p HEAD >commit &&
 	sed -e "s/author.*/author $author $oldtick/" \
-		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" > \
-		expected &&
+		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" \
+		commit >expected &&
 	git commit --amend --author="$author" &&
 	git cat-file -p HEAD >current &&
 	test_cmp expected current
@@ -570,8 +576,10 @@ test_expect_success 'git commit <file> with dirty index' '
 	echo tehlulz >chz &&
 	git add chz &&
 	git commit elif -m "tacocat is a palindrome" &&
-	git show --stat | grep elif &&
-	git diff --cached | grep chz
+	git show --stat >stat &&
+	grep elif stat &&
+	git diff --cached >diff &&
+	grep chz diff
 '
 
 test_expect_success 'same tree (single parent)' '
@@ -584,7 +592,8 @@ test_expect_success 'same tree (single parent)' '
 test_expect_success 'same tree (single parent) --allow-empty' '
 
 	git commit --allow-empty -m "forced empty" &&
-	git cat-file commit HEAD | grep forced
+	git cat-file commit HEAD >commit &&
+	grep forced commit
 
 '
 
-- 
2.24.0.399.gf8350c9437

