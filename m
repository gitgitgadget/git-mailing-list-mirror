Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C6B41F461
	for <e@80x24.org>; Thu, 11 Jul 2019 17:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfGKR0p (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 13:26:45 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42422 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKR0o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 13:26:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so6646640otn.9
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 10:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ql+1M1X+uH6O7JjHfE97tWCvISHIa5cdnRwNP2RM9FI=;
        b=DsulP5m+9i6oqJqogE2gXX5SMKhRvACNTsCN8I3bziG1gyGPtUWl+7g0/Yy50Ayls+
         3a4ZVyQYkCtqUebT+0a3Xxf4uJ5Pje2BEAImsRm2PrjeYKrTsFboR/60qlZF6kr3hyka
         QE/zaISvM0c+Q2i4j5QX2c/WbbjL1Yh3XhHuXHSSM7l5RgQcVNtT4sAP3ZFDvQ8v7iq7
         sgZtYYJrdf93bv5+CZ7fEezXc1bh8Wn8aZVvtLf1aPmCdOkWEwz/QrJJWKufhEnpyYuk
         3/RRVhqEBr/Yi87F9gYl45xQMLzS6gmBm4UZu9BbukR4WYoAQgwdhll+Z/r6X1sT9rwW
         ndNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ql+1M1X+uH6O7JjHfE97tWCvISHIa5cdnRwNP2RM9FI=;
        b=Mfv6tCMCyGNwvkuyOku8PyLdgCkgsAMzSjRErDGchgvicChySn1kwckLiu327TXWfN
         TtibIapb+OO14jk3XHupPTP0OV/kNjkRHeJpRM5Xe3HoIMF264uyk3JTrRZFhw6DxMzk
         uDfx1+QgiC/QsOIjWSV/wOvMw2a8HhsteJDUkOL3XVFVG9zGqg9VpcY6pHZeWtjDeSOd
         lqHLzFco2nBawuqpjBf/ML43wKQbR5x75jFTMlz43IsFJzOGLaTpVWeAvOugk0y0Ih16
         6Y5JQhAJ3VnwPlxWOA7jl6Dwp6Y9oUjGvNJYxdN+6wnowS58nWVxJcMgrWW6Iw4rCfKi
         3JBQ==
X-Gm-Message-State: APjAAAVNjBx/8yEzoGisKbqZM5ipMj1ELJEnVf6Uzol7PtzFo6KGuk8c
        GDGzXIC+q6QugMJwuZ00Ub10ZHFS
X-Google-Smtp-Source: APXvYqw6fYoMnBGwheECYqzzbveoKmjH/v6oJMelJFDcfPHPSvaXIwDkFFFCIwcJXRyA5++rB4qRTg==
X-Received: by 2002:a05:6830:1294:: with SMTP id z20mr1171934otp.0.1562866003923;
        Thu, 11 Jul 2019 10:26:43 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:5d50:4f59:ae8:3eb7])
        by smtp.gmail.com with ESMTPSA id h11sm2045933otj.76.2019.07.11.10.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 10:26:43 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v2 2/3] log: add --no-use-mailmap option to complement --use-mailmap option
Date:   Thu, 11 Jul 2019 12:26:25 -0500
Message-Id: <20190711172626.16480-3-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711172626.16480-1-ariadne@dereferenced.org>
References: <20190711172626.16480-1-ariadne@dereferenced.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When mailmap is enabled by default or by configuration, it may be
useful to override the default behaviour.  Previously, it was
possible to enable the mailmap feature when it was disabled by
default or in the configuration, but it was not possible to disable
the mailmap feature when it was enabled by default or by the
configuration.

The --no-use-mailmap option equalizes this by allowing the user to
explicitly enable or disable the mailmap feature according to their
requirements.

Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
---
 Documentation/git-log.txt | 5 +++++
 builtin/log.c             | 1 +
 2 files changed, 6 insertions(+)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index b02e922dc3..50bc8f7da2 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -54,6 +54,11 @@ OPTIONS
 	addresses to canonical real names and email addresses. See
 	linkgit:git-shortlog[1].
 
+--no-use-mailmap::
+	Do not use the mailmap file to map author and commiter names
+	and email addresses to canonical real names and email addresses.
+	See linkgit:git-shortlog[1].
+
 --full-diff::
 	Without this flag, `git log -p <path>...` shows commits that
 	touch the specified paths, and diffs about the same specified
diff --git a/builtin/log.c b/builtin/log.c
index 3d2ce8fa3d..a9195bcb34 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -167,6 +167,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		OPT__QUIET(&quiet, N_("suppress diff output")),
 		OPT_BOOL(0, "source", &source, N_("show source")),
 		OPT_BOOL(0, "use-mailmap", &mailmap, N_("Use mail map file")),
+		OPT_NEGBIT(0, "no-use-mailmap", &mailmap, N_("Do not use mail map file"), 1),
 		OPT_STRING_LIST(0, "decorate-refs", &decorate_refs_include,
 				N_("pattern"), N_("only decorate refs that match <pattern>")),
 		OPT_STRING_LIST(0, "decorate-refs-exclude", &decorate_refs_exclude,
-- 
2.17.1

