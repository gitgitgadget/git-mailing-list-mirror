Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE4DF1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 15:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388405AbfIEPrx (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 11:47:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46886 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbfIEPrw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 11:47:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so1994079pfg.13
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 08:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2SGUN1pQtHIBbG34jpTwc2RyLaRfhECP9vcQqdDgOKk=;
        b=eC98Yq3R4OpWduA/mMpO+/SsuLSWgQ2zHTt5YB8lHmuRbisFl06D0iWrjaYo/PxydS
         DLHqGkvp1HDs3nxdWBBLvnCiZHdlGIyf0qyl2xuSJORCrcUawL2Qr+aVGuZS5FemubMx
         xIgBcE26arGHUnv/yk4yCc9Gj56gsVqpaUuDi7Mb5J/FIVdMv5jdnsZMmwNbgGFC3b/f
         D5Yj+Fs0lZMfuXZiN8I3/vl/UcD6hfzpYvNySB4J7j2qfkKkEQNpcFAVfCvIji3+9Hqt
         lj99pbhbzvY81qRSmULwLYnN+uiHEaPSF49Ek6xMOluqK6LbQ/BkVeB2KTuSCVKMzBww
         tKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2SGUN1pQtHIBbG34jpTwc2RyLaRfhECP9vcQqdDgOKk=;
        b=Au4T9wtiXYxeeHVCYa+LLW9xITavzCpibpE5LCc/BACzT/LzOK64DZqEh8t2S0mL5l
         qU7psLfNF6Gkyu8vdJCD8ugbxT2pqFA09IcbsJkPTLalT0hmPrrCUcK0NW6mNAPst7tp
         muHsRGtTgdd1+MvlhK7ig8A1ykp9Ph7wyd3U1mFfK5cEXNmrL+b6LUMVdrOXMZjsT+Nd
         jgdVolWUGOb+xRRlFx/U2dmU5AzpJyejWNJhpT56iBJ0ND5qeDzMtrbObb4/DJRWJmS3
         s+EijK7dqcr2hQNpT/5YEJFxLWHr9IwPwNitwc94ly1NL8BRH97B1hQzvumVP73LrQrP
         QTTg==
X-Gm-Message-State: APjAAAUNd5dO0vauDROPy7NoqpGPQ86RFoVNQbjNeET6iH8PXzXfZXOB
        agWKfWawF5WAPJrqbDDrKLClnfP2
X-Google-Smtp-Source: APXvYqyUuWCQFVh+t417FwlWeAn3AYtHrT8/fbEzCWjCIh0jCKnk7YgPNgNM00lCddlVr4GH42N2cg==
X-Received: by 2002:aa7:92d1:: with SMTP id k17mr4518426pfa.160.1567698471878;
        Thu, 05 Sep 2019 08:47:51 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id x16sm2339867pjn.12.2019.09.05.08.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 08:47:51 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 11/12] clean: rewrap overly long line
Date:   Thu,  5 Sep 2019 08:47:34 -0700
Message-Id: <20190905154735.29784-12-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.11.g45a39ee867
In-Reply-To: <20190905154735.29784-1-newren@gmail.com>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
 <20190905154735.29784-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 3a7a63ae71..6030842f3a 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -158,7 +158,8 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 
 	*dir_gone = 1;
 
-	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) && is_nonbare_repository_dir(path)) {
+	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
+	    is_nonbare_repository_dir(path)) {
 		if (!quiet) {
 			quote_path_relative(path->buf, prefix, &quoted);
 			printf(dry_run ?  _(msg_would_skip_git_dir) : _(msg_skip_git_dir),
-- 
2.22.1.11.g45a39ee867

