From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: respect log.shownotes variable
Date: Wed, 07 Apr 2010 14:53:42 -0700
Message-ID: <7vljczapzt.fsf@alter.siamese.dyndns.org>
References: <20100407204536.GA32382@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 07 23:54:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzdCU-0007nI-6q
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 23:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756463Ab0DGVx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 17:53:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756414Ab0DGVx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 17:53:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 969B9A8886;
	Wed,  7 Apr 2010 17:53:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dxA7iDOdpF3sk60q9MCZpc4HuY8=; b=kMEVe6
	HzAqOlXXiZiJt3lkOJHc3aRnnYBpV2RptSPHu6aBKSipoiZm9SuN3t3yKR/lm49K
	5LpJwRmDQX6ZOzKJjZXRK7Qs1cX6vqejntRlD1Cwm4n3hY3T7AyEbUw9VNhFVY3S
	ugVI9gmixzcQygnLLp1Cr6otlih2mRilZTsaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iHFRmM3NJyNfKsD94v295HEpVwCbR5DX
	bfCZNAy6DCSBFB4Bu+NaQFEcSgOUaaRjSef8eruazdLAk3sa96h0PCh7PDgz2VdR
	PAoiqkwiOTtQK29exBLLOIlLnDLMRMggidAghg7BNCiAWevR4P7qVJ+CWd3dZMvS
	PjxtF/hj3uA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F363BA8885;
	Wed,  7 Apr 2010 17:53:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65D19A887B; Wed,  7 Apr
 2010 17:53:43 -0400 (EDT)
In-Reply-To: <20100407204536.GA32382@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 7 Apr 2010 16\:45\:36 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0C121078-4290-11DF-B204-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144286>

Jeff King <peff@peff.net> writes:

> I guess an alternate solution would be for me to store them in some
> other ref, and then use --show-notes=email when I do want to see them
> (instead of just --show-notes, as I would do with this patch). But I
> still wonder if log.shownotes is a sensible addition, just for the sake
> of completeness.

My gut feeling is that people who do have notes in the default namespace
(or the ones in notes.displayRef) do want to see them _all the time_.
Otherwise they'd put such notes in namespaces that are not shown by
default, and view them on demand, no?

But then there is a bigger question: what kind of notes would you want to
always see as part of "git log" output?  My answer to that question for my
personal workflow (both dayjob and here) so far has been "none", and that
is exactly the reason why my "applied from this message" notes live in
notes/am namespace and I have nothing in the default notes namespace.

If the answer is "none" for everybody, we should disable showing notes in
any command unless the user explicitly asks with either the --show-notes
command line option or the notes.displayRef and perhaps log.shownotes
configuration variables.
