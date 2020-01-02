Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DD6C2D0DF
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 03:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7892D215A4
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 03:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e94wNAzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgABDEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 22:04:05 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34424 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgABDEF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 22:04:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id l8so38039869edw.1
        for <git@vger.kernel.org>; Wed, 01 Jan 2020 19:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ikrqjXAuLHo1mDOVjL4hvvF4p0HJEbGpWWvFmq/hkEw=;
        b=e94wNAzdXlhuNJ9Q7LUNaCiWCRmAO9AaDOqezF2z+LUxpnLZCTNKF7QT3Bh4oYBt9z
         zlUAuOgUCQ7M/j323LjKjkzlVouAjc2Qp6b/fE4WPfPkTtxL5sWPU3wq0qqRuuJchy5f
         +V7GLM4X8eXobncsSXFxowygyf8J8lwAA+CT73ZSzA3MEPevNK9fE4SgLIyLXETZ7YeF
         5aqfyMLjUk7GMbJyewLHBJugXFe5COwty5nZG8VhjB+4622TF1z77Rr86j1NIh8xy4pw
         91xPjeNOmz1ZspVrbmZ2Kln8Yvg/3tbN4IySS6A5V6KiaLAWnHmox5PxF1R1aVDT6jP0
         1DfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ikrqjXAuLHo1mDOVjL4hvvF4p0HJEbGpWWvFmq/hkEw=;
        b=ghqooMN1RjMhReyNBX1Uzjc5DmpNn8G8qM9Tc48GxUnOS375ebvFDUc8ApE7SX+7mu
         /SkrxQjN/HtqV2mYfqCkTpJTog+dmrwEIqBu8p1gJu+p4OwxkhUwR/nvzumeaV+OFwMS
         fmt1eJC3qnNnf4iztMAwIfY2vvE6n5PSIo3PHy9wNU46ClLpULzCWTKXqix5Tjj5ZMl8
         brlezFTA/Gd9eCMEgc1Dd7ovncJl9NPXOlIF6xbLXgSVspqSIxPbpXozvWCeKTFnHNZu
         H7Ia4X97Aq5dmYRmqlQRiqsQWK6THR69C8BtwOST6wpV9XYwpeC1nBIxHpwgjHstJb5y
         weHQ==
X-Gm-Message-State: APjAAAWoTkPl8Z8zDhQXaXTe6cR24bj1C6JksedEXTM6CkawTK5RNBZQ
        O1qO7BQR+yzxeTWK18vfJwy/WqQl
X-Google-Smtp-Source: APXvYqzcmNmed312MJisWBOj6GR38H6T1CL5ZY1uYG9DdAkrcr3fTLB4fMZk+kipXkVuSfS1xuRq6w==
X-Received: by 2002:a17:906:3ce2:: with SMTP id d2mr17483726ejh.292.1577934243202;
        Wed, 01 Jan 2020 19:04:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id qc1sm5077758ejb.49.2020.01.01.19.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 19:04:02 -0800 (PST)
Message-Id: <90608636bf184de76f91e4e04d9e796a021775a0.1577934241.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.508.git.1577934241.gitgitgadget@gmail.com>
References: <pull.508.git.1577934241.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Jan 2020 03:04:01 +0000
Subject: [PATCH 1/1] add: use advise function to display hints
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Use the advise function in advice.c to display hints to the users, as
it provides a neat and a standard format for hint messages, i.e: the
text is colored in yellow and the line starts by the word "hint:".

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 builtin/add.c  | 4 ++--
 t/t3700-add.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 4c38aff419..eebf8d772b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -390,7 +390,7 @@ static int add_files(struct dir_struct *dir, int flags)
 		fprintf(stderr, _(ignore_error));
 		for (i = 0; i < dir->ignored_nr; i++)
 			fprintf(stderr, "%s\n", dir->ignored[i]->name);
-		fprintf(stderr, _("Use -f if you really want to add them.\n"));
+		advise(_("Use -f if you really want to add them.\n"));
 		exit_status = 1;
 	}
 
@@ -480,7 +480,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (require_pathspec && pathspec.nr == 0) {
 		fprintf(stderr, _("Nothing specified, nothing added.\n"));
-		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
+		advise( _("Maybe you wanted to say 'git add .'?\n"));
 		return 0;
 	}
 
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index c325167b90..a649805369 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -326,7 +326,7 @@ test_expect_success 'git add --dry-run of an existing file output' "
 cat >expect.err <<\EOF
 The following paths are ignored by one of your .gitignore files:
 ignored-file
-Use -f if you really want to add them.
+hint: Use -f if you really want to add them.
 EOF
 cat >expect.out <<\EOF
 add 'track-this'
-- 
gitgitgadget
