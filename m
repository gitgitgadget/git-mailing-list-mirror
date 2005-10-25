From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to clone faster via ssh ?
Date: Tue, 25 Oct 2005 10:17:20 -0700
Message-ID: <7vbr1dh5y7.fsf@assigned-by-dhcp.cox.net>
References: <200510251449.15302.lan@ac-sw.com>
	<200510251454.35202.lan@ac-sw.com>
	<Pine.LNX.4.63.0510251103110.24174@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 19:20:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUSQx-00026O-3M
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 19:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVJYRRX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 13:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVJYRRW
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 13:17:22 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:62630 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932218AbVJYRRW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 13:17:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051025171651.DKOU29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Oct 2005 13:16:51 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510251103110.24174@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 25 Oct 2005 11:04:33 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10600>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 25 Oct 2005, Alexander Litvinov wrote:
>
>> Forgot to tell:
>> clone via ssh was made using this command:
>> time git-clone -n ssh://lan@lan/home/lan/tmp/git/billing/repo r3
>
> If you have a working git on the other side, you could do
>
> 	time git-clone lan@lan:/home/lan/tmp/git/billing/repo r3
>
> which would utilize git-clone-pack. Way faster.

I think both of these notations do the same.

The time to unpack the resulting pack on this end is eliminated
if you use git from last week, namely this commit:

commit e1c7ada6dd1fdf249d0bb84f3293d3be768b9239
Author: Junio C Hamano <junkio@cox.net>
Date:   Wed Oct 19 14:43:43 2005 -0700

    git-clone: always keep pack sent from remote.

    This deprecates --keep and -q flags and always keeps the
    pack
    sent from the remote site.  Corresponding configuration
    variables are also removed.

    Signed-off-by: Junio C Hamano <junkio@cox.net>

But you would still pay for creating a pack on the remote side.
