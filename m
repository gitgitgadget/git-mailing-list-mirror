Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AF9C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 05:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbhK3Fkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 00:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhK3Fkr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 00:40:47 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FEFC061574
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 21:37:28 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso13891470wmr.5
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 21:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Au7nJtjmjY50zN8p2YwvP0I4EuVe7URveK1DkN1Vg6A=;
        b=f7AD58mrpw65ulNPRsy01FpYd/2bpioNcUILmGWKw6uqfkKscn9yk1HP8P64zgPMb6
         sDCydKf4oDv3CfhCghx30FNLW3PSc5L9NjpxSxvM00H5EYABp+l0kV7WBpPo7G+ayGSC
         4XqwnyCTcJFtDflzw/WNHsz0QPVPgbmRnWnxpMYBX+Mj2FE6mf87REEq9HQ6blePsCVa
         I8tPmPo/EtulRG5WAoeU9U/vIldxkWmDB3GQxuQvY9Kg6Awp6UgoDmp8D+PJNpDKztJl
         yHbCyKaJ1z9rdLNQXK7BkVj8qtgJ94ImMCNHKCAu/lMGfyIziD6bjRk/cdh9wngJb/2v
         CNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Au7nJtjmjY50zN8p2YwvP0I4EuVe7URveK1DkN1Vg6A=;
        b=YN97s+lEjrUewyGBdnQlf3anJ/jEfrBuniDbBbN5s10QDgdgAatB3XuV8wb+r7qwwt
         GZU0SsNpV9FEefPQsLslMs7PpwCkcAWBD+8KMbDcqfckeTcI3jFiSs9sJ2mqtmZob1LB
         oDzDLtY3F4B6fXmuhB0bmn/TNcn/STHlz6ZVsxky+OuBVJd1zGpTUVRgZJhaudlPwJ0Q
         n0+SoQOqgrwDhrBPQvM14sEHA7nbqgRh0iJyl56ZmcEjUFMwHrHXwe1mute0mblkWsYy
         UiiDeXeNSReccHo26WL6U2hRpNM5JluHL6tZIb6yTHuVorSSIXIUIb9sjaB/6lIKFlfn
         uc6w==
X-Gm-Message-State: AOAM5330yDKoBOUjI6g+NzegHVbbPELbyChRctBvk/hsYwFwszRlMV7s
        Zr6iYSYbj/q40aldLLgojPmOVezVc+0=
X-Google-Smtp-Source: ABdhPJzirF13/xmFQL0jamdVXvXD0lTCj3y8EyRS3w1NqNeiNcQx6LH1OiTVCQJdeaMiFOrgWxlTxQ==
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr2556902wma.129.1638250646629;
        Mon, 29 Nov 2021 21:37:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8sm15293197wrr.26.2021.11.29.21.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 21:37:26 -0800 (PST)
Message-Id: <pull.1076.v12.git.1638250645.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v11.git.1637681215.gitgitgadget@gmail.com>
References: <pull.1076.v11.git.1637681215.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 05:37:22 +0000
Subject: [PATCH v12 0/3] am: support --empty=(die|drop|keep) option and --allow-empty option to
 handle empty patches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since that git has supported the --always option for the git-format-patch
command to create a patch with an empty commit message, git-am should
support applying and committing with empty patches.

----------------------------------------------------------------------------

Changes since v1:

 1. add a case when not passing the --always option.
 2. rename the --always option to --allow-empty.

----------------------------------------------------------------------------

Changes since v2:

 1. rename the --allow-empty option to --empty-commit.
 2. introduce three different strategies (die|skip|asis) when trying to
    record empty patches as empty commits.

----------------------------------------------------------------------------

Changes since v3:

 1. generate the missed file for test cases.
 2. grep -f cannot be used under Mac OS.

----------------------------------------------------------------------------

Changes since v4:

 1. rename the --empty-commit option to --empty.
 2. rename three different strategies (die|skip|asis) to die, drop and keep
    correspondingly.

----------------------------------------------------------------------------

Changes since v5:

 1. throw an error when passing --empty option without value.

----------------------------------------------------------------------------

Changes since v6:

 1. add i18n resources.

----------------------------------------------------------------------------

Changes since v7:

 1. update code according to the seen branch.
 2. fix the wrong document of git-am.
 3. sign off commits by a real name.

----------------------------------------------------------------------------

Changes since v8:

 1. update the committer's name with my real name to fix DCO of GGG.

----------------------------------------------------------------------------

Changes since v9:

 1. imitate the signed name format of
    https://lore.kernel.org/git/pull.1143.git.git.1637347813367.gitgitgadget@gmail.com
    .

----------------------------------------------------------------------------

Changes since v11:

 1. introduce an interactive option --allow-empty for git-am to record empty
    patches in the middle of an am session.

徐沛文 (Aleen) (3):
  doc: git-format-patch: describe the option --always
  am: support --empty=<option> to handle empty patches
  am: support --allow-empty to record specific empty patches

 Documentation/git-am.txt           | 14 +++++-
 Documentation/git-format-patch.txt |  6 ++-
 builtin/am.c                       | 77 ++++++++++++++++++++++++++----
 t/t4150-am.sh                      | 61 +++++++++++++++++++++++
 t/t7512-status-help.sh             |  1 +
 wt-status.c                        |  3 ++
 6 files changed, 151 insertions(+), 11 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v12
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v12
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v11:

 1:  3d7e96ce2b3 = 1:  a524ca6adfa doc: git-format-patch: describe the option --always
 2:  6051ad9440a = 2:  a3e850bab7d am: support --empty=<option> to handle empty patches
 -:  ----------- > 3:  d44dac09c87 am: support --allow-empty to record specific empty patches

-- 
gitgitgadget
