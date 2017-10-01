Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C938820A10
	for <e@80x24.org>; Sun,  1 Oct 2017 16:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbdJAQLy (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 12:11:54 -0400
Received: from ikke.info ([178.21.113.177]:48014 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751093AbdJAQLy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 12:11:54 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id D53504403C1; Sun,  1 Oct 2017 18:11:52 +0200 (CEST)
Date:   Sun, 1 Oct 2017 18:11:52 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Yubin Ruan <ablacktshirt@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: will git rebase has side effect
Message-ID: <20171001161152.GA1667@alpha.vpn.ikke.info>
References: <CAJYFCiNj22McSaKcCVMDVgah5cAqHYHja_b2jj6VAaAA=zSM1g@mail.gmail.com>
 <20171001134155.GA20406@alpha.vpn.ikke.info>
 <20171001141719.GB20406@alpha.vpn.ikke.info>
 <CAJYFCiNmDpNNdbRsN-F-mOtcOEVruawEKUtA9h3BAFZZWKStsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJYFCiNmDpNNdbRsN-F-mOtcOEVruawEKUtA9h3BAFZZWKStsQ@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 12:06:38AM +0800, Yubin Ruan wrote:
> 2017-10-01 22:17 GMT+08:00 Kevin Daudt <me@ikke.info>:
> > Forgot to cc the mailing list.
> >
> > On Sun, Oct 01, 2017 at 09:23:23PM +0800, Yubin Ruan wrote:
> >> Suppose that I have such a history of commit locally:
> >>
> >> A --> B --> C --> D
> >>
> >> If I then add a few more commits locally
> >>
> >> A --> B --> C --> D --> E --> F --> G
> >>
> >> And then I do a rebase and squash F and G into one single commit H.
> >> What side effect will this rebase have? How will this affect "git push
> >> origin master"?
> >>
> >> Yubin
> >
> > Hello Yubin,
> >
> > So the situation is this:
> >
> >             [origin/master]
> >                   |
> > A --> B --> C --> D --> E --> F --> G
> >                                     |
> >                                  [master]
> >
> > Then you squash (F' is the result of squashing F and G):
> >
> >             [origin/master]
> >                   |
> > A --> B --> C --> D --> E --> F'
> >                               |
> >                            [master]
> >
> > When you want to push now, it's just as if you just created just two
> > commits in the first place, and you can just push normally (assuming no
> > one else has pushed in the mean time.
> 
> Hmm..You mean, if I do a squash, it will only affects those commits
> that has been squashed, not any other commits, and their parent-child
> relations remain the same?
> 
> Yubin

Only the commits being squashed, and the commits after it (not
applicable in your case). But not commits that come before the squash.
Remember that in git, commits point at their parent(s), not the opposite
way. So if you change commits, only the children will have to change (to
point to the new hashes), but not their parents.
