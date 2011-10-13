From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 16:44:50 +0200
Message-ID: <20111013144450.GA2856@victor.terreactive.ch>
References: <loom.20111013T094053-111@post.gmane.org>
 <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>
 <20111013145924.2113c142@ashu.dyn.rarus.ru>
 <loom.20111013T130924-792@post.gmane.org>
 <loom.20111013T141239-151@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 16:45:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REMWv-0001gZ-4z
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 16:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884Ab1JMOo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 10:44:59 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:53326 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab1JMOo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 10:44:58 -0400
Mail-Followup-To: arQon <arqon@gmx.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <loom.20111013T141239-151@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183488>

On Thu, Oct 13, 2011 at 12:42:42PM +0000, arQon wrote:
> Simple testcase:
> 
> >git init
> Initialized empty Git repository in C:/git-test/.git/
> >notepad file1
> >notepad file2
> >git st
>  # On branch master
>  # Initial commit
>  # Untracked files:
>  #   (use "git add <file>..." to include in what will be committed)
>  #       file1.txt
>  #       file2.txt
>  nothing added to commit but untracked files present (use "git add" to track)
> 
> >git add .
> >git st
>  # On branch master
>  # Initial commit
>  # Changes to be committed:
>  #       new file:   file1.txt
>  #       new file:   file2.txt
> 
> >git commit -am "init"
>   2 files changed, 2 insertions(+), 0 deletions(-)
>   create mode 100644 file1.txt
>   create mode 100644 file2.txt
> 
> >git co -b foo
>  Switched to a new branch 'foo'
> >notepad file1
> (edit stuff)
> >git st
>  # On branch foo
>  # Changes not staged for commit:
>  #       modified:   file1.txt
> 
> >git co master
>  M       file1.txt
> 
> file1 now has the wrong data in it for "master" branch.

The most important thing a VCS should do is to keep history intact.
That happens when you check out in Git: No branches were changed, only
the working space. The second most important thing a VCS should do is
not destroy any of your uncommitted work unless you tell it to. That
also happens when you check out in Git. The third most important thing a
VCS should do is facilitate the developer's workflow. One common thing
to do is to work on some thing, for example refactoring. During this
process you might realize that one of the changes actually fixed a bug
in the software. To keep things in their right place, you could now
either
1. `checkout master` and commit the fix there, then shift back and
continue working, or
2. commit the refactorings, `checkout master`, and commit the fix there.
Either of these are easy to do with Git. There really is no reason why
the changes in the workspace should be considered as "part of" the
currently active branch, because they *are* not.

Cheers,
V

-- 
terreActive AG
Kasinostrasse 30
CH-5001 Aarau
Tel: +41 62 834 00 55
Fax: +41 62 823 93 56
www.terreactive.ch

Wir sichern Ihren Erfolg - seit 15 Jahren
