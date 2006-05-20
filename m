From: Dave Jones <davej@redhat.com>
Subject: Re: dangling commits.
Date: Sat, 20 May 2006 19:49:11 -0400
Message-ID: <20060520234911.GA30269@redhat.com>
References: <20060520230531.GA27511@redhat.com> <Pine.LNX.4.64.0605201615270.3649@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 01:49:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhbCS-0003nO-7N
	for gcvg-git@gmane.org; Sun, 21 May 2006 01:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWETXtX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 19:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWETXtX
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 19:49:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47081 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932161AbWETXtX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 19:49:23 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k4KNnI65023575;
	Sat, 20 May 2006 19:49:18 -0400
Received: from nwo.kernelslacker.org (vpn83-123.boston.redhat.com [172.16.83.123])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k4KNnDvs006292;
	Sat, 20 May 2006 19:49:13 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.6/8.13.5) with ESMTP id k4KNnCkW030607;
	Sat, 20 May 2006 19:49:12 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.6/8.13.6/Submit) id k4KNnCCL030606;
	Sat, 20 May 2006 19:49:12 -0400
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605201615270.3649@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20409>

On Sat, May 20, 2006 at 04:19:06PM -0700, Linus Torvalds wrote:

 > > What's wrong here?
 > 
 > Nothing, except
 > 
 >  - you used rsync to fetch the thing (so you get all objects, regardless 
 >    of whether they are reachable or not)

Ah. I actually noticed this when I poked around the box that does
the nightly snapshots, and wondered for a few minutes why I never
switched it over to git:// last time I poked at that script.
Then it came back to me: rsync -q worked better than redirecting
git to /dev/null
- git-clone's -q was still outputting some stuff, so recloning each
  time the cronjob ran wasn't an option,
- subsequent git pull's were noisy too

When run from a cronjob, unless something fatal happens, I basically
never want to get mail from the snapshotting script.

 >  - junio re-bases his "pu" branch, and I just end up following him (I 
 >    should stop exporting git entirely, here's no point, really).

I just updated the snapshot script to pull from 
http://www.kernel.org/pub/scm/git/git.git/ instead.

thanks,

		Dave

-- 
http://www.codemonkey.org.uk
