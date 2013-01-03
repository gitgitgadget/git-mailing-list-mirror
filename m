From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test: Add target test-lint-shell-syntax
Date: Wed, 02 Jan 2013 16:16:29 -0800
Message-ID: <7vlicbyvc2.fsf@alter.siamese.dyndns.org>
References: <201301012240.10722.tboegi@web.de>
 <20130102094635.GD9328@sigill.intra.peff.net> <50E4BF58.4090808@web.de>
 <20130102232239.GA27952@sigill.intra.peff.net> <50E4C9B5.8070308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 03 01:16:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqYUQ-0007Ta-EW
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 01:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009Ab3ACAQd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 19:16:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752975Ab3ACAQc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2013 19:16:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BEF1A2B7;
	Wed,  2 Jan 2013 19:16:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8f8bttDxY3Ra
	4XjHEi6RFjxptuY=; b=WXW6JDI0Xixp+EqicAgjM+yAIa/mCwWBwLnKRbNt/4P+
	94VgQ+YhlN+5BXU7dNCPD65SDSW36Viv1RV/GTsn7VllfReoX9AdEhLDIQh2bdiy
	Fh2BDKI0a02j2ME9JrldvfAJWG1mQwVNmqIoWpziYBSNG6j9/hCSw2J0sAuccqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=D96ZVb
	Puzq8VU2dKUQiPTIOIgCRDFqgy07R3OHlYiZA8SIb7/Hwhsc6Ph0/D5d1DSjds9r
	m9piY46yB9eh0pOk8hbBNrUk7nUVzaGbO0qpd/B+X+kj8GbGscij30w+rqtQDruR
	sOpduxd8l3RJUGFBJyxwsd+sgbkmkU+7IkT20=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DB04A2B5;
	Wed,  2 Jan 2013 19:16:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 099AEA2B4; Wed,  2 Jan 2013
 19:16:30 -0500 (EST)
In-Reply-To: <50E4C9B5.8070308@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Thu, 03 Jan 2013 00:58:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2F80412-553A-11E2-81F1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212562>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> At least on my system the following combination works:
>
> git diff
> diff --git a/t/Makefile b/t/Makefile
> index f8f8c54..391a5ca 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -8,7 +8,7 @@
> =20
>  #GIT_TEST_OPTS =3D --verbose --debug
>  SHELL_PATH ?=3D $(SHELL)
> -PERL_PATH ?=3D /usr/bin/perl
> +PERL_PATH =3D "/Users/tb/projects/git/tb/pe rl"

I do not think that will fly.  Having that in the main Makefile
where the existing users of the symbol relies on it without any
surrounding quotes, e.g.

$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl GIT-VERSION-FILE
	$(QUIET_GEN)$(RM) $@ $@+ && \
	INSTLIBDIR=3D`MAKEFLAGS=3D $(MAKE) -C perl -s --no-print-directory ins=
tlibdir` && \
	sed -e '1{' \
	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
	    -e '	h' \
	    -e '	s=3D.*=3Duse lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'=
"$$INSTLIBDIR"'"));=3D' \
	    -e '	H' \
	    -e '	x' \
	    -e '}' \
	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
	    $@.perl >$@+ && \
	chmod +x $@+ && \
	mv $@+ $@

where $(PERL_PATH_SQ) is defined to replace each ' in $(PERL_PATH)
with '\'' so that '$(PERL_PATH_SQ)' becomes a shell-safe way to
quote the value of PERL_PATH without quotes, your definition will
look for a relative path that is inside a directory named '"'
(that's a single double-quote).
