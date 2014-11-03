From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] configure.ac: use GIT_CC_CHECK_FLAG_APPEND for adding --with-gcc-warnings configure option
Date: Mon, 03 Nov 2014 11:49:31 -0800
Message-ID: <xmqq1tpkrrn8.fsf@gitster.dls.corp.google.com>
References: <1415026641-24767-1-git-send-email-gitter.spiros@gmail.com>
	<1415026641-24767-3-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jnareb@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 20:49:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlNdD-0008Pf-0p
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbaKCTtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:49:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752448AbaKCTte (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:49:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BBF61A9ED;
	Mon,  3 Nov 2014 14:49:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c2LlCGN1Cwhipx2/ZGsIqZ2zU3w=; b=cVcLDn
	G9AO+Mu49QeWgIfmwhS99McO3XQeuAz4wGA/qF28ViPAqkCkOTU47RJblwKorSJc
	LYoXojb9gl1xYp22eJFyxOhbBykilJ5Z8EtFTbghmLO6+3oW4bSngSZeyRwOiOuc
	fQ1i5W6BQy+jBJeRHzIs98UpP1sljkMVyOQpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LOTZkGq0rvZOLaUiHup0pW6Tg8db3zWr
	cL+QuHUKyITsv2fnQCf7NUT7dx2F1H/X43bZgRP64vDP8vX54zAX/sqZ5MpXzS8t
	k58LE5OptSj6rxqzQlwakCXmApU74hcstAbMFJR1K8oOstAoQFcIf69dBsSBkpOG
	bjdccbGutrQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 014B71A9EC;
	Mon,  3 Nov 2014 14:49:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A35B1A9EB;
	Mon,  3 Nov 2014 14:49:33 -0500 (EST)
In-Reply-To: <1415026641-24767-3-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Mon, 3 Nov 2014 06:57:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 884EFF66-6392-11E4-B9D0-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> Use the GIT_CC_CHECK_FLAGS_APPEND autoconf macro
> for add in a portable way the new configure option
> --enable-gcc-warnings (default off).
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  Makefile     |   12 ++++++--
>  configure.ac |   96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 103 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 23485f1..9db34e2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -344,11 +344,9 @@ GIT-VERSION-FILE: FORCE
>  	@$(SHELL_PATH) ./GIT-VERSION-GEN
>  -include GIT-VERSION-FILE
>  
> -GIT_CFLAGS  =
> -GIT_LDFLAGS =
>  # CFLAGS and LDFLAGS are for the users to override from the command line.
>  
> -CFLAGS = -g -O2 -Wall $(GIT_CFLAGS)
> +CFLAGS = -g -O2 -Wall 
>  LDFLAGS = $(GIT_LDFLAGS)
>  ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)

Reverting what you did just a minute ago?

I am debating myself if I should say that the new placement may make
more sense.  On the one hand, -Wanything is more or less developer's
personal taste and should be easily overridable via CFLAGS for each
invocation of "make", just like -g and -O2.  On the other hand, some
class of error checking is so useful and bulletproof not to give us
false positives that we may want to encourage people to always use
them when available.  The placement in 1/2 was in line with the
former, but the updated placement makes it very hard to selectively
disable GCC crud that barfs unnecessarily without disabling
everything by GIT_CFLAGS="", I am afraid.

