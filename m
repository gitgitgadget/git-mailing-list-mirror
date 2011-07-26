From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git check-attr" lists macros as being "set" -- feature or bug?
Date: Tue, 26 Jul 2011 12:43:45 -0700
Message-ID: <7vvcuoq13i.fsf@alter.siamese.dyndns.org>
References: <4E2EAEA3.8000307@alum.mit.edu>
 <20110726184756.GA520@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 26 21:43:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlnXl-0007GX-II
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 21:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688Ab1GZTns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 15:43:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54345 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753698Ab1GZTnr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 15:43:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A3FF4AD4;
	Tue, 26 Jul 2011 15:43:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1xvZTBr8snTUMLq1hCxNwk6Ydxc=; b=Vkowku
	ZsfZs/+haJ1xkKMlgpzYWVfkzC3RzedPag+UL9rXKvlanPFtFxW+QYndKLiCqYZG
	kf92D9XJTNXQrbx/l5qpSwZJzQunErkRtZSl382aUpmbUiEeIdS08EZxR7c7XqX0
	/YZDOUYO9WcSBAgz/TK5Gky0NYjbpagje2VNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LlWfXhFoDlUjQ9wEUmSMGj/h1guNn5rP
	BHdO1m5zxveIx8Qy1Cbwa8oqoA9fTuxTQuHvExNd2CCeXdKVZqo9AMAdZUPpcMTv
	4C1OAUyeYu2QTHaxB62ZPpUYdVyftMnimPrrIWh6PIFp/OuI4gdlUzJlUp3r4vHN
	0DPy7gyDNVY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F284C4AD3;
	Tue, 26 Jul 2011 15:43:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 869054AD2; Tue, 26 Jul 2011
 15:43:46 -0400 (EDT)
In-Reply-To: <20110726184756.GA520@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 26 Jul 2011 12:47:56 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93B1451C-B7BF-11E0-9D79-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177899>

Jeff King <peff@peff.net> writes:

> I don't know the original rationale, but it seems like the only sane
> behavior to me.

I know the original rationale, which was "we didn't see any need to single
out macros at all, and the code does what was the most straightforward
from the point of view of the implementation". If the resulting behaviour
ended up to be also sane, that would just mean that the implementation was
good ;-).

I agree that showing the macros as set/unset just like elemental
attributes is the only sane thing to do.  Majority of end users do not
care about how some attributes are macros (to cause other attributes to be
set or unset), would set "binary" to their JPEG files, and would expect
the check-attr to say "binary is set for this path", without having to
know that "binary" affects "diff" and "text".

When we say "check-attr tells you if the named attribute is set", do we
say "but macros cannot be examined this way" in the documentation?  If
not, I do not think we need any cluttering update.

It is a separate issue if macros should also be listed as the new feature
that lists all attributes given to a path. I tend to think the macro
attributes as well as the other attributes they set should all be shown.
