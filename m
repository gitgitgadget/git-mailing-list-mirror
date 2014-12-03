From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Problems cloning existing (probably old) svn repo
Date: Wed, 3 Dec 2014 22:15:32 +0000
Message-ID: <20141203221532.GA30452@dcvr.yhbt.net>
References: <CADq_+R2t+ZprZj83TKJaWDpTtF+LwSZPTPc8vOYuDz9gkLDS-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Cody Goodman <codygman.consulting@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 23:15:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwICx-0004m9-SV
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 23:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbaLCWPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 17:15:36 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50617 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752163AbaLCWPf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 17:15:35 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 735FA1F7D1;
	Wed,  3 Dec 2014 22:15:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CADq_+R2t+ZprZj83TKJaWDpTtF+LwSZPTPc8vOYuDz9gkLDS-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260703>

Cody Goodman <codygman.consulting@gmail.com> wrote:
> I recently got this error when trying to git svn clone an existing repo:
> 
> Couldn't open a repository: Unable to connect to a repository at URL
> 'file:///home/cody/work/SmartPay': Unable to open an ra_local session
> to URL: Unable to open repository 'file:///home/cody/work/SmartPay' at
> /usr/share/perl5/Git/SVN.pm line

What happens when you try using the plain SVN client?

	svn co file:///home/cody/work/SmartPay foo

> Then I created my own new svn repo to ensure my install of svn-git was working:
> 
> cody@cody-XPS-L521X:~/svn-repos$ svnadmin create testrepo
> cody@cody-XPS-L521X:~/svn-repos$ svnserve -d -r /home/cody/svn-repos
> cody@cody-XPS-L521X:~/svn-repos$ cd /tmp
> cody@cody-XPS-L521X:/tmp$ git svn clone svn://localhost/testrepo
> Initialized empty Git repository in /tmp/testrepo/.git/
> 
> So I've verified my install is working and I understand how to clone a
> local repo.
> 
> What svn repo versions is git-svn compatible with? If the svnadmin
> version used to create the existing repo I want to clone was very old
> is that what is giving me the error? Is there a workaround?

git-svn uses the SVN Perl bindings which are wrappers around libsvn,
the same library the regular "svn" command uses.  So if it works
with plain svn, it should work with git-svn.

> How should I proceed?

I'd make sure the plain SVN-only tools work on your repo, first.
Perhaps try "svnadmin dump" and "svnadmin load", too.
