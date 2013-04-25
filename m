From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Itches with the current rev spec
Date: Thu, 25 Apr 2013 10:22:46 +0200
Message-ID: <vpqehdzkoix.fsf@grenoble-inp.fr>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 10:23:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVHSM-0005IC-Q8
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 10:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757039Ab3DYIW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 04:22:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39724 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757018Ab3DYIWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 04:22:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3P8Mk5u030836
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 25 Apr 2013 10:22:46 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UVHS3-0006mx-8Q; Thu, 25 Apr 2013 10:22:47 +0200
In-Reply-To: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 25 Apr 2013 10:37:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 25 Apr 2013 10:22:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3P8Mk5u030836
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1367482968.72985@hJ6HPA6y0xcLQTBA2YlMpg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222355>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi,
>
> So, I have three serious itches that would be nice to address:
>
> 1. git reset --hard HEAD~1/ git show HEAD~1 is a very common idiom
> that's unnecessarily cumbersome to type out.  We can make the <rev>
> part of <rev>~<n> optional without being ambiguous: you might argue
> that ~<n> normally refers to a /home/<n>, but who uses numbers in
> place of usernames?  Even if they do, how can that path possibly be
> inside our repository?

It's a bit more complex than that: the ~<username> is expanded by the
shell, before Git has any opportunity to guess anything.

~1 would be unusable for zsh users and tcsh users at least by default:

zsh% echo ~1
zsh: not enough directory stack entries.

tcsh% echo ~1
Unknown user: 1.

(An obvious workaround is to shell-quote it, but as the goal is to have
something easy to type, \~1 or '~1' do not give so much benefit over
HEAD~1)

That said, it seems to work fine for bash (even if the number is a PID,
it's not expanded), so it may be a good idea to add it as a shortcut,
with a warning in the doc about shell expansion.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
