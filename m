From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fetch-pack should not ask for a ref which is already there
Date: Thu, 29 Sep 2005 02:14:28 -0700
Message-ID: <7vhdc4grrf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509290149230.19126@wgmdd8.biozentrum.uni-wuerzburg.de>
	<7vll1gl4ms.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509291034450.20717@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 11:14:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKuV7-0000pY-VD
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 11:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVI2JOa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 05:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVI2JOa
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 05:14:30 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:15612 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751184AbVI2JO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 05:14:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050929091425.BSCU29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Sep 2005 05:14:25 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0509291034450.20717@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 29 Sep 2005 10:42:32 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9480>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Yeah, sorry. I did not test that one. Maybe an automated test for 
> git-fetch-pack would be useful after all...

Sounds sensible.  I think git-send-pack has one.

> How about the following? (I avoided an ugly goto, but had to duplicate 
> code :-( )

I suspect it would be cleaner to return (struct ref *) from
fetch_pack (ideally use NULL to signal failure but there is no
need -- it just dies) and print the refs from main() only after
seeing the last close and finish_connect succeed.