Looking at the way the patch to configure.ac tries to add many
things, I am not sure if these two patches are good idea (note: I
didn't say "I am sure this is going in a wrong direction").  Is it
adding everything under the sun, or after careful consideration on
each and every ones to see how false-positive-prone it is?

> @@ -1517,6 +1515,14 @@ ifdef DEFAULT_HELP_FORMAT
>  BASIC_CFLAGS += -DDEFAULT_HELP_FORMAT='"$(DEFAULT_HELP_FORMAT)"'
>  endif
>  
> +ifdef GIT_CFLAGS
> +BASIC_CFLAGS += $(GIT_CFLAGS)
> +endif
> +
> +ifdef GIT_LDFLAGS
> +BASIC_LDFLAGS += $(GIT_LDFLAGS)
> +endif
> +
>  ALL_CFLAGS += $(BASIC_CFLAGS)
>  ALL_LDFLAGS += $(BASIC_LDFLAGS)
>  
> diff --git a/configure.ac b/configure.ac
> index c67ca60..95d5d10 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1,4 +1,4 @@
> -#                                               -*- Autoconf -*-
> +#                                               -*- Autoconf -*- \
>  # Process this file with autoconf to produce a configure script.
>  
>  ## Definitions of private macros.
> @@ -433,7 +433,99 @@ AS_HELP_STRING([],[ARG is the full path to the Tcl/Tk interpreter.])
>  AS_HELP_STRING([],[Bare --with-tcltk will make the GUI part only if])
>  AS_HELP_STRING([],[Tcl/Tk interpreter will be found in a system.]),
>  GIT_PARSE_WITH(tcltk))
> -#
> +
> +
> +# Turn gcc warning
> +
> +AC_ARG_ENABLE([gcc-warnings],
> +  [AS_HELP_STRING([--enable-gcc-warnings],
> +                  [turn on GCC warnings (for developers)@<:@default=no@:>@])],
> +  [case $enableval in
> +     yes|no) ;;
> +     *)      AC_MSG_ERROR([bad value $enableval for gcc-warnings option]) ;;
> +   esac
> +   git_gcc_warnings=$enableval],
> +  [git_gcc_warnings=no]
> +)
> +
> +AS_IF([test "x$git_gcc_warnings" = xyes ],[ 
> +# Add/Delete as needed
> +GIT_CC_CHECK_FLAGS_APPEND([with_cflags], [CFLAGS], [\
> +  -Wall  \
> +  -Wextra  \
> +  -Wformat-y2k  \
> +  -fdiagnostics-show-option \
> +  -funit-at-a-time \
> +  -fstrict-aliasing \
> +  -Wstrict-overflow \
> +  -fstrict-overflow \
> +  -Wpointer-arith \
> +  -Wundef \
> +  -Wformat-security \
> +  -Winit-self \
> +  -Wmissing-include-dirs \
> +  -Wunused \
> +  -Wunknown-pragmas \
> +  -Wstrict-aliasing \
> +  -Wshadow \
> +  -Wbad-function-cast \
> +  -Wcast-align \
> +  -Wwrite-strings \
> +  -Wlogical-op \
> +  -Waggregate-return \
> +  -Wstrict-prototypes \
> +  -Wold-style-definition \
> +  -Wmissing-prototypes \
> +  -Wmissing-declarations \
> +  -Wmissing-noreturn \
> +  -Wmissing-format-attribute \
> +  -Wredundant-decls \
> +  -Wnested-externs \
> +  -Winline \
> +  -Winvalid-pch \
> +  -Wvolatile-register-var \
> +  -Wdisabled-optimization \
> +  -Wbuiltin-macro-redefined \
> +  -Wmudflap \
> +  -Wpacked-bitfield-compat \
> +  -Wsync-nand \
> +  -Wattributes \
> +  -Wcoverage-mismatch \
> +  -Wmultichar \
> +  -Wcpp \
> +  -Wdeprecated-declarations \
> +  -Wdiv-by-zero \
> +  -Wdouble-promotion \
> +  -Wendif-labels \
> +  -Wformat-contains-nul \
> +  -Wformat-extra-args \
> +  -Wformat-zero-length \
> +  -Wformat=2 \
> +  -Wmultichar \
> +  -Wnormalized=nfc \
> +  -Woverflow \
> +  -Wpointer-to-int-cast \
> +  -Wpragmas \
> +  -Wsuggest-attribute=const \
> +  -Wsuggest-attribute=noreturn \
> +  -Wsuggest-attribute=pure \
> +  -Wtrampolines \
> +  -Wno-missing-field-initializers \
> +  -Wno-sign-compare \
> +  -Wjump-misses-init \
> +  -Wno-format-nonliteral \
> +  -fstack-protector-all \
> +  -fasynchronous-unwind-tables \
> +  -fdiagnostics-show-option \
> +  -funit-at-a-time \
> +  -fipa-pure-const \
> +  -Wno-aggregate-return \
> +  -Wno-redundant-decls \
> +  -Wdeclaration-after-statement ])
> +
> +GIT_CONF_SUBST([GIT_CFLAGS],[$with_cflags])
> +])
> +
>  
>  
>  ## Checks for programs.
