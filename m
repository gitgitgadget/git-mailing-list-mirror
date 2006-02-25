From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 22:53:09 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602242242380.31162@localhost.localdomain>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
 <20060224174422.GA13367@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
 <20060224183554.GA31247@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
 <20060224192354.GC387@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241438521.31162@localhost.localdomain>
 <20060224204022.GA15962@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241544270.31162@localhost.localdomain>
 <20060224225023.GA28538@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 04:53:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCqUm-0004j9-W2
	for gcvg-git@gmane.org; Sat, 25 Feb 2006 04:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWBYDxN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 22:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWBYDxN
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 22:53:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20028 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932601AbWBYDxN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 22:53:13 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV80080U5GLT3E0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 24 Feb 2006 22:53:10 -0500 (EST)
In-reply-to: <20060224225023.GA28538@hpsvcnb.fc.hp.com>
X-X-Sender: nico@localhost.localdomain
To: Carl Baldwin <cnb@fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16752>

On Fri, 24 Feb 2006, Carl Baldwin wrote:

> > If you can add them into a single .tgz with instructions on how 
> > to reproduce the issue and provide me with an URL where I can fetch it 
> > that'd be perfect.
> 
> I will do this in an email off of the list because these files really
> shouldn't be available on a public list.

OK I have the files, and I can confirm that your problem is of the same 
combinatorial explosion type I already talked about, _even_ with the 
version using adler32.  This is really O(m*n) where m and n being the 
size of two consecutive versions of the files.  But since m and n are 
both _huge_ then the delta code really goes out to lunch.

I'm working on a patch to cap this to something like O(m+n).

Stay tuned.


Nicolas
