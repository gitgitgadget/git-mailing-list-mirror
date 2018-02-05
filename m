Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CE211F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeBEX4b (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:56:31 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33852 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbeBEXz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:59 -0500
Received: by mail-pg0-f67.google.com with SMTP id s73so125549pgc.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iAEM2fc5My3nfnMZyjrYz/tI5OndI4lGz/yuMwukEog=;
        b=i5MH/6StkWbS1LD0vO6qIW+A8amzRR4onGrmnSVRUePBmBEk3R3uRSdfh+htkn3CMm
         AqjgAvuJDvqYnWnvPJAEIAL9DLTTCdxx/WmbgcrWHvxd/gS0VLOKOkQHoJjP5z+0daGZ
         5J4MNwsBoH3TepEU92CvRjK9XBd8Rr47jDXdvNBpAG/iorCbOm5IFbtObTb3oOxNDXbG
         Ja+lRBrRU2bfG5JvQJXRJEm2nhxcEZv6V70vhq7ECK4RcMsypLWy4cqhCuMJxaJDx/ZO
         LlcAcLklO9qojzEmnQy/VHj6n/SIt3+9f15u1DBnpXOcDfGEI/WjsVDaU4ha8+0joS16
         6H4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iAEM2fc5My3nfnMZyjrYz/tI5OndI4lGz/yuMwukEog=;
        b=tEVaLtwWgqELdvqQhnO9o5a6LFQnj1ypQIsk5zcaZ5G3jpt89/JsTH6iYMQLKMmgek
         MxH4g5IjPFuCUCEUtukuZQkkVh+oJfNEavFxErPyCZgUXJKsNEtojXc6dZOyMKaAEmx3
         XDyYBM63LzzQJniTR1o9qaAUhNrEDwtLi8lMZfvwUx8MZsGAKbMq4lCEDJ6hkuGxNh9N
         BOkGXL4HQSvwf/bo6gRFJGEOy0cwCl1DZHk4ViKGO3sG56NY3Vu2pDLsRTfkC0vWLdmX
         rVgYMRidVciQ3FMPqZBa8z6jMO1VHBfmznzWx5r8s9Em80VAdx9tfoD1MVETm/p7WsNG
         VNSQ==
X-Gm-Message-State: APf1xPAjkS+dXaMnQerolJhVZ6HsZbSfU3uRwaFzGhtmQI7BdM0iT4h9
        cVPOLpUMclawJW68hCWkm26i/VQC1w0=
X-Google-Smtp-Source: AH8x225DZmG0PLHq51VYbrYDswUaD2iZWRhyA/bgT936YcC63NiiKmhJKtHScFL8XenHOkO7WBrk2Q==
X-Received: by 10.101.64.74 with SMTP id h10mr385336pgp.200.1517874958873;
        Mon, 05 Feb 2018 15:55:58 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id g17sm15188881pfh.134.2018.02.05.15.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 019/194] pack: add repository argument to prepare_packed_git_mru
Date:   Mon,  5 Feb 2018 15:52:13 -0800
Message-Id: <20180205235508.216277-20-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow the prepare_packed_git_mru caller
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 packfile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index 52cf9182c4..b4ace96f0c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -865,7 +865,8 @@ static void rearrange_packed_git_the_repository(void)
 		set_next_packed_git, sort_pack);
 }
 
-static void prepare_packed_git_mru(void)
+#define prepare_packed_git_mru(r) prepare_packed_git_mru_##r()
+static void prepare_packed_git_mru_the_repository(void)
 {
 	struct packed_git *p;
 
@@ -885,7 +886,7 @@ void prepare_packed_git(void)
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(the_repository, alt->path, 0);
 	rearrange_packed_git(the_repository);
-	prepare_packed_git_mru();
+	prepare_packed_git_mru(the_repository);
 	the_repository->objects.packed_git_initialized = 1;
 }
 
-- 
2.15.1.433.g936d1b9894.dirty

