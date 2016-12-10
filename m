Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24FAB209B4
	for <e@80x24.org>; Sat, 10 Dec 2016 03:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbcLJDVw (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 22:21:52 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35572 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbcLJDVv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 22:21:51 -0500
Received: by mail-pf0-f193.google.com with SMTP id i88so1889881pfk.2
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 19:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mrqiNX6SwNlocwAWsG5lHUTXTp0t3nn0itI/dAhS7oY=;
        b=jShLu/h4LybmtUEX/aUv+BZmKHYjYbCGCI4oZHFq6denX7m1ituMJ88mnUWvKno13K
         1wzKNABSa1QenRBJCVFbPl2M/f+VTcxoH3eBtkkwWxfYTt0IRo9E95loDNFbrvVS/JIF
         5w/pmAThMsheqa2VTxxIa9eYX53OThlP47QastHJqVQ8+dztQf7yh3WgpiUtyTjxra8F
         pqWLbl6Vh5fNji4y7ayjD8LI3yZggwBKlwZVWdIRtccYEh8hLjQJIfDAddtJ94Uot/sN
         7GMP4bwKqDmNqQ/YfKoEfefsaV93tqMzuEZ1TTbTxxpjWduCW2vE/bZZGMvGqEQQ8knj
         rarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mrqiNX6SwNlocwAWsG5lHUTXTp0t3nn0itI/dAhS7oY=;
        b=YrmgsD9zrj5PrFGacKF5clIvIzC5QCh0q85KNr0UG3F7qvIcZF4vAWCQ1nh9GO1K9x
         6BtRlci6gj+vMVx5E3uLU3zyDwz1k3NrO3rOr4hSDmP18t79cRGO6CGXPx3f8Yo2S/Nz
         UQ3O4eD2KMuL0zaDiXdCt0Ay5XUSlUGcRKepyU741KzCBJsyDFvOIVEFrXMB8bS7w6Cq
         aoAy3g61R9T8Bzm36oGGCyNEvOGuA/1Ad4ZHqZqCbYRrtAjjGhGG5+qwogPmlDauogiC
         Tb89IN+neni6PFP/pezt5Ob6HPmF/ZWCvguGb4ueavvUdRHeGvyWAq9B/Wmx/MziXbjo
         4Anw==
X-Gm-Message-State: AKaTC03u30sCLuvfplmQQ1n9JYSvi7fLnteIk3sVJ67ZP1MbOkr6rrC/lVJIR9uExbL/ag==
X-Received: by 10.98.4.134 with SMTP id 128mr86857593pfe.156.1481340110606;
        Fri, 09 Dec 2016 19:21:50 -0800 (PST)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id t193sm60916877pgb.4.2016.12.09.19.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2016 19:21:49 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: [PATCH 2/2] mergetools/tortoisemerge: simplify can_diff() by using "false"
Date:   Fri,  9 Dec 2016 19:21:44 -0800
Message-Id: <20161210032144.25503-2-davvid@gmail.com>
X-Mailer: git-send-email 2.11.0.27.gdeff8c7
In-Reply-To: <20161210032144.25503-1-davvid@gmail.com>
References: <20161210032144.25503-1-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This patch builds upon da/mergetool-trust-exit-code

 mergetools/tortoisemerge | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mergetools/tortoisemerge b/mergetools/tortoisemerge
index d7ab666a59..9067d8a4e5 100644
--- a/mergetools/tortoisemerge
+++ b/mergetools/tortoisemerge
@@ -1,5 +1,5 @@
 can_diff () {
-	return 1
+	false
 }
 
 merge_cmd () {
-- 
2.11.0.27.gdeff8c7

