Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E765C7EE23
	for <git@archiver.kernel.org>; Thu,  8 Jun 2023 19:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbjFHTWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbjFHTWK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 15:22:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA2E30DB
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 12:21:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba82ed6e450so1391974276.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2023 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686252091; x=1688844091;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EIgISl3q2fGpy/zJ0lAXzFwP2Pn+l8YAe0nxI7NDaxA=;
        b=GrN6DMh55NRrSDrdmYTCvb6Oi3Py1G3VuTwRB1zGExq2zA1fdgchgM0LRF+q3Zs3DL
         KKM3N0xdk1uUvZk5OpbO3wsSOJ6CJogA2ZKEIYNx5uLQvnobWmiU1Yms+paioO5INHE9
         C5tfmvQg8r77X6aoTux0KJLhqKb8dE4NFatD2mougXm9dj4ZLhl09alzlCQnZVOVMABm
         GErqoozmyglabinf/F7a1gwGP6VH8nVh47N3ua47wGC9XTeEMWvroOtoK2jCPfkCDPWq
         7samsPOnswHDeZBNgXUA2jAh4rMZVZOguUM7in821JP8/cDEaIhmeK3vf88uzCFCBG5c
         y+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686252091; x=1688844091;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIgISl3q2fGpy/zJ0lAXzFwP2Pn+l8YAe0nxI7NDaxA=;
        b=jOo5hBOeLG0RtjO6vQjSSwm6293gWSPKBCzMU3tYYbxR8FCt4act9If/F6K432T3Bz
         OzpNAz77LsNnWKsl/LSrghKPWim8idjEomPjWRJLRhs83tzj2O0UbhW5uz5A72tuEy7j
         ps4DZuyy2pYxtmn2sduwcuqrQnCjLuEdikB+JmuZz+3gW20WlP7T32RIcEQh4oEwbyUo
         slYDlMkmphYwfgUZtT9lwHv37esvHjkHy8I4EwwIFqHhf1DsSmiFQLgrIXvQCaN2lpXz
         SpUQ0zdaZkuxV59DirEL0L+1H7f37Zb3tpinF5cT3b7BMeAmHfCrvRPSRC85h5eNSDOt
         EgHw==
X-Gm-Message-State: AC+VfDyiFacruWLEBXyjwv4Ggil2T6qtYPdrl+H4IghGw4au3zC45Z/z
        7rFxXWMCJQBuJkzisedTabWwVqd1pBFqxkuH48z1CcqD6Ty9K8TD6L3NMsB15C9irKVPtkDxDAS
        rxiV+hTyuIuhGhKCwz465zfmRgS6ysLGirQu4Dmbt6hxi8y6DDjFbc9/60l+fLMjIGQDV2vlYzb
        UZ
X-Google-Smtp-Source: ACHHUZ6KicARd8e70gpK+pT/abzx5Z8TRNi+k/4YF4HyKhrWNmxUSEYL0ssc+G/0zOsN163EHcVWsFZkdE7l/M2Q2ubu
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:bde7:a867:45f9:3528])
 (user=jonathantanmy job=sendgmr) by 2002:a25:b42:0:b0:bab:a1e6:c87d with SMTP
 id 63-20020a250b42000000b00baba1e6c87dmr225812ybl.4.1686252091141; Thu, 08
 Jun 2023 12:21:31 -0700 (PDT)
Date:   Thu,  8 Jun 2023 12:21:22 -0700
In-Reply-To: <cover.1686251688.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1686251688.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <d4b63945f6d52e68a4760393f787acde0fccc312.1686251688.git.jonathantanmy@google.com>
Subject: [PATCH v3 1/4] gitformat-commit-graph: describe version 2 of BDAT
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code change to Git to support version 2 will be done in subsequent
commits.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/gitformat-commit-graph.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
index 31cad585e2..9dab222830 100644
--- a/Documentation/gitformat-commit-graph.txt
+++ b/Documentation/gitformat-commit-graph.txt
@@ -142,13 +142,16 @@ All multi-byte numbers are in network byte order.
 
 ==== Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
     * It starts with header consisting of three unsigned 32-bit integers:
-      - Version of the hash algorithm being used. We currently only support
-	value 1 which corresponds to the 32-bit version of the murmur3 hash
+      - Version of the hash algorithm being used. We currently support
+	value 2 which corresponds to the 32-bit version of the murmur3 hash
 	implemented exactly as described in
 	https://en.wikipedia.org/wiki/MurmurHash#Algorithm and the double
 	hashing technique using seed values 0x293ae76f and 0x7e646e2 as
 	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
-	in Probabilistic Verification"
+	in Probabilistic Verification". Version 1 bloom filters have a bug that appears
+	when int is signed and the repository has path names that have characters >=
+	0x80; Git supports reading and writing them, but this ability will be removed
+	in a future version of Git.
       - The number of times a path is hashed and hence the number of bit positions
 	      that cumulatively determine whether a file is present in the commit.
       - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
-- 
2.41.0.162.gfafddb0af9-goog

