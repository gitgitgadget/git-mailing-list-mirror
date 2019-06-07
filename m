Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 769701F462
	for <e@80x24.org>; Fri,  7 Jun 2019 01:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfFGBJR (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 21:09:17 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:42242 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBJR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 21:09:17 -0400
Received: by mail-yb1-f202.google.com with SMTP id 126so552442ybw.9
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 18:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QaKWisSBtMZItpyjKoSYeSiVegbyYujFfLU9nQDY6a8=;
        b=dcN9SnYwlO0BPgJGM/5WSfvAzmWhdNABbjuG9fz+ylxyZo7iQe4oY1BJiNjb6DUki0
         F59A+SFPRxNBG6WThOR+H7ipjrXfB4Hr+NCxfYpqvHNK3D1GCQi54v2I/7Xw9x0Oyuvl
         E+77tbVZHXs/fXw3pW6BZredJzlChf7OEBlR0W5fOC3GuYlERHsv+H7wSXFtXdpPbwAG
         gaBd7fub/1NBtZUrKMBNXNhjwYjrvgE9hBQVcqWgM/R8qbrEKlIdNksYgBl7PtrpV4BK
         r1NcG4s9vWafCuNE6jDg1xOPSO+7gTVH+fvhqVzNOSJoAw+9ctVBvxW4AYx9fcw+eCyA
         1VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QaKWisSBtMZItpyjKoSYeSiVegbyYujFfLU9nQDY6a8=;
        b=e/qrlOSwugh1+cyTGKh4wZTLGp/LMU+tQiVIHFrOhjGTldAS2o1ZxoWdNmdB1eN5De
         Si9p77jn5Qgq7KY/e6emIl2Vew40YiT64nDxz01fd/VIb75aX933PxgKYqpBLCDhvJGb
         XfzjTwflonNmI1+xTHVc2aR4aG22sKZM9is4CRP7/kmPujG3DkncjA5LkEQwtjHYSrgx
         SLrjWtwwazOu/EBOIT+/dUcp1hDi6Mw0MGptnUZ14sSL5w+rPuiBhq1Kkj6/2GDKmYwD
         SgD0nrR3eTTuOMlYuWf/y4TFrzshFl09o1FfhWxkLjPuTrjhvyWA2BtebhaMoqkg1HM/
         hJKw==
X-Gm-Message-State: APjAAAXOjXwhEqlU4WctQba4ZuxlcvgSAzNqFnX/MKUwOfMHSODeswzy
        p/KTvbjr8vDPjzLnx4CMko6B9umP6y4aL32gn9PXSAfAHa94+RnLRHroY99EEymiVwpla+ig1mj
        zUPU6pAN4w8Z7h1GQhrFtCC2Yy82sjqf9E0pic0vOJm0NAlhfelof0i5iNMVsymienJir/7H5hw
        ==
X-Google-Smtp-Source: APXvYqxvgBCsI5rLSLYJ+eeB6FdUQPutp0S/UKHnBPfKpnExn4Fl4mHoTNri0oN7uynXU2DenpIBZgf3M6Jwk9QlSLw=
X-Received: by 2002:a0d:f144:: with SMTP id a65mr6009688ywf.42.1559869756599;
 Thu, 06 Jun 2019 18:09:16 -0700 (PDT)
Date:   Thu,  6 Jun 2019 18:08:07 -0700
In-Reply-To: <20190607010811.52944-1-emilyshaffer@google.com>
Message-Id: <20190607010811.52944-10-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com> <20190607010811.52944-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH 09/13] walken: demonstrate reversing a revision walk list
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The final installment in the tutorial about sorting revision walk
outputs. This commit reverses the commit list, so that we see newer
commits last (handy since we aren't using a pager).

It's important to note that rev->reverse needs to be set after
add_head_to_pending() or before setup_revisions(). (This is mentioned in
the accompanying tutorial.)

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index 716d31f04e..86c8d29c48 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -61,6 +61,9 @@ static void final_rev_info_setup(int argc, const char **argv, const char *prefix
 	
 	/* add the HEAD to pending so we can start */
 	add_head_to_pending(rev);
+
+	/* Reverse the order */
+	rev->reverse = 1;
 	
 	/* Let's play with the sort order. */
 	rev->topo_order = 1;
-- 
2.22.0.rc1.311.g5d7573a151-goog

