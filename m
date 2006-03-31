From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] cvsimport: use git-update-ref when updating
Date: Fri, 31 Mar 2006 02:32:30 -0800
Message-ID: <20060331103230.GB15159@hand.yhbt.net>
References: <Pine.LNX.4.63.0603301405160.18852@wbgn013.biozentrum.uni-wuerzburg.de> <7vk6ab1iy2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0603311207270.20122@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 31 12:32:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPGvi-00050K-4x
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 12:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWCaKcb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 05:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWCaKcb
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 05:32:31 -0500
Received: from hand.yhbt.net ([66.150.188.102]:4299 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751282AbWCaKcb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Mar 2006 05:32:31 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 5F6E52DC035; Fri, 31 Mar 2006 02:32:30 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0603311207270.20122@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18225>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Thu, 30 Mar 2006, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > This simplifies code, and also fixes a subtle bug: when importing in a
> > > shared repository, where another user last imported from CVS, cvsimport
> > > used to complain that it could not open <branch> for update.
> > 
> > The second hunk look sensible but I do not know about "use Fcntl"
> > since I do not see anything you are adding that starts to use it...
> 
> O_EXCL. Without "use Fcntl;" perl says I am not allowed to use bareword 
> things in strict mode or some such.

Huh?  I still don't see where O_EXCL is used.

> > > +       system("git-update-ref refs/heads/$branch $cid") == 0

Passing args to system() in list form is always preferable in case
there's a shell-unfriendly variable:

	system("git-update-ref", "refs/heads/$branch", $cid) == 0

-- 
Eric Wong
