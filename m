From: Junio C Hamano <junkio@cox.net>
Subject: Re: Clueless bisect error message
Date: Wed, 11 Oct 2006 01:11:42 -0700
Message-ID: <7v1wpfuv9d.fsf@assigned-by-dhcp.cox.net>
References: <fcaeb9bf0610110008g642da719pb17f7f52169097e2@mail.gmail.com>
	<7vpsczuxj9.fsf@assigned-by-dhcp.cox.net>
	<fcaeb9bf0610110050h4c3a56fbge19607ff0bc094af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 10:12:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXZBr-0007ru-TS
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 10:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWJKILo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 04:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbWJKILo
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 04:11:44 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:8176 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1161022AbWJKILn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 04:11:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061011081143.CKGL26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Oct 2006 04:11:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YwBl1V00V1kojtg0000000
	Wed, 11 Oct 2006 04:11:46 -0400
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
In-Reply-To: <fcaeb9bf0610110050h4c3a56fbge19607ff0bc094af@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Wed, 11 Oct 2006 14:50:28 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28702>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

>> By looking at commit 810255f, however, I suspect that fix would
>> break Cogito.  The wording of the message actually comes from
>> Cogito nomenclature.
> Ah. I forgot to say I'm using git 1.4.2.1. My only wish is not a fix
> (unless it's a trivial fix) but that bisect should explain the
> situation better and guide people to fix it. I had grepped bisect man
> page for "seeked tree" and was still clueless.

My point actually was that even a simple rewording is harder
than it seems, because that cluelessness actually was introduced
to help Cogito.  If we do not care about it, we can just reword
it to say "Hey you are in the middle of another bisect, or maybe
you left your bisect by doing git-checkout earlier?  In either
case git-bisect --reset is your friend, oh, and we can run that
for you now if you want".  We could even remove head-name in
git-checkout when we see one.

But I suspect that doing either of these things would harm
Cogito users.  After cg-seek the user is not "in the middle of
another bisect", and if we run "git bisect --reset" when we see
head-name, it would probably break it too.
