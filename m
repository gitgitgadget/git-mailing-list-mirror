From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] general style: replaces memcmp() with starts_with()
Date: Tue, 18 Mar 2014 12:23:31 -0700
Message-ID: <xmqqiorb8g5o.fsf@gitster.dls.corp.google.com>
References: <1395093144-6786-1-git-send-email-quintus.public@gmail.com>
	<1395093144-6786-2-git-send-email-quintus.public@gmail.com>
	<xmqqob14a14s.fsf@gitster.dls.corp.google.com>
	<CALs4jVGxmirDdO03kaKco7=NrTaXBinY=1U71=fYwX1mbqNDOA@mail.gmail.com>
	<CAPig+cRGwBV5CE3X9yGZGRNtKojCagz_F_f4Kd+S+D_qX+ZwJw@mail.gmail.com>
	<CALs4jVFVO8Jf-nn0PMtOYeMMKsB869KWQv8vV5kAg1itC1isiQ@mail.gmail.com>
	<CAPig+cSu=zgXdd55dj-u6mOzHqpUme7r-7OH+jjnOEt2P6C0vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Quint Guvernator <quintus.public@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 20:23:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPzc7-0003Hn-93
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 20:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757696AbaCRTXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 15:23:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62893 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757689AbaCRTXo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 15:23:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1273F73DDC;
	Tue, 18 Mar 2014 15:23:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Y7OPlQL3OLPfaR7yeGC3KthC4k=; b=uGu7Aq
	TshV5+eK+rJVbk+DTrsfeZkk/r3MJd5JuDN+gM9ZrQFnbldUScFPRVnr3YngIdyc
	dtB2/ZqW4r6Q3IczY9NqPsjWB6PZEnUvNIbyUa+FKXnOwnwXnLu/4zpc34YRdgDg
	O4Ywqi6v9FCT0IWnITDGu84NHYhhp6WW/K7qQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OLY6wMQRTJ1xYmkAQS1fvOGeR8I3eRGu
	n+2ngzuydaLC/J+Oco35E/aMhoAsUJZ4zMoBGbMRGJsbhqyJE3+p9T2thKIvmOqk
	9F3s4ABj97q3RxJgJhGg7Esh/5tV7t6TxoUmradlUqzsdwW+gjWQAUWZomRkMqds
	iMf6aOfsK4Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5AE273DDB;
	Tue, 18 Mar 2014 15:23:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2B8C73DBD;
	Tue, 18 Mar 2014 15:23:33 -0400 (EDT)
In-Reply-To: <CAPig+cSu=zgXdd55dj-u6mOzHqpUme7r-7OH+jjnOEt2P6C0vw@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 18 Mar 2014 00:07:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CBFE34B8-AED2-11E3-B428-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244370>

Eric Sunshine <sunshine@sunshineco.com> writes:

>>> A patch of this nature doesn't require much more description than
>>> stating what it does ("replace memcmp() with starts_with()") and why
>>> ("improve code clarity"). The following rewrite might be sufficient:
>>>
>>>     Subject: replace memcmp() with starts_with()
>>>
>>>     starts_with() indicates the intention of the check more clearly
>>>     than memcmp().
>>
>> This is more concise; thank you. I will adapt this as the message for
>> the next version of this patch. Would it be wise to mention magic
>> numbers, as the discussion surrounding the rationale of this patch,
>> especially with Junio and Michael, has centered around that?
>
> I was thinking of mentioning magic numbers in the example, but decided
> that their removal was a natural and obvious consequence of the
> improvement to code clarity, so it wasn't strictly necessary to talk
> about it. On the other hand, it is a good secondary justification,
> thus it should be perfectly acceptable to mention it. If I was writing
> the commit message, I might start by saying "As an additional
> benefit..." and then talk a bit about magic number retirement.

I think your subject is good (as you said, it makes it clear that it
is a project-wide clean-up by not mentioning any specific area), but
"indicates the intention of the check more clearly" would not tell
new readers who are unfamiliar with the helper API what "intention"
it is talking about very much, so perhaps

	Subject: use starts_with() instead of !memcmp()

	When checking if a string begins with a constant string,
	using starts_with() is less error prone than calling
	!memcmp() with an explicit byte count.

or something?
