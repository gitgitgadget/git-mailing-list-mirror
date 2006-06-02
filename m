From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] handle concurrent pruning of packed objects
Date: Fri, 02 Jun 2006 08:53:52 -0700
Message-ID: <7vwtbzblkf.fsf@assigned-by-dhcp.cox.net>
References: <20060602153223.GA4223@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 17:54:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmByI-0006Kd-2p
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 17:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWFBPxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 11:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWFBPxy
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 11:53:54 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:41091 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932496AbWFBPxx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 11:53:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060602155353.JHWI15767.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Jun 2006 11:53:53 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060602153223.GA4223@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 2 Jun 2006 11:32:23 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21165>

Jeff King <peff@peff.net> writes:

> This is a repost, since there was no response last time. Linus
> indicated this approach was reasonable; see:
>   <Pine.LNX.4.64.0605300752430.5623@g5.osdl.org>

I haven't forgotten about it, but I have been sick.

I am uncertain about not re-examining the packs it originally
thought it had.  By prepending the new ones (and the same old
surviving ones) at the beginning you are effectively hiding the
old packs, which sounds reasonable in the usual case.

Also I suspect this might have funny interaction with the case
where there are hand-added packs (see how verify-pack does it).
We do not silently "fix" missing object problems we discover
there.
