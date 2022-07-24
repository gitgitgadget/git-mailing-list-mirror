Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE87C43334
	for <git@archiver.kernel.org>; Sun, 24 Jul 2022 08:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiGXIyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jul 2022 04:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiGXIyX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jul 2022 04:54:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EE81409C
        for <git@vger.kernel.org>; Sun, 24 Jul 2022 01:54:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 831F05D0FA;
        Sun, 24 Jul 2022 08:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658652861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hfC/U2PL7/jgDLpljw7WIRBHBhx/4jb8MKTrLVsPx48=;
        b=TyUB4KET8hdQX7wykeURFh637xI7BVbyiFFgSf/hTAobvu3cLKjMHashb5uKrT9PChpB80
        AC4QZ+HAwlysbgZ2iRPwjJnAu1qzw9c/R2oXAaX9R7eTksFy+r4XwcPEAqb7Pri1t00FiV
        umDbX8wzEU6duOrmL6S8fLa+fqMDlNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658652861;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hfC/U2PL7/jgDLpljw7WIRBHBhx/4jb8MKTrLVsPx48=;
        b=RCZlo21/ehgHf952cqTGOBUcA4nYBjlyNf3EZOC+RopVbe4s3wRinNu5a1Yw7372r6YcG5
        AF4A+dnF7zrY6RCA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8BC8E2C16F;
        Sun, 24 Jul 2022 08:54:20 +0000 (UTC)
Date:   Sun, 24 Jul 2022 10:54:19 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Phillip Susi <phill@thesusis.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Stephen Finucane <stephen@that.guru>,
        Git Users <git@vger.kernel.org>
Subject: Re: Feature request: provide a persistent IDs on a commit
Message-ID: <20220724085419.GG17705@kitsune.suse.cz>
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com>
 <87a692e8vj.fsf@vps.thesusis.net>
 <CAE1pOi1pS76iXU8j=A54wPGHC7qofxrPDAO4uyy0d6yMxeQwvw@mail.gmail.com>
 <6426b5c3-0a09-f641-9876-3534b0abd96d@iee.email>
 <20220722203642.GD17705@kitsune.suse.cz>
 <CA+P7+xr+k35RXoGv-O96fsfOJ+sg65HrVvt-3JKYAzerA0TJRw@mail.gmail.com>
 <20220723070055.GE17705@kitsune.suse.cz>
 <CABPp-BEYQOtr6EZmi4emKRKNVXS3071Ud90jiLycdGXGG+YqgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BEYQOtr6EZmi4emKRKNVXS3071Ud90jiLycdGXGG+YqgQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 23, 2022 at 10:23:09PM -0700, Elijah Newren wrote:
> On Sat, Jul 23, 2022 at 12:44 AM Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > On Fri, Jul 22, 2022 at 03:46:22PM -0700, Jacob Keller wrote:
> > > On Fri, Jul 22, 2022 at 1:42 PM Michal Suchánek <msuchanek@suse.de> wrote:
> > > >
> > > > On Fri, Jul 22, 2022 at 09:08:56PM +0100, Philip Oakley wrote:
> [...]
> > > > > Part of the rename problem is that there can be many different routes to
> > > > > the same result, and often the route used isn't the one 'specified' by
> > > > > those who wish a complicated rename process to have happened 'their
> > > > > way', plus people forget to record what they actually did. Attempting to
> > > > > capture what happened still results major gaps in the record.
> > > >
> > > > Doesn't git have rebase?
> > > >
> > > > It is not required that the rename is captured perfectly every time so
> > > > long as it can be amended later.
> > > >
> > >
> > > Rebase is typically reserved only to modify commits which are not yet
> > > "permanent". Once a commit starts being referenced by many others it
> > > becomes more and more difficult to rebase it. Any rebase effectively
> > > creates a new commit.
> > >
> > > There are multiple threads discussing renames and handling them in git
> > > in the past which are worth re-reading, including at least
> > >
> > > https://public-inbox.org/git/Pine.LNX.4.58.0504141102430.7211@ppc970.osdl.org/
> > >
> > > A fuller analysis here too:
> > > https://public-inbox.org/git/Pine.LNX.4.64.0510221251330.10477@g5.osdl.org/
> > >
> > > As mentioned above in this thread, depending on what context you are
> > > using, a change to a commit could be many to many: i.e. a commit which
> > > splits into 2, or 3 commits merging into one, or 3 commits splitting
> > > apart and then becoming 2 commits. When that happens, what "change id"
> > > do you use for each commit?
> >
> > Same as commit message and any trailers you might have - they are
> > preserved, concatenated
> 
> Exactly how are they concatenated?  Is that a user operation, or
> something a Git command does automatically?  Which commands and which
> circumstances?  If users do it, what's the UI for them to discover
> what the fields are, for them to discover whether such a thing might
> be needed or beneficial, and the UI for them to change these fields?
> This sounds like a massive UX/UI issue that I don't have a clue how to
> tackle (assuming I wanted to).

Currently when you squash commits you get both commit messages
concatenated, including any trailers.

You are free to adjust as you see fit.

> 
> > and can be regenerated.
> 
> "can be".  But generally won't be even when it should be, right?

"when it should" is not something that can be programmatically
derrmined, so it's up to the user, and sure, there will be cases where
somebody thinks it "should" but it has not. Then they can complain, just
like with any other trailer we already have today.

> I think the "many-to-many issue" others have raised in this thread is
> an important, big, and thorny problem.  I think it has the potential
> to be a minefield of UX and a steady stream of bug reports.  And
> seeing proponents of Change-Id just dismissing the issue makes me all
> the more suspicious of the proposal in the first place.

And how do you get this many to many situation in the first place?

You reset to a base before your changes and create completely new series
with completely new messages and everything?

Then of course you get completely new trailers as well unless you
somehow fish out some metadata from the old commits and manually apply
them.

I don't see any functionality in git that does many to many commits
transform in one step. It's always just split/merge.

Thanks

Michal
