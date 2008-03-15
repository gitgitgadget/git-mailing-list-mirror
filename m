From: Nicolas Pitre <nico@cam.org>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 20:38:10 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0803142025080.2947@xanadu.home>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
 <alpine.LFD.1.00.0803141041080.3557@woody.linux-foundation.org>
 <20080314183731.GA2994@atjola.homenet>
 <alpine.LFD.1.00.0803141150070.3557@woody.linux-foundation.org>
 <m34pb9xgrp.fsf@localhost.localdomain>
 <BAYC1-PASMTP1563DCF0556F09CFE67BE8AE0A0@CEZ.ICE>
 <93c3eada0803141643r2f2c4c56l9e59f2ee7b67a8ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 01:39:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaKQd-0000pb-6K
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 01:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbYCOAiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 20:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbYCOAiM
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 20:38:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22125 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbYCOAiL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 20:38:11 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JXQ00JRHXRM52H0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 14 Mar 2008 20:38:10 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <93c3eada0803141643r2f2c4c56l9e59f2ee7b67a8ca@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77298>

On Sat, 15 Mar 2008, Geoff Russell wrote:

> The context where I want to use this is for users who update files,
> can understand
> "take me back to the state I was in at 4pm yesterday before I mucked up
> my data" but who don't want to know about merging, branching, topics, etc, etc,
> But of course having taken them back to the 4pm commit, they then realise that
> they really need the 6pm commit or perhaps the 3pm commit. So anything which
> just throws away commits would be risky.

The reflog can help you there as well.  You can simply do:

	git reset --hard HEAD@{yesterday.at.4pm}

and it'll magically bring you back to the state you were yesterday at 
4pm.  You need the 6pm state instead?  No problem: just ask for 
yesterday.at.6pm then.

And before doing the 'reset --hard', you might want to do a simple 
'checkout' beforehand so you can be sure it actually corresponds to what 
you want:

	git checkout HEAD@{yesterday.at.4pm}
	[compile, test, whatever]
	git checkout HEAD@{yesterday.at.6pm}
	[compile, test, whatever]

and when OK with it, then:

	# return to your master branch (or any other branch)
	git checkout master
	# then reset it to the desired state
	git reset --hard HEAD@{yesterday.at.6pm}


Nicolas
