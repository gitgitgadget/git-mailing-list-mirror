Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187471F404
	for <e@80x24.org>; Thu,  8 Feb 2018 15:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeBHP5Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 10:57:24 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41905 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeBHP5N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 10:57:13 -0500
Received: by mail-wr0-f195.google.com with SMTP id u60so2503625wrb.8
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 07:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rtBbIED5k6pqO0oIbELMqXPyeuvtOc9cARjSDFZcWtY=;
        b=dovL37xVS0RkczY2UFs/ioG0vOCDJkqHqKkZhx0eBiRFTtGSMICrnrWh1FkotsatFd
         M47AEBRNwbPtV/iY9jIxT0IwLeVmV2maEcA9ZP4nZnAORraeEmyj07db6KvvlCQdNMlI
         R/wRWL9qX9Tpv7dESna1WxO+BMZaPUoavMN2H6ZrAk4RwujfUYiOlkyjSl2gvjnKwfxY
         1fSkpCHKG2a27P3Y1SQf7AaHXbZzuzj5APzP/kuCiqkqt4kSZH+nXmKG6mg3gMA6fxI2
         A5qJboglylYPReeljMWCYWh0Lw8OUXscfqMFZjySShvSLkI3i6ucVsMSlKjT8B1idzZM
         buLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rtBbIED5k6pqO0oIbELMqXPyeuvtOc9cARjSDFZcWtY=;
        b=FQWYyfgiKoG4PluuHqo8zBbMOoRMh1ZV/RPnWIfVbAHUJo6xfTh9FrpUQti8eZIF9h
         2isAEXnT0QAJS0PSAc72Bh48ZMXqxJL/AWPhjhD6g+clG8JiaUSRmfs5A1qOejUwYPXc
         fZ9DHaAlT2d5C3ctCOE0F4npQsKi4h6EgmFWfBYr/DftEts46H5xG1jkGDlW+W5ERgXC
         SvkD9BC31T+JCLHMO7t8GLTCb0f7x7+NZkD9xSAO8vC1rcNj0WmBrQymzoK7gu3MSTmR
         002iBRRaDTHasSJUruFFb0mDFDfyFNbxdv5KncFF4qJfJvG7Z2XZWk1YOtdvYuywnHMx
         HHog==
X-Gm-Message-State: APf1xPDipRJQbd9yhIdF8pYbHLLCV05eiCjaIQHBh05ZxciukuWMGJHT
        6M7tcFz/C6atAKvxP4jDgLY=
X-Google-Smtp-Source: AH8x227hvyVzgYlZRolgEMvSWF4sUyrlut8Axs7ZnUAFRZs9UioI+NToSMwoSQhZdOGRUbWbSHKS0w==
X-Received: by 10.223.201.133 with SMTP id f5mr1120137wrh.99.1518105432298;
        Thu, 08 Feb 2018 07:57:12 -0800 (PST)
Received: from localhost.localdomain (x4db2a6c8.dyn.telefonica.de. [77.178.166.200])
        by smtp.gmail.com with ESMTPSA id p14sm308880wrg.42.2018.02.08.07.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 07:57:11 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 5/9] t5510: consolidate 'grep' and 'test_i18ngrep' patterns
Date:   Thu,  8 Feb 2018 16:56:52 +0100
Message-Id: <20180208155656.9831-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <20180208155656.9831-1-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180208155656.9831-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the tests in 't5510-fetch.sh' checks the output of 'git fetch'
using 'test_i18ngrep', and while doing so it prefilters the output
with 'grep' before piping the result into 'test_i18ngrep'.

This prefiltering is unnecessary, with the appropriate pattern
'test_i18ngrep' can do it all by itself.  Furthermore, piping data
into 'test_i18ngrep' will interfere with the linting that will be
added in a later patch.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5510-fetch.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 668c54be41..3debc87d4a 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -222,12 +222,9 @@ test_expect_success 'fetch uses remote ref names to describe new refs' '
 	(
 		cd descriptive &&
 		git fetch o 2>actual &&
-		grep " -> refs/crazyheads/descriptive-branch$" actual |
-		test_i18ngrep "new branch" &&
-		grep " -> descriptive-tag$" actual |
-		test_i18ngrep "new tag" &&
-		grep " -> crazy$" actual |
-		test_i18ngrep "new ref"
+		test_i18ngrep "new branch.* -> refs/crazyheads/descriptive-branch$" actual &&
+		test_i18ngrep "new tag.* -> descriptive-tag$" actual &&
+		test_i18ngrep "new ref.* -> crazy$" actual
 	) &&
 	git checkout master
 '
-- 
2.16.1.158.ge6451079d

