Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27186C63777
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3FE620717
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgKWUUJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:20:09 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41590 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729592AbgKWUUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 15:20:09 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0ANKK3qR019996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 15:20:03 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 26A26420136; Mon, 23 Nov 2020 15:20:03 -0500 (EST)
Date:   Mon, 23 Nov 2020 15:20:03 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        =?iso-8859-1?B?Vu10?= Ondruch <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Pick the right default and stop warn on `git pull`
Message-ID: <20201123202003.GB132317@mit.edu>
References: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
 <CAMMLpeRLsE=zNDjCRKmEMFxJBYcnTOdDGxEL9cZuVhuDMF=sLg@mail.gmail.com>
 <20201123191355.GA132317@mit.edu>
 <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 01:40:38PM -0600, Felipe Contreras wrote:
> On Mon, Nov 23, 2020 at 1:17 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> 
> > If your repository is effectively a leaf repo, then rebasing may be
> > harmless, although there are still who don't like rebasing because it
> > invalidates your previous testing.  My personal preference is to do a
> > git fetch, followed by a git merge --ff-only, and if that errors out,
> > then I know I need to take a bit more care before deciding what to do
> > next.
> 
> Which is why I suggested to make fast-forward-only the default:
> 
> https://lore.kernel.org/git/1398988808-29678-1-git-send-email-felipe.contreras@gmail.com/
> 
> In what case would that default not be what most people want?

Well, it *was* the default, previously, IIRC.  The problem is that for
"simple" use cases, using rebases for git-pull is "simpler".  Well,
it's simpler until it does something super-surprising when the project
becomes more complex, but if the goal is to have a more gentle
learning curve for newbies, especially for small projects --- which
are the vast majority of projectds, on, say github and sourceforge ---
the case can be made.

So intead of having a huge discussion which is going to be very hard
to come to converge (much like the "main" vs "master" question),
requiring people to set their own global default or per-repo default
is a pretty good compromise.

						- Ted
