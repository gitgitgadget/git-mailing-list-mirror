Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92345C32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 22:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616102465A
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 22:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgcOswhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgAOW5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:57:38 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:46145 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbgAOW5h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 17:57:37 -0500
Received: by mail-wr1-f50.google.com with SMTP id z7so17275749wrl.13
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 14:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+nrj59oODCzegsPDvtBBHxcbmd6VQXjuJw/VszIVhuU=;
        b=jgcOswhELrKe1MbkDiZY3gDy76IIC/CclhAT1JqkPqZG7a2WVksGJZvCR2vq6OP3WV
         W7jMISLX2stmA9iptgM2KLFvZrXAtExMh4HOjYrh3K84brN6ZfaP1zZgLJOmWjMiJ0ip
         X6aHKH4IIppv7B/C05GG81y/92ZJ2vpGZP/vCay/VwMw08/5+XxSVrrsDHOAGSBZ7IWv
         YH4rPdBTqTP66kznpVEsq3TeIgD5aIqL84VC5u4MlzXQAlu+B7j4/93RtOQy6Ltbh1RV
         pcTh7QXkQXPVlNfg/tJ920stKprZybu2YnVGoVrK8OnQ6BLC6S0IoBBfB/9ND/NJDHz7
         wg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+nrj59oODCzegsPDvtBBHxcbmd6VQXjuJw/VszIVhuU=;
        b=T5z+kmSJ+CMcWOndPySiNFgfTHoMNsvUTJnMQin61RifPjdbRiNvABXLjAI5RFDLLa
         8JDbBDVF7kKiiCz4rZTLLAHw26aaUHajlz0Tn5hugjvzjUo1jjHeCz64dlclPn74H/C8
         gWY9LzNnWrbd1QRlPnOL/aLk4S+qZAP/I9hNJllIXFbOx9zAXgPwcm2Kc/LVBorqognD
         bAKQQ6VIFCaOfxSL8jh0hocc8/I17d5GuFYLFfGtVodIgsoZJ3OH3Y/6iDFVns3gUJv/
         aAmXOee9YgoICOt5r3Nc76vseRnNsoEsldPdcMsY6MSJs7SkzyrLnpgkmZKjj54NSN7E
         V3mQ==
X-Gm-Message-State: APjAAAUp002u+vMjsIf6aAODwd0XaV7YItHXOZ0T1lRCUGGgeyotgvkM
        F5QkrovHWJmCtKSd0Tv6rVOp1mpo
X-Google-Smtp-Source: APXvYqxFEanmi5w/7rAuI2xMaGHs/zums4jvva1knKstCSjYrlHofO/ruUNzBo59JHTWBHKaQfJe6g==
X-Received: by 2002:adf:b193:: with SMTP id q19mr33672136wra.78.1579129055427;
        Wed, 15 Jan 2020 14:57:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s15sm24467885wrp.4.2020.01.15.14.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 14:57:34 -0800 (PST)
Message-Id: <pull.527.git.1579129054234.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jan 2020 22:57:34 +0000
Subject: [PATCH] msvc: accommodate for vcpkg's upgrade to OpenSSL v1.1.x
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With the upgrade, the library names changed from libeay32/ssleay32 to
libcrypto/libssl.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    msvc: accommodate for vcpkg's upgrade to OpenSSL v1.1.x
    
    It was reported [https://github.com/git-for-windows/git/issues/2474] 
    that the vcpkg project (which we use for MSVC/Visual Studio builds of
    Git) upgraded [https://github.com/microsoft/vcpkg/pull/8566] OpenSSL
    from v1.0.x to v1.1.x, including the change of the library names. We
    need to adjust for that.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-527%2Fdscho%2Fvcpkg-upgraded-to-openssl-v1.1.x-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-527/dscho/vcpkg-upgraded-to-openssl-v1.1.x-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/527

 compat/vcbuild/scripts/clink.pl | 4 ++--
 contrib/buildsystems/engine.pl  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index ec95a3b2d0..d9f71b7cbb 100755
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -45,9 +45,9 @@
 	} elsif ("$arg" eq "-liconv") {
 		push(@args, "libiconv.lib");
 	} elsif ("$arg" eq "-lcrypto") {
-		push(@args, "libeay32.lib");
+		push(@args, "libcrypto.lib");
 	} elsif ("$arg" eq "-lssl") {
-		push(@args, "ssleay32.lib");
+		push(@args, "libssl.lib");
 	} elsif ("$arg" eq "-lcurl") {
 		my $lib = "";
 		# Newer vcpkg definitions call this libcurl_imp.lib; Do we
diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index fba8a3f056..070978506a 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -343,9 +343,9 @@ sub handleLinkLine
         } elsif ("$part" eq "-lz") {
             push(@libs, "zlib.lib");
         } elsif ("$part" eq "-lcrypto") {
-            push(@libs, "libeay32.lib");
+            push(@libs, "libcrypto.lib");
         } elsif ("$part" eq "-lssl") {
-            push(@libs, "ssleay32.lib");
+            push(@libs, "libssl.lib");
         } elsif ("$part" eq "-lcurl") {
             push(@libs, "libcurl.lib");
         } elsif ("$part" eq "-lexpat") {

base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
-- 
gitgitgadget
