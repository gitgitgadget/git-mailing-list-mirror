Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E101F406
	for <e@80x24.org>; Thu, 10 May 2018 14:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935419AbeEJOCH (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:02:07 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35594 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757187AbeEJOCG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:02:06 -0400
Received: by mail-wr0-f196.google.com with SMTP id i14-v6so2146457wre.2
        for <git@vger.kernel.org>; Thu, 10 May 2018 07:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B69RdVD1uRJcll8C/586zGmmN9BLbmmGBQ72TF3y7cM=;
        b=JvHPHNXopOoMNRRvjsghk/pG2hKAxhsskRlfZKmqoq1z30y8bOduwCE48Eiqu7xUuL
         49PffVgVXxIngAXrCQdVI/vzIxPKV9rAh/2ML8NbhLqy/bRio+GPS4h79NRSnWB5KWn7
         6cV7uOme2opwys8YrAjU8tDP3j3WG/X7x2UyHKtuzycdIVrC2aqg+tbvJeGbA1dKDXq2
         Ivngq36BJmmmoDX/IdqA1CLspFW8QwtJFt9G5GPRGvq1p0ilJDBi7SLbbJZ3ySKZ2fnm
         GtwHXbMYtNArc+6l4JtpxjdhBSixGgpJwNHwW96vMQfPURVO8euSMXsolaUyZ3lc9XGj
         Z98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B69RdVD1uRJcll8C/586zGmmN9BLbmmGBQ72TF3y7cM=;
        b=cewg2gxRHsLJA1DXBJ9LX7wgM8vhT8htp9ngUBWq8zyHbNsGJUPvaPrznA8zICc5iK
         t+aQIe6OxznXhJ43CIfxjhT/BsoVECQKO5X0vfXVDGmYSKpuYgcJZq3wOZIKrtOtynN0
         mnOBBo5yPiJyhG1MM6me4XtqUF2xCfwmwqRuNcUZpwU9nkiQDdhZzylsPhNeNE5apm8I
         NgI3b44NcIla7vI/omnZ7TflgLhfZQlOohSwa9mlsRqZLNGNSQ7b3qVGD/5jKxTFhSCg
         u2yhR4HDbR/9xTw55nI9zahSR0/zKJxtiLItte4gyXd3H1CkplnkvimbghYGyhGN2oBW
         EsdQ==
X-Gm-Message-State: ALKqPwd9MEbCQHqmdVl6TnemXrC8nAY7uXRc9sFq8mRohrhMefxpv20y
        ZfKf0JVKTC5yYXDy1H8WO10=
X-Google-Smtp-Source: AB8JxZoOuVH2jzQJvMjXIngR39Q0Mi1NCmjWqtiWmCW6f+gY1foYnbNwA7K8v0p6YXFDYLx+W3Ztxw==
X-Received: by 2002:adf:c4c3:: with SMTP id o3-v6mr1436607wrf.108.1525960925018;
        Thu, 10 May 2018 07:02:05 -0700 (PDT)
Received: from localhost.localdomain (x590c7c95.dyn.telefonica.de. [89.12.124.149])
        by smtp.gmail.com with ESMTPSA id q194-v6sm1850296wmd.26.2018.05.10.07.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 May 2018 07:02:04 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] t5516-fetch-push: fix broken &&-chain
Date:   Thu, 10 May 2018 16:01:54 +0200
Message-Id: <20180510140154.30381-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.756.gcf614c5aff
In-Reply-To: <20180510140154.30381-1-szeder.dev@gmail.com>
References: <20180510140154.30381-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

b2dc968e60 (t5516: refactor oddball tests, 2008-11-07) accidentaly
broke the &&-chain in the test 'push does not update local refs on
failure', but since it was in a subshell, chain-lint couldn't notice
it.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5516-fetch-push.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 832b79ad40..3e8940eee5 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -612,7 +612,7 @@ test_expect_success 'push does not update local refs on failure' '
 	chmod +x testrepo/.git/hooks/pre-receive &&
 	(
 		cd child &&
-		git pull .. master
+		git pull .. master &&
 		test_must_fail git push &&
 		test $(git rev-parse master) != \
 			$(git rev-parse remotes/origin/master)
-- 
2.17.0.756.gcf614c5aff

