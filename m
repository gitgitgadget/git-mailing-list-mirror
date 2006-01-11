From: Michal Ostrowski <mostrows@watson.ibm.com>
Subject: Re: [PATCH] (Updated) Exec git programs without using PATH.
Date: Wed, 11 Jan 2006 16:26:52 -0500
Message-ID: <1137014812.11717.669.camel@brick.watson.ibm.com>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
	 <1136849810.11717.518.camel@brick.watson.ibm.com>
	 <7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
	 <1136900174.11717.537.camel@brick.watson.ibm.com> <43C3CC4A.4030805@op5.se>
	 <1136910406.11717.579.camel@brick.watson.ibm.com> <43C4075E.4070407@op5.se>
	 <7vu0cb6f1n.fsf@assigned-by-dhcp.cox.net>
	 <1136924980.11717.603.camel@brick.watson.ibm.com>
	 <7vd5iz4mt7.fsf@assigned-by-dhcp.cox.net>
	 <1136945538.11717.643.camel@brick.watson.ibm.com>
	 <7v4q4bwavi.fsf@assigned-by-dhcp.cox.net>
	 <1136999157.11717.658.camel@brick.watson.ibm.com>
	 <7vek3esdw0.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0601111238550.5073@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 22:26:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwnTN-00058o-6I
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 22:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWAKVZd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 16:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWAKVZd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 16:25:33 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:57043 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750767AbWAKVZc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 16:25:32 -0500
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com [129.34.20.41])
	by igw2.watson.ibm.com (8.12.11/8.13.1/8.13.1-2005-04-25 igw) with ESMTP id k0BLRV6i006806;
	Wed, 11 Jan 2006 16:27:31 -0500
Received: from sp1n293en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with ESMTP id k0BLPIk291406;
	Wed, 11 Jan 2006 16:25:18 -0500
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with ESMTP id k0BLPGu176036;
	Wed, 11 Jan 2006 16:25:16 -0500
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id k0BMLxdK004654;
	Wed, 11 Jan 2006 17:22:00 -0500
Received: from brick (brick.watson.ibm.com [9.2.216.48])
	by kitch0.watson.ibm.com (AIX5.1/8.11.6p2/8.11.0/03-06-2002) with ESMTP id k0BLPEm31670;
	Wed, 11 Jan 2006 16:25:14 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601111238550.5073@g5.osdl.org>
X-Mailer: Evolution 2.4.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14517>

On Wed, 2006-01-11 at 12:42 -0800, Linus Torvalds wrote:
> 
> On Wed, 11 Jan 2006, Junio C Hamano wrote:
> > 
> > For your (primarily Michal, but other interested parties as
> > well) reference, here is the diff between your patch in the
> > message I am replying to and what I placed in the "pu" branch
> > last night.
> 
> Tangentially related note: maybe we should try to move to a "spawn()" like 
> interface so that it could port better to native Windows interfaces?
> 
> Even under Linux, using vfork()+exec() is actually faster than a regular 
> fork/exec, so there are potential advantages.
> 
> The real advantage of fork+exec is how you can do arbitrary setup between 
> the two, without needing insanely complex rules for file descriptors etc. 
> But maybe we don't have tons of those issues?
> 

I briefly tried to consider if I could hide the various fork()+exec()
sequences behind something like the run_command*() interfaces (which
would move us down the direction of something "spawn()"-like).  I found
that there's a lot of variation between the various paths in terms of
what happens between fork() and exec() on the various paths that does
not lend itself to such consolidation.

I'd love to be convinced otherwise.

-- 
Michal Ostrowski <mostrows@watson.ibm.com>
