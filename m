Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8002BC433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 18:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 635D820897
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 18:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgFQSGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:06:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:33320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbgFQSGV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 14:06:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2FB08AAC3;
        Wed, 17 Jun 2020 18:06:23 +0000 (UTC)
Date:   Wed, 17 Jun 2020 20:06:17 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        James Ramsay <james@jramsay.com.au>,
        Bryan Turner <bturner@atlassian.com>
Subject: Re: Consensus on a new default branch name
Message-ID: <20200617180617.GN21462@kitsune.suse.cz>
References: <20200615205722.GG71506@syl.local>
 <20200615212154.GA79696@syl.local>
 <20200616143107.GL666057@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616143107.GL666057@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 10:31:07AM -0400, Jeff King wrote:
> On Mon, Jun 15, 2020 at 03:21:54PM -0600, Taylor Blau wrote:
> 
> > > Concurrently with this, GitHub, GitLab [3], and Bitbucket are working together
> > > in order to make a similar change across our respective products. Because of
> > > this, we are met with a bit of a challenge: we would like to make these changes
> > > before the next version(s) (and so need to settle on a new default branch name),
> > > but we also want to avoid a situation where the community is fractured (eg.,
> > > GitHub uses 'main', Git uses 'default', etc).
> > >
> > > A related question is whether or not we plan to change the default value of
> > > 'core.defaultBranchName' at all (once Johannes' patches land, of course). That
> > > seems to be the intent in [4], but forming consensus around this would be good,
> > > too.
> 
> My biggest concern here was trying to understand what could break.
> Having read the patches from Johannes and thought about it a lot, I have
> a pretty good handle on where Git itself cares about the name. And I
> feel pretty confident that we can make the change in a way that won't
> cause problems there (and in fact, I think some of the code will be
> made more robust by relying on HEAD more appropriately).
> 
> There's a more open question of what _else_ will break in the ecosystem.
> I.e., what other tools and scripts did people write "master" in that
> we'll never even see, and they will eventually need to update. And there
> I think we need to be respectful of our users and their time. Obviously
> stopping at configurability is the least risky thing there. But it's
> clear that a lot of projects are interested in changing their names, so
> tools will have to deal with a world where various repos will have
> different HEAD names.
> 
> By moving the default, we do push some repos into a name change that
> might otherwise have remained oblivious (e.g., if your org has a custom
> script that nobody else will see, and nobody in your org has an interest
> in changing their repo HEADs, you might never need to update your
> scripts). We can help with that by:
> 
>   - clearly communicating the timetable for the change, and giving lots
>     of opportunity for people to consider whether their scripts might
>     need updating (again, I think in many cases these updates actually
>     make the tools more robust)
> 
>   - giving an escape hatch to restore the old behavior, which Johannes'
>     patches certainly do
> 
> Both of which I think everybody is on board with. I won't claim that
> changing the default won't cause _any_ disruption, but it seems to me to
> be on par with other changes we've made (and is being handled similarly
> carefully). So I think I'm in favor.
> 
> > > My interpretation thus far is that 'main' is the planned replacement for
> > > 'master'. Consensus seems to have formed around this name [5], but if that's
> > > incorrect--or there are yet-unvoiced opinions that you would like to share--now
> > > is the time to discuss further.
> 
> My opinion is that "main" is the best suggestion I've heard.

See also
https://lore.kernel.org/git/20200616210701.22924-1-zeevriend@gmail.com/
