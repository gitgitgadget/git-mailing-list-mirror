From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2013, #01; Thu, 1)
Date: Tue, 06 Aug 2013 09:37:52 -0700
Message-ID: <7vob9ahj1b.fsf@alter.siamese.dyndns.org>
References: <7vbo5hqe6r.fsf@alter.siamese.dyndns.org>
	<87a9kz3uy4.fsf@hexa.v.cablecom.net>
	<7vsiyonp2w.fsf@alter.siamese.dyndns.org>
	<87pptryyh0.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 06 18:38:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6kGl-0006ts-Rw
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 18:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944Ab3HFQh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 12:37:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46302 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054Ab3HFQhz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 12:37:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB608366EB;
	Tue,  6 Aug 2013 16:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HNG8Jn9bmlznaGRxH/U943ci+i8=; b=kvUuWd
	UsdWGvIkOsk1we++LAyGeqdQK65S9OLRU0eq+t8yypYBRgt8ItHVQwK7T72kdx8A
	8/Xq0CH7gi4T1fJifVDsyVaPIURKeyA74KnQx82zU/tkYquU+yBtGbRHBQySiVIH
	vq75Oqi3aMwPuCPZDBFJ27zROe0tVN2mADx+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qpzdp0aGs2wzfrWPg8bcqL7jcEtLFWPn
	xRYIA4E65zzGpBIXEMKciCQ5wmO3AtMIxY3IWAyNjlS+PUQRV0oKDFrOwQlFd/Ch
	FwpKJ0hF9SmzG9P+5dELaxFGgGpvyPO4KqzBPyLhh+X5GHX6bGUZovxWItDzhMqP
	OvCbD2fVlng=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1AE3366EA;
	Tue,  6 Aug 2013 16:37:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32D38366E9;
	Tue,  6 Aug 2013 16:37:54 +0000 (UTC)
In-Reply-To: <87pptryyh0.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Tue, 6 Aug 2013 11:12:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8AE33FCC-FEB6-11E2-89C7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231760>

Thomas Rast <trast@inf.ethz.ch> writes:

>> So while I do understand why sometimes you wish to see full diff 
>> "git log --full-diff -- <pathspec>" to match output from "git show"
>> without pathspec, I am not sure doing it unconditionally and by
>> default like your patch does is the best way to go.
>
> I'm utterly unconvinced.

I was waiting you to say "I'm positively convinced that showing
local diff with the true parent is right!"; the reason why I planted
that seed in "What's cooking" to discuss this was because I needed
to play devil's advocate to make sure that all of us know that this
change is a good one, and that we know we agree that this change is
a good one, as the change is large insemantics, and the bookkeeping
burden is not negligible.  I suspect that we may want to restrict
the copying of the true parents only to limited cases (e.g. when
"--full-diff" is given), but I think that can be done on top, as it
is only the performance thing, not correctness.
