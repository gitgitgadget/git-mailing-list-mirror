From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use correct U*MAX.
Date: Fri, 03 Jun 2005 17:09:56 -0700
Message-ID: <7vslzzj82z.fsf@assigned-by-dhcp.cox.net>
References: <7vy89ums2l.fsf@assigned-by-dhcp.cox.net>
	<7vis0xkjn4.fsf@assigned-by-dhcp.cox.net>
	<7vwtpc7lju.fsf_-_@assigned-by-dhcp.cox.net>
	<20050603230234.GC13093@pasky.ji.cz>
	<7v4qcfko0q.fsf@assigned-by-dhcp.cox.net>
	<20050604000042.GG13093@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 02:09:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeMEQ-00029t-ES
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 02:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVFDAMa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 20:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVFDALH
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 20:11:07 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:9454 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261193AbVFDAJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 20:09:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050604000958.ICBA12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Jun 2005 20:09:58 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050604000042.GG13093@pasky.ji.cz> (Petr Baudis's message of
 "Sat, 4 Jun 2005 02:00:42 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

>> I'd rather see it use the correct U*MAX.

PB> Care to elaborate? It doesn't make sense to me to use any U*MAX stuff
PB> there whatsoever. (And how do you define the "correct" U*MAX anyway?)

It just feels wrong to spell a parameter to the function
locate_size_cache() "-1" when I know the argument it expects is
of type unsigned long.  And correct U*MAX for that case is
obviously ULONG_MAX, _assuming_ that you agree to the function's
(unwritten) calling convention of "passing the largest possible
value to me means 'do not create', not 'you are telling me that
sha1 is such a large file'".

If you feel strongly about that calling convention, you could
rewrite it to take the third argument "int do_not_create" and
pass that information separately, which is conceptually cleaner.
I just did not think that was worth it for such an internal
helper when I wrote it.

