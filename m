Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 170281F404
	for <e@80x24.org>; Tue, 27 Feb 2018 02:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeB0CdQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 21:33:16 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34273 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeB0CdP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 21:33:15 -0500
Received: by mail-qt0-f196.google.com with SMTP id l25so11539755qtj.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 18:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AlwwmaXu3EbQpe6oDWB6P+inR3zycXSR70vZWSdxlsU=;
        b=rR8ZfdnrX/y0z0TeEVE+bdHvSjMBVUm+xgvcVBQ90EG3Eqzl/4la1jd9v5vjMRLGa1
         +td+YJZfNnn7sYluteRxYxPG1ZX7oBzctzhPbkXmmqisw6Pc6u0vmDYAdJCHW66hk3cP
         eYLeyF1ocRHnPw9NNgYRjvWvvLGTeVSPwvnuzVd0NcpHnRxjpqlY9gaWQjoj8Il42/Ck
         7tzrWJ3i+10cxmgAEmhiArROs9pXzm7SlkMO9VYo4hGCRylPRSUEYyAw2/TUT45mMAA/
         Dth7vksCn37mqkfoVIBCtvY0V8+9McUKzFu+bxVKmsyXaDicYhIuuepyneXVYPCvSadT
         DsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AlwwmaXu3EbQpe6oDWB6P+inR3zycXSR70vZWSdxlsU=;
        b=Jh0SYXcRlJ5cqUwjloqfZyxpUjFhTAC68FE7rO9cUDzaHMxjGvixULbU7H3JRpT+WI
         JB5JSLb6JJjWk+zQ05gnHl/hfg0g0u0NVvn/g3nxY/jxNY0QEe5u8/HASrrhbDqULBkN
         m0nplNmjzZ57h7v4su0RzVj+TQoOTjeW+ATmEFXr7artp5C31BigvqZUgEpEoJ24n1/l
         unRQolte+TavB2l6IBX+1HtoMOk98xfRk5Cebzlr3dR8cin1oCjSd7HB/GlEpRJLs/Ml
         ZVHF1ZqW3+uXw2B2Az9P5aYolB7i5TJpa8EoY3JvvKc0JPWoLpphMfwx/53tc/1uVH+A
         Ce2w==
X-Gm-Message-State: APf1xPD18YJVufGQPlXLHiyU8vADd4+xXtSOowb5iE0hdrkgJtZzLqTr
        qq7MpnYPwAeIH5SMzEug0MtNmFXgDcA=
X-Google-Smtp-Source: AG47ELtEomoNfOCKC23kiC9DM0skV6lUKdosVzhkcS4LYAJkjZVa6ku5W/4FoB1i60g1c9m/aMvlNw==
X-Received: by 10.200.53.137 with SMTP id k9mr21283089qtb.37.1519698794430;
        Mon, 26 Feb 2018 18:33:14 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 94sm5566530qtb.2.2018.02.26.18.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Feb 2018 18:33:13 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        jonathantanmy@google.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 01/13] commit-graph: add format document
Date:   Mon, 26 Feb 2018 21:32:55 -0500
Message-Id: <1519698787-190494-2-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 Documentation/technical/commit-graph-format.txt | 98 +++++++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/technical/commit-graph-format.txt

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
new file mode 100644
index 0000000..4402baa
--- /dev/null
+++ b/Documentation/technical/commit-graph-format.txt
@@ -0,0 +1,98 @@
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
+These positional references are stored as 32-bit integers corresponding to
+the array position withing the list of commit OIDs. We use the most-significant
+bit for special purposes, so we can store at most (1 << 31) - 1 (around 2
+billion) commits.
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
+      type appears at most once.
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
+
-- 
2.7.4

