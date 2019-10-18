Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68E0C1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfJRWEc (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:04:32 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:39133 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfJRWEa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:04:30 -0400
Received: by mail-pf1-f171.google.com with SMTP id v4so4670937pff.6
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zJ81W7ZgttEIX4oKmBXv/wY1VZeeU4NQp4kmTA0r8Co=;
        b=skwOGrfJt7ftpQBoeMvj5v1X1aZu0zVlOpjTr+WzPLKsS9jNbjzrrz49FLp0KQnwlM
         AapNq+WvF0RXeBc7y1O7fw77iiD5ejtxuQpLnxKBZOu6FP7uRqXIVlGnDz3c3IyciEm4
         OrKg7A4pE79mfd370P13RcJrZVBbCv64rNzmpumOxROtSsR4ER/MOQEWmjwU5BXJHb4I
         TfO3liNiNQDDTwh5uPt3Zeo5rqtfc4Pgm0VXfbuR6fvqtkJrqTbL8BJB7tapSVaWKwqZ
         gp0v2MD5Pf+ZaIJKeJR9ToJz7xSLNtrB3HQBKmwxMod/9CHoopctUZUJPZgsJeAJ9ASC
         Fwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zJ81W7ZgttEIX4oKmBXv/wY1VZeeU4NQp4kmTA0r8Co=;
        b=TlXGvqQf2eVCdEDg7cUHivGESna5o3oDtCLJX3twyDilt5HbEltnxz+xA2yam+q+lu
         9urI0t4PZw6d29Cm52xRTd/hoMVMCKPxu1cP5F50gT/Oaa3GvM2ngNcWAKRsOxQjKI/p
         Uts6CXifg6DcR69Z0nf9UGmmVm5Dme28sr7JhDGG0HMyX07aXBgtfq8VSVWOo3Ow9P9g
         mqSgqbLDdG8dR7MVVcaDdgNqSGnYWcEPP8cWv4Bpx8KoPmfmaSl+VqfdDxesl9Vx7LG9
         HuApRasd9rQBZXDgMZqVnL54doWxzUjdRwoK5ETYA/d56q1ecyEGLr8EPV8T6wNu7bBj
         Sr1Q==
X-Gm-Message-State: APjAAAX8U0cvmEaoiiKOcEkj8Z8vriCe4j6xzuxgSlfZNDyMB7klJBr5
        aSblm0uRVLCLxyFDmBX+arUfoRLF
X-Google-Smtp-Source: APXvYqwXSlqA+u4gTL491I1rJEp7v+9NQ/BPfSzcZFujfcZFaeu358G90xtfBGqQ1gn1XrcPuaKdRA==
X-Received: by 2002:a63:d70f:: with SMTP id d15mr12849338pgg.424.1571436269423;
        Fri, 18 Oct 2019 15:04:29 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id b20sm10102942pff.158.2019.10.18.15.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:04:28 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:04:26 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 09/15] t5520: replace test -{n,z} with test-lib functions
Message-ID: <2bca4f046d72615045e584d89817f99b6c0c61ec.1571435195.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <cover.1571435195.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571435195.git.liu.denton@gmail.com>
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
2.23.0.897.g0a19638b1e

