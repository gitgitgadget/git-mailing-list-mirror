From: Junio C Hamano <junkio@cox.net>
Subject: Re: git bug?
Date: Thu, 09 Jun 2005 01:15:41 -0700
Message-ID: <7vmzq0osia.fsf@assigned-by-dhcp.cox.net>
References: <42A7E7AD.5030108@pobox.com>
	<7vy89kq96o.fsf@assigned-by-dhcp.cox.net>
	<7vzmu0otg8.fsf@assigned-by-dhcp.cox.net> <42A7F769.2050800@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 11:16:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgI8r-0005uH-Ho
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 10:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVFIIPy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 04:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbVFIIPy
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 04:15:54 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51647 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262324AbVFIIPn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2005 04:15:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609081541.FCXU8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Jun 2005 04:15:41 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42A7F769.2050800@pobox.com> (Jeff Garzik's message of "Thu, 09
 Jun 2005 04:01:45 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JG" == Jeff Garzik <jgarzik@pobox.com> writes:

JG> 'git-diff-cache -p HEAD' should not show files that I have not modified.
JG> This screws up
JG> 	git-diff-cache -p HEAD | diffstat -p1 | awk '{print $1}'
JG> for example.

Agreed 100%.  If there is a file exists (rather, if the git
thinks the file is there), then diff-cache should not say it is
deleted.  That would be wrong.

Sorry for not having a crystal ball to poke into your terminal,
so let me get something straight.  I am still unsure the problem
you are reporting is coming from diff-cache bug, or somehow
yesterday's (well it is 01:13AM where I sit ;-)) merge updates
trashed your work tree or index file, so these questions would
help me tell which.  When "diff-cache" reports the file
"deleted":

 - Do you have that arch/arm/mm/minicache.c file in your working
   directory?

 - Does git-ls-files know about the file?  Does the path show in:
   git-ls-files --stage | grep arch/arm/mm/minicache.c

 - Does the HEAD tree have the path as well?  Does it show in:
   git-ls-tree -r HEAD | grep arch/arm/mm/minicache.c


