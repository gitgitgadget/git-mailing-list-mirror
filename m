Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C7071F404
	for <e@80x24.org>; Mon, 19 Feb 2018 18:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753487AbeBSSxf (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 13:53:35 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39981 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753439AbeBSSxd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 13:53:33 -0500
Received: by mail-qk0-f194.google.com with SMTP id n198so13469366qke.7
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 10:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VZMaGWRi5fB/BVOgCabbFVeUs3/0XP60gi38k4WuOaw=;
        b=MKvME/LS2fmBOaV20GG0NxhRSgGRyOFSq18PBm0XSRMtA52vkK9MboLnSqrQsSa/ou
         6Uw+EeEj/IH9tcv99NRG5ivXvulcNaaEFjUd8aix356VoXPirYJS9Rm8dnsjiAp1QzKd
         U0WJFFMQsNRt8oYD8lTX1CMEUdK9XJptPi2brvndSle14PUTNJRUzrKMnQMZIuFAgWA+
         ae8mmW09C6PUKZbVFz606dg30ueCDdUqMFfMYnSh3x3OfM5C9FYKlctuWrR+TwdrpnKk
         2sv9OBT3meqCxciwf5lAai7nJxCLnylC2rLmBoOaBxESKWwZIwU5wmPyIIHKTsAfsLrz
         GtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VZMaGWRi5fB/BVOgCabbFVeUs3/0XP60gi38k4WuOaw=;
        b=I3/yfuNC4+97l5DeJWofArY/ObZxfr8AoyUd+zBMmKOmNcxfoTdG3myZX3ynHEwwVO
         LjEju5LmCxdd/1uItdUGvfq4REw0wUoRq/fXnPVn4DQkGjKjlQNOhDTKRkiIwGWfW/lX
         qN2IM7B1m84l9v6VI/6/YwN8WFaU2ToEwPgR2L31jkG81SClj7jDg4c1YFd39s3wJKYY
         gjNrIzgh+z6u8oh9kvw/22qKgUuSgwTZMRGcukrhxP+vc67LyIw5Nod1JMxk7fnDy7M+
         vRkTwr3+V1XQ0tlptHKDal2JywSaPYZm+9dG0X+jt10PanUSRWDifAgDWSUOUlOiGnpo
         XC7A==
X-Gm-Message-State: APf1xPA7cfEKIKVLtTbUlYCdu/ugOfRd6CDMaEe7R6Xvoi033Pe1P2qR
        soitBVT/j8/4FbB42I1gUjFcRZ3AZqc=
X-Google-Smtp-Source: AH8x227vzlHQqDt5sxMcD5kJCcGUdCTssyj5h0QYX30H5r7J2NrotkT1GbLdQT3TjzWRCmls0Q+Cig==
X-Received: by 10.233.222.132 with SMTP id s126mr24927631qkf.60.1519066412252;
        Mon, 19 Feb 2018 10:53:32 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id o12sm1672631qke.81.2018.02.19.10.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Feb 2018 10:53:31 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Cc:     peff@peff.net, jonathantanmy@google.com, szeder.dev@gmail.com,
        sbeller@google.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 01/13] commit-graph: add format document
Date:   Mon, 19 Feb 2018 13:53:14 -0500
Message-Id: <1519066406-81663-2-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
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
 Documentation/technical/commit-graph-format.txt | 90 +++++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/technical/commit-graph-format.txt

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
new file mode 100644
index 0000000..11b18b5
--- /dev/null
+++ b/Documentation/technical/commit-graph-format.txt
@@ -0,0 +1,90 @@
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
+  1-byte number (C) of "chunks"
+
+  1-byte (reserved for later use)
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
+  Large Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
+      This list of 4-byte values store the second through nth parents for
+      all octopus merges. The second parent value in the commit data stores
+      an array position within this list along with the most-significant bit
+      on. Starting at that array position, iterate through this list of int-ids
+      for the parents until reaching a value with the most-significant bit on.
+      The other bits correspond to the int-id of the last parent.
+
+TRAILER:
+
+	H-byte HASH-checksum of all of the above.
+
-- 
2.7.4

