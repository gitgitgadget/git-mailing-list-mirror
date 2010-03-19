From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add ignore and clean rules for gitweb.min.js
Date: Fri, 19 Mar 2010 14:06:20 -0700
Message-ID: <7vbpekf2cz.fsf@alter.siamese.dyndns.org>
References: <4BA3D9E2.5070401@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Fri Mar 19 22:06:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsjOr-0005Gd-CW
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 22:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351Ab0CSVG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 17:06:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056Ab0CSVG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 17:06:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9563A3078;
	Fri, 19 Mar 2010 17:06:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f0oYnIbsyeIEkY1M9wAP+TNpCkI=; b=D3Mgmu
	tQZg53U2NkS9Q09mf84nnAJkYnul+lvxXjrzzWg5Owy93CCLnV206GepY/zeXFVM
	DXTgdiaBRGQ/5gdOSAjPSt8Ssm5bz+Ut//tPXLHqM3CEJ2pHyQQv49/D6hkJ4huq
	hhvHQ9BhQNJjuFzw4axt4jETWPSCGg2ccxXEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TZ17S+NM3mwgFg3oyzE/a23Mv+xPeHMv
	8XxaObZBEqBtyxBqmVVCpuLbXa/fh/V83gIBB2xIsvNsYhS7nWSgpRoiiHItJE+n
	nMJnPPofQloyj2lLb1JcqzHRyDEqSP/w4dw/R3/Fd07kY0yerJYkVUhrPNFdbQ1n
	drik8KdhJ/o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A0243A3075;
	Fri, 19 Mar 2010 17:06:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0085CA306E; Fri, 19 Mar
 2010 17:06:21 -0400 (EDT)
In-Reply-To: <4BA3D9E2.5070401@mailservices.uwaterloo.ca> (Mark Rada's
 message of "Fri\, 19 Mar 2010 16\:09\:06 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 46DD8F9C-339B-11DF-80A0-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142648>

Mark Rada <marada@uwaterloo.ca> writes:

> Signed-off-by: Mark Rada <marada@uwaterloo.ca>

Thanks; one question and a comment.

> ---
>  .gitignore |    1 +
>  Makefile   |    3 +++
>  2 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index 7b3acb7..3558dd2 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -156,6 +156,7 @@
>  /git-core-*/?*
>  /gitk-git/gitk-wish
>  /gitweb/gitweb.cgi
> +/gitweb/gitweb.min.js
>  /test-chmtime
>  /test-ctype
>  /test-date

Question: should this be part of your earlier "instaweb" patch, or are
they independent?

> diff --git a/Makefile b/Makefile
> index f80b25e..cdf16c2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2078,6 +2078,9 @@ clean:
>  	$(MAKE) -C Documentation/ clean
>  ifndef NO_PERL
>  	$(RM) gitweb/gitweb.cgi
> +ifdef JSMIN
> +	$(RM) gitweb/gitweb.min.js
> +endif #JSMIN
>  	$(MAKE) -C perl clean
>  endif

Running "make clean" in perl/ should stay in "ifndef NO_PERL", but I think
removal of both gitweb/{gitweb.cgi,gitweb.min.js} should be unconditional;
it does not hurt as $(RM) is "rm -f" (i.e. don't complain to ENOENT).
