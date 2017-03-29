Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 445A21FAFB
	for <e@80x24.org>; Wed, 29 Mar 2017 00:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932815AbdC2AeZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 20:34:25 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33924 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932571AbdC2Acu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 20:32:50 -0400
Received: by mail-qt0-f194.google.com with SMTP id x35so128005qtc.1
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 17:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pn/7iF0YabsDw0xfng1wHi8haTd3hMXx7JZ58Kc10jE=;
        b=S923L+I4cJ0gn/Q17p7HNeTLwP2m84QWdBUbj5BvAYXCyCDIFkeME6gYe/duSafGA5
         DC/Iz1mZ5wDVFkfpqP1SvhbTe+Bhkl8Adsrooy9Vlkw/s0LlxTvcUX/8TAadGuCr6dy2
         iV0QEwQDs+UI/XbHpIM2TtA/ns1b1gsAS4ThHq7GM+2DXZJOO08/Z8vy/GiJept9zL8+
         wL/CZ0vLd2g7EdZjqzLWfdKh4SxiP3kq8WJxRg6xjxO/K7tSh3qvuSz9XOjm2jWLmQHh
         5bLqMuHzAkeNIZup72cgFs6WR90asS3GtUKOe88Phwp27YtkIP9ejGHizRZIa9f4W3TL
         GURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pn/7iF0YabsDw0xfng1wHi8haTd3hMXx7JZ58Kc10jE=;
        b=BuGOI0bAHUSwm0hk2CmSw83lwtT2ejnRQCXLe/sMq/HwlPnGxRjOziZoyZqO+blxqE
         Pi5Plqt3tmlDMHfLxAU8sjA/27DpzYGbqKz7yoMtGoDoAcZLI760rxjWk1wryAVQf5hK
         xansx4K5Ohps2iL8qkUNHrQUjEUiiPRbYUGt2PEvPjpU5nl96h+jtwAXuCuHislqWmfq
         rVZDLdtthiORSHpMhlVHiH5rsbbzGW7ORl+72O8ExNmiHbVIf1Nn5sDVu9lX2x2JFJhQ
         PqnDP4Wy4jOVd7odGTpjP7wAHUhDlNdGLfw5Q82vjaRG0G4iAE4jBhLL++ekv+qHyrWv
         UjyA==
X-Gm-Message-State: AFeK/H2WwTe4Pvjo975NKopILYQ9AByqNlhsHTqzdooC4u8wzh1ZP+SvH3CSOg5Oa4mchA==
X-Received: by 10.200.53.209 with SMTP id l17mr28508496qtb.281.1490747568956;
        Tue, 28 Mar 2017 17:32:48 -0700 (PDT)
Received: from Daniels-MacBook-Pro.local.net ([187.11.121.49])
        by smtp.gmail.com with ESMTPSA id x26sm3819420qtx.47.2017.03.28.17.32.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 28 Mar 2017 17:32:48 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v4 5/5] files_reflog_iterator: amend use of dir_iterator
Date:   Tue, 28 Mar 2017 21:32:13 -0300
Message-Id: <1490747533-89143-6-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend a call to dir_iterator_begin() to pass the flags parameter
introduced in 3efb5c0 ("dir_iterator: iterate over dir after its
contents", 2017-28-03).

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 50188e9..b4bba74 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3346,7 +3346,7 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
 	files_downcast(ref_store, 0, "reflog_iterator_begin");

 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
-	iter->dir_iterator = dir_iterator_begin(git_path("logs"));
+	iter->dir_iterator = dir_iterator_begin(git_path("logs"), 0);
 	return ref_iterator;
 }

--
2.7.4 (Apple Git-66)

