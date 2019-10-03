Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_DBL_ABUSE_PHISH shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A621F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 20:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbfJCUyM (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 16:54:12 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42159 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfJCUyM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 16:54:12 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 29ED62004E;
        Thu,  3 Oct 2019 20:54:09 +0000 (UTC)
Date:   Fri, 4 Oct 2019 02:24:07 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] git-gui: support for diff3 conflict style
Message-ID: <20191003205407.uaguw7qyabfy3aym@yadavpratyush.com>
References: <97013a71289857767100d6a4adcb39ca99b2b21b.1569443729.git.bert.wesarg@googlemail.com>
 <f1477ba53a03484a0440202065a5293c8795d3b7.1569443729.git.bert.wesarg@googlemail.com>
 <20190929150406.s57pmb3dggfbcqhr@yadavpratyush.com>
 <CAKPyHN3nOL6qy4RhwwHrh2m3EJuJ1-rt-8+0+=z2oJi96Nigpw@mail.gmail.com>
 <dc210bf0-eef3-ed58-f596-0999fd9d9a98@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc210bf0-eef3-ed58-f596-0999fd9d9a98@iee.email>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/10/19 09:02PM, Philip Oakley wrote:
> On 30/09/2019 13:17, Bert Wesarg wrote:
> > Pratyush,
> > 
> > On Sun, Sep 29, 2019 at 5:04 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > > Hi Philip, Bert,
> > > 
> > > Is there any way I can test this change? Philip, I ran the rebase you
> > > mention in the GitHub issue [0], and I get that '9c8cba6862abe5ac821' is
> > > an unknown revision.
> > > 
> > > Is there any quick way I can reproduce this (maybe on a sample repo)?
> > The easiest way to produce a merge conflict, is to change the same
> > line differently in two branches and try to merge them. I added a
> > fast-import file to demonstrate this for you.
> > 
> > $ git init foo
> > $ cd foo
> > $ git fast-import <../conflict-merge.fi
> > $ git reset --hard master
> > $ git merge branch
> > 
> > this gets you into the conflict, probably the usual style. Which looks
> > in liek this on the terminal:
> > 
> > @@@ -2,7 -2,7 +2,11 @@@ Lorem ipsum dolor sit amet, consectetu
> >    Sed feugiat nisl eget efficitur ultrices.
> >    Nunc cursus metus rutrum, mollis lorem vitae, hendrerit mi.
> >    Aenean vestibulum ante ac libero venenatis, non hendrerit orci pharetra.
> > ++<<<<<<< HEAD
> >   +Proin bibendum purus ut est tristique, non pharetra dui consectetur.
> > ++=======
> > + Proin placerat leo malesuada lacinia lobortis.
> > ++>>>>>>> branch
> >    Pellentesque aliquam libero et nisi scelerisque commodo.
> >    Quisque id velit sed magna molestie porttitor.
> >    Vivamus sed urna in risus molestie ultricies.
> > 
> > and this in git gui: https://kgab.selfhost.eu/s/gHHaQqowGp7mXEb
> 
> The snapshot of the Gui looks just the thing! (I've been away).
> 
> I'm sure this would solve my immediate issue.
> 
> My only remaining bikeshed question it prompted was to check which parts
> would be committed as part of committing the whole "hunk". But haven't had
> time to look at all!

I'm not sure what you mean by "committing the whole hunk". In a merge 
conflict state, you don't get the usual "Stage hunk" and "Stage lines" 
options, but instead get 3 options:

  Use Remote Version
  Use Local Version
  Revert To Base

You can use these to choose how you want to resolve the conflict.

These 3 options seem to work fine on my quick testing.

-- 
Regards,
Pratyush Yadav
