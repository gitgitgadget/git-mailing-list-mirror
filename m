From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] string-list: Add string_list initializer helper functions
Date: Tue, 17 Jun 2014 15:10:26 -0700
Message-ID: <xmqqr42njigd.fsf@gitster.dls.corp.google.com>
References: <1402907232-24629-1-git-send-email-tanayabh@gmail.com>
	<1402907232-24629-2-git-send-email-tanayabh@gmail.com>
	<xmqqsin4o406.fsf@gitster.dls.corp.google.com>
	<53A09192.2030008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 00:10:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx1aW-0002Pb-0r
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 00:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967269AbaFQWKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 18:10:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62686 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967130AbaFQWKe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 18:10:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F2F221283;
	Tue, 17 Jun 2014 18:10:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W1T5RYtQVXwd1yrMKC+zb7yU84M=; b=Y4NS2E
	3tKdwwFhzrIIDwpAOSpKDhz9BpNTLWV+StKvWzxthhLmO/688dVmspBPg+v+Tac6
	hzs3NZZVPj2wKLmVLNE6nd+02qXbbiDYQnEhZvgs0FCNWjOqON6MXANgV26GqiRu
	HI3eQDdkucIyy0ClyQdwIdNJpY+qR2RlVQGaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M7CvOtDRhASNzDbEtsio0J4mOUexfR8A
	aIP0AuFLwL1GqrNcyPlBrX13dKsHmsEYEzljU3sfhGpKkuzv2g0gzzEJVaxCocox
	3+WIo8NlHv2IhzRCCfTtYS9Vz2B217t19arzkhHrkynYinnbPkei9srBRXEyaz6E
	4z7hM6KXetg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8D3F821282;
	Tue, 17 Jun 2014 18:10:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D55D12127F;
	Tue, 17 Jun 2014 18:10:25 -0400 (EDT)
In-Reply-To: <53A09192.2030008@gmail.com> (Tanay Abhra's message of "Tue, 17
	Jun 2014 12:05:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2F21AEAE-F66C-11E3-BDCC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251960>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 06/16/2014 03:59 PM, Junio C Hamano wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>> 
>>> When a compound construct like a string_list within another
>>> struct is used, the default initializer macros are useless.
>>> For such cases add helper functions for string_list
>>> initialization for both DUP and NODUP modes.
>>>
>>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>>> ---
>> 
>> 
>> Sorry, but I do not understand the above "useless".  Do you mean to
>> say that xyzzy below cannot be initialized that way?
>>  ...
> I was actually explaining for cases like below,
> ...
> +		string_list_init_dup(&e->value_list);

If that is what you wanted to refer to, I would have to say
"useless" is placing a stress on a wrong place.  (I do not see
anything wrong with your new code; it was just the way it was
explained in the proposed log message was misleading).

Structure initialisers are not something you can assign to a
variable anyway, and calling them "useless" is like complaining how
unwieldty hammers are on screws.  "Hammers are useless on screws"
may not be technically wrong per-se, but the readers won't be helped
by hearing it very much.

Instead, you would want to explain what your new invention, a
screwdriver, is and how it is intended to be used.

We of course have precedences for this kind of thing.  STRBUF_INIT
is for definition-time initialisation and strbuf_init() is to
initialise an uninitialised piece of memory to be used as a strbuf.

I tend to think it was a long-time misdesign of string-list API to
have the STRING_LIST_INIT* definition-time initialisers without
having runtime string_list_init*() initialisers, and it is a good
idea to add them to complete the API.

If I were writing the log message for this, I would just say:

	The string-list API has STRING_LIST_INIT_* macros to be used
	to define variables with initialisers, but lacks functions
	to initialise an uninitialised piece of memory to be used as
	a string-list at the run-time.

        Introduce string_list_init_{dup,nodup}() functions for that.

or something.
