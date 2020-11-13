Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36EFC388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9315421D79
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgKMO6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 09:58:24 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45497 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726160AbgKMO6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 09:58:24 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0ADEw267022420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 09:58:03 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 800BF420107; Fri, 13 Nov 2020 09:58:02 -0500 (EST)
Date:   Fri, 13 Nov 2020 09:58:02 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo
 fiasco
Message-ID: <20201113145802.GB3985404@mit.edu>
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
 <20201113010107.GL6252@camp.crustytoothpaste.net>
 <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
 <20201113051408.GA3985404@mit.edu>
 <CAMP44s3AeESm7VBKbar0ir_Py35g99ZW6bNX_=AK4N=OFkcrdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMP44s3AeESm7VBKbar0ir_Py35g99ZW6bNX_=AK4N=OFkcrdA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 12:28:52AM -0600, Felipe Contreras wrote:
> On Thu, Nov 12, 2020 at 11:14 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> 
> > Is it changing the default branch name when creating a new repository?
> > (Which affects only people creating new repositories)
> 
> You may choose to downplay the experience of certain part of the
> user-base, because in your experience creating new repositories
> doesn't happen often, but that doesn't mean these users don't exist.

OK, fine.  That wasn't clear in your earlier messages.  So this is
*not* like 2008, where we are breaking workflows or finger macros of
*existing* git users.

Instead, we might be causing a certain amount of confusion with
respect to *new* users, especially if some portion of them are using
an older version of git, where the default initial branch name is
"master", or a newer version of git, where the default initial branch
name is "main".

It's important we be specific about the concern, as opposed to using
abstract notions of "backwards compatibility".  Because I'll note that
even if we were to release a git 3.0, it's not going to fix the
potential confusion where some students / new users trying to follow a
tutorial are using git 2.x, and some are using git 3.x.

We could delay making the change for years, but that isn't going to
guarantee that all of the various tutorials on the 'net will be
changed, and experience from long deprecation periods (exhibit 1:
Pythonx 2.x vs Python 3) is that people will drag there feet and put
off doing the work to migrate for years and years and years.

So I think it's worth making explicit exact what the nature of the
breakage is: specifically, some confusion for new users following
tutorials that haven't been updated, and to balance that off against
the costs of delaying the change for years and years and years.  And
that's because individual projects and individual git repositories are
making that change *already*.  So changing what the default "out of
the box" might be in some ways will make it worse for new users who
follow the some random git tutorial or traning on the web and then
then have to interact with some open source community which has
already changed their primary development branch to be "main".

If we know that's the concern, then we can improve the messaging and
documentation, and I appreciate that you have done some work along
those lines already.  So let's see how we can address the problem
constructively; maybe that means making the git default trailing edge
as opposed to helping to lead the change.   Maybe not.

   	      	      	      	  	    - Ted
