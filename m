Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FBB21F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeBHUhz (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:37:55 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33231 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeBHUhx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:37:53 -0500
Received: by mail-qk0-f194.google.com with SMTP id c82so7352205qka.0
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 12:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IRiwAJ9fb974WbI9zrtb0SWdeKmzywwW22u0eNtVLfw=;
        b=FLF/AxAL24Zfph1N1AMAtDeUoLyo9fmqZ/c3sK+6zgVNQB/DzEjHhlhNpowF2VsUc6
         XbZ6h2GEBVIp08AWx5BEWPNXXZOV6hVKbERthVUshRsgsCPrytjDDMfRlVek5sj0K1Cz
         1VfZcY/Yxv30UaIzSy3bGzJJEWBJwhspGghWfiWGXmmpn182csu430yBsDMdlU+fe7WE
         AtGnU5UHZBUW4cpKuw/bPt+YGyTmv83/Q4Oue7apAFjf71qf7El5OCNHDeX/hAnu0aLG
         /C9tyUOVlqjOgMhfRa7aORQ+bptGWqFRR30iJM0o+b5HUmiHG5swMI9YZFYCRBp7TMUp
         JHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IRiwAJ9fb974WbI9zrtb0SWdeKmzywwW22u0eNtVLfw=;
        b=b9QeWd5yziSgE4iADpax91pzhCisbP8BYopaJRHs9YmCvbrhPVJgqzIzQcLXtpgyKS
         F/9kFnwYS6f1Nvzmx6y6eEEnPZTsCi1qIjxEQfn9J5w8AXdhs2zE9DL/th5n/1ABaQsO
         x8RKVR6szm1Aba4gDo3efXupXrqMIt+K3mZLgvVriezvLSoS1Ae9VbdHjqog0Dm7zBC1
         8gJshcEx0kKRIW+dZMAo3buKD6A0iKfw549/3cJ55pgH3Pie/QxNUi9X01K2aDiP8uqw
         t6pJIKzTHSjhEb3G9B8BmZCwlkfjNPJVVS3NZYPCmhna0OStXWk/aAkmmJ/UKxvQJUGR
         gchg==
X-Gm-Message-State: APf1xPANnV7etJkzh+HG02L6uguyD4qrtL8Zl5aAPuHRrhYj7dK1ozSL
        c+AKwY+GStK43jU91o7OuP1VK0YlRXM=
X-Google-Smtp-Source: AH8x227yDBP93C2ESy4BKftI7L+RH1DIoYe4HF8j8zRGBBa4qgyZhx3L2GDVMu32cBUFtxrce0i+cg==
X-Received: by 10.55.66.77 with SMTP id p74mr402042qka.205.1518122272596;
        Thu, 08 Feb 2018 12:37:52 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 58sm636735qtm.51.2018.02.08.12.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 12:37:52 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 01/14] commit-graph: add format document
Date:   Thu,  8 Feb 2018 15:37:25 -0500
Message-Id: <1518122258-157281-2-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
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
 Documentation/technical/commit-graph-format.txt | 91 +++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/technical/commit-graph-format.txt

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
new file mode 100644
index 0000000000..349fa0c14c
--- /dev/null
+++ b/Documentation/technical/commit-graph-format.txt
@@ -0,0 +1,91 @@
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
+      all octopus merges. The second parent value in the commit data stores
+      an array position within this list along with the most-significant bit
+      on. Starting at that array position, iterate through this list of int-ids
+      for the parents until reaching a value with the most-significant bit on.
+      The other bits correspond to the int-id of the last parent. This chunk
+      should always be present, but may be empty.
+
+TRAILER:
+
+	H-byte HASH-checksum of all of the above.
+
-- 
2.15.1.45.g9b7079f

