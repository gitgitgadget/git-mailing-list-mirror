Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68A481F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753691AbeAaLHS (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:07:18 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42712 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753566AbeAaLHR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:07:17 -0500
Received: by mail-pg0-f65.google.com with SMTP id j16so8360835pgn.9
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=08xCJXstPp/6RUIwJcNT6ythTRM9TGF/HZdOGoHPlEE=;
        b=TOb4kmMgSjeO0ePIdkDKmLav9IUYIIwSEid5w3Keuf0HHHDDM3aGMM1xf0tKqdYXzj
         r5Ck8VcTf6aTUZPk9v9+cZDGO1A1lHB9bc0W9AM3ddJnCgNyyxZbntr62VV6ISQY6BBU
         YE+aLZRSVbh5Sb62BlmXGXY/gLwx9tW2T1NPjMpTDyO89IzJBa4rRIz1Yyg9e4jJ0dTg
         oZNQmwZpT/L8/+J4gQiTscL3O18AW+ZR1xthyytPYIoLtwNnp4LWoQj7pOZhr0c85WV9
         hp8UaigfOPQU0rTOXw3k15uTh7272V5o/6iUoS8mi2cwbJjVcYXe34JtenT/Sfg20Zy6
         K+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=08xCJXstPp/6RUIwJcNT6ythTRM9TGF/HZdOGoHPlEE=;
        b=kikq5dI+apuK4NyIN9tAMjzQiAcD2quKuBYx9DVnV+M8E7iINpCPP3oNGkFQkzmed/
         239ew/ov6UjknmbS2u8vNTBWmByCYgFIwWNkAYsov9bbKBb5IDBWBXqCRfgW23g1jxDB
         SiVwfYa/+05kbb5wpJSL0+F2lEJSQYeiFP6tRzAN1A2JHb4TPdtWF8ElgsLLdltG3Uxu
         IWzlLGa/DPwAq6PvORk5lBbm7nyzvzV7/LBztQoYJfkp2MKoGbjELIrSFYgoqic4m5q/
         aoN2m2BAH4AnD5yru34SKb4EPXbBe2AJALCzrkYZC4dXbK70Hgr9s9+X0xdXXIXjmerc
         sGQw==
X-Gm-Message-State: AKwxytckZVxrNQ8vtnDQ1OK1NYY5y3YjzKR/U/2wEaTNNvBm/QK28AUY
        nok+60iyg2trPB379W1Rh4lOoA==
X-Google-Smtp-Source: AH8x224Ha5/0iDddo2PwcELpxCUmJI0s5TIQx4ooab3ISrrhhVQgONGijs/MfTejYMEIFj2H94uFig==
X-Received: by 10.101.93.142 with SMTP id f14mr19759941pgt.82.1517396836806;
        Wed, 31 Jan 2018 03:07:16 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id z128sm42868007pfb.36.2018.01.31.03.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:07:16 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:07:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 17/41] completion: use __gitcomp_builtin in _git_fetch
Date:   Wed, 31 Jan 2018 18:05:23 +0700
Message-Id: <20180131110547.20577-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

New completable options:

--deepen=
--ipv4
--ipv6
--jobs=
--multiple
--progress
--refmap=
--shallow-exclude=
--shallow-since=
--update-head-ok

Since _git_pull() needs fetch options too, $__git_fetch_options
remains. This variable will soon be gone after _git_pull() is updated.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 255d60f12d..316dac84e0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1448,7 +1448,7 @@ _git_fetch ()
 		return
 		;;
 	--*)
-		__gitcomp "$__git_fetch_options"
+		__gitcomp_builtin fetch "--no-tags"
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

