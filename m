From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] test: use unambigous leading path (/foo) for mingw
Date: Fri, 13 Sep 2013 12:51:04 -0700
Message-ID: <xmqqtxhoijpz.fsf@gitster.dls.corp.google.com>
References: <cover.1379048276.git.worldhello.net@gmail.com>
	<6533cbb59cd4de1d616ef62898f64a5cd144a561.1379048276.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 21:51:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKZOd-0003q7-Gj
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 21:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692Ab3IMTvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 15:51:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36600 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348Ab3IMTvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 15:51:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6816F417F6;
	Fri, 13 Sep 2013 19:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dZRelSiUtqi+Mwk0EYvNcsU7eV8=; b=LXwKzV
	aCl2Wy69Tc4XqhvOwThPYS+UtK1C2QKMOYLWnAYNGoOp5mf7rrUoXOFz0JQ32DM/
	5lzvHBaWQtC/uy/ggighG2XRza9q5WiJO2A8hj/fbjlgwU8x2/qNHZTuI8opKrJJ
	fuKHglPvZGM/lB3oinaTgEq5RYVtPmLZgtMa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qk8bGcfUqiajkbCVTLOf1JmsHAEWYaUT
	tJeMm9P4tZN9+ZpNbyj6v/j43IXALALT2FNr9SHuuXQztaeKfbaGZ1pLfWTMbiBD
	/mIHfFsb47WDyaOOb/nQBh/SfP6PBFl5mlLUkESQL7Ieac0zC5GiRXDPhdByQt9r
	07DcOGxq2j8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B33F417F5;
	Fri, 13 Sep 2013 19:51:08 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 91CAD417EA;
	Fri, 13 Sep 2013 19:51:07 +0000 (UTC)
In-Reply-To: <6533cbb59cd4de1d616ef62898f64a5cd144a561.1379048276.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Fri, 13 Sep 2013 13:08:12 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D4D3DD7A-1CAD-11E3-9B48-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234764>

Jiang Xin <worldhello.net@gmail.com> writes:

> In test cases for relative_path, path with one leading character
> (such as /a, /x) may be recogonized as "a:/" or "x:/" if there is
> such doc drive on MINGW platform. Use an umambigous leading path
> "/foo" instead.

"DOS drive", you mean?

Are they really spelled as /a or /x (not e.g. //a or something)?

Just double-checking.

> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  t/t0060-path-utils.sh | 56 +++++++++++++++++++++++++--------------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 3a48de2..82a6f21 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -190,33 +190,33 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
>  	test "$sym" = "$(test-path-utils real_path "$dir2/syml")"
>  '
>  
> -relative_path /a/b/c/	/a/b/		c/
> -relative_path /a/b/c/	/a/b		c/
> -relative_path /a//b//c/	//a/b//		c/	POSIX
> -relative_path /a/b	/a/b		./
> -relative_path /a/b/	/a/b		./
> -relative_path /a	/a/b		../
> -relative_path /		/a/b/		../../
> -relative_path /a/c	/a/b/		../c
> -relative_path /a/c	/a/b		../c
> -relative_path /x/y	/a/b/		../../x/y
> -relative_path /a/b	"<empty>"	/a/b
> -relative_path /a/b 	"<null>"	/a/b
> -relative_path a/b/c/	a/b/		c/
> -relative_path a/b/c/	a/b		c/
> -relative_path a/b//c	a//b		c
> -relative_path a/b/	a/b/		./
> -relative_path a/b/	a/b		./
> -relative_path a		a/b		../
> -relative_path x/y	a/b		../../x/y
> -relative_path a/c	a/b		../c
> -relative_path a/b	"<empty>"	a/b
> -relative_path a/b 	"<null>"	a/b
> -relative_path "<empty>"	/a/b		./
> -relative_path "<empty>"	"<empty>"	./
> -relative_path "<empty>"	"<null>"	./
> -relative_path "<null>"	"<empty>"	./
> -relative_path "<null>"	"<null>"	./
> -relative_path "<null>"	/a/b		./
> +relative_path /foo/a/b/c/	/foo/a/b/	c/
> +relative_path /foo/a/b/c/	/foo/a/b	c/
> +relative_path /foo/a//b//c/	//foo/a/b//	c/		POSIX
> +relative_path /foo/a/b		/foo/a/b	./
> +relative_path /foo/a/b/		/foo/a/b	./
> +relative_path /foo/a		/foo/a/b	../
> +relative_path /			/foo/a/b/	../../../
> +relative_path /foo/a/c		/foo/a/b/	../c
> +relative_path /foo/a/c		/foo/a/b	../c
> +relative_path /foo/x/y		/foo/a/b/	../../x/y
> +relative_path /foo/a/b		"<empty>"	/foo/a/b
> +relative_path /foo/a/b 		"<null>"	/foo/a/b
> +relative_path foo/a/b/c/	foo/a/b/	c/
> +relative_path foo/a/b/c/	foo/a/b		c/
> +relative_path foo/a/b//c	foo/a//b	c
> +relative_path foo/a/b/		foo/a/b/	./
> +relative_path foo/a/b/		foo/a/b		./
> +relative_path foo/a		foo/a/b		../
> +relative_path foo/x/y		foo/a/b		../../x/y
> +relative_path foo/a/c		foo/a/b		../c
> +relative_path foo/a/b		"<empty>"	foo/a/b
> +relative_path foo/a/b 		"<null>"	foo/a/b
> +relative_path "<empty>"		/foo/a/b	./
> +relative_path "<empty>"		"<empty>"	./
> +relative_path "<empty>"		"<null>"	./
> +relative_path "<null>"		"<empty>"	./
> +relative_path "<null>"		"<null>"	./
> +relative_path "<null>"		/foo/a/b	./
>  
>  test_done
