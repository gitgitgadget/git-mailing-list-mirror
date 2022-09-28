Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419C6C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 05:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiI1FFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 01:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiI1FE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 01:04:58 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91F18671E
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 22:04:55 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 138so9323346iou.9
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 22:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=wSk92Il6jsRdUTN5atOufZxTFHV0masOfq6eAHXYlOM=;
        b=F+NAd0urqTm60KQAfc3jJL7iTSX0TMZiv+LGZnnTHKQTrs/M4EUVgdzjd0fywXzfpj
         JJfTQnEudXL1vo4URQ0+unRS3eyGmn6QErG/O2Z2b22ckTrxDfmByH0su58DAFv9TE/U
         rQdaLPKA3Wq2TUYg1FRORkr5Vi/fXXfvs/9RkTLx/jOWDAuzZveOlrhN+YyGFjUnnGzI
         kX2GX0jQj8HLz9eYRjYy2uWGrFVQifqWCXzUlFe519I0fyjcMM3tMQMpchxaquvSppqQ
         Q9/C9anbhCO20i8jEeNUXoQBtsjKez3qSTYzb4eVkon1xQV4jQKLlfwPRTFD7nNTlj8b
         xqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=wSk92Il6jsRdUTN5atOufZxTFHV0masOfq6eAHXYlOM=;
        b=7bN+CJCYRlMPFCTfMwqlpAxOMpnhhChDi++SnW8D9bW2sF7/RbzASZWK02RDw7FHkP
         NRNQWIKbeLmFp7YlHZzw4II574s7Tpq1Dpgg0eddi8iOAjqpEjouxHMhSpCMiptyrrjF
         WtoBFqmi21aZf+kOFmAodlaXDwuHkwAAFtATLwex/bGRkNpftJPCpubuitmlP8klKxeh
         h9ULvmUEGelUoZxdM5165Sn/VPR9Jz2D/554B64pNKfAYEbKbUx5mkAU4Mq7BxEA5HqM
         pYPhi9nQz2GMMIY1nKM1KE2d4EuCnM2jR/6xQ2+6BtAsB9391X0UgwN1zt3jFdfAE6X/
         FlUw==
X-Gm-Message-State: ACrzQf340+d7w6aHZqPXFJUlYIMxC+OVVi3xpT6kJVsFgUn/Pe0lnhJK
        231U+sNXzXVeBEQfz7SAZlk7cGWfmIE=
X-Google-Smtp-Source: AMsMyM6e+0cwcRGdiJbA/75sLy978JxmWbGAI7JM/SlFew0bk6zbRRaHcyBbSBooDZ7kLxwNpXVEcA==
X-Received: by 2002:a02:85c5:0:b0:35b:5d6:6add with SMTP id d63-20020a0285c5000000b0035b05d66addmr15800509jai.252.1664341494638;
        Tue, 27 Sep 2022 22:04:54 -0700 (PDT)
Received: from xavier.localdomain (75-169-20-7.slkc.qwest.net. [75.169.20.7])
        by smtp.gmail.com with ESMTPSA id az28-20020a056638419c00b0034f465bbd52sm1410511jab.42.2022.09.27.22.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 22:04:51 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, emilyshaffer@google.com, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] bugreport: clarify that -o expects a directory and not a file
Date:   Tue, 27 Sep 2022 23:04:32 -0600
Message-Id: <20220928050432.701512-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/git-bugreport.txt | 2 +-
 builtin/bugreport.c             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index eca726e579..784d9b6304 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -8,7 +8,7 @@ git-bugreport - Collect information for user to file a bug report
 SYNOPSIS
 --------
 [verse]
-'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
+'git bugreport' [(-o | --output-directory) <dir>] [(-s | --suffix) <format>]
 		[--diagnose[=<mode>]]
 
 DESCRIPTION
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 530895be55..827688183e 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -60,7 +60,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>] [--diagnose[=<mode>]"),
+	N_("git bugreport [-o|--output-directory <dir>] [-s|--suffix <format>] [--diagnose[=<mode>]"),
 	NULL
 };
 
@@ -110,7 +110,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, "diagnose", &diagnose, N_("mode"),
 			       N_("create an additional zip archive of detailed diagnostics (default 'stats')"),
 			       PARSE_OPT_OPTARG, option_parse_diagnose),
-		OPT_STRING('o', "output-directory", &option_output, N_("path"),
+		OPT_STRING('o', "output-directory", &option_output, N_("dir"),
 			   N_("specify a destination for the bugreport file(s)")),
 		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
 			   N_("specify a strftime format suffix for the filename(s)")),
-- 
2.37.3

