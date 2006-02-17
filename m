From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: reuse data from existing pack.
Date: Thu, 16 Feb 2006 20:30:40 -0800
Message-ID: <7vu0ay8v4f.fsf@assigned-by-dhcp.cox.net>
References: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net>
	<7vbqx8m62q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Feb 17 05:30:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9xGY-0008VY-Vi
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 05:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWBQEao (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 23:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWBQEao
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 23:30:44 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:8132 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751239AbWBQEan (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 23:30:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060217042910.IKKS6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Feb 2006 23:29:10 -0500
To: git@vger.kernel.org
In-Reply-To: <7vbqx8m62q.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 15 Feb 2006 17:43:25 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16326>

Junio C Hamano <junkio@cox.net> writes:

> When generating a new pack, notice if we have already the wanted
> object in existing packs.  If the object has a delitified
> representation, and its base object is also what we are going to
> pack, then reuse the existing deltified representation
> unconditionally, bypassing all the expensive find_deltas() and
> try_deltas() routines.

This one has one nasty data corruption bug, which fortunately I
think I have figured out how to fix.  Please do not use it for
your production repository in the meantime.
