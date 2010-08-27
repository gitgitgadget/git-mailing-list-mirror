From: Dave Olszewski <cxreg@pobox.com>
Subject: Re: git pull --rebase differs in behavior from git fetch +
 git rebase
Date: Fri, 27 Aug 2010 01:27:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008270124450.20874@narbuckle.genericorp.net>
References: <4C772A01.5030207@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 10:42:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OouVa-00041C-JG
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 10:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866Ab0H0Ily (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 04:41:54 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:51981 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752733Ab0H0Ilw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 04:41:52 -0400
X-Greylist: delayed 850 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Aug 2010 04:41:52 EDT
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id o7R8RfA6004058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 27 Aug 2010 03:27:41 -0500
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <4C772A01.5030207@workspacewhiz.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154590>

On Thu, 26 Aug 2010, Joshua Jensen wrote:

> I have a case where 'git pull --rebase' does not do the Right Thing 
> (according to me).
>
> If I run 'git rebase origin/master', that rebase does the right thing, 
> perfectly reapplying my *single* commit on top of the upstream.
>
> 'git pull --rebase' ends up reapplying a bunch of much earlier commits and 
> ends up with a conflict.
>
> The documentation for git pull --rebase states: "Instead of a merge, perform 
> a rebase after fetching. If there is a remote ref for the upstream branch, 
> and this branch was rebased since last fetched, the rebase uses that 
> information to avoid rebasing non-local changes."  I do not understand
>
> I'm studying the git-pull script right now, but I have to admit this is 
> beyond me.  I'm sure if I stare hard enough, I'll get it.
>
> I mistakenly have assumed 'git pull' = 'git fetch; git merge' and that 'git 
> pull --rebase' = 'git fetch; git rebase'.  Does anyone want to clarify what 
> is really going on?  Unfortunately, I can't publish the repository in 
> question.

Are you by any chance running a git with commit cf65426de?  If not, give
it a try and see if it corrects your issue.

The main difference between "git pull --rebase" and "git fetch && git
rebase @{u}" is that "git pull --rebase" will attempt to use the reflog
to find a suitable "upstream" candidate instead of assuming your
tracking branch is the upstream itself.  This is intended to help
recover from upstream rebases, but has adverse effects sometimes, which
commit cf65426de should help with.

     Dave
