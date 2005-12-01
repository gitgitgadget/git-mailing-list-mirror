From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: add Update menu item.
Date: Thu, 1 Dec 2005 22:51:41 +1100
Message-ID: <17294.58317.317337.145932@cargo.ozlabs.ibm.com>
References: <20051123222003.GA16290MdfPADPa@greensroom.kotnet.org>
	<20051129211551.GF8383MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 12:53:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehmya-0005dT-C6
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 12:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVLALvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 06:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVLALvp
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 06:51:45 -0500
Received: from ozlabs.org ([203.10.76.45]:26498 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932171AbVLALvp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 06:51:45 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 222CF68867; Thu,  1 Dec 2005 22:51:44 +1100 (EST)
To: skimo@liacs.nl
In-Reply-To: <20051129211551.GF8383MdfPADPa@greensroom.kotnet.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13050>

Sven Verdoolaege writes:

> Update will redraw the commits if any commits have been added to any
> of the selected heads.  The new commits appear on the top.

I put this in although I'm not completely happy with it (though it is
a good step in the right direction).

Why do we unset children and nchildren in the phase == updatecommits
case?  Wouldn't it give the same result if we set ncleft to nchildren
for each commit and then we didn't call updatechildren in
finishcommits?  I think that would end up simpler.

I tried removing some commits (using git reset --hard) and then doing
selecting update from the menu, and it redrew everything, but the
removed commits were still shown.

Also, what will happen if the user selects update while gitk is still
drawing the graph?  I think that will cause havoc.  At _best_ we'll
end up with a truncated list of commits AFAICS.  We need to make that
robust.

Paul.
