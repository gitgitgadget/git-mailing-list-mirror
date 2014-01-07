From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] format-patch: introduce branch.*.forkedFrom
Date: Tue, 07 Jan 2014 12:48:53 -0800
Message-ID: <xmqqzjn7bjre.fsf@gitster.dls.corp.google.com>
References: <1389126588-3663-1-git-send-email-artagnon@gmail.com>
	<CALkWK0=g5-9r05vTkys8Tk7iv7PqPZJvMvkYsAOnN_F90Mtgxg@mail.gmail.com>
	<20140107204035.GA27932@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 07 21:49:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0daA-0005Cn-2t
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 21:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558AbaAGUs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 15:48:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64619 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbaAGUs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 15:48:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45E676198A;
	Tue,  7 Jan 2014 15:48:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NZPCy6bVL6yBJ2fZ2+UmlujhltQ=; b=gopWLR
	nGLB+qwrK0AgKTMDMGHCw4TrprlQemLwhZS9wCLWKIfaXrlmFjQhxjS3OxGoN1EN
	SWNYQN1IL42NT0aapcVd1rWTxk5EVrVd8NQBwNYUrVhrWkKVGIFxON8dUo8mrTAx
	RsJzm589bRsq1NNgA1JVEbLZSsV2EFeiXonsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uZHWyzmdslLcTYSaL5jW60J+maQqKQlT
	xcG8BIxErqSq2auSxbn1UksM+F+r1Rd5lqHBqUXM0foDqhPEKTVKKDjGtz7V5Vk/
	Gw22AwN8QGQY8kcrMBZpNg8UL8374sEed3jdV2w9dKGfnR963NCeeJfYx/YywOHp
	IVvI0xBE99c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C326261989;
	Tue,  7 Jan 2014 15:48:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 737F561988;
	Tue,  7 Jan 2014 15:48:55 -0500 (EST)
In-Reply-To: <20140107204035.GA27932@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jan 2014 15:40:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1FB84F4E-77DD-11E3-8AC2-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240151>

Jeff King <peff@peff.net> writes:

> The point was that the meaning of "@{upstream}" (and "branch.*.merge")
> is _already_ "forked-from", and "push -u" and "push.default=upstream"
> are the odd men out. If we are going to add an option to distinguish the
> two branch relationships:
>
>   1. Where you forked from
>
>   2. Where you push to
>
> we should leave @{upstream} as (1), and add a new option to represent
> (2). Not the other way around.

That matches my feeling as well.

I am not sure if "push -u" is truly odd man out, though.  It was an
invention back in the "you fetch from and push to the same place and
there is no other workflow support" days, and in that context, the
"upstream" meant just that: the place you fetch from, which happens
to be the same as where you are pushing to right now.  If "push -u"
suddenly stopped setting the configuration to merge back from where
it is pushing, that would regress for centralized folks, so I am not
sure how it could be extended to also support triangular folks, but
I do think @{upstream} should mean "this is where I sync with to
stay abreast with others".
