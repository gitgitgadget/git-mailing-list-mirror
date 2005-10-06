From: Junio C Hamano <junkio@cox.net>
Subject: Re: Still unsafe: write_sha1_from_fd()
Date: Thu, 06 Oct 2005 15:37:40 -0700
Message-ID: <7vvf0a5l1n.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510061520400.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 00:39:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENeMz-0002BF-Oa
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 00:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVJFWhm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 18:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVJFWhm
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 18:37:42 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:38875 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751136AbVJFWhm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 18:37:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051006223729.URIQ29747.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Oct 2005 18:37:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510061520400.31407@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 6 Oct 2005 15:26:52 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9787>

Linus Torvalds <torvalds@osdl.org> writes:

> The only user is apparently ssh-fetch, but especially since the input-fd 
> is a network connection, it looks like it is not at all unlikely that this 
> case will trigger - all it takes is somebody impatient waiting for a large 
> object.
>
> Ugh,

Ugh indeed.

I'd vote for renaming it to a less generic name, moving it out
of sha1_file.c -- make it static in ssh-fetch.c -- and slowly
deprecate the use of ssh-fetch/ssh-upload pair.

I do not see much point prefering it over the pack transfer
protocol anyway, if you already have ssh access to the box.
