From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Fri, 16 Dec 2011 11:33:30 -0800
Message-ID: <7vehw4ia5x.fsf@alter.siamese.dyndns.org>
References: <20111216110000.GA15676@sigill.intra.peff.net>
 <4EEB4F13.2010402@viscovery.net>
 <20111216192104.GA19924@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 16 20:33:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbdXG-0006KX-7N
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 20:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760609Ab1LPTde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 14:33:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59288 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264Ab1LPTdd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 14:33:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F024B76DF;
	Fri, 16 Dec 2011 14:33:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r104sYawFCOIMCzbNX6/bzX7gqI=; b=UDF4uz
	+TAUvIGU6mihmnCT5ZvTl4XjvymlOkPGLyQOE/+WskB8kBedwaj6UryXaTL2IrGM
	wXOZwxxLnnYfXoeSTB7LCurUpANAVOmM7gC+etujm6UYJ2ut3OWsgWIjEH4qSXDv
	9GJm7mXUrZeoTMXRNRPbWzHMRGbgJ/xyfExDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bsf5w5xhd3bCivCsRwKwldvrQ4bUima8
	qSfNBDV8S/0D10SEnXWj/SWFtGQlxAEL3IQ9RodqOoBr+vl7PSjxOw8fE+nongm5
	Xi+II5aU1pLscGaFcfWRTMJOguZSxhzI3El6yX81CvoYKfUy+B1nUER3OXKyNWLi
	P61ScyVmPP8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7D5B76DE;
	Fri, 16 Dec 2011 14:33:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D51176DD; Fri, 16 Dec 2011
 14:33:32 -0500 (EST)
In-Reply-To: <20111216192104.GA19924@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 16 Dec 2011 14:21:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6A6D788-281C-11E1-A220-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187308>

Jeff King <peff@peff.net> writes:

> I'm not clear from what you wrote on whether you were saying it is
> simply sub-optimal, or whether on balance it is way worse than the
> default funcname matching.

I think we recently saw that the optional built-in one for C did not even
understand a function that returns a pointer, and nobody complained about
it for a long time, and what was even more funny was that a patch to fix
it got a comment from somebody who wasn't using the optional built-in one
saying "The default works fine; what problem are you fixing?". That is
clearly one example where the default one is still better than the pattern
based one, iow, the pattern based one is way premature to be turned on by
default.

> And if it is bad on balance, is the right solution to avoid exposing
> people to it, or is it to make our patterns better?

Can't we do both, by avoid exposing normal users to broken one while
people who want to improve the pattern based one work on unbreak it?

> I.e., is it fixable,
> or is it simply too hard a problem to get right in the general case, and
> we shouldn't turn it on by default?

I do not think that is the "either-or" question. My impression has been
that even if it is fixable, it is too broken and produces worse result
than the simple default in its current form.
