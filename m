Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D703202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 21:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbdIVV2X (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 17:28:23 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:43658 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbdIVV2W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 17:28:22 -0400
Received: by mail-pg0-f53.google.com with SMTP id u18so1227219pgo.0
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 14:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SkG2IVuLjyOszykzhKiDStytm2we0DeXcWnfoIjl+n8=;
        b=bHK3oRHYWEIMSoqQ4oKEHxtEI9xyalxC5bKw2pOpRx68F/CZMGbrFlUJmosSsfd0XO
         CKyahAbp/qucJ7M7A5QUeKbXADH01322EG/S9Eylc2KrQLXczh3+b3vwiWgRFU3OEe0R
         HPWi/GZZFra/Gmj+qenpKfQpSfpXi7Axpsa4UqGmvS/eN28VGDt11Gtc8kmlNzOFgaPe
         hRIzZEUe+SXfrZ4Vu0FcrA6CdPKw9Zjl6r9T7c0FyxoNzdQ7aIoZy/5Y7ReA/aOMnsg8
         GOofrBMI7gr1kobl0JN6Oxf771oOkhkSJhWFK0M4jn3TTlcAklfPT/MkYBjkTWxUmwe0
         ZOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SkG2IVuLjyOszykzhKiDStytm2we0DeXcWnfoIjl+n8=;
        b=qGF4ToruXdqJ0woMHBT18lI2NeGSjgs90EgYRHARcV7NQtxRnJ5TbuLrzz5oniR7Dw
         vahZf2H9ko3KvK3DspAFu1qAibpqzwWes/aZ3LdT4vGviFpo3zNKqun7tdRmb+YVj7vn
         uUV4f1QPBY9WaJMKh2bNIy8WlaZIAK7zu0FaV5S5gFTFWLcud3MMpCev+u13mTYUDPx2
         I4q4E4oN3MOu/NJwd9dnQ4pAutpmT3dMuvPNsOgO4OhPrzVtGWVsxQVENnpqbqTqHYD3
         xRZkjYXIK2GJLXwNB0Uzxcr6lQX6ysHLyEuf8+s3wRImWN9GUk6lA05jL1Dy5Dcm6yhL
         9B/A==
X-Gm-Message-State: AHPjjUiVn4yz9QN5lU4nnMV3HLbcU4AHeW3dnc0hft2a94bb5ASddhxo
        8C1vMTx+ZnulEb6g8ttzEv8oTOZJWGk=
X-Google-Smtp-Source: AOwi7QB+F9QgFkA3QHiOBIBMKkyyyKw+DLOjn31qPLdiV6PdJAE+5mezLe4Nua5bgwgHnpA/sUHMGA==
X-Received: by 10.101.88.142 with SMTP id d14mr410020pgu.36.1506115701106;
        Fri, 22 Sep 2017 14:28:21 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:d91e:db02:7f11:b424])
        by smtp.gmail.com with ESMTPSA id s86sm850885pfi.74.2017.09.22.14.28.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 14:28:20 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH] Documentation/config: clarify the meaning of submodule.<name>.update
Date:   Fri, 22 Sep 2017 14:28:18 -0700
Message-Id: <20170922212818.9958-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With more commands (that potentially change a submodule) paying attention
to submodules as well as the recent discussion[1] on submodule.<name>.update,
let's spell out that submodule.<name>.update is strictly to be used
for configuring the "submodule update" command and not to be obeyed
by other commands.

These other commands usually have a strict meaning of what they should
do (i.e. checkout, reset, rebase, merge) as well as have their name
overlapping with the modes possible for submodule.<name>.update.

[1] https://public-inbox.org/git/4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com/

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dc4e3f58a2..b0ded777fe 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3085,10 +3085,9 @@ submodule.<name>.url::
 	See linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
 
 submodule.<name>.update::
-	The default update procedure for a submodule. This variable
-	is populated by `git submodule init` from the
-	linkgit:gitmodules[5] file. See description of 'update'
-	command in linkgit:git-submodule[1].
+	The method how a submodule is updated via 'git submodule update'.
+	It is populated by `git submodule init` from the linkgit:gitmodules[5]
+	file. See description of 'update' command in linkgit:git-submodule[1].
 
 submodule.<name>.branch::
 	The remote branch name for a submodule, used by `git submodule
-- 
2.14.0.rc0.3.g6c2e499285

