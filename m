Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F21D209B4
	for <e@80x24.org>; Sat, 10 Dec 2016 03:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbcLJDVu (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 22:21:50 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35575 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbcLJDVt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 22:21:49 -0500
Received: by mail-pg0-f68.google.com with SMTP id p66so4099614pga.2
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 19:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kjawuoMy28Coks2tkaSYLEGwFW4CYOd5b4tsE5ClwW8=;
        b=qS9alSDaq2jt9pTEMWCwg7QqMgWDCWoejmIxSjFiAwhj1DRSLwF0MNJAihJ0/gS/Mw
         Wnsu8FxHnDtfjj3HBn/pAKIlQoXwJd/BhN83U4oIytdiHcmnrpwTtZjzkRTYmfx3xBkn
         z9S0JVVlOtfWZs85iKg3xaftA7ICuNPw6cY8Dl0AccE7/t+wA6KaULUzpPQzAQlbHGEW
         agAj/3y87UgpNnDXH4BfGsDH2TmeqP7YGnOcYLlLi3HlZzvGDsnLfpgcyL10s5+gvllq
         7E5tXt/EZyuLKO77CECddFM/VFzBXEtXUjGGpbzOaVOr6XRy9evjTZHqoYRlRqZcNXH2
         DrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kjawuoMy28Coks2tkaSYLEGwFW4CYOd5b4tsE5ClwW8=;
        b=QZWKcpB8ObYSPAslReV3XkC5i/Dv3/VTVwaHswXFy5dXRR1+J/M615ovBNeBhMsdfr
         A9ZJJbrrtN5aYNAxnoxCDN6m3zQMPzOMV74OIReFNbQnawTboO/x8NzeGcjR8bPqMD6c
         KRX7QMjImeX8FXzyFO9zZuU78C9MmCDax1C+O8sUJVbzYtvB870nZWjCAQVR0F4ubPPn
         eP7ermrMi10AIH0qrjedBL8lPoJ7XrO9xVR3vjH4otuJyGuwdqFQ3fFtjaKTHzcV6bQc
         b1ClSCHObwr6pUJE/9hzDrkr1KhxS3wxUKo9YxPyDyGojnXh16VvfSCVyW0sV4HhuhT2
         1N8A==
X-Gm-Message-State: AKaTC03Ofn19PsEuZOS9KrnpvzjIuJ2mj/hAYNM6ZyM0S1a0fMK2+BdDt5eVgwnw2RQP/Q==
X-Received: by 10.98.156.17 with SMTP id f17mr86092545pfe.63.1481340108940;
        Fri, 09 Dec 2016 19:21:48 -0800 (PST)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id t193sm60916877pgb.4.2016.12.09.19.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2016 19:21:47 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: [PATCH 1/2] mergetools/kompare: simplify can_merge() by using "false"
Date:   Fri,  9 Dec 2016 19:21:43 -0800
Message-Id: <20161210032144.25503-1-davvid@gmail.com>
X-Mailer: git-send-email 2.11.0.27.gdeff8c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This patch builds upon da/mergetool-trust-exit-code

 mergetools/kompare | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mergetools/kompare b/mergetools/kompare
index e8c0bfa678..321022500b 100644
--- a/mergetools/kompare
+++ b/mergetools/kompare
@@ -1,5 +1,5 @@
 can_merge () {
-	return 1
+	false
 }
 
 diff_cmd () {
-- 
2.11.0.27.gdeff8c7

