Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A33702095B
	for <e@80x24.org>; Tue, 21 Mar 2017 13:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932282AbdCUNBR (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 09:01:17 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34371 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757131AbdCUNAv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 09:00:51 -0400
Received: by mail-wr0-f195.google.com with SMTP id u48so22367457wrc.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwDYwYqzL9attduLRhabFp5q+qQsLdNvkblQK4x5SlU=;
        b=tV75kqZQrQvcV0b5rZ6u78/I/pnss7fm3Caybc7+Xc9mHd8pgcI5Ku3+ulxAa2j2g4
         ydaimH9N1n6dfBPYRLN4N3YSmbHc7RDQZBoBxLea1rOwQRChDGzVUxIwt8fUveiZbRaD
         2YEG2+jyW6Kd1P60iDpSi+Leu6lrWCi3IzCBnyXgFDmBaAU2ECArwtRU68ceRzyPqFGW
         VZFH+o1ovrOfgL4YjH5DlRPA7GMn8/n84HHlHy+Ugd+8V93ddYkkYD4CezODs5/820WM
         ulZVVOTLpTqdm/CH10xZZJL9GiBxsNAB3dWzRf0xt90c/CT5eytWcqLhZ7jf4lhTElmD
         KDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwDYwYqzL9attduLRhabFp5q+qQsLdNvkblQK4x5SlU=;
        b=A67GfV8SUALY1Vupv5OiV9PWjPkYfnwqzV87eCHWcE+HGT2iGIegJI+ikrj05okQiG
         ZhVwn5XtUnAEKMkps9BPJJQXL3Ndxt9AzfQevg/P2VnL+o2zk7k8KqtmmpV9AMG/fNk6
         5d4Jv+qymZHi6mNKGJeXHQ83146L4GX1jLdSHopsC9tVUHrpIiFP2bs5qARuDgGVC0nA
         XHWuxdOJiC/NvJMB2SxiQUWi2PX6/b+HBFkl0fUIQ98is03J+YwxLu533aJoPLDz1GpU
         xG4mYZh94a6aLtdr6clcG4lJJI1OtDZ2z0Z0kQrITbCeyVh/1PH16yQJtvRwG2E9P0JC
         ipvw==
X-Gm-Message-State: AFeK/H1jCNHZoKerMRk4/vDCA/buFEhzJ5eFoQbuCwXCMdxGND2GKhIXusQGhH8B3UM3lQ==
X-Received: by 10.223.151.198 with SMTP id t6mr30827884wrb.9.1490101223567;
        Tue, 21 Mar 2017 06:00:23 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 63sm17555072wmg.22.2017.03.21.06.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 06:00:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/16] for-each-ref: partly change <object> to <commit> in help
Date:   Tue, 21 Mar 2017 12:58:53 +0000
Message-Id: <20170321125901.10652-9-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170321125901.10652-1-avarab@gmail.com>
References: <20170321125901.10652-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change mentions of <object> to <commit> in the help output of
for-each-ref as appropriate.

Both --[no-]merged and --contains only take commits, but --points-at
can take any object, such as a tag pointing to a tree or blob.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/for-each-ref.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index df41fa0350..1a5ed20f59 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -8,8 +8,8 @@
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
 	N_("git for-each-ref [--points-at <object>]"),
-	N_("git for-each-ref [(--merged | --no-merged) [<object>]]"),
-	N_("git for-each-ref [--contains [<object>]]"),
+	N_("git for-each-ref [(--merged | --no-merged) [<commit>]]"),
+	N_("git for-each-ref [--contains [<commit>]]"),
 	NULL
 };
 
-- 
2.11.0

