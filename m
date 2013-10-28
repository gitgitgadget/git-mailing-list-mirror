From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] graph.c: visual difference on subsequent series
Date: Mon, 28 Oct 2013 10:39:16 -0700
Message-ID: <xmqqsivlfg6z.fsf@gitster.dls.corp.google.com>
References: <1382717268-21884-1-git-send-email-milton.soares.filho@gmail.com>
	<xmqqeh79jmtr.fsf@gitster.dls.corp.google.com>
	<CAPNngRMP29s9gZg9R987yRd2qJ=UuaMWnFphtQdGDRgG_SCxsQ@mail.gmail.com>
	<87mwlwn4e0.fsf@gmail.com>
	<xmqqeh75h087.fsf@gitster.dls.corp.google.com>
	<CAPNngRMprE3QwDn3y74QqitAs+-DCBm1oO33uKRHsn9jLrNSnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keshav Kini <keshav.kini@gmail.com>, git@vger.kernel.org
To: Milton Soares Filho <milton.soares.filho@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 18:39:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vaqmi-0000YI-Te
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 18:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184Ab3J1RjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 13:39:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44947 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756643Ab3J1RjU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 13:39:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 463584E346;
	Mon, 28 Oct 2013 17:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UWfCvJWkpUSdGU0iQCFJGCUb238=; b=VA3Rpo
	wCfz1uUL67IvjokzewlZfMAgf+daznWP/72fgWxKbeWUNz1m1Fm5NmhXEwXYqliJ
	kbWgKl9e8baNbNsDF2UyD40Y724k17IGZ8qC84R0PIs36a4So/sxnAKh2qERfLbh
	aZ1M28+NoKoAFsEESNpfY+GWkK98/CPNUzrEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v0u8Dgce7vu1ycD9IW0qbO6IqNz0/GmP
	wx57NT3FniSN2WxQB59VJaIPWaX/J6nMlm9VvS7tlQBdKclNDKRFaZp03Xpx65Hp
	D1XC+4pw+bDBtvkujXWwxsaZgpaXGvS2B3hILSYi3BBjrxx4YGSr5QFRpETT2fLa
	Id5PPSPq+lA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3980E4E345;
	Mon, 28 Oct 2013 17:39:19 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 799864E344;
	Mon, 28 Oct 2013 17:39:18 +0000 (UTC)
In-Reply-To: <CAPNngRMprE3QwDn3y74QqitAs+-DCBm1oO33uKRHsn9jLrNSnA@mail.gmail.com>
	(Milton Soares Filho's message of "Mon, 28 Oct 2013 15:18:31 -0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DF2E6340-3FF7-11E3-A766-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236843>

Milton Soares Filho <milton.soares.filho@gmail.com> writes:

> On 28 October 2013 13:41, Junio C Hamano <gitster@pobox.com> wrote:
>> I agree to all of the above, including the ugliness of 'x' ;-)
>>
>> A "blank" may however be hard to spot, if the range is limited,
>> though.  For example,
>
> A 'x' looks like termination points in some specification languages
> such as SDL and MSC and thus translates directly to the idea of a
> root-commit, at least IMO. For sure it does not stand out as blatantly
> as it should, but it gives a general idea without further
> distractions, which seems to be the idea of a simple 'git log --graph
> --oneline'.
>
> An idea that have just come to mind is to have a decorator to enforce
> this property, like this.
>
>       * HEAD
>      /* a1
>     | * a2
>     | * a3
>     | x a4 (root-commit)
>     * b1
>     * b2
>     x b3  (root-commit)
>
> This way the user only gets 'distracted' if he explicitly asks for it
> (--decorate), with all its colors and whatnot. What do you think?
> Should I aim for it?
>
> Besides anything else, this discussion is becoming very subjective.

If I have to choose, I'd rather avoid using 'x' or anything that
have to override '*', not just 'x' being ugly, but the approach to
_replace_ the "revision-mark" (usually '*' but sometimes '<', '^',
etc) forces us to give priority between "root-ness" and other kinds
of information (e.g. "left-ness").  That was the primary reason I
liked Keshav's suggestion to use one extra line _below_ the root,
which will allow us to still keep the existing information unlike
what we discussed in our back-and-forth during the initial review.

I also think a blank (or divider) below the root commits does make
it visually obvious that nothing comes _before_ the root commit in
the history, which probably even removes the need to paint the
tracks of histories leading to different roots in different colours.

I hope the above shows that my reaction was much less subjective
than my response sounded ;-)

Thanks.
