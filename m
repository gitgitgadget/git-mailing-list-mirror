From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support wrapping commit messages when you read them
Date: Sun, 25 Dec 2011 01:57:13 -0800
Message-ID: <7vfwg99dom.fsf@alter.siamese.dyndns.org>
References: <8DE6E894-B50D-4F7E-AE18-C10E7E40A550@sidneysm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sidney San =?utf-8?Q?Mart=C3=ADn?= <s@sidneysm.com>
X-From: git-owner@vger.kernel.org Sun Dec 25 10:57:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RekpW-0004rt-EW
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 10:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885Ab1LYJ5S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Dec 2011 04:57:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55475 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629Ab1LYJ5Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Dec 2011 04:57:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47D374055;
	Sun, 25 Dec 2011 04:57:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JtzB8vpVJ9u3
	qCj+T4vCNVwnY3A=; b=JcpPm5ZhbQe+9SV/TardtBrk/Q/0BFNBwpqI8GD9l3wi
	iyDe1/mGLM9wbFrr9TSZc3a0x/aNq1sVbY4jf5KoFrxQkKfCB1wsGXj4l5aXBBgM
	aflEfVlf/TIM0mCcUnxc6V70CzpQ94jPeLkhHzBvPY4xk1IY+9haAMXilvofYsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fdL+gE
	KokQ50TBAf9hdXqmxAhL9OqJH3iAiJwmFeftr624BnTdBmVNS93kr1i+cCom0V8f
	joi2A964kiBCcffIa1J5brvSOSHvct16RYlU94mhGVaxCQyy495WlvC77UNzvCe8
	O+IBwZ6U92tTaQo9pu2+FiZO2BgONgX7JKfFY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F3BA4054;
	Sun, 25 Dec 2011 04:57:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 850294053; Sun, 25 Dec 2011
 04:57:14 -0500 (EST)
In-Reply-To: <8DE6E894-B50D-4F7E-AE18-C10E7E40A550@sidneysm.com> ("Sidney San
 =?utf-8?Q?Mart=C3=ADn=22's?= message of "Sat, 24 Dec 2011 21:05:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D269397C-2EDE-11E1-A9BF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187680>

Sidney San Mart=C3=ADn <s@sidneysm.com> writes:

> Fairly simpleminded line wrapping that makes commit messages
> readable if they weren=E2=80=99t wrapped by the committer.

This does not say anything useful, other than "this is a na=C3=AFve
implementation of message wrapper" and invites "So what?".

The most simple-minded solution is to reject such commits with crappy l=
og
message.

After all, SCM is merely a method to help communication between
developers, and sticking to the common denominator is a proven good way=
 to
make sure everybody involved in the project can use what is recorded in
the repository. This is not limited only to the log message, but equall=
y
applies to filenames (e.g. don't create xt_tcpmss.c and xt_TCPMSS.c in =
the
same directory if you want your project extractable on case insensitive
filesystems) and even to the sources.

You need to justify the cause a bit better. Why is such a new logic
justified?

> - Use strbuf_add_wrapped_text() to do the dirty work
> - Detect simple lists which begin with "+ ", "* ", or "- " and indent
>   them appropriately (like this line)
> - Print lines which begin with whitespace as-is (e.g. code samples)

I suspect the above would make it more palatable than format=3Dflowed
brought up in earlier discussions, which is unsuitable for nothing but
straight text.

> Add --wrap[=3D<width>] and --no-wrap to commands that pretty-print co=
mmit
> messages, and add log.wrap and log.wrap.width configuration options.

Why do you need two separate options and configurations that look as if
they are independent but in reality not?  If you say "no wrap", there i=
s
no room for you to say "wrap width is 72".

I would expect something like:

 --log-message-wrap, --log-message-wrap=3D72, --log-message-wrap=3Dno=20

with --log-message-wrap=3Dyes as a synonym for --log-message-wrap to gi=
ve
consistency. The corresponding configuraiton would be log.messageWrap
whose values could be the usual bool-or-int.

> log.wrap defaults to never, and can be set to never/false, auto/true,
> or always. If auto, hijack want_color() to decide whether it=E2=80=99=
s
> appropriate to use line wrapping. (This is a little hacky, but as far
> as I can tell the conditions for auto color and auto wrapping are the
> same.

Why does coloring have _anything_ to do with line wrapping? Maybe your
personaly preference might be "wrap and color if interactive terminal" =
but
that is conflating two unrelated concepts. A user may not expect colori=
ng
on a dumb interactive terminal, but wrapping may still be useful.

> log.wrap.width defaults to 80.

This does not deserve a comment as I already rejected the "two
configuration" approach, but do not use three-level names this way. We =
try
to reserve three-level names only for cases where the second level is u=
sed
for an unbound collection (e.g. "remote.$name.url", "branch.$name.merge=
").
that is user-specified.
