Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061E3C433EF
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 14:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353434AbiFAOtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 10:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiFAOtk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 10:49:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD835DBFA
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 07:49:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b8so2512988edf.11
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rttvl6QHLs1ZkUoiwb1j5YXscFnYjaEC+46PYb7oOO8=;
        b=GQD//tWIwrnI3UUIJrBkVLjnOPNof56LaHk027Q9Vzcvc/S2Aeo8WWytdY8oqpyXmQ
         d/7FczpgJCbU0K/6zzupDhcAke8OXYDcW9JDW/kg8D+vD4wNfthcw6mN4tU9yfmVNn15
         JkyQwfIgGph7GGO8KcgbStvxsrXsH5BdOemEdYi4sf73IzYk90sSqKog2HHEvoLOC48g
         F9SzIi0+0kkOLkXuewyOUPmv4Ct1JGiO313QM5GkmTtp8eZaP70PcUS03FfhdmoYh2EX
         yG7i2vDwFfra8jx0SdlhGFc20RiRkT0QByAcwK19yKdLP51+bO9Sy2K/6O271BnkNzac
         IX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rttvl6QHLs1ZkUoiwb1j5YXscFnYjaEC+46PYb7oOO8=;
        b=MVpZuc9zutZltemth6OkUSOKXCXgBc+kld8vkyK65ChqcztgFxfno4/iUJ6NfQBZ7C
         9NOevFY1ikhcnm1AymQSp13Y265b7pIiwb+D5MgWLBhWF/9ILPWtP4/1bR5DeeCPf3/8
         IuQgr3dFh2tNpGP9FJrBAcUuf/WDmJrfy3SJF78x55Lu0WGspXE5DBzUlUlK9jX/iJot
         v/9S0YmTpxxElFJojWwAWF3pOaApkfltRf3ZYaUZU3j+gpaE6p8r8mX3q9T7+AmzI2K9
         RnQigDkxnv+7GrdDSsreAWkRWvZnn44CzoJVovziY9SmGbYzNJci217dmsn0LCWdi+kw
         jkDw==
X-Gm-Message-State: AOAM531knxc9CfpMkMmCZ5Em5/bMMzGWKiL4hjlDpmChYWSO1emgDiRx
        68Ah+Y+8obTxVm6mbZTHG8Ul1db4v3dxDQ==
X-Google-Smtp-Source: ABdhPJzKVOHZ+D/SSuXKmiD1AYPDVjTECSJZTh0JpbRgQ17jo7Vy/F/4MzJHOtcZDdocpQsJSvYTjA==
X-Received: by 2002:a05:6402:1941:b0:413:2555:53e3 with SMTP id f1-20020a056402194100b00413255553e3mr74855edz.164.1654094977292;
        Wed, 01 Jun 2022 07:49:37 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a23-20020aa7cf17000000b0042dc882c823sm1114089edy.70.2022.06.01.07.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 07:49:36 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nwPfD-001ECV-KD;
        Wed, 01 Jun 2022 16:49:35 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Joakim Petersen <joak-pet@online.no>
Cc:     git@vger.kernel.org, Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [RFC PATCH] git-prompt: make colourization consistent
Date:   Wed, 01 Jun 2022 16:47:46 +0200
References: <20220601134414.66825-1-joak-pet@online.no>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220601134414.66825-1-joak-pet@online.no>
Message-ID: <220601.864k141ls0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 01 2022, Joakim Petersen wrote:

> The short upstream state indicator inherits the colour of the last short
> state indicator before it (if there is one), and the sparsity state
> indicator inherits this colour as well. Make the colourization of these
> state indicators consistent by clearing any colour before printing the
> short upstream state indicator, as this immediately follows the last
> coloured indicator.
>
> Signed-off-by: Joakim Petersen <joak-pet@online.no>
> ---
> As of 0ec7c23cdc6bde5af3039c59e21507adf7579a99, colourization of the
> output of __git_ps1 has changed such that the short upstream state
> indicator inherits the colour of the last short state indicator before
> it (if there is one), while before this change it was white/the default
> text colour. Some examples of what I mean are (assuming all indicators
> are enabled):
>  * If the local tree is clean and there is something in the stash, both
>    the '$' and the short upstream state indicator following it will be
>    blue.
>  * If the local tree has new, untracked files, both the '%' and the
>    short upstream state indicator will be red.
>  * If all local changes are added to the index and the stash is empty,
>    both the '+' and the short upstream state indicator following it will
>    be green.
>  * If the local tree is clean and there is nothing in the stash, the
>    short upstream state indicator will be white/${default text colour}.
>
> This appears to be an unintended side-effect of the change, and makes
> little sense semantically (e.g. why is it bad to be in sync with
> upstream when you have uncommitted local changes?). The cause of the
> change is that previously, the short upstream state indicator appeared
> immediately after the rebase/revert/bisect/merge state indicator, which
> is prepended with the clear colour code, while it now follows the
> sequence of colourized indicators, without any clearing of colour.
> However, adding a clearing of colour before the short upstream state
> indicator will change how the sparsity state indicator is colourized,
> as it currently inherits (and before the change referenced also
> inherited) the colour of the last short state indicator before it.
> Reading the commit message of the change that introduced the sparsity
> state indicator, it appears this colourization also was unintended.
>
>  contrib/completion/git-prompt.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 87b2b916c0..dfd6cef35f 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -286,6 +286,7 @@ __git_ps1_colorize_gitstring ()
>  	if [ -n "$u" ]; then
>  		u="$bad_color$u"
>  	fi
> +	p="$c_clear$p"
>  	r="$c_clear$r"
>  }
>  
>
> base-commit: e54793a95afeea1e10de1e5ad7eab914e7416250

This seems to make sense to me, but I haven't looked deeply into it. But
let's CC the author of 0ec7c23cdc6 (git-prompt: make upstream state
indicator location consistent, 2022-02-27) (which I've done here).

For a non-RFC patch I think a rephrasing of most of what yo uhave below
"--" should be part of the message. Note how I referred to the
0ec... commit above, you should reference the commit like that (see
SubmittingPatches).

Thanks for working on this fix!
 
