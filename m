From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix handle leak in write_tree
Date: Wed, 25 Apr 2007 14:16:58 -0700
Message-ID: <7vslaoupbp.fsf@assigned-by-dhcp.cox.net>
References: <20070423194925.GA5163@steel.home>
	<7vps5u9wsk.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0704240230x3a5b473k5da3d45d9c997c3b@mail.gmail.com>
	<7vps5u86bn.fsf@assigned-by-dhcp.cox.net>
	<20070425205930.GF30061@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 23:17:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgorG-0008Cy-Uk
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 23:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227AbXDYVRA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 17:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754223AbXDYVRA
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 17:17:00 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:56875 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbXDYVQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 17:16:59 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070425211659.DKUS1226.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 25 Apr 2007 17:16:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id rZGy1W00J1kojtg0000000; Wed, 25 Apr 2007 17:16:58 -0400
In-Reply-To: <20070425205930.GF30061@steel.home> (Alex Riesen's message of
	"Wed, 25 Apr 2007 22:59:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45581>

Alex Riesen <raa.lkml@gmail.com> writes:

> Then let the top level call something like
>
>     git_cleanup(struct git_context *);
>
> in its _own_ signal or atexit handlers. If it didn't setup the
> handlers, than perhaps it did want it so (leaving tempfiles behind is
> sometimes done on purpose). Or it _is_ a bug, but then it is clear:
> you have to cleanup, and you do git's part of cleanup with
> git_cleanup.

I would agree that libification would need to go something along
that line.

In the meantime for 1.5.2 stabilization, let's do the minimum
fix of applying your earlier patch.
