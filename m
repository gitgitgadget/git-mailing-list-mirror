From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [patch 11/15] no-hstrerror.patch
Date: Tue, 16 Mar 2010 00:24:47 -0700
Message-ID: <7veijkn2yo.fsf@alter.siamese.dyndns.org>
References: <20100316054220.075676000@mlists.thewrittenword.com>
 <20100316054352.704479000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 08:25:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrR99-0003vZ-Bq
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 08:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937513Ab0CPHYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 03:24:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936263Ab0CPHYx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 03:24:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 222C8A2012;
	Tue, 16 Mar 2010 03:24:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=gxiVvpg2O/DNocw4y9uWdGDe114=; b=S4cNeoKbbWDNqkUagEHa8Ue
	TKx0CODIg+zPSAQezDZDgiT1C1dGEbvjq7Z2lKZSwfWJlME2CAfKAkdaX/7FiQcC
	+VOvflxCuQ+CgG5+gXpLWoLQV+Sb6bwuLTQdP4T4XV2xMObVzbIm+GhoBuKzAJSZ
	9opTlWfAkwGGRenVpGsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=bugD02tQHlOWBQOru55Qh/hUHb9D8RUWArW1qhs+LuYtD5LEz
	uPk5yGKdJwBoHfpx1b29JlJRwLiFfrxwKMCTVXhoKrhGsNu7cx4/1uhBVnxLzb5V
	aWYM8PzTcYoobS5XmmsHP2zOZbFg5k1X6ZUeSyB+axlqcevHddW++HT8F4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F13F7A2010;
	Tue, 16 Mar 2010 03:24:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5171BA200F; Tue, 16 Mar
 2010 03:24:48 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 024F719A-30CD-11DF-B8CB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142329>

"Gary V. Vaughan" <git@mlists.thewrittenword.com> writes:

> SunOS 5.6 and 5.5.1 do not have hstrerror, even in libresolv.
>
> This patch improves the logic of the test for hstrerror, not to
> blindly assume that if there is no hstrerror in libc that it must
> exist in libresolv.
> ---
>  Makefile      |    1 +
>  config.mak.in |    1 +
>  configure.ac  |   17 ++++++++++++++---
>  3 files changed, 16 insertions(+), 3 deletions(-)
>
> Index: b/configure.ac
> ===================================================================
> --- a/configure.ac
> +++ b/configure.ac
> @@ -526,11 +526,22 @@ test -n "$NEEDS_SOCKET" && LIBS="$LIBS -
>  
>  #
>  # Define NEEDS_RESOLV if linking with -lnsl and/or -lsocket is not enough.
> -# Notably on Solaris hstrerror resides in libresolv and on Solaris 7
> -# inet_ntop and inet_pton additionally reside there.
> -AC_CHECK_LIB([c], [hstrerror],
> +# Notably on Solaris 7 inet_ntop and inet_pton additionally reside there.

You lost the thing they are "additional" to, so this needs a bit of
rewording?

Other than that the patch looked sane (I don't have access to any vintage
of Solaris these days, so I only read it through, though).

Thanks.
