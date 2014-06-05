From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] userdiff: support C# async methods and correct C# keywords
Date: Thu, 05 Jun 2014 15:59:31 -0700
Message-ID: <xmqqy4xbq7xo.fsf@gitster.dls.corp.google.com>
References: <1401682405-3319-1-git-send-email-ch3cooli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sup Yut Sum <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 00:59:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsgdM-0007S5-3o
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 00:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbaFEW7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 18:59:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54465 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471AbaFEW7j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 18:59:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A5F7A1E204;
	Thu,  5 Jun 2014 18:59:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=GxJvE4+h+rtFDlR/hU6YY0aiojg=; b=SlLdEpefGkgeCI3VB8tF
	bmqpC0B9EaBUJz2KgyO1vhr0I99zWrTg+fjOQYvU1UibEYZjlhGRZNSsg5mGNJaw
	KfiqbtO73MExXZBgt2ekw4z3OM41yG0MlzQU6Ha5x/iw0SmK9P1rBGOCJ23ao6rf
	yXnqA8ENm2pVwOV9qvTixcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=sE5Nn5rx24V3X9P/iIDs2JjwEfBBT3+ZLNqwKZXhsHngsZ
	mgGUNwuuUjnyYFBwQhrpDJ9+mvsoQGjvi/Je/lE2NAemHQkZu5cew6ceuvZfyzLq
	GtPLGj9iD0p8SvAoLsu8CV2WaSxDn7uc/VtRKvHItumeOt2wkpNJ0AjaWQl6g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C2EE1E203;
	Thu,  5 Jun 2014 18:59:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C26ED1E1FF;
	Thu,  5 Jun 2014 18:59:32 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0EACF824-ED05-11E3-83C5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250873>

Sup Yut Sum <ch3cooli@gmail.com> writes:

> async is in C# 5.0
> foreach is in C# 1.0

> instanceof is in Java. The similar keywords are typeof, is, as in C# 1.0

This one made me read it twice, until I realized you meant

    instanceof() is listed as keywords, but there is no such thing
    (it is in Java, though); in C# we use typeof() for similar
    purposes

> default, try are in C# 1.0
>
> Signed-off-by: Sup Yut Sum <ch3cooli@gmail.com>
> ---
>  userdiff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/userdiff.c b/userdiff.c
> index fad52d6..96eda6c 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -134,9 +134,9 @@ PATTERNS("cpp",
>  	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
>  PATTERNS("csharp",
>  	 /* Keywords */
> -	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
> +	 "!^[ \t]*(do|while|for|foreach|if|else|typeof|is|as|new|return|switch|case|default|throw|try|catch|using)\n"
>  	 /* Methods and constructors */
> -	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
> +	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe|async)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
>  	 /* Properties */
>  	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
>  	 /* Type definitions */
