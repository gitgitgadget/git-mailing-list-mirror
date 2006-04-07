From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Fri, 07 Apr 2006 14:46:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604071446010.2215@localhost.localdomain>
References: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com>
 <Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604030730040.3781@g5.osdl.org>
 <Pine.LNX.4.64.0604030734440.3781@g5.osdl.org>
 <7vhd55ls24.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604071002530.2215@localhost.localdomain>
 <7vhd55jkz0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 07 20:47:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRvz4-0000th-AB
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 20:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWDGSq7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Apr 2006 14:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWDGSq7
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Apr 2006 14:46:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60087 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964863AbWDGSq7
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 7 Apr 2006 14:46:59 -0400
Received: from xanadu.home ([74.56.105.38]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IXD00MMA867A690@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 Apr 2006 14:46:56 -0400 (EDT)
In-reply-to: <7vhd55jkz0.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18502>

On Fri, 7 Apr 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Fri, 7 Apr 2006, Junio C Hamano wrote:
> >
> >> Linus Torvalds <torvalds@osdl.org> writes:
> >> 
> >> > On Mon, 3 Apr 2006, Linus Torvalds wrote:
> >> >> 
> >> >> That said, I think git _does_ have problems with large pack-files. We have 
> >> >> some 32-bit issues etc
> >> >
> >> > I should clarify that. git _itself_ shouldn't have any 32-bit issues, but 
> >> > the packfile data structure does. The index has 32-bit offsets into 
> >> > individual pack-files. 
> >> >
> >> > That's not hugely fundamental,...
> >> 
> >> Linus _does_ understand what he means, but let me clarify and
> >> outline a possible future direction.
> >
> > For the record, the delta code also has 32-bit limitations of its own 
> > presently.  It cannot encode a delta against a buffer which is larger 
> > than 4GB.
> >
> > I however made sure the byte 0 could be used as a prefix for future 
> > encoding extensions, like 64-bit file offsets for example.
> 
> True the delta data representation, not just the "delta code",
> has that limitation, but I do not think you issue "insert 0-byte
> literal data" command from the deltifier side right now, so we
> should be OK.
> 
> Maybe we would want to check (cmd == 0) case to detect delta
> extension that we do not handle right now?

Good idea.  Will send you a patch.


Nicolas
