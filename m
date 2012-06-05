From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] api-credentials.txt: add "see also" section
Date: Tue, 05 Jun 2012 13:20:21 +0200
Message-ID: <vpqaa0ij98q.fsf@bauges.imag.fr>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
	<1338739804-32167-4-git-send-email-Matthieu.Moy@imag.fr>
	<7vsjecvxmc.fsf@alter.siamese.dyndns.org>
	<vpq1ulvuxd9.fsf@bauges.imag.fr>
	<20120604115630.GC27676@sigill.intra.peff.net>
	<vpqpq9en8ol.fsf@bauges.imag.fr>
	<20120605065955.GB25809@sigill.intra.peff.net>
	<20120605073403.GC25809@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 13:20:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbroU-00008L-N3
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 13:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761811Ab2FELUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 07:20:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50304 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761722Ab2FELUd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 07:20:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q55BBdKH013853
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 5 Jun 2012 13:11:39 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SbroE-0007HI-Rk; Tue, 05 Jun 2012 13:20:22 +0200
In-Reply-To: <20120605073403.GC25809@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 5 Jun 2012 03:34:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 05 Jun 2012 13:11:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q55BBdKH013853
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339499500.93082@bz/UtJv1CV3dRnBogTSwcA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199229>

Jeff King <peff@peff.net> writes:

>> I wonder if we could even make asciidoc work to convert
>> linkgit:git-config[1] into the right path (i.e., to include the ".."
>> automatically) when we are in the subdir.

Why not. I don't really care about eye candiness in technical/, but it
can make sense to make an effort at least for howto/ (which doesn't
contain links as of now, though).

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 14286cb..b3693c8 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -280,6 +280,7 @@ technical/api-index.txt: technical/api-index-skel.txt \
>  	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
>  	$(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
>  
> +technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
>  $(patsubst %,%.html,$(API_DOCS) technical/api-index): %.html : %.txt
>  	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
>  		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) $*.txt
> @@ -333,6 +334,7 @@ $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
>  
>  WEBDOC_DEST = /pub/software/scm/git/docs
>  
> +howto/%.html: ASCIIDOC_EXTRA += git-relative-html-prefix=../

Don't you miss a "-a" between += and git-relative-html-prefix?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
