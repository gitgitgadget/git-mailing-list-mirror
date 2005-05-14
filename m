From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] Ignore rules
Date: Sat, 14 May 2005 11:12:16 -0700
Message-ID: <7vsm0py8vz.fsf@assigned-by-dhcp.cox.net>
References: <4283CAF8.3050304@dgreaves.com>
	<20050513231229.GI32232@pasky.ji.cz> <4285B6A8.4080309@dgreaves.com>
	<7vy8ai2nb6.fsf@assigned-by-dhcp.cox.net>
	<20050514142421.GG3905@pasky.ji.cz> <42861584.6020601@dgreaves.com>
	<20050514153027.GN3905@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Greaves <david@dgreaves.com>, torvalds@osdl.org,
	GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 20:12:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DX17l-0004Ac-Ih
	for gcvg-git@gmane.org; Sat, 14 May 2005 20:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVENSMX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 14:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVENSMX
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 14:12:23 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:51954 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261451AbVENSMS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 14:12:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514181218.VJFB16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 May 2005 14:12:18 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050514153027.GN3905@pasky.ji.cz> (Petr Baudis's message of
 "Sat, 14 May 2005 17:30:27 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Here, I would like more people to speak up, plaese, especially the
PB> authors of other layers over git than Cogito, since I think it'd be
PB> great if we could agree on common ignore rules format and we could just
PB> call the files ".gitignore" instead of ".cgignore", ".jitignore" etc.

Purely off the top of my head, without even regurgitating what
you wrote in the message I am responding to (sorry, I am about
to leave for the day).

 * Two lists, one propagated with merges and another repository
   private one.

 * GIT_DIR/info/ignore is the one propagated with merge but it
   is not a list itself.  It records the name of a file that is
   GIT tracked.  GIT_DIR/ignore is the repository private one.

 * Repository private one and then merge propagated one are read
   in order, one line at a time.  The first hit determines
   whether it is taken or ignored.

 * Each entry in the list is not a shell glob but a regexp.  The
   ignore list rarely changes, so more expressiveness with a bit
   higher learning curve and a bit more typing would not hurt
   much.  The entry is implicitly anchored at the left and
   matched against the path relative to what is recorded in
   GIT_INDEX_FILE (so 'Makefile' matches "Makefile" in
   linux-2.6.git/ but not "fs/Makefile").  The regexp can
   optionally prefixed with a '!' to mean negation.  A line that
   starts with a '#' is a comment.

