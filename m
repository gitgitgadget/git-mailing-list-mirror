From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Sun, 15 May 2016 11:30:45 -0700
Message-ID: <xmqq1t536une.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<alpine.DEB.2.20.1605130820160.4092@virtualbox>
	<CAP8UFD2fSW0nds7myfb_09c+EaCdn6+1OqsNEzfY2rVTeA5TAw@mail.gmail.com>
	<alpine.DEB.2.20.1605140807310.4092@virtualbox>
	<CAP8UFD376guRRPpMVjC36K0dvWy17xdaHvV1WoRjMaNpdp0bqQ@mail.gmail.com>
	<xmqqwpmw7aow.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD0GrSy9E5Yv9Bdbd8SK+Q8GgYW2jDC-iopzsajpA6BKsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 20:31:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b20p6-0002zs-KU
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 20:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbcEOSbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 14:31:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751115AbcEOSbP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 14:31:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BA8C019F02;
	Sun, 15 May 2016 14:30:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h0SeQAYvR3rOEqmxBoZSlqGrQeE=; b=BaqIwn
	6SLCuSFmgQ63EUBsyf4rYd1SKeBXuwlxSjPE/saq529brjWEu+fwiCFVogNOZt8o
	GUh/xcoCZ8dQv07vlYiD6t47D9k5pR4anRM9zpNDzzcXvow+jIskL5tqksjxhRo0
	2PUqJzIsC+0of4G5TH3DwQR0PAr1NVAneW46M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=opghBNXphfYvs7Ilc+kkyDaRj9DMKVdi
	EwxIDcHeGLzp7/PZMQ1IA/evoLU4iFvYBVUAiv+uCDPrB5iFKRMZzVbwsMqD7LGU
	t1Nj13eZi9uH+4x/KA9JOTOpYBn1zWk3kjij593KBP70tbAJuFT4YNB3NKdEsYyD
	v8N4yXMXmP0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF9BF19F00;
	Sun, 15 May 2016 14:30:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DDF419EFF;
	Sun, 15 May 2016 14:30:47 -0400 (EDT)
In-Reply-To: <CAP8UFD0GrSy9E5Yv9Bdbd8SK+Q8GgYW2jDC-iopzsajpA6BKsw@mail.gmail.com>
	(Christian Couder's message of "Sat, 14 May 2016 21:37:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2465BD22-1ACB-11E6-987B-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294675>

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, May 14, 2016 at 8:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> I however do not see a reason why you need to expose that feature to
>> the users of "git apply".  So I am not sure if any of us care deeply
>> the choice among --silent, --quiet and -q -q.
>
> About that I wrote in initial email above:
> ...

Because you are not bound to stick to what you thought before the
discussion, what you wrote before everybody commented to improve
your proposal does not really matter.  Otherwise, the time they
spent would be wasted.  What matters more is what conclusion you
drew after having input from others.

"That --silent is optional and cannot decide if I want to have the
option was what I said at the beginning" does not help the
discussion very much at this point.  People know that you couldn't
decide back then, and that is why they hopefully helped you to get
closer to deciding by discussing the series.

"OK, I now think we don't need 'apply --silent' because ..., so I'll
drop it" or "I still think we want 'apply --silent' because..., so
I'll keep it", followed by "thanks for discussing and helping" would
be a more appropriate answer, whichever conclusion you have drawn.

"Hmm, I still cannot decide." is also fine, by the way.
