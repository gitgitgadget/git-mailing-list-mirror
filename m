Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C191ECAAD3
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 08:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiIGI1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 04:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiIGI1V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 04:27:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC46FAB050
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 01:27:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t14so11861466wrx.8
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=twjDJdyDzycPS/CPAcocpRilY98QzrHLOJMcwTaIjBw=;
        b=YUl+HQd8Eq3E4PTY/VYuNhvam5FiXqPfOzPcFKK2vrjz9cWU5KwDhqNFf56a+yucks
         ggxxokqz4tv1QcIr4nigfCww+NYgAq4+YGW28IySaiVuAIzelG4FimWurkS7eldXUXXL
         kCXv1oZQQxFHsIzB/ViAQdgAZUlDx8OqZLBOGK3wJ8eZfRJSeos3YWDfcR8qvQEsr6Da
         MyYhx6BtmrW99CasQ5WLePAkuwPLNcPpdyxO5bGRnndYRR22S5lxH8IAZgc4tfkd2J/j
         yUB36yhl0De7UYlts0/dt0tnBDT0aUJl2dB+Y0PjmBJZFeL351Ug0WBVPdq4Lvcuu2qJ
         4YIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=twjDJdyDzycPS/CPAcocpRilY98QzrHLOJMcwTaIjBw=;
        b=DoVtOXj13T/9sveJqnXS0Dg1B5G42BUHKxD9nkVER3pqDpiXAffa1TilKyopRQ0fdn
         bBfPfZIWMOGZXj+pMYZBfZ+WY7lHCfp1Ob+0O+XxmG4atOhIQdx0HHIVouRm6xdplbQz
         AN3OYIy5EoN2eY1cAqS6+iivEfe1fiWLB7mKBEuXEI87TquTQX9ZbyYx0DJEZOtz5ABE
         AV3Zu3IGpXs/+xN4HQ2c6hJ/tabp2Tv9T3ulNrbj5dmviPkkw7KsQAKC8XQ0SRtqK+YV
         PIKGVGGlQ/tLithNP3KE0vFKFVNLDdnqUSROC7lczmCSNfpvXXBUxs17NlUB85KE4n3U
         M7xg==
X-Gm-Message-State: ACgBeo3npS5HWaOrbXuRRvdNrX4zA1LfAN/XdGtCwHzXedlAHJRLYZkm
        Zx9XM3uTpAcLLxrwK06qqsG7Lty/o7uGNA==
X-Google-Smtp-Source: AA6agR4GjJJp5ZraRw6Oj2ZxzAhpyvmx3YKyOI39PoPIT7GNietXZqGxBYOBbGuj63Vd1+SHMOc8Hg==
X-Received: by 2002:a05:6000:713:b0:226:ea6c:2d7d with SMTP id bs19-20020a056000071300b00226ea6c2d7dmr1325404wrb.293.1662539237746;
        Wed, 07 Sep 2022 01:27:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003a3170a7af9sm19532096wmq.4.2022.09.07.01.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 01:27:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/9] difftool docs: de-duplicate configuration sections
Date:   Wed,  7 Sep 2022 10:27:02 +0200
Message-Id: <patch-v4-6.9-73e6804db13-20220907T082419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1490.g9adf4224da0
In-Reply-To: <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Include the "config/difftool.txt" file in "git-difftool.txt", and move
the relevant part of git-difftool(1) configuration from
"config/diff.txt" to config/difftool.txt".

Doing this is slightly odd, as we usually discuss configuration in
alphabetical order, but by doing it we're able to include the full set
of configuration used by git-difftool(1) (and only that configuration)
in its own documentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/diff.txt     | 15 ---------------
 Documentation/config/difftool.txt | 28 +++++++++++++++++++++++++---
 Documentation/git-difftool.txt    | 27 ++++-----------------------
 3 files changed, 29 insertions(+), 41 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 32f84838ac1..35a7bf86d77 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -178,21 +178,6 @@ diff.<driver>.cachetextconv::
 	Set this option to true to make the diff driver cache the text
 	conversion outputs.  See linkgit:gitattributes[5] for details.
 
