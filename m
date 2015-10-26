From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/2] sh-setup: explicitly mark CR as a field separator
Date: Mon, 26 Oct 2015 10:34:07 +0100
Message-ID: <vpqlhaqas8g.fsf@grenoble-inp.fr>
References: <cover.1445777347.git.johannes.schindelin@gmx.de>
	<cover.1445782122.git.johannes.schindelin@gmx.de>
	<2b089201404299257f23b3931499ea16202f0f65.1445782122.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 26 10:34:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqeB2-0008Ks-Pe
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 10:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbbJZJeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 05:34:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53508 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753347AbbJZJee (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 05:34:34 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9Q9Y6n3007150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 26 Oct 2015 10:34:07 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9Q9Y7e8021616;
	Mon, 26 Oct 2015 10:34:07 +0100
In-Reply-To: <2b089201404299257f23b3931499ea16202f0f65.1445782122.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Sun, 25 Oct 2015 15:10:25 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 26 Oct 2015 10:34:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9Q9Y6n3007150
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1446456851.26677@z9rtAlVbHxY5urpPaoV4OA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280186>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This is the correct thing to do, really: we already specify LF as
> field separator.

I'm almost convinced that this is the right thing to do in the long run
("almost" because I'm not sure, not because I have arguments against). I
agree with Junio that the commit message should be more convincing, but
indeed, accepting LF and not CR is strange.

However, is this the right thing to do in the maintainance branch? It
does fix the issue, but does so in a rather intrusive way, so I'd need
more arguments to be convinced that this is safe to merge in maint. Or
have a local fix for rebase to be merged in maint, and apply this in
master for the next feature release.

Sorry for being negative, and especially sorry since I'm partly guilty
for the breakage. I just want to be sure that we don't break anything
while repairing it (we already introduced this breakage while repairing
another one...).

>  # Similarly for IFS, but some shells (e.g. FreeBSD 7.2) are buggy and
>  # do not equate an unset IFS with IFS with the default, so here is
> -# an explicit SP HT LF.
> +# an explicit SP HT LF CR.
>  IFS=' 	
> -'
> +'"$(printf '\r')"

While we're there, it may be better to have a single "printf ' \t\n\r'"
to avoid the whitespace magic in the source code.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
