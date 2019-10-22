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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AAAE1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 10:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbfJVKUR (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 06:20:17 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:44948 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKUR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 06:20:17 -0400
Received: by mail-pl1-f175.google.com with SMTP id q15so8121516pll.11
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EigJeBJ0j0HcdKPYpu5EWH8ZxNvB/S22prLxKC5I0Uc=;
        b=lN0J3d0rWSqfQrVC8wvK5G/hq4hP4frOqwVl35ksTfmi8po0l6loEVfCqIAINMe2Dl
         jG3LhgLgzZ527ByqTZ3FMoB+Hxa4uwK+fO7pWRmE8vE6q4fkzWSe2sCkHWwj09L2YoxG
         KQKoshLSg1R6+Hepifrmj6Chu34Iq4JvE15tZqKSKs1zao1YFa1s08IjRG9eMR7SUOC9
         QbYcRfBk4gzJii7NrlK0r3TG8HyPMH7WmrIk2p7Xkf8w5nwwKRCCL19yCAEX3TpGM7gt
         xtQu00emM9x+weAulHDJxVrRGdWflcuFNBuAvVgD5poENmTWaw9G/lrQSBnmyETWKaxT
         Q1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EigJeBJ0j0HcdKPYpu5EWH8ZxNvB/S22prLxKC5I0Uc=;
        b=LdoqCHDyfd0bpAQk6kI1JgDtBLgEI80TbR3z6C66M2T9JufNA8wGMRhBZgsxbKMJsM
         hDfoEX+QzIT2SuDAgsX/Shmsnaza8SFBx214+xdF24YfkcpUidS4z95WnqeEl72ap488
         Say600k+VfBjFQK/8beBf9UfaPNaZo5b6AaPB0iPUbF4NUuDDW+q9S6gPXuldzjs8oGM
         XaDo1CvhzWg9wt96D396jBV3bP4hQiw4YyGBPx87VJp9S0n/DFJPAOj/XhXelJCOuLET
         YJHq/6Dk9YQPOjJKkVOhMGBmzJukkWg5aqECaGG8HMsIiLSvzP29ecUfTytKL3ApPohx
         TItg==
X-Gm-Message-State: APjAAAXsHvN4PYmOWz2vPwxTZc7+d739dRunLWPCiCXDi5UFUgNcPKCd
        Ae0PntQ2xpOyVAwRXDejD7+og6HB
X-Google-Smtp-Source: APXvYqyidi/t7lzZ2SdRxtwDkNBBoGcPgPpge/AUxV/kwvqYmtYE87N4tPrm7ZYJhzKzFawl/nqERw==
X-Received: by 2002:a17:902:6ac8:: with SMTP id i8mr2796422plt.164.1571739615854;
        Tue, 22 Oct 2019 03:20:15 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id 16sm17823889pfn.35.2019.10.22.03.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 03:20:15 -0700 (PDT)
Date:   Tue, 22 Oct 2019 03:20:13 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 08/14] t5520: replace test -{n,z} with test-lib functions
Message-ID: <86dafc7b54ddc9f3323d9f8d29edc89cb33c5dac.1571739459.git.liu.denton@gmail.com>
References: <cover.1571435195.git.liu.denton@gmail.com>
 <cover.1571739459.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571739459.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When wrapping a Git command in a subshell within another command, we
throw away the Git command's exit code. In case the Git command fails,
we would like to know about it rather than the failure being silent.
Extract Git commands so that their exit codes are not lost.

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
2.24.0.rc0.197.g0926ab8072

