From: Ron Garret <ron1@flownet.com>
Subject: Re: GIT_WORK_TREE environment variable not working
Date: Sun, 31 Jan 2010 23:09:25 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-EF4205.23092531012010@news.gmane.org>
References: <ron1-8E7697.17334731012010@news.gmane.org> <20100201051942.GA7761@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 01 08:12:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbqSe-0006d2-EE
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 08:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab0BAHJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 02:09:50 -0500
Received: from lo.gmane.org ([80.91.229.12]:40762 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754475Ab0BAHJt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 02:09:49 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NbqPs-0005Ny-8y
	for git@vger.kernel.org; Mon, 01 Feb 2010 08:09:48 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 08:09:48 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 08:09:48 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138584>

In article <20100201051942.GA7761@coredump.intra.peff.net>,
 Jeff King <peff@peff.net> wrote:

> On Sun, Jan 31, 2010 at 05:33:47PM -0800, Ron Garret wrote:
> 
> > What am I doing wrong here?
> > 
> > [ron@mickey:~/devel/gittest]$ pwd
> > /Users/ron/devel/gittest
> > [ron@mickey:~/devel/gittest]$ git status
> > # On branch master
> > # Untracked files:
> > #   (use "git add <file>..." to include in what will be committed)
> > #
> > #  git/
> > nothing added to commit but untracked files present (use "git add" to 
> > track)
> > [ron@mickey:~/devel/gittest]$ cd
> > [ron@mickey:~]$ export GIT_WORK_TREE=/Users/ron/devel/gittest
> > [ron@mickey:~]$ git status
> > fatal: Not a git repository (or any of the parent directories): .git
> > [ron@mickey:~]$ git status --work-tree=/Users/ron/devel/gittest
> > fatal: Not a git repository (or any of the parent directories): .git
> > [ron@mickey:~]$
> 
> You haven't told git where to find the repository itself. GIT_WORK_TREE
> is about saying "here are my work tree files", but it is explicitly not
> about "here is where my .git directory is". That lets you keep the two
> in totally separate locations. E.g., you could do something like
> tracking /etc, but keep your .git directory in /var.
> 
> For your case above, you would want to also
> 
>   export GIT_DIR=/Users/ron/devel/gittest/.git

Ah.  Thanks!

> though since you have a fully formed repository, I don't think there is
> really any advantage over just doing:
> 
>   cd /Users/ron/devel/gittest && git $whatever
> 
> though perhaps that is because this is not a real use case, but rather
> just you trying to figure out the feature. :)

It's a real use case.  The situation is that I'm using git as a back end 
for an IDE, so I can't rely on the cwd.

rg
