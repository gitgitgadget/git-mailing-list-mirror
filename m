From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Fri, 03 Aug 2007 14:50:15 -0700
Message-ID: <7v1wekmgo8.fsf@assigned-by-dhcp.cox.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021050500.14781@racer.site>
	<vpqbqdq45ua.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021147110.14781@racer.site>
	<AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca>
	<Pine.LNX.4.64.0708021541520.14781@racer.site>
	<46B1F3F4.5030504@midwinter.com>
	<Pine.LNX.4.64.0708021614420.14781@racer.site>
	<20070803053717.GA16379@midwinter.com>
	<7v3az1qgdg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708031121000.14781@racer.site>
	<7vir7wmk84.fsf@assigned-by-dhcp.cox.net>
	<vpqps24i9sx.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Jean-Francois Veillette <jean_francois_veillette@yahoo.ca>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 23:50:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH52L-000369-L4
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 23:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762101AbXHCVuS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 17:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762003AbXHCVuR
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 17:50:17 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:49720 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761605AbXHCVuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 17:50:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070803215014.VVEQ23215.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 3 Aug 2007 17:50:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XZqE1X00g1kojtg0000000; Fri, 03 Aug 2007 17:50:15 -0400
In-Reply-To: <vpqps24i9sx.fsf@bauges.imag.fr> (Matthieu Moy's message of "Fri,
	03 Aug 2007 23:32:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54765>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Also, is there any particular reason not to update the index stat
> information when files are found to be identical?

Very much --- diff is a read-only operation.

"git-status $args" on the other hand is a preview of "what would
happen if I say 'git-commit $args'", and in order to compute
that, you would fundamentally need to be able to write into the
object store.  In a special case of giving empty $args it can be
read-only.  The commit Dscho quoted earlier was to hack that
around so that "git-status" can pretend to be a read-only
operation in a repository you do not have write permission to.
