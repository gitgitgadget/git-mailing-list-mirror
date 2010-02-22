From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Sun, 21 Feb 2010 22:59:51 -0800
Message-ID: <7vwry5pxg8.fsf@alter.siamese.dyndns.org>
References: <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <20100219082813.GB17952@dpotapov.dyndns.org>
 <7v635tkta7.fsf@alter.siamese.dyndns.org>
 <7v8waniue8.fsf@alter.siamese.dyndns.org>
 <20100221072142.GA5829@dpotapov.dyndns.org>
 <7vhbpas7ut.fsf@alter.siamese.dyndns.org>
 <20100222033553.GA10191@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 09:07:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjSH9-0006KZ-GW
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 08:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875Ab0BVHAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 02:00:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606Ab0BVHAI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 02:00:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CC7BA9BBA8;
	Mon, 22 Feb 2010 02:00:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r6avOihzu5lzIsvKErUUeucEX7w=; b=r5Ww2u
	lYhg5+IAkD6mkmiO7d6/D7I0UP0lKKLnaOwQ2Gjdyn3zO55V8wqfl8JatCLvN0Pp
	/iiphZamr9p4Cg/lY3xTN6yR2lfk10AWSieT9hECmOwZgEKB4vLrfbHMzzlxBrHd
	zk7BOBMHIvwCWVlUHiUsc8U/JUkPFrOR+Qn3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lZNzjlmN8dJkAJwSszz/J4TnKm6iTuIO
	XB0juT8cGTv9MCE8UOac5ndS/96XQAXMTcsUIOkM0QkIaWfwDnG6EQRjh9HTho+F
	cf1rnzc9pAl/Skr+ImLwCOkzlIWC6KRdcwmVem05XgGzbufR0de69ksaQuocIHwQ
	USNrRqp4RL8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A08A9BB86;
	Mon, 22 Feb 2010 02:00:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C36C9BB83; Mon, 22 Feb
 2010 01:59:53 -0500 (EST)
In-Reply-To: <20100222033553.GA10191@dpotapov.dyndns.org> (Dmitry Potapov's
 message of "Mon\, 22 Feb 2010 06\:35\:54 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E5245058-1F7F-11DF-8055-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140640>

Dmitry Potapov <dpotapov@gmail.com> writes:

> If you look at speed-up numbers, you can think that the numbers are
> unstable, but in fact, the best time in 5 runs does not differ more
> than 0.01s between those trials. But because difference for >=128Kb
> is 0.05s or less, the accuracy of the above numbers is less than 25%.

Then wouldn't it make the following statement...

> But overall the outcome is clear -- read() is always a winner.

"... a winner, below 128kB; above that the difference is within noise and
measurement error"?

> It would be interesting to see what difference Nehalem, which has a
> smaller but much faster L2 cache than Core 2. It may perform better
> at larger sizes up to 256Kb.

Interesting.
