Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A06C04FDF
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 14:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343598AbjHPO0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 10:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343635AbjHPO0G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 10:26:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A508C2716
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 07:26:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe0eb0ca75so9984443e87.2
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692195963; x=1692800763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK6ktpUgeEo11cTEM2EhwhawnVVGaAVI0JE3GVrarXI=;
        b=DqUKToS9MUjjdpqp2sg3YFwKT/GoosgjmXSr1xIuxM4cOoJ+tZB8JVuESXoXUv5S/a
         LnbZzysm0iM5IcymDZIi55InQrOrUiauyI/cbpfJ7++HXrWERwSfYyfmRRwdEM6+EzKu
         Dt78BkL0wOsTJUAvI0zUcmSiN8NmEM3UJ8qGgfM5fQN5h6s0nyDpzhGymaWDO51+L96w
         iiOIp6yTCM5Pmq8Fe/iJ+LVArVoVEWRkFqN+rK63M4OVJjXnJtZJouZKC2aZTCtEdyU1
         0LcEKphEU0cH3jG/1dsN67oeUKut8ZNdnuoutxoTGW1dNSNHejsYNwcaSULVz1zatESK
         b1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692195963; x=1692800763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XK6ktpUgeEo11cTEM2EhwhawnVVGaAVI0JE3GVrarXI=;
        b=gC3dwd/pb0T4dDAsZL8iOYiOjEqKMjfsWFmzO8nMf7KQXTYCNWEHIbmXdcmZcsqXN2
         wFe6rXqORg1O/YRLht5NW5RQPAksMVZ+g7RcXPzP9uykyfZPVwM01HiqZz15RFlTzxbJ
         sH8DTA1Wxhii6+onQbI4KEu/mgmybQHdUov4GKxIMqmGJOzRFnrKxD6gLOKJa15NI6tG
         LD0KkSBQU822AigK0pU81Wsrj4eHaHVcvZDDW08vUQdrf8E5fB/Iccu950BvamJ0gfCf
         v7QjNQK5x+rC48Jer0yeBukguAU/FE1S4mfxx04syg+IHKMNtKagYrXQruRdeELVOYoQ
         U4Bg==
X-Gm-Message-State: AOJu0YzrDLROgtokCQiTHMxBNXjpB/wkKm6nT2w1CfL0CXiEa+UgaXP9
        Z78aO9oD+yRwAwDeUNexHU7MRWOdgr8=
X-Google-Smtp-Source: AGHT+IEo4KZ3mImPHaKxouIFN8va4JOhH/dbVWrWjYS/fbz6AQ2avZfnfGB4CzbOvdfRQEDMD4jdYg==
X-Received: by 2002:a05:6512:224a:b0:4ff:7e04:7575 with SMTP id i10-20020a056512224a00b004ff7e047575mr1756922lfu.14.1692195963261;
        Wed, 16 Aug 2023 07:26:03 -0700 (PDT)
Received: from localhost.localdomain (78-67-21-133-no600.tbcn.telia.com. [78.67.21.133])
        by smtp.gmail.com with ESMTPSA id c18-20020a05651221b200b004fe1c9ce61bsm2927925lft.116.2023.08.16.07.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:26:02 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 4/4] rev-list-options: fix typo in `--stdin` documentation
Date:   Wed, 16 Aug 2023 16:24:36 +0200
Message-ID: <b1b3f1d10b64e63c62db0105957a4ad5e0295d34.1692194193.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.42.0.rc2.215.g538df5cf27
In-Reply-To: <cover.1692194193.git.martin.agren@gmail.com>
References: <cover.1692194193.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With `--stdin`, we read *from* standard input, not *for*.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/rev-list-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index e6468bf0eb..a4a0cb93b2 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -237,7 +237,7 @@ endif::git-rev-list[]
 
 --stdin::
 	In addition to getting arguments from the command line, read
-	them for standard input as well. This accepts commits and
+	them from standard input as well. This accepts commits and
 	pseudo-options like `--all` and `--glob=`. When a `--` separator
 	is seen, the following input is treated as paths and used to
 	limit the result.
-- 
2.42.0.rc2.215.g538df5cf27

