From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 09 Aug 2007 20:48:41 -0700
Message-ID: <7v643ovyli.fsf@assigned-by-dhcp.cox.net>
References: <20070809163026.GD568@mbox.bz>
	<alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
	<7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net>
	<7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
	<20070809165218.9b76ebf7.seanlkml@sympatico.ca>
	<alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091444550.25146@woody.linux-foundation.org>
	<7vtzr8wemb.fsf@assigned-by-dhcp.cox.net>
	<7vps1wwa5w.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0708091734210.25146@woody.linux-foundation.org>
	<7vhcn8w6sw.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0708091754150.25146@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 05:48:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJLUd-0005eg-3u
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 05:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbXHJDsq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 23:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbXHJDsq
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 23:48:46 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:55032 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbXHJDsp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 23:48:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070810034841.KREJ26965.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 9 Aug 2007 23:48:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id a3oh1X0061kojtg0000000; Thu, 09 Aug 2007 23:48:42 -0400
In-Reply-To: <alpine.LFD.0.999.0708091754150.25146@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 9 Aug 2007 17:57:45 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55504>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> (I didn't test it, though, maybe I missed something).

I do not think the change affects the normal codepath.  The
one-liner patch to git-commit.sh touches the codepath that
updates the index used only to write out the partial commit, and
losing the cached stat info from that index does not matter, as
that index is removed immediately after writing the tree out and
is never compared with working tree as far as I can tell.
