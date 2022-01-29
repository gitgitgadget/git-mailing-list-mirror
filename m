Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE5DC433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 17:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352725AbiA2Rvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 12:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352724AbiA2Rvf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 12:51:35 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136C0C06173B
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 09:51:35 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s18so17084828wrv.7
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 09:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ia9jmKJ4AlsS6Vki0bBg8zYEIlH/CrzKA4fY9kSGebg=;
        b=opDMsspH95vbyPd3PTuTzmVZ41HHTNLKvhHnGudtRbGiIRaVd/FQVpiRnK5aww2EqY
         F+XOm/fW2JGlHvbKy1OyMiCnupGDBhk1C58wEEYITHwdROvVZEa/mZj1ws2y2HQYb9OM
         HZuGV6xRRbPEYwfVGvJIJ1YX1uf213F+ppXESizh0EC+3BLlOP9ZXS0zwBd5uNn3MBWj
         lOxIf+XyenpaNzhyUSnYRGcbhQE4YdEemIY8dwmkqWKMwsLa7nnm2TsCivXNNzfxj1Yu
         AsWW1L4QWYo3KzI+/tBX7agtROjWQgCTtcvsnVHisUegKZ/YRE9ILGJsN3e1Pl5jRSo8
         boqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ia9jmKJ4AlsS6Vki0bBg8zYEIlH/CrzKA4fY9kSGebg=;
        b=D1RFrnp6LqpAJ6DIPs19+VkaMzw+vDdk5E9GKr6ZH7gYNr3bFl4sAuHb/nCv1w+Sww
         oDvvfvTDWaSwj3EaTdKdnOfi6CZotBiOiX0E9VqrSr2LXGKbfLXwvnlsNUyuaY/10tkZ
         AXumoTpuRJkRNRirgsx6i9SgtI5DpcbBrxAXRnW8jogY4zWD5uWqZOClJjvnPf0c9G2N
         CCjsvMIrmtNDsoRvAn2GkeDeluRWe5aGT8bETM8LaOXH6TvxWF/9hskGUiamNmij52sD
         j+19Eu2K4LJSaAERnZ1ZOaIQprk0gDn6oRJW8GOa00oBYfisFMykqyFoeKvnuopXSgI9
         WA4w==
X-Gm-Message-State: AOAM532ivvDBbvsZ2CgOo0BhXpwo4iCm4UAg+EYbl+xpfNwP/MklJV4k
        g0M0mv2ADb+OI+b9eNrZMnYwKseaXAw=
X-Google-Smtp-Source: ABdhPJxkFYY7lNw61NvrNmi9qGXg7LaaRZeg13OlgvCy4pEgpOWdWWTeV+5pWudNFkPTco3y/Y+lJg==
X-Received: by 2002:a5d:6d04:: with SMTP id e4mr11558126wrq.279.1643478693366;
        Sat, 29 Jan 2022 09:51:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm5059810wmq.43.2022.01.29.09.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 09:51:33 -0800 (PST)
Message-Id: <pull.1131.v2.git.1643478692337.gitgitgadget@gmail.com>
In-Reply-To: <pull.1131.git.1643334969216.gitgitgadget@gmail.com>
References: <pull.1131.git.1643334969216.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Jan 2022 17:51:32 +0000
Subject: [PATCH v2] repo-settings: fix checking for
 fetch.negotiationAlgorithm=default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commit 3050b6dfc75d (repo-settings.c: simplify the setup,
2021-09-21), the branch for handling fetch.negotiationAlgorithm=default
was deleted.  Since this value is documented in
Documentation/config/fetch.txt, restore the check for this value.

Note that this change caused an observable bug: if someone sets
feature.experimental=true in config, and then passes "-c
fetch.negotiationAlgorithm=default" on the command line in an attempt to
override the config, then the override is ignored.  Fix the bug by not
ignoring the value of "default".

