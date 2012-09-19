From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/Makefile: Allow custom XMLTO binary
Date: Wed, 19 Sep 2012 10:59:44 -0700
Message-ID: <7vehlxhp0v.fsf@alter.siamese.dyndns.org>
References: <1348074397-29978-1-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: dborowitz@google.com
X-From: git-owner@vger.kernel.org Wed Sep 19 20:00:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEOZ2-00011T-BB
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 19:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932915Ab2ISR7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 13:59:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42891 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932823Ab2ISR7r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 13:59:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBEF18158;
	Wed, 19 Sep 2012 13:59:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W9fm06yGOqrAZzsHz8gi99PSBGQ=; b=tZcI66
	DRpPXDHWZ9tcmx7f2k69IKnDZ3dgX6FwcomvEn8xc5pAyPjSTTJxt94AKcERnZMR
	hWwDweLTYAPsCYlf0LtZVQXTcld6pmEFzls0N1nNI5j2vd6G122bopqgpSc4eZHA
	KlseA7E7aixRXWwSMicws9jwU6MVQ9oqI6IZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A4TwOF52ru3w0Yy3nxVQE/XF9ssWKFNf
	R+PK1cNs/u0aFQicBGzGZ8wdombyG8yTEAxt6+19hrLvMpLbQCyAsuQT/MSUCq4M
	Mh0NkWxsm0H1AXe4aUN5KzxXwfwsttDFm96oVg+1ZRp4Ku+muH1vWWi4JCxQkqxn
	F+UYE+5k2Is=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9BF58157;
	Wed, 19 Sep 2012 13:59:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D47E8156; Wed, 19 Sep 2012
 13:59:46 -0400 (EDT)
In-Reply-To: <1348074397-29978-1-git-send-email-dborowitz@google.com>
 (dborowitz@google.com's message of "Wed, 19 Sep 2012 10:06:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC032D1C-0283-11E2-8B53-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205965>

dborowitz@google.com writes:

> From: Dave Borowitz <dborowitz@google.com>
>
> Signed-off-by: Dave Borowitz <dborowitz@google.com>
> ---

Thanks; the patch sort-of makes sense but makes me wonder what your
use case is.  Do you have xmlto2 program you want to use in place of
xmlto or you have xmlto but not on your $PATH?

>  Documentation/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index cf5916f..b045628 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -47,6 +47,7 @@ man7dir=$(mandir)/man7
>  ASCIIDOC=asciidoc
>  ASCIIDOC_EXTRA =
>  MANPAGE_XSL = manpage-normal.xsl
> +XMLTO=xmlto
>  XMLTO_EXTRA =
>  INSTALL?=install
>  RM ?= rm -f
> @@ -245,7 +246,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
>  
>  %.1 %.5 %.7 : %.xml manpage-base-url.xsl
>  	$(QUIET_XMLTO)$(RM) $@ && \
> -	xmlto -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
> +	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
>  
>  %.xml : %.txt
>  	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
