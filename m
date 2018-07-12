Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97CDD1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeGLTvI (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:08 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37797 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeGLTvI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:08 -0400
Received: by mail-qt0-f195.google.com with SMTP id a18-v6so25154319qtj.4
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JllXlHiTTXfCpAkbsyBvwg6tFPTlBNxPcUSwqJCaXQs=;
        b=U2nOROL30Cf6ZCJVgfT3p4El876eTZ/t9FhCJVnleltMi4kxs2cobEk7obmN5n5/Fu
         ReWaCmklICa3reL+qZeBIjvgbfNTtEpI/sPP2cvrSjsmxWBzngKCyxqCuYCMngME4oGS
         bvml6DiJ2JmT8kry7WvkfMEZYsISz0zpOWzO/hWO0S3u6nbO2lUMQzqvknw+RH1pS+Ty
         euTtupgSzoDBhZyiSF/Xx0OQzeMBUGhAB9Qg6zm2JSxdmcc8tXZk9xcEGKFEDyqBKnB7
         tzN2GESro2DfuGtYO8sm+auqAO8L/haT4IL9QETa5mHRKc3SKA9KDl/ePZn/x1YE+F0U
         QM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JllXlHiTTXfCpAkbsyBvwg6tFPTlBNxPcUSwqJCaXQs=;
        b=UsbmBitjd6k4WyNL0L2wH/j1haw40Fja6UFamdDfOh9OlgoRHyh89Qbyb/YoNRD5UM
         nHJmqW0SnBXokAx0K32fT9/tRtWErRFqUm0wAat4hPHGVb9TMhm88sRqg3LekoKfzPCG
         B1a3+Ldwk6NleIJHFq0108eKKknIP49BOK+BYtyFZjui54pSDq1PdeLhMHF060zIpZby
         nTYlzYw9yNT8SuT0lHceBVHjcZfce5dpiQtHh27bmEqnLvzuzz0PWAhAIhghR0In2w1h
         kXrwQffoUPUP9ZqsfK35UC4NwiNat46IsxnVACX4cLHY9kCQOZplATNJj/6wYudr22Ta
         v5Vg==
X-Gm-Message-State: AOUpUlH9rJrTMl1Y7oUmqEpWYGJIE+2/jeVOPCd4BeTffoYGuTS5W8ji
        VbyhUTDDkoVyDDERLedJMd/5BNy2r50=
X-Google-Smtp-Source: AAOMgpemZCuB93bwHaWGyksvkT/68jRWUmNmbk2ntEYVIOC5Tz+jRVxyw/2L4YfWcTLUdpwOQZ46uw==
X-Received: by 2002:aed:3d2d:: with SMTP id g42-v6mr3184911qtf.195.1531424407231;
        Thu, 12 Jul 2018 12:40:07 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:06 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 02/23] multi-pack-index: add format details
Date:   Thu, 12 Jul 2018 15:39:19 -0400
Message-Id: <20180712193940.21065-3-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
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
2.18.0.118.gd4f65b8d14

