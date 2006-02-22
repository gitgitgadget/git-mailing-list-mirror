From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] relax delta selection filtering in pack-objects
Date: Tue, 21 Feb 2006 23:23:06 -0800
Message-ID: <7vhd6rsvqd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602212034180.5606@localhost.localdomain>
	<7vpslgrkr0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 08:23:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBoLC-000784-2D
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 08:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWBVHXK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 02:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWBVHXK
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 02:23:10 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61871 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932202AbWBVHXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 02:23:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222072031.KILL17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Feb 2006 02:20:31 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <7vpslgrkr0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 21 Feb 2006 22:05:39 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16592>

Junio C Hamano <junkio@cox.net> writes:

> I haven't dug into the issue yet, but these four delta series
> seem to break the testsuite.

I bisected.  It is the adler32 one -- since it makes the
generated delta much smaller, it is understandable that it would
interact with the break/rename heuristics.  It is not strictly
breakage in that sense -- we just need to readjust the
heuristics thresholds for those algorithms.
