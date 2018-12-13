Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3841F20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 16:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbeLMQug (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 11:50:36 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:47077 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbeLMQug (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 11:50:36 -0500
Received: from [10.31.188.88] (helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1gXUC2-0000nt-7m
        for git@vger.kernel.org; Thu, 13 Dec 2018 11:50:34 -0500
Date:   Thu, 13 Dec 2018 11:50:29 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     git <git@vger.kernel.org>
Message-ID: <20181213165029.GB4633@hopa.kiewit.dartmouth.edu>
References: <20181210224901.GL4633@hopa.kiewit.dartmouth.edu>
 <20181211000859.130266-1-sbeller@google.com>
 <20181211051032.GQ4633@hopa.kiewit.dartmouth.edu>
 <CAGZ79kaka_DTUMkGdSbYW7Vam3XSWcdqxPrzFDXZJSsQC1zHYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaka_DTUMkGdSbYW7Vam3XSWcdqxPrzFDXZJSsQC1zHYQ@mail.gmail.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 10.31.188.88
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: [PATCH] Re: [wishlist] submodule.update config
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, 12 Dec 2018, Stefan Beller wrote:

> > But again, I must confess, that either I forgot or just do not see a
> > clear use-case/demand for submodule.update config myself any longer,

> ok, let's drop that patch then.

ok, But I will cherish it in my memory so whenever the use case
comes back to me -- I will be back too ;)

> > Probably I need to try "submodules update --merge" to see what is that
> > rough edge which makes it different from the potential "merge
> > --recurse-submodules", or is it easy to describe? ;-)

> I think the branch handling would be the difference. I'd expect
> "merge --recurse-submodules" to be sensible about staying on
> the branch both in the superproject and submodule, whereas
> "submodule update --merge" is too much plumbing, that we'd
> expect a sensible branch handling (detached HEAD is just fine,
> right?)

re "detached HEAD is just fine" -- I guess "it depends"...  E.g.  why
should it get detached if it was not detached to start with?  Why not
just to perform a regular "git merge --recurse-submodules" within
the submodule thus making it all consistent across?

If there is a need in detached HEADs handling of merges etc, get
them detached and then they would stay detached - no surprises.

> The merge result would be the same, I'd think.

it better be ;)

> > I wonder if may be instead of pestering you about this config one, I
> > should ask about pointers on how to accomplish "revert
> > --recurse-submodules"

> What do you want to do in revert --recurse-submodules?
> When you have "revert --recurse-submodules $COMMIT",
> would that revert all submodule commits introduced in
> that commit as well as the regular superproject revert?

That is correct

> This would require either opening multiple editors
> (once per submodule and at last for the superproject)
> or we'd have to do fancy snip-snapping of the user input,
> e.g. providing a template like:

>     Revert "$title"

>     This reverts commit $COMMIT.

>     # The above is for the superproject commit
>     # Please enter the commit message  ...

>     # Changes to be committed:
>     #       ...
>     # --8<-- DO NOT DELETE THIS LINE
>     # Below is the commit for submodule $submodule:
>     Revert $submodule_range

>     This reverts commits $maybe_many

>     # The above is for the submodule commit
>     # Please ...

> I guess it may be easier to just have multiple
> editors opened sequentially to give a commit
> message.

yeap - that would be beautiful.  Now I just need to do that all manually
;)

> >  or where to poke to make it possible to clone
> > recursively from  http://datasets.datalad.org/ where  we do not place
> > submodules all under the very top /.git/modules ;-)

> Not sure what you mean there?

sorry I was not clear... I will start a new thread for a complete
description.

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
