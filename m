Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7810C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 20:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EFE61040
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 20:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbhHCUNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 16:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239102AbhHCUNR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 16:13:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783DFC061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 13:13:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y125-20020a2532830000b029058328f1b02eso420223yby.7
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 13:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=b1GYHs/BYsu7XSXFXyZrW4PcTgtOQF9l5769W9JkrQ4=;
        b=mLsV8bOJuP/N5qIHRI2b9fEiGD6RWwOLeVLfq01069CaHlA4fX2+x9NjeBzZ+E5qHG
         WYnUFH2OsgpgcOiQVpXjQAOZJ+4+Kr3Ar5Q/jF222oKRv9EHkk8LXV9Tr1XCUnqFiVLe
         2iHkIaa2EgrEUnjk7MJDekAiTvn8IChQDDANrv62Ahdfp0rSRNw9zv/rGHzhxQUSXHMh
         jrsfNe7ReUwZ0ACxcsbNv6xEcJxxm2VLxaNd5QjLFeEJoEsKboz8kLDWs0AG79tiOOTr
         B/wKrb4khGAXvyQHjLYFxtdbdBlH53u6QA9cx6I5HggLh3WVZZXzjfkr3dQLBZfASsow
         hT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=b1GYHs/BYsu7XSXFXyZrW4PcTgtOQF9l5769W9JkrQ4=;
        b=lqGno3jaZpweOTsEW8nWGMZEeRjo1gffi/GzY0mNRd3ns6jsdkC5GBsMNb/ZVrNCv4
         MuF8M3hTbg5/3jVWBs1mXKiB0e5XdNwjC5/Pe6sLsi7WYYtwLb8UueZGFEe4ESJ25cOl
         oeadJ0E9GummYw31r8bkYRb+/jgT+QmUIoZz6RfD02CxnzqxOTN66dHEPVNZE/ByVGBj
         cbe6lQ050itLU5KmIhBXGNUSx/HK7rA1FqntszVMKplx4nCDpmuAcKBrr0jX2PZKQmzT
         Q6wR3O+ZD936m4ihEjcoBnUkWwP25ZQcCILXOWxA6VH1QMYw9o6HOKC+Xu2Tz0GSvU9m
         3fig==
X-Gm-Message-State: AOAM532lwYlXHo69DW9B/SmQt9bSYOcnMn/as/EWa4diafcVRANwzw0s
        msRPQAl/kEiAIfOPfZywb5Ljgxk9nx+0c/UQLR9HnljkcDvZeMm5DV3Q+0DioOYHmspQV3cC4o8
        l+CLyIIObAp1YbLF/2UxxuTXs8JC1n16aWo6ndoA+pVoDtQZa51hbnnyEw0h+9Jw=
X-Google-Smtp-Source: ABdhPJx35P2iYNUx8B9fhlrQ5VxDI5a5GAd3uwjAaQgJHpL647bzAfw+I/N4G7gLyDkZZtLzZExx2Rzhm937nA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:ece9:6ffe:4c31:18b4])
 (user=steadmon job=sendgmr) by 2002:a25:ba44:: with SMTP id
 z4mr29346587ybj.476.1628021584689; Tue, 03 Aug 2021 13:13:04 -0700 (PDT)
Date:   Tue,  3 Aug 2021 13:13:02 -0700
Message-Id: <f79ab95af6da3da710da2112cfcae4a042b7f7fb.1628020616.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH] connect, protocol: log negotiated protocol version
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is useful for performance monitoring and debugging purposes to know
the wire protocol used for remote operations. This may differ from the
version set in local configuration due to differences in version and/or
configuration between the server and the client. Therefore, log the
negotiated wire protocol version via trace2, for both clients and
servers.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---

Do people have a preference for logging this as an integer (and
therefore having "unknown protocol version" show up as "-1", or should I
add a protocol_version_to_string function so that we can format it
properly? For now I've erred on the side of having a smaller diff.

 connect.c  | 1 +
 protocol.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/connect.c b/connect.c
index 70b13389ba..6e23e3ff2d 100644
--- a/connect.c
+++ b/connect.c
@@ -164,6 +164,7 @@ enum protocol_version discover_version(struct packet_reader *reader)
 		BUG("unknown protocol version");
 	}
 
+	trace2_data_intmax("transfer", NULL, "negotiated-version", version);
 	return version;
 }
 
diff --git a/protocol.c b/protocol.c
index 052d7edbb9..3791d8499e 100644
--- a/protocol.c
+++ b/protocol.c
@@ -89,5 +89,6 @@ enum protocol_version determine_protocol_version_client(const char *server_respo
 			die("protocol error: server explicitly said version 0");
 	}
 
+	trace2_data_intmax("transfer", NULL, "negotiated-version", version);
 	return version;
 }
-- 
2.32.0.554.ge1b32706d8-goog

