Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD61AC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 11:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A589920691
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 11:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgFKLwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:52:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:46126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgFKLwT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 07:52:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2BF51ADD7;
        Thu, 11 Jun 2020 11:52:21 +0000 (UTC)
Date:   Thu, 11 Jun 2020 13:52:15 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200611115215.GQ21462@kitsune.suse.cz>
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 11:30:31PM +0200, Johannes Schindelin wrote:
> Hi all,
> 
> On Tue, 5 May 2020, brian m. carlson wrote:
> 
> > On 2020-05-04 at 17:20:33, Simon Pieters wrote:
...
> > Clearly we have compatibility concerns to consider though, so if we
> > decided to make a change, we'd probably want to make it in a 3.0, which
> > as far as I'm aware hasn't been discussed yet.  I also wondered what
> > such a change would involve, so I did some research.
> >
> > It appears that if we made the obvious one-line change to
> > builtin/init-db.c, we'd have 304 tests that fail, which is about a third
> > of our test suite.  I haven't examined any of these tests, so I don't
> > know what would be involved in changing them.  I imagine a project to do
> > so would involve setting an environment variable in the test setup code
> > (e.g., MAIN_BRANCH) and replacing instances of "master" with that until
> > everything works with an alternate value of that variable.  Picking the
> > new name itself could be deferred until later, and we could choose from
> > some popular alternatives.
> 
> As mentioned elsewhere in this thread, Don (Cc:ed) and I started working
> on this, and I just submitted it:
> https://lore.kernel.org/git/pull.656.git.1591823971.gitgitgadget@gmail.com/
> That patch series adds a config variable allowing to override the default
> name of the default branch.
> 
> I hope to see this finalized and sent off to the Git mailing list
> relatively soon: being strictly opt-in, it should be really
> uncontroversial and obviously helpful.

Indeed, the flexibility to choose the name of the default branch can be
helpful for projects with specific naming, especially non-english
speaking projects.

To that end I would suggest adding -b argument to git init to be able to
choose the default branch name per project. This should select the
initial branch name and also write the it as the default branch name in
the repo configuration (if git continues to treat the default branch
specially).

This can be used in documentation to use the new name immediately
without breaking existing workflows that rely on the 'master' branch.

The default branch name will not be preserved across clones but today
projects that choose different default branch name don't get the default
branch special treatment in anyway clones so I don't see that as a
regression.

Thanks

Michal
