From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-annotate, a tool for assigning blame.
Date: Fri, 24 Feb 2006 01:52:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602240148250.32472@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11404323692193-git-send-email-ryan@michonline.com>
 <20060220234054.GA7903@c165.ib.student.liu.se> <20060223221048.GA6423@mythryan2.michonline.com>
 <20060223225547.GB8673@c165.ib.student.liu.se>
 <Pine.LNX.4.63.0602240055080.31816@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vek1thaop.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Fri Feb 24 01:52:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCRCN-0001o7-Da
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 01:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWBXAwl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 19:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWBXAwk
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 19:52:40 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:15583 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932159AbWBXAwk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 19:52:40 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 06B6D1B33;
	Fri, 24 Feb 2006 01:52:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id EE7CF2A72;
	Fri, 24 Feb 2006 01:52:38 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id B827912EC;
	Fri, 24 Feb 2006 01:52:38 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek1thaop.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16678>

Hi,

On Thu, 23 Feb 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > This could probably benefit a *LOT* from the libification project, I
> >> > think, though.
> >> 
> >> Yes, perhaps. Some of the git-rev-list bits might simplify a couple of
> >> things.
> >
> > The major problem is probably not solved: What Linus calls a "stream 
> > interface".
> >
> > I.e. if you pipe the output of git-rev-list to another program, you 
> > *need* to execute the two semi-simultaneously. The "alternative" would be 
> > to use buffers, which can get huge (and are sometimes not needed: think 
> > git-whatchanged, which starts outputting before it's getting no more 
> > input).
> 
> You need a limited coroutine support, something like generator
> functions in Python ;-).  In C, traditional way of doing it is
> to make your application specific function a callback of
> rev-list or whatever generator is, which is very unpleasant to
> code.

The most unpleasant aspect is that you usually need something like "this" 
in C++: a pointer to an object (which you have to pass around all the 
time). Without it you can not use the function in a nested way.

However, I can also see benefits of this when compared to the traditional 
UNIX approach. It should be faster, for one, since you don't need to pass 
data through pipes all the time. (This might be not as true for Linux as 
for other OSes.)

Ciao,
Dscho
