From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Sat, 04 Aug 2007 01:01:23 +0200
Message-ID: <vpqir7wi5oc.fsf@bauges.imag.fr>
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
	<7v1wekmgo8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steven Grimm <koreth@midwinter.com>,
	Jean-Francois Veillette <jean_francois_veillette@yahoo.ca>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 01:02:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH69l-0004fX-R6
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 01:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763577AbXHCXB5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 19:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762850AbXHCXB5
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 19:01:57 -0400
Received: from imag.imag.fr ([129.88.30.1]:57904 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762209AbXHCXB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 19:01:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l73N1Nti010237
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 4 Aug 2007 01:01:26 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IH695-0001uD-HK; Sat, 04 Aug 2007 01:01:23 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IH695-00067R-El; Sat, 04 Aug 2007 01:01:23 +0200
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, Steven Grimm <koreth@midwinter.com>, Jean-Francois Veillette <jean_francois_veillette@yahoo.ca>, git@vger.kernel.org
In-Reply-To: <7v1wekmgo8.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Fri\, 03 Aug 2007 14\:50\:15 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 04 Aug 2007 01:01:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54766>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Also, is there any particular reason not to update the index stat
>> information when files are found to be identical?
>
> Very much --- diff is a read-only operation.
>
> "git-status $args" on the other hand is a preview of "what would
> happen if I say 'git-commit $args'", and in order to compute
> that, you would fundamentally need to be able to write into the
> object store.  In a special case of giving empty $args it can be
> read-only.

Can you give an example where it _could_ not be read-only?

> The commit Dscho quoted earlier was to hack that around so that
> "git-status" can pretend to be a read-only operation in a repository
> you do not have write permission to.

I really, really, really, don't understand your argument.

There are two different concepts:

* Should git-diff be "read-only for the user"?
  (i.e. external specification)

* Should git-diff be actually read-only for the filesystem?
  (i.e. implementation)


"read-only for the user" is a user-interface thing. It just means that
running

$ git-diff >& /dev/null; whatever

will give the same result as

$ whatever

In another context, "cat", for example, is a read-only operation for
the user. I can run "cat whatever-file" without influencing the
behavior of subsequent operations. Now, somewhere in the kernel of my
OS, I do hope that reading this file will have side-effects (putting
the file in the cache, and why not decide to physically move the file
on disk).


Here, obviously, git-diff is a read-only operation for the user. I
don't expect git-diff to modify the behavior of subsequent commands,
but I appreciate if git-diff can improve the speed of subsequent
commands.

Now, both of us agree that git-status should not be read-only for the
filesystem, both of us agree that git-diff should be read-only for the
user, but we disagree on the two other cases.

In the same way, I expect git-status to be read-only for the user. You
say "what _would_ happen _if_ I say commit $args". But you don't
commit, the sentence is conditionnal. I don't expect any tool to have
visible side-effects when I say "what would happen if ...".

-- 
Matthieu
