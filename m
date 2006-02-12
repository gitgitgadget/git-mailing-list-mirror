From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix object re-hashing
Date: Sun, 12 Feb 2006 11:21:11 -0800
Message-ID: <7vlkwg9ye0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602120956130.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602121006360.3691@g5.osdl.org>
	<7vaccwbf6v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602121037460.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602121101040.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 20:21:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Mmo-0008OL-R0
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 20:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWBLTVO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 14:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWBLTVO
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 14:21:14 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:56009 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751425AbWBLTVN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 14:21:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212192118.TZRT25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Feb 2006 14:21:18 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602121101040.3691@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 12 Feb 2006 11:10:11 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16014>

Linus Torvalds <torvalds@osdl.org> writes:

> Anyway, if all this makes you nervous,...

I did draw an illustration like the one I sent in my previous
message when I received the first patch from Johannes, and it was
reasonably obvious to me that it was meant to redistribute about
half of the existing entries to the upper area, always going
upwards, so modulo that wraparound corner case you fixed, I
think doubling is fine.

> Btw, as it currently stands, I worry a tiny tiny bit about the
>
> 	obj_allocs = (obj_allocs < 32 ? 32 : 2 * obj_allocs)
>
> thing, because I think that second "32" needs to be a "64" to be really 
> safe (ie guarantee that the new obj_allocs value is always at least twice 
> the old one).

obj_allocs starts out as 0 so the first value it gets is 32 when
you need to insert the first element.
