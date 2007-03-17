From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 16:12:52 -0700
Message-ID: <7vabybqxaj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
	<alpine.LFD.0.83.0703162257560.18328@xanadu.home>
	<Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 00:12:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSi52-00007D-4R
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 00:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbXCQXMy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 19:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbXCQXMy
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 19:12:54 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:55840 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbXCQXMx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 19:12:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070317231254.ELYC18070.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Mar 2007 19:12:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bzCs1W00D1kojtg0000000; Sat, 17 Mar 2007 19:12:53 -0400
In-Reply-To: <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 17 Mar 2007 14:45:49 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42458>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Here's the trivial patch to extend the caching to 1k entries if somebody 
> cares. I don't know if the small added performance is worth it.

This largely would depend on the project, but if a blob that is
cached is 20kB each, a 1024-entry cache would grow to 20MB.  We
may need to introduce early eviction of cached objects with
total cache size limit, configurable per repository.
