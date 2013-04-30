From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] sha1_name: avoid Yoda conditions
Date: Tue, 30 Apr 2013 15:30:49 -0700
Message-ID: <7vobcvabxi.fsf@alter.siamese.dyndns.org>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
	<1367358554-4257-4-git-send-email-felipe.contreras@gmail.com>
	<7vehdrbrvz.fsf@alter.siamese.dyndns.org>
	<CAMP44s3osZJO1P6_KoPVON0cOSAD5D-OZmL=aKGkcWReortiCw@mail.gmail.com>
	<7v1u9rbrb4.fsf@alter.siamese.dyndns.org>
	<CAMP44s3K8BOfnUdc0514KgvYsbncSBO4DRSyfqhFQJomGrZN0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 00:30:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXJ4b-000714-NE
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933885Ab3D3Way (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 18:30:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35026 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933783Ab3D3Waw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 18:30:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD3B21A069;
	Tue, 30 Apr 2013 22:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iMzbI9BWbvYRwC75AkIxQTzKnJE=; b=oF7lGy
	XVjolWBo7vmz3HXkZedXui4fffufMydA0neQLc5RZDEqJtYCOkGiKLDsozYkL6Y8
	6Omkl8jbnr2hLZ/hFwxUcTk1SSDLOJbYRQl/W2zU0fZt8epcICwW65OgfJYqslPM
	EE2yFBdLL51tNg2Jij5fJIYapyTf7ZoFc38pQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DzwSBZM9f4rtmncUjHzPf4nnWymDrm53
	3BoVrJEnkXFaFvdRbal8+kidHpd7z3U3SZOs2sGw68d95Enmx9py/aQR1hERBQmi
	+6Ltb500ekahwQitPeWflLynJBaVKfUFTfzYk+cKrkXCyfEJsPJ+CCAhl5UYzXF7
	ZIbU0sRMME0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D190A1A068;
	Tue, 30 Apr 2013 22:30:51 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46C8F1A065;
	Tue, 30 Apr 2013 22:30:51 +0000 (UTC)
In-Reply-To: <CAMP44s3K8BOfnUdc0514KgvYsbncSBO4DRSyfqhFQJomGrZN0A@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 30 Apr 2013 17:20:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CEDA9B4-B1E5-11E2-98C2-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223031>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Apr 30, 2013 at 5:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> On Tue, Apr 30, 2013 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> What is a Yoda condition?
>>>
>>> ---
>>> Using if (constant == variable) instead of if (variable == constant),
>>> like if (4 == foo).
>>>
>>> Because it's like saying "if blue is the sky" or "if tall is the man".
>>
>> That is an invalid analogy, as the sentences do not make sense.
>>
>> A much better explanation I heard on this list is that people do not
>> say "If 1 is smaller than the number of your wives, you have a big
>> problem".
>>
>> I actually was not asking why people find the convention to visually
>> align comparison with number lines unusual. We discussed this style
>> long time ago on this list.  I haven't heard the "Yoda condtion"
>> expression and was asking about the "Yoda" part.
>
> It's popular culture.
>
> http://en.wikipedia.org/wiki/Yoda

I know who Yoda is.  What I was puzzled with was what it has to do
with "if blue is the sky" (which is a bad analogy for "if (0 < len)"
anyway)?
