Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70085C2D0E4
	for <git@archiver.kernel.org>; Sun, 15 Nov 2020 03:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3477E22384
	for <git@archiver.kernel.org>; Sun, 15 Nov 2020 03:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgKODrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 22:47:11 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46261 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726433AbgKODrL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 22:47:11 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AF3knv4004101
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Nov 2020 22:46:50 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 214B1420107; Sat, 14 Nov 2020 22:46:49 -0500 (EST)
Date:   Sat, 14 Nov 2020 22:46:49 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Lukasz Niemier <Lukasz.Niemier@kobil.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo
 fiasco
Message-ID: <20201115034649.GC3985404@mit.edu>
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
 <20201113010107.GL6252@camp.crustytoothpaste.net>
 <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
 <20201113051408.GA3985404@mit.edu>
 <CAMP44s3AeESm7VBKbar0ir_Py35g99ZW6bNX_=AK4N=OFkcrdA@mail.gmail.com>
 <20201113145802.GB3985404@mit.edu>
 <CBC2DBAA-A409-49CD-B932-AC82D3C20D55@kobil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CBC2DBAA-A409-49CD-B932-AC82D3C20D55@kobil.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 14, 2020 at 02:19:59PM +0000, Lukasz Niemier wrote:
> > OK, fine.  That wasn't clear in your earlier messages.  So this is
> > *not* like 2008, where we are breaking workflows or finger macros of
> > *existing* git users.
> > 
> > Instead, we might be causing a certain amount of confusion with
> > respect to *new* users, especially if some portion of them are using
> > an older version of git, where the default initial branch name is
> > "master", or a newer version of git, where the default initial branch
> > name is "main".
> 
> I am pretty much **existing** Git user where I am maintaining few repos
> yet I am constantly creating new ones for another projects of mine. Such
> abrupt change in the default branch name, without any warning, would be
> very confusing for me. Not every user is working on a single Git repo
> for their whole life.

So we need to make sure existing users know that they can add:

[init]
    defaultBranch = master

to their ~/.gitconfig if they want the legacy behavior.  This could be
done by, in addition to mentioning it in the release notes, or by
adding a comment printed out when "git init" is run and there is not
init.defaultBranch defined in ~/.gitconfig.

We do something similar if merge.ff is not in ~/.gitconfig, and people
run "git merge" without --no-ff or --ff-only specified on the command
line.   So there is precedence for this sort of thing.

This *really* is not hard; which is why I am starting to suspect
people are really kvetching because their objections are really more
about the woke/anti-woke aspect of the "master" -> "main" migration
--- and they are using *think* the children^H^H^H^H^H^H^H users as a
rhetorical device.

						- Ted
