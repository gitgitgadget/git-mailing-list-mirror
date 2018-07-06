Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A24941F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 00:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753677AbeGFAxd (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 20:53:33 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43989 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753537AbeGFAxb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 20:53:31 -0400
Received: by mail-qt0-f193.google.com with SMTP id f18-v6so8712249qtp.10
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 17:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JllXlHiTTXfCpAkbsyBvwg6tFPTlBNxPcUSwqJCaXQs=;
        b=CHrpE7K/bYuTEfKopnh77Ayf0+jwpNnIhejmMXnNgfIMJjyF52Xg7Uy9y156jvom8P
         4tSUoJ2Tly1+1CQGNxyZAg7N+rNbiBso2r8oiim546lbOejWIe0qOASW5R+D+z8ovzW7
         zyjJ645Wbl6aKUGrLca7uHYVGnLt4ErUnlvs/2faBiiVALSFi5LzWGV32DHQA9vKazfx
         PP29MiM1kESZNpwd1Dl5sdeWYyono1udzfyjvvN2m0Xs4SVWJeHSQYVwD/yXOJJ127j8
         y4+uRDGnqqbQ7AJv7jUfzS4fc560+Lm1G2O/QLz4LMHhOfZo6GsVvxMiNHnneFyaSeRS
         A4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JllXlHiTTXfCpAkbsyBvwg6tFPTlBNxPcUSwqJCaXQs=;
        b=uMyD/wGAc1kZhvNveKiAhbBvxq+DMTPD//x4q9wzldn1UFp1nmKVrZK0hixk9Eo8s9
         Gcssr7cAPbf/uP8nQSp6GTsSfe5zf3dpzYcCVUjCBibg9hweYIaPSS+XdWJ/nb+uGa+M
         JafZFqWeW8vx4WeXy4ATRTYFtvFkaafxcZkWiNh6BwP0tKxt+8Ib45sNg2pg44ch1RoV
         F5UEfOklJJSCx3ymiCxSp6dMroJJuqAcs3monBOb83FOObEn/7xA3SCTlr4b0jYQBADi
         vY6k1qcI8LGBcGkM1zSTe+haH4xuS9mbstb0rHYGob5EpNInms6vdm8kAWNmuV+ogUug
         oz1A==
X-Gm-Message-State: APt69E3geTvClio9wZJ6dgMAwrdIfiWkzzIuNv7F+nA3dkoJLcLnwXDM
        SeeqvWSfceom5lebY0dhJ1H9G1Mn
X-Google-Smtp-Source: AAOMgpcFn9gu6Njy0XM7aUmmO3MNe6YDdYAlCzM9xal5a3qH3wSf53ORyJEAYbnqxHrGR9knG7lxTQ==
X-Received: by 2002:aed:37c2:: with SMTP id j60-v6mr7530594qtb.417.1530838410056;
        Thu, 05 Jul 2018 17:53:30 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4882791qku.3.2018.07.05.17.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 17:53:29 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v3 02/24] multi-pack-index: add format details
Date:   Thu,  5 Jul 2018 20:52:59 -0400
Message-Id: <20180706005321.124643-3-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180706005321.124643-1-dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
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

