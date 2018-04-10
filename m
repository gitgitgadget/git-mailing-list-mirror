Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F4461F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeDJM4i (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:56:38 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44308 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752584AbeDJM4h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:56:37 -0400
Received: by mail-pf0-f196.google.com with SMTP id p15so8223308pff.11
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 05:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8lILYpuaXAj8OEcOpQiyTb0P6z4Gk41ZgZx2IO6j4h0=;
        b=KbsPOztQa+MFeBYXIg5JTrEzvoogHHNqk2s4TJcRwXxv26Bq2B62DwqxiZmUeTOcog
         GC0ITGKhZ7gHaOiYDqzNG74uyrh8vF+PgqLNe0A84AmiRkMrQxquk93KIKf4qOr3WTSX
         6sNGILxL/pPeWXWuwjwusAYfX5xu7lM1XuhSQ9FyKdlrDiqPg/XwwCCdJdZPmiH4SoHI
         vQSLCsBkTMTyBHpcL6s+k3UkE2S/x/zL7moFExJq7+L0Jqmh4HbfNr6oGbro8M5yvKOj
         mZK8zQVx0PtWFqBQGHvepKeyB3LN859/mstBluZr+MYrFqbELQ/Y/j1P4S8nPDWqJ065
         1ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8lILYpuaXAj8OEcOpQiyTb0P6z4Gk41ZgZx2IO6j4h0=;
        b=a12I+mQgx1TA1Ro+KfyvIFBCUuVSGBTkFgNoVu2axdJwfLpzMgxC9lgLpYtrDYb3BX
         J6edT3loNCrqsfHNocLfonM6pTvGk5+lnBkROn4mouYM0WDuMUi8lS90eAiEym55RNuR
         1q4zWcNMC2Yb0ujRRwzsZ6I37T3reurSMUYRJENlq8uSJ7ySyAUjku/zNDzo94naTXVy
         5HC4XiOBA77+von2c9mjSzh0h0Pxe0/OWQGl+1DPtDtjnlv0wQlTa48H81cbxXb9/SJY
         b2zH7Jj8FnS3ovFQ7N+2yRGJqRQuCRjCi2fhbTlJfT3EBM3LWnGnmp+AvAcUOWQcfuCX
         7k9w==
X-Gm-Message-State: ALQs6tDjuNsgWZEozrMTr7pRsg8r9Bepb5ymqjV6ohv06QR0I/WiRYAS
        XPdymSF1YoNWNuslyr7Vtc/Onv/HGD0=
X-Google-Smtp-Source: AIpwx486quBsyi0EBCpu+dVBllzwDdnzgnF8mo4e3Z6tS3ZpQuhCujuW7MsjaWktnLCkNZndXejINA==
X-Received: by 10.101.77.145 with SMTP id p17mr203490pgq.275.1523364996539;
        Tue, 10 Apr 2018 05:56:36 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id l10sm4421666pgp.35.2018.04.10.05.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 05:56:36 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, ramsay@ramsayjones.plus.com, sbeller@google.com,
        szeder.dev@gmail.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v8 03/14] commit-graph: add format document
Date:   Tue, 10 Apr 2018 08:55:57 -0400
Message-Id: <20180410125608.39443-4-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410125608.39443-1-dstolee@microsoft.com>
References: <20180402203427.170177-1-dstolee@microsoft.com>
 <20180410125608.39443-1-dstolee@microsoft.com>
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
2.17.0

