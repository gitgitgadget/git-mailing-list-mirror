Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DE182035F
	for <e@80x24.org>; Thu, 10 Nov 2016 11:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754796AbcKJLNy (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 06:13:54 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35687 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752186AbcKJLNx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 06:13:53 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so2416300wme.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 03:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/4WneFHIc4uHkJx6QC5qRiE2FUNcO5j47H/BpYfhwd4=;
        b=oQ1ef9dB+MDRFCPGEIl2b3v9tRYLPTj1b5a5BMmMtva646G/y6OWtC2nkv2G+0gNP8
         h1KCqHv1ppQjl1CERi1iu7kTX1EjVY8oruAdn60Do8tmVW8NKMLjbqAbNtFggsBh7+k5
         Rd6mrRIqqGw00OrKnJGPv0kcYwGTUlCMEJsUbwsiuEW/maMqHNg5IJ2E7yTp5NGYYsma
         8RZKe17GIYC/25e8OJEBOsdTLaIJnDMrPCJYdnikj9zQ9Ou2eO9El7w0W+CdDkpi0ukI
         YdVNeoBt1GShgQg4OibZveozQ3IUB2dL4K9M61zENlBL6aSBBpflywsTX9mqfEkBVekE
         9h9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/4WneFHIc4uHkJx6QC5qRiE2FUNcO5j47H/BpYfhwd4=;
        b=Pg4Z1bD68dtDZFCDI5Ln/xbREOHYUa+QMPahfkHcCbPiX6b/ZK4x0T+EyEN+0A2VwN
         +b0Z2+MdEBiO1jcFaqecJUhjerInAQ56WGs9dWWL+kDHToWIEB32azDXDW+vRA/CBTj5
         AbnFivlqKc8KDRU+dHiB/KkgJLG6xbl5c1nNHtrEJT8kmr98mbD9UKv/QALcpE7qYk/p
         gQ4wVjbJhDp+89O5b0lH7UlikhAH38xWe+lesRVttY2itymvdrNHtCuo1rCw6Gp13fTv
         27iTjK4sXtemvi/A1z5nNA4AzUN8J2UNS7tunkRSk9GGBryi0/GM8LnOgPfXJ0lw3Wo7
         PN1Q==
X-Gm-Message-State: ABUngvcltY8RgWebp1ZtfuZExop3ku6eKx5kYx1mgqPo+aYGS1BFvw7uiTErBrNWrC4zcw==
X-Received: by 10.28.154.86 with SMTP id c83mr24732514wme.23.1478776432347;
        Thu, 10 Nov 2016 03:13:52 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id d17sm2599395wjr.14.2016.11.10.03.13.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 03:13:51 -0800 (PST)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, tboegi@web.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v2] Makefile: set NO_OPENSSL on macOS by default
Date:   Thu, 10 Nov 2016 12:13:48 +0100
Message-Id: <20161110111348.61580-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <1fdc5333-79a8-7c1d-f7e5-e8150d0ad9cc@web.de>
References: <1fdc5333-79a8-7c1d-f7e5-e8150d0ad9cc@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Apple removed the OpenSSL header files in macOS 10.11 and above. OpenSSL
was deprecated since macOS 10.7.

Set `NO_OPENSSL` and `APPLE_COMMON_CRYPTO` to `YesPlease` as default for
macOS. It is possible to override this and use OpenSSL by defining
`NO_APPLE_COMMON_CRYPTO`.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 9d6c245..f53fcc9 100644
--- a/Makefile
+++ b/Makefile
@@ -1047,6 +1047,7 @@ ifeq ($(uname_S),Darwin)
 		endif
 	endif
 	ifndef NO_APPLE_COMMON_CRYPTO
+		NO_OPENSSL = YesPlease
 		APPLE_COMMON_CRYPTO = YesPlease
 		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
 	endif
-- 
2.10.2

