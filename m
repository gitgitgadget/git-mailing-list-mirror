Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82BBC1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932449AbeDBUe4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:34:56 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38517 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932424AbeDBUez (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:34:55 -0400
Received: by mail-qt0-f195.google.com with SMTP id z23so16230717qti.5
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=agLi/qIN3famcin0GKJJCxuOu+/U5mWZXeM+POkFeSY=;
        b=Gej9sMv7dXlBUuoW2z96dvETMCaQxu339dchwRJBhCBS4vreqhQNQPz19BL7/psw9f
         gDQgbNOqCmq01Pe4nCIh+luJv2bfMB4uiZ0N+A65raggPtcZ0T5eoDe8y1rons9Wct1k
         pcKkTKMVzu6KanIX6azhVl/2Gzq2EZBnwkNZ7i/fyoi6jS7Fri5Yc15kZpZwyj5z/0ul
         crHNtu3HcqqiktaD/0Dd0jAk3ruHhH5ojnZ8ZKQvpkYfAUvetQ10kYMjZLKL2pFX//J7
         cFs7ZMayQl0l3BRpRcfOgwGll/c+Yb9dAKtruordFa3AYzhcayrm2niLCHasyBeyee23
         b0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=agLi/qIN3famcin0GKJJCxuOu+/U5mWZXeM+POkFeSY=;
        b=M8wQ3TnvtEvFXHSp+Neqjl7I+YCCsnhz3+wKjo0l+UgCpwmoyjH2Welf8C8fDsFTYu
         CRLmWW7qkUB1qsVSaUAf1kVdgOQfxwWmokpAJ7tOR7qCsjxKWuyyF8v1mbGEQjw3SwUg
         fqBiRVrrqV5tmR014obvua/TF95E08HfqCX6ERuTKJpH6qT7ZdkX23qCQv6BO7d4UzSz
         Q0NuopzL8cVDPlpsgcygMGvxZWsv5nvwdh11iqPG3YqHnQx91aczpnseUNwdkORGaPqh
         e5H0W+375SQXKC45q6o6sAZ/ViaK1DgHiidZBjvtDxumEw3oBdoZGjwGCScrYeJeyEoO
         WVyg==
X-Gm-Message-State: ALQs6tBXCov94FRHvPYXsFxH7yV30BhspZMurQKUf6L0S1uM5Wxz4+Ii
        D5VpCnxq6wJuVLZsGE0ffljzCoNyKGc=
X-Google-Smtp-Source: AIpwx4/0TRiEKqqRUftlXxGUEz5SN5LU4h8oGx0/p4dm4qX1OPlV/+IsHWQOFSiMk2TDXqvO8Y/V0Q==
X-Received: by 10.200.8.117 with SMTP id x50mr15763209qth.240.1522701294717;
        Mon, 02 Apr 2018 13:34:54 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id n30sm998611qtb.93.2018.04.02.13.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 13:34:54 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 03/14] commit-graph: add format document
Date:   Mon,  2 Apr 2018 16:34:16 -0400
Message-Id: <20180402203427.170177-4-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180402203427.170177-1-dstolee@microsoft.com>
References: <20180314192736.70602-1-dstolee@microsoft.com>
 <20180402203427.170177-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add document specifying the binary format for commit graphs. This
format allows for:

* New versions.
* New hash functions and hash lengths.
* Optional extensions.

Basic header information is followed by a binary table of contents
into "chunks" that include:

* An ordered list of commit object IDs.
* A 256-entry fanout into that list of OIDs.
* A list of metadata for the commits.
* A list of "large edges" to enable octopus merges.

The format automatically includes two parent positions for every
commit. This favors speed over space, since using only one position
per commit would cause an extra level of indirection for every merge
commit. (Octopus merges suffer from this indirection, but they are
very rare.)

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .../technical/commit-graph-format.txt         | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/technical/commit-graph-format.txt

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
new file mode 100644
index 0000000000..ad6af8105c
--- /dev/null
+++ b/Documentation/technical/commit-graph-format.txt
@@ -0,0 +1,97 @@
+Git commit graph format
+=======================
+
+The Git commit graph stores a list of commit OIDs and some associated
+metadata, including:
+
+- The generation number of the commit. Commits with no parents have
+  generation number 1; commits with parents have generation number
+  one more than the maximum generation number of its parents. We
+  reserve zero as special, and can be used to mark a generation
+  number invalid or as "not computed".
+
+- The root tree OID.
+
+- The commit date.
+
+- The parents of the commit, stored using positional references within
+  the graph file.
+
+These positional references are stored as unsigned 32-bit integers
+corresponding to the array position withing the list of commit OIDs. We
+use the most-significant bit for special purposes, so we can store at most
+(1 << 31) - 1 (around 2 billion) commits.
+
+== Commit graph files have the following format:
+
+In order to allow extensions that add extra data to the graph, we organize
+the body into "chunks" and provide a binary lookup table at the beginning
+of the body. The header includes certain values, such as number of chunks
+and hash type.
+
+All 4-byte numbers are in network order.
+
+HEADER:
+
+  4-byte signature:
+      The signature is: {'C', 'G', 'P', 'H'}
+
+  1-byte version number:
+      Currently, the only valid version is 1.
+
+  1-byte Hash Version (1 = SHA-1)
+      We infer the hash length (H) from this value.
+
+  1-byte number (C) of "chunks"
+
+  1-byte (reserved for later use)
+     Current clients should ignore this value.
+
+CHUNK LOOKUP:
+
+  (C + 1) * 12 bytes listing the table of contents for the chunks:
+      First 4 bytes describe the chunk id. Value 0 is a terminating label.
+      Other 8 bytes provide the byte-offset in current file for chunk to
+      start. (Chunks are ordered contiguously in the file, so you can infer
+      the length using the next chunk position if necessary.) Each chunk
+      ID appears at most once.
+
+  The remaining data in the body is described one chunk at a time, and
+  these chunks may be given in any order. Chunks are required unless
+  otherwise specified.
+
+CHUNK DATA:
+
+  OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
+      The ith entry, F[i], stores the number of OIDs with first
+      byte at most i. Thus F[255] stores the total
+      number of commits (N).
+
+  OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
+      The OIDs for all commits in the graph, sorted in ascending order.
+
+  Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)
+    * The first H bytes are for the OID of the root tree.
+    * The next 8 bytes are for the positions of the first two parents
+      of the ith commit. Stores value 0xffffffff if no parent in that
+      position. If there are more than two parents, the second value
+      has its most-significant bit on and the other bits store an array
+      position into the Large Edge List chunk.
+    * The next 8 bytes store the generation number of the commit and
+      the commit time in seconds since EPOCH. The generation number
+      uses the higher 30 bits of the first 4 bytes, while the commit
+      time uses the 32 bits of the second 4 bytes, along with the lowest
+      2 bits of the lowest byte, storing the 33rd and 34th bit of the
+      commit time.
+
+  Large Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
+      This list of 4-byte values store the second through nth parents for
+      all octopus merges. The second parent value in the commit data stores
+      an array position within this list along with the most-significant bit
+      on. Starting at that array position, iterate through this list of commit
+      positions for the parents until reaching a value with the most-significant
+      bit on. The other bits correspond to the position of the last parent.
+
+TRAILER:
+
+	H-byte HASH-checksum of all of the above.
-- 
2.17.0.14.gba1221a8ce

