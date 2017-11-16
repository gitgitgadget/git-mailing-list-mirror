Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00953201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 02:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933670AbdKPCBD (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 21:01:03 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:45879 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933634AbdKPCAy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 21:00:54 -0500
Received: by mail-it0-f66.google.com with SMTP id l196so4089028itl.4
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 18:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LhNIsCcME0XsXTl7aAaDIyDGnjAyi5m/IC5vqSFjXyo=;
        b=eXb0MWMkfCR12GPn5vVpNMj6mNTSKKzWg4ozm8MtZF31kgdX8QT4m5DenYN4CvsgzK
         90aLoq/y/ksGtkXyQiz5Xc68SjyfTq8Xu70axRJ9ZYF6GGAwP1VkIkbHKxIrHPQShIAB
         aiVxBzw/KPGhSrzdd6DnsM5xZzDfRPORgt/ZsCXvg/brvrRPMmtJs1oyx1XrRB5jRgfR
         jd0dl9WM9z9EbZEC+h2vnTsKNkIdv77UF9wgXnDeEuOXd4L1mOEeVSg64M48Hs08Nj02
         j0yGJlBBxq0Xvyemt3OgMD9OBAAjR3I7N7UC6D9srGbsQbZU26TQ7Jq3XCUaT0MhWqZD
         7OzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LhNIsCcME0XsXTl7aAaDIyDGnjAyi5m/IC5vqSFjXyo=;
        b=ZFUw9aJ8j8M0pEn7H7gtbqppX98ZrdpWdUmKgSevoIsP+xAQRiL33lSkw9UAxdBSqf
         JMJERs+sHmbz1v0Q2I1JEvCJ54VHjuMppsMfSH3zQZCnlRq+HF8vI0C/8y/uRjIc8GL0
         HeZ0dbYToBGiHIOA7xrGl3Hgz/1sSXfXQdZ1tVX5weOyWkEOmHSiMKUkEaHrxGABpVhg
         jG7vt2T9ba3eeKXeNjcBAx2reyM4kkQHc/3CNLAdEb50rdQ7dcNsrjEePNpIsws7OmiI
         5EQmAlyk525zClqi0RD4cXto08aX2Zq0AGT+y08Ssipoajqzg9DAGAXa5WGRQv9OQ/82
         EVJg==
X-Gm-Message-State: AJaThX6XYo3TYnZ8d1nQV3IUWuYiUujCVgvaWeGxspkEkoKEHj3MGT2D
        niDMRGpiUOu0b1/Qk2G+FT/J7j/LVOk=
X-Google-Smtp-Source: AGs4zMZccer5toMR/zxze2JGNHmTedXNeZ0BAKoowIKKohv6PYbSlHyfEUZDQ3liWBiS70AYxkXV6Q==
X-Received: by 10.36.17.193 with SMTP id 184mr554103itf.68.1510797653688;
        Wed, 15 Nov 2017 18:00:53 -0800 (PST)
Received: from localhost ([2620:0:100e:422:34c9:3de6:9af7:a340])
        by smtp.gmail.com with ESMTPSA id k23sm190119iti.22.2017.11.15.18.00.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Nov 2017 18:00:53 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 4/7] builtin/describe.c: rename `oid` to avoid variable shadowing
Date:   Wed, 15 Nov 2017 18:00:36 -0800
Message-Id: <20171116020039.17810-5-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171116020039.17810-1-sbeller@google.com>
References: <20171116020039.17810-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function `describe` has already a variable named `oid` declared at
the beginning of the function for an object id.  Do not shadow that
variable with a pointer to an object id.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/describe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 29075dbd0f..fd61f463cf 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -381,9 +381,9 @@ static void describe(const char *arg, int last_one)
 	}
 
 	if (!match_cnt) {
-		struct object_id *oid = &cmit->object.oid;
+		struct object_id *cmit_oid = &cmit->object.oid;
 		if (always) {
-			printf("%s", find_unique_abbrev(oid->hash, abbrev));
+			printf("%s", find_unique_abbrev(cmit_oid->hash, abbrev));
 			if (suffix)
 				printf("%s", suffix);
 			printf("\n");
@@ -392,11 +392,11 @@ static void describe(const char *arg, int last_one)
 		if (unannotated_cnt)
 			die(_("No annotated tags can describe '%s'.\n"
 			    "However, there were unannotated tags: try --tags."),
-			    oid_to_hex(oid));
+			    oid_to_hex(cmit_oid));
 		else
 			die(_("No tags can describe '%s'.\n"
 			    "Try --always, or create some tags."),
-			    oid_to_hex(oid));
+			    oid_to_hex(cmit_oid));
 	}
 
 	QSORT(all_matches, match_cnt, compare_pt);
-- 
2.15.0.128.gcadd42da22

