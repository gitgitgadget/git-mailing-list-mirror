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
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3BC1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 23:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408042AbfJWXcc (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 19:32:32 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:43882 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408036AbfJWXcc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 19:32:32 -0400
Received: by mail-pg1-f170.google.com with SMTP id l24so8110483pgh.10
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 16:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i4lYL+FdZdQg3HbyjMUx8yf919PYm5gHxe4ZudLcAm0=;
        b=rTfK4jj/xWklZ0YDDLBip0gS5hZL2rCkcDSruob3NAf9oz0A4eJ7JYgELYf49XC5j0
         /FKTpo4sH7qGpbVIBk8KP5gFGTs1XROXLF4vhUjzvGV7JUp6Ncc25zIbeFJZAgtPZb7R
         xJJ2ULJ9gxez+lfOP410p0IoRNuimZNvkDWJ7N9LjwvoPioaJWUaHyHEjpmy3QEUKlQA
         gIGhJdfcs+sMWb5NTspMnSaEEyW2TJ2823I8BZw93mv+f2lrElH4rPVHaTVLW0WGiLwL
         zfdXvjZ2+qkMLu1qcVcH0hyVbxyS731m9lktaqwBMK+zn9og4TQazBdLUTonuAcHKMzj
         +9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i4lYL+FdZdQg3HbyjMUx8yf919PYm5gHxe4ZudLcAm0=;
        b=dfmNCLpT+zKEe7F0Ac2GMMHajUSSwsps0nA2/nJ2dYNGMz4o0NzQ6eaMRdvmtaGooM
         TOsptLl+VuVNFvJwUkTRdF4DuidtHv4EREhMwxhSOqutf5sM8Og4/GBHrF2TZr8UeXin
         oXrQ1CWkg53f2RtZL7N4RhU2PynI9PSq4nNx2EIOUsrRmoTbk2YeSVDerW4JLxTbab8u
         SzVEelsFOQb54KE82L1ECoCse0WVyeUvd/WO3125OuT4quo/OTcOrLNvf/xGZmRipUh3
         ufBR4XDj+GsXfe8ULvRrpdEAqU4A3mzFoF0VbdVfplrtmiDpJXPWyUBzBI4WIpbl809N
         yENA==
X-Gm-Message-State: APjAAAUczz6VtmzxGXNmCTNokTrZ5flXyBBSN6DuhDs7wSFB7JqPX7JY
        hIIGViY2RT8IAOf30dcPsI66F4VR
X-Google-Smtp-Source: APXvYqyCGU4BjDi2w6Vg82LXccrL1RbJbyWo7I9rwqH1Ftdch/Tn9HQJ3Lo1F+XdectpKSS5+faCoA==
X-Received: by 2002:a17:90a:1b45:: with SMTP id q63mr3207626pjq.106.1571873551004;
        Wed, 23 Oct 2019 16:32:31 -0700 (PDT)
Received: from generichostname ([204.14.239.55])
        by smtp.gmail.com with ESMTPSA id l23sm355993pjy.12.2019.10.23.16.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:32:30 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:32:28 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/5] t4108: replace create_file with test_write_lines
Message-ID: <84fe1614a3c807e3604549ec012535ce6bd17228.1571873435.git.liu.denton@gmail.com>
References: <cover.1571832176.git.liu.denton@gmail.com>
 <cover.1571873435.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571873435.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the locally defined create_file() duplicates the functionality of
the test_write_lines() helper function, remove create_file() and replace
all instances with test_write_lines(). While we're at it, move
redirection operators to the end of the command which is the more
conventional place to put it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4108-apply-threeway.sh | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index fa5d4efb89..b109ecbd9f 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -4,13 +4,6 @@ test_description='git apply --3way'
 
 . ./test-lib.sh
 
-create_file () {
-	for i
-	do
-		echo "$i"
-	done
-}
-
 sanitize_conflicted_diff () {
 	sed -e '
 		/^index /d
@@ -20,7 +13,7 @@ sanitize_conflicted_diff () {
 
 test_expect_success setup '
 	test_tick &&
-	create_file >one 1 2 3 4 5 6 7 &&
+	test_write_lines 1 2 3 4 5 6 7 >one &&
 	cat one >two &&
 	git add one two &&
 	git commit -m initial &&
@@ -28,13 +21,13 @@ test_expect_success setup '
 	git branch side &&
 
 	test_tick &&
-	create_file >one 1 two 3 4 5 six 7 &&
-	create_file >two 1 two 3 4 5 6 7 &&
+	test_write_lines 1 two 3 4 5 six 7 >one &&
+	test_write_lines 1 two 3 4 5 6 7 >two &&
 	git commit -a -m master &&
 
 	git checkout side &&
-	create_file >one 1 2 3 4 five 6 7 &&
-	create_file >two 1 2 3 4 five 6 7 &&
+	test_write_lines 1 2 3 4 five 6 7 >one &&
+	test_write_lines 1 2 3 4 five 6 7 >two &&
 	git commit -a -m side &&
 
 	git checkout master
@@ -87,7 +80,7 @@ test_expect_success 'apply with --3way with rerere enabled' '
 	test_must_fail git merge --no-commit side &&
 
 	# Manually resolve and record the resolution
-	create_file 1 two 3 4 five six 7 >one &&
+	test_write_lines 1 two 3 4 five six 7 >one &&
 	git rerere &&
 	cat one >expect &&
 
@@ -104,14 +97,14 @@ test_expect_success 'apply -3 with add/add conflict setup' '
 	git reset --hard &&
 
 	git checkout -b adder &&
-	create_file 1 2 3 4 5 6 7 >three &&
-	create_file 1 2 3 4 5 6 7 >four &&
+	test_write_lines 1 2 3 4 5 6 7 >three &&
+	test_write_lines 1 2 3 4 5 6 7 >four &&
 	git add three four &&
 	git commit -m "add three and four" &&
 
 	git checkout -b another adder^ &&
-	create_file 1 2 3 4 5 6 7 >three &&
-	create_file 1 2 3 four 5 6 7 >four &&
+	test_write_lines 1 2 3 4 5 6 7 >three &&
+	test_write_lines 1 2 3 four 5 6 7 >four &&
 	git add three four &&
 	git commit -m "add three and four" &&
 
-- 
2.24.0.rc0.197.g0926ab8072

