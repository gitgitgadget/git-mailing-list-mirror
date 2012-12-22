From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Sort howto documents in howto-index.txt
Date: Sat, 22 Dec 2012 11:40:03 -0800
Message-ID: <7v8v8pri3w.fsf@alter.siamese.dyndns.org>
References: <1870890640.302608.1356201267202.JavaMail.ngmail@webmail13.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sat Dec 22 20:40:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmUvp-00024G-FX
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 20:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046Ab2LVTkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 14:40:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48995 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab2LVTkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 14:40:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DDE1A65F;
	Sat, 22 Dec 2012 14:40:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6awXh0cIiJe0ij5k6ZaLNOuFnFs=; b=PVXQ44
	5nbHolKRX3sA2vWUPzgoj2X9dRq2o0tbK1BRnr5c4gkBRtMna9mFN7e5QNuaOHtv
	OzfBDvSmMe6YBoa+NZPAd6mzZfGNQm48N4d0MCN3BHdVP+ACrabjLR3UUWt/nh4L
	YI4F4IluivyaRrNBS4hLlpmt6mhtb2Mc/4nq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QVyKkdMp6WbOVh0TbTHbxNJNL0IVzo2e
	cPLNzwpuqFzymExq4HTPUJnbNDzfuK3rTWdy4dRs+NtMO9FtHfsJrFGBIRKCmMwK
	6QdG4XddlJh814TlDE4Du4kng9kk+vIkCSETCdTYvzK768scXzEDKqatAre+z5p4
	Il1FJ0QQbDA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88606A65D;
	Sat, 22 Dec 2012 14:40:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E016AA65C; Sat, 22 Dec 2012
 14:40:04 -0500 (EST)
In-Reply-To: <1870890640.302608.1356201267202.JavaMail.ngmail@webmail13.arcor-online.net>
 (Thomas Ackermann's message of "Sat, 22 Dec 2012 19:34:27 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62537EAE-4C6F-11E2-8223-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212069>

Thomas Ackermann <th.acker@arcor.de> writes:

> Howto documents in howto-index.txt were listed in a rather
> random order. So better sort them.
>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---

I think $(wildcard) used to sort but in recent GNU make it no longer
does, so this is probably a good change.

Do we need to explicitly sort the api-index as well?  $(API_DOCS) is
fed to the script that reads filenames one at a time in the given
order, but I do not see anybody asking for a sorted list while
producing that list.  The result looks to be sorted in my build
farm with GNU make 3.82, but that could be by accident.

>  Documentation/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index d7417b8..ff8ad9a 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -348,7 +348,7 @@ $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
>  
>  howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
>  	$(QUIET_GEN)$(RM) $@+ $@ && \
> -	'$(SHELL_PATH_SQ)' ./howto-index.sh $(wildcard howto/*.txt) >$@+ && \
> +	'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(wildcard howto/*.txt)) >$@+ && \
>  	mv $@+ $@
>  
>  $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
