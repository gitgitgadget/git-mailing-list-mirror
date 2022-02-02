Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5E4C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 11:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343812AbiBBLPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 06:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238677AbiBBLPS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 06:15:18 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AB0C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 03:15:17 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c192so14975748wma.4
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 03:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2hrq/ZdrZr64/pNzRSMrj4rhd/FX1kO3kgXK5AzM68A=;
        b=cs01AB61Qo9ON7nPRHiu2VffCGHivWDdrjIOPxW4azEtTBdHIXq0DzjPXl9A0gPhIM
         gG4Ryb1Mjvsvrt2lGihBFtyenWfj8nHJXuQE2cAIa5efNoZ8Gi9PRroWNHoSGyigep0c
         OfYfR2r3LBcR1EOw06I/3NdTCBv3fyCDhMTpp3L1AAnL1SNrMjSoCelAm2wSQ1EsfJ4i
         16nFOq6K8aDUM8r1KpkhgpasBbEN2IFDn68/6tAjvJUDhO3xaSBK/BsXVoGHJYyMinCP
         zHH7sBzP5xLkzxy9AOK87yVN49ystxCocyIU/oSDkJvd2c9Uu4n0vuc6dFTdo+E5EZ6E
         1iLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hrq/ZdrZr64/pNzRSMrj4rhd/FX1kO3kgXK5AzM68A=;
        b=wET26EdNHznvAx3VVvrUneoyNkAarPIhXiZ2OAttTIZHGnIw7qRbtYW28SQcfSYdDn
         RvCnMnUvIGcgeLdBaZvKGMs4tWgW8Fzh8Xt9Pr/ngn0NMuhqtz85TjBCM/kGtizwUO82
         pZ2JKZyFR/S2UH97XfsuetZjLeK9RdipFROqITn0U3nYUfrbbRp8KWS56BGF6Du57pSO
         z13eB+5JdXD8o7RcmSuIxlyHfOhc/nw3wOJGiDGkqrAsMrLf+OezWHcwdhBIZLUUIs29
         9YTVXSrVQMPle9oGgYoC57FlAcBrp1eDbSX/oSmz+VVCHCC+e/Y0VjYlcobjDkN8wR7T
         l+Hw==
X-Gm-Message-State: AOAM531LYgKgLdQvp4Hq2cUNqricz6f3xhbkxEfqJGUAY+dCS6uAabV/
        t2yLBRb/y8NYB7T4zw5CIbHJYzYO9AqOsw==
X-Google-Smtp-Source: ABdhPJz1vql2+gtDuUi6Rv7ft29enobJJC6zkgHqrzodHFrdWs0Bn+BnUExPHBMUB3E+5j1Z295avA==
X-Received: by 2002:a05:600c:6010:: with SMTP id az16mr5536937wmb.137.1643800516051;
        Wed, 02 Feb 2022 03:15:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm18266603wrs.51.2022.02.02.03.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:15:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hongyi Zhao <hongyi.zhao@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Victor=20Bonfim?= 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] completion: add a GIT_COMPLETION_SHOW_ALL_COMMANDS
Date:   Wed,  2 Feb 2022 12:15:08 +0100
Message-Id: <cover-v2-0.2-00000000000-20220202T111228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.913.g12b4baa2536
In-Reply-To: <patch-1.1-5f18305ca08-20220125T124757Z-avarab@gmail.com>
References: <patch-1.1-5f18305ca08-20220125T124757Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds an opt-in configuration to make "git <TAB>" complete
the likes of "cat-file" (plumbing), in addition to the existing
completion for the likes of "status" (porcelain).

This v2 addresses feedback from Junio on the v1, I also added a
preceding patch to change the re-sourcing of git-completion.bash in
some existing tests to use a subshell, which is a pattern I'd buggily
copied in the v1.

Ævar Arnfjörð Bjarmason (2):
  completion tests: re-source git-completion.bash in a subshell
  completion: add a GIT_COMPLETION_SHOW_ALL_COMMANDS

 contrib/completion/git-completion.bash | 13 ++++-
 t/t9902-completion.sh                  | 81 +++++++++++++++++++-------
 2 files changed, 72 insertions(+), 22 deletions(-)

