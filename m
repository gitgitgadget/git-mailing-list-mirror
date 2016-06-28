Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B2B72018A
	for <e@80x24.org>; Tue, 28 Jun 2016 18:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbcF1SUD (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 14:20:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34170 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbcF1ST6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 14:19:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id 187so7973613wmz.1
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 11:19:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jmHNFx2euTKRq7bc2bdAa5tKQTNxrNT2PVCZeKGhk0E=;
        b=Vby5hIO2WsZJqDX+dDHGChIqy3HbgKruCqP3wEtl6XGRJF25XbOMCrTW373N4+Va1L
         q892t8Vnhh3/dt9MvmE4OlXyFoe9BBw1/EhNWI2nxAik0EzvDiQy0nHrMwlSyJGsuhjG
         u3NCqkFYFycq65oPhJX2G0ZcDM/3GuJVXnWLTR5fSHg5clp16+qAfGnuo/g6xIU4xB2S
         7kq9/LLEMVkQhHzGADqYS4TdkMktb7jwpqK78Zpx+Wofk4RrIDtH2waAeFlshOZ86FvA
         h7h230/AacM/2KjLLhz8r4G8Klsw5EbTC8yP9rW5bDBted5G9Y4bylKpAyLUYo3xHeM2
         5vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jmHNFx2euTKRq7bc2bdAa5tKQTNxrNT2PVCZeKGhk0E=;
        b=knpy+9v5gC2v6aXEIHkGYhGplJuw85zdzUOoPX92hG6BjF7doyRD6ruMZQDxSuirUm
         6Cled7TlgPqkXADb7esYAQfyv/cR8KL3eXJkd29f94qhViTgwAJAznQ3oBZ9hk59Mcf2
         Nl2BwFgSU1PHshwXI24lNyoILsS0AzejuPTyaWEVNOFwLqD3XmdxzCIBuacREUUU2QXG
         YnSQYtX26KTnvei0Ppefk20LFOdDQPk9CJ261qWNNo1qDq6isjvxghCHdeHWugN0ha4w
         2ns8xyZ2LpuvSRgP3xCXOI5tVIH5x59coLi7ZWk2udQ1rLdqVNbKaZ9xinKXSEswRiNW
         SBrA==
X-Gm-Message-State: ALyK8tKUFxvwD2INaVySOGOyQqkhDeg0JIKOCn3JJN/hfvPRM2CSo3PCLkZOG1mXPDdBdw==
X-Received: by 10.28.29.146 with SMTP id d140mr5159121wmd.27.1467137997128;
        Tue, 28 Jun 2016 11:19:57 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id yr4sm2061048wjc.18.2016.06.28.11.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jun 2016 11:19:56 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v2 08/10] t0400: add test for external odb write support
Date:	Tue, 28 Jun 2016 20:19:31 +0200
Message-Id: <20160628181933.24620-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.11.g990c140
In-Reply-To: <20160628181933.24620-1-chriscool@tuxfamily.org>
References: <20160628181933.24620-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index 6c6da5c..3c868ca 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -66,4 +66,12 @@ test_expect_success 'helper can add objects to alt repo' '
 	test "$size" -eq "$alt_size"
 '
 
+test_expect_success 'commit adds objects to alt repo' '
+	test_config odb.magic.command "$HELPER" &&
+	test_commit three &&
+	hash3=$(git ls-tree HEAD | grep three.t | cut -f1 | cut -d\  -f3) &&
+	content=$(cd alt-repo && git show "$hash3") &&
+	test "$content" = "three"
+'
+
 test_done
-- 
2.9.0.rc2.11.g990c140

