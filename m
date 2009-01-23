From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: lineups with GIT
Date: Fri, 23 Jan 2009 13:01:31 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901231247100.19665@iabervon.org>
References: <1232610882661-2196604.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: outre <spoony.sob@hotmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 19:03:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQQMt-0002ds-1n
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 19:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756808AbZAWSBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 13:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756783AbZAWSBd
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 13:01:33 -0500
Received: from iabervon.org ([66.92.72.58]:46073 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756557AbZAWSBd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 13:01:33 -0500
Received: (qmail 24863 invoked by uid 1000); 23 Jan 2009 18:01:31 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Jan 2009 18:01:31 -0000
In-Reply-To: <1232610882661-2196604.post@n2.nabble.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106896>

On Wed, 21 Jan 2009, outre wrote:

> I am trying to set up two different line-ups for a project (development and
> testing).
> 
> The development line-up is the master, and test line-up pulls data from it.
> The code is the same in both.
> But since the line-ups are served from two different domains one folder in
> the development line-up is called
> iWeb.local, and in the test line-up it is called iWeb.test. That is the only
> difference between the two.
>
> I tried using "git mv" command and it somewhat solved the problem. After I
> cloned the devel line-up, I used "git rm iWeb.local iWeb.test".
> And now if I edit a file in iWeb.local and do a pull to iWeb.test this file
> gets properly updated while preserving the difference between
> the folder names. But if I add a new file to iWeb.local, and then do a pull
> I get  iWeb.local folder added together with the 
> new file to the testing line-up.
> 
> I was wondering if it is intended behaviour for GIT. And if it is may be
> someone can point me to a better way to setup two line-ups using
> GIT.

The best thing is probably to have both of them store everything in a 
directory "iWeb", and have whatever process is used to make something 
start serving things copy the directory into whatever location it needs. 
It helps a lot with git if any two versions that are effectively the same 
are exactly the same.

One handy trick is to have a script that reads an untracked file to 
determine where and how to arrange stuff for installation. Then you can 
have different values in the working directories for the two repositories, 
and the same (tracked) script in each repository will do the appropriate 
different thing for that repository, while leaving the tracked content for 
development exactly the same in testing.

	-Daniel
*This .sig left intentionally blank*