Range-diff against v1:
-:  ----------- > 1:  cf09546e079 completion tests: re-source git-completion.bash in a subshell
1:  5f18305ca08 ! 2:  2e2e3569e02 completion: add a GIT_COMPLETION_SHOW_ALL_COMMANDS
    @@ Commit message
         completion with git <TAB>, respectively.
     
         It was already possible to do this by tweaking
    -    GIT_COMPLETION_SHOW_ALL_COMMANDS from the outside, that testing
    +    GIT_TESTING_PORCELAIN_COMMAND_LIST= from the outside, that testing
         variable was added in 84a97131065 (completion: let git provide the
         completable command list, 2018-05-20). Doing this before loading
         git-completion.bash worked:
    @@ Commit message
         and we make no guarantees that those internal won't change. So let's
         expose this as a dedicated configuration knob.
     
    +    It would be better to teach --list-cmds=* a new category which would
    +    include all of these groups, but that's a larger change that we can
    +    leave for some other time.
    +
         1. https://lore.kernel.org/git/CAGP6POJ9gwp+t-eP3TPkivBLLbNb2+qj=61Mehcj=1BgrVOSLA@mail.gmail.com/
     
         Reported-by: Hongyi Zhao <hongyi.zhao@gmail.com>
    @@ contrib/completion/git-completion.bash: __git_main ()
     
      ## t/t9902-completion.sh ##
     @@ t/t9902-completion.sh: test_expect_success 'option aliases are shown with GIT_COMPLETION_SHOW_ALL' '
    - 	EOF
    + 	)
      '
      
     +test_expect_success 'plumbing commands are excluded without GIT_COMPLETION_SHOW_ALL_COMMANDS' '
    -+	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
    -+	sane_unset GIT_TESTING_PORCELAIN_COMMAND_LIST &&
    ++	(
    ++		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
    ++		sane_unset GIT_TESTING_PORCELAIN_COMMAND_LIST &&
     +
    -+	# Just mainporcelain, not plumbing commands
    -+	run_completion "git c" &&
    -+	grep checkout out &&
    -+	! grep cat-file out
    ++		# Just mainporcelain, not plumbing commands
    ++		run_completion "git c" &&
    ++		grep checkout out &&
    ++		! grep cat-file out
    ++	)
     +'
     +
     +test_expect_success 'all commands are shown with GIT_COMPLETION_SHOW_ALL_COMMANDS (also main non-builtin)' '
    -+	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
    -+	GIT_COMPLETION_SHOW_ALL_COMMANDS=1 &&
    -+	export GIT_COMPLETION_SHOW_ALL_COMMANDS &&
    -+	sane_unset GIT_TESTING_PORCELAIN_COMMAND_LIST &&
    ++	(
    ++		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
    ++		GIT_COMPLETION_SHOW_ALL_COMMANDS=1 &&
    ++		export GIT_COMPLETION_SHOW_ALL_COMMANDS &&
    ++		sane_unset GIT_TESTING_PORCELAIN_COMMAND_LIST &&
     +
    -+	# Both mainporcelain and plumbing commands
    -+	run_completion "git c" &&
    -+	grep checkout out &&
    -+	grep cat-file out &&
    ++		# Both mainporcelain and plumbing commands
    ++		run_completion "git c" &&
    ++		grep checkout out &&
    ++		grep cat-file out &&
     +
    -+	# Check "gitk", a "main" command, but not a built-in + more plumbing
    -+	run_completion "git g" &&
    -+	grep gitk out &&
    -+	grep get-tar-commit-id out
    ++		# Check "gitk", a "main" command, but not a built-in + more plumbing
    ++		run_completion "git g" &&
    ++		grep gitk out &&
    ++		grep get-tar-commit-id out
    ++	)
     +'
     +
      test_expect_success '__git_complete' '
-- 
2.35.0.913.g12b4baa2536

