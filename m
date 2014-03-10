From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse --parseopt: option argument name hints
Date: Mon, 10 Mar 2014 12:55:00 -0700
Message-ID: <xmqqk3c1rfqj.fsf@gitster.dls.corp.google.com>
References: <1393842740-4628-1-git-send-email-ilya.bobyr@gmail.com>
	<xmqqwqg9kbuk.fsf@gitster.dls.corp.google.com>
	<531D51EC.6050503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 20:55:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN6I5-00057Z-77
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 20:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944AbaCJTzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 15:55:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33422 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244AbaCJTzE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 15:55:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 980607300F;
	Mon, 10 Mar 2014 15:55:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J1g9bbI57XM4MVv7+pCKbOBGn74=; b=agKSh1
	Oed4oX4bq76RnEDx1an1Jm8z6OVX7aoYDtpgtii2AZn1h0JSRL1DevJyIRGYlmRI
	dOA+BpU4YtcGrZeUhycchjfEy/eD8NdgGjcs0gR5R5oF74pPYJDZlGzNFkGtiQnm
	875tCQiSIntyZiV/5nbMPSM9dIz6uFcg031mI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=th1EGdhzI+kQFm50WrorxSWZezinJBye
	ILF/r/6YeJMjvLbnjr9BZt6LMGnXv4kb7IgXBEU8lZ78PT3imbb2GcyEcnThzE86
	6i1+jKwox6z2j0UU9G0lvaR6rXp5KRkiWhfnskzPWMDFRYZHmSfk08Z2TV3H7VFW
	WqHo8C/rXss=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 841757300E;
	Mon, 10 Mar 2014 15:55:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A076473006;
	Mon, 10 Mar 2014 15:55:02 -0400 (EDT)
In-Reply-To: <531D51EC.6050503@gmail.com> (Ilya Bobyr's message of "Sun, 09
	Mar 2014 22:47:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DE6AF956-A88D-11E3-81F9-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243802>

Ilya Bobyr <ilya.bobyr@gmail.com> writes:

> On 3/4/2014 11:22 AM, Junio C Hamano wrote:
>> Ilya Bobyr <ilya.bobyr@gmail.com> writes:
>>> @@ -333,6 +339,7 @@ h,help    show the help
>>>     foo       some nifty option --foo
>>>   bar=      some cool option --bar with an argument
>>> +baz=arg   another cool option --baz with an argument named <arg>
>> It probably is better not to have " named <arg>" at the end here, as
>> that gives an apparent-but-false contradiction with the "Angle
>> brackets are added *automatically*" and confuse readers.  At least,
>> it confused _this_ reader.
>
> I am not sure I understand what is confusing here.  But I removed the
> " named <arg>" part.

After reading "Angle brackets are automatically given", seeing that
the argument description has manually spelled "<arg>" gave me "Huh?".

Without " named <arg>" there is no such confusion.

> If there would be an example, I think, it is easy to understand how it
> works.

Of course.  That is why I suggested to do without " named <arg>"
part---I didn't mean to suggest not to add the example.  I also
think that you can demonstrate something other than '=' (whose usage
is already shown with "bar=" above) here as well, but I think we can
go either way.

>> After the "eval" in the existing example to parse the "$@" argument
>> list in this part of the documentation, it may be a good idea to say
>> something like:
>>
>> 	The above command, when "$@" is "--help", produces the
>> 	following help output:
>>
>> 	... sample output here ...
>>
>> to show the actual output.  That way, we can illustrate how input
>> "baz?arg description of baz" is turned into "--baz[=<arg>]" output
>> clearly (yes, I am suggesting to use '?' in the new example, not '='
>> whose usage is already shown in the existing example).
>
> Documentation on the whole argument parsing is quite short, so, I
> though, adding an example just to show how usage is generated would
> look like I am trying to make this feature look important than it is
> :)

You already are by saying the "Angle brackets are automatic", aren't
you?

> At the same time the target structure that holds the option
> description calls this string "argh".

OK, that is fine, then (I'd prefer a field name not to sound like
arrrgh, but that is an entirely different topic).

> I've renamed it to "end".  It is used to remember possible end of the
> argument name in just one paragraph of code.

Sounds good.
