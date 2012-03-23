From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] merging renames of empty files
Date: Thu, 22 Mar 2012 21:56:14 -0700
Message-ID: <7vehsjvrtd.fsf@alter.siamese.dyndns.org>
References: <4F6B1F48.3040007@in.waw.pl>
 <20120322140140.GA8803@sigill.intra.peff.net>
 <7vty1gy3eh.fsf@alter.siamese.dyndns.org>
 <20120322175952.GA13069@sigill.intra.peff.net>
 <20120322182533.GA20360@sigill.intra.peff.net>
 <7v62dwxybd.fsf@alter.siamese.dyndns.org>
 <20120322190303.GA32756@sigill.intra.peff.net>
 <7vwr6cwiux.fsf@alter.siamese.dyndns.org>
 <20120322224651.GA14874@sigill.intra.peff.net>
 <7vpqc4us0u.fsf@alter.siamese.dyndns.org>
 <20120323002300.GA15940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzej?= =?utf-8?Q?ewski-Szmek?= 
	<zbyszek@in.waw.pl>, "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 05:56:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAwY2-00013A-Cr
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 05:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133Ab2CWE4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 00:56:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825Ab2CWE4R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 00:56:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E12A64D3;
	Fri, 23 Mar 2012 00:56:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3owr5Gt6BQ1IZ6EqsoHy95p1dj8=; b=dbd+SW
	0EAC7O2DeYjExur4bAAu6X0Tu8GG5+lRqBox5SQlgT+2m50ie2sb4cEBO5rRpiti
	7RCdyPiwaUNQVnT8yS/bJhcGGGStCp3m5eltaCl6/qllJz9q8KdTpNlAFbsP8Em/
	YHBlIrhunkqM/t+/vAa5a55bnCJzsONBHdVQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZZP9pcoJ0odKfXhu6dPDEiuod9MR8D/G
	F6r24SvZuCnqXFd/QrmONJOcdryC1B5iF62pbh0KdbsZENtvszC3Eg7J5zNbBLHq
	H/WqOFY1RxXTC5tCtpxVSpD+tuBTX9ekqu76a2EzYGw5rAz0MfPQvNs5rvaIFG7P
	Wg9y4nf4sGg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4280864D2;
	Fri, 23 Mar 2012 00:56:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C967D64D1; Fri, 23 Mar 2012
 00:56:15 -0400 (EDT)
In-Reply-To: <20120323002300.GA15940@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 22 Mar 2012 20:23:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 855756C6-74A4-11E1-9E30-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193745>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 22, 2012 at 04:37:05PM -0700, Junio C Hamano wrote:
>
>> Hrm. As this is probably useful for older maintenance track, I would have
>> preferred not to see the first one that touches sequencer.c that did not
>> exist in the 1.7.7.x maintenance track, as the change is purely "cosmetic"
>> and does not have anything to do with fixing the over-agressive merge.
>
> I considered that, but assumed this was not a maint fix, but rather a
> new "feature" to improve the heuristics.

Ok. Perhaps I over-reacted to the issue, which sounded like a grave
mismerge that can go unnoticed.
