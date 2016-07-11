Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 069CC1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 17:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776AbcGKRXc (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 13:23:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33838 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932489AbcGKRX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 13:23:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id w75so16416558wmd.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 10:23:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jIKErPrqsft6lko+TmcKH1XmgiT70p7yut6Oj1QcphU=;
        b=sJT/iS0MvKrJY7nNW9fEKqoscb3yugre5JubOQZL2ANSH29FmMBqWjLTv8iQEwjQoe
         48AUoY73caUneuX5r3sZDJ6Jjvdlf5GdvoUklNK08B9pWHoOllR65duopOg3MY6TtWhD
         hbPz2UCOiKhNSNxcyWhhs76iwstRGj1r3UYznH1vRzguqEVwydfDTjEXMgaZMmKER8ym
         +mi/p1GHb2CguIXmqL6RJBqCHlFeivqMJkzjjwnXjl3+fd69QNKPNpl30uBmYSa23Z4I
         ZPCS6UEcyOjanqr0t4HiynmB0J+Haz1c/E6vTxni5DOw34IA/PuzNNWPICGid724iMcb
         qtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jIKErPrqsft6lko+TmcKH1XmgiT70p7yut6Oj1QcphU=;
        b=NWRrHleVhCH9KwfvG5iTimFRjzkqLJhRctlMcfFmGQ2ei1U8s+iJNUV/HCR8v6EOIQ
         y9S7ZT1TKK7F/EmO0EJGUFJVCwizJhJKX7aKxKUK0zUe1fp2s3E54lG99CWJDFZQdPL9
         NWs/MAVAuPDQ6vcbUHOOfl8sBclAo03Rr9ZS0gJ4pHMn2PXe09fOy2cEfZG2R8SzvLRX
         FNwRd2usVlzYMjkSrsQhcaUkezQZ23lPwCh1pPJZpPaRo/CQ7OiBCiJCbz/6fifW5YBG
         xFoMQ3bnoQTBPpXQWJBJzey7N8v9DbFRk1i4/aXxoRBVh9DpiavHLrACaCiTwqz85rbv
         VURQ==
X-Gm-Message-State: ALyK8tKrOWupgGuYjkqNvUgeuoGVM8YrFvzue2YENVaN1NUKugxnvvh4rfyaa+7FHJWiNA==
X-Received: by 10.194.91.197 with SMTP id cg5mr904397wjb.154.1468257805282;
        Mon, 11 Jul 2016 10:23:25 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id si2sm829442wjb.19.2016.07.11.10.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jul 2016 10:23:24 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 6/8] Documentation/git-update-index: talk about core.splitIndex config var
Date:	Mon, 11 Jul 2016 19:22:52 +0200
Message-Id: <20160711172254.13439-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.250.g7087ccc.dirty
In-Reply-To: <20160711172254.13439-1-chriscool@tuxfamily.org>
References: <20160711172254.13439-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-update-index.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index c6cbed1..2293140 100644
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
2.9.0.250.g7087ccc.dirty

