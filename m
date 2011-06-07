From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [rfd] auto-following tags upon "git push"?
Date: Tue, 07 Jun 2011 11:45:44 -0700
Message-ID: <7vpqmp5vl3.fsf@alter.siamese.dyndns.org>
References: <7v4o417g9s.fsf@alter.siamese.dyndns.org>
 <20110607173051.GA22216@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 20:46:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU1Hy-0006AA-8k
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 20:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab1FGSpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 14:45:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab1FGSpx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 14:45:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 95A8E52A0;
	Tue,  7 Jun 2011 14:48:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hICfB7DBgz+nXrOy9FjYOARHCmU=; b=aXVre2
	g0dL/qTkEgvcNRuNl6tWc82Wg3KYXmoRzo2UanNoepZbhDoKhyJ/Uz96Fk0KuHZt
	I52vFCHvnICblgxnKqd4+9dfwghoyX91E7qfcDxNlmIMJnKtfjnk4oNDQgVcn7+3
	jEpIvdUiK1bzx2AuA16Kgv+WBKRsPXGXuP8dc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XKjANCGrzXloRZ4Cj0ciDZwCK/G6HAoX
	Wc0borUI/0hYD8zT3OHcOmANSef6E/qqkWMqWJtpqkF3nNCBL41SBiLv41wuryGn
	EafSk2mHxR9JZHwlkU9J27oBPsolSzj4hPgcM/yhpSPuEJYuR7rlw/2cca1q2EYk
	hY74dFCXvIs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6AD71529F;
	Tue,  7 Jun 2011 14:47:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7AF73529E; Tue,  7 Jun 2011
 14:47:56 -0400 (EDT)
In-Reply-To: <20110607173051.GA22216@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 7 Jun 2011 13:30:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA5BB676-9136-11E0-9C9D-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175249>

Jeff King <peff@peff.net> writes:

> Hmm. Is it a clear enough hint when the user uses an actual tag object
> to make a signed or annotated tag? At least for me, private throw-away
> tags tend to just be refs/tags/foo pointing to a commit, and real,
> for-public-consumption tags at least get an annotation, if not a
> signature.
>
> I seem to recall we make a similar distinction somewhere else in the
> code, but I can't remember offhand where. Maybe it was just a proposal
> that never made it anywhere.

You are thinking about "describe", I think, and the analogy holds
true. The tag annotation vs lightweight tag is a good hint I forgot to
take into account.

> Anyway, the problem would be somebody who does something like:
>
>   $ git tag -m "here is a description of how this wip is going" foo-wip
>
> which violates the assumption above.

True, I think I did that sometimes.

I personally do not use "private tags" that much anymore; I make liberal
use of private branches for that kind of work instead, as it is more
flexible (I can check it out, build on it, rebase -i, and generally whip
it around in any other way).
