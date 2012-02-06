From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] blame duplicates trailing ">" in mailmapped emails
Date: Sun, 05 Feb 2012 16:39:35 -0800
Message-ID: <7vehu8dcc8.fsf@alter.siamese.dyndns.org>
References: <20120202084859.GC3823@burratino>
 <7v8vklvxwh.fsf@alter.siamese.dyndns.org>
 <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
 <7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
 <7vehuboe5g.fsf@alter.siamese.dyndns.org>
 <CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
 <20120204182611.GA31091@sigill.intra.peff.net>
 <7v39aphw85.fsf@alter.siamese.dyndns.org>
 <7vipjlezas.fsf@alter.siamese.dyndns.org>
 <20120205234750.GA28735@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 01:40:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuCco-0002tb-NY
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 01:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472Ab2BFAji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 19:39:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39269 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754244Ab2BFAjh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 19:39:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 293A475A7;
	Sun,  5 Feb 2012 19:39:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2FA3te4yalIH7Fcn3MPBFw/oTPo=; b=TJersr
	YaxDp00jiLRnuwhkGi44wCROlNPPONZhTlIfEaol5haDwFFFk2aJFX3OPcox7zMI
	erPfkPjIlrkVoLh3zXxKEs3wO+A/MsooSSY7s07dZpWr9yLLvPrsBDaTMAHHoYsD
	e5z7SL3JEuv/OKKCXAZ1Fo2kAhWGdo5IRbXLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B0U0rlc72FGuRBMS6+yyi4lti4LngoNZ
	PxF+5Gl1/LFHGKgxWZtgxE8UVjGHcE+KwoQaL/yhx5C8LhLExlKoUBjpAkOk4RSN
	eQCtx+/Lm4VSWaOGEAlJI/LCKIg5tCNBr1WqpL+ccYWlMMt719ufvX23ImGpr6xt
	IeE6RCr+0O4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BE8A75A6;
	Sun,  5 Feb 2012 19:39:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A629775A5; Sun,  5 Feb 2012
 19:39:36 -0500 (EST)
In-Reply-To: <20120205234750.GA28735@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 5 Feb 2012 18:47:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0BBBB270-505B-11E1-8516-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189990>

Jeff King <peff@peff.net> writes:

> We could also go as far as saying that map_user would _always_ terminate
> in this way (i.e., the caller gets a munged result, whether we found
> anything or not). Then internally, map_user could be simplified to stop
> worrying about making a temporary copy in mailbuf. And callers could
> simply call map_user without worrying about branching on whether it
> found anything or not.

I thought about it, but such a change needs to audit all the call sites
that assumes the promise original map_user() used to make before it was
broken. If we return 0 to the caller, the caller does not have to worry
about map_user() munging the buffer it lent to it.

It might be a worthwhile thing to do. I dunno; I didn't look into it.
