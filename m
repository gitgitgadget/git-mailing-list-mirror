Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEA3C433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 18:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241806AbhKZSfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 13:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243960AbhKZSdV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 13:33:21 -0500
Received: from sprint-2.amdmi3.ru (sprint-2.amdmi3.ru [IPv6:2a0a:2b41:94:cb5e::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60E5BC061D7B
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 10:06:55 -0800 (PST)
Received: from amdmi3.ru (localhost [IPv6:::1])
        by sprint-2.amdmi3.ru (Postfix) with SMTP id 2B50A188FFA;
        Fri, 26 Nov 2021 21:06:50 +0300 (MSK)
Received: by amdmi3.ru (nbSMTP-1.00) for uid 1000
        amdmi3@amdmi3.ru; Fri, 26 Nov 2021 21:06:50 +0300 (MSK)
Date:   Fri, 26 Nov 2021 21:05:46 +0300
From:   Dmitry Marakasov <amdmi3@amdmi3.ru>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: pull.rebase config option broken in 2.33.1
Message-ID: <YaEh+k2q+9LoLXNh@hades.panopticon>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <YYFEE/2g3SiM04zx@hades.panopticon>
 <YYFJEASSimMhEsYz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YYFJEASSimMhEsYz@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Jeff King (peff@peff.net) wrote:

> > After update from 2.33.0 to 2.33.1 the pull.rebase = true option
> > no longer works: `git pull` no longer tries to rebase (however manual
> > `git pull --rebase` works fine):
> > 
> > % git config pull.rebase
> > true
> > % git pull
> > fatal: Not possible to fast-forward, aborting.
> > % git pull --rebase
> > Successfully rebased and updated refs/heads/local-fixes.
> > % git pull
> > fatal: Not possible to fast-forward, aborting.
> > % grep -C1 rebase .git/config
> > [pull]
> > 	rebase = true
> > [rebase]
> > 	autostash = true
> > 
> > After downgrade to 2.33.0:
> > 
> > % git pull
> > Current branch local-fixes is up to date.
> 
> This looks like the same bug discussed in:
> 
>   https://lore.kernel.org/git/CH2PR06MB650424B4205102AC6A48F489B1BD9@CH2PR06MB6504.namprd06.prod.outlook.com/
> 
> There's a fix in that thread. It's currently in "next", but didn't quite
> make the cutoff for the upcoming v2.34.0.

For the record, the problem is still present in 2.34.1

-- 
Dmitry Marakasov   .   55B5 0596 FF1E 8D84 5F56  9510 D35A 80DD F9D2 F77D
amdmi3@amdmi3.ru  ..:     https://github.com/AMDmi3  https://amdmi3.ru

