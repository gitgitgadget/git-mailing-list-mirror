From: Junio C Hamano <junkio@cox.net>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 11:29:47 -0800
Message-ID: <7vveyrt6ms.fsf@assigned-by-dhcp.cox.net>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
	<b0943d9e0511160311k725526d8v@mail.gmail.com>
	<7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
	<7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
	<81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>
	<Pine.LNX.4.63.0511171207580.20898@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vsltvwmlr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511171249550.737@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 20:31:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcpSD-0006Dj-L8
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 20:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVKQT3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 14:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVKQT3u
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 14:29:50 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:44687 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964792AbVKQT3t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 14:29:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051117192835.DEQA17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 14:28:35 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12140>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I'd like to wait to have a reaction from other people. I vividly remember 
> my eyes falling out of my sockets when somebody reported success on cygwin 
> without NO_MMAP. If there is *any* cygwin version which fixes it, we 
> should rather make people upgrade, no?

I am not so sure about forcing people upgrade, but we may end up
deciding it is better not to have NO_MMAP as the default.  If
that turns out to be the case, I'd prefer to have something like
this instead:

diff --git a/Makefile b/Makefile
index 7ce62e8..215abf0 100644
--- a/Makefile
+++ b/Makefile
@@ -213,6 +213,10 @@ endif
 ifeq ($(uname_O),Cygwin)
 	NO_STRCASESTR = YesPlease
 	NEEDS_LIBICONV = YesPlease
+	# There are conflicting reports about this.
+	# On some boxes NO_MMAP is needed, and not so elsewhere.
+	# Try uncommenting this if you see things break -- YMMV.
+	# NO_MMAP = YesPlease
 	NO_IPV6 = YesPlease
 	X = .exe
 endif
