From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 13:13:54 -0700
Message-ID: <7vk5w9fnjx.fsf@assigned-by-dhcp.cox.net>
References: <11768880622402-git-send-email-junkio@cox.net>
	<Pine.LNX.4.64.0704181247410.12094@racer.site>
	<20070418153445.GC12888@admingilde.org>
	<alpine.LFD.0.98.0704180910120.2828@woody.linux-foundation.org>
	<7vslaxhamd.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704181136360.2828@woody.linux-foundation.org>
	<7vzm55fqyv.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704181246160.2828@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 22:14:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeGXf-0007Pl-LB
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 22:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992531AbXDRUN5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 16:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992513AbXDRUN5
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 16:13:57 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:60469 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992506AbXDRUNz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 16:13:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418201354.IEAW1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 16:13:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id okDu1W00T1kojtg0000000; Wed, 18 Apr 2007 16:13:55 -0400
In-Reply-To: <alpine.LFD.0.98.0704181246160.2828@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 18 Apr 2007 12:51:38 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44938>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> by making attributes say something like
>
> 	*: merge=ours
>
> because I think the attributes are really about what we do WHEN we hit 
> file-level conflicts, while the "merge strategy" is a much higher-level 
> thing. They are independent.

Yes, but in the case I had trouble with, I know what I want to
see happen when we DO hit file-level conflict on RelNotes
symlink.  The ancestor says Documentation/RelNotes-1.5.0.txt,
the maint branch says Documentation/RelNotes-1.5.0.1.txt, while
the current branch says Documentation/RelNotes-1.5.1.txt.  The
logic in merge_file() simply says "we would punt on file-level
conflicts for symlinks" without giving a chance for low-level
drivers to interfere.
