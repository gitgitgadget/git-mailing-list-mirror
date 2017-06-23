Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF5962082E
	for <e@80x24.org>; Fri, 23 Jun 2017 01:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753995AbdFWB3d (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:29:33 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33332 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753833AbdFWB3b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:31 -0400
Received: by mail-pf0-f171.google.com with SMTP id e7so16604733pfk.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JDcybFjxc0T/4dojFqcQZbqNYq22S5CI7HusdCP9fbE=;
        b=DO+jWvwFgPHrTQw/lXAgm20b9vKhmEUb5MMJ8j30XDe+L+srFMHLT0YGB+bptYgiP9
         GlNDX26Co+vVDg/OVXKv6oYIOg1whKRE1m+aZS6IdZZBpVATbbKtfQT74dq3nGIgRQtM
         7BQryfcmWWMVkCinabrKNWo7LSiA5WtogAsDVUiSLTPyd6PXi5yGWrHKwnNGixsWFQkB
         XG5lIIscgI+8lUPk7Zs/SKiJiiaPSoJdBf0vVUahHP8F/HbuulG4g7NYz0XtVZyUPhSy
         q222etL4Ixg0U4MspEzreK0vcFLcwjbPD/DUEpAWe/1+lS0/ShuPH9+x91bBVNwE8q0V
         qusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JDcybFjxc0T/4dojFqcQZbqNYq22S5CI7HusdCP9fbE=;
        b=jqXrKc8TXffjmqAUzCk/+BFcciediV3bP46WvfqT1XB8Mgy677pRi2QHdPtoys9t1K
         XPQeLPAFGOtxrnptXfmusVHX38GXMWpIESA8JHAL0zFr1fHGdXYd5LgbgJn+/hVgsvnT
         ZoPkqiFkm2BUnvPSBNNVyfHVaz8QmDfpyn1e2ciGcOD80c0Ea1J+MOCT7JgtLX5kqzdw
         xKxo11MBOlNfkhh3pHjro43BAMr6Coedh7VnKI8cjP11zmmFjI72uZroJa96UUhVPU26
         P6vD/iQQekqOUCIiYWR74rwmipGa3rC8YsxqrRfU3ljr3B3XAuUInVpGr/X/hIyXPcYD
         eIRw==
X-Gm-Message-State: AKS2vOz1NkDYD/8THh7VPByQbrEVe76E2jydQUonxsZ63g+45pR/71TE
        ArfLhINOFzFzZqsi
X-Received: by 10.101.77.74 with SMTP id j10mr5503376pgt.43.1498181370143;
        Thu, 22 Jun 2017 18:29:30 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id f1sm5646211pgc.8.2017.06.22.18.29.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 01/25] diff.c: readability fix
Date:   Thu, 22 Jun 2017 18:28:55 -0700
Message-Id: <20170623012919.28693-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have dereferenced 'p->two' into a local variable 'two'.
Use that.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 74283d9001..3f5bf8b5a4 100644
--- a/diff.c
+++ b/diff.c
@@ -3283,8 +3283,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 	const char *other;
 	const char *attr_path;
 
-	name  = p->one->path;
-	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
+	name  = one->path;
+	other = (strcmp(name, two->path) ? two->path : NULL);
 	attr_path = name;
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
-- 
2.12.2.575.gb14f27f917

