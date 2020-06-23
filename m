Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C824C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 064E9204EA
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WvbLp93Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391368AbgFWUc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:32:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:56221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390856AbgFWUc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 16:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592944367;
        bh=MPyLzpmKj3XaRYLYsCzgwUrKPXCKQskfaT5I98Bm4do=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WvbLp93QWJ3lkJZ3/mzrr8dJ74he65DdpRwND7Z1vf/5eRHPSk3cOdsTOvmPxwtlZ
         27kbU202k5OvDPvUSK7o9zxPatpdoyRAm8ox5GHTSKrViO/qWnhk0h06d9mTZQb2lx
         wB9w1XC2AOBwhJHSgqpcCNxatzXj08dPH5DUADKQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bSj-1inzbB3He7-010a1l; Tue, 23
 Jun 2020 22:32:46 +0200
Date:   Tue, 23 Jun 2020 22:32:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for
 new repositories
In-Reply-To: <20200616124502.GC666057@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2006232228560.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com> <CAPig+cSnEvVB5vsffFXidG1-XNxDX10u2XhD9NqV3pwh8zyxxw@mail.gmail.com>
 <20200616124502.GC666057@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mtGbM2KW5/sfLO6a8VlryeKDb3a5jD0aePgkk3yRchCvIVb9Y//
 R8ZHEtNt0x/amKJ0B3BeyTYA6x1YnqfRCEcYsqxVUIoR2HN3FgUslIGaN+WcFySb7XJeiZW
 J3EygoyEl1Sf+2r1Ql4tcZrFAMoJhtECmTTZRbplOQwcbL04EtE3HGIgKgxtBezwykRB7Lz
 ucLTkeNm+4DCmqxKLOT0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c4ou7AScv3E=:6KL7e4QVidTuGmnT5d02CX
 tgxMXxCje5RMfjzMUNBXQjscssGDY8qhtoS6CSPWWOLNDEj9+KqcXQaVoWmUbPMsqOuxVPv2z
 +584j+i4twP1RNHBtDdg2chJarUExz0Je19+1+dmmIY51QiUQhV7ZykO0wJVRXbC6XJwpJLGm
 QRdWAzlMCyl0OhiKmpVxcOX7ZlH1/O5VvfE1ikSoPcx3DwOrWyN8T2a3IJX+qOlv933gNpy2A
 awcD2x3k2bywmUptDLn7QhLwv19kKoF9eacpAmc6GNuTa81jzIIMpokTqqIlki42tSz6D8tk9
 MXSkWYFwSBfkgLTOwjJ8TwR66w0bEgP41Uslmi0AxNcQMjHRKH6s38ZK9w25B4/xhWTwtvc/7
 mu8tLxwTiYzEUbtHweZIKAjl6y3LxXN99mw07DO3ZrvNWpwJlMV0JDHTbgoqj/4pcVHOwzUvp
 Kqqk3WCwBAZpJEZDYQ6RBmLRXH37bq+pIEk9PoUEwXpuyLyjpz5BgUrpU47ow6rTxhW0K9arm
 9kbrL2a+a6Op/MrPrLEOEfF6u+CRELPlTSi+w9i49Q13Yf5J4lXyeRaaz68AjFz/8vxZkoOxA
 PWodhal+gHWoN5Rch0QBM1TJ6QB8zC11CYPDvzRLBWdcwK/7pL+gQeMOqfaUEGHiwr5yFsTWe
 JieTWbEM6fLYZADR6g9OqkuXYmGd+7+BFFu7ldALaaaMScLD8zt+j0ldJSeMmQ8ITpg+wzxF3
 wIlNzBJqNRPRTuMIIbQZ1LnpvblX1TJKxbctcrw1TiWLknCtHrQpCHMl3sK6L3AuCI8lNZzCu
 XDc3Y+VZSFrdLCsXkC2Dn15hij6FGnuXCnFww2snWbuTGpigxm7rTVtURnXzkb9FHr/kjpLMq
 2Mw8P9QXvc5Yt05wtXR7Z0M+EEz8e0LvfFA74oAwF5bgSK//2FL+ONRoPlnuBY2axd1XFA5h/
 Y66/OpfqIsnMZ3yK8LYfF9hx18Nm69521rBfo17LQ8fxaKcHe02R9U1k1XhNan5ZPTBzliZAT
 TIav64g1I/RRUl8I9MUKz95Wg1tF3L4n0zbUt0y+LE0NHAMJ/qHyDSs8B97WYG+0T6+WS2cMw
 il2u450n+e1Z8HqXA5Z1fJH8dFs5MMdObFOIZA/yEBF5oU9f3YEkkRNns69hN8+LYT7ce3Nen
 H8dd68LlpKlIUxHVMy6w4PK/zDXOmLfa1RaNtNjJArB9Nybn1EGDZQ04BLo5jntEGX6xqs1qi
 /kMRtrQhlbckrgzDm
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,


On Tue, 16 Jun 2020, Jeff King wrote:

> On Wed, Jun 10, 2020 at 08:16:38PM -0400, Eric Sunshine wrote:
>
> > > +/*
> > > + * Retrieves the name of the default branch. If `short_name` is non=
-zero, the
> > > + * branch name will be prefixed with "refs/heads/".
> > > + */
> > > +char *git_default_branch_name(int short_name);
> >
> > Overall, the internal logic regarding duplicating/freeing strings
> > would probably be easier to grok if there were two separate functions:
> >
> >     char *git_default_branch_name(void);
> >     char *git_default_ref_name(void);
> >
> > but that's subjective.
>
> Having seen one of the callers, might it be worth avoiding handing off
> ownership of the string entirely?

For `git_default_branch_name()`: yes. For `repo_default_branch_name()`,
not really, as that is potentially repository-specific.

(Side note: while I cannot really think of a use case where you would want
to set `init.defaultBranch` in a repository-local config, there _might_ be
use cases for that out there, and it _is_ how our config machinery works.)

> I.e., this comes from a string that's already owned for the lifetime of
> the process (either the environment, or a string stored by the config
> machinery). Could we just pass that back (or if we want to be more
> careful about getenv() lifetimes, we can copy it into a static owned by
> this function)?
>
> Then all of the callers can stop dealing with the extra free(), and you
> can do:
>
>   const char *git_default_branch_name(void)
>   {
> 	return skip_prefix("refs/heads/", git_default_ref_name());
>   }

For ease of use, I decided to only ever return the branch name (but check
the full ref).

Those callers that actually need the full ref usually also need the branch
name, and it is easy enough to call `xstrfmt("refs/heads/%s", ...)`.

It might make the code a bit less efficient (but who cares, it's not like
we're setting up a gazillion repositories per second all the time), but
quite a bit easier to reason about.

Ciao,
Dscho
