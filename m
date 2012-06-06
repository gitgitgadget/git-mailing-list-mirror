From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add the DEFAULT_HELP_FORMAT option to Makefile
Date: Wed, 06 Jun 2012 12:06:35 -0700
Message-ID: <7vzk8gl0p0.fsf@alter.siamese.dyndns.org>
References: <20120606135353.GD2597@sigill.intra.peff.net>
 <1339008702-704-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: vfr@lyx.org
X-From: git-owner@vger.kernel.org Wed Jun 06 21:06:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScLZ5-0002w9-Bj
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 21:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757598Ab2FFTGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 15:06:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59403 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756172Ab2FFTGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 15:06:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CCE28AA7;
	Wed,  6 Jun 2012 15:06:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uav4Sz1kuSKa7wJRb5Fd/J0lLCw=; b=oFfvcv
	xLJlYWrK1E7G0UtwoOgjlzRFnQTBeadLledk12hkaPCb9ogQ87bd0JTNAVQS9bQc
	U3YNPAQlhChxuqRiLCVxfMMzFbKzmsnC4yvbT+JB1hDZwC/RRG5rjYv930NCXjE8
	Ar9+JRZvPZxzOHyPBPpEEDrY7rn+R0lVRdV/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=preGt6479xwH8Dr1bbU+2kdhuvXyqYWy
	uJAh0i8/bv7lGbBi/vIH9WMWUyd5/Z+XmXMIAqRqnNKBUdW/ZiYnJNQPH1uUnUgb
	M9VEzxIdaUxUJ6MOrUF0ICziz2S65YC7teSO1+fnDM2dwUnSM2/eEPa+QHF8gVFk
	z09L/HhCiHI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 132FC8AA6;
	Wed,  6 Jun 2012 15:06:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A0778AA5; Wed,  6 Jun 2012
 15:06:37 -0400 (EDT)
In-Reply-To: <1339008702-704-1-git-send-email-vfr@lyx.org> (vfr@lyx.org's
 message of "Wed, 6 Jun 2012 18:51:42 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD922B64-B00A-11E1-BF41-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199347>

vfr@lyx.org writes:

> From: Vincent van Ravesteijn <vfr@lyx.org>
>
> This patch advertises the DEFAULT_HELP_FORMAT compile option in Makefile. It will also allow to call 'make DEFAULT_HELP_FORMAT=info' to specify a different default.
>
> Proposed-by: Jeff King <peff@peff.net>
> Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
> ---
>  Makefile |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index ffbd7a4..b21afed 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -296,6 +296,10 @@ all::
>  # the diff algorithm.  It gives a nice speedup if your processor has
>  # fast unaligned word loads.  Does NOT work on big-endian systems!
>  # Enabled by default on x86_64.
> +#
> +# Define DEFAULT_HELP_FORMAT to "man", "info", "web" or "html"
> +# (defaults "man") if you want to have a different default when
> +# "git help" is called without a parameter specifying the format.

We probably should just say 'html' without the idiotic 'web'
synonym.

> @@ -1238,6 +1242,7 @@ ifeq ($(uname_S),Windows)
>  	NATIVE_CRLF = YesPlease
>  	NO_INET_PTON = YesPlease
>  	NO_INET_NTOP = YesPlease
> +	DEFAULT_HELP_FORMAT = html
>  
>  	CC = compat/vcbuild/scripts/clink.pl
>  	AR = compat/vcbuild/scripts/lib.pl
> @@ -1917,6 +1922,10 @@ SHELL_PATH_CQ_SQ = $(subst ','\'',$(SHELL_PATH_CQ))
>  BASIC_CFLAGS += -DSHELL_PATH='$(SHELL_PATH_CQ_SQ)'
>  endif
>  
> +ifdef DEFAULT_HELP_FORMAT
> +BASIC_CFLAGS += -DDEFAULT_HELP_FORMAT='"$(DEFAULT_HELP_FORMAT)"'
> +endif
> +
>  ALL_CFLAGS += $(BASIC_CFLAGS)
>  ALL_LDFLAGS += $(BASIC_LDFLAGS)

The choice of the variable name, decision to tweak BASIC_CFLAGS and
the placement of the tweak all look good to me.

You would also need actual code to react to -DDEFAULT_HELP_FORMAT in
the same patch.

I think the choices of PAGER and EDITOR share the same problem, but
shouldn't this choice recorded in GIT-BUILD-OPTIONS in some way?

Thanks.
