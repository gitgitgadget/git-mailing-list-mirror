Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA01220248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfBXKL2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:28 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:46352 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfBXKLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:25 -0500
Received: by mail-ed1-f54.google.com with SMTP id f2so5181045edy.13
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ln1vhX2iRHfPcImzdK9B6NdovHLxlKgMq0rWgJ0mJFs=;
        b=HKvL8tCd/BbMU0iEoIwQBzUsoSI5ySwMvONE/r2aFqFijCSQ/We7UipgtGz9nkLgVD
         nWGPgyhh0CJcgapNkx1etKa0WpkpvciiZqweFPL5NY3kXxPhBnBREu5Dsb3vmZUJJq8G
         nz9BjzsTk8+amtskF+09B8I/LDJE9fsfLE+CoOuk8ZDzehvSsm7uQNx0cVB7D/DHuADr
         Vm3FOhNPyK2Gyyvy8xi6SXdU64nBZpgNBXwMKU5p9BU5qk4wSaVvHOCS4JUjzwtV/PC+
         ASwms8QHV/wj3RTkYMXxAojXmQl4cMXsEn430FUEq55qQwAILmwwvljUUZW4qxKozFRn
         7foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ln1vhX2iRHfPcImzdK9B6NdovHLxlKgMq0rWgJ0mJFs=;
        b=W6+5nQYeX2sltd5/2wCAts0JifimRR/lADLTjaUt9cC0OwoTfxmpffdJo4S97ct7cW
         eBdzB/ckwNNvXy34vvo5MufWgBknUaTFwHictSAQlUcX41n8nAWj1H0YpE/PBHBOcTKM
         BZHmewVZDCgbGNVGnE8Z4a4BdddxMPvMrOLClrcuYYzEPbinrYSYzYHKLUB5w6ShSf4Z
         v7vyffmMyXJI1DwYFrHb+B0ldnNoNYM96hBccK7MitB/hZ4IXX9hPy+tlQMxVRy8CkPk
         RNLqcQFF66PxpvCdSao8J3kuey7UmHeRXidtmGzLfssZD4XrS0WZ50E4zXG0H+eqO3yS
         TQPw==
X-Gm-Message-State: AHQUAuZ5NliJ+XFMJJ6FJn9LAGYPpvGVoCrGBbMVVwr0XoOvNsv2u1wY
        S+4N6XrjE8FAI4G1o4O14dik4wBK
X-Google-Smtp-Source: AHgI3IaPF06c5ICGtbr4pPcpPGiTaZPLFzpKlfcRaQUppRX9vAUmvzfrRhIo9okTgxUAtlhdwer5uw==
X-Received: by 2002:a50:9156:: with SMTP id f22mr10574771eda.172.1551003082814;
        Sun, 24 Feb 2019 02:11:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm1182862ejl.49.2019.02.24.02.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:22 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:22 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:10:57 GMT
Message-Id: <152b7c1229616780e91e1191432a05d44b84be35.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 09/26] bisect.c: libify `bisect_next_all` and its dependants
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

Turn `exit()` to `return` calls in `bisect_next_all()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 bisect.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/bisect.c b/bisect.c
index b1ea658a75..3d11a8eac7 100644
--- a/bisect.c
+++ b/bisect.c
@@ -964,10 +964,12 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
 }
 
 /*
- * We use the convention that exiting with an exit code 10 means that
- * the bisection process finished successfully.
- * In this case the calling shell script should exit 0.
- *
+ * We use the convention that return -10 means the bisection process
+ * finished successfully.
+ * In this case the calling function or command should not turn a -10 
+ * return code into an error or a non zero exit code.
+ * This returned -10 is converted to 10 at the end of cmd_bisect__helper().
+ * 
  * If no_checkout is non-zero, the bisection process does not
  * checkout the trial commit but instead simply updates BISECT_HEAD.
  */
@@ -997,23 +999,35 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	if (!revs.commits) {
 		/*
-		 * We should exit here only if the "bad"
+		 * We should return error here only if the "bad"
 		 * commit is also a "skip" commit.
 		 */
 		res = error_if_skipped_commits(tried, NULL);
 		if (res)
-			exit(-res);
+			return res;
 		printf(_("%s was both %s and %s\n"),
 		       oid_to_hex(current_bad_oid),
 		       term_good,
 		       term_bad);
-		exit(1);
+
+		/*
+		 * We don't want to clean the bisection state
+		 * as we need to get back to where we started
+		 * by using `git bisect reset`.
+		 */
+		return -1;
 	}
 
 	if (!all) {
 		fprintf(stderr, _("No testable commit found.\n"
 			"Maybe you started with bad path parameters?\n"));
-		exit(4);
+
+		/*
+		 * We don't want to clean the bisection state
+		 * as we need to get back to where we started
+		 * by using `git bisect reset`.
+		 */
+		return -4;
 	}
 
 	bisect_rev = &revs.commits->item->object.oid;
@@ -1021,12 +1035,17 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	if (oideq(bisect_rev, current_bad_oid)) {
 		res = error_if_skipped_commits(tried, current_bad_oid);
 		if (res)
-			exit(-res);
+			return res;
 		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
 			term_bad);
 		show_diff_tree(prefix, revs.commits->item);
-		/* This means the bisection process succeeded. */
-		exit(10);
+		/* 
+		 * This means the bisection process succeeded.
+		 * Using -10 so that the call chain can simply check 
+		 * for negative return values for early returns up 
+		 * until the cmd_bisect__helper() caller.
+		 */
+		return -10;
 	}
 
 	nr = all - reaches - 1;
-- 
gitgitgadget

