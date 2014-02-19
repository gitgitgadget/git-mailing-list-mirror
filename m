From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse: fix --resolve-git-dir argument handling
Date: Tue, 18 Feb 2014 16:25:37 -0800
Message-ID: <xmqqzjlo9ce6.fsf@gitster.dls.corp.google.com>
References: <5301C4B4.5070503@thequod.de>
	<65ea2c8ce4f0d60f0d93f730aac50183ba63bd1c.1392626780.git.john@keeping.me.uk>
	<xmqq61ocdug5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Hahler <genml+git-2014@thequod.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Feb 19 01:25:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFuyv-0004Ta-E9
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 01:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbaBSAZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 19:25:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46084 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbaBSAZk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 19:25:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 338BF6ED41;
	Tue, 18 Feb 2014 19:25:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pa4c9vEkSlOURBtskyPuiy/bVys=; b=gCnCQx
	lVTBe++R8e+JviWdCjQwEsKGplBUuwCaIsQIzVbO/i2RqT3q2MIWDRFeZ/P2Gza7
	AR0UtlWT9uIdie0kRLfQPhtkX2etuRgG0R8M17Fsf2v+5SetHvT1bZHbknXj/Gj6
	0mfXUTPhbXRQiRGHOJEIjgx+ExRm219YG/7q0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p3YzJ8oI7qpyngXjjIjwU0ynVi/kCzTT
	svSC8QKjPTlqK6tGhiPweCQ0HHNRKK50L+33CqOYhsJorDSLsLpg+iXolP300Y1M
	j5wnxlidosMpoKw6AZc6SL0f4/FKWQ6v8k6utvZyhGiHY66gYfbpFzBntR43uYQ1
	o1P2s0nyWQE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F00016ED40;
	Tue, 18 Feb 2014 19:25:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EBAC6ED3F;
	Tue, 18 Feb 2014 19:25:38 -0500 (EST)
In-Reply-To: <xmqq61ocdug5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 18 Feb 2014 12:42:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5BCE728E-98FC-11E3-9574-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242378>

Junio C Hamano <gitster@pobox.com> writes:

> John Keeping <john@keeping.me.uk> writes:
>
>> There are two problems here:
>>
>> 1) If no argument is provided, then the command segfaults
>> 2) The argument is not consumed, so there will be excess output
>>
>> Fix both of these in one go by restructuring the handler for this
>> option.
>>
>> Reported-by: Daniel Hahler <genml+git-2014@thequod.de>
>> Signed-off-by: John Keeping <john@keeping.me.uk>
>> ---
>
> Looks sensible; thanks.

Ehh, I spoke too fast. Don't we already have this queued as a43219f2
(rev-parse: check i before using argv[i] against argc, 2014-01-28)?
