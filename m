Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D60A01F461
	for <e@80x24.org>; Thu, 11 Jul 2019 18:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfGKSHT (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 14:07:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34538 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbfGKSHS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 14:07:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id l12so5244342oil.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 11:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ql+1M1X+uH6O7JjHfE97tWCvISHIa5cdnRwNP2RM9FI=;
        b=AdJB03QBYzPTmMzY3M7tyhF282R9gcnFYEOPu0TCK4dZMl/Z7nXBM/E1t8gVVXwjJ4
         AvazZE58uH3AO0ROueP/m0axGdyjiYh37xGS5qXmO7ho/hoc5S7ajTVhOosr79L8ahaf
         2AQHRV5fCcQD1h+vmpnL1esJpZBcYbUm98GWZuSMZsTdyeVk7QzaCnC7OwdDx3Uz8lKg
         3IunuTVSwokhXnjXQ8xj//diofO4sZjZVrHVPvkP4Eo1VaeV1X+xexC/QPm74Z01AFly
         09qiSDsCwJhMKG+iLRsKIiwyfgRqImp/nqYL/BJDpODD9zn928YsMwysdMmgJEw3swzg
         mMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ql+1M1X+uH6O7JjHfE97tWCvISHIa5cdnRwNP2RM9FI=;
        b=mhZm4sWQE5iqZaj2dGHpl6FWWdCqg/bKPzluK0sZzZQIl+urRljN6nbHTx8AT6TMp6
         fa8AV54oCJ0ip5OHoYVUho7ROoQKZiVy0tZ6A+wDP67vp8XOxtiCKYg7ax2D9WGvkOi+
         IS68r9VhRx+juOZB/Z6BGGlFnmI+8gIxYvLLHaOFVKjYA5+/XuqXpYBLR34qBwls01wP
         65Hyyjq9DEmU4yQTx/yprPL2jGnFVCD/wdsMobb5awg396kdGtU3edTfqe79Y2nV9Dh1
         TbCXSiVBN7UYuAF01EsfNkLWcBsJQAegjb5k397E+pax3y4UaMynaJxULSVXZsQ1evLS
         Il5Q==
X-Gm-Message-State: APjAAAUPkqTfdriW/HmS9dZJRfT8ETC1/P1fsv8UudSv/zRFMvMAb39V
        0N3yd2NKVlfYRKNH10Vzpa4KnZaT
X-Google-Smtp-Source: APXvYqw1l6Oc2j0OmA12YPvupmK/VBEJ7tJ35fuAaGT7lIwZOyXJ7AAeQxUIZoqTE0xuFCbrSpOtTw==
X-Received: by 2002:aca:dc86:: with SMTP id t128mr3334016oig.130.1562868437681;
        Thu, 11 Jul 2019 11:07:17 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:5d50:4f59:ae8:3eb7])
        by smtp.gmail.com with ESMTPSA id 132sm2131545oid.47.2019.07.11.11.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 11:07:17 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v3 2/3] log: add --no-use-mailmap option to complement --use-mailmap option
Date:   Thu, 11 Jul 2019 13:06:43 -0500
Message-Id: <20190711180644.30417-3-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711180644.30417-1-ariadne@dereferenced.org>
References: <20190711180644.30417-1-ariadne@dereferenced.org>
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

