Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B35BD201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757667AbdERTiC (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:38:02 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33317 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754073AbdERTh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:37:57 -0400
Received: by mail-pf0-f176.google.com with SMTP id e193so28545774pfh.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HYFdFpBUP2Jrcw8vjzwQJDG4TZnJhmnGMZFZ247AIeg=;
        b=grD8z4ObPfkKjLMLGqUgBQyMx435o4hq2vW2R2rYFIe5C13MXEJ32ZT3od+XSZ6sSC
         zOnbXibAUDw/QeCXUFxuqg/SLxob2rlhDMXaEbmzhpYN1gL8ZEEO1iiBYqWVIHTXMjxB
         c9g9LqkO0h5jZCdGmIBgsZGSgbktemnZjt40NZ9c8sEkmBsafGp6yC/KYBSjWq/HfdVk
         fYm17FHYkFVdU8sgUmBNnfZ79LWKUszYIUZqYDh9XDdiSR/s02AGqPuinc0ujfIRFF/D
         XvkNpmij+J7By/uulUnr4xQMJK/8vLoL5vtyuaGdXdM78P7mUyLyle+CbWVv2blmm9E2
         Zy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HYFdFpBUP2Jrcw8vjzwQJDG4TZnJhmnGMZFZ247AIeg=;
        b=hR6h4LOTgx68Gg7g+BSODLT3PU5GRHK5QSsfQtfgE/WKrD2UDAeNq5co22iz3VJ6am
         I6JS9dWhIEfDHUZ62/j0Fugn3mYkWVSRqHbIK+5YA1lp7ZXijiQkdERMNJcUWU1hhLBM
         1qkmWPWDV676Ae3a+L5CzcPrSrC+b92WQ7LsV6wnauRi2Rx6h0MtwS5e56O0f5spRTqE
         YD7sendaoOx7f5fmgbakviCjq2PE+8AOPdHBne31ax3vFoNbe8wZOxfnvUZDzIbGBHst
         RI7oFu5j+XOkxLxP53FLURamluDaJcosLaW3YUdZ2eIZtQlUfpo71EGExQG4kHhVvvIl
         6doA==
X-Gm-Message-State: AODbwcCfD+wB/10NIa44CSh1IUxnE/m0Fv9Bb3CsaVzTZVP1w0vGrEte
        EJYhZjoH6pyGrqqM
X-Received: by 10.98.89.201 with SMTP id k70mr6248960pfj.196.1495136276431;
        Thu, 18 May 2017 12:37:56 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7013:588c:5765:703d])
        by smtp.gmail.com with ESMTPSA id a85sm11132637pfg.7.2017.05.18.12.37.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:37:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: [PATCHv3 01/20] diff: readability fix
Date:   Thu, 18 May 2017 12:37:27 -0700
Message-Id: <20170518193746.486-2-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170518193746.486-1-sbeller@google.com>
References: <20170517025857.32320-1-sbeller@google.com>
 <20170518193746.486-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have dereferenced 'p->two' into a local variable 'two'. Use
that.

Signed-off-by: Stefan Beller <sbeller@google.com>
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
2.13.0.18.g7d86cc8ba0

