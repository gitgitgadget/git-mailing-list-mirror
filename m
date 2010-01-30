From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] add --summary option to git-push and git-fetch
Date: Fri, 29 Jan 2010 17:25:09 -0800
Message-ID: <7vwrz08juy.fsf@alter.siamese.dyndns.org>
References: <20090703044801.GA2072@cthulhu>
 <7viqiat965.fsf@alter.siamese.dyndns.org> <20090707015948.GA525@cthulhu>
 <h35bda$kgv$1@ger.gmane.org> <20090710022415.GA27274@cthulhu>
 <4A56EEBA.3070806@gmail.com> <20090711174156.GA17154@cthulhu>
 <7viqhzm454.fsf@alter.siamese.dyndns.org> <20100130005948.GA14938@cthulhu>
 <7vzl3w9yst.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Sat Jan 30 02:25:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb25U-0005Wy-4y
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 02:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519Ab0A3BZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 20:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754086Ab0A3BZR
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 20:25:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709Ab0A3BZP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 20:25:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 96D2E95A67;
	Fri, 29 Jan 2010 20:25:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2okLY4AEe5Lq/9Wbxn3K9FN3PoY=; b=hyJsY0
	M2suV7mj79q6gLac/jJOpPiyASNKYAIQpfPdyRhA0YbtgOBAWbswVZUjd4LM26G0
	PYtxnBznwSwKnuf5nBI8vboUaQmcqFq3tWOaqr5deJovHztl9dvnsheqjftDk5j+
	Cp50yBJ+hnAaRuOiJHLUndk9gXe+R//F5IqA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ek9ypqig5asKQxZ1p1auPReHD+BnUUmw
	dmkyQ3HBOf22Bp7H5205dQuKJ3Qh5P4rv7IDx+70coOCXNSwSRSxtsZO1cB1fmEX
	gkiZ3WJmbvjWm43+4OF+nDu89xL/FP8p200+/7SoFOqF6ZWIXVcZTj4iLQUT2n/I
	cNRQLZ+/lnw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7101695A65;
	Fri, 29 Jan 2010 20:25:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B695B95A64; Fri, 29 Jan
 2010 20:25:10 -0500 (EST)
In-Reply-To: <7vzl3w9yst.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 29 Jan 2010 17\:17\:06 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5083406A-0D3E-11DF-94E5-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138420>

Junio C Hamano <gitster@pobox.com> writes:

>>> How would you know, when you asked 20 and you showed 20 here, that there
>>> is no more to come?
>>
>> If there's more it will print the "...", if there isn't then it won't.
>
> If your limit is 20 and if you unconditionally say "..." after pulling 20
> from the pool, the consumer of your output would think "Ah, I see 20 but
> that is only I asked for 20, and the ... means there are more".  But that
> is incorrect because your 21st call to get_revision() might have yielded
> NULL in which case you had only 20 after all.
>
> You cannot do "..." correctly without pulling one more than the limit from
> the pool.

Ah, I either misremembered the loop or didn't read it correctly.

Either way, the loop in your v5 looks correct ("read, check count to say
... and exit if limit goes down to zero, show one, decrement and go to
top").
