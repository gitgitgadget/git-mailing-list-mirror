From: Nicolas Pitre <nico@cam.org>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Mon, 12 May 2008 15:36:13 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805121527550.23581@xanadu.home>
References: <20080512122900.GA13050@mithlond.arda.local>
 <20080512155243.GA3592@mithlond.arda.local>
 <alpine.DEB.1.00.0805121810501.30431@racer>
 <20080512184334.GB5160@mithlond.arda.local>
 <alpine.LFD.1.10.0805121453250.23581@xanadu.home>
 <20080512190946.GC5160@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon May 12 21:37:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvdpY-00009W-UN
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 21:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbYELTgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 15:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYELTgP
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 15:36:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52339 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbYELTgO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 15:36:14 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0R005V4T4DP140@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 12 May 2008 15:36:13 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080512190946.GC5160@mithlond.arda.local>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81914>

On Mon, 12 May 2008, Teemu Likonen wrote:

> Nicolas Pitre wrote (2008-05-12 14:56 -0400):
> 
> > On Mon, 12 May 2008, Teemu Likonen wrote:
> > 
> > > Well, I don't really have any problems with the current behaviour;
> > > it just feels a bit strange that, for example, Linus's kernel
> > > repository grew about 90MB after just one update pull and gc.
> > 
> > That looks really odd.  Sure the repo might grow a bit, but 90MB seems
> > really excessive.  How many time did pass between the initial clone
> > and that subsequent pull?
> 
> As I used the kernel repo just for testing this behaviour in question
> I did both things today. Timestamps tell that there were six hours
> between the initial .keep pack and the new pack created by manual "git
> gc".

This is way too big a difference.  Something is going on.

What git version is this? And can you send me the content of your 
.git/logs directory?

> > > Also, dangling objects are kept forever in .keep packs (which are
> > > created with "git clone", for example).
> > 
> > A pack obtained via 'git clone' will never contain any dangling
> > objects.
> 
> I think it can contain at some later point. For example, if a user first
> fetches all the branches but later decides to track only one branch.
> After deleting unneeded tracking branches and expiring the reflog
> there'll be dangling objects in the original .keep pack created with
> "git clone".

Sure.  But to decide to track only one branch and exclude the others 
require some higher level of git knowledge already.  At that point if 
you really care about top packing performances you certainly can deal 
with the .keep file as well.


Nicolas
