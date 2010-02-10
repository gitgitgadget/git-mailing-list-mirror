From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git cherry-pick --continue?
Date: Wed, 10 Feb 2010 14:01:09 -0800
Message-ID: <7v63644uoq.fsf@alter.siamese.dyndns.org>
References: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com>
 <20100210210419.GA7728@coredump.intra.peff.net>
 <20100210212408.GB7728@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 23:01:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfKcj-00030k-MK
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 23:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150Ab0BJWBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 17:01:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756124Ab0BJWBY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 17:01:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 222F898919;
	Wed, 10 Feb 2010 17:01:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IAUxDKYNVYH/6ln8kzLZgEtTAiY=; b=QJ3dIg
	KsmcGqHarz+gc2luDWQ8qjZdY8TxOEIfA894DJteo92kQtd+JLg7tLtnfA5ua5DI
	h8S9lWZU93lCFguwALzF9m5lT208myp1uISI+rrh6u1b/ErPNG4VVL3h6HAUls7o
	fR4BYaEOdYxbLvvwoHEGw2c3JXjUocWpzRmc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s/AfTglHfsaG8OhqA0OeXf4HL9cBQ9lQ
	4/iM3wQhtVtQI+oiLQ4fsQHiAiH9nf8otlVLUqYymdgFK0GdOFOXocgSe9CzhogP
	S3eyOapi1DoS30S1shM0GbCnZwrbnZIVT74boq3DDX7B7d2uwdRpreg1kGZbIHmY
	VL4l/jwQhEc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E4AEA9890D;
	Wed, 10 Feb 2010 17:01:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07AAD98904; Wed, 10 Feb
 2010 17:01:10 -0500 (EST)
In-Reply-To: <20100210212408.GB7728@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 10 Feb 2010 16\:24\:08 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CF564054-168F-11DF-A59D-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139555>

Jeff King <peff@peff.net> writes:

> Hmm. I was thinking "am" was the odd man out, but really there are only
> two sequencer commands that I noted: rebase and am. So you could perhaps
> argue that rebase should also learn "--resolved". Or am I forgetting
> one?

I don't think you are forgetting anything, except that "am" came first with
"resolved".

The focus of the verb is "I declare I am finished marking the resolution".
Taking that declaration and continuing is ultimately "am"'s decision.  IOW
the user is not telling "am" to continue---the difference is subtle, but
it was a conscious design decision.

"rebase --continue" came later, and I think its focus is placed more
heavily on the instruction side ("Please continue"), and not on the
declaration side ("I now have marked the resolution for all paths").

This causes people sometimes to want to see it "continue", even when then
haven't marked the resolved paths as resolved.  I personally think the
focus is misplaced.

But that is just a philosophical difference ;-).
