From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] parse-options: allow positivation of options
 starting, with no-
Date: Mon, 27 Feb 2012 09:18:28 -0800
Message-ID: <7v8vjob3ff.fsf@alter.siamese.dyndns.org>
References: <4F49317A.3080809@lsrfire.ath.cx>
 <4F49332E.7070003@lsrfire.ath.cx> <7vy5rpcgrk.fsf@alter.siamese.dyndns.org>
 <87d390smpa.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	<git@vger.kernel.org>, Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 27 18:18:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S24De-0001x8-8Q
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 18:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740Ab2B0RSc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 12:18:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49351 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753573Ab2B0RSb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 12:18:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E37FB65C7;
	Mon, 27 Feb 2012 12:18:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OkkHY/ZN5DS7
	AqgQIY51ODsfsUs=; b=v/pMy0SyHGqfGjrNAu4Z6UvP9fThL6vm/OErUqOVCbiY
	N7xosKY8MwocPylbJyB3fcUM1a3zVpZ0PxdgWcMMzrhK6lUQlB6ByaTRhitql9yy
	E4msiFqIIbOUiLCXE/TwEx5haVwXkAMsu4+SPF3Vk6K3ht9MFKw5J0q2LRz34JY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QBqFNx
	7cMQaWTd7UVnSiqxYmVdiPWHQZEn4DXBl8oakfO9tzYoYKO1ZahtAqbQQ1EJLgiw
	1bF9YNp9r3p2zNulqGxiPYSKpx8NZASMQeNbGmY9tH/hR9SROnBDrP3s19ceIv1J
	ZPKfRTGEt1R/2JVDwSVR6frjwigKFiINlpcgA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D928165C6;
	Mon, 27 Feb 2012 12:18:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61A6165C5; Mon, 27 Feb 2012
 12:18:30 -0500 (EST)
In-Reply-To: <87d390smpa.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Mon, 27 Feb 2012 09:30:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11B096F6-6167-11E1-8C68-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191631>

Thomas Rast <trast@inf.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I would na=C3=AFvely expect that it would be sufficient to update an=
 existing
>> definition for "--no-frotz" that uses PARSE_OPT_NONEG to instead def=
ine
>> "--frotz" that by itself is a no-op, and "--no-frotz" would cause wh=
atever
>> the option currently means, with an update to the help text that say=
s
>> something to the effect that "--frotz by itself is meaningless and i=
s
>> always used as --no-frotz".
>
> Doesn't that last quote already answer your question?

Yes, but only partly.  I would agree with the awkwardness in

> It would be rather awkward to see, in 'git apply -h',
>
>   --add                 Also apply additions in the patch.  This is t=
he
>                         default; use --no-add to disable it.

but it feeels somewhat questionable that the solution to get this:

>
> Compare to the current concise wording
>
>   --no-add              ignore additions made by the patch

is to define OPT_BOOL("no-add") that does not have any hint (other than
the fact that the option name begins with 3 character "no-") that this =
is
an already negated boolean and the "no-" negation can be removed.

This means an option "no-$foo" can never mean anything but "not foo".  =
Not
that we would have to or necessarily want to support an option to give =
the
number of foo as --no-foo=3D47, as --num-foo=3D47 is a perfectly good s=
pelling
for such an option.

If it were OPT_BOOL("no-foo", OPT_ISNEG | ...) that signals the parser
that:

 - the option name is already negative;
 - the leading "no-" is to be removed to negate it; and
 - no extra leading "no-", i.e. "--no-no-foo", is accepted.

I probably wouldn't have felt this uneasy iffiness.

But it is just a minor issue.
