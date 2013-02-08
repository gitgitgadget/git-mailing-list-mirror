From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] Makefile: factor common configuration in git-default-config.mak
Date: Fri, 08 Feb 2013 18:05:26 +0100
Message-ID: <vpq4nhmbusp.fsf@grenoble-inp.fr>
References: <vpqobfxwg2q.fsf@grenoble-inp.fr>
	<1360174292-14793-1-git-send-email-Matthieu.Moy@imag.fr>
	<1360174292-14793-4-git-send-email-Matthieu.Moy@imag.fr>
	<7vobfv7wkl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 18:06:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3rOq-0005jr-0c
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 18:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946611Ab3BHRFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 12:05:45 -0500
Received: from mx1.imag.fr ([129.88.30.5]:50004 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758581Ab3BHRFo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 12:05:44 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r18H5OHa005132
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 8 Feb 2013 18:05:24 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U3rOA-0002U1-Gi; Fri, 08 Feb 2013 18:05:26 +0100
In-Reply-To: <7vobfv7wkl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 07 Feb 2013 11:28:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 08 Feb 2013 18:05:25 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r18H5OHa005132
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360947928.18072@/cPOOSbG7JCeFoVkxqBaKA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215781>

Junio C Hamano <gitster@pobox.com> writes:

> I really think this is going in a wrong direction.  Whatever you
> happen to have chosen in this patch will be available to others,
> while whatever are left out will not be.  When adding new things,
> people need to ask if it needs to be sharable or not, and the right
> answer to that question will even change over time.

My feeling is that Git's toplevel Makefile has become too large to
remain completely monolithic, and splitting is good to organize it (and
yes, splitting code into several files imply that future added code will
have to be added in the right file, but that's not very different from
splitting C code into several .c files to me). But that is another
matter, and ...

Junio C Hamano <gitster@pobox.com> writes:

> Then do something like
>
> 	all::
> 		$(MAKE) -C ../.. \
> 			PERL_SCRIPT=contrib/mw-to-git/git-remote-mediawiki.perl \
>                         build-perl-script

This ended up being very simple to implement (essentially, the Makefile
already knows how to do this, so this just means adding convenience
build-perl-script target to the toplevel), so 2 new patches follow doing
this, with a ridiculously small new version of mw-to-git/Makefile.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
