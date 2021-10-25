Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3BCC433FE
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60451604E9
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhJYV3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 17:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhJYV3r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 17:29:47 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AFAC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:27:24 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id d205so13239648qke.3
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gokXIJiLkNt+SR2xH6s6FPwFbWR2isiSUaTCKJlN0jI=;
        b=OLh+rvzUhqB7j3kTb+BHILpyhd3I3QHjEb4Z+sSCNLHap9Xnb1QTRt6ec9Fyyuo+Lv
         t4MVAEortofjMuS1RxYiuvf5C7eJzUIT0w8mT2uTJRjBYvou4Fey8/EHl/7ekzXZIaKa
         RrFW89IlyeLagxvigU4v5oge0LjcSOxJPaH8/6FXjZrgfINqnTAcFT19XJ0QNM8AGbzq
         kh2F/aXjqP4euoZRlP0Gq+P2sRXHhMs4ktCnetyJQMTv710C6nFKmh9yWHyhZVVMN5n4
         L3ccI5bkuOjUw9cZtdRNgZL2pcPxuHHUrDrha6kottfEjjh69EtyGy7DPy/oS+k0FEM9
         ORCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gokXIJiLkNt+SR2xH6s6FPwFbWR2isiSUaTCKJlN0jI=;
        b=niW93ALxn6RXU/zLdXjhTDDzBvZaytuHk/1QjKAC2aVNkOb9aminAc0Y4ryHFMdK8s
         EszzxGBuH8SjLSqFEXFxxT0Z1of4Q/fwGBsiMSGpgRL2dYyThP+lN69FsMnibT1mqNtm
         nO0E2sWVJV4KhTCmd0qdYr7q/rSMq9KVgjFFUj5wfq6FA7YK/xwWPisrX/fD520jwRNB
         j/4Sj2O29NtaurqGrLVAlmzCnSVha3pU/Zt5RfwSodR7ASCXyib50K4sBopGJkoD1BPq
         8IBDgQsBoP3c4wzSQL4U6G2QAVYaf7/J4ATMLcTcV7uqVkooLHSBH8Pm3uA0mGK4KY2O
         iVkw==
X-Gm-Message-State: AOAM530QZnVwNVEh+twWPnSU+SyipgT+GT11RC46FGnql1d21SKrEcXi
        KNf3AIsGFh77h0pMpCG0PzUmIMvpaQgaGw==
X-Google-Smtp-Source: ABdhPJylxSdmfnhDbO3vJhRWLgoibX+S6Ve7qh1P/Iyv3sfTNqLCmzFJ6rf11F8lD8tFUKXaFOqi8g==
X-Received: by 2002:a37:7ce:: with SMTP id 197mr15633719qkh.59.1635197243708;
        Mon, 25 Oct 2021 14:27:23 -0700 (PDT)
Received: from localhost.localdomain (bras-base-ktnron0919w-grc-11-76-71-43-238.dsl.bell.ca. [76.71.43.238])
        by smtp.gmail.com with ESMTPSA id bk13sm9288672qkb.58.2021.10.25.14.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:27:23 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     git@vger.kernel.org, carenas@gmail.com, gitster@pobox.com,
        bagasdotme@gmail.com, avarab@gmail.com
Cc:     tbperrotta@gmail.com
Subject: [PATCH v8 2/2] send-email docs: add format-patch options
Date:   Mon, 25 Oct 2021 17:27:07 -0400
Message-Id: <20211025212707.188151-3-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <87fst7lkjx.fsf@evledraar.gmail.com>
References: <87fst7lkjx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-send-email(1) does not mention that "git format-patch" options are
accepted. Augment SYNOPSIS and DESCRIPTION to mention it.

Update git-send-email.perl USAGE to be consistent with
git-send-email(1).

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
---
 Documentation/git-send-email.txt | 6 ++++--
 git-send-email.perl              | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3db4eab4ba..41cd8cb424 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -9,7 +9,8 @@ git-send-email - Send a collection of patches as emails
 SYNOPSIS
 --------
 [verse]
-'git send-email' [<options>] <file|directory|rev-list options>...
+'git send-email' [<options>] <file|directory>...
+'git send-email' [<options>] <format-patch options>
 'git send-email' --dump-aliases
 
 
@@ -19,7 +20,8 @@ Takes the patches given on the command line and emails them out.
 Patches can be specified as files, directories (which will send all
 files in the directory), or directly as a revision list.  In the
 last case, any format accepted by linkgit:git-format-patch[1] can
-be passed to git send-email.
+be passed to git send-email, as well as options understood by
+linkgit:git-format-patch[1].
 
 The header of the email is configurable via command-line options.  If not
 specified on the command line, the user will be prompted with a ReadLine
diff --git a/git-send-email.perl b/git-send-email.perl
index b45c7da3ab..ace2dbca1a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -40,7 +40,8 @@ package main;
 
 sub usage {
 	print <<EOT;
-git send-email [options] <file | directory | rev-list options >
+git send-email' [<options>] <file|directory>
+git send-email' [<options>] <format-patch options>
 git send-email --dump-aliases
 
   Composing:
-- 
2.33.1

