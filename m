From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] configure.ac: add new autoconf macro for checking valid compiler flags
Date: Mon, 03 Nov 2014 11:39:44 -0800
Message-ID: <xmqq61ewrs3j.fsf@gitster.dls.corp.google.com>
References: <1415026641-24767-1-git-send-email-gitter.spiros@gmail.com>
	<1415026641-24767-2-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jnareb@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 20:39:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlNTj-00034Y-Tu
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbaKCTjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:39:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752144AbaKCTjr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:39:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DF7D1A782;
	Mon,  3 Nov 2014 14:39:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d+oXR9jrLWqJ7TIfKzoIsexMe3w=; b=X+N9WQ
	7kKdAB97xvGc+ur+ZrpUR3orf3GGbYwIYxrrMxRHeCY5v800HolRIsL23MTktAuI
	eCBMi0rU6KXih5pCBTEhWkYt5vsHwCd2QCf+cD9Kdn4yBoS1ifLJqtPWBbcgcirg
	3vynUvd8X5xwVXoYcvBLJtBq+tPHe9a+TIVeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fcFOpGqaW9v3+blyKEUceaze44qSXWxl
	DZ3+uVwGlqgW5Ddq/AJBnkNhduDc0NnQVWT325+Gu228cvrLHPvS14IwNbbW6sxA
	WOjEjI2tKvuRXaKAKYq02QxC4tPtEFJJkUqX0vkH7kIib4/mX1iDTdmLTuO8RZgd
	pxKH7CNhhgM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7541A1A781;
	Mon,  3 Nov 2014 14:39:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EEC041A780;
	Mon,  3 Nov 2014 14:39:45 -0500 (EST)
In-Reply-To: <1415026641-24767-2-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Mon, 3 Nov 2014 06:57:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2A597374-6391-11E4-9B66-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> Add GIT_CC_CHECK_FLAG_APPEND, GIT_CC_CHECK_FLAGS_APPEND
> and GIT_CC_CHECK_LDFLAGS autoconf macro.

... which does what and for what purpose?

Don't explain it to me in your response, or tell me to read the
patch text.  I am speaking for those who have to read "git log"
output down the line and need to get the big picture.

In the bigger picture, what is important is "why" than "how".

You add a handy way to give list of possible compilation flags and
add as many of them as we can without triggering errors to CFLAGS
and LDFLAGS.  Why is that a good thing to do?  What kind of
compilation flags you are planning to throw at these macros?  I
think a mere mention of the latter will be sufficient to remind the
reader why this change would be a good idea.

>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  Makefile     |    6 ++++--
>  configure.ac |   45 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 827006b..23485f1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -344,10 +344,12 @@ GIT-VERSION-FILE: FORCE
>  	@$(SHELL_PATH) ./GIT-VERSION-GEN
>  -include GIT-VERSION-FILE
>  
> +GIT_CFLAGS  =
> +GIT_LDFLAGS =
>  # CFLAGS and LDFLAGS are for the users to override from the command line.
>  
> -CFLAGS = -g -O2 -Wall
> -LDFLAGS =
> +CFLAGS = -g -O2 -Wall $(GIT_CFLAGS)
> +LDFLAGS = $(GIT_LDFLAGS)
>  ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)
>  STRIP ?= strip
> diff --git a/configure.ac b/configure.ac
> index 6af9647..c67ca60 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -139,6 +139,51 @@ if test -n "$1"; then
>  fi
>  ])
>  
> +
> +dnl Check if FLAG in ENV-VAR is supported by compiler and append it
> +dnl to WHERE-TO-APPEND variable
> +dnl GIT_CC_CHECK_FLAG_APPEND([WHERE-TO-APPEND], [ENV-VAR], [FLAG])
> +
> +AC_DEFUN([GIT_CC_CHECK_FLAG_APPEND], [
> +  AC_CACHE_CHECK([if $CC supports flag $3 in envvar $2],
> +                 AS_TR_SH([cc_cv_$2_$3]),
> +          [eval "AS_TR_SH([cc_save_$2])='${$2}'"
> +           eval "AS_TR_SH([$2])='-Werror $3'"
> +           AC_LINK_IFELSE([AC_LANG_SOURCE([int a = 0; int main(void) { return a; } ])],
> +                          [eval "AS_TR_SH([cc_cv_$2_$3])='yes'"],
> +                          [eval "AS_TR_SH([cc_cv_$2_$3])='no'"])
> +           eval "AS_TR_SH([$2])='$cc_save_$2'"])
> +
> +  AS_IF([eval test x$]AS_TR_SH([cc_cv_$2_$3])[ = xyes],
> +        [eval "$1='${$1} $3'"])
> +])
> +
> +dnl GIT_CC_CHECK_FLAGS_APPEND([WHERE-TO-APPEND], [ENV-VAR], [FLAG1 FLAG2])
> +AC_DEFUN([GIT_CC_CHECK_FLAGS_APPEND], [
> +  for flag in $3; do
> +    GIT_CC_CHECK_FLAG_APPEND($1, $2, $flag)
> +  done
> +])
> +
> +dnl Check if the flag is supported by linker (cacheable)
> +dnl GIT_CC_CHECK_LDFLAGS([FLAG], [ACTION-IF-FOUND],[ACTION-IF-NOT-FOUND])

Missing SP after comma?  I do not particularly mind commas without
leading SP in m4 source, but please be consistent unless there is a
compelling reason not to (and I do not think there is in this case).

> +
> +AC_DEFUN([GIT_CC_CHECK_LDFLAGS], [
> +  AC_CACHE_CHECK([if $CC supports $1 flag],
> +    AS_TR_SH([cc_cv_ldflags_$1]),
> +    [ac_save_LDFLAGS="$LDFLAGS"
> +     LDFLAGS="$LDFLAGS $1"
> +     AC_LINK_IFELSE([int main() { return 1; }],
> +       [eval "AS_TR_SH([cc_cv_ldflags_$1])='yes'"],
> +       [eval "AS_TR_SH([cc_cv_ldflags_$1])="])
> +     LDFLAGS="$ac_save_LDFLAGS"
> +    ])
> +
> +  AS_IF([eval test x$]AS_TR_SH([cc_cv_ldflags_$1])[ = xyes],
> +    [$2], [$3])
> +])
> +
> +
>  ## Configure body starts here.
>  
>  AC_PREREQ(2.59)
