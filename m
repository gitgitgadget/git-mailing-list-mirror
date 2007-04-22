From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFR] gitattributes(5) documentation
Date: Sun, 22 Apr 2007 00:02:06 -0700
Message-ID: <7vmz10q4cx.fsf@assigned-by-dhcp.cox.net>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net> <7vr6qlxexe.fsf@assigne
	d-by-dhcp.cox.net> <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
	<7vslav4yv6.fsf_ -_@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704191835290.9964@woody.linux -foundation.org>
	<7virbr4p0v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0704211749300.5655@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: David Lang <david.lang@digitalinsight.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 09:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfW5M-0000CS-N8
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 09:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbXDVHCJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 03:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754107AbXDVHCJ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 03:02:09 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:42271 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098AbXDVHCH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 03:02:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422070207.GFHV1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 03:02:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id q7261W0031kojtg0000000; Sun, 22 Apr 2007 03:02:06 -0400
In-Reply-To: <Pine.LNX.4.63.0704211749300.5655@qynat.qvtvafvgr.pbz> (David
	Lang's message of "Sat, 21 Apr 2007 17:51:57 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45223>

David Lang <david.lang@digitalinsight.com> writes:

> in the long run this would let you phase out the core.autocrlf option
> entirely, letting the bahavior be specified in gitattributes.

You _could_, but that is quite against what we want.  These
should stay separate, and the gitattributes mechanism is
designed specifically to allow them cleanly separated.

The configuration "core.autcrlf" describes a particular
repository.  If the platform the repository is on expects text
files to be line-terminated with CRLF, you would have
core.autocrlf set; otherwise you don't.

On the other hand, gitattributes' 'crlf' describes if the path
is text, and that is the reason it can and should be "in-tree",
i.e. not just $GIT_DIR/info/attributes (which is private to the
repository) but in .gitattributes (and subdirectories'), which
is given to everybody who has a copy of the project.

How text files are handled is a local matter, and stays in the
config.  Which ones are text is the same for everybody who has a
copy of the project, and is in-tree information.
