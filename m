Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04F7A1FAED
	for <e@80x24.org>; Tue, 31 Oct 2017 00:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753754AbdJaAeO (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 20:34:14 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45198 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753723AbdJaAeG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 20:34:06 -0400
Received: by mail-io0-f194.google.com with SMTP id i38so31319420iod.2
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 17:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EI/4dmcppN42J3wIYQ5qmDIDXB89WuNctT9orOaERV0=;
        b=WnENVHxCrY+eZaQEfdyAS9qJ39emn9R1uGWCuQwBZbtFg1UKqpmDlkqtR5h55tzcE1
         QrWqXHWZw58B7fHERr6cB9dHdEICK3wJ5NfYIxxQUSmMMB3oa61ydl7NzZPMhEJRBhx3
         fPd/Mb4Y7J67vJAVN3q29/pVbjubt3/fNp0ZHGtx9gISauC1CxkHZC+RN69b/viesi5v
         XUm+HhSHDN0q63bUfyneezR4e6Lx8kAzXzWClh5aOfWxLXjJgxjfQrFMjr3c+WXIU1/N
         5mPZZGUQ+VcZLUTbQmf3FkPoYZXgimIzo5J+Dmup+z60veHPxXnViHSLqGbeiWSndtoX
         dlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EI/4dmcppN42J3wIYQ5qmDIDXB89WuNctT9orOaERV0=;
        b=MQmdq8id2TLHo+OlyUokb+6k5aMyAtYBbTCf1z+OBBlIr+RDGc/yPPXcz00cluMvw+
         9Cxb87X00cid3vDOj34LHbQLXc1MHKPHvi51hNcuqutYGKDYxXc7jBXOqq58LkrNT84m
         bNMRG1vqC6kokdAzPn/92aMIpohCCBRHbJEFg8nNzyGzmgwSvp3K5VFtGGohNhKjECA5
         soWswCOOCNrf0h5LLYcq2O5ORcIgrVvKpuoBb4+2jZYn6wqMW0ZfK3N8AfU8pRgKPi/I
         uHX2mlGOTw26WCvXvIDpY+hFUB0/RhlgzinBti6fy/FnDe8SZ9Fcn8X+afYDzBz2HiGH
         vQtw==
X-Gm-Message-State: AMCzsaVOVc42+Ly1Dxn8CZ7MXTMkAhsjsjFFq24lX6+Q+4I5iIo+tLci
        NvnRe/Y+lHg1A28vPl3kcRT8ug==
X-Google-Smtp-Source: ABhQp+RPKqrlw7X3FoB3OnbYmNMN4A2lS6uIO+qBSs73dMwt8XZGiUPInuE4PR2x2MhN7drGxY6mNg==
X-Received: by 10.107.104.25 with SMTP id d25mr213653ioc.290.1509410046057;
        Mon, 30 Oct 2017 17:34:06 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:58cb:1473:3cb:a95f])
        by smtp.gmail.com with ESMTPSA id s17sm97353ioi.28.2017.10.30.17.34.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 17:34:05 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, me@ikke.info, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH 4/7] builtin/describe.c: print debug statements earlier
Date:   Mon, 30 Oct 2017 17:33:48 -0700
Message-Id: <20171031003351.22341-5-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171031003351.22341-1-sbeller@google.com>
References: <20171028004419.10139-1-sbeller@google.com>
 <20171031003351.22341-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For debuggers aid we'd want to print debug statements early, so
introduce a new line in the debug output that describes the whole
function, and the change the next debug output to describe why we need
to search. Conveniently drop the arg from the second line; which will
be useful in a follow up commit, that refactors the describe function.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/describe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index fd61f463cf..3136efde31 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -293,6 +293,9 @@ static void describe(const char *arg, int last_one)
 	unsigned long seen_commits = 0;
 	unsigned int unannotated_cnt = 0;
 
+	if (debug)
+		fprintf(stderr, _("describe %s\n"), arg);
+
 	if (get_oid(arg, &oid))
 		die(_("Not a valid object name %s"), arg);
 	cmit = lookup_commit_reference(&oid);
@@ -316,7 +319,7 @@ static void describe(const char *arg, int last_one)
 	if (!max_candidates)
 		die(_("no tag exactly matches '%s'"), oid_to_hex(&cmit->object.oid));
 	if (debug)
-		fprintf(stderr, _("searching to describe %s\n"), arg);
+		fprintf(stderr, _("No exact match on refs or tags, searching to describe\n"));
 
 	if (!have_util) {
 		struct hashmap_iter iter;
-- 
2.15.0.rc2.443.gfcc3b81c0a

