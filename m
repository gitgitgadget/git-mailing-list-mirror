From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make cvsexportcommit work with filenames containing spaces.
Date: Fri, 22 Sep 2006 21:17:04 -0700
Message-ID: <7vvenfw727.fsf@assigned-by-dhcp.cox.net>
References: <20060922223506.3377.34859.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 06:17:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQyx5-0002Rm-Qd
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 06:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWIWERI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 00:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWIWERI
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 00:17:08 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:42178 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750797AbWIWERF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 00:17:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923041705.QDNT2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Sep 2006 00:17:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RgH31V00R1kojtg0000000
	Sat, 23 Sep 2006 00:17:04 -0400
To: Robin Rosenberg <robin.rosenberg@dewire.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27560>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Binary files are except to this so far.

Funny.  This works on my home machine (CVS 1.12.13) while it
does not pass test #2 "with spaces" on another machine that has
CVS 1.11.22.

> +. ./test-lib.sh
> +
> +export CVSROOT=$(dirname $(pwd))/cvsroot
> +export CVSWORK=$(dirname $(pwd))/cvswork

You are creating t/{cvsroot,cvswork} directories.  Do not
contaminate outside the test/trash directory your tests is
started in.

> +rm -rf $CVSROOT $CVSWORK

People's $(pwd) can contain shell $IFS characters, especially on
Cygwin.   Be careful and quote them when in doubt.
