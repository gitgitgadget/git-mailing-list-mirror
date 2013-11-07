From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] Rename suffixcmp() to has_suffix() and invert its result
Date: Wed, 06 Nov 2013 16:12:51 -0800
Message-ID: <xmqq38n96pdo.fsf@gitster.dls.corp.google.com>
References: <20131105210237.21525.61810.chriscool@tuxfamily.org>
	<20131106221735.GB10302@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 01:13:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeDDl-0001gO-6s
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 01:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106Ab3KGAM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 19:12:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40024 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813Ab3KGAMz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 19:12:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A02550DC1;
	Wed,  6 Nov 2013 19:12:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MC8Sub1xT+IPvpCTkaV1Oiif8Ek=; b=ZtysI1
	HRKWXFXBwYERkE1TZ+DsUjY7X80GJU1P92jt5ye8P5wWCkTK5W3OtbZ3qaCA+EiZ
	zhnc7yW80wpSCz9Jdja4lz5Qp0TXLq9STT294gMfprKAM+IAqqB/O7U9EbPrCwsN
	L5O/NqA8mD9zQaqrwi5BNkykrspsZkXOBTpUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cZn7davHY45JPwHvRP4qFJpJn/Zhu/sl
	jwnvSip11uhPYU4RtDOm0/7cPEHT7JhlRKO6kCpdNz3VGqYr6BkHhaam3lGVICbB
	7/Z77bu0vXNQ3i779uHd/iekesQ6B+N+CDp7V0lSXLjMVcH+amPb7vODPcYJP8z/
	hq7b/LoLPfM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3692D50DC0;
	Wed,  6 Nov 2013 19:12:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8888A50DBF;
	Wed,  6 Nov 2013 19:12:54 -0500 (EST)
In-Reply-To: <20131106221735.GB10302@google.com> (Jonathan Nieder's message of
	"Wed, 6 Nov 2013 14:17:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5935F96E-4741-11E3-AD6A-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237389>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> The old name followed the pattern anything-cmp(), which suggests
>> a general comparison function suitable for e.g. sorting objects.
>> But this was not the case for suffixcmp().
>
> It's not clear to me that prefixcmp() is usable for sorting objects,
> either.  Shouldn't it get the same treatment?

Sounds like a plan for a good follow-up series.

> If some day we invent a type for 4-byte-aligned object names, it might
> make sense to do something similar to hashcmp, distinguishing between
> hashcmp for use where ordering is important and something like hash_eq
> when checking for equality (since I suspect the latter can be made
> faster).

Interesting.
