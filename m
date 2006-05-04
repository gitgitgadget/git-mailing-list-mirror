From: Junio C Hamano <junkio@cox.net>
Subject: Re: sha1_to_hex() usage cleanup
Date: Wed, 03 May 2006 17:36:57 -0700
Message-ID: <7v1wvabp7a.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605031717190.4086@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 04 02:37:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbRq1-0008Mi-P7
	for gcvg-git@gmane.org; Thu, 04 May 2006 02:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWEDAg7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 20:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWEDAg7
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 20:36:59 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:34786 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750815AbWEDAg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 20:36:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060504003658.YQTE27327.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 May 2006 20:36:58 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0605031717190.4086@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 3 May 2006 17:21:08 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19538>

Linus Torvalds <torvalds@osdl.org> writes:

> Somebody on the #git channel complained that the sha1_to_hex() thing uses 
> a static buffer which caused an error message to show the same hex output 
> twice instead of showing two different ones.
>
> That's pretty easily rectified by making it uses a simple LRU of a few 
> buffers, which also allows some other users (that were aware of the buffer 
> re-use) to be written in a more straightforward manner.
>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> ---
>
> This is another throw-away patch of mine. Not a big deal, but since I 
> tried it, I might as well try to submit it and see if Junio agrees..

Makes sort of sense in that the callers still need to be aware
of the magic 4 limit but as long as they are they do not have to
worry about allocation/deallocation/copying.  But is that kind
of cheat maintainable?  I dunno.
