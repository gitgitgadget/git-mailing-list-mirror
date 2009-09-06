From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] push: make non-fast-forward help message
 configurable
Date: Sun, 06 Sep 2009 00:52:37 -0700
Message-ID: <7vzl98fr22.fsf@alter.siamese.dyndns.org>
References: <20090906064454.GA1643@coredump.intra.peff.net>
 <20090906064816.GC28941@coredump.intra.peff.net>
 <7v8wgsk0rw.fsf@alter.siamese.dyndns.org>
 <20090906072322.GA29949@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 06 09:53:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkCYY-0000B7-Nn
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 09:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730AbZIFHwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 03:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754685AbZIFHww
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 03:52:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683AbZIFHwv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 03:52:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5FF22806B;
	Sun,  6 Sep 2009 03:52:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XFceHnt9l+xqttL2wojgw1joCNo=; b=bA1qIU
	q9IFg5EQFJcMbuyynpNgYLPvvEmfs/kniX08gfYB/N0Z9/I44jGuwF+lE5R/RE6J
	rSN7xtKV4sxWf1XAYX/lND0hqtOqQKDcggfHJAa1u9AQwXPbysIg+bH3BrfD8GIi
	bJEc+ukko+8oUVTHQT/ETyVcV4o3utfUonpcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QwBQibxmEGE1bgFVeELv0DOUYy2pZ4rR
	N8PN5xCGWkzIO+CfmOYYerhy4IVYtMjXvE77Wx9FV+hPXDCgg/HXDzK1hbu7dDPp
	dvhf1NtmDsTHd7fOuBmpotcgwrsHWfQz48Pncm2MpWw1GypSUDIw1aIIFZKiFb3O
	AG782cZJu+Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6333D28063;
	Sun,  6 Sep 2009 03:52:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DDD52805E; Sun,  6 Sep
 2009 03:52:39 -0400 (EDT)
In-Reply-To: <20090906072322.GA29949@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 6 Sep 2009 03\:23\:22 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 44A2B5BA-9ABA-11DE-84F3-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127844>

Jeff King <peff@peff.net> writes:

> Thinking on it more, I think "advice" is the right word. It is not about
> arbitrary messages; it is about particular messages which try to advise.
> You would never want this feature to cover messages that are
> informational about a particular state or action that has occurred. Only
> "maybe you should try this" messages.

Speaking of which, has anybody felt annoyed by this message?

    $ git reset --hard HEAD^^
    HEAD is now at 3fb9d58 Do not scramble password read from .cvspass

This is not "maybe you should try this", but I would consider that it
falls into the same "I see you are trying to be helpful, but I know what I
am doing, and you are stealing screen real estate from me without helping
me at all, thank you very much" category.

Besides, if you want to use "where you are" to your next command, you can
just say HEAD without knowing exactly where you are.

It might be slightly more useful if the message said this instead:

    $ git reset --hard HEAD^^
    HEAD was at d1fe49f push: re-flow non-fast-forward message

Resetting is done because I want to build an alternate history starting
from an earlier point, and when I am done, I may want to feed this to "git
diff" or whatever to sanity check the result, without having to go through
the reflog.
