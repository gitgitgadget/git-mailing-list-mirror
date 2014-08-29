From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pretty: Provide a strict ISO8601 date format
Date: Fri, 29 Aug 2014 11:59:12 -0700
Message-ID: <xmqqwq9r5dhb.fsf@gitster.dls.corp.google.com>
References: <1409331522-8457-1-git-send-email-bbolli@ewanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Beat Bolli <bbolli@ewanet.ch>
X-From: git-owner@vger.kernel.org Fri Aug 29 20:59:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNROR-0000Vu-TP
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 20:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbaH2S7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 14:59:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57551 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115AbaH2S7W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 14:59:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4BA0434A46;
	Fri, 29 Aug 2014 14:59:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8DXb4IUh6Q6bphcKVgWqXIjGeRU=; b=L3X0cQ
	FXUF/BtYpKkbT9Y7a+12Rd5jwnW6TrMt/YmwHEM6AdIeDtc58T1svD9EgI8MREBi
	roBv1fqR7Bbo6qmtMQDeR8HjthiFZkLzvMKl4F51P/s6Fo6GSpJ/n1uooLDGyHUS
	mtQrhR/W1/dsRJfxvZvHH9hv+qeTTMVNMCse8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c5RNWaM7+9BRCCxIXLrOVXStizFgOc9l
	Pn/y1oMz5Lq2SUD3GeLvxJZCpwyKMAtyOF8th6fWaplrBcfC9ByqRifGdOUUcdy5
	QtQXahF9OMZ/LqO6CedkJj4CxOZiGExZLeBhyUR2ywoNJuqf6k1RnoFURj6+Y8gn
	nTtG4R5aCuI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3FEB434A44;
	Fri, 29 Aug 2014 14:59:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 02A9834A35;
	Fri, 29 Aug 2014 14:59:13 -0400 (EDT)
In-Reply-To: <1409331522-8457-1-git-send-email-bbolli@ewanet.ch> (Beat Bolli's
	message of "Fri, 29 Aug 2014 18:58:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 918593AA-2FAE-11E4-A764-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256180>

Beat Bolli <bbolli@ewanet.ch> writes:

> Subject: Re: [PATCH v2] pretty: Provide a strict ISO8601 date format

"pretty: add --date=iso-strict, a strict ISO-8601 date format"

> The differences between the two formats are the following:

"The --date=iso format Git uses deviates from ISO-8601 in these
ways" may make it clear which one has "T" and which doesn't.

>   - a space instead of the `T` date/time delimiter
>   - a space between time and time zone
>   - no colon between hours and minutes of the time zone

> This commit adds a strict ISO 8601 date format for displaying committer
> and author dates. It uses the '%aI' and '%cI' format specifiers (note
> the uppercase 'I') and the '--date=iso-strict' or
> '--date=iso8601-strict' date format names.

"Add a .... author dates. Use '%aI' and '%cI' format specifiers ...".

> See http://thread.gmane.org/gmane.comp.version-control.git/255879 and
> http://thread.gmane.org/gmane.comp.version-control.git/52414/focus=52585
> for discussion.

Thanks for the pointers, especially for the older one.

> +	else if (mode == DATE_ISO8601_STRICT) {
> +		char sign = (tz >= 0) ? '+' : '-';
> +		tz = abs(tz);
> +		strbuf_addf(&timebuf, "%04d-%02d-%02dT%02d:%02d:%02d%c%02d:%02d",
> +				tm->tm_year + 1900,
> +				tm->tm_mon + 1,
> +				tm->tm_mday,
> +				tm->tm_hour, tm->tm_min, tm->tm_sec,
> +				sign, tz / 100, tz % 100);

OK.

> +# ISO strict date format
> +test_expect_success 'ISO and ISO-strict date formats display the same values' '
> +	git log --format=%ai%n%ci | sed -e "s/ /T/; s/ //; s/..\$/:&/" >expected &&
> +	git log --format=%aI%n%cI >actual &&
> +	test_cmp expected actual
> +'

This is saying that as long as --date=iso-strict format is
bug-to-bug compatible with --date=iso format it is OK.

Which is fine, especially knowing the implementation ;-)

> +
>  # get new digests (with no abbreviations)
>  head1=$(git rev-parse --verify HEAD~0) &&
>  head2=$(git rev-parse --verify HEAD~1) &&
