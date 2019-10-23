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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C2C01F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 12:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405185AbfJWMDw (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 08:03:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47069 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731954AbfJWMDw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 08:03:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id q21so1915727plr.13
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 05:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i4lYL+FdZdQg3HbyjMUx8yf919PYm5gHxe4ZudLcAm0=;
        b=COOGTVOdlvquHMTsdPXCKgPoIF9NtLi0EwmL9V00MBkTT2CRwXNy/cbccKhN36aTMv
         fwRczdgjoT9zw7/dpzARt29DSNL8FfJU5M4uIpor5uyoONS6n7EjltzVVG0SjC6Fg1xu
         0bVbh/g//XMZqOwTJ7tfAeLe7KlQ1uRrSY451oEo0WwdR7pEEQy/ve7e5aDaRZgcblcL
         rl3gd6t8zef0aB/zeWUbppOZJRRI4JMKFEpzTPkuWxjigT6/Ng1E7bXukLLrGequ4gLz
         S5ReFt+gSckg9WBBC+DBhNlm6EgPMeNbWXVjxzu1GFRIQQa0WXenqeR0lUXHA/LMDWaC
         QnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i4lYL+FdZdQg3HbyjMUx8yf919PYm5gHxe4ZudLcAm0=;
        b=CCSzHdw5JusSi4nF1dAdZ6Fks9xXaHOC7C0woGJlI45rfWaKw4CIL0tftDOXfYIvSH
         gyDY5VXvl7hLJPgyJS82PO7xc2A4YCwk9aN3J1mDkR2g/+N3TljqZDez1kr1gS2w7o2C
         ONMgv/hhPPSQlE2LPXacwNs9s036bJPz7nPI8d4z3fAugmP36Iz1+G/sgjeqBLFo8vGS
         vUyJJbXrQgpL8b7xp1rZWXzQf5ZxN3WV7uu14147L76KaX2McexTHM67rlO1cwFsMHOP
         4Tjch0TDz25UHIr2N79CVNQa870PDDbUWZxtcV9QWjnI2LxS7OcWPY0GEiXnRUy7bnZ2
         OHmA==
X-Gm-Message-State: APjAAAX+QZvX2vIc3w1xlaGlq2MJbhXEu7VdQrFBbj4NeDdR7zGhyw3Y
        k1LkbxPVw//zeZmxCaOVz6A605AO
X-Google-Smtp-Source: APXvYqyP6DWdykHqg3y1YmVMgcQ3Y24Spb3m16O4ziKpptiWo5R9c3+IJiy6g2KqbQ2584EBe8eo/g==
X-Received: by 2002:a17:902:b20a:: with SMTP id t10mr9191482plr.277.1571832230913;
        Wed, 23 Oct 2019 05:03:50 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id l72sm27837826pjb.7.2019.10.23.05.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 05:03:49 -0700 (PDT)
Date:   Wed, 23 Oct 2019 05:03:48 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] t4108: replace create_file with test_write_lines
Message-ID: <84fe1614a3c807e3604549ec012535ce6bd17228.1571832176.git.liu.denton@gmail.com>
References: <cover.1571832176.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571832176.git.liu.denton@gmail.com>
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

