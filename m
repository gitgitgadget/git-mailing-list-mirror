From: Junio C Hamano <junkio@cox.net>
Subject: Solaris cloning woes partly diagnosed
Date: Sun, 02 Apr 2006 03:41:51 -0700
Message-ID: <7vy7yol0nk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 02 12:42:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ01t-0001A7-UI
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 12:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWDBKly (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 06:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWDBKly
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 06:41:54 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:43961 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932309AbWDBKlx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Apr 2006 06:41:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060402104152.PXYA20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Apr 2006 06:41:52 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18264>

This is just an interim report, but people might have heard that
OpenSolaris team are in the process of choosing a free DSCM and
we are one of the candidates.  They initially wanted to try
1.2.4 but had trouble using it for local cloning, and the
evaluation is being done with 1.2.2.

I was on #git tonight with Oejet, and managed to reproduce this
problem. The local clone problem seems to disappear if we
disable the progress bar in pack-objects.

We do two funky things when we have progress bar.  We play games
with timer signal (setitimer(ITIMER_REAL) and signal(SIGALRM)),
and we spit out messages to stderr.

It's too late tonight for me to continue digging this, but if
somebody with access to a Solaris box is so inclined, I'd really
appreciate help on this one.
