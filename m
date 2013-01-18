From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] CodingGuidelines: add Python code guidelines
Date: Fri, 18 Jan 2013 12:25:34 -0800
Message-ID: <7vip6uqlvl.fsf@alter.siamese.dyndns.org>
References: <20130118180639.GD31172@serenity.lan>
 <7vvcauqpn4.fsf@alter.siamese.dyndns.org>
 <20130118193501.GE31172@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Pete Wyckoff <pw@padd.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jan 18 21:26:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwIVi-0004ls-Bm
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 21:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644Ab3ARUZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 15:25:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40346 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858Ab3ARUZg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 15:25:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C1CBCE91;
	Fri, 18 Jan 2013 15:25:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BrOz/j6VLIayvQQCPK0Dxzf+Wd4=; b=MySAq+
	y/5beUzSMgwRQ0U1KMAUsR/VPE5M/BsAlT8XID6K10EnyBSdWw5MKilvKVGltrwP
	3NLfRP78Wvoo0pYTBdYVw1y3Fd3ked06aEoK2lZSnk3GBZWd2V50JX4lgE7Ctqg/
	Ek5pUw6FX6d1tIHIt7Q4zBqEBkuCOcU+Ijc5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W6pj+RbB3UWYPYt6OLNalthi5nNIyyAg
	RqMw0hRag6PV0Sz2ct6+Aum6kWVIRg0sEuohcZp/gTFJxpP9V7yS/cYsBoMHegNQ
	rVMbzBvRFvmmfOAvNgT0ZZ8oPyGfDg20folMJ3Ox7Fd5dXLH7xIhA9JcOuBVC/49
	jMYNnCPc9g8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 722C6CE90;
	Fri, 18 Jan 2013 15:25:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC2BDCE8D; Fri, 18 Jan 2013
 15:25:35 -0500 (EST)
In-Reply-To: <20130118193501.GE31172@serenity.lan> (John Keeping's message of
 "Fri, 18 Jan 2013 19:35:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 373C0F62-61AD-11E2-BAEA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213933>

John Keeping <john@keeping.me.uk> writes:

>>> + - Where required libraries do not restrict us to Python 2, we try to
>>> +   also be compatible with Python 3.  In this case we use
>>> +   `from __future__ import unicode_literals` if we need to differentiate
>>> +   Unicode string literals, rather than prefixing Unicode strings with
>>> +   'u' since the latter is not supported in Python versions 3.0 - 3.2.
>> 
>> "In this case"?  In what case?  This document will stay effective
>> long after you settle one particular backward incompatibility Python
>> 3 introduced, namely, the unicode literal issues.  It is just one
>> "example".
>
> I meant "in the case where you are supporting Python 3" but I suspect it
> would be better to move the unicode_literals sentence to a new bullet.
> Or maybe we should just remove it - I haven't seen a case in the current
> Git source where we need Unicode literals.

Yeah, "we support 2.x" and "we suport 3.x" may want to be combined,
but listing individual specifics as separate points to watch out for
would make it much more readable.

> As more people have started trying to support Python 3 in the wild, it
> has become clear that it is often easier to have a single codebase that
> works with both Python 2 and Python 3, and not use 2to3.
>
> It is for this reason that the Unicode literal prefix was reintroduced.

Yes, and from that perspective, placing floor on earlier 3.x makes
tons of sense, no?

These early versions may not be unstable in the "this does not
behave as specified in the language specification for 3.x" sense,
but for the purpose of running scripts meant to be executable by
both 2.x and 3.x series, the early 3.x versions are not as good as
later versions where Python folks started making deliberate effort
to support them.
