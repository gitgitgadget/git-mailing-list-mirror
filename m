Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 634941FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754004AbdCFJtf (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:49:35 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35271 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753926AbdCFJtc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:49:32 -0500
Received: by mail-wr0-f193.google.com with SMTP id u108so17010930wrb.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5s0oWsjM2ZBrJ0oO61uN7NLu3RSRGmPtljG0m6awkuQ=;
        b=U/bkc+8KsyOvlt8AKYZZ1ZUSubwyj7vASJmf75ogklG3iOgIkYvD2ZY+hotQ0UmhX0
         V/tV7Kq+wMP7U1sRwDkg+QDU+tR3NXKUTlb0E7TMRXwvxtoCKeezLueINGqjhNJ0FqjU
         zn4TaKdL/FaTF4j1zjjVlKTDWawNwhKLoh04ggI2HEwzWRiZ6ZL5Hht4aQMkhciZVkwh
         gRWKNFMA2ZB7mSxExuJ+MGJiREiqrIU3C46PVLIhM4L3Ava5fLEGRBd0L7w4ep+MNVX+
         g72TyPK90eD+w5AQLoxvYIh/+KVoXdgkmvr4ecqTNA08kShmpYx6oycBoPAZ6x4vauXt
         oAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5s0oWsjM2ZBrJ0oO61uN7NLu3RSRGmPtljG0m6awkuQ=;
        b=VPRMaAtmCweb37gpDlOUVqMzRzOzcwqGeoEQO3k5oB+bw44VGuLp6/mDiaNkxsPuIK
         44yiuvluRpgqQhsl/VjJOzpTUZs4oE/+v1pUs4ujjQGJ6leqCqfuFhaR8qlOY/nuswfE
         f/DR7gLbyFsrUb3199S23zJchwzbV3bozLy65INdz5cOj3Rz0GKuNwNK+zmWerttrBD0
         Oue8gUfC/ySIkBqjVnp8UwHldUKJjNXgrcm3ekjE88b7GOQoOUKPtbmDNbQRXj+dyCyb
         PZQigx2/TrwiamUh6y3fRFt+rrYyzywcYBETR7Dut4UJYMWhhZ61fhvRUUFNbXwCTMA+
         buyg==
X-Gm-Message-State: AMke39nY2GuocwIwbfvThDTC0RMOYINYKzlB+OESlzOhFd4D6/h4cQiZtLe625HFqXV9nw==
X-Received: by 10.223.136.4 with SMTP id d4mr13714468wrd.44.1488793350005;
        Mon, 06 Mar 2017 01:42:30 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:28 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 09/22] Documentation/git-update-index: talk about core.splitIndex config var
Date:   Mon,  6 Mar 2017 10:41:50 +0100
Message-Id: <20170306094203.28250-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
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
2.12.0.206.g74921e51d6.dirty

