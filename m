Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA23DC04A68
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 08:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiG2I0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiG2I0H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 04:26:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDE628E2B
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p10so891903wru.8
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=iGWn60Jo1hdccX/ALML2Yb+t40t05WarPvwfQ+VcFbM=;
        b=ZviWuWnPSOXBZD5CfHyRrzydd2u94TgRK2/VYMKpCh4sKI+rZ9/6xyOY0nHOKUDhfD
         xJYCaV6UZ7wuzYovl+lSaSgG2zmv3PHOKhJEszBGh8R0WeMeht5Mn+QCbWBiRxhnjQJq
         ysMRfVfp+kNXPuL/1IsUVy5avlksSUQD9tfSzK1hTl16gfG1ilzdvg2SZz1ZP9hcRcYH
         ObKj/dzGru3SX0fFOd4/GEdLGeyWAF66bXXwjeW9Dl7hSxJPTGfE4HUhekpPecO06FcG
         fvu16r3TIrsMBItAb7/MCWsp4VWuNzHm6He8HqbflPenxYPlD+iOvYW790tnFBuZNgPK
         jS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=iGWn60Jo1hdccX/ALML2Yb+t40t05WarPvwfQ+VcFbM=;
        b=NsXpEL0GZlk7eghCWfl5tLmpgCpvESiQISBfxpfD93IaceU4eeddTOJiFB1L9ZRZr8
         SGj57K+6gvlhfA+WGPyQTkobjRU5+WqORwOJbWbucyXCJdbbL2fbpLFmBim4qx4Q0WaI
         q9iUr0hjpeJCiVWcwFGDfIgHoiZGlPI3JdUlj+Dg3TfI0dYwkn8h3x5ZqMfQTiOcCa89
         dQoxANf+yDlfJk0s9iLXj8HcBe++9HQBufB2UG5KGDf24Wmfwhfox7vldBInbER7OmUK
         C+tFGzuCtOdj12aU9K3tgkQm2UMGZ5UnoKedBBP+S2TPsgTXq7pQhg7fT7BnMgeIrXg3
         sDOw==
X-Gm-Message-State: ACgBeo1b69XizaE3wYqe1lyzBByclMnzp9d5WUyfDOb8F7q+S+9G3ENY
        jltN9fVeR58PgQYQwGtu9QQwjwusKM9nTg==
X-Google-Smtp-Source: AA6agR6M4a7GWiZenBDyZ6YO6HnBuJgYqQ8YkwKRj6ZwduA/+pH3vzR0VKaB/UXt24XjlaEmOemHaw==
X-Received: by 2002:adf:ee8f:0:b0:21e:529e:fa3b with SMTP id b15-20020adfee8f000000b0021e529efa3bmr1621224wro.207.1659083162722;
        Fri, 29 Jul 2022 01:26:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0021e571a99d5sm2994802wrh.17.2022.07.29.01.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:26:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/9] difftool docs: de-duplicate configuration sections
Date:   Fri, 29 Jul 2022 10:25:52 +0200
Message-Id: <patch-v2-6.9-b3a5ea46bb5-20220729T081959Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1196.g8af3636bc64
In-Reply-To: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
References: <cover.1657819649.git.matheus.bernardino@usp.br> <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
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
2.37.1.1196.g8af3636bc64

