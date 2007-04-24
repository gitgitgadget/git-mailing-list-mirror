From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix handle leak in write_tree
Date: Tue, 24 Apr 2007 02:33:48 -0700
Message-ID: <7vps5u86bn.fsf@assigned-by-dhcp.cox.net>
References: <20070423194925.GA5163@steel.home>
	<7vps5u9wsk.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0704240230x3a5b473k5da3d45d9c997c3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 11:33:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgHPH-0001Tp-GQ
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 11:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbXDXJdu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 05:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754622AbXDXJdu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 05:33:50 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:59357 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621AbXDXJdt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 05:33:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070424093349.VSUN1226.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Apr 2007 05:33:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qxZo1W0011kojtg0000000; Tue, 24 Apr 2007 05:33:48 -0400
In-Reply-To: <81b0412b0704240230x3a5b473k5da3d45d9c997c3b@mail.gmail.com>
	(Alex Riesen's message of "Tue, 24 Apr 2007 11:30:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45436>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> ... Isn't such kind of resource control _generally_ nicer to implement
> in the top levels of a program?

In theory perhaps, but my understanding of our use of atexit()
is to clean them up in situations beyond the control of the top
levels of a program, most notably upon exit on signal.