-diff.tool::
-	Controls which diff tool is used by linkgit:git-difftool[1].
-	This variable overrides the value configured in `merge.tool`.
-	The list below shows the valid built-in values.
-	Any other value is treated as a custom diff tool and requires
-	that a corresponding difftool.<tool>.cmd variable is defined.
-
-diff.guitool::
-	Controls which diff tool is used by linkgit:git-difftool[1] when
-	the -g/--gui flag is specified. This variable overrides the value
-	configured in `merge.guitool`. The list below shows the valid
-	built-in values. Any other value is treated as a custom diff tool
-	and requires that a corresponding difftool.<guitool>.cmd variable
-	is defined.
-
 include::../mergetools-diff.txt[]
 
 diff.indentHeuristic::
diff --git a/Documentation/config/difftool.txt b/Documentation/config/difftool.txt
index 67625944804..a3f82112102 100644
--- a/Documentation/config/difftool.txt
+++ b/Documentation/config/difftool.txt
@@ -1,6 +1,17 @@
-difftool.<tool>.path::
-	Override the path for the given tool.  This is useful in case
-	your tool is not in the PATH.
+diff.tool::
+	Controls which diff tool is used by linkgit:git-difftool[1].
+	This variable overrides the value configured in `merge.tool`.
+	The list below shows the valid built-in values.
+	Any other value is treated as a custom diff tool and requires
+	that a corresponding difftool.<tool>.cmd variable is defined.
+
+diff.guitool::
+	Controls which diff tool is used by linkgit:git-difftool[1] when
+	the -g/--gui flag is specified. This variable overrides the value
+	configured in `merge.guitool`. The list below shows the valid
+	built-in values. Any other value is treated as a custom diff tool
+	and requires that a corresponding difftool.<guitool>.cmd variable
+	is defined.
 
 difftool.<tool>.cmd::
 	Specify the command to invoke the specified diff tool.
@@ -9,6 +20,17 @@ difftool.<tool>.cmd::
 	file containing the contents of the diff pre-image and 'REMOTE'
 	is set to the name of the temporary file containing the contents
 	of the diff post-image.
++
+See the `--tool=<tool>` option in linkgit:git-difftool[1] for more details.
+
+difftool.<tool>.path::
+	Override the path for the given tool.  This is useful in case
+	your tool is not in the PATH.
+
+difftool.trustExitCode::
+	Exit difftool if the invoked diff tool returns a non-zero exit status.
++
+See the `--trust-exit-code` option in linkgit:git-difftool[1] for more details.
 
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 143b0c49d73..9d14c3c9f09 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -113,33 +113,14 @@ instead.  `--no-symlinks` is the default on Windows.
 
 See linkgit:git-diff[1] for the full list of supported options.
 
-CONFIG VARIABLES
-----------------
+CONFIGURATION
+-------------
 'git difftool' falls back to 'git mergetool' config variables when the
 difftool equivalents have not been defined.
 
-diff.tool::
-	The default diff tool to use.
+include::includes/cmd-config-section-rest.txt[]
 
-diff.guitool::
-	The default diff tool to use when `--gui` is specified.
-
-difftool.<tool>.path::
-	Override the path for the given tool.  This is useful in case
-	your tool is not in the PATH.
-
-difftool.<tool>.cmd::
-	Specify the command to invoke the specified diff tool.
-+
-See the `--tool=<tool>` option above for more details.
-
-difftool.prompt::
-	Prompt before each invocation of the diff tool.
-
-difftool.trustExitCode::
-	Exit difftool if the invoked diff tool returns a non-zero exit status.
-+
-See the `--trust-exit-code` option above for more details.
+include::config/difftool.txt[]
 
 SEE ALSO
 --------
-- 
2.37.3.1490.g9adf4224da0

