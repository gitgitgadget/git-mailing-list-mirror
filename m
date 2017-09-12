Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A143C20286
	for <e@80x24.org>; Tue, 12 Sep 2017 10:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbdILKbP (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 06:31:15 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34501 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdILKbO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 06:31:14 -0400
Received: by mail-pg0-f67.google.com with SMTP id v82so5966545pgb.1
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 03:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=XlKmqen7DUX9VQ/mmN1mEMHLgwFVQBVUGA8XAhdTd4I=;
        b=jWi01oF2kRbryjOpZu2QRme4xwb3WDUtQRUeFecfVe3aBgRlrjYExsyPxfoekAaWBf
         UqvrxNqw3ytlM0hjXO3Z+6dtLEYKL0SvDRJY+/jBOukDG/BP9l1OhZRS4Y7hXmsDurun
         76YnQnC+P7/B5PEMSp8YyeEDAdBcH6KcFwqbiiO6qZHMxZv5bmUDS060CV96fBj8q26J
         0//yibYObi5ttc6CVjgGGJNCpc/XPhBIWmPlEBsZajB1P7rjVl4cT1wCj9aZaeMc1/NF
         93P8lkKwJuRsWclLnIUuUrAKBwJrWCejhEnsSmXKefDx7J2jEvgfhDL9aKBuZHnhvJQ4
         ev5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=XlKmqen7DUX9VQ/mmN1mEMHLgwFVQBVUGA8XAhdTd4I=;
        b=GXw/8+UITRGUkgVn+ZN6xcc5OVF+qWnkPSBTMCmm+y7bBmB+f4/oaPmu8vOfCw1gaH
         yzPW36bAxE81OT9SUYeltEhzu+/9+nRkuYNXJ3UxkfYbiaYx9enqw2yiQ/JtLv4n6Ahv
         NlRaaOS6UXBK/Kt+nQ9njtayCcFw21v+EKO4Uf5SmkRR/L5LaJKOcxAtvzZn1XqVECYy
         CpNx+EXzzgT+CIhlPqEdu8FCkfYkEyA7bMtmGyWXV76v/LLAJ6sV0nklETRBAzK25b/X
         h5KO5p79h5rAhTTMjNvJloUI990PXf6j2uYqBmRxBOldtlnv5pzfbZGsTOFp+yO2y5Oi
         rBmw==
X-Gm-Message-State: AHPjjUgVxXhHLZFeaDp9Xi4CMPlR7YGGwCzxShZdMQ8a6p9DeKdFKI9L
        kZqtZ+0a2WnFSCAKvE+RgQ==
X-Google-Smtp-Source: ADKCNb7nLjuNSvpWNWir3zLs3IE0rBoLfJc/csU5GgzqpJIuFn1uHVC+cOWQ7Sis13aJWlwZHo6Q1w==
X-Received: by 10.84.133.37 with SMTP id 34mr17178224plf.362.1505212273934;
        Tue, 12 Sep 2017 03:31:13 -0700 (PDT)
Received: from localhost.localdomain ([117.209.154.179])
        by smtp.gmail.com with ESMTPSA id m87sm20104341pfi.122.2017.09.12.03.31.11
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Sep 2017 03:31:13 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH/RFC] branch: strictly don't allow a branch with name 'HEAD'
Date:   Tue, 12 Sep 2017 16:01:04 +0530
Message-Id: <20170912103104.26856-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.1006.g90ad9a07c
In-Reply-To: <xmqqtw081kep.fsf@gitster.mtv.corp.google.com>
References: <xmqqtw081kep.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allowing a branch with a name 'HEAD' could trigger ambiguity. We could
avoid this by checking for it manually. Moreover this has been done
partially in 8efb8899c ("branch: segfault fixes and validation", 2013-02-23)
There was still a way to create a branch with name 'HEAD' by using

    $ git checkout -b HEAD

Avoid such loop holes by 'strictly' checking for a branch with name HEAD.
The check is referred to as strict because it's done in a place which is
supposed to be called to ensure that a new branch name is a valid one.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 branch.c         | 3 +++
 builtin/branch.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/branch.c b/branch.c
index 36541d05c..ea1050649 100644
--- a/branch.c
+++ b/branch.c
@@ -184,6 +184,9 @@ int validate_new_branchname(const char *name, struct strbuf *ref,
 	if (strbuf_check_branch_ref(ref, name))
 		die(_("'%s' is not a valid branch name."), name);
 
+	if (!strcmp(name, "HEAD"))
+		die(_("it does not make sense to create 'HEAD' manually"));
+
 	if (!ref_exists(ref->buf))
 		return 0;
 	else if (!force && !attr_only)
diff --git a/builtin/branch.c b/builtin/branch.c
index 16d391b40..c86348d4c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -762,9 +762,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		int branch_existed = 0, remote_tracking = 0;
 		struct strbuf buf = STRBUF_INIT;
 
-		if (!strcmp(argv[0], "HEAD"))
-			die(_("it does not make sense to create 'HEAD' manually"));
-
 		if (!branch)
 			die(_("no such branch '%s'"), argv[0]);
 
-- 
2.14.1.1006.g90ad9a07c

