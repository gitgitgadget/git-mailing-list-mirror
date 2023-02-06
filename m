Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE352C636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 18:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBFSiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 13:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBFSiR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 13:38:17 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20CACA11
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 10:38:05 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id cr22so13910684qtb.10
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 10:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biLsIQ6ez+h1D93HWbgIXZSBm+jjkNha4WroRDHfPm8=;
        b=RndndYc9E8H6VM2XQKhnJyWiZM6/b1ep1ql6sOLWzfTHs/A+reyiZ2rpMYStQs4ZwJ
         +QXmjntvZwFJPy+gJWB5fH8oqZ2TxjkxBMElY34bXN83KHD2Yn75xxw5949cNk9/oV+P
         N5DnhQ7KV1/YeXutttWcNktabAc3mozbWBAZ2WwqWKcIK2cc3aoNtHC5ZqVsjSiC8WPx
         8ArWMQ5qLXBbA5Ld8Pl/dMrjrw81LCIDg5U5JFXRpBbH3eV/Fjg5fU2gphlH7OPtc/KH
         2kUuh8LO1i9xKL7eaqXZKeiPmFUvVvTn6BSIdde0psBZH0KA6DORAnCic+9W+zmlo+s+
         3gDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=biLsIQ6ez+h1D93HWbgIXZSBm+jjkNha4WroRDHfPm8=;
        b=ykNgEngpYkDJsypbfGey6wMdC/CIqh4QwUaTA7RY2vDpBC7uj7IvddPdG8IIXFO4xu
         tZ3Leo3UEFZA20/ibBfyvCqa8xFfuFgxau3BO2Bwehb0+RogD4Og2C+Ol0q71SztkI8Q
         9R0M0TeVXj86Yi9/4WQNEF1BFN58vJlZcZijRuJuGj6ueVecpyz3nmU38byObLhANUcW
         Kexnvcl7fW3kiJILHVKsQPbJsL8jTYzSM1SnhzzCchcrD5K67tuQIWk9OBiDQVKsGugt
         ktrFpw7kAJ10WAN/Lc/fXq8HOZBvzvbZMgxf/IMgIFK3UI/gLn/amJVsxJ0VzomjEj47
         G0Iw==
X-Gm-Message-State: AO0yUKUbpWsT4U2d7xYY6q94Dn22MDgQ9XgQCBHjbX9c185YxpNpuay8
        M72Hg4H27/NrfeurzRdopDo=
X-Google-Smtp-Source: AK7set/lY/QLy9KlbMPpYGzR0pR7hU49QB6AF3hAE92Rl9JFNO7zfIKYza0adQNG4bZsWjMRDmJRgw==
X-Received: by 2002:ac8:590d:0:b0:3b8:2edf:33a1 with SMTP id 13-20020ac8590d000000b003b82edf33a1mr583221qty.6.1675708684854;
        Mon, 06 Feb 2023 10:38:04 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id f10-20020ac840ca000000b003b84b92052asm7648671qtm.57.2023.02.06.10.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 10:38:04 -0800 (PST)
Subject: Re: [PATCH 1/3] add: remove "add.interactive.useBuiltin" & Perl "git
 add--interactive"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?B?U2xhdmljYSDEkHVracSH?= <slawica92@hotmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <cover-0.3-00000000000-20230203T125859Z-avarab@gmail.com>
 <patch-1.3-f39dde93011-20230203T125859Z-avarab@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <7ed6f7a8-61de-3b60-c7fa-4b5acdbb4e98@gmail.com>
Date:   Mon, 6 Feb 2023 13:38:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <patch-1.3-f39dde93011-20230203T125859Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

Le 2023-02-03 à 11:30, Ævar Arnfjörð Bjarmason a écrit :
> Since [1] first released with Git v2.37.0 the built-in version of "add
> -i" has been the default. That built-in implementation was added in
> [2], first released with Git v2.25.0.
> 
> At this point enough time has passed to allow for finding any
> remaining bugs in this new implementation, so let's remove the
> fallback code.
> 
> As with similar migrations for "stash"[3] and "rebase"[4] we're
> keeping a mention of "add.interactive.useBuiltin" in the
> documentation, but adding a warning() to notify any outstanding users
> that the built-in is now the default. As with [5] and [6] we should
> follow-up in the future and eventually remove that warning.
> 
> 1. 0527ccb1b55 (add -i: default to the built-in implementation,
>    2021-11-30)
> 2. f83dff60a78 (Start to implement a built-in version of `git add
>    --interactive`, 2019-11-13)
> 3. 8a2cd3f5123 (stash: remove the stash.useBuiltin setting,
>    2020-03-03)
> 4. d03ebd411c6 (rebase: remove the rebase.useBuiltin setting,
>    2019-03-18)
> 5. deeaf5ee077 (stash: remove documentation for `stash.useBuiltin`,
>    2022-01-27)
> 6. 9bcde4d5314 (rebase: remove transitory rebase.useBuiltin setting &
>    env, 2021-03-23)
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  .gitignore                   |    1 -
>  Documentation/config/add.txt |    7 +-
>  Makefile                     |    1 -
>  builtin/add.c                |   66 +-
>  ci/run-build-and-tests.sh    |    1 -
>  git-add--interactive.perl    | 1920 ----------------------------------
>  t/README                     |    4 -
>  t/t2016-checkout-patch.sh    |    6 -
>  t/t3701-add-interactive.sh   |   29 +-
>  t/t6132-pathspec-exclude.sh  |    6 +-
>  t/test-lib.sh                |    4 -
>  11 files changed, 46 insertions(+), 1999 deletions(-)
>  delete mode 100755 git-add--interactive.perl

INSTALL mentions that Perl is needed to use 'git add -p', so we would want
to change that also, I think. I came up with this change to avoid reflowing 
the whole paragraph (feel free to squash it in)

diff --git a/INSTALL b/INSTALL
index 3344788397..c34d967f15 100644
--- a/INSTALL
+++ b/INSTALL
@@ -120,7 +120,7 @@ Issues of note:
          for everyday use (e.g. "bisect", "request-pull").
 
        - "Perl" version 5.8 or later is needed to use some of the
-         features (e.g. preparing a partial commit using "git add -i/-p",
+         features (e.g. sending patches using "git send-email",
          interacting with svn repositories with "git svn").  If you can
          live without these, use NO_PERL.  Note that recent releases of
          Redhat/Fedora are reported to ship Perl binary package with some

The other commands still in Perl not mentioned above are:

git-archimport.perl
git-cvsexportcommit.perl
git-cvsimport.perl
git-cvsserver.perl

which I think are too obscure these days to warrant a mention in there...
