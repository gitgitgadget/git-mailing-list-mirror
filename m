Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95E9C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 14:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349173AbiA1OcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 09:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiA1OcA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 09:32:00 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E02DC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 06:32:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a13so11237386wrh.9
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 06:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sk0uhcofNNnOFjGPvNXzzTnsPAxGF11w/2EjUczFyEQ=;
        b=DlLVggEPFBk4csaFUGhqYoGoY29++2Wtzz8pbmz1zG15z6w+Y5sNUI0vqgUNlp5eI3
         07hwLpaL0jPdvt3M0V6ari/UqxNxmNlsGj3vLU5qNsbnGoy0sMBFinY1jvuP9A0fYeZl
         ReP7NS4z3ujEfzma020Iq8NkSLxmj8miJqTi59CW4oMOHAHcd9DizXu0t2EC2CgjTAyS
         4m1N0vUQz8UJTAbeG30P509tVQI7IgwrtMLRNr8jccyzRhYczc/3WHVN2C1zbdi3fB+R
         mscsJey9I7VzXqRO2dutvBO5us2qQgQw276sZfmc8WhgPOFSf89ewraumb9ee9W5qKYG
         ehpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sk0uhcofNNnOFjGPvNXzzTnsPAxGF11w/2EjUczFyEQ=;
        b=sU/45eT/TbEMzCl8DVZRSIZv0bGFSmIGhPITDBn1fy9ph5RodrOBaPbiqnKdiqR0GO
         TBgeOAMGfOeY4m1Weh/OBcDDXueRpxl+Sjz+YS9zHFX+W7Sm/FqNF0Aa4HjZsw+R6i98
         Cx/lMgJxNMZFbHpT58slDsPTO7UiN03UNUlJUBby+yjwm4N6w6AY3Gf2eOyKtQNndQkO
         IKGTSv9IWy9jOD5MThOR9mfl3hLnat2Tmahb37mVGrwJnV9jIsfn4dRxSCWy0rOMxtjH
         EjcJUzEdzquymb9cC76mHZ3UAWQ5D54t7CHM6pIc0Qx4qEyRFsqvTNS8b0tRqhpyYkg8
         O0HQ==
X-Gm-Message-State: AOAM53323QNsV/TM8kIUqIZwqwlrjDB1rKY81E+SvwGUdWllSZeGE+3I
        2JtXqZptkmQbzeKhoIEAUw7rdEvVUzU=
X-Google-Smtp-Source: ABdhPJzMwE2dcfCnguxbQS5rMjz0d2YWMzKSINsYc6yVXEgpAxNuuPg8TaeqjERXdXNl5jmPo8tyHw==
X-Received: by 2002:a5d:6349:: with SMTP id b9mr7371948wrw.178.1643380318699;
        Fri, 28 Jan 2022 06:31:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l39sm2168009wms.24.2022.01.28.06.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 06:31:58 -0800 (PST)
Message-Id: <pull.1130.v2.git.1643380317358.gitgitgadget@gmail.com>
In-Reply-To: <pull.1130.git.1643195729608.gitgitgadget@gmail.com>
References: <pull.1130.git.1643195729608.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 14:31:57 +0000
Subject: [PATCH v2] scalar: accept -C and -c options before the subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `git` executable has these two very useful options:

-C <directory>:
	switch to the specified directory before performing any actions

-c <key>=<value>:
	temporarily configure this setting for the duration of the
	specified scalar subcommand

With this commit, we teach the `scalar` executable the same trick.

Note: It might look like a good idea to try to reuse the
`handle_options()` function in `git.c` instead of replicating only the
`-c`/`-C` part. However, that function is not only not in `libgit.a`, it
is also intricately entangled with the rest of the code in `git.c` that
is necessary e.g. to handle `--paginate`. Besides, no other option
handled by that `handle_options()` function is relevant to Scalar,
therefore the cost of refactoring vastly would outweigh the benefit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    scalar: accept -C and -c options
    
    This makes the scalar command a bit more handy by offering the same -c
    <key>=<value> and -C <directory> options as the git command.
    
    Changes since v1:
    
     * Added a regression test case.
     * Augmented the commit message with a brief analysis why we're choosing
       not to refactor git.c:handle_options() but instead copy-edit the
       dozen or so lines that we want.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1130%2Fdscho%2Fscalar-c-and-C-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1130/dscho/scalar-c-and-C-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1130

