Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC52AC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62EC1610E7
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhDHXbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDHXbE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:31:04 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF7EC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 16:30:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r22so4359197edq.9
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 16:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=XXNkuswKZdUGdFPCevyQzvhSFpx217uH7mhHmiG1lfU=;
        b=lDFobnDaiErz7bwKoHOlFk6ZDEqw0hONIOhcG1iXr7MUVNODjH1tcLLzmMrUQUiYNV
         Mvz+xnONYnL2xp3CCzfmpBQ1V7X56MVKC1ox/3LhuqzjzjxoKdQqfAbh4ZFqJ0KTGZGT
         m4aX36GhyRxRalgw7wm78wGrzMrbFC0DgwxKB+G937tRWEMEZBvMuJw5r0Z/Skfef+vJ
         dDZJNqwsJHcfgzc+dy5W7wxq3wnabssY6kH/CKrgf3RHRFb20EM8ljteSt3OgERjKf/2
         SYKQPFgEzS6qkNcGHsMitUOp3sUsk2RWhc1teXUFWJNcc3We9oJpTYG2F8ga0rzBmObM
         s1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=XXNkuswKZdUGdFPCevyQzvhSFpx217uH7mhHmiG1lfU=;
        b=lKwgrRbj31iVg3bLu9x7pTvCNahs4R896ckQ/hBs5JzBOiK/DyzInIqxUDQ6VRVaDA
         FVV+LHt7N3ZZWJCX8pJ2seDLurHkjZLrt5HjcZZlTBoJWOziviiUga6f1Pmy8zE43fdS
         k33+akuur0ol8bUoEJINjohBAOXW/gzDa7E5eKTrAx67R4Vo53hC5G2ee3D+gBg7bJgf
         llqvbjY/IodUeVbYyDdgmu+AtVWTeaavUurAgAVyaSnp3epyxpwpPBlv1cA69x6eGJfa
         9+pHJwsDFbtF6n7Zw+cz0BjVQIaNwAYpGCBOCOo7qGcz6GA+HNj6n1kH+Cg6413fhtqc
         GSOg==
X-Gm-Message-State: AOAM532QnF7QQaFnzzeJ4u+REtmscGJAjaQFVSLbB53TncuQMkhqD+mC
        J7ePszpqxvi/wCU6qwTwelQ=
X-Google-Smtp-Source: ABdhPJxci7Z9rbTN6Bb3YaT3f/pHi4bL0NTO+4RnYUHMdIXJ+MIGEB42FWGsbRAu/RoCPu+Fr2XpxA==
X-Received: by 2002:a50:ec8c:: with SMTP id e12mr14720811edr.249.1617924651594;
        Thu, 08 Apr 2021 16:30:51 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u13sm365844ejr.100.2021.04.08.16.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 16:30:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] config: Introduce GIT_CONFIG_NOGLOBAL
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
Date:   Fri, 09 Apr 2021 01:30:50 +0200
Message-ID: <8735w0icb9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 08 2021, Patrick Steinhardt wrote:

> +`GIT_CONFIG_NOGLOBAL`::
> +	Whether to skip reading settings from the system-wide `~/.gitconfig`
> +	and `$XDG_CONFIG_HOME/git/config` files.  This environment variable can

Let's not call ~/.gitconfig system-wide with /etc/gitconfig being,
saying "global" is consistent with git-config's own
--global/--system/--local etc. Still a bit odd, but at least the same
nomenclature.
