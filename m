From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rss produced by git is not valid xml?
Date: Sat, 19 Nov 2005 02:31:22 -0800
Message-ID: <7v7jb57wud.fsf@assigned-by-dhcp.cox.net>
References: <200511181833.40048.ismail@uludag.org.tr>
	<200511182127.06958.ismail@uludag.org.tr>
	<20051118200217.GA2831@vrfy.org>
	<200511182208.24248.ismail@uludag.org.tr>
	<Pine.LNX.4.64.0511181220350.13959@g5.osdl.org>
	<20051118205513.GA3168@vrfy.org>
	<Pine.LNX.4.64.0511181314470.13959@g5.osdl.org>
	<Pine.LNX.4.64.0511181338460.13959@g5.osdl.org>
	<437E51EB.7050100@zytor.com>
	<Pine.LNX.4.64.0511181520390.13959@g5.osdl.org>
	<7vek5deam6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511181653191.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 11:32:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdQ0T-0003YE-Aq
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 11:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbVKSKbZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 05:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbVKSKbZ
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 05:31:25 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:18896 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750997AbVKSKbY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 05:31:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051119103021.DXUS26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 19 Nov 2005 05:30:21 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12326>

Linus Torvalds <torvalds@osdl.org> writes:

> Although right now "-u" doesn't actually _force_ a conversion: if you have 
> an email with 8-bit characters and no character set mentioned, it will 
> silently just do nothing, and the end result won't be valid UTF-8 after 
> all.

... unless it was already utf8, that is.  I have received a
couple of patches with charset=utf-8; I think cte of them were
qp, which was a bit unpleasant.

> If we want utf-8, we should probably force it, and default to the latin1 
> translation (with some way to specify alternatives).

Well, some people on the list seem to think UTF-8 is the one and
only right encoding, so for them if the message does not
identify what it is in, assuming UTF-8 and not doing any
conversion is probably the right thing ;-).

This suggests a few flags (config items) to mailinfo:

    (1) if we pass thru the input intact or not (1 bit);

    (2) what charset to assume if the mail does not identify
        itself (default to latin1; specify "barf" to mean abort
        processing if a message with 8-bit character does not
        identify itself);

    (3) what we do when the mail does not transliterate
        correctly (1 bit -- fail, or remove offending bytes and
        pretend things are peachy -- defaulting on the stricter
        side);
