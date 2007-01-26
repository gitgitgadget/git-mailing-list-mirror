From: Junio C Hamano <junkio@cox.net>
Subject: Re: Seriously broken "git pack-refs"
Date: Thu, 25 Jan 2007 19:22:27 -0800
Message-ID: <7v7iva4glo.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701251636060.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 26 04:22:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAHfd-00023Y-Ba
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 04:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030643AbXAZDW3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 22:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030645AbXAZDW3
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 22:22:29 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:59090 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030643AbXAZDW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 22:22:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126032228.GGMX3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Thu, 25 Jan 2007 22:22:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FfMW1W00w1kojtg0000000; Thu, 25 Jan 2007 22:21:31 -0500
In-Reply-To: <Pine.LNX.4.64.0701251636060.25027@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 25 Jan 2007 16:51:21 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37793>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The default for "git pack-refs" is to pack just tags. Which is a HORRIBLE 
> MISTAKE. Becuase it means that if you actually had any packed non-tags, 
> they now get removed entirely.
>
> I'd call whoever made that decision a complete crack-addict and total 
> idiot, but it might be me, so I'll just tread carefully and call the 
> choice "interesting".

Guilty as charged, I guess (I haven't asked 'blame' about it but
I am reasonably sure it was me).  And thanks for catching it.

But I think "only packing tags" is a reasonable default, as
local branch heads are meant to be advanced, and remote tracking
branches follow whatever happens on the remote end upon every
fetch.  Tags on the other hand are meant to be stationary.

What was a HORRIBLE MISTAKE was not repacking what came out of
the pack if it was pruned.
