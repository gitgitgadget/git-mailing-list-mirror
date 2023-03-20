Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232E5C7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 17:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjCTReQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 13:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjCTRds (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 13:33:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402BB7A88
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 10:29:49 -0700 (PDT)
Received: (qmail 18683 invoked by uid 109); 20 Mar 2023 17:02:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Mar 2023 17:02:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24968 invoked by uid 111); 20 Mar 2023 17:01:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Mar 2023 13:01:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Mar 2023 13:01:58 -0400
From:   Jeff King <peff@peff.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase issue
Message-ID: <20230320170158.GA2614670@coredump.intra.peff.net>
References: <CAHp75VfTQZ8vFQXZKgbsedG2BOad-pv9fCVkNkX+kFAxhnhhXQ@mail.gmail.com>
 <CAHp75VcZJPysc2-NXTC53XvOwbx-UfPO9SbsBJFb72JGHFyO1A@mail.gmail.com>
 <CAHp75Vc419vikJ184syJHN7rxyaspHzgtT9a_uFA=CT=cdqo-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75Vc419vikJ184syJHN7rxyaspHzgtT9a_uFA=CT=cdqo-w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Please don't put random folks in the to/cc unless you think they have
specific knowledge related to your problem.]

On Mon, Mar 20, 2023 at 02:10:38PM +0200, Andy Shevchenko wrote:

> > > With the new release I have got an error
> > >
> > >   fatal: 'netboot' is already checked out at ...
> > >
> > > To work around this I have to split the above to
> > >
> > >   git checkout --ignore-other-worktrees "$branch"
> > >   git rebase --rebase-merges -X ours --onto "$newbase" "$oldbase"
> > >
> > > which makes all these too inconvenient.
> > >
> > > Any suggestions?
> 
> So, what should I do? Today I got again to help manually with my (used
> to working) scripts.

Running "git log --grep=already.checked.out" suggests that it may be
b5cabb4a967 (rebase: refuse to switch to branch already checked out
elsewhere, 2020-02-23).

Adding its author to the cc, who may be able to say more. But my
understanding is that this was probably fixing a bug (though I don't
know all the implications of having a branch checked out in multiple
worktrees).

-Peff
