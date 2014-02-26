From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git stash pop` UX Problem
Date: Wed, 26 Feb 2014 12:20:45 -0800
Message-ID: <xmqqvbw139sy.fsf@gitster.dls.corp.google.com>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<530C953F.9050805@booking.com> <vpqlhwz5o58.fsf@anie.imag.fr>
	<530CA4C9.60601@booking.com> <vpqeh2r43kx.fsf@anie.imag.fr>
	<530D97BA.1080107@booking.com> <vpqzjlez3c4.fsf@anie.imag.fr>
	<xmqqd2i94qfq.fsf@gitster.dls.corp.google.com>
	<vpqy50xd5cr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Omar Othman <omar.othman@booking.com>,
	Brandon McCaig <bamccaig@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 26 21:20:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIkyN-000358-FQ
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 21:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbaBZUUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 15:20:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33267 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751AbaBZUUu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 15:20:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79C236D36F;
	Wed, 26 Feb 2014 15:20:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EsnqO+mJJgjQ0OF4z/pppKjEAFM=; b=nsmESD
	jzEgotmMtGHsx+8kowKEUI29Ea62aFEGv6q23/8g5G7ldsz1EhUDo6oBYLu9PPUj
	YGL93juI7MwlJTEyaD+hI54GMEWZI7dBTuOKfJuj60Xzj26olrFB64CDsvQPSwct
	Xw3o5bdlP+5ZUJRpYIhwxW+of+gBhsQ1rIe8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PzsqqeOBQifbEO/qoPjgGe2hUC4cofMg
	OPcu7htsELPR7y6ZPO5BJ18ax/CO2IqVkyLOUz6VuET6z1+SRZRiEhGgx5cJQ8Zy
	pFZSvDXXYBIMqZmu/iZUaIugtlWkfhO4kkVYsooFdzdjPg2TFsCxfiPsOldgywJO
	Tz1Psox+cgw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C6E76D36E;
	Wed, 26 Feb 2014 15:20:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D7E86D36C;
	Wed, 26 Feb 2014 15:20:48 -0500 (EST)
In-Reply-To: <vpqy50xd5cr.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	26 Feb 2014 20:46:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7AE72986-9F23-11E3-BB82-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242757>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I'd however have to say that even "please resolve the conflicts
>> manually" is over-assuming.
>
> I understand your point, but in a short hint message, I still find it
> reasonable. Fixing conflicts is the natural way to go after a "stash
> pop", and the user who do not want to go this way probably knows why.
>
>> "The stash was not dropped" is the most important thing in your
>> additional text.  How about rephrasing like this?
>>
>>     $ git stash pop
>>     Auto-merging foo.txt
>>     CONFLICT (content): Merge conflict in foo.txt
>>
>>     The stashed change could not be replayed cleanly, leaving
>>     conflicts in the working tree. The stash was not dropped in case
>>     you need it again.
>>
>>     After you are done with the stash, you may want to "git stash
>>     drop" to discard it.
>
> I'm fine with this, but it's even longer than mine which I already found
> too long. Perhaps the "leaving conflicts in the working tree" could be
> dropped, as the message follows "CONFLICT (content): Merge conflict in
> foo.txt".

Surely.  s/was not dropped/is kept/ would make the result even
shorter.

We can also remove the last three lines, for that matter.
