Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17873C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 22:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhLKWsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 17:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhLKWsC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 17:48:02 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D34C061714
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 14:48:02 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id t5so40400259edd.0
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 14:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=FdYd8f5Q7UlLBr0a17DKk+OnwbgjyFVTF6umyWrRNtA=;
        b=mVVaYJ4v0QnZVP2ouhEC+GK4tTF3saTU+34imVixxJBLbH7dVk/9vRIvlKGsIFeKhI
         onrBv3guGWhgnhtEqmpEmRSxZaGnajyaVSHcf1tAtCtbxBbNTJv4vXySzdIZT0L9eEMB
         qAeqYnRcyFxFKJaCVhPLxfV2PNYpr91THqPzePXRkBItm2tBHCim6AmtieNDXOTOtO5I
         atnfOLFvSxm7rpzgYoQj5hoO5zwO6+MaMLo0NIPmoyFSPbNdhNXH3oNLuOQxJ4at7Cbx
         eoM98rFFRWeX8VzLQ86tDvigYNn0Ldx+s1mN07q+J6IZjQ8Ga67Z6G0v1BVFuGY2DxWp
         J/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=FdYd8f5Q7UlLBr0a17DKk+OnwbgjyFVTF6umyWrRNtA=;
        b=Skn6Do8IlN81Wci/szM6vwZqbW6J6RndAuqgyzFJXu6bqxCei4S6d6zjF8Ff/8nxnR
         d2kbBk70NewNj8FN4ylnRB1Bkw1sLDM06jPBhlWp66G63yrHOYVOTUw2AzDYPzQEnuYQ
         p8ugN1iYSE5g7rqEihfbRcaMmHx9Wu1XWGH660lWsgQlzdgg2XBSZ/XGLqDGQNSKkBD3
         i1p3ZKcUGr+Q3lmLXn1b2ySCDMvZBF0+My1RWYM5s/Msm1VQNAhJeItzl1Eec1WaHIEP
         s+/zZlVLJXV5l/DGWNbA6cPdJgc8OWrNqYHjgWISbiPXP30oU0ygkqOb36YiaZSlngwS
         kQxw==
X-Gm-Message-State: AOAM530TFMqw1GeYPdr7zZ7Lj3hQI4UNkdd5RbMcS8Lgi0op32Y1TBA7
        OijD7KHLiCqjIHucbHav1CMF7xkmxGw=
X-Google-Smtp-Source: ABdhPJw/33pVhStaxxJki2slHuFtKQTXLqZwAf1cheqyOmoxkPrZcLhBplMawYjD+3k5O0tzOb+jzQ==
X-Received: by 2002:a17:906:79c3:: with SMTP id m3mr32870519ejo.332.1639262880889;
        Sat, 11 Dec 2021 14:48:00 -0800 (PST)
Received: from cpm12071.fritz.box ([79.140.114.159])
        by smtp.gmail.com with ESMTPSA id go10sm3556080ejc.115.2021.12.11.14.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 14:48:00 -0800 (PST)
References: <20211203034420.47447-1-sunshine@sunshineco.com>
 <20211203034420.47447-3-sunshine@sunshineco.com>
User-agent: mu4e 1.6.8; emacs 27.2
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/2] git-worktree.txt: add missing `-v` to synopsis for
 `worktree list`
Date:   Sat, 11 Dec 2021 23:25:40 +0100
In-reply-to: <20211203034420.47447-3-sunshine@sunshineco.com>
Message-ID: <gohp6kilvupxls.fsf@cpm12071.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine <sunshine@sunshineco.com> writes:

> When verbose mode was added to `git worktree list` by 076b444a62
> (worktree: teach `list` verbose mode, 2021-01-27), although the
> documentation was updated to reflect the new functionality, the
> synopsis was overlooked. Correct this minor oversight.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  Documentation/git-worktree.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 8a7cbdd19c..9e862fbcf7 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]] [-b <new-branch>] <path> [<commit-ish>]
> -'git worktree list' [--porcelain]
> +'git worktree list' [-v | --porcelain]
>  'git worktree lock' [--reason <string>] <worktree>
>  'git worktree move' <worktree> <new-path>
>  'git worktree prune' [-n] [-v] [--expire <expire>]

Oops! Thanks for cleaning up after me.

-- 
Thanks
Rafael
