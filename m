From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status takes 30 seconds on Windows 7. Why?
Date: Wed, 27 Mar 2013 13:00:26 -0700
Message-ID: <7vy5d8lijp.fsf@alter.siamese.dyndns.org>
References: <CAFT1WNyyXbCOQWMt8nYife7Tix_mJzDQrj5e+N=GKbDR8OyYzQ@mail.gmail.com>
 <vpqr4j0rccf.fsf@grenoble-inp.fr>
 <CAFT1WNxm0Kx9vHx+NB92_tZV6KsVhefiVXa-K69YbWOkpCXSgA@mail.gmail.com>
 <20130327184657.GP2286@serenity.lan>
 <20130327190425.GA26380@sigill.intra.peff.net>
 <CA+55aFypcwbLwPLq++AU9FggCKLYkgkuN6i-gOD9pRioH1Dz2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Jim Kinsman <jakinsman@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 27 21:01:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKwWn-00035s-Je
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 21:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175Ab3C0UA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 16:00:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42209 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753475Ab3C0UA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 16:00:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84532B72E;
	Wed, 27 Mar 2013 16:00:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EnAVfAm4XqqJyljDjdGx+CacIyM=; b=i1EPfM
	ynyuBwgt/2UhYHeKcL25FXt2U8w/RtWrb8PYyWb8D0oFq7J0lz4GY6K2EnUgjK56
	ZSDy6SBbrpMaFlLRdM7QkLDNUixGIl0oPh25vJBdw2D46cgFxS4iPvNALJzmtcjS
	NlNRx1JEDYTa8WCaDH7Jsa2FjO6X9OPD6xFWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yIZ8Y9gmOWkiVXek04AN1RyNwse49GbW
	0gxutiBgq+qCBq6SXI/97Xg48P8AtVdMeSRecTdsvNgvqcqdApuFlze/PHEP50wW
	T96xMEYy0cS6uzDdIINp0384jYIKJ14ulZXp39SvJf++qqUVP5bG+O1gjWXt0fDU
	p5K+W6tDLOs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79357B72D;
	Wed, 27 Mar 2013 16:00:28 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D386EB729; Wed, 27 Mar 2013
 16:00:27 -0400 (EDT)
In-Reply-To: <CA+55aFypcwbLwPLq++AU9FggCKLYkgkuN6i-gOD9pRioH1Dz2g@mail.gmail.com> (Linus
 Torvalds's message of "Wed, 27 Mar 2013 12:27:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F8813850-9718-11E2-9865-CDBF2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219314>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Mar 27, 2013 at 12:04 PM, Jeff King <peff@peff.net> wrote:
>>
>> Yes, I think that's pretty much the case (though most of my
>> Git-on-Windows experience is from cygwin long ago, where the stat
>> performance was truly horrendous). Have you tried setting
>> core.preloadindex, which should run the stats in parallel?
>
> I wonder if preloadindex shouldn't be enabled by default.

I am surprised that we haven't done so.

Given that we haven't tweaked the parallelism or thread-cost
parameters since the inception of the mechanism in Nov 2008, I
suspect that we would see praises from some and grievances from
other corners of the user base for a while until we find acceptable
values for them, but I agree the feature has been in use
sufficiently by some people (heh, I just discovered that I don't
have it in my config), it can be the default.
