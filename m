Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1BD820A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 05:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbeLKFKk (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 00:10:40 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:55734 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLKFKk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 00:10:40 -0500
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1gWaJa-0000hj-LD
        for git@vger.kernel.org; Tue, 11 Dec 2018 00:10:38 -0500
Date:   Tue, 11 Dec 2018 00:10:32 -0500
From:   Yaroslav O Halchenko <yoh@onerussian.com>
To:     git@vger.kernel.org
Message-ID: <20181211051032.GQ4633@hopa.kiewit.dartmouth.edu>
References: <20181210224901.GL4633@hopa.kiewit.dartmouth.edu>
 <20181211000859.130266-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181211000859.130266-1-sbeller@google.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: [PATCH] Re: [wishlist] submodule.update config
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, 10 Dec 2018, Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

> > > So you are proposing a variable like submodule.update
> > [...]

> > Glad to hear that. Not sure though I would know where to stick my
> > nose to figure out what to change. ;-)

> The update_module is computed via the submodule--helpers
> update-module-mode command, which is a small wrapper
> around determine_submodule_update_strategy()
> which you already touched in the other patch that makes
> --reset-hard another mode.

> This contains code and tests, but we'd need some docs as well.
> I am not sure about this patch as it allows for easier experimentation
> with submodules (e.g. "git config submodule.update '!git reset --hard'"
> sounds like what you're trying to get)

;-) it was indeed one of the original approaches I considered instead of
having "update --reset-hard"...

> and using them, but as discussed
> below this might be too much convenience already and we'd rather want to
> have it properly integrated into the real commands.

indeed, having "update --reset-hard" provides necessary to me
convenience for my use cases.  Motivation behind  submodule.update  was
primarily to allow for heterogeneous (but still simple to define)
strategies, where for some subproject I could just define
submodule.update to be "reset-hard" (I do not expect my local commits
matter) and in the others -- "merge" (I carry my changes on top).

But again, I must confess, that either I forgot or just do not see a
clear use-case/demand for submodule.update config myself any longer,
besides providing a potentially useful default over
submodule.MODULE.update config.

> > Well, not sure... In the long run, if UX is to be tuned up, I wonder if
> > it would be more worthwhile to look toward making all those git commands
> > (git merge, git checkout, git rebase, ..., git revert, git cherry-pick)
> > support --recurse-submodules with a consistent with the non-recursive
> > operation by default behavior

> That is the end goal, very much.

> > (e.g.  not introducing detached HEADs or
> > controlling that via a set of additional options where needed).

> As with the discussion of the submodule.repoLike option (the patch I
> referenced in the other discussion), this is tricky to get the right
> behavior, so it takes some more time to do.

> Also what is right for a "git merge --recursive" might be totally different
> from a "git submodule update --merge" as the former is not centered around
> submodules but merging, such that a sensible default would be expected,
> whereas the "submodule update" is allowed to have a rough edge.

Probably I need to try "submodules update --merge" to see what is that
rough edge which makes it different from the potential "merge
--recurse-submodules", or is it easy to describe? ;-)

I wonder if may be instead of pestering you about this config one, I
should ask about pointers on how to accomplish "revert
--recurse-submodules" or where to poke to make it possible to clone
recursively from  http://datasets.datalad.org/ where  we do not place
submodules all under the very top /.git/modules ;-)

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
