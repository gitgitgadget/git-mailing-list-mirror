Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EC341F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 05:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfJPFSz (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 01:18:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43148 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfJPFSy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 01:18:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so13922047pfo.10
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 22:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fCHAn7Qaeu0WxnxXRaO5PFTLC6Rwnvn/nlwjTV+Nqj8=;
        b=OxZZHYUHbz5daLRq5hbOveT3aEw5mKmkJXLeSXOjXi+9t62A2mDz0ugeGsfBbERtfr
         R/ktms+QCTnREnipRkpcC6vPzb3ISVw70vxUSZeAdIg47wS4bp4/hPTdb8RooryHhLoQ
         XsijFtIOBpXf6Z7zejQT11YwDQUOZfcfbm1lqyRrWqQ4WTJ1Tpydu4xadD04S6qOGSg5
         93IT9/kgvaVb2n4Cu/9cUFpJNWLnADMXTjiVYPCjNXxQrupMPM4mRKuhjv5ntZfT/bjz
         QhtimR9XI8fC8BKchB7WZhCwbCZ5vHRGYICiUzGxNJQJBOlpd2sl7bBBwNxqIWzOTbby
         pEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fCHAn7Qaeu0WxnxXRaO5PFTLC6Rwnvn/nlwjTV+Nqj8=;
        b=uBW2bgzWxT5ccGhmn7d7YAKN2WzHX7GZKaKKfXywA2fcqLgKzfBtQZVh1rFnZs484x
         gbDFFShQMWzXYiPY69otISm6hUS5ZbyFd0ycNaefR3MXn3H2RkhO3gmB48ILoqgsEAgG
         1WwM5Eyntq1svpwxbzdYsp89PfCWfma7NfFWPhQGxH+txMdj2GuyTAvRMROqyFgflYqE
         isfhWw46w0zBeC3a4Xilt0YDGvejqosr6fAd5UW9OpDdD4TdImjEppS71zWwOUoxA6sW
         jLoOAg8U6sRP4RxEOclm9jHtTpzxtrTF1Om6Spz4w58chPT7ByYCXZvw8AZ3ZWGO+kf+
         CiNg==
X-Gm-Message-State: APjAAAUjCGirgC4pq3TCXVMR0MIo4wF4EDoCak6a3Cxg2k3mJR+7vHGp
        k8g+Wwb1ujq6nTjioMYEJPb44/FR
X-Google-Smtp-Source: APXvYqxxNLOPoRQuSpW735u/PbQx0XglhMxH+qWXPGWXHU0CDqag2+3tgFa1WnWvE7uKoBWDVfyccQ==
X-Received: by 2002:aa7:829a:: with SMTP id s26mr5011350pfm.80.1571203133942;
        Tue, 15 Oct 2019 22:18:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:2b61:f51c:7233:c8a4:1e74])
        by smtp.gmail.com with ESMTPSA id f6sm24759105pfq.169.2019.10.15.22.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 22:18:53 -0700 (PDT)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH 1/2] t3301: test diagnose messages for too few/many paramters
Date:   Wed, 16 Oct 2019 12:18:40 +0700
Message-Id: <20191016051841.19896-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015163631.21808-1-congdanhqx@gmail.com>
References: <20191015163631.21808-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From commit bbb1b8a35a, ("notes: check number of parameters to "git
notes copy"", 2010-06-28), we have a test for too many or too few
of parameters provided to `git notes copy'.

However, the test is only ensure the command will fail but it doesn't
really check if it fails because of number of parameters.

If we accidentally lifted the check inside our code base, the test may
still failed because the provided parameter is not a valid ref.

Correct it.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 t/t3301-notes.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index d3fa298c6a..d7767e4438 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1167,8 +1167,10 @@ test_expect_success 'GIT_NOTES_REWRITE_REF overrides config' '
 '
 
 test_expect_success 'git notes copy diagnoses too many or too few parameters' '
-	test_must_fail git notes copy &&
-	test_must_fail git notes copy one two three
+	test_must_fail git notes copy 2>error &&
+	test_i18ngrep "too few parameters" error &&
+	test_must_fail git notes copy one two three 2>error &&
+	test_i18ngrep "too many parameters" error
 '
 
 test_expect_success 'git notes get-ref expands refs/heads/master to refs/notes/refs/heads/master' '
-- 
2.23.0

