Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76064C43217
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 03:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJUDLv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 23:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJUDLd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 23:11:33 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544C215D0BF
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:11:31 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id l6so986624ilq.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NS5jnNvTpcFKtSvrcIw2q8cUIC7uZK6L+0C7KlbIWK0=;
        b=vJtpkwzpjYZDZVSyhqMhCJWmrGRJcyhHQzlq2dSIzZnJgy0/T79SEdwVauDuLP39vx
         ZXxjJPb6GwHTgcMwbc7mEXPwKicBK0SbqcYll6/YFr/go8bbRseTU+GIHZSruz1wRKI4
         Cvdo/l+Csa9FU3jb9xKuVdZqDpZPxMdIeNft1XQg4uwDcMy+VHbypx4GwOYAViTyovh9
         sKgoh7Fdm/d/7GSAvPQQPXkJY+KqjYEDjxjdIIipCVMIYvkrwOlcRkT8WvnpSwvzjfbc
         U2TTDHJrQtY5Jqjq307qq4W/1Grh9vHC/GFKpV6OJPp3MEx9gcuCk4f5nNjr2EcciAMq
         gGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS5jnNvTpcFKtSvrcIw2q8cUIC7uZK6L+0C7KlbIWK0=;
        b=vtsQOiIyPafwNA3hiA2bfnbOq6ADmWqRMkw6dbGJuzLcxiAKAnEGq9SRORTRcTyboY
         fOKN5YqpjSdcLNlZVIS+3nuGK9g3EVKYsftlKMObsMVif6WJAf4pb7w3T/BuB5v4VGCC
         Kq1NG0q5YNbAEE9fMXN8H+HOIwMYZMg0tUfS3YbHD2545Q9L07N33911MZRGJjyo1/gx
         /sXIC90djs92q6CeSemXU0EFmdKuixvx3iud2hpkfw8Zb7jscd+SA2KAb0xKtegSk/+Z
         RGUYt5OyvoGYz/nZVXjsJil8zB9b4pjlgfm8guUCI0HCgYud5WFEMrL6cOTLeLch7kTD
         6b/Q==
X-Gm-Message-State: ACrzQf0GKu9RqONPawgj7BB6/dQ+YG63X+0ntGxm4/8iuoAGwW3sj+g0
        P5xXl0Bil4zqNgOw/E55U0a6W1l7Fmy2x7Xf
X-Google-Smtp-Source: AMsMyM7YSCjiBqwhAEMRonP53Obi7IjMoExplS+B53m4iVQzdKH5uzgPPOpoGsbdCqHQ8KpCbMk2Sw==
X-Received: by 2002:a05:6e02:1a82:b0:2ff:3a41:4440 with SMTP id k2-20020a056e021a8200b002ff3a414440mr5116572ilv.231.1666321890530;
        Thu, 20 Oct 2022 20:11:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x10-20020a0566380caa00b00349d33a92a2sm3852740jad.140.2022.10.20.20.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 20:11:30 -0700 (PDT)
Date:   Thu, 20 Oct 2022 23:11:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v2 1/6] shortlog: accept `--date`-related options
Message-ID: <58baccbaa8612adae55f776ce10806809861270c.1666320509.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666320509.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666320509.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Prepare for a future patch which will introduce arbitrary pretty formats
via the `--group` argument.

To allow additional customizability (for example, to support something
like `git shortlog -s --group='%aD' --date='format:%Y-%m' ...` (which
groups commits by the datestring 'YYYY-mm' according to author date), we
must store off the `--date` parsed from calling `parse_revision_opt()`.

Note that this also affects custom output `--format` strings in `git
shortlog`. Though this is a behavior change, this is arguably fixing a
long-standing bug (ie., that `--format` strings are not affected by
`--date` specifiers as they should be).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-shortlog.txt | 5 +++++
 builtin/shortlog.c             | 3 ++-
 shortlog.h                     | 2 ++
 t/t4201-shortlog.sh            | 7 +++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index f64e77047b..311c041c06 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -47,6 +47,11 @@ OPTIONS
 
 	Each pretty-printed commit will be rewrapped before it is shown.
 
+--date=<format>::
+	With a `--group=format:<format>`, show dates formatted
+	according to the given date string. (See the `--date` options
+	in the "COMMIT FORMATTING" section of linkgit:git-log[1].)
+
 --group=<type>::
 	Group commits based on `<type>`. If no `--group` option is
 	specified, the default is `author`. `<type>` is one of:
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 7a1e1fe7c0..53c379a51d 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -211,7 +211,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	ctx.fmt = CMIT_FMT_USERFORMAT;
 	ctx.abbrev = log->abbrev;
 	ctx.print_email_subject = 1;
-	ctx.date_mode.type = DATE_NORMAL;
+	ctx.date_mode = log->date_mode;
 	ctx.output_encoding = get_log_output_encoding();
 
 	if (!log->summary) {
@@ -407,6 +407,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	log.user_format = rev.commit_format == CMIT_FMT_USERFORMAT;
 	log.abbrev = rev.abbrev;
 	log.file = rev.diffopt.file;
+	log.date_mode = rev.date_mode;
 
 	if (!log.groups)
 		log.groups = SHORTLOG_GROUP_AUTHOR;
diff --git a/shortlog.h b/shortlog.h
index 3f7e9aabca..dc388dd459 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -2,6 +2,7 @@
 #define SHORTLOG_H
 
 #include "string-list.h"
+#include "date.h"
 
 struct commit;
 
@@ -15,6 +16,7 @@ struct shortlog {
 	int in2;
 	int user_format;
 	int abbrev;
+	struct date_mode date_mode;
 
 	enum {
 		SHORTLOG_GROUP_AUTHOR = (1 << 0),
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 3095b1b2ff..7547da539d 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -83,6 +83,13 @@ test_expect_success 'pretty format' '
 	test_cmp expect log.predictable
 '
 
+test_expect_success 'pretty format (with --date)' '
+	sed "s/SUBJECT/2005-04-07 OBJECT_NAME/" expect.template >expect &&
+	git shortlog --format="%ad %H" --date=short HEAD >log &&
+	fuzz log >log.predictable &&
+	test_cmp expect log.predictable
+'
+
 test_expect_success '--abbrev' '
 	sed s/SUBJECT/OBJID/ expect.template >expect &&
 	git shortlog --format="%h" --abbrev=35 HEAD >log &&
-- 
2.38.0.16.g393fd4c6db

