Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F4AD1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 20:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754450AbeBGUix (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 15:38:53 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:47577 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754281AbeBGUiw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 15:38:52 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:34540 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1ejWUV-0002cs-Hg; Wed, 07 Feb 2018 15:38:51 -0500
Date:   Wed, 7 Feb 2018 15:38:48 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Todd Zullinger <tmz@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: categorization, documentation and packaging of "git core"
 commands
In-Reply-To: <20180207172902.GL1427@zaya.teonanacatl.net>
Message-ID: <alpine.LFD.2.21.1802071529080.14481@localhost.localdomain>
References: <alpine.LFD.2.21.1802070801470.19185@android-a172fe96dd584b41> <20180207172902.GL1427@zaya.teonanacatl.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 7 Feb 2018, Todd Zullinger wrote:

> Robert P. J. Day wrote:
> > first, here are the executables under /usr/libexec/git-core/ that
> > are unreferenced by that web page, but that should be fine as
> > almost all of them would be considered underlying helpers or
> > utilities (except for things like git-subtree, but we're still
> > unclear on its status, right?):
>
> I don't think there's anything unclear about git subtree's status.
> It's in contrib/ within the source, so it's not part of the core git
> suite.  Some distributions (Fedora being one of them) ship a
> git-subtree package to provide it for users who want it.
>
> > on the other hand (and this is not so much a git issue as a fedora
> > packaging issue), there are a number of command links at that web
> > page that are supplied by distinct RPM packages rather than by the
> > basic fedora git package, so one would need to install the
> > following packages to get some of those commands on fedora:
> >
> >   * gitk
> >   * git-cvs
> >   * git-svn
> >   * git-p4
> >   * git-email (provides git-send-email)
>
> These packages are in separate sub-packages in Fedora (and some
> other distributions) because they are no required by all users and
> they pull in dependencies which are not wanted on minimal installs.
> In Fedora, you can install git-all to get all the available git
> sub-packages.

  not to belabour this (and i'm sure it's *way* too late for that),
but fedora has the following packaging scheme.  first, there's a bunch
of stuff in "git-core", which has no dependencies on any other
git-related packages.

  then there's "git", which has the following property:

  $ rpm -qR git
  /bin/sh
  /usr/bin/perl
  emacs-filesystem >= 25.3
  git-core = 2.14.3-2.fc27
  git-core-doc = 2.14.3-2.fc27
  ... snip ...

  $ rpm -ql git
  ... snip ...
  /usr/libexec/git-core/git-add--interactive
  /usr/libexec/git-core/git-am
  /usr/libexec/git-core/git-credential-libsecret
  /usr/libexec/git-core/git-credential-netrc
  /usr/libexec/git-core/git-difftool
  /usr/libexec/git-core/git-difftool--helper
  /usr/libexec/git-core/git-instaweb
  /usr/libexec/git-core/git-request-pull
  /usr/libexec/git-core/git-submodule
  /usr/libexec/git-core/git-submodule--helper
  ... snip ...
  /usr/share/man/man1/git-am.1.gz
  /usr/share/man/man1/git-difftool.1.gz
  /usr/share/man/man1/git-instaweb.1.gz
  /usr/share/man/man1/git-request-pull.1.gz
  /usr/share/man/man1/git-submodule.1.gz
  /usr/share/man/man1/gitweb.1.gz
  /usr/share/man/man5/gitweb.conf.5.gz
  $

so with fedora, "git" drags in "git-core" and a small number of
additional git utilities. all of this leads one to wonder -- is there
any comprehensible relationship between:

  1) commands that claim to be in the "git suite"
  2) commands that come from contrib/
  3) commands listed at
     https://www.kernel.org/pub/software/scm/git/docs/
  4) how different distros package all of the above

as i think we've noticed, it's not at all clear how git decides what
is and isn't part of the "official" git suite.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
