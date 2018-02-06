Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22D91F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeBFAYy (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:24:54 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45603 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbeBFAYp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:24:45 -0500
Received: by mail-pg0-f68.google.com with SMTP id m136so156455pga.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=npkPO2P4LTfaYYcy+8q0LdzbT2pbS45ACQSz9CjJ5DY=;
        b=cXSxj5hjUuZ1NlK4aKy636olffXZkWSxPfeS2WzD1iKL7PrPUzBKOef6vB15rHwccY
         3zysMpRl/oR4BNq4OgLR1Af3V79Zc+iZlyOaAZxxSb1MZMLFt77SiPh2jr+jBCIjsYmk
         MpwsCkwJ1MOhFjlovwK1GX+pfwwxVHy9+PvYM04pQOdVHHJSShk83TYN7pEVpe/w20xq
         MDxKBNBqNHp5E0ExpMb/AV1XZv8UC1nBdptY63I4d7q/N2yYLSDQyXItxWaKFUdRSCmM
         ek2D0cCINSW9n7yOXalLo6jIbbC5+c6a0PaH9PIgXbuMb4l/CL5z6gFhJNo4yaAklnhO
         hGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=npkPO2P4LTfaYYcy+8q0LdzbT2pbS45ACQSz9CjJ5DY=;
        b=g7N+IBu00qP/j84UpPpNK3MF2YlH2jQzCaZviOlwJ+ALbsOKHejk8OuOJun6yUMZWL
         nnN6DdeJH7Od8tvZxUSz271utx23gpJ9dknHOnedLfmvT6GSZCb9yBClh9s7FPuRkH3V
         M5mOGZuPPsRE3cjTLa0WQGXmBZnjx5m7OniSUl4WBGTnZPEdxoGIVFLgtQbsFXNoIfhR
         JBZeQhJ7sLUMlHkOrEE62tka6HzeAmAcqJJjHMT3R+msXZ2Rb4ZqQZrLky6Ars9BRkV6
         244O0lyrnoCqzvZ9er6RC/o0t6z9gavwvmUKP78EiEBX8jMbzDEER51LVQJxwA318JcW
         5zBA==
X-Gm-Message-State: APf1xPDp3tobkDu0jEboh0VLDGTwLWnvacp9UwfXfXynbNQZfW664uUU
        TvyoPhYdUBMQNU+SUSpOwnVS3dCq2dQ=
X-Google-Smtp-Source: AH8x227OoFhdtxI3wwuTAw2H7rHLYIyLVs6pb/h1cDW5vDzkM7UT6az+MTVxgxQFM7025WY7IkDNrg==
X-Received: by 10.98.35.14 with SMTP id j14mr573851pfj.62.1517876684715;
        Mon, 05 Feb 2018 16:24:44 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id f10sm14496716pgr.33.2018.02.05.16.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:24:44 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 142/194] commit: convert read_graft_file to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:57 -0800
Message-Id: <20180206001749.218943-44-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Brandon Williams <bmwill@google.com>

Signed-off-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 43ed3298cc..3a990b7078 100644
--- a/commit.c
+++ b/commit.c
@@ -178,8 +178,7 @@ struct commit_graft *read_graft_line(struct strbuf *line)
 	return NULL;
 }
 
-#define read_graft_file(r, f) read_graft_file_##r(f)
-static int read_graft_file_the_repository(const char *graft_file)
+static int read_graft_file(struct repository *r, const char *graft_file)
 {
 	FILE *fp = fopen_or_warn(graft_file, "r");
 	struct strbuf buf = STRBUF_INIT;
@@ -190,7 +189,7 @@ static int read_graft_file_the_repository(const char *graft_file)
 		struct commit_graft *graft = read_graft_line(&buf);
 		if (!graft)
 			continue;
-		if (register_commit_graft(the_repository, graft, 1))
+		if (register_commit_graft(r, graft, 1))
 			error("duplicate graft data: %s", buf.buf);
 	}
 	fclose(fp);
-- 
2.15.1.433.g936d1b9894.dirty

