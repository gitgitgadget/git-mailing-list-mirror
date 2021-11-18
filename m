Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5B8C433FE
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 10:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B10060F51
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 10:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245581AbhKRKib (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 05:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245334AbhKRKiG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 05:38:06 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81B2C061764
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 02:35:06 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id b4so4932614pgh.10
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 02:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VOynQIdaBuKUA6E4eeBBiJCLpFY5vFyk1BTzzCreSsg=;
        b=C6uzPAVKf2eEdYeRQPvubnTcF7AQmKzOAa8VKciy+HpMUAR8d2Bw6DM+aOEs29Cwcm
         Y9YeULeh+U4O6rVB4KX7vsVgaqIgJG7ymWcJRLpL19ds/IfoCT/nXLwNw1be9YI2wMHv
         2l6UBuxV1O+FvbvozZUe0Jhe0wnM76UDCkXmFtX1KklPoCvu6zKSp5lgqEcPaz5IZbG8
         S+uhMcXkMNopIUAB/RJJRQNqsT1nl292fDZxEYr0DmvaU9DkKh4MEjUBl3gF6Z3CKATE
         mzfYHYa0J3GxkjuibmgWWwyZlinzUjOxkOMUuHEq4KTuJdMOhnlq55ldVkw5A5emzly5
         741A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VOynQIdaBuKUA6E4eeBBiJCLpFY5vFyk1BTzzCreSsg=;
        b=GiLQRDXnjHZmRgR5+chSfPYImUqhM9GFFTy1lMDxYBj1A+eTGaZUOQcMXQCPjCSNcO
         +qejfK1pt1qiYrm7wH9gK2929vj7LbvI9ppnXZq7ju0hPaxr2AxiLaZ8vs+b/qeAEUMt
         mSnhFcQU8qxuo6XIh2x5mog3q4ZvBnnAknbAfAntez1UWpQGy3QO24ze7mZnnslPzPi5
         Y/MNoW17hmHUcjLRcRiHFu/DevTmwgLoT3ii+4csBdFHe6F4tRVmZtFvIEmiUnlG2VWz
         tAZgb1Hn7OPxyzRQWT4Bbw5wUpEXys4wSft6i+auWNNOxhzi+r0qfjZM6nGEUEkyltRb
         mGaw==
X-Gm-Message-State: AOAM532m5bmwzLKPdl6vQIRgCNuX7A3N8XAZxz8uChin5EgBQM2Tn5tx
        EH22yswy2vfaxvihXpTEnLlaXNGo+do=
X-Google-Smtp-Source: ABdhPJxhGiPXPPN6lkbNKPCukqZlhogaUqc0PIZv0Dz3cyvZ3q4xrKjRviMdkWd1z7wAalmGF76CqA==
X-Received: by 2002:a05:6a00:1a8d:b0:49f:de63:d9c0 with SMTP id e13-20020a056a001a8d00b0049fde63d9c0mr54266450pfv.79.1637231706211;
        Thu, 18 Nov 2021 02:35:06 -0800 (PST)
Received: from ubuntu.mate (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id k13sm2945707pfc.197.2021.11.18.02.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 02:35:05 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] fetch-pack: parameterize message containing 'ready' keyword
Date:   Thu, 18 Nov 2021 17:34:25 +0700
Message-Id: <20211118103424.6464-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The protocol keyword 'ready' isn't meant for translation. Pass it as
parameter instead of spell it in die() message (and potentially confuse
translators).

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes since v1 [1]:
   - Parameterize message (suggested by Ævar)

 [1]:
https://lore.kernel.org/git/20211114073143.84004-1-bagasdotme@gmail.com/T/#u
 fetch-pack.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a9604f35a3..b8a20778bb 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1410,9 +1410,13 @@ static int process_ack(struct fetch_negotiator *negotiator,
 	 * otherwise.
 	 */
 	if (*received_ready && reader->status != PACKET_READ_DELIM)
-		die(_("expected packfile to be sent after 'ready'"));
+		/* TRANSLATORS: The parameter will be 'ready', a protocol
+		 * keyword */
+		die(_("expected packfile to be sent after '%s"), "ready");
 	if (!*received_ready && reader->status != PACKET_READ_FLUSH)
-		die(_("expected no other sections to be sent after no 'ready'"));
+		/* TRANSLATORS: The parameter will be 'ready', a protocol
+		 * keyword */
+		die(_("expected no other sections to be sent after no '%s"), "ready");
 
 	return 0;
 }

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
An old man doll... just what I always wanted! - Clara

