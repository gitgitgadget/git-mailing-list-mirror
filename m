Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FA831F404
	for <e@80x24.org>; Fri, 26 Jan 2018 12:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeAZMhb (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 07:37:31 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43207 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbeAZMh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 07:37:29 -0500
Received: by mail-wr0-f193.google.com with SMTP id t16so396336wrc.10
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 04:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CztAR9NWZeMn1HS6pKBqrgAScI+D5ArZvfIq9pk3Ias=;
        b=f06H5Vl9lEkW2h7maZXyqtw65Ih6LzybaaavJ3MglUR4ClKXp6jIb8cOpvSgGE+8ez
         7F7N4DFmBG5VRtMlTMKl56OIXpzuoACfAQpD8I3aLapXCVJ/aCaPd5f1DAnwwLV94JBT
         aVI2FhCi2LZuJRuoWVNPc+Dds2G1bUd3R0Z38AzmJjIK/9ff8bAA5dBJC7ySrxK0pP9b
         8oQLhh/LMgRaljHcfq8fLC8seoXan8gbpebiKmWCWxgRFtmwEu3t50i5c9ViUMwfgPHA
         gWdoCjYlIldfBNbk1X/cWHnOrpj4aIfxZVx4bbf9PRPOCanSCP8I0KZXJWkXv2ApNVQ4
         +09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CztAR9NWZeMn1HS6pKBqrgAScI+D5ArZvfIq9pk3Ias=;
        b=M7fuSGxD7kuD8iq+YcS9CWMJxl3LvLuL0Z+5Se8yQR5mmXfABNKQcV8BOWNDXN0mVJ
         aMm5o2F4STJwvJjRwzRT9V7CKmf4suNX9DyXFO0drjLoph1TG1pl45K/lDjnhaiP/CJZ
         AHhkPPfB/+Ft3iH+H058v/Y+fEOqaoLwMW4KRWpdac1EIXHp6zYMCGUCYRghk0DloRF4
         wCZPgaxKjbZYHk7jxiv+CsIRxGFIm2MuzqTd5dTtgvFlmq6tEL7edp1vvKdWe/HTnXo9
         0bkDc5bell9rQEl0f/9Ye4ubCCut+GXSiy/2MdG0WS3KRUTjKCoMRgXx5fYBf/OaQ8uH
         G+sA==
X-Gm-Message-State: AKwxytfRRTqF5dQ5xG4OF47OkoYFkqgq8LeAC2Boo+rXnPFddl/jKQjW
        TCbUERxrBMz038jJPoLLqwGIaA==
X-Google-Smtp-Source: AH8x227FmWe0Ds5m9KNErHMAeCcKFxLXp+vyN+SOyMVr/2/WaH1Gs4dBMYB5x7TacZHSF6Vv8bzeGA==
X-Received: by 10.223.182.65 with SMTP id i1mr12027669wre.92.1516970246855;
        Fri, 26 Jan 2018 04:37:26 -0800 (PST)
Received: from localhost.localdomain (x590dab0e.dyn.telefonica.de. [89.13.171.14])
        by smtp.gmail.com with ESMTPSA id d17sm4756626wrd.50.2018.01.26.04.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 04:37:26 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 06/10] t5536: let 'test_i18ngrep' read the file without redirection
Date:   Fri, 26 Jan 2018 13:37:04 +0100
Message-Id: <20180126123708.21722-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.155.g5159265b1
In-Reply-To: <20180126123708.21722-1-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Redirecting 'test_i18ngrep's standard input from a file will interfere
with the linting that will be added in a later patch.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5536-fetch-conflicts.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
index 2e42cf331..644736b8a 100755
--- a/t/t5536-fetch-conflicts.sh
+++ b/t/t5536-fetch-conflicts.sh
@@ -22,7 +22,7 @@ verify_stderr () {
 	cat >expected &&
 	# We're not interested in the error
 	# "fatal: The remote end hung up unexpectedly":
-	test_i18ngrep -E '^(fatal|warning):' <error | grep -v 'hung up' >actual | sort &&
+	test_i18ngrep -E '^(fatal|warning):' error | grep -v 'hung up' >actual | sort &&
 	test_i18ncmp expected actual
 }
 
-- 
2.16.1.155.g5159265b1

