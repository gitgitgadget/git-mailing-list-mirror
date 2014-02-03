From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] userdiff: update Ada patterns
Date: Mon, 03 Feb 2014 12:00:27 -0800
Message-ID: <xmqqppn4dl0k.fsf@gitster.dls.corp.google.com>
References: <52EE234C.1060002@redneon.com>
	<20140202233531.GE16196@sigill.intra.peff.net>
	<52EF7E7C.3070504@redneon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Adrian Johnson <ajohnson@redneon.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 21:00:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPh6-0005dv-9t
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 21:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbaBCUAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 15:00:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42551 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbaBCUAb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 15:00:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B45E7696A4;
	Mon,  3 Feb 2014 15:00:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z9uF2tkfHBucqbwgrcmWw9ZJ+z8=; b=wb6V4z
	YD3AW4Whco5a0u3B+TOGucFHsIexFhWyWaS96KCd/F9xqlwE22I5qgAXm3pWCgM5
	x9wlvKGDtWsDxkEgKWeg967XX+pqKsHnwh0P+V3rtkoW2Grb751B8xgufkUULIVW
	m+tkoroXi/hR8dOBMVnPk0Gu0ZCeCauDInRgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bZx4sqDAaYAfbY09NzPpX40Ywqu3l+l5
	9ct+9NkyeMRpLKWlTzDfsMIZJu6uIwOBbxeRqNPZi+1GFsUC9Q2M9mFiM1v2wzTb
	nkBU4iM67QQ5WrtKbnfE+x+kBTUwSLhDkdUyhduPbQ/kKiEvz+WlqUXzDOlT2vxs
	q/weM0m6mjQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8729B696A0;
	Mon,  3 Feb 2014 15:00:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A74666969F;
	Mon,  3 Feb 2014 15:00:29 -0500 (EST)
In-Reply-To: <52EF7E7C.3070504@redneon.com> (Adrian Johnson's message of "Mon,
	03 Feb 2014 22:03:16 +1030")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D4E275BC-8D0D-11E3-9207-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241467>

Adrian Johnson <ajohnson@redneon.com> writes:

> - Allow extra space in "is new" and "is separate"
> - Fix bug in word regex for numbers
>
> Signed-off-by: Adrian Johnson <ajohnson@redneon.com>
> ---
>  t/t4034/ada/expect | 2 +-
>  userdiff.c         | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t4034/ada/expect b/t/t4034/ada/expect
> index be2376e..a682d28 100644
> --- a/t/t4034/ada/expect
> +++ b/t/t4034/ada/expect
> @@ -4,7 +4,7 @@
>  <BOLD>+++ b/post<RESET>
>  <CYAN>@@ -1,13 +1,13 @@<RESET>
>  Ada.Text_IO.Put_Line("Hello World<RED>!<RESET><GREEN>?<RESET>");
> -1 1e<RED>-<RESET>10 16#FE12#E2 3.141_592 '<RED>x<RESET><GREEN>y<RESET>'
> +1 <RED>1e-10<RESET><GREEN>1e10<RESET> 16#FE12#E2 3.141_592 '<RED>x<RESET><GREEN>y<RESET>'
>  <RED>a<RESET><GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
>  <RED>a<RESET><GREEN>y<RESET>
>  <GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b<RESET>
> diff --git a/userdiff.c b/userdiff.c
> index ea43a03..10b61ec 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -15,13 +15,13 @@ static int drivers_alloc;
>  	  word_regex "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" }
>  static struct userdiff_driver builtin_drivers[] = {
>  IPATTERN("ada",
> -	 "!^(.*[ \t])?(is new|renames|is separate)([ \t].*)?$\n"
> +	 "!^(.*[ \t])?(is[ \t]+new|renames|is[ \t]+separate)([ \t].*)?$\n"
>  	 "!^[ \t]*with[ \t].*$\n"
>  	 "^[ \t]*((procedure|function)[ \t]+.*)$\n"
>  	 "^[ \t]*((package|protected|task)[ \t]+.*)$",
>  	 /* -- */
>  	 "[a-zA-Z][a-zA-Z0-9_]*"
> -	 "|[0-9][-+0-9#_.eE]"
> +	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"

This would match a lot wider than what I read you said you wanted to
match in your previous message.  Does "-04##4_3_2Ee-9" count as a
number, for example, or can we just ignore such syntactically
incorrect sequence?

>  	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
>  IPATTERN("fortran",
>  	 "!^([C*]|[ \t]*!)\n"
