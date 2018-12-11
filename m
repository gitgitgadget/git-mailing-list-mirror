Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4003320A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 05:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeLKF2P (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 00:28:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42480 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbeLKF2O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 00:28:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so12698893wrx.9
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 21:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2MlkPh/mYiPuNKdmMMvVaifG/cZSWglzGLvJndF72bc=;
        b=lGLjnYuW0BQ/zNDG3sVLdRoISqhGU1NT5AS6AVcfMI4rm0g3e8OgqJ+kDmbtYsuj0T
         Bcb+JcZ9ZVUkforDLiC6dUPcm8DT53L0sQxyl/8nUXDhUPVLaM8gw9UqcPyAI+0WqAS1
         Ru2a9bWJ0bzXrwm4mcVNGkn/tasS+Njse36bBT8gzq3ZFGWjfFld9gq3zj4SJqy25rL4
         BuLvXC6d97McJPRXrHzrNc4ni+Tq8LDU+LwUrH0xaZPfkhKFRDqDSuy3mztzOSik1nN1
         ArZqu1nUc6ydXEeJK/H65Vuoq/5mGcDUVVtiCk7tz+dkvwRoOitfFd5zHmSj4S6XBvej
         xkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2MlkPh/mYiPuNKdmMMvVaifG/cZSWglzGLvJndF72bc=;
        b=rJGD73wq+qnH2YSHur5eOowUc00PXXfPrVnacgYUIyu/eZSbQq733o9xBsBMfCypXU
         umLgvDqIstVhDz8GthydJqEU6VJ7DPUqlu0u91NgOd4KWB9cUCyWIAMwCpDTq4l/pxxB
         wird7GcmAhhPLoXCcgjwrkUbbqSJCDKGOFH0F5qmQJRU4sBnQaUvdmTzZyxC1+Atep9/
         PiEzkroZJLNwxelY9dRgn43qh+U84woGL7IY/3ddoynfeT6x3HJ9Et8jOyypJw01YUQD
         PD989myISXxyEwMJb9czsiqx8EliJ18RieSGRxF2N47DOoqf9qOvXHznaUQsNmb3k6l0
         AnWA==
X-Gm-Message-State: AA+aEWZxNGIZ8wbw/rlIBh539CNahmKYAB5XjrtDaOCf0ZGqBMXGX7Qi
        Qiggs8GH2EA0gCrsL5VLiNv+CK0i
X-Google-Smtp-Source: AFSGD/WIdCUZ5uHX28VRO7Hh/5UZz6J0Ox7cJT3Ch7FL/NOdMk8VF1H7SsUOGnEK4H+VEDGpXmMJuA==
X-Received: by 2002:a05:6000:8a:: with SMTP id m10mr11684790wrx.79.1544506091736;
        Mon, 10 Dec 2018 21:28:11 -0800 (PST)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l197sm3708185wma.44.2018.12.10.21.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 21:28:11 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v1 5/8] promisor-remote: use repository_format_partial_clone
Date:   Tue, 11 Dec 2018 06:27:43 +0100
Message-Id: <20181211052746.16218-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.0.rc2.14.g1379de12fa.dirty
In-Reply-To: <20181211052746.16218-1-chriscool@tuxfamily.org>
References: <20181211052746.16218-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A remote specified using the extensions.partialClone config
option should be considered a promisor remote too.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index ca2b8bf6bb..e4a0625426 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -73,6 +73,11 @@ static void promisor_remote_do_init(int force)
 	initialized = 1;
 
 	git_config(promisor_remote_config, NULL);
+
+	if (repository_format_partial_clone &&
+	    !do_find_promisor_remote(repository_format_partial_clone))
+		promisor_remote_new(repository_format_partial_clone,
+				    strlen(repository_format_partial_clone));
 }
 
 static inline void promisor_remote_init(void)
-- 
2.20.0.rc2.14.g1379de12fa.dirty

