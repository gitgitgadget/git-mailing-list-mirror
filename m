Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B90D1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 23:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfFZXvQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 19:51:16 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:35713 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 19:51:16 -0400
Received: by mail-pf1-f202.google.com with SMTP id r142so281489pfc.2
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 16:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dbeAs++P6lgwcZBiAdad7ATS/JYm4HxYSeUjqc8FQlg=;
        b=m+xNeUzkAsv16anNVWEY2/no6OBtVic407fK+s/tpm6HbDIEJcGTsID0RcuBhS2Gk2
         7jgYykfDK1nAjbw0TpPhBdrVfffsImG7UxD87fc5sO3XuMghijAkSkl2w8jdcO1nucve
         PSof4EHHNrShLUOCslR7ptu+JlnoubkuICLNjHs2K2E/zb644ke3D8xdshNCuk1Z0gWT
         9WDDtKX+SANmhXVcAIs/KPvC4Yae3ja6z3S8a8AXir8bm0jgr/j+xpS2UNZNSczaVBmV
         L6rOmz5yg2o/nODcs2mFh04UjZIT85/jW1nHIykKi6a6K/8J1pdL6cBfNJyIZWQqTsBx
         F0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dbeAs++P6lgwcZBiAdad7ATS/JYm4HxYSeUjqc8FQlg=;
        b=aoFr9p1Hsx/OVNlEqC528GAXEKsWu9/IxMcMqCDYV/UkrjJA+HKmpLrGbpcfLL5NJ+
         PnjaOH88miR5rJGaw9UEm2xIXcWDzB/9/gcYMfrwA98UB96aS72vRw7zw7mNTOsz7/HD
         P4ATbOKp1eJq5VeUi6Xq7cVIwsWJjF0TQgVxu+sSKfGSX6gcFZW3hg7Es5TbsgeliIr0
         qDU4pJ6RzEg6jNiLtEU6+Fm2B3PROJJfdy0XUnT5J1tjhhEVmLH/bY6V5blLuu2cAWXL
         PBNzAHegNoyfY7PuNYAyrzRt0RmK/0bL7aY8t+vAyuCqfLteNjtTI/LbsLJ8BbOhUCXs
         Ictg==
X-Gm-Message-State: APjAAAXd2TyLZwhijm7bEHYv+i4M3pUY6QUkujuEQkO4275HYI1hK5ss
        Fiqu9qPx6Mre/k3ThRYey7bTtUY6Zdr4VXFgjyr3H2thzHiEsCre3SxTWFGf+xkIMOM7XUNonCT
        dL3/eWmce3/MgVqdKXhwRH4ekvwor0hfgfxUOLRvP2MVyJtbp0Wx9GrrDIMPE45qQbdm8xqp//A
        ==
X-Google-Smtp-Source: APXvYqwZTX/T7VzHdFVr89lTSRYkefk8o0NKYz3jYRTSXwjXVkv6p5NEbzOgMpN6+vIQjmXmNP6wjlWB0s1no8Y8BKA=
X-Received: by 2002:a63:9a51:: with SMTP id e17mr651376pgo.212.1561593074843;
 Wed, 26 Jun 2019 16:51:14 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:50:27 -0700
In-Reply-To: <20190626235032.177551-1-emilyshaffer@google.com>
Message-Id: <20190626235032.177551-9-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v2 08/13] walken: demonstrate various topographical sorts
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Order the revision walk by author or commit dates, to demonstrate how to
apply topo_sort to a revision walk.

While following the tutorial, new contributors are guided to run a walk
with each sort and compare the results.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Change-Id: I7ce2f3e8a77c42001293637ae209087afec4ce2c
---
 builtin/walken.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index da2d197914..6cc451324a 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -69,6 +69,13 @@ static void final_rev_info_setup(int argc, const char **argv, const char *prefix
 
 	/* add the HEAD to pending so we can start */
 	add_head_to_pending(rev);
+	
+	/* Let's play with the sort order. */
+	rev->topo_order = 1;
+
+	/* Toggle between these and observe the difference. */
+	rev->sort_order = REV_SORT_BY_COMMIT_DATE;
+	/* rev->sort_order = REV_SORT_BY_AUTHOR_DATE; */
 }
 
 /*
-- 
2.22.0.410.gd8fdbe21b5-goog

