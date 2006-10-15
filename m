From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: use of version 3 delta is now optional.
Date: Sun, 15 Oct 2006 14:30:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610151422510.17085@xanadu.home>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
 <7virim10rb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610151135110.17085@xanadu.home>
 <7vac3xzbze.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Oct 15 20:31:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZAlj-0006qf-Ox
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 20:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbWJOSat (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 14:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWJOSat
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 14:30:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33006 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1161080AbWJOSar (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 14:30:47 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J76007CRWRAAOA0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 15 Oct 2006 14:30:47 -0400 (EDT)
In-reply-to: <7vac3xzbze.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28925>

On Sun, 15 Oct 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > If anything, maybe this patch can be added before v1.4.3 is released:
> >...
> > This way pack v3 could be fed to GIT v1.4.3 and above whenever we add 
> > back pack v3 generation, and a pack converted to v2 from any v3 on the 
> > fly when that capability is not present.
> 
> I think that is sensible.  I also was thinking that we should
> call the current one packv3 and the one with delta-base-offset
> packv4.

I think we should not.  The pack version should be tied to incompatible 
pack data to prevent older GIT versions from misinterpreting newer 
packs.  The delta block copy encoding is a perfect example of that where 
a bit changed meaning.

The delta-base-offset case included a new object type that wasn't used 
before hence there is no room for confusion, and yet that new delta 
object could be encoded according to pack version 2 or pack version 3 
which makes it orthogonal to the pack version itself.


Nicolas
