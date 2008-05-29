From: Barry Roberts <blr@robertsr.us>
Subject: Re: git-gui clone differs from command line
Date: Wed, 28 May 2008 20:59:23 -0600
Message-ID: <1212029963.8891.2.camel@gdub.robertsr.us>
References: <483D7884.2050407@robertsr.us>
	 <20080528232324.GM30245@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 29 05:00:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1YNZ-0000A0-3q
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 05:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbYE2C72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 22:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbYE2C72
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 22:59:28 -0400
Received: from qmta09.emeryville.ca.mail.comcast.net ([76.96.30.96]:40270 "EHLO
	QMTA09.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751119AbYE2C71 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2008 22:59:27 -0400
Received: from OMTA10.emeryville.ca.mail.comcast.net ([76.96.30.28])
	by QMTA09.emeryville.ca.mail.comcast.net with comcast
	id XDpz1Z0090cQ2SLA907500; Thu, 29 May 2008 02:59:27 +0000
Received: from [172.30.4.99] ([76.27.51.25])
	by OMTA10.emeryville.ca.mail.comcast.net with comcast
	id XEzP1Z00A0YdJok8W00000; Thu, 29 May 2008 02:59:24 +0000
X-Authority-Analysis: v=1.0 c=1 a=QgqGedOSsOAA:10 a=dqGxn-36XDsA:10
 a=kDBM25NCNWwDtnZg7QcA:9 a=6PKgpjuvRrwwlkUZMwlQ7W1RBncA:4 a=WuK_CZDBSqoA:10
In-Reply-To: <20080528232324.GM30245@spearce.org>
X-Mailer: Evolution 2.12.3 (2.12.3-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83167>


On Wed, 2008-05-28 at 19:23 -0400, Shawn O. Pearce wrote:
> Barry Roberts <blr@robertsr.us> wrote:
> > After much mis-directed research, I finally figured out that cloning a 
> > repo (ssh://) with git-gui doesn't work exactly like 'git clone' from 
> > the command line.  The main difference is that 'git pull' doesn't work 
> > on master.  I get the error below.  Is that intentional, or are we doing 
> > something wrong?
> 
> Bug in git-gui.
> 
> git-gui's clone feature isn't implemented in terms of git-clone.
> Its implemented in terms of more primitive actions:
> 
> 	git init
> 	git remote add origin
> 	git fetch
> 	git fetch --tags
> 	git update-ref refs/heads/master origin/master
> 	git checkout
> 
> however it forgets to setup the branch configuration:
>  
> > If you often merge with the same branch, you may want to
> > configure the following variables in your configuration
> > file:
> > 
> >    branch.master.remote = <nickname>
> >    branch.master.merge = <remote-ref>
> >    remote.<nickname>.url = <url>
> >    remote.<nickname>.fetch = <refspec>
> > 
> > See git-config(1) for details.
> 
> Yea.  That author of git-gui should really check git-config(1)
> for detais.  *ducks and hides*
> 
> I'll try to fix it tonight or tomorrow.

No worries.  I just e-mailed out a [branch "master"] section
from .git/config from a cmd-line clone'd repo and all the Windows users
are happy.  Oddly, our Linux users never saw this ;-)

Thanks,
Barry
