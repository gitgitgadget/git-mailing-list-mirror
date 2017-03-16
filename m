Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A20A320323
	for <e@80x24.org>; Thu, 16 Mar 2017 21:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754297AbdCPVga (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 17:36:30 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36115 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754288AbdCPVg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 17:36:29 -0400
Received: by mail-pf0-f181.google.com with SMTP id o126so30111204pfb.3
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 14:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TcECxh660kCWY60XUoUzMwlzZxMB5fkYvhE/m6JtrGw=;
        b=Rqj1+0Ouey0ip/CqE83FKvlAxICrRAMbmIhDu1oJwgsDqB7VmhS5yoepoo9N4EfZDu
         kkijEpGNpEPZz3dAbSzPBQp7Ibj2JuBnuF642SeUYQHhFrtFn4DLiNQuN1qPOx69GgB5
         J2PL871T+elPPg/9hoxVxgSuPcNQA8bAVCTLYXIUjONpQTU1DWZ3DwXNFk4XyQ0e9J/V
         Bec8pgNq0OfhMmB1csBK/dZqMkVS2ZbJcV0gd8MY/D4PXul1+KFrgUW79wKw3GruGYke
         avz/L0iAqhXyyd+ljztaPTapTJNzqGYAd05z+AVZ4n+qyW5xCxc1+0g8w9brT24ImO0B
         YXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TcECxh660kCWY60XUoUzMwlzZxMB5fkYvhE/m6JtrGw=;
        b=OKEMCuXx9F2nNQ8Ii27ceBNwpuaN+HqI+xmJcK8g6Sf53f2a7PZCF0pyLAs5aJo4Bp
         49EM5S+mZDqA3JI+eJLIKQsxJRCwG9+PurefAPPcs5jiu/ZjhUWxERybq/Y2xTkVeS7w
         R86PsTGLy4l+fGEptD4J/46xZdbX8XtqrLRxHosALlqU/bVvStkBVnq7aB2gdC3MT7Lk
         buXBbfJRK8ueNCU/w6EfzTrcIYPi5syvQUBiJD3us7h3izrgNpdujBd4ce16iwtkhRhI
         gvIPvBduf0DlxN7Z/FSZ+Djtk7V7OW/cV4mSk8DtMT0WSa6AyBPdHpcCFNXJHZYkPbhI
         YSvw==
X-Gm-Message-State: AFeK/H1vivR8xmHXNQnRuueSOfi4SmlWlUOhr9ZK4AWBgsAPUWpeb+N4gp22Ca2MdDFTjJx5
X-Received: by 10.99.176.68 with SMTP id z4mr12199920pgo.18.1489700187665;
        Thu, 16 Mar 2017 14:36:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:29bb:161:bf0d:8070])
        by smtp.gmail.com with ESMTPSA id b70sm12335289pfc.100.2017.03.16.14.36.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 14:36:26 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] wt-status.c: improve readability for wt_shortstatus_print
Date:   Thu, 16 Mar 2017 14:36:19 -0700
Message-Id: <20170316213619.30678-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.269.g1a05a5734c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 wt-status.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index d47012048f..a52d342695 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1785,34 +1785,24 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 
 static void wt_shortstatus_print(struct wt_status *s)
 {
-	int i;
+	struct string_list_item *it;
 
 	if (s->show_branch)
 		wt_shortstatus_print_tracking(s);
 
-	for (i = 0; i < s->change.nr; i++) {
-		struct wt_status_change_data *d;
-		struct string_list_item *it;
+	for_each_string_list_item(it, &s->change) {
+		struct wt_status_change_data *d = it->util;
 
-		it = &(s->change.items[i]);
-		d = it->util;
 		if (d->stagemask)
 			wt_shortstatus_unmerged(it, s);
 		else
 			wt_shortstatus_status(it, s);
 	}
-	for (i = 0; i < s->untracked.nr; i++) {
-		struct string_list_item *it;
-
-		it = &(s->untracked.items[i]);
+	for_each_string_list_item(it, &s->untracked)
 		wt_shortstatus_other(it, s, "??");
-	}
-	for (i = 0; i < s->ignored.nr; i++) {
-		struct string_list_item *it;
 
-		it = &(s->ignored.items[i]);
+	for_each_string_list_item(it, &s->ignored)
 		wt_shortstatus_other(it, s, "!!");
-	}
 }
 
 static void wt_porcelain_print(struct wt_status *s)
-- 
2.12.0.269.g1a05a5734c.dirty

