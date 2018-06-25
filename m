Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 536821F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934433AbeFYOe4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:34:56 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:37340 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934421AbeFYOew (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:34:52 -0400
Received: by mail-qk0-f196.google.com with SMTP id t79-v6so853224qke.4
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cd9KykTKZX3VKYRoYzBwH8TEnpterTeUsClPauprEgA=;
        b=df+ZlZFXCscD6HPurd8iOh+Y0aWEtEBf67uUf/uLNtIx419sjGjxgni/fOqf6XkJpK
         /rLmRLobWXVfTW5IQc+MPRfyKT7AaeMacb/KTRCGD7sZweY4bMgbFOKUHTMl8VY154lM
         Dyw7TVyvfWt1m7Mf7+qFXUFpJpn80ItcymMT48itzJN56V7Pc0Uj/foYA9GuV6J7Eq7y
         YcWcAlw1WGDmzJJyJW0jOA1XnF2UDM1CDneNYbfeUySFXHvc8TG75DxLBOwRHvFyS67W
         lcn5/pCZap7+55AfDLZNhluW+fw7z0uVRsaESv/y9QJVkE2Ock0RgYszJRF7APZiR6kE
         utMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cd9KykTKZX3VKYRoYzBwH8TEnpterTeUsClPauprEgA=;
        b=pVqevp1S5UNz2AoOJa1Uhywwz06UPxF4T0oDyzNcSRUHe4cT+d57u+tJh0EqNa4kwe
         otW2DIQSnQJ9/G7JAuqUcA+A1ze6Ems6iMDokiY3lFXni/Umj55dgiarHQNl7FozKYkQ
         rAS/8QZ7Kp9w/zlpmnmVRp7tgMnFq/PeTxRL48GYDopEJ4CEs8D2HxoW4v+N4D3XcdAC
         Pf6wZg7wTBR8rzjXMHcBwgb2dNBt84qNLccAzTzIucwzSxxoI3nG4/b2eI1aIjdquG4C
         SaXQ4LWttbJe7CwvL43RRXMIb40zUYdXkMVYqLLZvZyq8/NJIz2o1Pv/kZUArcOHHzFG
         S26A==
X-Gm-Message-State: APt69E1m3lvxlWP4FzOJVinOCHlfeL10TIWleAzmjnGQIn9Ypiv1tUJr
        8JlKYCcj1Q8hwjD97Tq2eigkgk3V
X-Google-Smtp-Source: ADUXVKK0j1INVMTJ6Jog+IXvcKxgI1C7CqCCSY2VhthQKc2rKAzwG8FNOebLEAHk7Z2K9Y1A1PML0g==
X-Received: by 2002:a37:9704:: with SMTP id z4-v6mr11118170qkd.272.1529937291548;
        Mon, 25 Jun 2018 07:34:51 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:34:51 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 02/24] multi-pack-index: add format details
Date:   Mon, 25 Jun 2018 10:34:12 -0400
Message-Id: <20180625143434.89044-3-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The multi-pack-index feature generalizes the existing pack-index
feature by indexing objects across multiple pack-files.

Describe the basic file format, using a 12-byte header followed by
a lookup table for a list of "chunks" which will be described later.
The file ends with a footer containing a checksum using the hash
algorithm.

The header allows later versions to create breaking changes by
advancing the version number. We can also change the hash algorithm
using a different version value.

We will add the individual chunk format information as we introduce
the code that writes that information.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/pack-format.txt | 49 +++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 70a99fd142..e060e693f4 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -252,3 +252,52 @@ Pack file entry: <+
     corresponding packfile.
 
     20-byte SHA-1-checksum of all of the above.
+
+== multi-pack-index (MIDX) files have the following format:
+
+The multi-pack-index files refer to multiple pack-files and loose objects.
+
+In order to allow extensions that add extra data to the MIDX, we organize
+the body into "chunks" and provide a lookup table at the beginning of the
+body. The header includes certain length values, such as the number of packs,
+the number of base MIDX files, hash lengths and types.
+
+All 4-byte numbers are in network order.
+
+HEADER:
+
+	4-byte signature:
+	    The signature is: {'M', 'I', 'D', 'X'}
+
+	1-byte version number:
+	    Git only writes or recognizes version 1.
+
+	1-byte Object Id Version
+	    Git only writes or recognizes version 1 (SHA1).
+
+	1-byte number of "chunks"
+
+	1-byte number of base multi-pack-index files:
+	    This value is currently always zero.
+
+	4-byte number of pack files
+
+CHUNK LOOKUP:
+
+	(C + 1) * 12 bytes providing the chunk offsets:
+	    First 4 bytes describe chunk id. Value 0 is a terminating label.
+	    Other 8 bytes provide offset in current file for chunk to start.
+	    (Chunks are provided in file-order, so you can infer the length
+	    using the next chunk position if necessary.)
+
+	The remaining data in the body is described one chunk at a time, and
+	these chunks may be given in any order. Chunks are required unless
+	otherwise specified.
+
+CHUNK DATA:
+
+	(This section intentionally left incomplete.)
+
+TRAILER:
+
+	20-byte SHA1-checksum of the above contents.
-- 
2.18.0.24.g1b579a2ee9

