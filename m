From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] diff --stat: allow custom diffstat output width.
Date: Thu, 28 Sep 2006 18:35:07 -0700
Message-ID: <7vk63nsbec.fsf@assigned-by-dhcp.cox.net>
References: <7vr6xyjal0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609281349110.3952@g5.osdl.org>
	<7vac4ju1f1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609281458420.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 03:35:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT7HY-0001K5-MP
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 03:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161263AbWI2BfL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 21:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161266AbWI2BfL
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 21:35:11 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:53222 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1161263AbWI2BfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 21:35:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060929013508.ZQFL12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 21:35:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id U1bA1V01F1kojtg0000000
	Thu, 28 Sep 2006 21:35:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609281458420.3952@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 28 Sep 2006 15:07:16 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28080>

Linus Torvalds <torvalds@osdl.org> writes:

> You should probably check the "width" and "name_width" values for sanity.

The output code forces (well, at least tries to force) some
sanity into these values when they are not, so probably we do
not need it.  If we want, we could check something like:

    	if (name_width < 10 || width - name_width < 15)
		die("at least 10 for name, and 15+name for width please");

The number 10 is totally arbitrary; among the total area that is
given by width, after subtracting name_width, 10 columns are
taken by left and right end space, vertical bar and numbers, so
the above gives at least 5 columns to draw the graph.
