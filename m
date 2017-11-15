Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C420B202AF
	for <e@80x24.org>; Wed, 15 Nov 2017 00:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756517AbdKOAbP (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 19:31:15 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:49336 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756224AbdKOAa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 19:30:58 -0500
Received: by mail-io0-f194.google.com with SMTP id x63so14189512ioe.6
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 16:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1MOggtfYOemBaG1ZGxZt1qU0yamYZIvzEWbJh7sWmBw=;
        b=LGb+HKp3l/BwzXLJa4sdhTQ/p/9BJLp8UAeGPmvOVEjSmbAOyxWe5uJFHrX2JcC4jq
         dZYfYqkUfZGh0Z/4RgR5Qu1vitZTvQKLt/QV6zS2AOUN5vVnYPo36MxdnLY78ERVRCv3
         ZAC8G8peAm2Vj8Yg8hsKK0jIAMO+aq527JZU40cKX/DXw1cYcuoak+ndYgUqZS6WTVMx
         XRYSaARof7jHZ0o2sMMk6YpuvKKciSbyfgwUad6EZAfVztYOFrV9UxNYVG8hH75i+vQP
         zfc+00tMEY/6pRiU/Q8AOV6c5es/c2kI08CS0o4X//AklXDT3p8+DhN1hrlXgwFetvZH
         ZKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1MOggtfYOemBaG1ZGxZt1qU0yamYZIvzEWbJh7sWmBw=;
        b=FtfDxyQbmSxj77yu15RDNCtDMS/xeEJzx0Dmi9RF+KJ2RVbK87NZmdxhB1x0WUCM1c
         5m+Wk+vYG2DyjLPhoiLYaNQrFifC8WjZszTQtNd9zgDrv1WzinXlh6p6ILDu4dzlt0hE
         4Mh8lPn/i6wmbfZ1/5mU01YQJ38Kk/DC2qRrMdeyz2v1x7+PU94QFv8mzuGfieKBILop
         u7Wr3skWPvE8Fp88DpqEcs/wjIrZSmOF1/4AZcIJk0aL9SjVPqfVQ2n7KUWPN6IWd34x
         4goyy9onEtYSQdE+Nzb2qcHBzCX/QaDw0j+5yum1CZqF5KR3fS8gT01zDW7GlINpdg71
         D2cw==
X-Gm-Message-State: AJaThX4bBfgVAMoH8jTnSgBRmXHFRrqmrBt0S/kREnbV2k8OdREV00dT
        jBMFUPZs1vZyM7xH6p2SppNWNLfsroA=
X-Google-Smtp-Source: AGs4zMaEtum7KaU/mma7Uk3wAy7mUe58I40hMVpcb2zFvVTpTrUQCg9+UNnpnelblY1htVoqRrQxLg==
X-Received: by 10.107.43.75 with SMTP id r72mr17270877ior.31.1510705857681;
        Tue, 14 Nov 2017 16:30:57 -0800 (PST)
Received: from localhost ([2620:0:100e:422:c9fb:9110:c737:8943])
        by smtp.gmail.com with ESMTPSA id d14sm3531943itj.11.2017.11.14.16.30.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Nov 2017 16:30:56 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 5/7] builtin/describe.c: print debug statements earlier
Date:   Tue, 14 Nov 2017 16:30:41 -0800
Message-Id: <20171115003043.24080-6-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171115003043.24080-1-sbeller@google.com>
References: <20171115003043.24080-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For debuggers aid we'd want to print debug statements early, so
introduce a new line in the debug output that describes the whole
function, and then change the next debug output to describe why we
need to search. Conveniently drop the arg from the second line;
which will be useful in a follow up commit, that refactors the
describe function.

This re-arrangement of debug printing is solely done for a better
refactoring in the next commit, not to aid debugging git-describe,
which is expected to have the same information readily available
with the new prints.

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
2.15.0.128.gcadd42da22

