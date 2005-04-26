From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] diff-cache buglet
Date: Tue, 26 Apr 2005 10:56:10 -0700
Message-ID: <7vy8b5o211.fsf@assigned-by-dhcp.cox.net>
References: <7v7jippjky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504261005360.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 19:56:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQUHa-0002ze-H8
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 19:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVDZR7w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 13:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVDZR55
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 13:57:57 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:14512 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261746AbVDZR4k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 13:56:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050426175610.KFOU22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 26 Apr 2005 13:56:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504261005360.18901@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 26 Apr 2005 10:11:19 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I'm ok with that, but if so I think it should show the stage somehow, and
LT> make it clear that it's unmerged. Maybe by appending something to the name
LT> (maybe just a ':' and stage number, but I'd almost prefer the stage number
LT> to be translated into something human-readable, so maybe we could have
LT> something like

LT> 	filename.c^orig
LT> 	filename.c^first
LT> 	filename.c^second

LT> for stages 1-3 respectively)?

I'm the one who has been trying very hard to keep the output
machine readable (remember? many of the -z flags are mine).

While I agree with you that we should somehow show the stage, I
do not like your suggestion above very much.  How about adding
one column for stage number before the filename when --unmerged
is given, just like show-files --stage shows?  You'd soon get
used to the pattern that has a single digit in between
whitespaces to recognize which is merged and which isn't.
E.g. this is from show-files --stage:

    100644 b258508afb7ceb449981bd9d63d2d3e971bf8d34 1 MM
    100644 b431b272d829ff3aa4d1a5085f4394ab4d3305b6 2 MM
    100644 19989d4559aae417fedee240ccf2ba315ea4dc2b 3 MM
    100644 a716d58de4a570e0038f5c307bd8db34daea021f 0 MN

Another thing I'd like to rectify is that show-files use a space
while diff-tree and friends use a tab in between columns.  Is it
too late to standardize one way or the other?  My vote goes to
a space.

