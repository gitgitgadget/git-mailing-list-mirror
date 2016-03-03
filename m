From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: talk about pager in api-trace.txt
Date: Thu, 03 Mar 2016 08:51:21 -0800
Message-ID: <xmqqfuw733p2.fsf@gitster.mtv.corp.google.com>
References: <1456755680-4335-1-git-send-email-chriscool@tuxfamily.org>
	<20160229213152.GC25342@sigill.intra.peff.net>
	<CAP8UFD38odsz=fwE9E+0fVJXFE-4vwL1vTQT0rshyCAUYO1fcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 17:51:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abWTK-0005KM-9R
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 17:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755039AbcCCQvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 11:51:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63999 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751530AbcCCQvY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 11:51:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 970F24728D;
	Thu,  3 Mar 2016 11:51:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Um1zPWkzAHy+95glJwA2mU5ggqo=; b=wetIEI
	59QcDNErfJ+vQ6PEejx2HEJHxLYT5Oq4LWeZvNnBJMT00wxulyOGJzSgZYYjsK1O
	+UiOt9ged/saAhCdctH3u3FJ+gopaPwa6vPJalMPSLxwZT7ZxJ8S8aT1DVBFFeDb
	uMqOsN0tXNxRb2PQwHG1ADPXmS9wJ8l0cgLnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uf48CY4nvmXETb8jyC34g0gFJOadeWCv
	HVdiBlf4IKr4GRDcLHhgt/1h9RoMdsUUBi9end5RANqiWXgvXmse38HwyOezufOX
	jH+lW92N9eQLUyCnAnjPT2uPM/Q3X7BLz8AeYFQgeWTVX8hPE5dYnLXOlgJ/uDUT
	q8zgOc8mCxI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8EF114728C;
	Thu,  3 Mar 2016 11:51:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EED554728B;
	Thu,  3 Mar 2016 11:51:22 -0500 (EST)
In-Reply-To: <CAP8UFD38odsz=fwE9E+0fVJXFE-4vwL1vTQT0rshyCAUYO1fcw@mail.gmail.com>
	(Christian Couder's message of "Thu, 3 Mar 2016 10:17:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 294BB804-E160-11E5-A1A0-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288190>

Christian Couder <christian.couder@gmail.com> writes:

> Junio do you plan to merge this patch or would you prefer something like:
>
> +
> +Bugs & Caveats
> +--------------
> +
> +Some git commands, like `git log`, are run by default using a
> +pager. In this case, stdout and stderr are redirected to the pager and
> +are closed when the pager exits.
> +
> +If a GIT_TRACE* environment variable has been set to "1" or "2" to
> +print traces on stderr, no trace output will be printed after the
> +pager has exited.
> +
> +This can be annoying, because GIT_TRACE_PERFORMANCE by default prints
> +the performance stats for the whole command at atexit() time which
> +happens after the pager has exited.
> +
> +So the following command will print no performance stat:
> +
> +------------
> +GIT_TRACE_PERFORMANCE=2 git log -1
> +------------
> +
> +To overcome this problem, you can use for example:
> +
> +------------
> +GIT_TRACE_PERFORMANCE=2 git --no-pager log -1
> +------------
>
> ?

Should I take either one?  Which one do you prefer and why?

I do not have strong preference between the two.  I understand that
the differences are only in the example workarounds.  And I do not
think the common parts of the two patches are that great.

Even though I think the first two paragraphs do not tell a lie, I
think they are overly verbose, tell irrelevant details and does not
highlight the real issue.  You only want to say

	GIT_TRACE_* environment variables can be used to tell Git to
	show trace output to its standard error stream.  Git can
	often spawn a pager internally to run its subcommand and
	send its standard output and standard error to it.

The third paragraph is misleading.  "by default prints ... at
atexit() time" sounds as if you are hinting that the solution would
be to use some non-default way to tell it to print the stats at some
other time before atexit() to ensure that the output is done before
the pager exits, but that is not actually what you are going to
suggest.

The real source of the annoyance is not that trace output will not
be seen after the pager exits, but that PERFORMANCE trace does not
begin until the pager exits, which by definition means you would see
nothing.  "This can be annoying" is an understatement (because
sending PERFORMANCE output to pager always gives an annoying
result), and blames a wrong thing at the same time (because the fact
that trace output are sent to pager together with the program output
is not what makes it annoying; the real culprit is that PERFORMANCE
output comes only after pager exits).

I'd replace it with something like this, if I were writing this patch.

	Because GIT_TRACE_PERFORMANCE trace is generated only at the
	very end of the program with atexit(), which happens after
	the pager exits, it would not work well if you send its log
	to the standard error output and let Git spawn the pager at
	the same time.

That would make "So the following ... no performance stat:"
unnecessary, and the workarounds more obvious.  You can choose not
to use the pager, or you can send the trace output to a file.
