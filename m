Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DF7C83F01
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjH3S3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343742AbjH3QoK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 12:44:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5851A3
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-594e8207103so61968297b3.2
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693413841; x=1694018641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QoHkY0gwz3nTB1tdRU4Jvo65AWGB7v8s4sgW6WMdEOs=;
        b=1RbBJOt/QldDkliZgq+ZJNzgX1zJN2S80aQai7lUKu3E0GI3aGPN2Biyxwe9UtuCXd
         fWkM28BXJE7Yz25aBlHNeX/PIqcAt5vFsKuE5BTFItKagQIMrEpepZsCUsj1ldzG7xb/
         AoIhnOEh3yfsZEs0mrPAqQmMG1XpYQFGpDGaiZkQTlB5YwsBBEW/DhAQLTFx8N1MOW/f
         bkpifJ4QVpbv/j/BjvOa7xb5EXF0dOhC4i19cuVtaYhdb2ZSE//pikS62NkuVNF8hw0/
         mC+5QvMJPynR+HEKhzWfGi4vjWpeigwCQ6Wj8SKWzVloXpalq2SxOxWyyYhcN0fdjHm2
         iJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413841; x=1694018641;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QoHkY0gwz3nTB1tdRU4Jvo65AWGB7v8s4sgW6WMdEOs=;
        b=NH4aqT7l9MRtA7oPr5yj0HjDmfsQfssPKslhgdAEbs2VGAMgn9vBGohlymXEw+Dndz
         WSXH6ECTZcGp/geuzHvrNvEro59G7m4pVBNiXMZ1H32NxsuKvUL1lVVLzf0iv7HG3ozp
         CVJaGXQm7i08vi5+dWqh5FUFtyHTvv4IuG8PC40pBcgoic2s2zG0doqbSaIgQn6lVv//
         kwvmuN4UL8mkPs8dffscJd3dYDIcdZnUL1OnCHRtnNkUNKWltwRlHcAPncFjS7MACBNQ
         Vt6gaFTjymx+MfuOvEJ1Mgzexu3cN9P0PpxNdaf4XvrZcxEOAW3ntPyKkqWblwulqTre
         XwVA==
X-Gm-Message-State: AOJu0Ywf+X8gE7rqyGQ0+xSCOGG3DEH1UHgbF50vPtrWYpx4+rMiq3Mo
        IHyNfs8GQhSn5j1zKsEepIsspzmoalKzwa52T4DFzOiPDc+651S0IjN6iGyrT0Ur8+8uEeitxp0
        hix2vitDB+RNLxvkmsqXXz3TdCCliZWaugoRn63bfOHmcjj9wmtfw1fxJZmdUHg11QAx/7pWcbY
        Fa
X-Google-Smtp-Source: AGHT+IEuhrYMLPQ9ipbsdb8whi98ootygiZcsYyHFLWWi2SJokMXRwzW0FjciqOHwXQD747Sjo8l1s1Qqi1lnrOGwuzZ
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:2899:32d6:b7e3:8e6e])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ced0:0:b0:d77:d70c:b5cd with
 SMTP id x199-20020a25ced0000000b00d77d70cb5cdmr71148ybe.12.1693413841694;
 Wed, 30 Aug 2023 09:44:01 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:43:41 -0700
In-Reply-To: <cover.1693413637.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1692654233.git.me@ttaylorr.com> <cover.1693413637.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <dcfc98774123862ddb9390690127fa358af20d05.1693413637.git.jonathantanmy@google.com>
Subject: [PATCH v2 01/15] gitformat-commit-graph: describe version 2 of BDAT
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "SZEDER =?utf-8?B?R8OhYm9y?=" <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code change to Git to support version 2 will be done in subsequent
commits.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitformat-commit-graph.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
index 31cad585e2..3e906e8030 100644
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
+	in Probabilistic Verification". Version 1 Bloom filters have a bug that appears
+	when char is signed and the repository has path names that have characters >=
+	0x80; Git supports reading and writing them, but this ability will be removed
+	in a future version of Git.
       - The number of times a path is hashed and hence the number of bit positions
 	      that cumulatively determine whether a file is present in the commit.
       - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

