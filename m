From: "Russ Dill" <russ.dill@gmail.com>
Subject: Re: git-svn+cygwin failed fetch
Date: Thu, 12 Jul 2007 10:49:22 -0700
Message-ID: <f9d2a5e10707121049o758109c0l4ebeb08250093ba0@mail.gmail.com>
References: <f9d2a5e10707101106w305e28acy55f465e558485298@mail.gmail.com>
	 <20070711090600.GB29676@muzzle>
	 <f9d2a5e10707110254j46d1123fuade955f17da0a8c5@mail.gmail.com>
	 <20070712054800.GC29676@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 19:49:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I92nF-0004UH-Gz
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 19:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119AbXGLRt0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 13:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbXGLRt0
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 13:49:26 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:11677 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbXGLRtY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 13:49:24 -0400
Received: by mu-out-0910.google.com with SMTP id i10so322464mue
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 10:49:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I65GbpXiOVHLiavUB3Mazwlb3vNQ6fX30cb/OkPP/5YHouex3nzarTFGOK48P9b8f0ZU3BQG5K1mRtXY9c0umXbpNS5KbEGWfvpD2EaxWSZi3U47qIrYfGsvzD+iuJcyqkRjUccYQkORpMJyikdgQrUi6VCaVnYfo+96ApLC9BU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ot+qyAeBmnoFluRo6ytoBJbzoRptvU1WkCjytApbPepq58An7c3J27aclMu0bPSYelhfZdGchA9ITf2H/YqtSV+Ug3ysPzohG8QnSx26S3PVdTAyocbUHfeMsscUHLAooXRwKj8/U6Epl/UZdUjV+GfZuUfg7esRervb4VqKbuM=
Received: by 10.82.108.9 with SMTP id g9mr874394buc.1184262563011;
        Thu, 12 Jul 2007 10:49:23 -0700 (PDT)
Received: by 10.82.149.11 with HTTP; Thu, 12 Jul 2007 10:49:22 -0700 (PDT)
In-Reply-To: <20070712054800.GC29676@muzzle>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52308>

On 7/11/07, Eric Wong <normalperson@yhbt.net> wrote:
> Russ Dill <russ.dill@gmail.com> wrote:
> > On 7/11/07, Eric Wong <normalperson@yhbt.net> wrote:
> > >Russ Dill <russ.dill@gmail.com> wrote:
> > >> [...]/src $ mkdir foo
> > >> [...]/src $ cd foo
> > >> [...]/src/foo $ git-svn init -t tags -b branches -T trunk
> > >> https://www.[...].com/svn/foo/bar/bla
> > >> Initialized empty Git repository in .git/
> > >> Using higher level of URL: https://www.[...].com/svn/foo/bar/bla =>
> > >> https://www.[...].com/svn/foo
> > >>
> > >> [...]/src/foo $ git-svn fetch
> > >> config --get svn-remote.svn.url: command returned error: 1
> > >>
> > >> [...]/src/foo $ git config --get svn-remote.svn.url
> > >> https://www.[...].com/svn/foo
> > >
> > >Sorry, I can't help here other than recommending a real UNIX with
> > >fork + pipe + exec and all that fun stuff.
> > >
> > >git-svn relies heavily[1] on both input and output pipes of the
> > >safer-but-made-for-UNIX fork + pipe + exec(@list) variety, so I suspect
> > >this is just the tip of the iceberg for Windows incompatibilies with
> > >git-svn...
> >
> > Its actually reading and writing quite a bit of stuff from the config
> > file, so why this one simple command would fail eludes me. Especially
> > since it wrote it there in the first place. If I comment out the
> > command_oneline and hardcode the value I know it should return,
> > git-fetch runs. Its actually been running for several hours now.
>
> Wow.  That's a pleasant surprise that anything in git-svn works at all
> on cygwin.  I was almost certain git-svn on Windows was a hopeless cause
> from other chatter I had heard on the mailing list.
>
> command_oneline() is used everywhere in that code, so I'm at a total loss
> as to why it would fail in one place.  Can you put a the following lines
> right before where it was failing?
>
>         print "GIT_CONFIG: $ENV{GIT_CONFIG} | GIT_DIR: $ENV{GIT_DIR}\n";
>         system('cat', "$ENV{GIT_DIR}/config");
>
> And tell me what it outputs?


Use of uninitialized value in concatenation (.) or string at
/usr/bin/git-svn line 1189.
GIT_CONFIG:  | GIT_DIR: .git
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[svn-remote "svn"]
        url = https://www.[...].com/svn/foo
        fetch = bar/bla/trunk:refs/remotes/trunk
        branches = bar/bla/branches/*:refs/remotes/*
        tags = bar/bla/tags/*:refs/remotes/tags/*
[gui]
        geometry = 864x678+162+162 104 204


If I export GIT_CONFIG, then the problem goes away. Much better work
around then hardcoding svn-remote.svn.url

The git-svn fetch died overnight due to an http error. Its restarted
now. There are dozens of branches and tags in the repo, and each one
seems to take about a half hour to and hour to fully fetch. It takes a
similar amount of time to checkout trunk with tortise SVN. The repo is
local, but I don't have direct access to it.
