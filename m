Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324AA200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 19:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933126AbcL0Tg0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 14:36:26 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33618 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933094AbcL0TgW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 14:36:22 -0500
Received: by mail-pf0-f178.google.com with SMTP id d2so55864304pfd.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 11:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=seeGlQD+h7howXThjETs9aJWyydJd3eqToMgMCuwNM8=;
        b=ey+p2yz8Rma66G/YVZ/jfSmpGcW3fR+sKHrYeizAlDtMy7PdOzhX+Cg1CODJMm7Rt3
         H/DbiUuj1wKfSjQol5n7Pet/Y9LuF2f9vhIMNUrqE+GB7sUAcTDSfTj14KbdzJyA4dQY
         NSa0c+sko2BiaCpzQVxHhHJiz8CPfC308f8zm8MSIAIToLM54/14UDfK8aBdrXQ2/SO2
         3n2EIixP5osULtVAVMGclyRTOJ4d0SZ8idEvPJibZ5IsuwKWH3vDa1GA3rnuTajr3Tns
         gTbprPt8+Ko5XXMBZG6GYV/7GeWAsVS+P0w2v/Di3hV/k/KZS388sLBu6tPpSZ/DfZyE
         CGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=seeGlQD+h7howXThjETs9aJWyydJd3eqToMgMCuwNM8=;
        b=lcBi7QCE1z+tYU24xVAUYOZWj4ju41ZDbQti+d5zqj5QOtBEKJvXtsmWOWK5dvg/ne
         G88dTQITSF2XIwsB3KxIGa01b1P5SWyFLDzDalQK+s2Bt9uLDioRjXBolkNOtINbib1M
         /XPdXEHC+ek8/XXpjXFXM38OTFXM6XuWU8n88cicyXYXe8o6QgZB3tddsdFOLhY05TsP
         HBLYLgv8PeguaEvXkdrcQdNXXXmewUplB0IyCcfvZyUJKXBRpOPMR29Dpv0Fq0uZ2IV3
         dht29RKdyU2B1wYPe4Xlh+d1+dst4ItV6rw3fcBQhKYJ/QScYNi30lxoH45SSz3+7M+5
         uROw==
X-Gm-Message-State: AIkVDXKryUMgZxiVFUoKBAbcR8bBZCl9himYSm/5co8oZOtMjpcZw4WHRc75j+R0dgQWRVcC
X-Received: by 10.84.131.65 with SMTP id 59mr68625221pld.79.1482867381269;
        Tue, 27 Dec 2016 11:36:21 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1aa:810:98b9:be05])
        by smtp.gmail.com with ESMTPSA id d1sm91384213pfb.76.2016.12.27.11.36.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Dec 2016 11:36:20 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] t7411: test lookup of uninitialized submodules
Date:   Tue, 27 Dec 2016 11:36:05 -0800
Message-Id: <20161227193605.12413-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.50.g8bda6b2.dirty
In-Reply-To: <20161227193605.12413-1-sbeller@google.com>
References: <20161227193605.12413-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes we need to lookup information of uninitialized submodules. Make
sure that works.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7411-submodule-config.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 3646f28b40..b40df6a4c1 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -126,6 +126,27 @@ test_expect_success 'reading of local configuration' '
 	)
 '
 
+cat >super/expect_url <<EOF
+Submodule url: '../submodule' for path 'b'
+Submodule url: 'git@somewhere.else.net:submodule.git' for path 'submodule'
+EOF
+
+test_expect_success 'reading of local configuration for uninitialized submodules' '
+	(
+		cd super &&
+		git submodule deinit -f b &&
+		old_submodule=$(git config submodule.submodule.url) &&
+		git config submodule.submodule.url git@somewhere.else.net:submodule.git &&
+		test-submodule-config --url \
+			"" b \
+			"" submodule \
+				>actual &&
+		test_cmp expect_url actual &&
+		git config submodule.submodule.url "$old_submodule" &&
+		git submodule init b
+	)
+'
+
 cat >super/expect_fetchrecurse_die.err <<EOF
 fatal: bad submodule.submodule.fetchrecursesubmodules argument: blabla
 EOF
-- 
2.11.0.rc2.50.g8bda6b2.dirty

