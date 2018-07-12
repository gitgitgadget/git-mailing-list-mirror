Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF921F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeGLTvI (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:08 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45370 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbeGLTvG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:06 -0400
Received: by mail-qt0-f196.google.com with SMTP id y5-v6so25143903qti.12
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KYt80ukRbwS0OE8uJR/Icx7hVaH2cYAUhYteHDWxdXI=;
        b=cvlZLI89oYYaUdVNnor8E97HLdBBD3ryEhWJ1VnJoUjFLY587ooqjumdPe5ZOHD+GG
         Ri9APTJku4tc+tI/0aAVQTXGbAAlCRHmk8rWTN7kfefG/4g3eOL2ruG8NRJnesTYlU93
         UG6CJQx462KAKOz7NFypAPe/EKmfdYVa+EBVUYE4cmNO5CJ9afRlbHBV5geJOKNdiyqA
         MtRFwFJ2BXUbBwo7ZbMpH7nzKIOFZFgZm1JQzYoghbtfzbHbRcmj+9RRLuG2BxnpUMnO
         UtQ5kZF0uGMt543GYEAxbOREKciZiUPAUejt/ZGKpZtgSggAG/r9yYNiLpXk9TU6KlF7
         770g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KYt80ukRbwS0OE8uJR/Icx7hVaH2cYAUhYteHDWxdXI=;
        b=FTI3vUimtxtxzy0NdmiNdxMyF26vAtHiIeeMPLRABH/lM9IJnE1Z+74lJ4S33n6Jyn
         rROmFnbbauADw1UO97wqGl0UQbTplGeOAIEkeMeuJ6xUOFRcbopCKtr3PRN+UvYRkkud
         ok65oCsvgrIdqmi3uTS+g9D4BqQ4cipqyuIU78sOiw7MOeD2aLsNUZaHBL6uQQM9+hpR
         qdg82z04UQu2bcEF9tB/2ADfUpUYjqxhUx8ttcjGxLUl3GYPp8etVFvKVPqXpw1wzNpy
         EMilG2iTyfqMBZYFlvDqG1b+L3KGp58R8CR+lC5Yw3EvJeq2+eeXFeX5VPtJMOswxXiH
         c2Sg==
X-Gm-Message-State: AOUpUlGW8U0nwMgn4pzrPQB3M9Ij6ety7F2Q7Xn0Y2a7RGY/gsIjlds8
        dg06iAZ6ysw0eqWJDl4LhqaoUhbrR38=
X-Google-Smtp-Source: AAOMgpdvxIgwG+XpoHWVmXLwnOL75VnJNBIxn5QEk/1j/yy23Vhz5QaFbWAXfUG5UXnGSKhOsOonZg==
X-Received: by 2002:ac8:226a:: with SMTP id p39-v6mr3175173qtp.291.1531424405379;
        Thu, 12 Jul 2018 12:40:05 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:04 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 01/23] multi-pack-index: add design document
Date:   Thu, 12 Jul 2018 15:39:18 -0400
Message-Id: <20180712193940.21065-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/multi-pack-index.txt | 109 +++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/technical/multi-pack-index.txt

diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
new file mode 100644
index 0000000000..d7e57639f7
--- /dev/null
+++ b/Documentation/technical/multi-pack-index.txt
@@ -0,0 +1,109 @@
+Multi-Pack-Index (MIDX) Design Notes
+====================================
+
+The Git object directory contains a 'pack' directory containing
+packfiles (with suffix ".pack") and pack-indexes (with suffix
+".idx"). The pack-indexes provide a way to lookup objects and
+navigate to their offset within the pack, but these must come
+in pairs with the packfiles. This pairing depends on the file
+names, as the pack-index differs only in suffix with its pack-
+file. While the pack-indexes provide fast lookup per packfile,
+this performance degrades as the number of packfiles increases,
+because abbreviations need to inspect every packfile and we are
+more likely to have a miss on our most-recently-used packfile.
+For some large repositories, repacking into a single packfile
+is not feasible due to storage space or excessive repack times.
+
+The multi-pack-index (MIDX for short) stores a list of objects
+and their offsets into multiple packfiles. It contains:
+
+- A list of packfile names.
+- A sorted list of object IDs.
+- A list of metadata for the ith object ID including:
+  - A value j referring to the jth packfile.
+  - An offset within the jth packfile for the object.
+- If large offsets are required, we use another list of large
+  offsets similar to version 2 pack-indexes.
+
+Thus, we can provide O(log N) lookup time for any number
+of packfiles.
+
+Design Details
+--------------
+
+- The MIDX is stored in a file named 'multi-pack-index' in the
+  .git/objects/pack directory. This could be stored in the pack
+  directory of an alternate. It refers only to packfiles in that
+  same directory.
+
+- The pack.multiIndex config setting must be on to consume MIDX files.
+
+- The file format includes parameters for the object ID hash
+  function, so a future change of hash algorithm does not require
+  a change in format.
+
+- The MIDX keeps only one record per object ID. If an object appears
+  in multiple packfiles, then the MIDX selects the copy in the most-
+  recently modified packfile.
+
+- If there exist packfiles in the pack directory not registered in
+  the MIDX, then those packfiles are loaded into the `packed_git`
+  list and `packed_git_mru` cache.
+
+- The pack-indexes (.idx files) remain in the pack directory so we
+  can delete the MIDX file, set core.midx to false, or downgrade
+  without any loss of information.
+
+- The MIDX file format uses a chunk-based approach (similar to the
+  commit-graph file) that allows optional data to be added.
+
+Future Work
+-----------
+
+- Add a 'verify' subcommand to the 'git midx' builtin to verify the
+  contents of the multi-pack-index file match the offsets listed in
+  the corresponding pack-indexes.
+
+- The multi-pack-index allows many packfiles, especially in a context
+  where repacking is expensive (such as a very large repo), or
+  unexpected maintenance time is unacceptable (such as a high-demand
+  build machine). However, the multi-pack-index needs to be rewritten
+  in full every time. We can extend the format to be incremental, so
+  writes are fast. By storing a small "tip" multi-pack-index that
+  points to large "base" MIDX files, we can keep writes fast while
+  still reducing the number of binary searches required for object
+  lookups.
+
+- The reachability bitmap is currently paired directly with a single
+  packfile, using the pack-order as the object order to hopefully
+  compress the bitmaps well using run-length encoding. This could be
+  extended to pair a reachability bitmap with a multi-pack-index. If
+  the multi-pack-index is extended to store a "stable object order"
+  (a function Order(hash) = integer that is constant for a given hash,
+  even as the multi-pack-index is updated) then a reachability bitmap
+  could point to a multi-pack-index and be updated independently.
+
+- Packfiles can be marked as "special" using empty files that share
+  the initial name but replace ".pack" with ".keep" or ".promisor".
+  We can add an optional chunk of data to the multi-pack-index that
+  records flags of information about the packfiles. This allows new
+  states, such as 'repacked' or 'redeltified', that can help with
+  pack maintenance in a multi-pack environment. It may also be
+  helpful to organize packfiles by object type (commit, tree, blob,
+  etc.) and use this metadata to help that maintenance.
+
+- The partial clone feature records special "promisor" packs that
+  may point to objects that are not stored locally, but available
+  on request to a server. The multi-pack-index does not currently
+  track these promisor packs.
+
+Related Links
+-------------
+[0] https://bugs.chromium.org/p/git/issues/detail?id=6
+    Chromium work item for: Multi-Pack Index (MIDX)
+
+[1] https://public-inbox.org/git/20180107181459.222909-1-dstolee@microsoft.com/
+    An earlier RFC for the multi-pack-index feature
+
+[2] https://public-inbox.org/git/alpine.DEB.2.20.1803091557510.23109@alexmv-linux/
+    Git Merge 2018 Contributor's summit notes (includes discussion of MIDX)
-- 
2.18.0.118.gd4f65b8d14

