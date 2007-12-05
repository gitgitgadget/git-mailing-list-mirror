From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] autoconf: Add test for OLD_ICONV
Date: Wed, 05 Dec 2007 11:38:12 -0800
Message-ID: <7vtzmxortn.fsf@gitster.siamese.dyndns.org>
References: <7vd4u5l29v.fsf@gitster.siamese.dyndns.org>
	<1196869526-2197-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 20:40:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0065-0000YP-DP
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 20:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbXLETi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 14:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754229AbXLETiY
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 14:38:24 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56220 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbXLETiW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 14:38:22 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6A4532FA;
	Wed,  5 Dec 2007 14:38:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id BE0749D3FC;
	Wed,  5 Dec 2007 14:38:35 -0500 (EST)
In-Reply-To: <1196869526-2197-1-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Wed, 5 Dec 2007 16:45:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67186>

Jakub Narebski <jnareb@gmail.com> writes:

> diff --git a/configure.ac b/configure.ac
> index 5f8a15b..5d2936e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -212,6 +212,27 @@ test -n "$NEEDS_SOCKET" && LIBS="$LIBS -lsocket"
>  
>  
>  ## Checks for header files.
> +AC_MSG_NOTICE([CHECKS for header files])
> +#
> +# Define OLD_ICONV if your library has an old iconv(), where the second
> +# (input buffer pointer) parameter is declared with type (const char **).
> +AC_DEFUN([OLDICONVTEST_SRC], [[
> +#include <iconv.h>
> +
> +int main(void)
> +{
> +	iconv_t cd;
> +	char *ibp, *obp;
> +	size_t insz, outsz;
> +	iconv(cd, &ibp, &insz, &obp, &outsz);
> +}
> +]])
> +AC_MSG_CHECKING([for old iconv()])
> +AC_COMPILE_IFELSE(OLDICONVTEST_SRC,
> +	[AC_MSG_RESULT([no])],
> +	[AC_MSG_RESULT([yes])
> +	OLD_ICONV=YesPlease])
> +AC_SUBST(OLD_ICONV)
>  

Which result does COMPILE_IFELSE give for non error warnings?  Ok, or
Bad?
