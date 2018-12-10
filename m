Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 773E620A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 22:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbeLJWtJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 17:49:09 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:50346 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeLJWtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 17:49:09 -0500
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1gWUMM-00019r-UA
        for git@vger.kernel.org; Mon, 10 Dec 2018 17:49:07 -0500
Date:   Mon, 10 Dec 2018 17:49:01 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     git <git@vger.kernel.org>
Message-ID: <20181210224901.GL4633@hopa.kiewit.dartmouth.edu>
References: <20181208154539.GH4633@hopa.kiewit.dartmouth.edu>
 <CAGZ79kY+F776YfNBrx3wk3ffv4sqqabM5iJxbQDiPE6xoio69w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kY+F776YfNBrx3wk3ffv4sqqabM5iJxbQDiPE6xoio69w@mail.gmail.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: [wishlist] submodule.update config
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, 10 Dec 2018, Stefan Beller wrote:
> > I wondered, if you think it would be sensible to also add of
> > submodule.update which would be considered before submodule.SUBMODULE.update
> > variable possibly defined per submodule.  That would be more inline with desire
> > to use any of the --merge, --rebase (and hopefully soon --reset-hard)
> > strategies specified as an option for submodule update, where no per-submodule
> > handling  is happening.

> > Thanks in advance for the consideration!

> So you are proposing a variable like submodule.update
> without the .<name>. that would apply to any submodule?

yes

> The precedence in descending order of these
> configs that modify the behavior of "git submodule update"
> would be:

> * the command line flag (--merge/--rebase/--checkout)
> * submodule specific instructions (submodule.<name>.update)
> * generic submodule config (the new submodule.update)
> * default as --checkout

sound great

> I first hesitated in thinking this would be a good addition,
> as there is no plumbing command for submodules,
> to easily modify submodules irrespective of the user
> config. But that is out already with the submodule
> specific update configs.
> So I think it may be a good addition.

Glad to hear that. Not sure though I would know where to stick my
nose to figure out what to change. ;-)

> I wonder if we'd be better off to re-invent the UX instead
> of hiding your intentions in a config setting for a command
> that is already long to type. What about

>   git submodule merge
>   git submodule rebase
>   git submodule checkout
>   git submodule reset (--hard)

> as aliases for
>   git submodule update (...)

Well, not sure... In the long run, if UX is to be tuned up, I wonder if
it would be more worthwhile to look toward making all those git commands
(git merge, git checkout, git rebase, ..., git revert, git cherry-pick)
support --recurse-submodules with a consistent with the non-recursive
operation by default behavior (e.g.  not introducing detached HEADs or
controlling that via a set of additional options where needed).  I feel
that "git-submodule" ideally should not get its interface extended to
complement everything "git" commands can do, although that might need to
be extended to provide necessary plumbing.  As for the UX, it should
provide only the set of additional commands, which could not be present
in the main API (e.g. pure "git submodule" itself to list
submodules, and "submodule foreach", "init", "deinit").

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
