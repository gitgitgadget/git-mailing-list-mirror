From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: git-svn set-tree bug
Date: Mon, 11 Jun 2007 01:55:09 +0200
Message-ID: <003401c7abba$c7574300$0e67a8c0@Jocke>
References: <466C8B35.3020207@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'Eric Wong'" <normalperson@yhbt.net>,
	"'git'" <git@vger.kernel.org>
To: "'Steven Grimm'" <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 01:55:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxXFz-0008Ps-Tb
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 01:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760495AbXFJXz3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 19:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753675AbXFJXz3
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 19:55:29 -0400
Received: from mail.transmode.se ([83.241.175.147]:64177 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751315AbXFJXz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 19:55:28 -0400
Received: from Jocke ([84.217.92.176]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 11 Jun 2007 01:55:26 +0200
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <466C8B35.3020207@midwinter.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Thread-Index: AceruFKDiBFshOubQO+imx7neR6eeQAAfMeQ
X-OriginalArrivalTime: 10 Jun 2007 23:55:26.0258 (UTC) FILETIME=[D1080920:01C7ABBA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49794>

 

> -----Original Message-----
> From: Steven Grimm [mailto:koreth@midwinter.com] 
> Sent: den 11 juni 2007 01:37
> To: Joakim Tjernlund
> Cc: 'Eric Wong'; 'git'
> Subject: Re: git-svn set-tree bug
> 
> Joakim Tjernlund wrote:
> > Is there a way to tell set-tree to commit the whole "merge" branch
> > as one svn commit?
> > If I merge the latest kernel into my tree there will
> > be a lot of commits that I don't want in svn.
> >   
> 
> You want a "squash" merge. Something like this:
> 
> git checkout -b tempbranch origin/svn-branch-to-commit-merge-to
> git merge --squash branch-with-commits-you-want-to-merge
> git commit
> git svn dcommit
> 
> The "merge" command will merge in the changes but will not commit 
> anything; when you do the explicit "commit" command 
> afterwards, you get 
> the contents of the merge but from git's point of view it's just a 
> regular commit so git-svn doesn't get confused.
> 
> After you do git svn dcommit, you may want to edit 
> .git/info/grafts to 
> tell git after the fact that this commit was a merge. It won't hurt 
> git-svn at that point and it will mean you can do another merge later 
> without git getting confused about what has already been merged.
> 
> Take a look at the script I posted a while back, which does something 
> similar:
> 
> http://www.spinics.net/lists/git/msg29119.html
> 

Hi Steven

That looks promising, especially Junos comment about making git-svn
able to deal with merges. Eric, do you feel this is doable?

 Jocke 
