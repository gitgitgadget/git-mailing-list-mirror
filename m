Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E18F520248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfDPJeh (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:34:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43172 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfDPJeh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:34:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so10046397pgu.10
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W3W1FhLdyUO50vG4zZkd9uJrGRDawVoKF5asVD25MyA=;
        b=uZHXB+ItDMlI+rn5U48ZqohI2J4A8IxfGKVXzsppf76bYXOk94oOXfkOH7YVc0N8DU
         Gx93OYs3XF9YME8y1qOdqjYPcXjdjZk5IGEHjJU5JSGa0jbL/6Z5AjixpUnhs2K8ce48
         dJvKU0SYruG9DeKRuolP0+bTb9dbaBLMnK3fbUUamzY2nJpqICzl/V7RbhhIks3+ZpdL
         9gk3aEylWnFIrjz4soUITEJfMVDzGusPJJaIymkDgT007NPvjw1mYsCER6KMxJ3FIUW/
         MpmU/UUTPHPxLDXy8Nl37uQ26gj1DDk1YYT1BVIXnVhq+LhMsDR6f8uUxpTQFtTCKAc6
         Tcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W3W1FhLdyUO50vG4zZkd9uJrGRDawVoKF5asVD25MyA=;
        b=to0+jzZccSUs0zW8Fi4lIQuN/FOo4p42uJ/b8iGDm2DqIALbX2u87Mv5HDoUDwJAsv
         fto3xAZmF6IUBGCseVxEmRQngTCHLJNqU34caNSBWRwWaPUhD4ds/ou96PHbSrWUYhRy
         10Xbw97MwLH+jDR7dAZ5UzwBF4mU/O0yZVvIx9kupgp9O94sO/V8GGIBhbGXMo/NEDjx
         GS4zLJzPvFaLzsXrOb29OD4I2cYUQ/Jf1xwR0dCwcTYybyZZCWqHvyROAlyO0ooRCaza
         1b6MX49xXx8NrpDOKUpFPfjCWymjIi+VLVEHTDrkrvgKbsFrB0KYjm28HxqcqJNHGBri
         0+mw==
X-Gm-Message-State: APjAAAWo9vRB0W2Vc0l6XkyDGFYz7aYvP6Afa0SWkOel2QOepb/VMllk
        0j67O8bD6W8e0iYzwvNwl3Q=
X-Google-Smtp-Source: APXvYqzfdP5LiRRm7PumAF3GrIDiVTiPPQObG1guvGrHGQURf89O14KmlR8MaaFeYfnbtqUux5Ablg==
X-Received: by 2002:a63:be02:: with SMTP id l2mr71393877pgf.48.1555407277081;
        Tue, 16 Apr 2019 02:34:37 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id c3sm96081855pfg.88.2019.04.16.02.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:34:33 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:34:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 01/34] builtin rebase: use FREE_AND_NULL
Date:   Tue, 16 Apr 2019 16:33:08 +0700
Message-Id: <20190416093341.17079-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

Use the macro FREE_AND_NULL to release memory allocated for
'head_name' and clear its pointer.

Patch generated with 'contrib/coccinelle/free.cocci' and Coccinelle
v1.0.7 (previous Coccinelle versions don't notice this).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/rebase.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 77deebc65c..868bcd1446 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1592,8 +1592,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				branch_name = options.head_name;
 
 		} else {
-			free(options.head_name);
-			options.head_name = NULL;
+			FREE_AND_NULL(options.head_name);
 			branch_name = "HEAD";
 		}
 		if (get_oid("HEAD", &options.orig_head))
-- 
2.21.0.682.g30d2204636

