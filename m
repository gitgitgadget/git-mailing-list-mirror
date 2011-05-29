From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv2 1/2] Starting work on a man page for
 /etc/gitweb.conf (WIP)
Date: Sun, 29 May 2011 13:37:48 -0700
Message-ID: <7vwrh9nsyr.fsf@alter.siamese.dyndns.org>
References: <1306698626-32402-1-git-send-email-jnareb@gmail.com>
 <1306698626-32402-2-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 29 22:38:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQmkX-0001aH-Bn
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 22:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab1E2UiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 16:38:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab1E2UiF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 16:38:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 046865E1F;
	Sun, 29 May 2011 16:40:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S9mbukURP4bqCwwtobh5z00Dt5Q=; b=AbvKpa
	5sQtPYZaLhqRVtQaYka9mgE8USvUF3CNCA3u7OTZ//0JsH1k154H0W4s0wZ/d9I6
	WoUw9eu9TQKJqyxcs22AKoHosgDQKCL4PsYQTPgym6hsH7EOAG8S6E5MAaX5q0Q1
	U2yAMIbrUse0plEP5wgPEQkheKasGQ6Q0lCnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rNxE1gwYH4MGgu8M3JQoRtf0UWvKyUdv
	rTv+kcFP2PIRYvdXhf4aJiGpRwWfVFrJVZphG24IAuKt79Hm2BlqnARMJtnT33NZ
	KN42BaIBjgdPk4sElxd58vH++Q1PdieenlQbVbVGidpN1TR5gvLCa61d5ZoX9KaL
	kjI2REEeigc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 939DE5E06;
	Sun, 29 May 2011 16:40:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D58A95DFE; Sun, 29 May 2011
 16:39:57 -0400 (EDT)
In-Reply-To: <1306698626-32402-2-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Sun, 29 May 2011 21:50:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5C0D0F8-8A33-11E0-88B9-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174707>

Jakub Narebski <jnareb@gmail.com> writes:

> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index 0a6ac00..582e1b0 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -112,6 +112,14 @@ endif
>  
>  GITWEB_FILES += static/git-logo.png static/git-favicon.png
>  
> +GITWEB_MAN5_TXT = gitweb.conf.txt
> +GITWEB_MAN_TXT = $(GITWEB_MAN1_TXT) $(GITWEB_MAN5_TXT) $(GITWEB_MAN7_TXT)
> +GITWEB_MAN = $(patsubst %.txt,%.1,$(GITWEB_MAN1_TXT)) \
> +             $(patsubst %.txt,%.5,$(GITWEB_MAN5_TXT)) \
> +             $(patsubst %.txt,%.7,$(GITWEB_MAN7_TXT))
> +GITWEB_HTML= $(patsubst %.txt,%.html,$(GITWEB_MAN_TXT))
> +GITWEB_DOC = $(GITWEB_MAN) $(GITWEB_HTML)
> +
>  GITWEB_REPLACE = \
>  	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
>  	-e 's|++GIT_BINDIR++|$(bindir)|g' \
> @@ -155,6 +163,11 @@ test-installed:
>  	GITWEB_TEST_INSTALLED='$(DESTDIR_SQ)$(gitwebdir_SQ)' \
>  		$(MAKE) -C ../t gitweb-test
>  
> +### Documentation
> +
> +doc:
> +	$(MAKE) -C ../Documentation $(GITWEB_DOC)
> +
>  ### Installation rules
>  
>  install: all

I am not sure if this target is needed or even desirable.

The only potential benefit this complexity and risk of these build
procedure knowledge diverge what is in ../Documentation is to let you say
"cd gitweb && make doc" and avoid building the rest of the documentation,
but I personally do not find it necessary at all.

Aren't you making a mistake similar to the one that let instaweb have
intimate and unnecessary knowledge of how to build gitweb, which you
recently cleaned up?
