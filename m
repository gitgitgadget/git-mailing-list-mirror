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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3FC1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 00:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfKLAOB (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 19:14:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37652 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfKLAOB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 19:14:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id p24so11966212pfn.4
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 16:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IPW7kMkS/kYSUx1zEOvd8CZtQxnJuLDPIq5XTL6vScg=;
        b=NdJmaFFng7HAn6tS1nAiYXpibbP84jyB6N2pz29eYkWV8I7DWxvdSCwXno3nBvgrTY
         kVYPMVg8QhcCdxh8FQCcdlb+FRj/4/q44H5ts5OwzMF2p32Ck03eE9rj/Yk1EEj3HbQd
         Ari918KBBjWcGkuBTp7WGNryqPmYbhkiIFlxiJn29xtWD2LMKW1UdUYFplICumZ4SkL/
         sobYXxxlEyIs8wxo8rPG9mN0kAhYRNyBKt/TnaWE7PC6+6QL3FffPNfn+1gRf5dgif/A
         yMIWTx2zYU4BZLwx9ImIrlNpPCEiH1BGkpmXuKPIO8Sd+o33HThAWtwor7JZO2L6CW5c
         YJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IPW7kMkS/kYSUx1zEOvd8CZtQxnJuLDPIq5XTL6vScg=;
        b=ug1VZGT9w4wNuYQkdUDBWkZoNwk1H9bZyR+sDjlsDSZuE8sgoy2DVa8QoDhrnYdziT
         knpXtByKEWsGKS3Wapw/Br9ZvTaMgmKBH03Lf4aZm1UA6P+4gec3aum4nbAGdF71Sg1f
         KRWip3Z/a9hqClkz7o63OKaRYVR3VlshbgZiiGv9dAmZoIYQHt2DEZ4xnHOhWj80W7VQ
         hB8WM+w41Vbkzq+yfZoE4cZ7lQQH6sUy7LHdYjn2o6uWHTUTAYQ/4ggAmv9m8hv9ZlSX
         VoEsoX8gewj3Ib0L0MLPOJxXwugG3GQ2OEXAS+SccKN5qr1VvEff9kbkmPMorG17kVhL
         YDNw==
X-Gm-Message-State: APjAAAUTV9qJlPCtVbe7ntx0D9F5FZd7gCGGR1zkIMrK3Vdt5HPpRIJ5
        fY3zh6goi7HXa334/ldA9kvJ17Qi
X-Google-Smtp-Source: APXvYqy6izS8J+k74Km0Xmc9+slZDGipWpqyPkAJxhib5u3icQbO4YeO+8NfE4X8/PUI0WAzjH9dag==
X-Received: by 2002:a63:d258:: with SMTP id t24mr31572045pgi.289.1573517639856;
        Mon, 11 Nov 2019 16:13:59 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id r20sm23077481pgo.74.2019.11.11.16.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:13:59 -0800 (PST)
Date:   Mon, 11 Nov 2019 16:13:57 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 08/14] t5520: replace test -{n,z} with test-lib functions
Message-ID: <85b444e8a6c1876e53560dd6a989ef62c2daba2c.1573517561.git.liu.denton@gmail.com>
References: <cover.1573152598.git.liu.denton@gmail.com>
 <cover.1573517561.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573517561.git.liu.denton@gmail.com>
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
2.24.0.300.g722ba42680

