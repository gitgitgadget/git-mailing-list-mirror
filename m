From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: New diff-delta.c implementation
Date: Sat, 22 Apr 2006 10:57:17 -0700
Message-ID: <7vd5f9ijcy.fsf@assigned-by-dhcp.cox.net>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com>
	<Pine.LNX.4.64.0604212308080.2215@localhost.localdomain>
	<A856A2C5-2BD7-4DC5-9CCC-CD53E9A2623C@adacore.com>
	<7v7j5hkglq.fsf@assigned-by-dhcp.cox.net>
	<6794F5B2-A277-4CD9-9BA8-509F86378E68@adacore.com>
	<Pine.LNX.4.64.0604220846040.2215@localhost.localdomain>
	<81E2B4A6-3591-418D-9448-47648AF4A687@adacore.com>
	<7v3bg5k0ev.fsf@assigned-by-dhcp.cox.net>
	<EB4042E4-D74E-4346-A9CA-50E9CB33F18C@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 22 19:57:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXMME-0004a0-0k
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 19:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWDVR5T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 13:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWDVR5T
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 13:57:19 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:20692 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750812AbWDVR5S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Apr 2006 13:57:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060422175718.EBRF20694.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 22 Apr 2006 13:57:18 -0400
To: Geert Bosch <bosch@adacore.com>
In-Reply-To: <EB4042E4-D74E-4346-A9CA-50E9CB33F18C@adacore.com> (Geert Bosch's
	message of "Sat, 22 Apr 2006 13:28:23 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19042>

Geert Bosch <bosch@adacore.com> writes:

> That's about how I implemented it in my last patch.
> Is it correct that 0 means that there is no max_size?
> Should I set *delta_size to 0 when doing an early
> return, or leave it alone?

When failing, I think
the convention is to return NULL and what you do with *delta_size
does not matter, but Nico and pack-objects.c code can answer
that better than I can ;-).

> Note that this really is a micro-optimization,

True.  max_size is a hint, and the caller validates the size
independently anyway, so ignoring is fine.
