From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git gc / git repack not removing unused objects?
Date: Sat, 06 Feb 2010 20:16:58 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002061935180.1681@xanadu.home>
References: <cccedfc61002051145q1ff673e7s3db3bd7290be25e1@mail.gmail.com>
 <alpine.LFD.2.00.1002051539080.1681@xanadu.home>
 <cccedfc61002051304t6030d3f7if4bb14709ee6c918@mail.gmail.com>
 <alpine.LFD.2.00.1002051634380.1681@xanadu.home>
 <cccedfc61002060553w464d5d9drd582b3b3c3f35227@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jon Nelson <jnelson@jamponi.net>
X-From: git-owner@vger.kernel.org Sun Feb 07 02:17:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndvlr-0002M9-DD
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 02:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933540Ab0BGBRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 20:17:02 -0500
Received: from relais.videotron.ca ([24.201.245.36]:16538 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932141Ab0BGBRA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 20:17:00 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KXG00BHY68A6X70@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 06 Feb 2010 20:16:58 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <cccedfc61002060553w464d5d9drd582b3b3c3f35227@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139205>

On Sat, 6 Feb 2010, Jon Nelson wrote:

> Last night, the repo size was 153G after removing some commits and
> objects by way of git filter-branch.
> I'm using "du -sh" in the .git directory to determine the disk usage.
> 
> Before: 136G
> git repack -dAl
> After: 153G

Why are you using -A instead of -a ?

> Then, just to make sure of some things, I changed nothing and simply
> re-ran "git repack -dAl".
> After: 167G

Could you run 'git count-objects -v' before and after a repack in such 
cases as well?

> [pack]
>         packsizelimit = 256m

Why are you using this?

> pack.packsizelimit=2M

This is even worse.  150G / 2M per pack = approx 75000 packs.

What you should be aiming for is a _single_ pack for best performances.  
A couple packs is common and doesn't make much of a difference.  A 
hundred packs is getting a bit large.  But 75000 packs is totally 
insane.


Nicolas
