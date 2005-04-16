From: Junio C Hamano <junkio@cox.net>
Subject: Re: using git directory cache code in darcs?
Date: Sat, 16 Apr 2005 07:28:00 -0700
Message-ID: <7vacny94pb.fsf@assigned-by-dhcp.cox.net>
References: <20050416132231.GJ2551@abridgegame.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, darcs-devel@darcs.net
X-From: darcs-devel-bounces@darcs.net Sat Apr 16 16:25:19 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMoEK-0000er-3g
	for gcvdd-darcs-devel@m.gmane.org; Sat, 16 Apr 2005 16:25:04 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DMoHn-0004lk-Pw; Sat, 16 Apr 2005 10:28:39 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28])
	by abridgegame.org with esmtp (Exim 4.50) id 1DMoHk-0004kj-JF
	for darcs-devel@darcs.net; Sat, 16 Apr 2005 10:28:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172]) by fed1rmmtao11.cox.net
	(InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP id
	<20050416142801.BUZ22013.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
	Sat, 16 Apr 2005 10:28:01 -0400
To: David Roundy <droundy@abridgegame.org>,
In-Reply-To: <20050416132231.GJ2551@abridgegame.org> (David Roundy's message
	of "Sat, 16 Apr 2005 09:22:36 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net

>>>>> "DR" == David Roundy <droundy@abridgegame.org> writes:

DR> 1) Would this actually be a good idea?

I think it is sensible, especially if you are doing a lot of
comparison between the working area and the pristine.

DR> 3) Is it likely that git will switch to not using global
DR> variables for active_cache, active_nr and active_alloc?

DR> 4) Would there be interest in creating a libgit?

These are related.  I have seen some people interested in
libifying it, and encapsulating those globals would naturally
fall out of it.  My impression from the list however is that a
lot more people are interested in the upper SCM layer than the
git layer right now.  And git layer, although solid enough to
host itself, is still slushy.  A couple of days ago dircache
format was changed from host to network endian.  Last night
Linus made another change to dircache format, which fortunately
is upward compatible if you stay within pathnames shorter than
2^12 bytes ;-).  Another problem I see for somebody to pick up
and start libifying things right now is that, although there is
one central person on the SCM side (Petr Baudis), git layer is
still fractured between Linus and Petr.

Petr syncs with Linus often and he seems to be doing a good job
at keeping track of public patches, but the git layer Linus
works on does not have some patches Petr collected or wrote
himself.  In time, a better coordination would emerge, of
course, but the project is still young at this moment.  Stay
tuned ;-).
