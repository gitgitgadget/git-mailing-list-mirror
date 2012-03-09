From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Fri, 09 Mar 2012 12:21:01 -0800
Message-ID: <7v62ed5xw2.fsf@alter.siamese.dyndns.org>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vsjhi6qky.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Mar 09 21:21:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S66JP-0003EH-Au
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 21:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030746Ab2CIUVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 15:21:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62413 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030754Ab2CIUVE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 15:21:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F0047736;
	Fri,  9 Mar 2012 15:21:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W25QNG/Q/Nf7ye5L8SMU6swyLfg=; b=jXG9ou
	3J4myHY5yKHQLc2vEDN+to6Dv4/7uIQv+d5bFVJWOVW9mPAGgzwhxj+hjtXuKgq7
	Y9SQBv/jzFenXhhdzvGMxYOwssMnx5P8R4dKnbDTBnRDjDi8mx5ILE+M7gRBdVEm
	NK3DUMKGbl0thDuHZUd+tsV+Zi9wEoaKjPMA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kl2KT93UpGuRObka5/40Vg2h+q3IINXc
	Hw+vJcgHLWe5iEhWpms8dEd31mWI3tVBVT12hSkFTKGOUULnyeJn4ICk0DoL1b9O
	M/L7Pz3DDfeP+nz2skV+KzeFn33CsIbMGFNYUTZKPvOOZomuwqZBcV8owh53elni
	n+TppqPcsZk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 847D77735;
	Fri,  9 Mar 2012 15:21:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 136947733; Fri,  9 Mar 2012
 15:21:03 -0500 (EST)
In-Reply-To: <7vsjhi6qky.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 09 Mar 2012 02:01:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 648D9416-6A25-11E1-8693-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192738>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> This patch prepares a transition to 'upstream', unlike the previous
>> version which was advertizing 'current'. In most case, this would be
>> the same, but 'upstream' is probably more sensible in case it points
>> to a branch other than 'current'. I don't care much either way.
>
> I would agree with that choice (provided that we were to do this
> change).
>
>> I've kept the wording from the original patch, which commits to a
>> future change. We may instead relax this commitment and just say "the
>> default is likely to change in a future version", or so.
>
> Please no.  Keep it _very_ firmly committed.  Otherwise we didn't
> learn a thing from 1.6.3 era.

The need for awareness building outside this mailing list remains,
but the ball is in the court of "let's change the default" folks and
I cannot do anything further on that front, so I'll focus on the
patch itself in this message.

The code seems quite competently done, except that the message text
would want to live in a separate static array, if only to keep the
lines in the patch not overly long.  Also, The message taken from
Jeff's $gmane/166787 may need to be tweaked further, waiting the
conclusion of the discussion in the other subthread.

Oh, another thing is that the "1.8.0" in Jeff's original was written
back in 1.7.5 era.  We would want to bump it to say "1.8" (or even
"2.0").

Thanks.
