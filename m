From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: respect "core.ignorecase"
Date: Mon, 10 Sep 2012 13:30:03 -0700
Message-ID: <7vvcflmxis.fsf@alter.siamese.dyndns.org>
References: <1347210113-27435-1-git-send-email-ralf.thielow@gmail.com>
 <7v7gs3q9rp.fsf@alter.siamese.dyndns.org>
 <20120910161325.GB9435@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 10 22:30:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBAcc-0000LJ-NJ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 22:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288Ab2IJUaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 16:30:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35389 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932152Ab2IJUaH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 16:30:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA0AC8B32;
	Mon, 10 Sep 2012 16:30:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ap9l/OmNW61NuwPO7ukDkREAMQo=; b=iagkYw
	7tkVN/u1mXtZc7OnyqFiI55PHknqTr9B8/c6EPNKoS5GqE9Ljg9xdZMGlz9egxrk
	ilRaOufFwFdaTBO7YiNoBe6ajZI8hwiW6eiZBpGQykxQPXkg4VaasZwDt10wnaQU
	8MoLyDdofH4PSQNze37yfQ1opQFTnD47/OIXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KqSX2B1a4CU8oma33vWYJj7CHR2C8KDt
	D1hDWun1GSp1vpLx7izgr/qVx0mjTF3vDlfWFNm98cKbjoqB4v0yFiNQXvqqCRu8
	jPe4M/Gox3/by1pZq+IW/z8YIAfaJUHVavkCTLOJ6t0Qcw3ct30ATJXDZO0Qa3gE
	MZXllC1WTUU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83B4E8B31;
	Mon, 10 Sep 2012 16:30:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84B6D8B25; Mon, 10 Sep 2012
 16:30:04 -0400 (EDT)
In-Reply-To: <20120910161325.GB9435@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 10 Sep 2012 12:13:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DB1FF28-FB86-11E1-957E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205175>

Jeff King <peff@peff.net> writes:

> If the proposal were instead to add a certain type of pathspec that is
> case-insensitive[2], that would make much more sense to me. It is not
> violating git's case-sensitivity because it is purely a _query_ issue.
> And it is a feature you might use whether or not your filesystem is case
> sensitive.
> ...
> [2] I did not keep up with Duy's work on pathspec magic-prefixes (and I
>     could not find anything relevant in the code or documentation), but
>     it seems like this would be a logical feature to support there.

I think it mostly is in setup.c (look for "Magic pathspec").
