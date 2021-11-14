Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF8FC433EF
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 17:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF93261027
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 17:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhKNR6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 12:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbhKNR6N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 12:58:13 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A67C061746
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 09:55:18 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r12so61348995edt.6
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 09:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=L3tjteDNpIx8+6e+rLSsOdI1GKGsAvM+2xYcHmDRwmM=;
        b=EqMJBNJIH+z0SLazimwt8frEcHGPN4VIJpAZwVx06B3XF4q+/u+bQs1DdV/w3gg309
         j1+Qfsl6LcNmacQM03yaXApUHiDeM20ZsYfNyrdasY2IfUmEHuWFFRfe9NMdPWWSjOCp
         qhOcVRiDJPpx6yFw60RDIda3mPHN2SvFL56ZXFQqtk1pPAcGxC6AYsHoK9ISHWEqykR+
         nB2wj2kn38Cu2YYyABNFVGF//5/ox5lQb77DPit+gNhh160+uiaCPpLo9s4im3z5H9xq
         u6/3i7hjjK2Q6/QSRdNJkt+bsR4UTodpXWdNPdS2A31+piS5hhYY0+1xiUQztjyMN+ds
         EoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=L3tjteDNpIx8+6e+rLSsOdI1GKGsAvM+2xYcHmDRwmM=;
        b=60kI/mXmqmG2wBO8moSmwPIlwa1hYVthgL9KWoWVh1NkG/sgMDOZz57I0OanKQMVUR
         amjfg998svO6ZYzoaJw8gsvqfUZKRuTn6E7dIIzsmjv9v1k/Bzf2YKnxatWfRtfaLAaW
         BJFB6j6aq2usucZXCNAy8kD4gcnGa3Tgin3YapV26+u2CCyWZIPI83qvemCgibuhLFIo
         9CBIbaZoaTzhz7ub5kXZTxHmH2pz5DnQPDK4uS3Qt2gz654o6oXqvgLziTW1Ec+jejmw
         8R6sBkbyC17W2/9QDvgXnR5mXvaMIJZhJLkHCCm3LYUebLVx/VfAUQzGioG5Bl8uPj2a
         M9OQ==
X-Gm-Message-State: AOAM530yOLJ4Wt2ih/p3CE7knQP1F5SlPu09KsGoAI0ATz4kOrQGT2oW
        3G4PJZOLk8zq/y3B/j7wxfg=
X-Google-Smtp-Source: ABdhPJzoW8tlCJVwV6InGUDLyW/kXb/KVep32tsBFumJYHy73gB1voybpFpbrRMtOV2e1VADa1t6fg==
X-Received: by 2002:a17:906:3056:: with SMTP id d22mr33968259ejd.548.1636912517400;
        Sun, 14 Nov 2021 09:55:17 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p10sm5885753edj.91.2021.11.14.09.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 09:55:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmJim-000s2i-Hr;
        Sun, 14 Nov 2021 18:55:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas Koutcher via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Thomas Koutcher <thomas.koutcher@online.fr>
Subject: Re: [PATCH] subtree: ignore merge.ff setting
Date:   Sun, 14 Nov 2021 18:54:25 +0100
References: <pull.1139.git.git.1636902454370.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <pull.1139.git.git.1636902454370.gitgitgadget@gmail.com>
Message-ID: <211114.864k8etyez.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 14 2021, Thomas Koutcher via GitGitGadget wrote:

> From: Thomas Koutcher <thomas.koutcher@online.fr>
>
> When `merge.ff` is set to `only` in .gitconfig, `git subtree pull` will
> fail with error `fatal: Not possible to fast-forward, aborting.`. This
> fix ignores the `merge.ff` setting when using `git merge` within subtree.
>
> Signed-off-by: Thomas Koutcher <thomas.koutcher@online.fr>
> ---
>     subtree: ignore merge.ff setting
>     
>     When merge.ff is set to only in .gitconfig, git subtree pull will fail
>     with error fatal: Not possible to fast-forward, aborting.. This fix
>     ignores the merge.ff setting when using git merge within subtree.
>     
>     Signed-off-by: Thomas Koutcher thomas.koutcher@online.fr
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1139%2Fkoutcher%2Fsubtree-merge-ff-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1139/koutcher/subtree-merge-ff-fix-v1
> Pull-Request: https://github.com/git/git/pull/1139
>
>  contrib/subtree/git-subtree.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 7f767b5c38f..de918d9fb05 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -976,10 +976,10 @@ cmd_merge () {
>  
>  	if test -n "$arg_addmerge_message"
>  	then
> -		git merge -Xsubtree="$arg_prefix" \
> +		git -c merge.ff= merge -Xsubtree="$arg_prefix" \
>  			--message="$arg_addmerge_message" "$rev"
>  	else
> -		git merge -Xsubtree="$arg_prefix" $rev
> +		git -c merge.ff= merge -Xsubtree="$arg_prefix" $rev
>  	fi
>  }

"-c merge.ff=" works, it's lesser known syntax. I'd tihnk "-c
merge.ff=false" would be better here, i.e. what matches "git config"'s
description of "merge.ff".
