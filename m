From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 02:06:25 -0700
Message-ID: <7v1wjsdwj2.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	<Pine.LNX.4.64.0703131757080.9690@woody.linux-foundation.org>
	<7vveh4hapk.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703140119s4691211bw8a5ef3ba25c5cbdf@mail.gmail.com>
	<7vfy88dwvw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 10:06:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRPRd-0003KK-PC
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 10:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbXCNJG2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 05:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965360AbXCNJG2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 05:06:28 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:61526 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965217AbXCNJG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 05:06:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314090626.CMQD3546.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 05:06:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aZ6R1W0031kojtg0000000; Wed, 14 Mar 2007 05:06:25 -0400
In-Reply-To: <7vfy88dwvw.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 14 Mar 2007 01:58:43 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42188>

Junio C Hamano <junkio@cox.net> writes:

> I've been telling you since the #git session that I know that is
> *different* from how "diff" works, and I think everybody agrees
> if we were doing git from scratch today we would have done exit
> status with 0/1/other to signal no-change, have-diff and error.
>
> But the established way for scripts that use plumbing is
>
>  - to check error with $? (or ... || )
>  - to check modified-or-not with output
>
> and people who have been learning from the scripts (we used to
> have lot more scripts) would have picked up that pattern.
> That's why I already told you that --exit-status is the right
> thing to do if we were doing it from scratch, but is a wrong
> thing to do at this point.

Correction.

s/--exit-status is/doing --exit-status without such an explicit option is/.

> Maybe in a release as big as 1.5.0
> that we pre-announce a lot of interface changes.
>
> In short, Linus is right in that the current exit code is not
> useful to see what the end users are interested in (and they are
> not in the business of debugging git, and diff would error out
> only when the repository has problems, perhaps a corrupt object
> or something like that).  But being not useful and being
> currently not relied upon are two different things.
>
> And I am being conservative, especially after a big release.
