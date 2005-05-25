From: Junio C Hamano <junkio@cox.net>
Subject: Re: change of git-diff-tree and symlinks
Date: Wed, 25 May 2005 12:40:51 -0700
Message-ID: <7vzmujjdq4.fsf@assigned-by-dhcp.cox.net>
References: <20050525111711.GA27492@vrfy.org>
	<Pine.LNX.4.58.0505251054110.2307@ppc970.osdl.org>
	<20050525183546.GA4241@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 21:42:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db1iq-000597-8D
	for gcvg-git@gmane.org; Wed, 25 May 2005 21:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVEYTk7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 15:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVEYTk6
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 15:40:58 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:61083 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261206AbVEYTkx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 15:40:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525194050.DRHZ19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 15:40:50 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050525183546.GA4241@vrfy.org> (Kay Sievers's message of
 "Wed, 25 May 2005 20:35:46 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:

KS> Ok, works again. Any reason not to mark it as 'M'? It's easyly to
KS> distinguish between a content change and a mode change by looking if
KS> the sha has changed.

I'd need some time to think about this in the evening (I'm at
work now) but I think Linus did '?' as an interim measure.  I
suspect 'M' would work just as well without introducing a new
class 'T', but on the other hand having them distinct would be
easier for people who read diff-raw format, so my knee-jerk
reaction is that we should use 'T'.  It's the same reasoning to
have N, D, and U --- they can be gleaned by looking at mode and
sha fields and there is no need to mark them any differently but
surely marking them the way we do now is much nicer.

More importantly I need to double check that diffcore stuff
including rename/copy are doing the right thing about type
changes.  If some of them are throwing type-change pair away
under certain obscure conditions, then tweaking the part Linus
added the '?' is too late to remedy the situation.

