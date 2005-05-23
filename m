From: Junio C Hamano <junkio@cox.net>
Subject: Comments on "Rename/copy detection fix."
Date: Sun, 22 May 2005 21:38:54 -0700
Message-ID: <7vvf5aa74x.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
	<7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
	<7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
	<20050522184237.GG18500@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505221203410.2307@ppc970.osdl.org>
	<7v64xbdq4y.fsf@assigned-by-dhcp.cox.net>
	<7vy8a7cavf.fsf@assigned-by-dhcp.cox.net>
	<7vd5ribmam.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 23 06:38:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Da4hG-0005EV-6X
	for gcvg-git@gmane.org; Mon, 23 May 2005 06:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVEWEi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 00:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVEWEi7
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 00:38:59 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:40944 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261842AbVEWEi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 00:38:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050523043854.UCAN12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 00:38:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vd5ribmam.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 22 May 2005 21:26:09 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I talked about patch reordering in the commit log without giving
specifics, because I did not think it is good to cast specifics
of uncoded ideas into stone in a commit log message.

But to throw it out open in the public, here are two of the
obvious ones.

 (1) Give users a way to specify patches about which files
     should come before which other files.  Things like "*.h
     files before *.c files", or "README and Documentation first
     before anything else".

 (2) Currently when pickaxe is used, it shows only diffs about
     the files involved in the change we looked for.  The user
     may sometimes want to see such a diff in the context of
     whole patches and I plan to add an option for doing so.  It
     may be useful in such a case to show the patch about the
     file that triggered the commit to be selected by the
     pickaxe first before patches for all other files.

These may or may not be useful, but this kind of reordering
would make it pretty much pointless to record which is a rename
and which is a copy in the diff_filepair structure in the
diff_queue.  It all depends on which one comes first and which
one comes later in the final ordering, which is something
diffcore-rename cannot (and should not) know about.


