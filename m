Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4532018E
	for <e@80x24.org>; Tue, 23 Aug 2016 03:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755878AbcHWDHk (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 23:07:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44844 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755181AbcHWDHj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 23:07:39 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 525401F859;
        Tue, 23 Aug 2016 03:07:21 +0000 (UTC)
Date:   Tue, 23 Aug 2016 03:07:21 +0000
From:   Eric Wong <e@80x24.org>
To:     Lucian Smith <lucianoelsmitho@gmail.com>
Cc:     git@vger.kernel.org, Alfred Perlstein <alfred@freebsd.org>
Subject: Re: git-svn bridge and line endings
Message-ID: <20160823030721.GA32181@starla>
References: <CAHLmBr2CRzt58RB+_YmnXcyost-R5=Ff51tALf1xh0kGk+frDw@mail.gmail.com>
 <CAHLmBr1JHjjp66Er-2e6Yu+3zjrhT82Da-O8fj6_OoPtEPz8eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHLmBr1JHjjp66Er-2e6Yu+3zjrhT82Da-O8fj6_OoPtEPz8eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding Alfred to the Cc:, more below...

Lucian Smith <lucianoelsmitho@gmail.com> wrote:
> I'm attempting to use the git-svn bridge, and am having problems with
> line endings on Windows.
> 
> The setup is that we have a git repository on github, and I've checked
> out a branch on my Windows machine using Tortoise svn.  I make
> changes, commit them, and the branch is updated.  In general, this
> works fine.
> 
> If this was just SVN, I could set the 'eol-style' for files to
> 'native' to let it know to expect Windows/linux/mac line endings for
> particular files.  This seems to be handled in git by using the
> '.gitattributes' file instead.  Unfortunately, the git/svn bridge
> doesn't seem to be translate the information in the .gitattributes
> file to appropriate eol-style settings in SVN.  Checking out a file
> using SVN on Windows leaves me with a file without CRLF's, and if I
> check in a CRLF file, that's the way it goes into the repository.
> Differences in CRLF alone show up as 'real' differences that can be
> checked in, and, if this happens, this causes problems with other
> people's repositories.
> 
> Am I doing something wrong; is there another way to handle this; or
> can I file this as a bug report/feature request?
> 
> Thank you!
> 
> -Lucian Smith

Lucian: Which version of git are you using?

As of git v2.3.0 and thanks to Alfred, the "git svn propset"
command exists for setting new props via git; however it
only got documented recently in v2.9.1.

It also seems to support setting props via "svn-properties"
in the .gitattributes file based on reading the code;
but I'm not familiar with this area, so I defer to Alfred.

Alfred: "svn-properties" isn't documented anywhere, yet;
is this something that should/could be documented?

Thanks.

cf. commit 83c9433e679635f8fbf8961081ea3581c93ca778
    ("git-svn: support for git-svn propset")
    https://bogomips.org/git-svn.git/commit/?id=83c9433e6796

    commit 19a7f24b6f8aa89ea5899c928c2fa350f4b1521e
    ("git-svn: document the 'git svn propset' command")
    https://bogomips.org/git-svn.git/commit/?id=19a7f24b6f8a

    https://public-inbox.org/git/?q=s:%22git-svn+propset%22

Anyways I've never used SVN props much myself, so don't much
have experience in this area; nor do I have much experience
with git-side gitattributes.
