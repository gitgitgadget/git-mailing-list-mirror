Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EABED1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeA3VkN (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:40:13 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40653 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeA3VkM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:40:12 -0500
Received: by mail-qk0-f193.google.com with SMTP id d18so12123139qke.7
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QP8uB7/fGyJrlnvr7Szwq2shKpfp7x/uMpoTVbHCezk=;
        b=eUOY2E+GbwBBbEVmQcKtJlbjyh7HXgRZ5mtx9cM5fcTcEV3ufvt1eXi6CZItu7F7sE
         xsuc4fZO/MowN1GkbQKK9QVcaVs57TwWjnMq7dYXYDRbNeRvHCc3arac0uE3BioZo1C+
         yxGl/HqDlR/hUhK5Ll9Kz4Ytn//JnNJTQ9FluBlg+sHY26PdxctQXB9MeXEyZCf9I3JG
         XfBhyyUWLhdmVLGqDOMAZrFdw3fOv7vwx4oJsJHwYXEmkW6zwQ+fZYqy1f3N+OXBMKzy
         m4K7Re1n11Yac6PhrYcqmtNIj2DjkooxBSaH/Bvjb6Es1F0TIKCHspgE6sJtc0iI/2Uz
         BX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QP8uB7/fGyJrlnvr7Szwq2shKpfp7x/uMpoTVbHCezk=;
        b=tR2ePO8j0jddVNrJl1FMW5E/ux1vpYT5tCaFQy8Or782XEtP+CW5Ztqbv3YNKx3L9b
         JeYo19N+vXncnkReVqGEJjJ3KPE+LLEfydORCgQolZeQcbpCZCDP3KGnaaf+Q79selvR
         9IS19JTRQrlQUEZ2gtl7JfkV35DgzHJXXKftkkILXKS3oCz7l2APkcBfWV+avUcRMD3S
         TnfTbqf/mrXix1GfxQgrk5/2TVYJOjhxfcXHnZq83yFaanIJMe0/SDjFSY4jI5cr/HQ2
         t08HdhdGsc0Xi2A8W3qh5c/SWQGt/Auxt9NPmMZqI7jN+xj6bJTOZJsP2ri9ZEktlsTf
         BR/w==
X-Gm-Message-State: AKwxytfD+nZ0b9gqCS+8BjDZT2Wex6PYupzT9Aeq1+uHbxp+CG0MdEB7
        y4bjWlrNb8lZdipIED21qSMPn3M0
X-Google-Smtp-Source: AH8x225bSb57EdPLBXf8kCl559QqNbPDOqWaT2Enc9IeM3rh77sI6jlp5z9VtGDTlk7Bnh0pqJ7OSw==
X-Received: by 10.55.23.99 with SMTP id i96mr45161487qkh.104.1517348411617;
        Tue, 30 Jan 2018 13:40:11 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id x79sm11725193qkg.38.2018.01.30.13.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 13:40:04 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH v2 01/14] commit-graph: add format document
Date:   Tue, 30 Jan 2018 16:39:30 -0500
Message-Id: <1517348383-112294-2-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
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
 Documentation/technical/commit-graph-format.txt | 89 +++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/technical/commit-graph-format.txt

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
new file mode 100644
index 0000000000..8a987c7aa9
--- /dev/null
+++ b/Documentation/technical/commit-graph-format.txt
@@ -0,0 +1,89 @@
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
+== graph-*.graph files have the following format:
+
+In order to allow extensions that add extra data to the graph, we organize
+the body into "chunks" and provide a binary lookup table at the beginning
+of the body. The header includes certain values, such as number of chunks,
+hash lengths and types.
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
+  1-byte Object Id Version (1 = SHA-1)
+
+  1-byte Object Id Length (H)
+
+  1-byte number (C) of "chunks"
+
+CHUNK LOOKUP:
+
+  (C + 1) * 12 bytes listing the table of contents for the chunks:
+      First 4 bytes describe chunk id. Value 0 is a terminating label.
+      Other 8 bytes provide offset in current file for chunk to start.
+      (Chunks are ordered contiguously in the file, so you can infer
+      the length using the next chunk position if necessary.)
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
+    * The next 8 bytes are for the int-ids of the first two parents
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
+  Large Edge List (ID: {'E', 'D', 'G', 'E'})
+      This list of 4-byte values store the second through nth parents for
+      all octopus merges. The second parent value in the commit data is a
+      negative number pointing into this list. Then iterate through this
+      list starting at that position until reaching a value with the most-
+      significant bit on. The other bits correspond to the int-id of the
+      last parent. This chunk should always be present, but may be empty.
+
+TRAILER:
+
+	H-byte HASH-checksum of all of the above.
-- 
2.16.0.15.g9c3cf44.dirty

