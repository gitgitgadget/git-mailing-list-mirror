From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2 (fix broken test)] rebase -i: add exec command to launch a shell command
Date: Thu, 12 Aug 2010 09:47:41 +0200
Message-ID: <vpq4of0l1b6.fsf@bauges.imag.fr>
References: <vpq62ziv788.fsf@bauges.imag.fr>
	<1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
	<7v62zhyp9e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 09:48:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjSWE-0008M8-7n
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 09:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758789Ab0HLHr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 03:47:59 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38734 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754369Ab0HLHr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 03:47:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o7C7alG0010654
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 12 Aug 2010 09:36:47 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OjSVp-0005Fi-MO; Thu, 12 Aug 2010 09:47:41 +0200
In-Reply-To: <7v62zhyp9e.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 11 Aug 2010 11\:31\:57 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 12 Aug 2010 09:36:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7C7alG0010654
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1282203410.34644@Z2FFjI6oe5SWoTn0nt0qLg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153350>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> +# "exec" commands are ran with the user shell by default, but this may
>> +# be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
>> +# to create a file. Unseting SHELL avoids such non-portable behavior
>> +# in tests.
>> +SHELL=
>
> Tricky but true.
>
> Do we have other callouts that we use $SHELL from the environment?

Not as far as I know. "git grep SHELL" show mostly "SHELL_PATH", and
the testsuite passes for me with SHELL=zsh.

This exec command is a bit of a special case: I wanted the user to
keep the advanced features of his shell (for example, the ** wildcard
of zsh and recent bash), not just allow executing commands.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
