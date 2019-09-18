Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5868E1F463
	for <e@80x24.org>; Wed, 18 Sep 2019 19:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfIRTW2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 15:22:28 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:53583 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfIRTW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 15:22:27 -0400
Received: from localhost (unknown [1.186.12.28])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id EE6FA100005;
        Wed, 18 Sep 2019 19:22:24 +0000 (UTC)
Date:   Thu, 19 Sep 2019 00:52:22 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: missing some patches from git?
Message-ID: <20190918192222.rqn3oqxfeu7bmnp5@yadavpratyush.com>
References: <CAGr--=KXqFbivuXHPNecb3dBR_hx8QqWoR4pBGXy7uOiT+ESbg@mail.gmail.com>
 <20190918092721.GA76617@archbookpro.localdomain>
 <20190918151404.rqjohdderwxfqtdm@yadavpratyush.com>
 <xmqqblvh5wbr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqblvh5wbr.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/09/19 10:49AM, Junio C Hamano wrote:
> Pratyush Yadav <me@yadavpratyush.com> writes:
> 
> > Assuming I have git.git cloned in ../git (relative to git-gui.git), I 
> > ran:
> >
> >   git pull -Xsubtree=git-gui ../git $branches
> >
> > instead of:
> >
> >   git merge $branches
> >
> > because git-gui's tree doesn't have those commits and branches yet, so 
> > we can't merge straight away. This seems to have worked, but I thought 
> > I'd mention it in case it would cause some subtle problems.
> 
> I am not sure what your $branches above are referring to, but if you

The $branches is from Denton's script (its in his email that I replied 
to) that lists all the branches merged into git/git-gui that are not in 
git-gui. So it should essentially be all the branches not in my tree 
that should be.

> run "git log" in the resulting git-gui repository and see any of the
> commits that are about git and not git-gui, then it is not a subtle
> but a grave problem.  The reason why git-gui and gitk are separate
> projects is because they do not want to contaminate their history
> with stuff that are not related to them (e.g. changes to "git
> fast-export").

No, I was only pulling in merges related to git-gui into my tree. I do 
not intend to pull in any other changes.
 
> Taking one of the commits Denton found as an example:
> 
> >> 	js/misc-git-gui-stuff: 76756d67061076c046973bff2089ad49f5dc2eb6
> 
> (by the way, this can also be found by running
> 
> 	git log --first-parent --min-parents=2 master -- git-gui

Yes, that is what I was doing. Denton's script just made the tedious 
task of finding all those out easier.

> in git itself; 02a5f25d956be187bc0 merged it in as its second
> parent.  The second parents of these merges you would find are
> candidates---you may already have some, and you may need to merge
> others to your tree; there may be some that are direct updates to
> git-gui/ part of my tree (which shouldn't have been done but
> mistakes happen).
>
> You should be able to merge this (and all other git-gui topics
> already in my tree Denton pointed out) to your 'master'.  If you
> then make a trial merge of the result back into my tree with "git
> merge -Xsubtree=git-gui", it should result in "already up to date",
> i.e. a noop merge.

Well, technically it won't be a noop merge because my master has some 
changes that haven't been pulled by you yet, but I get the point. 
Thanks. I'll test this out.

-- 
Regards,
Pratyush Yadav
