Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC30ECAAD3
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 08:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiIGI13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 04:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiIGI1T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 04:27:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A70A2A92
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 01:27:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c11so14921071wrp.11
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=O2eEHWeCeyI2dFwYcxXvouMTslPu0pCAj7JobwcO6c0=;
        b=cVl7voS/y3yFzpTCMn7Uw25mlaH3mxvD5kgHgjyWuuhyHhPHlCUkvtuMfXM1ECHa0m
         kRPVatNY+ZPcSuvNdcdFm1LO8DsSF9yoixwk5TfzXCURSawhVj8rHlpjrwFSRIp/eC1w
         C0ASrQutcqBou8k8Qgt24ptbxxvQcMyTVwLD6OvosnDpW4PowJ3dfe9KAKZwNOlpY8YA
         NTkUQmYsqEZawnexn/Gkukl4Gvy/TUhsoA/u1Nwg3itWRc0tM5DLzEbiQUMuu7lnvx2O
         lD/RxM0nVex1r+lVRMjyzQ4+sbD58zk/UyKSIjvwzsCO7BoebJe9llW5SBll5nnk8bz3
         YRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=O2eEHWeCeyI2dFwYcxXvouMTslPu0pCAj7JobwcO6c0=;
        b=xT6z2aDAfurO+6ezc2qkGqPiPH2Tlwc7tt5UFBf4WWnnbiF1AO/i+PPmCZIOM9ujkj
         A+hDTdCEkAsS0jrLWeRMiu78kpAwOXefETsTdHBGSj5/2KwXY/QUl2vKFWiSvmekmX+Z
         9uXqdz3n/ccBReF5ddFfeB7S8d3OuuEBziNbOPRv59D8gT1ZG/OqWhCl9Vm6xgPUBtKv
         rRJDxG1kls+sGhzyWwTnqhCCPShFpdItv+t+JRIy5+77gvC8N7buldM/ojkBeU4ibRM9
         glBhAOJwEan47oMPh5zVX1x+R2NFDFYBaooAnatx9iuu/weMGhIQSZBOIC2HLi1/L7SJ
         h49Q==
X-Gm-Message-State: ACgBeo0dFqr4ROYDn2qaX1TIXa1/xlPoQQMa0tNru5NcKecBnQjROrtJ
        e7hI1FpjpqmBhAE52oBPmNs34mBiRml90Q==
X-Google-Smtp-Source: AA6agR7UwSm3Q7+81c5+y+yuVkpuDg6upCGgssVdA6rx4xgMOT3vgb8ANDkIhMnefkRwch9N0btrig==
X-Received: by 2002:adf:db06:0:b0:220:7a57:6665 with SMTP id s6-20020adfdb06000000b002207a576665mr1347411wri.55.1662539234599;
        Wed, 07 Sep 2022 01:27:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003a3170a7af9sm19532096wmq.4.2022.09.07.01.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 01:27:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/9] send-email docs: de-duplicate configuration sections
Date:   Wed,  7 Sep 2022 10:26:59 +0200
Message-Id: <patch-v4-3.9-f73c148a06e-20220907T082419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1490.g9adf4224da0
In-Reply-To: <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

De-duplicate the discussion of "send-email" configuration, such that
the "git-config(1)" manual page becomes the source of truth, and
"git-send-email(1)" includes the relevant part.

Most commands that suffered from such duplication had diverging text
discussing the same variables, but in this case some config was also
only discussed in one or the other.

This is mostly a move-only change, the exception is a minor rewording
of changing wording like "see above" to "see linkgit:git-config[1]",
as well as a clarification about the big section of command-line
option tweaking config being discussed in git-send-email(1)'s main
docs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/sendemail.txt | 40 +++++++++++++++++++++++++++---
 Documentation/git-send-email.txt   | 36 ++-------------------------
 2 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index 50baa5d6bfb..51da7088a84 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -18,17 +18,49 @@ sendemail.<identity>.*::
 	identity is selected, through either the command-line or
 	`sendemail.identity`.
 
