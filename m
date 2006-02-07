From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Cogito] Various bugs
Date: Mon, 06 Feb 2006 18:03:13 -0800
Message-ID: <7vfymw3oym.fsf@assigned-by-dhcp.cox.net>
References: <20060131041318.GC30744@diku.dk>
	<20060207003643.GJ31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 03:03:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6ICS-0001Bg-NM
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 03:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWBGCDT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 21:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWBGCDT
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 21:03:19 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:51959 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964924AbWBGCDS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2006 21:03:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060207020043.OMSV26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Feb 2006 21:00:43 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060207003643.GJ31278@pasky.or.cz> (Petr Baudis's message of
	"Tue, 7 Feb 2006 01:36:43 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15675>

Petr Baudis <pasky@suse.cz> writes:

> I'm puzzled. GIT should handle this fine.
>
> 	export GIT_AUTHOR_NAME=''
> 	git-commit-tree $(cg-object-id -t)
>
> works as expected, but for some reason escaping me it does not work
> inside of cg-commit. Insights welcomed.

They probably do not have anything to do with the problem at
hand, but I just noticed your version of pick-author code in
cg-commit lacks two changes I added to git-commit:

 (1) the pick_author_script you have in cg-commit lacks the
     support for names with single-quotes in them
     (aa66c7ec77d474b737da607d6cb2d07f56628def).

 (2) I run the sed script with LANG and LC_ALL set to C locale.
     I think I had some trouble without them with high-bit
     names, (e3e291fc07b49b74bb655ca854bdb19e849e044c) but the
     detail escapes me.
