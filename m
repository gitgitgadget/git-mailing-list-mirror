From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] run-command: use void to declare that functions take no parameters
Date: Tue, 11 Nov 2014 09:32:40 -0800
Message-ID: <xmqqegt97idj.fsf@gitster.dls.corp.google.com>
References: <54612B4C.8010609@web.de>
	<xmqq7fz28yo1.fsf@gitster.dls.corp.google.com>
	<20141111025415.GB21328@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Etienne Buira <etienne.buira@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 18:32:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoFJ9-0004fK-Or
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 18:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbaKKRco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 12:32:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751089AbaKKRcn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 12:32:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82FA81C4F8;
	Tue, 11 Nov 2014 12:32:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LaS8+SGlzuCtAZpdKbLnz2LEPLA=; b=Jn7EGY
	XUlgTlozpS9U+YEUtK4e5EdJMRNT/CDYsthwXbLDHRBVl0VUeGf5SUD7t+u5U32C
	dMx9YsDvU5tIhI8q/UxXQXW1+aS0LDxH7ts3Y/Xa2bYgRnlmtzFlPnc+NiEqzXTO
	Z0O4E4LVHWF6KhzKTunDgpu5QIsvp/NWtDFWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tym9a4VDQnjMw1SWPNNsPgRXKNMAeOrt
	Znp3sGQl2xm485rP0fp5wQ7z0uSvNZ6iq8vLGlOBQo42P1uSYxgi3n5JSpcyJZaA
	upGdLaNM0rlztMABH2uJ9R+hIYINdO3VHF5ulg+yesmgdOdJZIQJVEB94JmkqI1T
	HyWJjoqOapM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 799A41C4F6;
	Tue, 11 Nov 2014 12:32:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D63EA1C4F5;
	Tue, 11 Nov 2014 12:32:41 -0500 (EST)
In-Reply-To: <20141111025415.GB21328@peff.net> (Jeff King's message of "Mon,
	10 Nov 2014 21:54:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BD563990-69C8-11E4-8C23-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I had always just assumed that -Wstrict-prototypes was part of -Wall,
> but it is not (nor even part of -Wextra!). Maybe it is time to add it to
> your integration-build flags. :)

Yup, I had -Wold-style-definition but not -Wstrict-prototypes in the
mix.  Thanks for spotting.

>
> Looks like we also need this on top of hv/submodule-config (still in pu,
> so squashing is probably best):
>
> diff --git a/submodule-config.h b/submodule-config.h
> index 58afc83..9061e4e 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -24,6 +24,6 @@ const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
>  		const char *name);
>  const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
>  		const char *path);
> -void submodule_free();
> +void submodule_free(void);
>  
>  #endif /* SUBMODULE_CONFIG_H */
>
> -Peff
