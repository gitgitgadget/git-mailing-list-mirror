From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 1/1] http: Add Accept-Language header if possible
Date: Thu, 26 Feb 2015 14:13:16 -0800
Message-ID: <xmqq1tlcl3sz.fsf@gitster.dls.corp.google.com>
References: <CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
	<1422446677-8415-1-git-send-email-eungjun.yi@navercorp.com>
	<1422446677-8415-2-git-send-email-eungjun.yi@navercorp.com>
	<xmqqpp8xmwnp.fsf@gitster.dls.corp.google.com>
	<20150226030416.GA6121@peff.net>
	<xmqqmw40l777.fsf@gitster.dls.corp.google.com>
	<20150226213356.GA14464@peff.net>
	<xmqqa900l57y.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbUOhbs2DpM3CK=f+Gwj3v-q44Q7beiVgDHPPwm+rhEng@mail.gmail.com>
	<20150226220609.GA24663@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Yi EungJun <semtlenori@gmail.com>,
	Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 23:13:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR6gP-0002Pp-8c
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 23:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbbBZWNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 17:13:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753539AbbBZWNT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 17:13:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5B643BC85;
	Thu, 26 Feb 2015 17:13:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gHcVchT0WO3Cj8xrZqAW/mrvbWM=; b=nIBMJH
	uAA7CCa1DWZ7IbucDh0wFHPka9fZVfr5sT2fPKCFmkzVnz+olRLVXSLliga4aKxf
	D6zw8n+RDJCJxaA4MDFBwl/swj3V59xC0JOyM4HFFFyOEgwV5kF4PMwmQw4MfujK
	znndziQdPsIjWvqQavMp8kx9ZwPANKyFMuftg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zmtk8Xt+lw1OvQJzS5CmlW3+GNAPpeh1
	Di727eE4ckbrseFAjD94Qr6Set1pJrPnaYNk+gCXnnwuBbjxJLwgEbTNaYe2nwgB
	ok0AXhqqiJyFkhqbANsJ//7ABaGXYpFcB+xdrplC44xayX4N0x2UYyVsq1qWioaI
	cyaE+mEVuQ8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD0483BC83;
	Thu, 26 Feb 2015 17:13:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10F6A3BC62;
	Thu, 26 Feb 2015 17:13:18 -0500 (EST)
In-Reply-To: <20150226220609.GA24663@peff.net> (Jeff King's message of "Thu,
	26 Feb 2015 17:06:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AABBCD78-BE04-11E4-9D2B-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264474>

Jeff King <peff@peff.net> writes:

> On Thu, Feb 26, 2015 at 01:47:34PM -0800, Stefan Beller wrote:
>
>> On Thu, Feb 26, 2015 at 1:42 PM, Junio C Hamano <gitster@pobox.com> wrote:>
>> > Here is what I queued.  Thanks.
>> 
>> I did not follow the thread if there are any intermediate patches,
>> though it applied cleanly.
>
> What Junio posted is missing the hunk to drop the old static definition
> of get_preferred_languages from http.c.

I am still scratching my head to see how this happened, but I think
when I did

    $ git checkout ye/http-accept-language
    $ git apply -3 $gmane/264422

I took the wrong side of the confict in http.c

Thanks both for noticing.  Now it is fixed up.
