Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90AB20248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfBXKLW (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:22 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42396 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbfBXKLU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id j89so5191147edb.9
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hmWe158jp9FE67wVvBYJFEYdrHr9Pj7yRIiHYs5M3Eo=;
        b=ches+dAWis5TeNyK/O7qtMeRCEDOZVYT9HUVduz0II3I2Y8lZNVeyqVhrvXeehfpPw
         rvhrFxZJAGTMcsguBYH7M9hrGWUgIK79RGRVAENPsfVHC7DwHBYIyNJ0t8GGwhTArohg
         4nOhZJc01BC1Y+s+AsY64xycI6ETAsj+AUJcwnUzkWBMA2a0iH5MPv789qmWSK6Izu08
         WmJd5qOV85uaeXblwjt+iuTnWZT2WEXZNfM0vrdTD0YtxMhH+9zqCGDs09bMn6jetyaG
         OrDCbYFqzyPWjnjfo671zuhKfgFxLEXAAra0eCWykg4MH75I5rX8y20k0SHWcdaS4g3/
         OCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hmWe158jp9FE67wVvBYJFEYdrHr9Pj7yRIiHYs5M3Eo=;
        b=dyxFEAL1yqGpVWf4RaST/mNexIpUSBPgm0YYqDoH3v0phWGKisQLzG7Uyf/KjQSwHa
         ueVjWMct8JJpiSFBC20kHitK9cotNeUCzuQmW3+SLzfAneAcvmlF4qsxld8Mkbsp5P7H
         oDWJ7pwjCGpG5NUW/c2XT88OTRf0ZU1psK2tiCYs1Pcb3HNFyDFfjB+hr5LG22VozI6/
         3kn4XirGrMdnYOjTRMS0UvHRYoujDLXhM1sCkvlsnd28VYu5JjuMw1w55tVKzNGEskBN
         hmNnPslJVbZByGIhL9bOXq9oVdIufE2AxBHS9JaEAWIq87WKa5NOv2WBSHTR9qRjz6O0
         8Uqw==
X-Gm-Message-State: AHQUAuYCahp9z+T6JKfF0m8ncnJcxHrfzKpmlwOzs46tH+Bffhl0UR0/
        Mqji+LmkZk/QyRnSwWuVuq/6yqKl
X-Google-Smtp-Source: AHgI3IavMYIxodSjMy8Gn2wE9qD7chk6/LLw4McgUQC/vN4qJtKeOyBZugGLhsT5JZsJySc88SR0uw==
X-Received: by 2002:a17:906:7206:: with SMTP id m6mr9208756ejk.145.1551003078915;
        Sun, 24 Feb 2019 02:11:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i42sm1821362eda.86.2019.02.24.02.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:18 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:18 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:10:52 GMT
Message-Id: <b6aecadd82949a120ca880b24aab9331658f3a34.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 04/26] bisect.c: libify `exit_if_skipped_commits` to
 `error_if_skipped...`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Since we want to get rid of git-bisect.sh it would be necessary to
convert those exit() calls to return statements so that errors can be
reported.

Emulate try catch in C by converting `exit(<positive-value>)` to
`return <negetive-value>`. Follow POSIX conventions to return
<negative-value> to indicate error.
Modify `cmd_bisect_helper()` to handle these negative returns.

Turn `exit()` to `return` calls in `exit_if_skipped_commits()` and rename
the method to `error_if_skipped_commits()`.

Handle this return in dependant method `bisect_next_all()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 bisect.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/bisect.c b/bisect.c
index 487675c672..bb926f09d0 100644
--- a/bisect.c
+++ b/bisect.c
@@ -659,11 +659,11 @@ static void bisect_common(struct rev_info *revs)
 		mark_edges_uninteresting(revs, NULL);
 }
 
-static void exit_if_skipped_commits(struct commit_list *tried,
+static int error_if_skipped_commits(struct commit_list *tried,
 				    const struct object_id *bad)
 {
 	if (!tried)
-		return;
+		return 0;
 
 	printf("There are only 'skip'ped commits left to test.\n"
 	       "The first %s commit could be any of:\n", term_bad);
@@ -674,7 +674,13 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 	if (bad)
 		printf("%s\n", oid_to_hex(bad));
 	printf(_("We cannot bisect more!\n"));
-	exit(2);
+
+	/*
+	 * We don't want to clean the bisection state
+	 * as we need to get back to where we started
+	 * by using `git bisect reset`.
+	 */
+	return -2;
 }
 
 static int is_expected_rev(const struct object_id *oid)
@@ -949,7 +955,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
-	int reaches = 0, all = 0, nr, steps;
+	int reaches = 0, all = 0, nr, steps, res;
 	struct object_id *bisect_rev;
 	char *steps_msg;
 
@@ -972,8 +978,9 @@ int bisect_next_all(const char *prefix, int no_checkout)
 		 * We should exit here only if the "bad"
 		 * commit is also a "skip" commit.
 		 */
-		exit_if_skipped_commits(tried, NULL);
-
+		res = error_if_skipped_commits(tried, NULL);
+		if (res)
+			exit(-res);
 		printf(_("%s was both %s and %s\n"),
 		       oid_to_hex(current_bad_oid),
 		       term_good,
@@ -990,7 +997,9 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	bisect_rev = &revs.commits->item->object.oid;
 
 	if (oideq(bisect_rev, current_bad_oid)) {
-		exit_if_skipped_commits(tried, current_bad_oid);
+		res = error_if_skipped_commits(tried, current_bad_oid);
+		if (res)
+			exit(-res);
 		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
 			term_bad);
 		show_diff_tree(prefix, revs.commits->item);
-- 
gitgitgadget

