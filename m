From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0008: 4 tests fail with ksh88
Date: Fri, 20 May 2016 08:16:43 -0700
Message-ID: <xmqq37pchi90.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEhviK9KZxR6R6xzkZ5EAO-RjWj3xYah_DOSDXhEjYsT-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Fri May 20 17:16:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3mAa-0003Xl-DO
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 17:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbcETPQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 11:16:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56195 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752568AbcETPQv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 11:16:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 393C81BBB3;
	Fri, 20 May 2016 11:16:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zQg4XRYqlRCmu37rLrw5xd57BAA=; b=jdoR9z
	e/GE631gu0NgBy1lBwXYdPxBLGmbuHbA7HiyZdINfDb6FAo9KwG8Ev1/WQdI2YGT
	ACwViqVCvsZqh92jEb74MTZ4GEFvfcKtCna/FhDW9ioXCm6UrW1oZI9FKSMUQgkz
	DeMZW1fzkDI1Yfb/aoiq0yYx9lO27GtfGOMRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oH4lrLqUSA2wj6jeQmAoEhXTq0bLIBd7
	xsxr5FeQKAbQY61RFDAn/cmWNGQKk+ma5SRtYkQO5vYQEGSX5q05qOF9rR30TVDo
	KPWeg6ckcF0nwgVqBnY7dNTuqgLz+3cZqW6VJ01pddSjD8cYnRBi373MhU1weyEJ
	xL0tY0f1Z2Y=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F3411BBAF;
	Fri, 20 May 2016 11:16:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8EC11BBAA;
	Fri, 20 May 2016 11:16:44 -0400 (EDT)
In-Reply-To: <CALR6jEhviK9KZxR6R6xzkZ5EAO-RjWj3xYah_DOSDXhEjYsT-A@mail.gmail.com>
	(Armin Kunaschik's message of "Fri, 20 May 2016 16:31:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DCF39816-1E9D-11E6-AEF2-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295174>

Armin Kunaschik <megabreit@googlemail.com> writes:

> From: Armin Kunaschik <megabreit@googlemail.com>
>
> \" in the test t0008 is not treated the same way in bash and in ksh.

Could you refrain from singling out "bash"?  We don't write for
"bash" specifically (and the test I ran are with "dash" before I
push things out).

Ideally, if you can try ksh93 and if you find out that ksh93 works,
then the above can be made in line with your "Subject" to mark ksh88
as broken (as opposed to other POSIX shells)?  That would help us by
reminding that running test fine with ksh93 is not a sufficient
check to make sure we didn't break ksh88 users.

> In ksh the \ disappears and generates false expect data to
> compare with.
> Using \\" works portable, the same way in bash and in ksh and
> is less ambigous.

All of the above would need s/ksh/&88/g; I'd think.  I just tried

	make SHELL_PATH=/bin/ksh93
        cd t && /bin/ksh93 t0008-*.sh

and this patch is not necessary for ksh93.

> Acked-by: Jeff King <peff@peff.net>

I didn't see him acking this exact version, so if you didn't include
this line here, I would have missed it.  Thanks.

> Signed-off-by: Armin Kunaschik <megabreit@googlemail.com>
> ---
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index 89544dd..b425f3a 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -605,7 +605,7 @@ cat <<-EOF >expected-verbose
>         a/b/.gitignore:8:!on*   a/b/one
>         a/b/.gitignore:8:!on*   a/b/one one
>         a/b/.gitignore:8:!on*   a/b/one two
> -       a/b/.gitignore:8:!on*   "a/b/one\"three"
> +       a/b/.gitignore:8:!on*   "a/b/one\\"three"
>         a/b/.gitignore:9:!two   a/b/two
>         a/.gitignore:1:two*     a/b/twooo
>         $global_excludes:2:!globaltwo   globaltwo
> @@ -686,7 +686,7 @@ cat <<-EOF >expected-all
>         a/b/.gitignore:8:!on*   b/one
>         a/b/.gitignore:8:!on*   b/one one
>         a/b/.gitignore:8:!on*   b/one two
> -       a/b/.gitignore:8:!on*   "b/one\"three"
> +       a/b/.gitignore:8:!on*   "b/one\\"three"
>         a/b/.gitignore:9:!two   b/two
>         ::      b/not-ignored
>         a/.gitignore:1:two*     b/twooo
