Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EA7C04AA5
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 00:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiHYA3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 20:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHYA3T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 20:29:19 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB412804B4
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 17:29:18 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id h27so14020277qkk.9
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 17:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=tByyhOFdi8FMzOuOJYXynQJHp6vjh8lz6iGElqg5HNY=;
        b=TZDnN8X8nZOu196y9MocsBKLhdiFtkn8FNEbV0g7vBc5lfjKUXHXNNLNK1dbMn/dq+
         OneMcMzzak2OeQccPAlvnuaMusM2B8j+rPFQpzr39axQe8Jg9UMltlysGtjhO0QNaxSf
         wKEnh7vbe6yFzg3ckGBC5PcUOz5d0yuVZoWSo1EC22tV8GC272vvZSPjPB/w3Mfml4r+
         QXXHb0DlCYtgE9SQK2usiCaMgxzc7ZBX1LhlXg3mTqiQbReHktQ9yFsrP7OrUqJCUvlP
         PfIj2QXFezkeCQPkZlSpOvrXp9+IISafP6Yd8ZLz/OFfk1bDX5STrC7ybDZCJI6gAKDY
         WGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=tByyhOFdi8FMzOuOJYXynQJHp6vjh8lz6iGElqg5HNY=;
        b=NcuTqN5G99GwlYkD1VJL3w1eLpWf7VhCPyAzwmFxMF0vpnI9lmCn0TAhlns4w8IJzn
         BgHWwZuWKc0hLogVZhuEvwDJvcmf8rFA7qzsEHZeUp7IlKmtiaS1QBWFwV76X8rIjcOo
         SpcPIzQsuqEki1m5jU45cG3b7UJBXTPu56Qh1RqyvYcXbPM2oXtnvuKIzl2X9pbMF8ka
         huXostGBDgSjgtd06sYLy9fSVIGR6n58cKtOsPOFfNgaFzEayRKnf0VTad4c/+GbbGvQ
         JJK6pqQNbGip+Jk/n5zhC2g1dk7yw7G5hW58oBJPpJ4ZyA1/SrWvyUr7aPasFsJcFsvo
         D7gQ==
X-Gm-Message-State: ACgBeo16kAVX529rs8iSz1Jhqq8mJt8uKIqaCT/dUU3toRJ7g2iRTkM2
        cDfBA4YxH4x5NMbMcMGKg3k=
X-Google-Smtp-Source: AA6agR6MC9m5imDEGZxKL9g9bij2N8izl/llCzpnFmyUF06y7gnchDQgQLRZh7vHsuU+ETYkCRBjpA==
X-Received: by 2002:a05:620a:b04:b0:6ba:e707:b245 with SMTP id t4-20020a05620a0b0400b006bae707b245mr1386293qkg.418.1661387357797;
        Wed, 24 Aug 2022 17:29:17 -0700 (PDT)
Received: from [192.168.1.128] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id b17-20020ac84f11000000b0031e9ab4e4cesm13547982qte.26.2022.08.24.17.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 17:29:17 -0700 (PDT)
Subject: Re: [PATCH 4/5] rebase --keep-base: imply --reapply-cherry-picks
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
 <9cd4c372ee4b3e5ba45c66a43ad0edaf52f0eed9.1660576283.git.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <53130a55-8bae-0414-64c2-bb577a1ae02d@gmail.com>
Date:   Wed, 24 Aug 2022 20:29:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9cd4c372ee4b3e5ba45c66a43ad0edaf52f0eed9.1660576283.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 2022-08-15 à 11:11, Phillip Wood via GitGitGadget a écrit :
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> As --keep-base does not rebase the branch it is confusing if it
> removes commits that have been cherry-picked to the upstream branch.
> As --reapply-cherry-picks is not supported by the "apply" backend this
> commit ensures that cherry-picks are reapplied by forcing the upstream
> commit to match the onto commit unless --no-reapply-cherry-picks is
> given.
> 
> Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks a lot for picking this up ! I still think that it's a good idea
to do that. At least now since 767a4ca648 (sequencer: advise if skipping 
cherry-picked commit, 2021-08-30) we get a warning, but I think changing
the default for '--keep-base' is even better.

> ---
>  Documentation/git-rebase.txt     |  2 +-
>  builtin/rebase.c                 | 15 ++++++++++++++-
>  t/t3416-rebase-onto-threedots.sh | 21 +++++++++++++++++++++
>  3 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 080658c8710..dc0c6c54e27 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -218,7 +218,7 @@ leave out at most one of A and B, in which case it defaults to HEAD.
>  	merge base of `<upstream>` and `<branch>`. Running
>  	`git rebase --keep-base <upstream> <branch>` is equivalent to
>  	running
> -	`git rebase --onto <upstream>...<branch> <upstream> <branch>`.
> +	`git rebase --reapply-cherry-picks --onto <upstream>...<branch> <upstream> <branch>`.
>  +
>  This option is useful in the case where one is developing a feature on
>  top of an upstream branch. While the feature is being worked on, the

I think the doc should explicitely mention "This implies `--reapply-cherry-picks`",
in addition to your changes.

Cheers,

Philippe.