+sendemail.multiEdit::
+	If true (default), a single editor instance will be spawned to edit
+	files you have to edit (patches when `--annotate` is used, and the
+	summary when `--compose` is used). If false, files will be edited one
+	after the other, spawning a new editor each time.
+
+sendemail.confirm::
+	Sets the default for whether to confirm before sending. Must be
+	one of 'always', 'never', 'cc', 'compose', or 'auto'. See `--confirm`
+	in the linkgit:git-send-email[1] documentation for the meaning of these
+	values.
+
 sendemail.aliasesFile::
+	To avoid typing long email addresses, point this to one or more
+	email aliases files.  You must also supply `sendemail.aliasFileType`.
+
 sendemail.aliasFileType::
+	Format of the file(s) specified in sendemail.aliasesFile. Must be
+	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus', or 'sendmail'.
++
+What an alias file in each format looks like can be found in
+the documentation of the email program of the same name. The
+differences and limitations from the standard formats are
+described below:
++
+--
+sendmail;;
+*	Quoted aliases and quoted addresses are not supported: lines that
+	contain a `"` symbol are ignored.
+*	Redirection to a file (`/path/name`) or pipe (`|command`) is not
+	supported.
+*	File inclusion (`:include: /path/name`) is not supported.
+*	Warnings are printed on the standard error output for any
+	explicitly unsupported constructs, and any other lines that are not
+	recognized by the parser.
+--
 sendemail.annotate::
 sendemail.bcc::
 sendemail.cc::
 sendemail.ccCmd::
 sendemail.chainReplyTo::
-sendemail.confirm::
 sendemail.envelopeSender::
 sendemail.from::
-sendemail.multiEdit::
 sendemail.signedoffbycc::
 sendemail.smtpPass::
 sendemail.suppresscc::
@@ -44,7 +76,9 @@ sendemail.thread::
 sendemail.transferEncoding::
 sendemail.validate::
 sendemail.xmailer::
-	See linkgit:git-send-email[1] for description.
+	These configuration variables all provide a default for
+	linkgit:git-send-email[1] command-line options. See its
+	documentation for details.
 
 sendemail.signedoffcc (deprecated)::
 	Deprecated alias for `sendemail.signedoffbycc`.
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 41cd8cb4247..3290043053a 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -456,41 +456,9 @@ Information
 CONFIGURATION
 -------------
 
-sendemail.aliasesFile::
-	To avoid typing long email addresses, point this to one or more
-	email aliases files.  You must also supply `sendemail.aliasFileType`.
+include::includes/cmd-config-section-all.txt[]
 
-sendemail.aliasFileType::
-	Format of the file(s) specified in sendemail.aliasesFile. Must be
-	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus', or 'sendmail'.
-+
-What an alias file in each format looks like can be found in
-the documentation of the email program of the same name. The
-differences and limitations from the standard formats are
-described below:
-+
---
-sendmail;;
-*	Quoted aliases and quoted addresses are not supported: lines that
-	contain a `"` symbol are ignored.
-*	Redirection to a file (`/path/name`) or pipe (`|command`) is not
-	supported.
-*	File inclusion (`:include: /path/name`) is not supported.
-*	Warnings are printed on the standard error output for any
-	explicitly unsupported constructs, and any other lines that are not
-	recognized by the parser.
---
-
-sendemail.multiEdit::
-	If true (default), a single editor instance will be spawned to edit
-	files you have to edit (patches when `--annotate` is used, and the
-	summary when `--compose` is used). If false, files will be edited one
-	after the other, spawning a new editor each time.
-
-sendemail.confirm::
-	Sets the default for whether to confirm before sending. Must be
-	one of 'always', 'never', 'cc', 'compose', or 'auto'. See `--confirm`
-	in the previous section for the meaning of these values.
+include::config/sendemail.txt[]
 
 EXAMPLES
 --------
-- 
2.37.3.1490.g9adf4224da0