Range-diff vs v1:

 1:  8f2af8c3ec1 ! 1:  d7ee2d03b04 scalar: accept -C and -c options before the subcommand
     @@ Commit message
      
          With this commit, we teach the `scalar` executable the same trick.
      
     +    Note: It might look like a good idea to try to reuse the
     +    `handle_options()` function in `git.c` instead of replicating only the
     +    `-c`/`-C` part. However, that function is not only not in `libgit.a`, it
     +    is also intricately entangled with the rest of the code in `git.c` that
     +    is necessary e.g. to handle `--paginate`. Besides, no other option
     +    handled by that `handle_options()` function is relevant to Scalar,
     +    therefore the cost of refactoring vastly would outweigh the benefit.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## contrib/scalar/scalar.c ##
     @@ contrib/scalar/scalar.txt: The `scalar` command implements various subcommands,
       COMMANDS
       --------
       
     +
     + ## contrib/scalar/t/t9099-scalar.sh ##
     +@@ contrib/scalar/t/t9099-scalar.sh: test_expect_success 'scalar delete with enlistment' '
     + 	test_path_is_missing cloned
     + '
     + 
     ++test_expect_success 'scalar supports -c/-C' '
     ++	test_when_finished "scalar delete sub" &&
     ++	git init sub &&
     ++	scalar -C sub -c status.aheadBehind=bogus register &&
     ++	test -z "$(git -C sub config --local status.aheadBehind)" &&
     ++	test true = "$(git -C sub config core.preloadIndex)"
     ++'
     ++
     + test_done


 contrib/scalar/scalar.c          | 22 +++++++++++++++++++++-
 contrib/scalar/scalar.txt        | 10 ++++++++++
 contrib/scalar/t/t9099-scalar.sh |  8 ++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 1ce9c2b00e8..7db2a97416e 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -808,6 +808,25 @@ int cmd_main(int argc, const char **argv)
 	struct strbuf scalar_usage = STRBUF_INIT;
 	int i;
 
+	while (argc > 1 && *argv[1] == '-') {
+		if (!strcmp(argv[1], "-C")) {
+			if (argc < 3)
+				die(_("-C requires a <directory>"));
+			if (chdir(argv[2]) < 0)
+				die_errno(_("could not change to '%s'"),
+					  argv[2]);
+			argc -= 2;
+			argv += 2;
+		} else if (!strcmp(argv[1], "-c")) {
+			if (argc < 3)
+				die(_("-c requires a <key>=<value> argument"));
+			git_config_push_parameter(argv[2]);
+			argc -= 2;
+			argv += 2;
+		} else
+			break;
+	}
+
 	if (argc > 1) {
 		argv++;
 		argc--;
@@ -818,7 +837,8 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	strbuf_addstr(&scalar_usage,
-		      N_("scalar <command> [<options>]\n\nCommands:\n"));
+		      N_("scalar [-C <directory>] [-c <key>=<value>] "
+			 "<command> [<options>]\n\nCommands:\n"));
 	for (i = 0; builtins[i].name; i++)
 		strbuf_addf(&scalar_usage, "\t%s\n", builtins[i].name);
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index f416d637289..cf4e5b889cc 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -36,6 +36,16 @@ The `scalar` command implements various subcommands, and different options
 depending on the subcommand. With the exception of `clone`, `list` and
 `reconfigure --all`, all subcommands expect to be run in an enlistment.
 
+The following options can be specified _before_ the subcommand:
+
+-C <directory>::
+	Before running the subcommand, change the working directory. This
+	option imitates the same option of linkgit:git[1].
+
+-c <key>=<value>::
+	For the duration of running the specified subcommand, configure this
+	setting. This option imitates the same option of linkgit:git[1].
+
 COMMANDS
 --------
 
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 2e1502ad45e..89781568f43 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -85,4 +85,12 @@ test_expect_success 'scalar delete with enlistment' '
 	test_path_is_missing cloned
 '
 
+test_expect_success 'scalar supports -c/-C' '
+	test_when_finished "scalar delete sub" &&
+	git init sub &&
+	scalar -C sub -c status.aheadBehind=bogus register &&
+	test -z "$(git -C sub config --local status.aheadBehind)" &&
+	test true = "$(git -C sub config core.preloadIndex)"
+'
+
 test_done

base-commit: ddc35d833dd6f9e8946b09cecd3311b8aa18d295
-- 
gitgitgadget
