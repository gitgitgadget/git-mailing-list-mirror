Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D201F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390372AbfJRWKe (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:10:34 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:42006 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390334AbfJRWKd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:10:33 -0400
Received: by mail-pg1-f182.google.com with SMTP id f14so4067777pgi.9
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YktZpmrJifjA99PNTOVnRtSLaAx+iks0dLQmMQ/JKCw=;
        b=ABIZ3UDOrnViUxVX8Mfyu6RJjUOMeKU0AKOT8BVpzSU7xk0XAvOkQwSdYZXtaUC2Cs
         aBWZOdgJ/Kc/RjC30nA402HU1KHcd0q6uP3MqDYpGEDvphXPf//N92n2fzRzbZZvAkSD
         r0tFVnyAxgFzOAvzsZ+T+GaIQk6wEhNBoPDk59Cx5a7kz0/24vvkVswX9q2hpTL9GNO9
         /owVslqtndjD7OjyfC0A5MBKP23xfiTfDfb3r2xT1WMmkXcYpUpOZPIj1JDud39neB+N
         ce23BFFIJ3Im/LkzQXZaKs28YGJmwweOkG4ikC/XtnziFfDpSAfKGIe6JMxXNK3xQGBe
         gWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YktZpmrJifjA99PNTOVnRtSLaAx+iks0dLQmMQ/JKCw=;
        b=EXD/MjOypRqi/1+bLj4P0+hdWs+/tOZUSgbx3Yktbm1LlPYtji9skFa+CXOtHHmq77
         HdcryuBqHjatIs6+SdMOrwWSxSQ4Suat9pg3N9Qd6bDwmmvDR1W8mRcyA0oI+8bU4ITc
         hgd1JXZyKfNqXqZFa1QR1cC2wTh/jnsAmLBIlFPFlFOdlJkyHQuRCtG2sOINLYqQhgEg
         6EaeJiAUGytTJ69v+4UR70jB8lyRaoC5jDaQMHLrkJgGyzLWPOS7YOtwA6GjZ/JRAUGI
         mFRV2Ljd0xlkwmgdJEA+1zEA7scrU44ZzqVqasuyR7nbfKSUy1T2J1f10JqZAAQF3V9r
         TJQA==
X-Gm-Message-State: APjAAAXTFYUfO4SHm08tQTWCbujOC9YmeETQAGXqV6TuZE5iEUlLdsWa
        GpgDima9S/vNyCz1y+uDJHAAhHzh
X-Google-Smtp-Source: APXvYqxMiJ2mSLCGYcezMf6n/2r/m7FDljkiaziZwQIZvJKg9B9HChovdDrjuHfHhQeri6OEW6f8mw==
X-Received: by 2002:aa7:86d6:: with SMTP id h22mr9313371pfo.72.1571436632231;
        Fri, 18 Oct 2019 15:10:32 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id n66sm11601022pfn.90.2019.10.18.15.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:10:31 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:10:29 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 05/15] t5520: let sed open its own input
Message-ID: <9fac3dff833624c458cd0bf14d811ea49ac1ee30.1571435195.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <cover.1571435195.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571435195.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We were using a redirection operator to feed input into sed. However,
since sed is capable of opening its own files, make sed open its own
files instead of redirecting input into it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index a3de2e19b6..55560ce3cd 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -5,7 +5,7 @@ test_description='pulling into void'
 . ./test-lib.sh
 
 modify () {
-	sed -e "$1" <"$2" >"$2.x" &&
+	sed -e "$1" "$2" >"$2.x" &&
 	mv "$2.x" "$2"
 }
 
-- 
2.23.0.897.g0a19638b1e

