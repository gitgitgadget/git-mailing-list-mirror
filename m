Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DA191F462
	for <e@80x24.org>; Tue, 30 Jul 2019 21:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387765AbfG3V30 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 17:29:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42070 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387515AbfG3V30 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 17:29:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so17406545wrr.9
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 14:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9pVLFbc3iRzGF6L1Mw06uqZiRYjY8QfPvBHKPx6Ikls=;
        b=JC/2zUKAUqlZRjwbCtqVQ18jga4drR4xOGzRmhcju+XLXnoGcvt6QlYetJbi1b6D/f
         P9x1fAVOdePnqHAEvFhDffl7ICT4d8EitYxn1Db0L7IBNwqn4n5IlNQb1KpMAztUHrpE
         yTQuyahf+7mL5r7Hs6+Ehe0Ek0vPdyIKOjKY7mlRm4vNWUpNMY6DEgHbQfojhKPSlLVU
         NSjjs9LlU6uXUy8wrlgKcFLWp9ggHJtYG5eIfSREzIa/KvxH1CLGKEiIDx4upZqoaWyV
         3FUoUZf2Vf8xwdWvTrPAvDhwmYStnxGQYoUQHtiPQ8RYGgX8PfnsMJ1UmTiZu7mG9HHb
         XPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9pVLFbc3iRzGF6L1Mw06uqZiRYjY8QfPvBHKPx6Ikls=;
        b=VY5eKJ9/fCzEXjm62JadrMt4gU6bFaUlUb9Oyo8Ddr4u9XSN0GSCanbY8qMWbaDBfc
         xRkfoh0Z4ysdD7ueGyCe+2uMxvqnSbMzGD8Lod4EiiTIBhXBsgewLTtAOuTsQnieSrpG
         htNL0jOofY5gyN3mSdlt2Qzqs5FffHyS8rpeLo3YmFVKp6Dfn2JuYUQPWX+Ny8XY8nYR
         Yrl5IMzmKBoOCwJdMzGUVXbt45774TaKieEBD8u9gy6WQf0rP+7NorNWtLmrs6/Qmia7
         tau7+vf5gEpwIaZvkX+flo5QXogEC3oMC5t1gsu8F9rXu5c7e8OyyNUv/Xl9rAHk5mxj
         kiAA==
X-Gm-Message-State: APjAAAUdnPSfirR17yZEKy7C+/xi3IYZzSBO81Qk6MBVcfSgvw4zesbL
        z7DN7+uJYAZPyLch22pDVCY=
X-Google-Smtp-Source: APXvYqwmElP9tPzz7Mg4wtMk/sk9gd8SbZoChjGklIMdPcmCVqoDf92C6GfnRLLnxE4J+1/bUuyCBw==
X-Received: by 2002:a5d:4fc9:: with SMTP id h9mr2416416wrw.349.1564522164231;
        Tue, 30 Jul 2019 14:29:24 -0700 (PDT)
Received: from localhost.localdomain (x4dbe512f.dyn.telefonica.de. [77.190.81.47])
        by smtp.gmail.com with ESMTPSA id z1sm68409857wrp.51.2019.07.30.14.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jul 2019 14:29:23 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t5510-fetch: fix negated 'test_i18ngrep' invocation
Date:   Tue, 30 Jul 2019 23:29:15 +0200
Message-Id: <20190730212915.3509-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.926.g602b9a0287
In-Reply-To: <a4fe71618410bdb188b6850a61ec65e7b4da5897.1560889525.git.gitgitgadget@gmail.com>
References: <a4fe71618410bdb188b6850a61ec65e7b4da5897.1560889525.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test '--no-show-forced-updates' in 't5510-fetch.sh' added in
cdbd70c437 (fetch: add --[no-]show-forced-updates argument,
2019-06-18) runs '! test_i18ngrep ...'.  This is wrong, because when
running the test with GIT_TEST_GETTEXT_POISON=true, then
'test_i18ngrep' is basically a noop and always returns with success,
the leading ! turns that into a failure, which then fails the test.

Use 'test_i18ngrep ! ...' instead.

This went unnoticed by our GETTEXT_POISON CI builds, because those
builds don't run this test case: in those builds we don't install
Apache, and this test comes after 't5510' sources 'lib-httpd.sh',
which, consequently, skips all the remaining tests, including this
one.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

This is a minor issue in v2.23.0-rc0.

'git grep "! test_i18n"' shows no other similar cases.

 t/t5510-fetch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 139f7106f7..f2481de577 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -997,7 +997,7 @@ test_expect_success '--no-show-forced-updates' '
 	(
 		cd no-forced-update-clone &&
 		git fetch --no-show-forced-updates origin 2>output &&
-		! test_i18ngrep "(forced update)" output
+		test_i18ngrep ! "(forced update)" output
 	)
 '
 
-- 
2.22.0.926.g602b9a0287