Technically, before commit 3050b6dfc75d, repo-settings would treat any
fetch.negotiationAlgorithm value other than "skipping" or "noop" as a
request for "default", but I think it probably makes more sense to
ignore such broken requests and leave fetch.negotiationAlgorithm with
the default value rather than the value of "default".  (If that sounds
confusing, note that "default" is usually the default value, but when
feature.experimental=true, "skipping" is the default value.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    repo-settings: fix checking for fetch.negotiationAlgorithm=default
    
    This regression is not new in v2.35; it first appeared in v2.34. So, not
    urgent.
    
    Changes since v1:
    
     * Put the common code in two testcases into a function, and then just
       invoked it from each

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1131%2Fnewren%2Ffix-fetch-negotiation-algorithm-equals-default-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1131/newren/fix-fetch-negotiation-algorithm-equals-default-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1131

Range-diff vs v1:

 1:  9c592baded1 ! 1:  633c873b513 repo-settings: fix checking for fetch.negotiationAlgorithm=default
     @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
      
       ## t/t5500-fetch-pack.sh ##
      @@ t/t5500-fetch-pack.sh: test_expect_success 'fetching deepen' '
     + 	)
       '
       
     - test_expect_success 'use ref advertisement to prune "have" lines sent' '
     +-test_expect_success 'use ref advertisement to prune "have" lines sent' '
     ++test_negotiation_algorithm_default () {
      +	test_when_finished rm -rf clientv0 clientv2 &&
       	rm -rf server client &&
       	git init server &&
       	test_commit -C server both_have_1 &&
      @@ t/t5500-fetch-pack.sh: test_expect_success 'use ref advertisement to prune "have" lines sent' '
     + 	rm -f trace &&
     + 	cp -r client clientv0 &&
     + 	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv0 \
     +-		fetch origin server_has both_have_2 &&
     ++		"$@" fetch origin server_has both_have_2 &&
     + 	grep "have $(git -C client rev-parse client_has)" trace &&
     + 	grep "have $(git -C client rev-parse both_have_2)" trace &&
     + 	! grep "have $(git -C client rev-parse both_have_2^)" trace &&
     +@@ t/t5500-fetch-pack.sh: test_expect_success 'use ref advertisement to prune "have" lines sent' '
     + 	rm -f trace &&
     + 	cp -r client clientv2 &&
     + 	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv2 -c protocol.version=2 \
     +-		fetch origin server_has both_have_2 &&
     ++		"$@" fetch origin server_has both_have_2 &&
     + 	grep "have $(git -C client rev-parse client_has)" trace &&
     + 	grep "have $(git -C client rev-parse both_have_2)" trace &&
       	! grep "have $(git -C client rev-parse both_have_2^)" trace
     - '
     - 
     -+test_expect_success 'same as last but with config overrides' '
     -+	test_when_finished rm -rf clientv0 clientv2 &&
     -+	rm -rf server client &&
     -+	git init server &&
     -+	test_commit -C server both_have_1 &&
     -+	git -C server tag -d both_have_1 &&
     -+	test_commit -C server both_have_2 &&
     -+
     -+	git clone server client &&
     -+	test_commit -C server server_has &&
     -+	test_commit -C client client_has &&
     ++}
      +
     -+	# In both protocol v0 and v2, ensure that the parent of both_have_2 is
     -+	# not sent as a "have" line. The client should know that the server has
     -+	# both_have_2, so it only needs to inform the server that it has
     -+	# both_have_2, and the server can infer the rest.
     -+
     -+	rm -f trace &&
     -+	rm -rf clientv0 &&
     -+	cp -r client clientv0 &&
     -+	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv0 \
     -+		-c feature.experimental=true \
     -+		-c fetch.negotiationAlgorithm=default \
     -+		fetch origin server_has both_have_2 &&
     -+	grep "have $(git -C client rev-parse client_has)" trace &&
     -+	grep "have $(git -C client rev-parse both_have_2)" trace &&
     -+	! grep "have $(git -C client rev-parse both_have_2^)" trace &&
     ++test_expect_success 'use ref advertisement to prune "have" lines sent' '
     ++	test_negotiation_algorithm_default
     ++'
      +
     -+	rm -f trace &&
     -+	cp -r client clientv2 &&
     -+	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv2 -c protocol.version=2 \
     ++test_expect_success 'same as last but with config overrides' '
     ++	test_negotiation_algorithm_default \
      +		-c feature.experimental=true \
      +		-c fetch.negotiationAlgorithm=default \
     -+		fetch origin server_has both_have_2 &&
     -+	grep "have $(git -C client rev-parse client_has)" trace &&
     -+	grep "have $(git -C client rev-parse both_have_2)" trace &&
     -+	! grep "have $(git -C client rev-parse both_have_2^)" trace
     -+'
     -+
     + '
     + 
       test_expect_success 'filtering by size' '
     - 	rm -rf server client &&
     - 	test_create_repo server &&


 repo-settings.c       |  2 ++
 t/t5500-fetch-pack.sh | 17 ++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/repo-settings.c b/repo-settings.c
index 00ca5571a1a..38c10f9977b 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -85,6 +85,8 @@ void prepare_repo_settings(struct repository *r)
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
 		else if (!strcasecmp(strval, "noop"))
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
+		else if (!strcasecmp(strval, "default"))
+			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
 	}
 
 	/*
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index f0dc4e69686..0a737cf0a0a 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -927,7 +927,8 @@ test_expect_success 'fetching deepen' '
 	)
 '
 
-test_expect_success 'use ref advertisement to prune "have" lines sent' '
+test_negotiation_algorithm_default () {
+	test_when_finished rm -rf clientv0 clientv2 &&
 	rm -rf server client &&
 	git init server &&
 	test_commit -C server both_have_1 &&
@@ -946,7 +947,7 @@ test_expect_success 'use ref advertisement to prune "have" lines sent' '
 	rm -f trace &&
 	cp -r client clientv0 &&
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv0 \
-		fetch origin server_has both_have_2 &&
+		"$@" fetch origin server_has both_have_2 &&
 	grep "have $(git -C client rev-parse client_has)" trace &&
 	grep "have $(git -C client rev-parse both_have_2)" trace &&
 	! grep "have $(git -C client rev-parse both_have_2^)" trace &&
@@ -954,10 +955,20 @@ test_expect_success 'use ref advertisement to prune "have" lines sent' '
 	rm -f trace &&
 	cp -r client clientv2 &&
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv2 -c protocol.version=2 \
-		fetch origin server_has both_have_2 &&
+		"$@" fetch origin server_has both_have_2 &&
 	grep "have $(git -C client rev-parse client_has)" trace &&
 	grep "have $(git -C client rev-parse both_have_2)" trace &&
 	! grep "have $(git -C client rev-parse both_have_2^)" trace
+}
+
+test_expect_success 'use ref advertisement to prune "have" lines sent' '
+	test_negotiation_algorithm_default
+'
+
+test_expect_success 'same as last but with config overrides' '
+	test_negotiation_algorithm_default \
+		-c feature.experimental=true \
+		-c fetch.negotiationAlgorithm=default \
 '
 
 test_expect_success 'filtering by size' '

base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
-- 
gitgitgadget
