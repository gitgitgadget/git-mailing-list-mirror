From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 21:27:09 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512222122300.355@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net> <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vek465cev.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AA75D1.7040009@op5.se> <Pine.LNX.4.63.0512221220220.7112@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AA9BE6.7000601@op5.se> <Pine.LNX.4.63.0512221530570.18551@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AACBE9.7060201@op5.se> <Pine.LNX.4.63.0512221700310.18982@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AAD9D7.1070503@op5.se> <7vwthxlzai.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512222022510.31591@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3bkkkhwb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 21:27:24 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpX1z-0005pY-Ga
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 21:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbVLVU1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 15:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbVLVU1M
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 15:27:12 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:17073 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965184AbVLVU1K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 15:27:10 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C312813F9E6; Thu, 22 Dec 2005 21:27:09 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9FB489E3DF; Thu, 22 Dec 2005 21:27:09 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 81E7B9E2AA; Thu, 22 Dec 2005 21:27:09 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 600D013F9E6; Thu, 22 Dec 2005 21:27:09 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bkkkhwb.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13967>

Hi,

On Thu, 22 Dec 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > And then somebody comes along and allows world access by chmod(0775) and 
> > does not realize that *everybody* can delete packs, objects and what-nots 
> > in GIT_DIR.
> 
> That somebody has to be somebody who owns .git directory not
> just a group member, so that is not a serious objection either,
> but you need to realize I was joking with 0777 -- a saner
> default would obviously be 0775.  Otherwise you would not be
> able to server it from gitweb safely -- http server is typically
> not a group member.

I was talking about somebody who has only one server for everything: mail, 
web and git. So this somebody would be the owner of .git.

> > Given the complexity we are talking about, and the needs which are not at 
> > all that complicated, why not just go with core.umask until somebody 
> > *needs* core.repositoryumask?
> 
> I am afraid that is going backwards.  Nobody *needs* core.umask
> either, but we are still talking about this.

Well, I do.

> Your core.umask would make sure the .git/objects/ directory
> would be suitable for other members, but git is not the only
> tool the people would use in the working tree.  To work well
> with an editor that does not overwrite an existing file but does
> creat/rename upon saving would require you to have a sane umask
> if the user adopts your "shared working tree writable by all
> members" workflow.  Running "make" in the working tree would
> leave object files, worse yet in a temporary build directory
> make created, with permission bits masked with your umask,
> making it imposible to run "make clean" for other members.

Hmm. That is convincing.

> we should be able to say "such and such things under .git/ in this 
> repository must be ug+rw regardless of user's umask".

Yes, I tried to avoid that.

Ciao,
Dscho
