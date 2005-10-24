From: Junio C Hamano <junkio@cox.net>
Subject: Re: User-relative paths
Date: Sun, 23 Oct 2005 18:56:39 -0700
Message-ID: <7vslursmnc.fsf@assigned-by-dhcp.cox.net>
References: <435ABB99.5020908@op5.se>
	<7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se>
	<7v1x2cyplw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510231427230.10477@g5.osdl.org>
	<7v8xwjx2f9.fsf@assigned-by-dhcp.cox.net> <435C3427.30803@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 03:58:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETrZt-0000sv-1A
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 03:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVJXB4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 21:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbVJXB4m
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 21:56:42 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:34755 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750911AbVJXB4l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2005 21:56:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051024015605.SLKF11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Oct 2005 21:56:05 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <435C3427.30803@zytor.com> (H. Peter Anvin's message of "Sun, 23
	Oct 2005 18:08:55 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10524>

"H. Peter Anvin" <hpa@zytor.com> writes:

> If this is meant to dequote shell-quoted paths, it really should be modal.

You are right, but this is not meant to dequote arbitrary shell
quoted paths.  It specifically is for unwrapping what sq_quote()
produced, and refuses to proceed if you feed some shell-valid
but not sq_quote() produced string.  The reason is because it is
part of the git-shell "login shell" -- the input validation is
enforced there.

And the reason it lives next to quote.c::sq_quote() is that you
would hopefully notice sq_dequote() needs matching changes when
you ever update sq_quote.
