From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] exec_cmd.c, sideband.c, Makefile: avoid multiple PREFIX definitions
Date: Thu, 05 May 2016 15:02:17 -0700
Message-ID: <xmqqk2j89n9y.fsf@gitster.mtv.corp.google.com>
References: <1462483733-3496-1-git-send-email-philipoakley@iee.org>
	<1462483733-3496-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GitList <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git-for-windows <git-for-windows@googlegroups.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri May 06 00:02:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayRLl-0001S2-0Z
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 00:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756644AbcEEWCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 18:02:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53547 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756245AbcEEWCU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 18:02:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B7A7189AD;
	Thu,  5 May 2016 18:02:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GcFwETs5D0CNprTKo0z3i3stmW8=; b=id6Py/
	fgd1hPTsr1JdZgX+KlyTfTNXmCEalnJSBk5ungoQrH4pYgbsYTHwqB2ZAjFGorzr
	90fnk3KftTM/0sSEng5ErSp2H+j6/mzKwqxpcl2UTYXHX6hTA53uQxUDWbumeTNk
	HVA3LKWWnfzoTY2cwM6FK9GZsuBP7chCPrqHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xpkQYeb32SR6OqisdgoWEkAHJ9paYRSJ
	vsK1oLrn8QPtpQTC7kpNB9ennegYJw4cqNl+X/SY3Wg32SanZnCcvFQh0NvB9J58
	6bu9gSyMIrbM8zhx8HL6SKNH74/wBI4y9KWmOgwX7R2MvlC2TUDl6bYR56c+rlte
	IeAMDpmtqu0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 53711189AC;
	Thu,  5 May 2016 18:02:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5B55189AB;
	Thu,  5 May 2016 18:02:18 -0400 (EDT)
In-Reply-To: <1462483733-3496-2-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Thu, 5 May 2016 22:28:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0904FDE2-130D-11E6-AC1D-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293711>

Philip Oakley <philipoakley@iee.org> writes:

> The short and sweet PREFIX can be confused when used in many places.
>
> Rename both usages to better describe their purpose.
>
> Noticed when compiling Git for Windows using MSVC/Visual Studio which
> reports the conflict beteeen the command line definition and the
> definition in sideband.c

Good eyes.

>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  Makefile   | 2 +-
>  exec_cmd.c | 4 ++--
>  sideband.c | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 33b0f76..bcdd3ec 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1973,7 +1973,7 @@ exec_cmd.sp exec_cmd.s exec_cmd.o: GIT-PREFIX
>  exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
>  	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
>  	'-DBINDIR="$(bindir_relative_SQ)"' \
> -	'-DPREFIX="$(prefix_SQ)"'
> +	'-DEXEC_PREFIX="$(prefix_SQ)"'

I am not entirely happy with this name as the name can be easily
confused with GIT_EXEC_PATH.

This is a fallback used under RUNTIME_PREFIX option, if I am reading
the code correctly, so the name should hint the linkage between the
"runtime prefix" mechanism and this variable.

Perhaps RUNTIME_PREFIX_FALLBACK?  Used at only two places, that
should not be an overlong name.

DISPLAY_PREFIX is OK, as it is an entirely a local thing to
sideband.c, but with the externally visible PREFIX fixed to be a
more appropriate name that hints its relation with the "runtime
prefix" mechanism, it may be better not to even touch it.

>  builtin/init-db.sp builtin/init-db.s builtin/init-db.o: GIT-PREFIX
>  builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
> diff --git a/exec_cmd.c b/exec_cmd.c
> index 9d5703a..2a79781 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -12,7 +12,7 @@ char *system_path(const char *path)
>  #ifdef RUNTIME_PREFIX
>  	static const char *prefix;
>  #else
> -	static const char *prefix = PREFIX;
> +	static const char *prefix = EXEC_PREFIX;
>  #endif
>  	struct strbuf d = STRBUF_INIT;
>  
> @@ -27,7 +27,7 @@ char *system_path(const char *path)
>  	    !(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
>  	    !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
>  	    !(prefix = strip_path_suffix(argv0_path, "git"))) {
> -		prefix = PREFIX;
> +		prefix = EXEC_PREFIX;
>  		trace_printf("RUNTIME_PREFIX requested, "
>  				"but prefix computation failed.  "
>  				"Using static fallback '%s'.\n", prefix);
