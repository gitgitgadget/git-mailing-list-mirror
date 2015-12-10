From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] update-index: use enum for untracked cache options
Date: Thu, 10 Dec 2015 10:46:21 -0800
Message-ID: <xmqqh9jqi1ky.fsf@gitster.mtv.corp.google.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-3-git-send-email-chriscool@tuxfamily.org>
	<xmqq1tawlpqw.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3+gsHZuaBweP83or=rEh-LFnz6=ycBCeuhApxp0PzN1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 19:46:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a76Ef-0001rl-BW
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 19:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbbLJSqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 13:46:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751685AbbLJSq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 13:46:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 422B0324FB;
	Thu, 10 Dec 2015 13:46:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rmknDaVQ2/0HVzRiEuoXNyhGDYc=; b=nQPqTn
	klMxsw1sysczu59tcOyzBqe3FFdI0devIFRowwyPEFhDerjaZWDILm7dilLLnWhg
	NBTUnTsnXKsYO4GiVvth+XsqsxBAnXz1ksX0e8On07J3TtrkqUyqcIe9MgDfHETt
	SCr3LTiZDY4G89YlVWaoclBKZaGdzUqpX8te8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lZoJhtoC25evqcsn0JO/Mo+g0WYKiVGA
	DUO4nfADtpvO8VzX40B/m5cVS8fT64FvNFWFeL9k6HB+VvL880y07eop7YQV00J8
	NwoK2en1YldJtZkUo+8IRoBDaxMX8ahEE62BPy5msqYNvjzCddlM0y45eTyM4BtN
	HhjiwwlXLqY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 37B53324F9;
	Thu, 10 Dec 2015 13:46:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 958D4324F6;
	Thu, 10 Dec 2015 13:46:26 -0500 (EST)
In-Reply-To: <CAP8UFD3+gsHZuaBweP83or=rEh-LFnz6=ycBCeuhApxp0PzN1A@mail.gmail.com>
	(Christian Couder's message of "Thu, 10 Dec 2015 11:37:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 517BC834-9F6E-11E5-9462-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282223>

Christian Couder <christian.couder@gmail.com> writes:

>>> +/* Untracked cache mode */
>>> +enum uc_mode {
>>> +     UNDEF_UC = -1,
>>> +     NO_UC = 0,
>>> +     UC,
>>> +     FORCE_UC
>>> +};
>>> +
>>
>> With these, the code is much easier to read than with the mystery
>> constants, but did you consider making UC_ a common prefix for
>> further ease-of-reading?  E.g.
>>
>>     UC_UNSPECIFIED
>>     UC_DONTUSE
>>     UC_USE
>>     UC_FORCE
>>
>> or something?
>
> Ok, I will use what you suggest.

As you know I am bad at bikeshedding; the only suggestion in the
above is to have common UC_ prefix ;-)  Don't take what follow UC_
as my suggestion.

Thanks.
