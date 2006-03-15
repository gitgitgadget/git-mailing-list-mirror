From: Junio C Hamano <junkio@cox.net>
Subject: Re: seperate commits for objects already updated in index?
Date: Wed, 15 Mar 2006 11:25:04 -0800
Message-ID: <7vlkvbik8f.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603141634010.5276@sheen.jakma.org>
	<Pine.LNX.4.64.0603140856120.3618@g5.osdl.org>
	<Pine.LNX.4.64.0603141703080.5276@sheen.jakma.org>
	<Pine.LNX.4.64.0603140915290.3618@g5.osdl.org>
	<7vwtewk2jp.fsf@assigned-by-dhcp.cox.net>
	<7vy7zcie5c.fsf@assigned-by-dhcp.cox.net> <44181DFE.7080204@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Jakma <paul@clubi.ie>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Mar 15 20:25:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJbcS-0003Dq-Db
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 20:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWCOTZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 14:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWCOTZI
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 14:25:08 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:45311 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751194AbWCOTZG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 14:25:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060315192306.PHZT20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Mar 2006 14:23:06 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <44181DFE.7080204@op5.se> (Andreas Ericsson's message of "Wed, 15
	Mar 2006 15:00:30 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17613>

Andreas Ericsson <ae@op5.se> writes:

> Can't this be done by updating .git/index first and then use the
> temporary index to commit? Then .git/index would match the current
> tree and everybody would be happy with very little tweaking. Doing the
> temporary index commit first could cause data-loss as described above
> if the updating of .git/index somehow fails and the user is unaware of
> it (or what to do to fix it).

You have to think about how to rewind it when the user decides
later not to commit by for example giving an empty commit
message or killing the editor.  The order of things need to be
to populate the index to be committed so that we can give
preview in the commit log template upon 'commit -v', spawn the
editor and get the final version of log, and then make a
commit.  So it may or may not be doable -- I haven't thought
about it through, and currently have not much incentive nor
inclination to think about it myself right now.
