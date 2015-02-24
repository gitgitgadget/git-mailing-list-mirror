From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: add disassociate alias to dissociate option
Date: Tue, 24 Feb 2015 12:06:31 -0800
Message-ID: <xmqqbnkjqdko.fsf@gitster.dls.corp.google.com>
References: <1424459423-11727-1-git-send-email-mattwhiteley@gmail.com>
	<1424459423-11727-2-git-send-email-mattwhiteley@gmail.com>
	<20150221062754.GC29665@peff.net>
	<xmqqzj87wxck.fsf@gitster.dls.corp.google.com>
	<20150221073509.GA32548@peff.net>
	<xmqqvbitx0eh.fsf@gitster.dls.corp.google.com>
	<54EC3EF8.7040302@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Matt Whiteley <mattwhiteley@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 24 21:06:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQLke-0006vf-Cn
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 21:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbbBXUGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 15:06:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751679AbbBXUGd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 15:06:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F77739EDA;
	Tue, 24 Feb 2015 15:06:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bFuCWrUZDnvKTp8pFUJV6JZnHgU=; b=YTkZbf
	k37oH5DQbGGMv4GwjlLnERy/mXUS4gZbEuTj0dA+6BWrdDSN63UBAHPzsReFCDdF
	xoPezKZOCmYhMs56Da5OtBEbjVnir9FEF/whbT7bQ39yiRrYM69ZU5h9HMsM7JCm
	3VXeGNtqJlyk9mnxNKlwYw7hyQDspNcfK8AHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tHhM9bUHQMEhZ2dQ/j6Orvf2ZfzcOVcf
	5WFrzkRJP61GAzN0GHyoXL0LCv2ZNmEa6L9ayjw4a4w6I7jms2Ir2agODvr3rIEE
	/s6rlEbs7afWdaGHgKOxPIiXdMoZPxVYmk2dtigTHbXRk7RpIhttBRY5G5IFbTpB
	NwYE9klYS/Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 46A4239ED9;
	Tue, 24 Feb 2015 15:06:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C0E5F39ED8;
	Tue, 24 Feb 2015 15:06:32 -0500 (EST)
In-Reply-To: <54EC3EF8.7040302@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 24 Feb 2015 10:06:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A0C39148-BC60-11E4-ADA5-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264341>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 02/22/2015 07:32 PM, Junio C Hamano wrote:
>> ...  Both borrow the objects
>> in order to reduce the network cost, and the difference is that one
>> keeps borrowing while the other one limits the borrowing to strictly
>> the initial phase.  The two words, "borrow" and "reference", would
>> not convey that key distinction. ... and that is why I
>> call it a cop-out.
>> ...
>> We are all on the same page.  We know the cop-out is suboptimal, we
>> understand why the cop-out is better than "--borrow", and we cannot
>> come up with a better name that contrasts with the existing
>> "--reference" to make it clear how the new thing is different.
>
> I'll take that as an invitation to brainstorm :-)
>
>     --use-objects-from=
>     --copy-objects-from=
>     --precopy-objects-from=
>     --precopy-from=
>     --donor=
>     --object-donor=
>     --steal-from=
>     --steal-objects-from=
>
> Of these, I think I like "--object-donor" the best.

Donor (somehow the word reminds me of organ harvesting, yuck)?

I didn't think of the word 'copy', but that probably captures the
essence the best.  "reference-to-borrow-and-then-dissociate" is an
implementation detail, which, as you say, we do not want the users
to view this operation as; copying locally instead of over the
network is what the user wants to do.

> By the way, once we have stopped thinking about this feature as
> "--reference" and then "--dissociate", it becomes obvious that a nice
> generalization would be to allow *any* repository (including remote
> ones) to serve as the object donor.

As I do not think of a workable approach to implement such a
mechanism, I'd refrain from being irresponsible and say "Yeah,
that's a neat idea", which would make me sound like clueless "me
too, why doesn't Git do that?" crowd.
