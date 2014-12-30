From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] send-email: Improve format of smtp initialization error message
Date: Tue, 30 Dec 2014 08:13:46 -0800
Message-ID: <xmqqa925t8sl.fsf@gitster.dls.corp.google.com>
References: <1419875601-20836-1-git-send-email-kuleshovmail@gmail.com>
	<xmqqppb2z3w9.fsf@gitster.dls.corp.google.com>
	<87iogt4d53.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Alex Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 17:13:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5zQh-0001Ss-6u
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 17:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbaL3QNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 11:13:49 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751287AbaL3QNt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 11:13:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 87C7D28AAE;
	Tue, 30 Dec 2014 11:13:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DbEBuf2Q1CCx/bjfqLuGmBqvoOU=; b=U0Snnw
	46g+kVOz3l/nA8qPmfP5iJMfSafvK5gM56AEae2jRTS9Pbv0qVOrDseOIGNyqW/T
	PF7YzZWg1Z8T6HteubURzs3JECFRY3GZ7gc5ZCwPkXTs1qE+8FTzAXLEPMOGgNIR
	7rORxQ0Viq9K5zuJHkNf9pWi40/Olzr/2MUp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ly1rEie9GjwKHLQLCzdLOsJb4dYnULic
	bsTKC5DrdMYQnQHv77gHwW7Jri7DpcY/DiP9RL2dltgAufWXRGEbqSOBfrwTQHsU
	8mR3HlJOVXOp1O8iijvfmCUzsQSLSKz/RTgmsdtfX1Sam1cKg/VkrvIGzbrk58Qu
	eo5O8ECojCM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EBC128AAD;
	Tue, 30 Dec 2014 11:13:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EED3128AAB;
	Tue, 30 Dec 2014 11:13:47 -0500 (EST)
In-Reply-To: <87iogt4d53.fsf@gmail.com> (Alex Kuleshov's message of "Tue, 30
	Dec 2014 16:59:04 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D5F485E6-903E-11E4-B82A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261924>

Alex Kuleshov <kuleshovmail@gmail.com> writes:

> What's about output like this:
>
> Unable to initialize SMTP properly. Check config and use --smtp-debug.
>
> VALUES:
> 	server=smtp.gmail.com
> 	encryption=
> 	hello=localhost.localdomain
> 	port=587

Hmmm, maybe I am being slow but what's about it?  I thought that was
what you are trying to give with your patch since the first
iteration.

Puzzled...

>
> Junio C Hamano <gitster@pobox.com> @ 2014-12-30 00:50 QYZT:
>
>> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>>
>>> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
>>> ---
>>>  git-send-email.perl | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/git-send-email.perl b/git-send-email.perl
>>> index 82c6fea..60dcd8d 100755
>>> --- a/git-send-email.perl
>>> +++ b/git-send-email.perl
>>> @@ -1275,10 +1275,10 @@ X-Mailer: git-send-email $gitversion
>>>
>>>  		if (!$smtp) {
>>>  			die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
>>> -			    "VALUES: server=$smtp_server ",
>>> -			    "encryption=$smtp_encryption ",
>>> -			    "hello=$smtp_domain",
>>> -			    defined $smtp_server_port ? " port=$smtp_server_port" : "";
>>> +			    "\nVALUES: \n\tserver=$smtp_server ",
>>> +			    "\n\tencryption=$smtp_encryption ",
>>> +			    "\n\thello=$smtp_domain",
>>> +			    defined $smtp_server_port ? " \n\tport=$smtp_server_port" : "";
>>
>> It may be a good convention to have LF at the beginning of a new
>> string (i.e. we terminate the old line only when we have something
>> more to say), but that is true only when we want to end the sentence
>> without the final newline.  I wonder if that is true in this case;
>> do we want perl to say "at line # in file X" at the end?
>>
>> In any case, you have two output lines that ends with a trailing SP
>> just before LF, which is probably not what you wanted.
>>
>> If we want to see all lines end with LF, it may be far easier to
>> read this way:
>>
>> 	die "msg\n",
>>             "\tvar1=val1\n",
>>             "\tvar2=val2\n",
>>             defined $var3 ? "\tvar3=val3\n" : "";
>>
>> I dunno.
>
> --
> Best regards.
> 0xAX
