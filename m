Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0FBF20248
	for <e@80x24.org>; Tue, 19 Mar 2019 19:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfCSTD7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 15:03:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36263 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfCSTD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 15:03:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so77855wrd.3
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 12:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=HkPIJ3yLvj5KCd8MPgI6UYz23Hx72UDZ9ZecGFrVWUg=;
        b=onH4Jb8VKx36p9t8dvnmHIhsWv+dFkI2ypDO3t65G8KEBT3Wa7VRxxSoDlw/m3Cg7M
         7Me0YXheIktBlXvIT5bBtJ2kM4jLuCPl9a6EAe9F+GO8W2gHt5O5l/HOQ3bY40RdntsK
         So+5ZOnbxlO/GEldrrID3Aolfp4P0zqwJqvr7Mw2Y2dA9jPiuFhBHPMU9LPZAVgZdjl4
         I++1VXd5XCyjCO5W0Q/uDe8omM4e3n0yhkmvvArK3aDDrVPU1WnWONVoq3icvmG7K2Kx
         kSnVmkr1JqRfA2qiSQxt2DBqpsG6bv+lviNe4sWVXT4ceScNOq9elGL2gjRt1UrHfEN/
         KFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=HkPIJ3yLvj5KCd8MPgI6UYz23Hx72UDZ9ZecGFrVWUg=;
        b=dqWxqSn8O5L2Cdj2Qce8FbeRH5XmegFUEqCmweUL5za14B4LHGCcf+RADJ42vnCeFE
         LITPlwVK87HLr730AuFnkc2HrVH397fc3zpTxj0c0PUdu7YYEnxSP3tpGCFEgv9uFMtS
         /lewHe6Yupoojxf9Htv/HJWvUfc26udzoRI5HmRyMEOrrLahW4Qbwlq3s0M+M/Ol05jn
         dayyVm3W3YE81pCv667kBaEXWia+ir2Q/Md65n7oclbOF14qw6+3/YBJSXrYE5X9u/CM
         kbtLT/s3stZirVCU4gZyI48F1EpBcVhMjGf6rJDYxGvxvCh8KdpT9VravtyveWpSdNmd
         oRDg==
X-Gm-Message-State: APjAAAUbo6vVnTBFs1wyvPyPoCwjIhMobcwCrOgo00aBcTOshelLEWF2
        /yWTlAAcXv0t+wOpWAtmEKgaRlNddhI=
X-Google-Smtp-Source: APXvYqzliyWQezC6zfrF0eREnnbBuQGaYTtDmseWe7uybbnrEKfUgzKwxaivzE5VLQkW1PP2fBclGg==
X-Received: by 2002:a5d:468d:: with SMTP id u13mr18172772wrq.132.1553022237344;
        Tue, 19 Mar 2019 12:03:57 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.gmail.com with ESMTPSA id s187sm6253853wms.7.2019.03.19.12.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 12:03:56 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 02/11] rebase: rename write_basic_state()
Date:   Tue, 19 Mar 2019 19:03:08 +0000
Message-Id: <20190319190317.6632-3-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319190317.6632-1-phillip.wood123@gmail.com>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This clashes with a function in sequencer.c

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 52114cbf0d..b634879c5b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -245,7 +245,7 @@ static int read_basic_state(struct rebase_options *opts)
 	return 0;
 }
 
-static int write_basic_state(struct rebase_options *opts)
+static int rebase_write_basic_state(struct rebase_options *opts)
 {
 	write_file(state_dir_path("head-name", opts), "%s",
 		   opts->head_name ? opts->head_name : "detached HEAD");
@@ -640,7 +640,7 @@ static int run_am(struct rebase_options *opts)
 	}
 
 	if (is_directory(opts->state_dir))
-		write_basic_state(opts);
+		rebase_write_basic_state(opts);
 
 	return status;
 }
-- 
2.21.0

