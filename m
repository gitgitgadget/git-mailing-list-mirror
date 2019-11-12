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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9343A1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 23:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfKLXII (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 18:08:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42651 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfKLXIG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 18:08:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id q17so12843771pgt.9
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 15:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CyvsfEK2N89Wdpqpa10i2EKsrf8kZgF2OAWRpV87lB8=;
        b=hIrdqyvuyV2G9GEUqq0EZ6tZfZQE3YUuQby9T2eOZwxStauw7TreDdL3aGrhznBFEd
         gfmcntMPKvTpLFfIWPQ96EweO3gEODE/1SW3HDBK+NQghtVvU9aVkmm2Onpbcl16YRSY
         rxC/gFfzIzP2Fniov17pevKC5r3gsurXMXnuizo04Ddi85vShKQtGNig5xkC6tr2RH3B
         E8XVLWUQTvsapIfJFj6zm6px90i5AHGl3b3LmP1CiS/25r/0KUjnlAjv2nrqRFUqdloT
         v2DtdckUuWrauQTxhbOykxrjDRb8ZnpDAjL/pZVa6e8z6lpyt/7t5euonxIl5Qm1TCnL
         Skgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CyvsfEK2N89Wdpqpa10i2EKsrf8kZgF2OAWRpV87lB8=;
        b=CYr9f+UW6G6jbfMatUG/SHlwMdOujmOm5gUOtPUOHuCXjxQsS5sJV30RKeYmgtJ6D0
         eDocdD6cR4Ku7AnSVbPOiu1c/g/aO7XO1QHgVoAbnRjIp8/UwOYTG5Vzo3XdYT9/Ktly
         dNgggN8NjiizBIhKd22VZVZpLAGSlGS3EuG1eFX4WyBAcmxB1E66xkZxFnT5B+JlD1+m
         qZvu6w5402QMueO4iiVaO2h5+m1BSwhnFHqljr7c0tNqyxxMgyv+Qa0kxLROyVs3UOr7
         1cWbMf4xQM68Q5tO87+tSEHCkX/HdFO60D26aRzZgw4/1wJYkaTora+6Jdm+6ggS/Ib2
         mz0g==
X-Gm-Message-State: APjAAAVUWhhZrr2ZJWHF3owNR1EZF3/go/RPkwIyvX6KRQ/e0upcIL6p
        zv62/ycIaqAN9/skeAAjizwnYDpK
X-Google-Smtp-Source: APXvYqzlFhwIgV4hRp5PaYkReZMRbSxXKI3RnkjGLunPlco9WH4c1SOEWsVAHVIv9ac4fdRBL4RXxg==
X-Received: by 2002:a63:e90f:: with SMTP id i15mr21436pgh.9.1573600084917;
        Tue, 12 Nov 2019 15:08:04 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id j10sm24791pfn.128.2019.11.12.15.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:08:04 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:08:02 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 08/14] t5520: replace test -{n,z} with test-lib functions
Message-ID: <8043b230a727b253dbc14e2b9eb5c79d056da673.1573595985.git.liu.denton@gmail.com>
References: <cover.1573517561.git.liu.denton@gmail.com>
 <cover.1573595985.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573595985.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When wrapping a git command in a command substitution within another
command, we throw away the git command's exit code. In case the git
command fails, we would like to know about it rather than the failure
being silent. Extract git commands so that their exit codes are not
lost.

Instead of using `test -n` or `test -z`, replace them respectively with
invocations of test_file_not_empty() and test_must_be_empty() so that we
get better debugging information in the case of a failure.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 0ca4867e96..18225d8430 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -206,15 +206,18 @@ test_expect_success 'fail if the index has unresolved entries' '
 	test_when_finished "git checkout -f copy && git branch -D third" &&
 	test "$(cat file)" = file &&
 	test_commit modified2 file &&
-	test -z "$(git ls-files -u)" &&
+	git ls-files -u >unmerged &&
+	test_must_be_empty unmerged &&
 	test_must_fail git pull . second &&
-	test -n "$(git ls-files -u)" &&
+	git ls-files -u >unmerged &&
+	test_file_not_empty unmerged &&
 	cp file expected &&
 	test_must_fail git pull . second 2>err &&
 	test_i18ngrep "Pulling is not possible because you have unmerged files." err &&
 	test_cmp expected file &&
 	git add file &&
-	test -z "$(git ls-files -u)" &&
+	git ls-files -u >unmerged &&
+	test_must_be_empty unmerged &&
 	test_must_fail git pull . second 2>err &&
 	test_i18ngrep "You have not concluded your merge" err &&
 	test_cmp expected file
@@ -667,7 +670,8 @@ test_expect_success 'git pull --rebase detects upstreamed changes' '
 	(
 		cd dst &&
 		git pull --rebase &&
-		test -z "$(git ls-files -u)"
+		git ls-files -u >untracked &&
+		test_must_be_empty untracked
 	)
 '
 
-- 
2.24.0.346.gee0de6d492

