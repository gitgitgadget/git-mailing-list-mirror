Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F46C433EF
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 07:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiGWHBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 03:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiGWHBB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 03:01:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A6611153
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 00:01:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4F2F338831;
        Sat, 23 Jul 2022 07:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658559657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e83a7YT2q6r+1V66+GHDww6WLTesrcTRUklml1OkEUA=;
        b=VBgu/rAiX5Dy7W/3R5LpP7vM5P9s0Ok/kwh/fmvsVWAa8CE7scWI/CiOp7UsNmlKHUKJnX
        KnK7d4zFyzpHwHnfpo7Z84MuD2ykPCRDsEXy6vlwgXLdVJbN1houYRQ8XKeSjuPdcBx8mD
        zGcAk46mQF8LUFQ/nmm1jZpqM4So3fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658559657;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e83a7YT2q6r+1V66+GHDww6WLTesrcTRUklml1OkEUA=;
        b=wUFvo7duJP8JS71sKEYLHyEnK+pFKMoKzJdnK5PHdHtIu6gwpSUB6bXZwB1+8qa+d1BNNW
        s1rkR4rMwN749lDg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1FB392C16D;
        Sat, 23 Jul 2022 07:00:57 +0000 (UTC)
Date:   Sat, 23 Jul 2022 09:00:55 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Phillip Susi <phill@thesusis.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Stephen Finucane <stephen@that.guru>,
        Git Users <git@vger.kernel.org>
Subject: Re: Feature request: provide a persistent IDs on a commit
Message-ID: <20220723070055.GE17705@kitsune.suse.cz>
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com>
 <87a692e8vj.fsf@vps.thesusis.net>
 <CAE1pOi1pS76iXU8j=A54wPGHC7qofxrPDAO4uyy0d6yMxeQwvw@mail.gmail.com>
 <6426b5c3-0a09-f641-9876-3534b0abd96d@iee.email>
 <20220722203642.GD17705@kitsune.suse.cz>
 <CA+P7+xr+k35RXoGv-O96fsfOJ+sg65HrVvt-3JKYAzerA0TJRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+P7+xr+k35RXoGv-O96fsfOJ+sg65HrVvt-3JKYAzerA0TJRw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 03:46:22PM -0700, Jacob Keller wrote:
> On Fri, Jul 22, 2022 at 1:42 PM Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > On Fri, Jul 22, 2022 at 09:08:56PM +0100, Philip Oakley wrote:
> > > On 21/07/2022 19:58, Hilco Wijbenga wrote:
> > > > On Thu, Jul 21, 2022 at 9:39 AM Phillip Susi <phill@thesusis.net> wrote:
> > > >> Ęvar Arnfjörš Bjarmason <avarab@gmail.com> writes:
> > > >>
> > > >>> This has come up a bunch of times. I think that the thing git itself
> > > >>> should be doing is to lean into the same notion that we use for tracking
> > > >>> renames. I.e. we don't, we analyze history after-the-fact and spot the
> > > >>> renames for you.
> > > >> I've never been a big fan of that quality of git because it is
> > > >> inherently unreliable.
> > > > Indeed, which would be fine ... if there were a way to tell Git, "no
> > > > this is not a rename" or "hey, you missed this rename" but there
> > > > isn't.
> > > >
> > > > Reading previous messages, it seems like the
> > > > after-the-fact-rename-heuristic makes the Git code simpler. That is a
> > > > perfectly valid argument for not supporting "explicit" renames but I
> > > > have seen several messages from which I inferred that rename handling
> > > > was deemed a "solved problem". And _that_, at least in my experience,
> > > > is definitely not the case.
> > >
> > > Part of the rename problem is that there can be many different routes to
> > > the same result, and often the route used isn't the one 'specified' by
> > > those who wish a complicated rename process to have happened 'their
> > > way', plus people forget to record what they actually did. Attempting to
> > > capture what happened still results major gaps in the record.
> >
> > Doesn't git have rebase?
> >
> > It is not required that the rename is captured perfectly every time so
> > long as it can be amended later.
> >
> > Thanks
> >
> > Michal
> 
> Rebase is typically reserved only to modify commits which are not yet
> "permanent". Once a commit starts being referenced by many others it
> becomes more and more difficult to rebase it. Any rebase effectively
> creates a new commit.
> 
> There are multiple threads discussing renames and handling them in git
> in the past which are worth re-reading, including at least
> 
> https://public-inbox.org/git/Pine.LNX.4.58.0504141102430.7211@ppc970.osdl.org/
> 
> A fuller analysis here too:
> https://public-inbox.org/git/Pine.LNX.4.64.0510221251330.10477@g5.osdl.org/
> 
> As mentioned above in this thread, depending on what context you are
> using, a change to a commit could be many to many: i.e. a commit which
> splits into 2, or 3 commits merging into one, or 3 commits splitting
> apart and then becoming 2 commits. When that happens, what "change id"
> do you use for each commit?

Same as commit message and any trailers you might have - they are
preserved, concatenated, and can be regenerated.

Thanks

Michal
