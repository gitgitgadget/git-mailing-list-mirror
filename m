From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support username and password inside URL
Date: Sun, 20 Nov 2005 12:21:53 -0800
Message-ID: <7vwtj3xe72.fsf@assigned-by-dhcp.cox.net>
References: <87u0e71zpx.fsf@litku.valo.iki.fi>
	<873blriqh0.fsf@litku.valo.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 21:22:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdvhR-0004xa-Oo
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 21:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVKTUV4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 15:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVKTUVz
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 15:21:55 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:7346 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750776AbVKTUVz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 15:21:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051120202050.TEAR26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 20 Nov 2005 15:20:50 -0500
To: Kalle Valo <Kalle.Valo@iki.fi>
In-Reply-To: <873blriqh0.fsf@litku.valo.iki.fi> (Kalle Valo's message of "Sun,
	20 Nov 2005 12:05:47 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12397>

Kalle Valo <Kalle.Valo@iki.fi> writes:

> Currently usage of curl was so that netrc was mandatory and passwords in URL
> weren't allowed. Change netrc to optional to make HTTP basic authentication
> with username and password in URL also work.

HTTP "basic"?  Let's at least say "digest" for starters ;-).

I am modestly against letting users use auth-embedding URLs, and
fairly strongly against encouraging users to do so.

It is handy to have weak "authentication" in some situations.  I
am not ashamed to admit that I've used security-by-obscurity
myself, when I sent an email to a friend, saying:

        Hi, I have some pictures I took during our last trip
        together, but due to their size I am not attaching them
        to this e-mail.  Please pick them up at:

	        http://members.cox.net/junkio/r0ZIEF/5S54m/

        Please drop me a note after picking them up, so that I
        can clean-up the directory.

Auth-embedding URLs are about as secure as the above URL, but it
is worse because they may tempt you to reuse the same username
password pair for other purposes later.

If you are using the password protected URL yourself, I'd
imagine having them in your netrc would not be such a big deal,
so I suspect your expected usage is not for yourself, but more
like giving a temporary, even one-shot, access to others like
the above example, and making it more convenient for them (even
in that case, if it is not one-shot but for repeated use, I'd
imagine it would not be such a big deal to ask them to do
appropriate netrc).  If that is what is going on here, then
IMNSHO it would be better to make it clear that you are doing
security-by-obscurity by not using username password pair, which
makes you pretend that you are doing _some_ security.
