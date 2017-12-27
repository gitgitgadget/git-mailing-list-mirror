Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39811F404
	for <e@80x24.org>; Wed, 27 Dec 2017 23:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752983AbdL0XA4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 18:00:56 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:41470 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbdL0XAy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 18:00:54 -0500
Received: by mail-wm0-f65.google.com with SMTP id g75so41700465wme.0
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 15:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GSZTsA8uVefJRrY9p0UJDsVkcebYrqOzrX93nny8SmE=;
        b=l/4QIrMfNNBS+8M3IfWSVyuwQRmL86JCSFwTZ8Ks4GwCJMDDgLW8xRkyeZby/iFgU7
         JvzUF3QG4BReAmYdj541lJSQftBPlsVIvFC7UMV32WR1yGtDsyMsKwQrFsykpKEYki6W
         sqf0GW3/jns5TD0YlEWtzUu83cA7LgjhkYZyYFycgVovcNFfGcMLUcbTQ5QG58sXK0vT
         OSi/pZ7AxRouL5uKFsB4hOlRcNl8BUh1UpmtxUQg9q1PjNQbmrJ1FEudDKJQ0wyVr+oc
         jTFRJpyFS2de8sKJy/lJhZ1DhQIbX/admLnA+zP8sJeeWiTcgF9CKEsomG3jj1a1kkyh
         zKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GSZTsA8uVefJRrY9p0UJDsVkcebYrqOzrX93nny8SmE=;
        b=mx0iBWGokq4ryxxmNuBa1blBbn8pQbmlnnQ1wfu9/8kKpFHWjJFXbElTHsXayHL8uM
         Bz+LdFaSxLl+1TjuU2advVie5/iW81SktOT/3bvqq96B4dfYP6Z9FkTA5PwPOZYodlIb
         IiObmbfHD0qsEHvntH9SYHaHcYpnyyJoGZWvoTAIdyWPyaMLUXD1ZCOmb4bmfRsEMWwS
         W/BmPR18JTLeoCIbA8xEgobvJtThQpSfAHeqIMO/HKGMng9hVXKC8GxhhwpXOQIL2T34
         nNK8mkP2IRYUBigLOPsl9zYuB2nGep2I4kRxjbF1rCs1YO+200vIn40XaZ/D5IuKZuM0
         HHyQ==
X-Gm-Message-State: AKGB3mIIEdY8dlS5vvEMx5ogY71eFTp66ehj2KSwgb2xXZuAXlFHyAnq
        dmfEemgPhFP+S1kARyfrIrhBmg3E
X-Google-Smtp-Source: ACJfBov9+z7CFiBKInELWV1t+mF1kb6om9YepBolTdC0XQ3sVOhXL/y153+/0d2MwRluVDgrPham+A==
X-Received: by 10.28.154.70 with SMTP id c67mr23106801wme.142.1514415652348;
        Wed, 27 Dec 2017 15:00:52 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k61sm21467411wrc.84.2017.12.27.15.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 15:00:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] Windows: stop supplying BLK_SHA1=YesPlease by default
Date:   Wed, 27 Dec 2017 23:00:38 +0000
Message-Id: <20171227230038.14386-3-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171227230038.14386-1-avarab@gmail.com>
References: <20171227230038.14386-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using BLK_SHA1 in lieu of the OpenSSL routines was done in [1], but
since DC_SHA1 is now the default for git in general it makes sense for
Windows to use that too, this looks like something that was missed
back in [2].

As noted in [3] OpenSSL has a performance benefit compared to BLK_SHA1
on MinGW, so perhaps that and the Windows default should be changed
around again, but that's a topic for another series, it seems clear
that this specific flag is nobody's explicit intention.

1. 9bccfcdbff ("Windows: use BLK_SHA1 again", 2009-10-22)

2. e6b07da278 ("Makefile: make DC_SHA1 the default", 2017-03-17)

3. 2cfc70f0de ("mingw: use OpenSSL's SHA-1 routines", 2017-02-09)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 685a80d138..6a862abd35 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -361,7 +361,6 @@ ifeq ($(uname_S),Windows)
 	NO_REGEX = YesPlease
 	NO_GETTEXT = YesPlease
 	NO_PYTHON = YesPlease
-	BLK_SHA1 = YesPlease
 	ETAGS_TARGET = ETAGS
 	NO_INET_PTON = YesPlease
 	NO_INET_NTOP = YesPlease
-- 
2.15.1.424.g9478a66081

