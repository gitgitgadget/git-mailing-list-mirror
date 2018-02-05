Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AA391FAE4
	for <e@80x24.org>; Tue,  6 Feb 2018 00:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeBFADv (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:03:51 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45804 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeBFADt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:03:49 -0500
Received: by mail-pg0-f65.google.com with SMTP id m136so113075pga.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Secil25Tp7cwKJDaBYmsgBITps+0DLV2xj1/2OhOMfc=;
        b=VAOC/Ex8OnWFeWekHtwctX17qgrNDrE7fVaPvRmfpS8Nn6JghU3prmwY0Zelqk3kgD
         l4Dsv4BeLfgv0CcHGldSY3qK4t4DzHNLtALChLp7ywoTCe0NzvvZr7EBYqIEFVZ6OJEX
         K2LQgL4pAIbBa7iWDw7Vc/HQnBxTKRk4V4eahiWeSAn1gA8X/di3SujJ8XWHgeGItacH
         WiQvsS1AyEDK3uwfceuaYA0OAFzqqspiBSz82qL0WR/6ri5VQ2ZKbfzAzN7Yvl+3OZxJ
         Z9777RS2W7XP80RiaJvDTVWpSNAmktVeE3cRcIaJcYBA/Vy707TccjAYgud7vnfd4hH7
         20gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Secil25Tp7cwKJDaBYmsgBITps+0DLV2xj1/2OhOMfc=;
        b=T85aEG1CH2C4kEUGenQQAfQ9I0tAq5Fh1lpNEXzqxbNweSgMdfnJqq6TYye91L+tXU
         QP7xBDD79QdB13gaJBAIn2aJArAmhcOSLjdH1NxsSCdc32mma9mPCXof9ZJItegYpg88
         l7IYCqAlnuLCB3noTIPUpxHabyV7U3OC4YHkZZ/N3uLpelAROCAjzkxxyPCljAGrxWfQ
         N6EZw2gc4tXzBXtrJQI3RncE5SBFHHEC2n/lTYLVv0IAujaeztnRxB8RxXZrNlxZpSDw
         CI7bObueAH2i3QLn8plp6FpTf65Bv+bY9VabzCPfHMnT5g9Y0BAKua17kFBCvY9su/qK
         FjDA==
X-Gm-Message-State: APf1xPB51+6HHBwZ0KVjY9GbW6CDjCgiFWF6030xnatRE3xD2jZncwzS
        bRyI2Ay+xePAnAKS9EW0/YJYTQ1Mj70=
X-Google-Smtp-Source: AH8x227Bm6cRUi/yEZrJYz3glOft1rFiQ2lQ56IRfHqxj3d9Qep2W/jstRbjVD7gMFT8mynzGJf36g==
X-Received: by 10.98.55.3 with SMTP id e3mr500255pfa.119.1517875428255;
        Mon, 05 Feb 2018 16:03:48 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id q14sm14147660pgt.53.2018.02.05.16.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:03:47 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 048/194] replace-object: add repository argument to do_lookup_replace_object
Date:   Mon,  5 Feb 2018 15:55:09 -0800
Message-Id: <20180205235735.216710-28-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the do_lookup_replace_object caller
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 2 +-
 replace-object.h | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index d26e180639..cf38c3df00 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -94,7 +94,7 @@ static void prepare_replace_object(void)
  * permanently-allocated value.  This function always respects replace
  * references, regardless of the value of check_replace_refs.
  */
-const unsigned char *do_lookup_replace_object(const unsigned char *sha1)
+const unsigned char *do_lookup_replace_object_the_repository(const unsigned char *sha1)
 {
 	int pos, depth = MAXREPLACEDEPTH;
 	const unsigned char *cur = sha1;
diff --git a/replace-object.h b/replace-object.h
index 668bbed1da..702020a3a0 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -13,7 +13,8 @@ struct replace_object {
  * This internal function is only declared here for the benefit of
  * lookup_replace_object().  Please do not call it directly.
  */
-extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
+#define do_lookup_replace_object(r, s) do_lookup_replace_object_##r(s)
+extern const unsigned char *do_lookup_replace_object_the_repository(const unsigned char *sha1);
 
 /*
  * If object sha1 should be replaced, return the replacement object's
@@ -25,7 +26,7 @@ static inline const unsigned char *lookup_replace_object(const unsigned char *sh
 {
 	if (!check_replace_refs)
 		return sha1;
-	return do_lookup_replace_object(sha1);
+	return do_lookup_replace_object(the_repository, sha1);
 }
 
 #endif /* REPLACE_OBJECT_H */
-- 
2.15.1.433.g936d1b9894.dirty

