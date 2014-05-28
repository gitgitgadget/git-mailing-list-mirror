From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v12 11/11] Documentation: add documentation for 'git interpret-trailers'
Date: Wed, 28 May 2014 12:44:36 -0700
Message-ID: <xmqqa9a1d6xn.fsf@gitster.dls.corp.google.com>
References: <20140525051254.5329.66539.chriscool@tuxfamily.org>
	<20140525053223.5329.28002.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 28 21:44:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpjmL-0002wL-6d
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 21:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261AbaE1Ton (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 15:44:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63316 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751902AbaE1Tol (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 15:44:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C1A1C1BDD2;
	Wed, 28 May 2014 15:44:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cQpMpxHrJFJk5+ZR7r26ArvcYKk=; b=hSg8Oa
	KZuX1jPgR4cYAQUih0N5o4L4+K57mo+4XdqNmL2+Tn8AXX0VtHyHF+L/8VEzdYKy
	93uq5o3Bi8V1OtFAvtNwnKfskYvLzvcV3WkOQoIx3HvtHN36ECzPt1BZ9npiFvgD
	lz6fpgnjIqT6ra0FFur3LxrvX/4kSSsN9zJME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WFColJMPtAUZu1NdWv6jX5IE88AIefVi
	Km16YopC2nDrnWkm+iBgYaEvoXxbNUKlnw6RBm5TmgBi9m/7uLpufLjroXnmRtqd
	wFhkb3dBb4f0rSU//BnCCTnukKB/JnWtc+S5vh9aZlZ8AlkhcsCuhJDZfpFBfVLH
	0ttDkhvOSLs=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B56991BDD1;
	Wed, 28 May 2014 15:44:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 520491BDCD;
	Wed, 28 May 2014 15:44:37 -0400 (EDT)
In-Reply-To: <20140525053223.5329.28002.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 25 May 2014 07:32:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 805F6C4C-E6A0-11E3-8DF7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250322>

Christian Couder <chriscool@tuxfamily.org> writes:

> +trailer.<token>.key::
> +	This `key` will be used instead of <token> in the
> +	trailer. After the last alphanumeric character, this variable
> +	can contain some non alphanumeric characters, like for example
> +	`'%'` (one percent sign), `' = '` (one space followed by one
> +	equal sign and then one space), `' #'` (one space followed by
> +	one number sign) or even just `' '` (one space), that will be
> +	used to separate the <token> from the <value> in the
> +	trailer. The default separator, `': '` (one colon followed by
> +	one space), which is the usual standard, is added only if the
> +	last character in `key` is alphanumeric, so watch out for
> +	unwanted trailing spaces in this variable.

Perhaps corollary to the other review comment to this patch, I think
this is overly complex without giving more value to the users than
it causes confusion.

If the goal is to allow random syntax on the output side, why do you
even need to list percent, pound, etc., when you can just say "The
key is emitted and then your value" and the user will get exactly
what they specified to be emitted?

Any magic applied on top (namely, we would add ": " only in certain
circumstances) only makes things unnecessarily complex; I think your
having to say "so watch out for..." is a clear indication of that.

If we use the "separator", so that we can recognise a line with an
unseen key as a trailer we do not know about, we should stick to
just a single standard one ':' and I think it is OK to add a missing
": " by magic if that is the direction we are going to take, though.
