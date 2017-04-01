Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 561D220958
	for <e@80x24.org>; Sat,  1 Apr 2017 15:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbdDAPbB (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 11:31:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35161 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbdDAPbA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 11:31:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id z133so3993383wmb.2
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 08:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LAA/EOkJ/qLj2SqUXplPD5dcqD0K0TX92A/fln4Zjh0=;
        b=EQNSE41x0dL8S7RY6j4pfhFouyF5UWkkslvNyCSg+KLAIPIWZK4Uw96wsC9Z/wgd3I
         ulBPxxIb6SeghGQ+s8tuznGZKhpPycQbT89AB8aIpE6FjEpFFj+LUIaHqjiVoGGG7neo
         LJcKpIKOsRcjDbDMWMQVhgThyIs1uCynqK9F0GTDNFtrCcvDcVcEsqqFS4Lyci6C8gLL
         OKSOJs9puzWuL6xegP9dzcL2HxBUs/rKMECDL5rJeA6pgyBIdPCi2X64azWRVDcT38Xd
         G3/vOI4stngxHzWvsNYYRTNW7DkVwhJTu/jzjh/am0z0cEXnGnh5BsGqiEQ3nJDlebjo
         S8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LAA/EOkJ/qLj2SqUXplPD5dcqD0K0TX92A/fln4Zjh0=;
        b=Snw3hRh4uKeLvQvuoJvewJODpymQEL/rBn3k0jrZ8wRghLP+dAKH0snySDFmndcycT
         eyVvR3OWlrTTwzVdl2X7rg/M4gfAolGbtCs5rkyWzuC+uJTG1K766yuP+v6ND2mp9aB1
         eZzwyiweay3OuB3k7Ucq53IgCrH4nG5/Yj5uwPU90rlvvBUAmExt1YUxhNlCTPpBgksQ
         iXQBJaP2O55TdwmwOWUE06dzwJHy7Mbepds7dayv+ILYZfNU2kMpQ/inYCqU4X8UqDgj
         +8Cs61wsZi91jufATAYksUi6YySp8A1lXXhZ9yU6Ye5mb0hZ9Mc0EFTI9mNXOOUEJcj2
         YGow==
X-Gm-Message-State: AFeK/H0PbL6jNK773vIdbi82BgsQdmzfupIbdOcXlnfa33tELC3JBDYx
        oJqJjK1ZrIerjw==
X-Received: by 10.28.136.81 with SMTP id k78mr2663260wmd.36.1491060659289;
        Sat, 01 Apr 2017 08:30:59 -0700 (PDT)
Received: from localhost.localdomain ([178.156.154.74])
        by smtp.gmail.com with ESMTPSA id y22sm10924192wry.51.2017.04.01.08.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Apr 2017 08:30:58 -0700 (PDT)
From:   Robert Stanca <robert.stanca7@gmail.com>
To:     git@vger.kernel.org
Cc:     Robert Stanca <robert.stanca7@gmail.com>
Subject: [PATCH 1/2] [GSOC] Convert signed flags to unsigned
Date:   Sat,  1 Apr 2017 18:30:48 +0300
Message-Id: <20170401153049.21400-1-robert.stanca7@gmail.com>
X-Mailer: git-send-email 2.12.2.577.g38c7602c8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 Unsigned int is a closer representation of bitflags rather than signed int that uses 1 special bit for sign.This shouldn't make much difference because rev_list_info.flags uses only 2 bits(BISECT_SHOW_ALL and REV_LIST_QUIET)

Signed-off-by: Robert Stanca <robert.stanca7@gmail.com>
---
 bisect.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bisect.h b/bisect.h
index acd12ef80..a979a7f11 100644
--- a/bisect.h
+++ b/bisect.h
@@ -16,7 +16,7 @@ extern struct commit_list *filter_skipped(struct commit_list *list,
 
 struct rev_list_info {
 	struct rev_info *revs;
-	int flags;
+	unsigned int flags;
 	int show_timestamp;
 	int hdr_termination;
 	const char *header_prefix;
-- 
2.12.2.575.gb14f27f91.dirty

