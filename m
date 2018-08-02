Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF39208E9
	for <e@80x24.org>; Thu,  2 Aug 2018 06:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbeHBIFi (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 04:05:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34981 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeHBIFi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 04:05:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id a3-v6so888056wrt.2
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 23:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XLs2ekaXa1CVi+NlaWhxPYa+ZRn8v7mto9kKqJDHWR0=;
        b=mqzUaxFDfIoOVKH6iyUjcHZZK82lUfu+avxvu42Yj5pGM910vvnQGWksl0q1qhcaR/
         38+xB54R9U4wT8/o2tjAqBjiqBhScLJPKmekfCegdf9rB5jVhoBUst4by3PgBAWSyb9W
         pa7mnscgFxjM7C6iyriJuJR3C6sl6yV2sgsJuWQvsciKRKdjDU3J8erHNg6/KJT50Yrs
         fE7H6yO5QyQVbNqwHSp94K6+M926qgd3eiERgM9f08vBsJi3rBt1wAZc5k5X+XtnE4aD
         Ra/MnqB6TWhpxU3nrDwsGCG+5+eXbYRKqKi+atIwwa0LrOasTldvI0uW52jAopfa8vgC
         hGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XLs2ekaXa1CVi+NlaWhxPYa+ZRn8v7mto9kKqJDHWR0=;
        b=exy2/3dUYU/GlnQA7qEmxpDLkEMJ+QuRKykD1MzsdzPXv4FydBcwGbHFpjwynNnz4E
         Qzh6Ulrj5J9nvObg0nrX3hQMJbGQD0U2zZMaxbfWZWGDC5F95gfUc9/x9YlEetTVK+7e
         Fi99twxQxPIkva0Bhs+Slafk7cGpckSqEfbF3yPjEtDafDRM8iClEgWWKmDZIiS/xSYi
         IarjUYGc9uBen6nur4j0P8fWlU9YiPLRh+HOPPcXxqHR+RLj6UTW/wSG58JB9bGgNSa6
         AuVzET/wKymCH+d6uEOJLyoxfiqLai6rhmuMOg++Ne8JMp51rDnDAnQiMb+ythnYz+nP
         3XAg==
X-Gm-Message-State: AOUpUlGdZ5xs1gmuuxjhvB9Gi3OxxkS6nRyJ8tJgQKnze0KhWYUuNECl
        nlRE7PsfaSBz1sXzAnkfkLifq5O7
X-Google-Smtp-Source: AAOMgpd9ofOigAHUFvO7t/rWObYEqVa2veshKFqStKO3YYFfsJjS1r6F1R3qCcEa6o1zr/Q2+G56qQ==
X-Received: by 2002:a5d:480d:: with SMTP id l13-v6mr974330wrq.234.1533190565211;
        Wed, 01 Aug 2018 23:16:05 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:109f:b149:1092:6e1:496b:fd26])
        by smtp.gmail.com with ESMTPSA id m200-v6sm1093018wma.32.2018.08.01.23.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 23:16:04 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 9/9] Documentation/config: add odb.<name>.promisorRemote
Date:   Thu,  2 Aug 2018 08:15:05 +0200
Message-Id: <20180802061505.2983-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.330.g17eb9fed90
In-Reply-To: <20180802061505.2983-1-chriscool@tuxfamily.org>
References: <20180802061505.2983-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 43b2de7b5f..2d048d47f2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2513,6 +2513,11 @@ This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
 environment variable, which must be a colon separated list of refs or
 globs.
 
+odb.<name>.promisorRemote::
+	The name of a promisor remote. For now promisor remotes are
+	the only kind of remote object database (odb) that is
+	supported.
+
 pack.window::
 	The size of the window used by linkgit:git-pack-objects[1] when no
 	window size is given on the command line. Defaults to 10.
-- 
2.18.0.330.g17eb9fed90

