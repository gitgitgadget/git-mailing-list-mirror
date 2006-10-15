From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: use of version 3 delta is now optional.
Date: Sun, 15 Oct 2006 14:51:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610151433310.17085@xanadu.home>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
 <7virim10rb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610151135110.17085@xanadu.home>
 <7vac3xzbze.fsf@assigned-by-dhcp.cox.net> <egtu1r$813$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_R6qy5mX4c6lKz7vj10r/8A)"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 15 20:51:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZB4r-00015Y-Jm
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 20:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWJOSvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 14:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWJOSvJ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 14:51:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52278 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030225AbWJOSvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 14:51:08 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J76006VIXP89EE0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 15 Oct 2006 14:51:08 -0400 (EDT)
In-reply-to: <egtu1r$813$1@sea.gmane.org>
X-X-Sender: nico@xanadu.home
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28927>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_R6qy5mX4c6lKz7vj10r/8A)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sun, 15 Oct 2006, Jakub Narebski wrote:

> Junio C Hamano wrote:
> 
> > I think that is sensible.  I also was thinking that we should
> > call the current one packv3 and the one with delta-base-offset
> > packv4.
> 
> Just curious: what was the difference between packv1 and packv2,
> and packv3 and packv4?

Pack v1 was really short-lived (one day or two).  It used a different 
encoding for object size and delta size than what exists today.  When 
the current encoding was adopted the pack version was bumped to 2 to 
make sure anyone, if any, who might have started to rely upon packs in 
those early days would not end up trying to use incompatible pack data.  
Backward compatibility was not a concern at all back then of course.  
So for all practical purposes just consider that pack version 1 never 
existed.

Pack version 3 simply redefined one bit in the delta encoding that was 
never used.  The former definition of the bit was implemented in the 
decode part, but attempts to use it in the encode part turned up to be 
way too costly for really really poor benefits.  for details just have a 
look at commit d60fc1c8649f80c006b9f493c542461e81608d4b.

As for pack v4... My opinion is that nothing justifies it so far.  So if 
I can convince Junio there shouldn't be any v4 just yet.


Nicolas

--Boundary_(ID_R6qy5mX4c6lKz7vj10r/8A)--
