From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/14] appp.sh: use the $( ... ) construct for command substitution
Date: Mon, 28 Apr 2014 12:20:07 -0700
Message-ID: <xmqq7g69qn14.fsf@gitster.dls.corp.google.com>
References: <1398260646-2660-1-git-send-email-gitter.spiros@gmail.com>
	<1398260646-2660-4-git-send-email-gitter.spiros@gmail.com>
	<20140425225843.GA238861@vauxhall.crustytoothpaste.net>
	<xmqq61lts5m9.fsf@gitster.dls.corp.google.com>
	<vpqmwf572fx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:20:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wer6b-0001jt-Is
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbaD1TUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:20:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51006 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408AbaD1TUL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:20:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 663A4818FF;
	Mon, 28 Apr 2014 15:20:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y4mbRFoiyTbSMdzt+0bCTrmnWN4=; b=qd1JW6
	rclDQgIDy6R3J3+ke0yeegaa+2GhywuTRi1mcAgzffK0j/o1X0z5AIr4rVD9tHkx
	q1W5Os239mViQ0/071xdkB2jzD+hXk+ObSrsmlKHx495SYmjILlKVvh5Z6DNDjXR
	OGKo5JWzOoqo0vUS/lzGPIr0dLy51aPUn801I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FNjLW9p9jYO4AXU1/+VQcb8inu/HcPOx
	AkqsnfCWbcQWqYJdcCqwE5YtOlkJUEB5wE+DPN23kkcB7Yge65jTH/ujwQHzUjHJ
	A73e0OrS6meR3RozOPBzBMP3Ylh1DXvYTAqTrNvkqRNgYKfvI5M1TcNnO+yOZMFC
	NhYbu+LHB9M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 510F1818FD;
	Mon, 28 Apr 2014 15:20:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 596DE818FB;
	Mon, 28 Apr 2014 15:20:09 -0400 (EDT)
In-Reply-To: <vpqmwf572fx.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	28 Apr 2014 20:07:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1CF7C382-CF0A-11E3-ADF1-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247399>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>
>>>>  CCS=`echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
>>>>  	-e 's/^Signed-off-by: \(.*\)/\1,/gp'`
>>>
>>> It looks like you may have missed a usage here due to the line break.
>>
>> Good eyes ;-)
>>
>> The following may be an obvious replacement patch, but alternatively
>> we could just drop the whole thing (contrib/ material is not
>> something we would need to police strictly for the style---nobody
>> should be mimicking their styles as they are not part of _our_
>> codebase in the first place).
>
> My vote goes for keeping the patch as it is, so that future people
> grepping for `...` construct do not find any after the series is
> finished.
>
> (and because it's simple to do)

Sure, let's do that.
