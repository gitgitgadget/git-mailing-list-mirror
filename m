From: Junio C Hamano <junkio@cox.net>
Subject: Re: Multiple pulls from the same branch in .git/remotes/origin
Date: Mon, 07 Aug 2006 11:28:08 -0700
Message-ID: <7vd5bc4czr.fsf@assigned-by-dhcp.cox.net>
References: <20060727140343.GS9411@mellanox.co.il>
	<20060807125116.GA28658@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 20:29:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA9pn-0006ze-BO
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 20:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWHGS2M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 14:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWHGS2M
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 14:28:12 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:43686 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932280AbWHGS2L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 14:28:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060807182809.WHRO554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Aug 2006 14:28:09 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20060807125116.GA28658@mellanox.co.il> (Michael S. Tsirkin's
	message of "Mon, 7 Aug 2006 15:51:16 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25024>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> I get remote linus_master properly fetched into local origin.
> Two questions:

> 1. Isn't is possible to pull from the same remote branch into multiple local
>    branches?

Currently, no.  The underlying git-fetch-pack makes sure you do
not give the same branches twice on the command line.  I think
what the code actually tries to do is to make sure each of the
given refspecs is not ambiguous and matches something, but while
doing so it marks the remote ref that matched ineligible to
match again, which ends up showing the error message you saw.

It might not be too difficult to change it though.  This part of
the code is relatively old and I do not remember the details
offhand, other than I remember that the first time I saw it I
had the same confused "Huh?  we do not let a ref fetched twice?"
reaction ;-).
