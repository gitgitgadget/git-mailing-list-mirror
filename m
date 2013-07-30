From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Remove sq_quote_print() in favor of *_buf
Date: Tue, 30 Jul 2013 08:27:27 -0700
Message-ID: <7va9l4xe3k.fsf@alter.siamese.dyndns.org>
References: <1375173087-2164-1-git-send-email-artagnon@gmail.com>
	<7viozsxfcd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
	<pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 17:27:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Bpr-0000vh-8H
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 17:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab3G3P1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 11:27:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46780 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753413Ab3G3P1c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 11:27:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD5C834B13;
	Tue, 30 Jul 2013 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=04D7m7kya0cis8d1cd021q2pbCk=; b=MX7GsL
	TA2Q2AAhlc476mFZEDbldnnnNAqno+ouEOWfSSGfpKsSpA5saoWasyClCisexSST
	STXYqWVXE7OreWcy7RB/9GYwKtrWfFUPeOnyhIUIGsmQBXzCS1RRzRcE2D7kQv+p
	l4cQXYf16nzFlKkpvAnILsSSFv510gUPgl0BQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ruk3hPWDwyBqXf/mSF6vISjbkGt1Wk22
	skALxwUcCE2ZfcvXDCTPU0v9obF58ITwu2Ep9EzUnfDPg6MNslRc5S84Ho14KxsB
	+8Lv0K9rHaMfjCdKjKFIWQHwBLlFH7GSfHd35pP+LOSZOt+xHbUvWfPCiO37olf5
	un2jf7hIqcw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFBEC34B12;
	Tue, 30 Jul 2013 15:27:30 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A349934B0D;
	Tue, 30 Jul 2013 15:27:29 +0000 (UTC)
In-Reply-To: <7viozsxfcd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 30 Jul 2013 08:00:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C00076C-F92C-11E2-AF9E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231367>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> While going through the for-each-ref-pretty series that Duy and I were
>> developing, I noticed that this cleanup was independent and good
>> as-it-is.
>>
>> So here it is.
>
> You always can first allocate a piece of memory and write into it
> instead of writing things out directly.  The patch shows it _can_ be
> done, but that is not a news.
>
> And such a change is hardly a "clean-up".  It just wastes more
> memory you do not have to waste, in order to do what you are doing.
>
> When there is a reason why you need an in-memory representation,
> this change starts to become the first step refactoring for an
> enhancement.

Having said all that, the patch texts all look OK, so I'll queue
them with updated log messages.  It was the usual me reacting to
unjustified value judgement made in log messages and cover letters.

It would save me a lot of work if people stopped doing that and
instead stuck to facts.  For example, between print_to_buf() and
print_to_stdout(), the former is *not* necessarily "nicer".  It is
more flexible but that flexibility comes with a price, and the
caller needs a demonstrative need for that flexibility to justify
the cost.

Thanks.
