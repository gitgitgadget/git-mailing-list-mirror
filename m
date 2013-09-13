From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Fri, 13 Sep 2013 07:37:54 -0700
Message-ID: <xmqqppsckcsd.fsf@gitster.dls.corp.google.com>
References: <523094F0.9000509@gmail.com> <20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
	<CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
	<20130912202246.GF32069@sigill.intra.peff.net>
	<xmqqr4ctokat.fsf@gitster.dls.corp.google.com>
	<CAHGBnuOQ-y1beD_X_jiH+FrhPvLOVJqT0J=Wk988Q4NeCs1-9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 16:38:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKUVW-00079W-Cz
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 16:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756220Ab3IMOh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 10:37:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47384 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755584Ab3IMOh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 10:37:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEDE440F70;
	Fri, 13 Sep 2013 14:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Re+cLq1JN+lYImuA78vVLTu5OvI=; b=cBKzMd
	MD6IzoA8Ydw+jMrhP+naDwCaxhdngurxOnMpD3TfhszNrr2hY57erT97RvypCbuG
	vor+QwcAJhGjujHz2H/hkzoYfJlCX6ra/NfcmpV5EGmggrWreUYPTY56dcyPFw5e
	kWbMd4lS3kwvXjx8GAToL4YUTcpcirAspSKqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K0G8lk/z6olE5Yt0xPcPoRk9I65QxvZY
	w3IaehClc2WiBDpLUwkwW+o19K/88vR6ibvhhWqgijk1d6P4a0fhHsz/0xEI1r9Z
	zxiGyX77gFUlm0V+5zfedQ4kvyn9zKMxRR6cCnYvkJxdp31MZfgP9QW9UIDbzyu4
	m9uQcoJ2Kh8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3CC040F6F;
	Fri, 13 Sep 2013 14:37:56 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 034BB40F6B;
	Fri, 13 Sep 2013 14:37:56 +0000 (UTC)
In-Reply-To: <CAHGBnuOQ-y1beD_X_jiH+FrhPvLOVJqT0J=Wk988Q4NeCs1-9Q@mail.gmail.com>
	(Sebastian Schuberth's message of "Fri, 13 Sep 2013 14:47:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 142B768A-1C82-11E3-9BB1-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234756>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Well, if by "everywhere" in (1) you mean "on all platforms" then
> you're right. But my patch does not define __NO_INLINE__ globally, but
> only at the time string.h / strings.h is included. Afterwards
> __NO_INLINE__ is undefined. In that sense, __NO_INLINE__ is not
> defined "everywhere".

Which means people who do want to see that macro defined will be
broken after that section of the header file which unconditionally
undefs it, right?

That is exactly why that change should not appear in the platform
neutral part of the header file.

> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -85,12 +85,16 @@
>  #define _NETBSD_SOURCE 1
>  #define _SGI_SOURCE 1
>
> +#ifdef __MINGW32__
>  #define __NO_INLINE__ /* do not inline strcasecmp() */
> +#endif
>  #include <string.h>
> +#ifdef __MINGW32__
> +#undef __NO_INLINE__
> +#endif

That is certainly better than the unconditional one, but I wonder if
it is an option to add compat/mingw/string.h without doing the
above, though.

That header file can do the "no-inline" dance before including the
real thing with "#include_next", and nobody else would notice, no?

	#ifdef __NO_INLINE__
        #define __NO_INLINE_WAS_THERE 1
        #else
        #define __NO_INLINE__
        #define __NO_INLINE_WAS_THERE 0
	#endif

	#include_next <string.h>
        #if !__NO_INLINE_WAS_THERE
        #undef __NO_INLINE__
	#endif

or something like that.

That of course assumes nobody compiles for _MINGW32_ with a compiler
that does not understrand "#include_next" and I do not know if that
restriction is a showstopper or not.



>  #ifdef HAVE_STRINGS_H
>  #include <strings.h> /* for strcasecmp() */
>  #endif
> -#undef __NO_INLINE__
>
>  #ifdef WIN32 /* Both MinGW and MSVC */
>  #ifndef _WIN32_WINNT
