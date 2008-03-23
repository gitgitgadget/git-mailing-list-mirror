From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH 0/3] Teach builtin-clone to pack refs
Date: Sun, 23 Mar 2008 10:49:20 +0100
Message-ID: <200803231049.20874.johan@herland.net>
References: <200803220210.30957.johan@herland.net>
 <7v8x0agtdn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 10:50:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdMqe-0006v2-0m
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 10:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbYCWJt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 05:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262AbYCWJt4
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 05:49:56 -0400
Received: from smtp.getmail.no ([84.208.20.33]:38620 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624AbYCWJtz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 05:49:55 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JY600I15GN6C400@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 23 Mar 2008 10:49:54 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JY600GRFGM9CZ80@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 23 Mar 2008 10:49:21 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JY600B0WGM9UOG0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 23 Mar 2008 10:49:21 +0100 (CET)
In-reply-to: <7v8x0agtdn.fsf@gitster.siamese.dyndns.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77874>

On Sunday 23 March 2008, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> 
> > Although most of the speedup from current "next" is achieved by the
> > builtin-clone work, there is still a considerable additional improvement
> > from writing all refs to a single file instead of writing one file per
> > ref. I expect the performance improvement to be much bigger on platforms
> > with slower filesystem (aka. Windows).
> 
> At some point, additional speedups are hidden in the noise.

Yes, however, I bet you'll notice the difference between writing 11000 files on Windows, and writing 1.

Unfortunately, this scenario is not as far fetched as some may think: At $dayjob I'm working on converting old CVS modules with up to ~10 years of history, and some of the resulting repos have ~30000 refs (mostly build tags). Although I'll probably remove the build tags before preparing the repos that most other developers will see, I'll still have to keep the build tags around somewhere, in case devs need to refer to them. And, of course, most devs are still Windows-users. Keeping refs packed is pretty much crucial in this scenario.

> Not writing reflogs is a _different_ behaviour from the previous, but I
> suspect it might even be an improvement.  When you have 1000 remote
> branches, probably most of them are not even active.

Exactly my thinking as well. And for those few that _are_ active, you'll still of course get regular reflog entries when they _do_ change.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
