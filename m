From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 11/12] Documentation: add documentation for 'git interpret-trailers'
Date: Mon, 28 Apr 2014 09:37:58 -0700
Message-ID: <xmqq8uqptno9.fsf@gitster.dls.corp.google.com>
References: <20140406163214.15116.91484.chriscool@tuxfamily.org>
	<20140406170204.15116.15559.chriscool@tuxfamily.org>
	<xmqqmwfv3433.fsf@gitster.dls.corp.google.com>
	<20140425.215619.2296838250398594645.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, dan.carpenter@oracle.com,
	greg@kroah.com, peff@peff.net, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk, jrnieder@gmail.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:38:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeoZl-0000kZ-Nb
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 18:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756606AbaD1QiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 12:38:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48468 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756580AbaD1QiM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 12:38:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D954E80AF7;
	Mon, 28 Apr 2014 12:38:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5K3yhmi01dSqzkXufbOQdFJNSVs=; b=ohK/Me
	9axCfFbummKrbKrH99+T2owBO/PCKwvzBCs9qaE8kjvtjLvhrIPjhXpek9VtEejc
	L39VE1pIyELFfvxP0Kj84Qzl2IGnkUpqo/6Arps06VPzyYOgr8ut4Oo2sH0zZ4xq
	Wr7wi1mfyQoWb2vNyo+kEX62KVhsH/pqqRx/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hnNmXyHOYqJ8L3YFhdDXiqtuNQARaKRN
	xQ+SWj6+FFZ2e5PXikcNIF6aLw6y0y9g9xOuHIjejZD9pijBmXHioBs3HF0Iza5p
	DAeoA2cK9Tf+029YE3A8liI1P2qC7ux9aawp2BbLX9NrufVaQ/Ub88DfHpcNM3oV
	io0uLxXwOUk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E8BA80AF6;
	Mon, 28 Apr 2014 12:38:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD3B180AF1;
	Mon, 28 Apr 2014 12:38:00 -0400 (EDT)
In-Reply-To: <20140425.215619.2296838250398594645.chriscool@tuxfamily.org>
	(Christian Couder's message of "Fri, 25 Apr 2014 21:56:19 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7649FD36-CEF3-11E3-BC3B-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247379>

Christian Couder <chriscool@tuxfamily.org> writes:

> From: Junio C Hamano <gitster@pobox.com>
>>
>> Christian Couder <chriscool@tuxfamily.org> writes:
>> ...
>
>>> +	trailer. After some alphanumeric characters, it can contain
>>> +	some non alphanumeric characters like ':', '=' or '#' that will
>>> +	be used instead of ':' to separate the token from the value in
>>> +	the trailer, though the default ':' is more standard.
>> 
>> I assume that this is for things like
>> 
>> 	bug #538
>> 
>> and the configuration would say something like:
>> 
>> 	[trailer "bug"]
>>         	key = "bug #"
>> 
>> For completeness (of this example), the bog-standard s-o-b would
>> look like
>> 
>> 	Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> 
>> and the configuration for it that spell the redundant "key" would
>> be:
>> 
>> 	[trailer "Signed-off-by"]
>>         	key = "Signed-off-by: "
>
> Yeah, but you can use the following instead:
>
>  	[trailer "s-o-b"]
>          	key = "Signed-off-by: "

Sure, but note that both of these have a SP at the end in the value
part (which I think is a sensible thing to do).

> The <token> and the key can be different.
>
>> Am I reading the intention correctly?
>
> Yeah, I think so.
>
>> That is, when trailer.<token>.key is not defined, the value defaults
>> to "<token>: " (with one SP after the label and colon),
>
> Yes.
>
>> and when it
>> is defined, the value can come directly after it.
>
> The value can come directly after the key, only if the key ends with '#'.
>
> If it ends with something else, except spaces, one SP will be added
> between the key and the value.

And I do not think we want (or even need) this "only when it ends
with #" special casing in the code at all.  When the project's
convention is to say "frotz# value-of-frotz", the users will specify
that with 'key = "frotz# "' (with a trailing SP in the value part),
and in a project that wants 'nitfol %value-of-nitfol', your parser
will find 'key = "nitfol %"'.  The users will obtain the result they
want for either case, and a hard-coded special casing in the code
that only has incomplete knowledge on the project convention will
actively harm them.  I'd suggest dropping that special case.
