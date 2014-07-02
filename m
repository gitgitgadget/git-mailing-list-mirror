From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Compile Error on Git 2.0.1 on Redhat 5.9 with Fix
Date: Wed, 02 Jul 2014 18:25:58 +0200
Message-ID: <vpqtx6z4tih.fsf@anie.imag.fr>
References: <CAH5EwqY8D=CGxB+rZvwPH5115r9qmRCBBvJMG_o0962d4Uquxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eldon Nelson <eldon_nelson@ieee.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 18:26:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2NMe-0005Po-J5
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 18:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbaGBQ03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 12:26:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34813 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753926AbaGBQ02 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 12:26:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s62GPuUM015723
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 2 Jul 2014 18:25:57 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s62GPwXU003583;
	Wed, 2 Jul 2014 18:25:58 +0200
In-Reply-To: <CAH5EwqY8D=CGxB+rZvwPH5115r9qmRCBBvJMG_o0962d4Uquxw@mail.gmail.com>
	(Eldon Nelson's message of "Wed, 2 Jul 2014 10:56:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 02 Jul 2014 18:25:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s62GPuUM015723
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404923158.52978@u0+tnckg6bJNiL4j684Fhw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252791>

Eldon Nelson <eldon_nelson@ieee.org> writes:

> make prefix=/home/eldon/local all doc info
> ...
>     CC zlib.o
>     CC unix-socket.o
>     CC thread-utils.o
>     CC compat/strlcpy.o
>     AR libgit.a
> /bin/sh: gar: command not found
[...]
> I think the fix is to allow the use of "ar" if "gar" does not exist.

It is already the case. The Makefile defaults to "ar" and does not even
contain any mention of "gar". The configure script checks for both:

configure.ac:AC_CHECK_TOOLS(AR, [gar ar], :)

My guess is that you ran the configure script on a machine where gar is
present, and then used the result on a machine where it isn't.

Normally, at configure time you should see this:

checking for ar... ar

You actually don't need to run the configure script, the Makefile runs
fine without it. Delete config.mak.autogen to cancel the effect of
./configure.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
