Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 743E720387
	for <e@80x24.org>; Tue, 18 Jul 2017 19:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752251AbdGRTFx (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 15:05:53 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36077 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbdGRTFn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 15:05:43 -0400
Received: by mail-pf0-f175.google.com with SMTP id o88so9277220pfk.3
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PqjQsSZ7qcpiisd5TqN7jxea+T9ex8wPwITBRNmVhwY=;
        b=iWxreGvzFe8msGnloQK4OTM0JrHaRtTCWSN7RCHDU0A6N5jM1CsUlqc5LnHJF2btju
         A62F3LxjBbnrURCDqD6ckz2fI+KW9GCjMyBDmKUIPdixrLtSVb42cHDXnmCCs/CcpzQG
         1/WHRltJTygGXqTXFcHRt6zwu4FSbJ7dF3YVhUgLE/bQkwfZNoBImTF/Hk8v72Q9CRP6
         Qvyyv0t4ENVyV/sROVNiRUurN0FairiHFUUKz3k4WH3RHr6Hsts+vqdwwX9FtorrcpNi
         sAYfZRj5/E46YZharauJ3P2VPRBTvIaOucJTMLqYJ8gkMxHmWfQhORbQPJQInfeuaeJc
         tzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PqjQsSZ7qcpiisd5TqN7jxea+T9ex8wPwITBRNmVhwY=;
        b=n6x9OpS4YZaGlzNYychN/aZCwRcQLqPJgxPI9Q2qI2bNdDat7sSB9eO2L0NNUn0XE4
         XG2rArkzBBt+W+YCFNhBm9H3tJGmeUbBbdovMqCYAA/h4byXSfnqw6Ii69fOrypYCqme
         hgrFIWh9ifXpNzAQwd0Id38aG2CGWqpSjOKfR4XGKrXiSdpw94beLbnXSMgrPoKWPnIa
         CqhLLU7GlndXxT8CcN6wazBcPz18CruhznseTeEPKfKMpL2BxNGzhh/FzT4gAJD2W+to
         5M2B9jNZ5R3FTrzOHgFH2cLFja1IekTgCTQn0IzghTX960sy/IdgNOhWMHfnp+XmNTg2
         qCwA==
X-Gm-Message-State: AIVw112kNtza3YaILs6fEvAAm4f2LzkkrXXYs4svWVrdPUf7kC66GIFh
        R4wp0Sj3UE+pwLKZOn932A==
X-Received: by 10.84.176.195 with SMTP id v61mr3276082plb.51.1500404742290;
        Tue, 18 Jul 2017 12:05:42 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t11sm6894649pfi.66.2017.07.18.12.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 12:05:41 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 03/10] cache.h: add GITMODULES_FILE macro
Date:   Tue, 18 Jul 2017 12:05:20 -0700
Message-Id: <20170718190527.78049-4-bmwill@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
In-Reply-To: <20170718190527.78049-1-bmwill@google.com>
References: <20170714222826.81148-1-bmwill@google.com>
 <20170718190527.78049-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a macro to be used when specifying the '.gitmodules' file.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 cache.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cache.h b/cache.h
index 71fe09264..d59f767e2 100644
--- a/cache.h
+++ b/cache.h
@@ -433,6 +433,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
+#define GITMODULES_FILE ".gitmodules"
 #define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
 #define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
 #define GIT_NOTES_DISPLAY_REF_ENVIRONMENT "GIT_NOTES_DISPLAY_REF"
-- 
2.13.2.932.g7449e964c-goog

