Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A921620248
	for <e@80x24.org>; Thu, 28 Mar 2019 17:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfC1RRw (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 13:17:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38397 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfC1RRw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 13:17:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so16500284wro.5
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 10:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aPoaRr4MQJOjKlAQc67uV9qdtpB1pZyevaMgzEXSn90=;
        b=shg51U8FBrPa8s4HA/2BiEhUVBNeh2N3VmicADnpQYhEmrw8f/y8u2z3a3ncVK+g1a
         MsClGFStKMAndPWTpNZalFJ+f0fj34lsHomHEViIt2AU3Lmm9Eu9u1rFcFeeoCCF6XVS
         mYUo5lwg2oK5f5sb3dxcV9lWENWrRg9wf1MRWrgk1hGNuxq3+Mx72f282XJJzfBbrE72
         Y/FzPN4KZ3huz/QTUKLXDQOzWIW3yOKTGOjZLIxy/G0Kd7rTxSFE3U9g8wcNzwW/7qgz
         aZT+VsTxFSOu2153OuXxybLQt6cjkwROHyDXQam0jJ0zLgJQfpYy6Hqz+Q8nOs/FjhJ5
         cRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aPoaRr4MQJOjKlAQc67uV9qdtpB1pZyevaMgzEXSn90=;
        b=Mip7ZTIu6rNoL2ejD2XJwydAeFWN2osmNbY71HVsvfyJtkR8CAA7zagPmVYFs994+8
         HArEP2Fvh3gKnAXYiE9C9sVBxIawOfb4gVGDyzpZ8PQvz9VuoJGLVm0TmDJC7DtBnpVR
         +CEVqbOqMqPTJG7UPML/nhe8rh/Hq3aRVF3iM5aEKdqUg1L0ehxxpDwNmb2Y1JWZOsg6
         zAZh7E6YdxkPs52+a23gmzxHm1srbX3+ilTzLREhISJW8nO/JwB0A/7PfeV07J/gIk20
         20PYB71qoctzdLYshUHDsIXY/dEToBlYPGj66UowMFhds0Rj3XLEhqQA3cnejx+ZWb1c
         4fRw==
X-Gm-Message-State: APjAAAV6HCrIH1glEAtoyEMV6bKSyl4vAptOgAMZwV5vZuSRD1LFvywN
        gFtgEB17qE/NRusVZP1OAjgZ/b/q
X-Google-Smtp-Source: APXvYqxF2SfdRQStcY54u0kE5nUjomi0NLKx8ELQqaGqeP9iOhszTEenfZ3c0CRP5Ch6NDkR0OjlZQ==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr27027645wrn.324.1553793470755;
        Thu, 28 Mar 2019 10:17:50 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:1085:dfe0:49c5:28f4:744c:fa99])
        by smtp.gmail.com with ESMTPSA id d17sm25837369wrw.88.2019.03.28.10.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 10:17:50 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@suse.de>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] t6050: redirect expected error output to /dev/null
Date:   Thu, 28 Mar 2019 18:17:21 +0100
Message-Id: <20190328171722.9753-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.68.gd997bba285.dirty
In-Reply-To: <20190328171722.9753-1-chriscool@tuxfamily.org>
References: <20190328171722.9753-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise the error from `git rev-parse` is uselessly
polluting the debug output.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 41b177936e..5cb8281bab 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -40,7 +40,7 @@ commit_peeling_shows_parents ()
 	test "$_found" = "$_parent" || return 1
 	_parent_number=$(( $_parent_number + 1 ))
     done &&
-    test_must_fail git rev-parse --verify $_commit^$_parent_number
+    test_must_fail git rev-parse --verify $_commit^$_parent_number 2>/dev/null
 }
 
 commit_has_parents ()
-- 
2.21.0.68.gd997bba285.dirty

