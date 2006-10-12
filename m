From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff: fix 2 whitespace issues
Date: Thu, 12 Oct 2006 09:40:33 -0700
Message-ID: <7v4pu9pjwe.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0610121418180.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 18:41:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY3bq-0007en-8N
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 18:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbWJLQkf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 12:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbWJLQkf
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 12:40:35 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:41353 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932674AbWJLQke (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 12:40:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061012164033.OKGL12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Oct 2006 12:40:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ZUgP1V0011kojtg0000000
	Thu, 12 Oct 2006 12:40:23 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610121418180.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 12 Oct 2006 14:22:14 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28788>

I noticed this breakage sometime last week and it was sitting at
near the bottom of my stack of things to look at.  Ray's
bugreport and your fix were quite timely.  Thanks.

You mentioned six whitespace problems but I counted only three
and the test failed on "CR at the end"; the test vector was easy
to hand-fix thanks to the "index" line.

This patch is an example that we do not want to transmit files
that has CRs in e-mail.  These CRs appear in format-patch
output, so either the user needs to do --attach (and perhaps the
option needs to do base64 or qp in such a case) or format-patch
needs to treat a blob with CR as binary and emit binary diff?
The latter is not appropriate since patches apply just fine with
CR in them.
