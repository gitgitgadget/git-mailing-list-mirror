Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B67131F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeBFA2i (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:28:38 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37573 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752213AbeBFA2f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:28:35 -0500
Received: by mail-pl0-f65.google.com with SMTP id ay8so137070plb.4
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Zm7zhnmLPg5QrIacIOPjEGUqXM6qWqgtmeIR5eqZys=;
        b=hLPUYqN/oOESMCf8iOYsd2mRAVI77qtMUsA084MRYSO3j46aOq43FB+hjozc4r7WmA
         GtbzP3RRLx1niSzdmFv6uLt6fkzoFWWxi1I8bWBI8Y+0bSoh3NdFnVnMCjwSmObeRS+F
         HllvDkQZcHg8AKUTwfxAEGKHJ/y6qkrtrX+A9h4irns4aw5jLoL0ig5+fngSNfdaHXP6
         e1DiZr29LoHLkfNHO5qIxchQVBqFEbz8Ubf/oMN1i92h8fYZHt5iC26Yb5mUXDfFFdew
         MF26EHW9e8PBmnyX+DyS9p06rFTZ70XWo519WbZ7ee01s89Ke0lhPs0WSIqlS955x1Pv
         Slpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Zm7zhnmLPg5QrIacIOPjEGUqXM6qWqgtmeIR5eqZys=;
        b=hmhDCpSN7uOQKeSbcjsZv9Ykoh8rsh2O/8RH5FSYAoBFd3RORgOiH7LfFal5iXzoBb
         23cry95GYv56ICRuODuTvjPt3JeYeYjTjJCSZTjYP6TPueEL9RIepktGKW9x7zJA2A32
         k16LToPk7vbOPdzwEdcUvZrRXsSLzZ8rzao+tux9E8Z/tfRCHdzqNULvKbFs5rskbHO3
         4FSVD5czcsoSmNXOTTQ5Qph+xwPyNQrouWqjMi5teI0roTmYSskvZWlr2vNVXnbGFpjM
         7Um6r27KD4wqfLHRMiE7Egzs5IF2PyxnPHx3dzHg80RtQ9AS3sfY8qwOfhtnAxIJQJJn
         4MgQ==
X-Gm-Message-State: APf1xPBcz7qfpNjNQAt6AtRlAVRUlRoEm+jyIP01levUWojp+c5u912P
        7c7vYnoaUPgh+FKWMOwK5LSYyoUQRuI=
X-Google-Smtp-Source: AH8x225suqCwI2Sp6yp5qE0s5pgS2qjCIDBuPiv+u+f1tUgXchJKTxEQ8+3K0csMPk5ZYcxUuWDbGg==
X-Received: by 2002:a17:902:7793:: with SMTP id o19-v6mr552770pll.207.1517876914779;
        Mon, 05 Feb 2018 16:28:34 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id n1sm5716935pfh.185.2018.02.05.16.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:28:34 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 166/194] commit: allow paint_down_to_common to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:21 -0800
Message-Id: <20180206001749.218943-68-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 3886266785..5454bb5e11 100644
--- a/commit.c
+++ b/commit.c
@@ -805,8 +805,7 @@ static int queue_has_nonstale(struct prio_queue *queue)
 }
 
 /* all input commits in one and twos[] must have been parsed! */
-#define paint_down_to_common(r, o, n, t) paint_down_to_common_##r(o, n, t)
-static struct commit_list *paint_down_to_common_the_repository(struct commit *one, int n, struct commit **twos)
+static struct commit_list *paint_down_to_common(struct repository *r, struct commit *one, int n, struct commit **twos)
 {
 	struct prio_queue queue = { compare_commits_by_commit_date };
 	struct commit_list *result = NULL;
@@ -844,7 +843,7 @@ static struct commit_list *paint_down_to_common_the_repository(struct commit *on
 			parents = parents->next;
 			if ((p->object.flags & flags) == flags)
 				continue;
-			if (parse_commit(the_repository, p))
+			if (parse_commit(r, p))
 				return NULL;
 			p->object.flags |= flags;
 			prio_queue_put(&queue, p);
-- 
2.15.1.433.g936d1b9894.dirty

