Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EDC4200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932386AbcLZKXZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:23:25 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:34709 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755443AbcLZKWo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:44 -0500
Received: by mail-wj0-f196.google.com with SMTP id qs7so10343126wjc.1
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4sqGRx7LPlz9+S0uXua5iISQtfpSpblxJRJ/HYIvQKs=;
        b=kCynrXA/IxgUUTeUdBQeGKXstPX/7kbmsZnKWcm/X2KbH0FMD/kvDDcEJhKJyu9vhn
         +VvaEYyTYeykAjCKNhkNoM4i2oT/3wJKtJD8TRumtfHohYWre9ad5QbKVh7JCRc5Pbao
         9WzZEaBmpR6pWc1JfPqqCCEVF2PvLx7FpjOzFDOu8uSDeYX2ed6i6WWMMyJk/JKAA+W6
         eBk8ROgFMzdPa1NRi80v2PHsnkb05KEBS/uMrz9dPn3BLbbgGDoxAHvL31x0voGIqQTh
         XrZqR03snFdCcNJ5fXec3z4VU9PgpXFkxYH9r9dFxBCwK3gfjeKLHbf9gCJM9LNTrsrx
         R1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4sqGRx7LPlz9+S0uXua5iISQtfpSpblxJRJ/HYIvQKs=;
        b=ozbV7hq6jHAG8daKf8DqAwOsGarAI1qLFVF3dymXu8+hsqsIX6Zxi2D9rmSF8zp/D9
         kFTYBbWodZa227kZ/hjKIy8VHe2NHqZEh1yUBp6NbrlCPd0diXDSy6K0i3+hNwF3tGqZ
         OEiRtN/kKTeTtUhJiuyNDY8RXaPtm9TqpI2Z7zt4F1ESsZhbg4GDdtUraMrIvvcf+OzO
         y7/vIIVkp5ZGjD72WONEPmbdfr3ckXtpV6Akjx/dFRy+Ma76EIEORcQHTBSxLhKef8Ed
         PhuNXvB/viqLQ4eO6JhMj4wLfK4O36fLsDQagC5npzY0QQKXKqy/FryGBt+WiB30cq/A
         fO5Q==
X-Gm-Message-State: AIkVDXIQW4fUd3jbrUHkePKUcUacbUlbV/ffGezZT32l29ObaYecB48y35OQqVzXTeqydA==
X-Received: by 10.194.77.129 with SMTP id s1mr16771662wjw.82.1482747762687;
        Mon, 26 Dec 2016 02:22:42 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:41 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 08/21] Documentation/git-update-index: talk about core.splitIndex config var
Date:   Mon, 26 Dec 2016 11:22:09 +0100
Message-Id: <20161226102222.17150-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-update-index.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 7386c93162..e091b2a409 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -171,6 +171,12 @@ may not support it yet.
 	given again, all changes in $GIT_DIR/index are pushed back to
 	the shared index file. This mode is designed for very large
 	indexes that take a significant amount of time to read or write.
++
+These options take effect whatever the value of the `core.splitIndex`
+configuration variable (see linkgit:git-config[1]). But a warning is
+emitted when the change goes against the configured value, as the
+configured value will take effect next time the index is read and this
+will remove the intended effect of the option.
 
 --untracked-cache::
 --no-untracked-cache::
-- 
2.11.0.209.gda91e66374.dirty

