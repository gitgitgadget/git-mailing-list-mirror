From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 11/12] Documentation: add documentation for 'git interpret-trailers'
Date: Tue, 08 Apr 2014 14:26:40 -0700
Message-ID: <xmqqmwfv3433.fsf@gitster.dls.corp.google.com>
References: <20140406163214.15116.91484.chriscool@tuxfamily.org>
	<20140406170204.15116.15559.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Apr 08 23:26:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXdXg-0007PN-PB
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 23:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757700AbaDHV0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 17:26:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43686 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757674AbaDHV0n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 17:26:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F33079351;
	Tue,  8 Apr 2014 17:26:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4ea5f2OwENqCyP+7TPSOYAuy+y4=; b=jLOh3M
	1JoabpfXEvY6lV0F19xSypQbP6PLvJiaGdXJsoY3xxIUdL+JrAPAAoU5TVWsC1Mn
	tRm+thAAxM7l+I8uyP8Y+n+Coo7wLU4/S0MzT+a1vrVD3bNop7iDCgOhK24oMEBx
	8HKYqFhg34O6CFh2ZmZ+N/yZ6ITmRG4bW3UrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F4y+95DqTeL/tlZIvqAIc+trb2DpsNWP
	YapBJVC7jEXz8H8AwVg83MxlxPLRvADn0BD8bxtARqmidmVIRFEyJ+UJFX6khZzE
	lBCpuz6HttzYADMnJ2C9onkEGDgzpmJQd4N3FzVQUXkenJe+lJSNrZlfzKPWVeY9
	gQjYTrgLpp0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F3A679350;
	Tue,  8 Apr 2014 17:26:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 486A87934E;
	Tue,  8 Apr 2014 17:26:42 -0400 (EDT)
In-Reply-To: <20140406170204.15116.15559.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 06 Apr 2014 19:02:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7A7AAD36-BF64-11E3-B8E8-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245960>

Christian Couder <chriscool@tuxfamily.org> writes:

> +Help add RFC 822-like headers, called 'trailers', at the end of the
> +otherwise free-form part of a commit message.

I think it is somewhat misleading to use the word "headers" like
that.  'trailers' look similar to RFC-822-headers but they come at
the end.  The sentence however reads as if they are "headers" that
look like RFC 822.  Perhaps shuffling words like so:

	Help adding 'trailers' lines, that look similar to RFC 822
	e-mail headers, at the end of the ...

would make it less confusing.

> +Some configuration variables control the way the `token` arguments are
> +applied to the message and the way any existing trailer in the message
> +is changed. They also make it possible to automatically add some
> +trailers.
> +
> +By default, a 'token=value' or 'token:value' argument will be added
> +only if no trailer with the same (token, value) pair is already in the
> +message. The 'token' and 'value' parts will be trimmed to remove
> +starting and trailing whitespace, and the resulting trimmed 'token'
> +and 'value' will appear in the message like this:
> +
> +------------------------------------------------
> +token: value
> +------------------------------------------------

Mental note: this does assume that the final output for the 'token'
is to have a line <label> that is followed by a colon ":", SP and
the value.

And the natural way to express that on the command line would be to
say "token: value", I would think, but let's just read on.

> +Note that 'trailers' do not follow and are not intended to follow many
> +rules that are in RFC 822. For example they do not follow the line
> +breaking rules, the encoding rules and probably many other rules.

s/that are in RFC 822/for RFC 822 headers/.
s/line breaking/line folding/. (see RFC 822, 3.1.1)

> +OPTIONS
> +-------
> +--trim-empty::
> +	If the 'value' part of any trailer contains only whitespace,
> +	the whole trailer will be removed from the resulting message.
> +
> +CONFIGURATION VARIABLES
> +-----------------------
> +
> +trailer.<token>.key::
> +	This 'key' will be used instead of 'token' in the

As `key` is something that is typed literally, it should be typeset
as `key` in the descriptive text.  I think other manpages spell the
placeholder as `<token>` (or '<token>', I am not sure which...).

> +	trailer. After some alphanumeric characters, it can contain
> +	some non alphanumeric characters like ':', '=' or '#' that will
> +	be used instead of ':' to separate the token from the value in
> +	the trailer, though the default ':' is more standard.

I assume that this is for things like

	bug #538

and the configuration would say something like:

	[trailer "bug"]
        	key = "bug #"

For completeness (of this example), the bog-standard s-o-b would
look like

	Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

and the configuration for it that spell the redundant "key" would
be:

	[trailer "Signed-off-by"]
        	key = "Signed-off-by: "

Am I reading the intention correctly?

That is, when trailer.<token>.key is not defined, the value defaults
to "<token>: " (with one SP after the label and colon), and when it
is defined, the value can come directly after it.
