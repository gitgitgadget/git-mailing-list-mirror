From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there any efficient way to track history of a piece of code?
Date: Thu, 08 May 2014 11:34:26 -0700
Message-ID: <xmqq1tw43yrx.fsf@gitster.dls.corp.google.com>
References: <CAHz2CGW4rRWzGMPxM1XsoYvrwrrddrxAr+AKAi5SdMx+3rBjNg@mail.gmail.com>
	<20140508070051.GA4532@sigill.intra.peff.net>
	<CAHz2CGV6==abb0SrXOyqwumxEVLFnTtqe1Z4j2A7XcvJNuoAHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jianyu Zhan <nasa4836@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 20:34:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiT9S-0005we-Il
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 20:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755076AbaEHSef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 14:34:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58026 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753497AbaEHSee (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 14:34:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 190351568B;
	Thu,  8 May 2014 14:34:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Jq5+3y3QbCsHdtmWaYwQM+h3xo=; b=HcbwjU
	tq3Ve5Tk3P53eylnslyJeppjZXCabcF7CDginmtVCPESNNrDeaq+MPsAFNOAkFFO
	VJz3BSG6I5WKlm9Rdh7dkLpMsoE6M3dhaPLWzsMbo6JHicUCdx3T9cEhNE4ws/Jk
	XoMaGcCH+JqpxWAbFzr4owNxK1hwAsIM0WcPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CrMFceETMDgAh3ZRYfIRTe23JgMSY8WQ
	mdUKyZ0kgTWNIXyAh9YQrHiQVAQKsho9rgP1DQ9ieQIOm9OdDhvA5KR3IZJW5405
	eNOleHse4sEARFO4CqET1X6q1+7Vgd96gRiWKH451jIHJOj3y05RqzRQ6d2rCCuX
	QqEY4nNsZYk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0EE0C1568A;
	Thu,  8 May 2014 14:34:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9396F15689;
	Thu,  8 May 2014 14:34:30 -0400 (EDT)
In-Reply-To: <CAHz2CGV6==abb0SrXOyqwumxEVLFnTtqe1Z4j2A7XcvJNuoAHw@mail.gmail.com>
	(Jianyu Zhan's message of "Thu, 8 May 2014 15:32:47 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 64AA348A-D6DF-11E3-BF78-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248430>

Jianyu Zhan <nasa4836@gmail.com> writes:

> On Thu, May 8, 2014 at 3:00 PM, Jeff King <peff@peff.net> wrote:
>> Try "tig blame"[1]; from the blame view, the "," command will restart
>> the blame at REF^ automatically.  If you don't mind a more graphical
>> interface, I think "git gui blame" can also reblame from the parent from
>> the right-click context menu.
>
> Thanks! It helps!
>
> Hmm, but you know, we are cli people so we met git ;-)
>
> My by-hand recursive digging history works for me and I've consider automate
> this but failed since the pattern match to find the correct line of
> code in each recursion
> is a big problem.

Yes, by definition, there is no corresponding line in a version
behind the version shown in the blame output, so there needs some
heuristics, such as "assume the same line range", "find the
beginning and the end of the function definition that contains that
line", etc.
