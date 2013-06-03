From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2] reflog: show committer date in verbose mode
Date: Mon, 03 Jun 2013 10:43:18 -0700
Message-ID: <7v61xvgkeh.fsf@alter.siamese.dyndns.org>
References: <517a09251fbbc81073fbd53f04a3f4b58cb8b3f7.1370224175.git.worldhello.net@gmail.com>
	<CALkWK0k-cikpwue4iQDGJgP4NrGdkCw2r=dzzP78+QbsA5BiMA@mail.gmail.com>
	<CANYiYbG-f+bM0jP0f-R-ciuR0sR13+8FcYkTas-X0LOh1mPRfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 19:43:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjYn0-000533-1k
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 19:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756683Ab3FCRnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 13:43:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663Ab3FCRnV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 13:43:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1782B24CE7;
	Mon,  3 Jun 2013 17:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r0kgMrQo4aE5bwePvIh5JQ7yPcw=; b=Xc8uOb
	U7VDOG8o2dwWs+UWG+AVq5jMhOyWoLDdPYcJhiUWywLnJf47Xh2VnUxVLWAwxaA9
	oFbs74iqrYbSM4IKXRuJPS0Ajlg8PGy0fJ5EJqDdiN0ar7Yh9MetwIq8oxtu9DoN
	o9ysrOw0yJa+w3RZzk01Cn9s4CC+h7moIx7AE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ApY2cTqfW9WuqUKqQr4BwnR4HnWtXyN2
	OwpUlFb2YqGEzNGDHrZu5ncUVy/Vmz8fJp7fA6apF2sI69YId4NYhtu3A2MuBIvh
	RJecgvyIWbEkYR1t/4r0Qn+S9rO9rUjaFV08Mh+52YYFS7kQUdSbA3xPjwghT6DK
	ETjJjAPzU1g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 037B624CE6;
	Mon,  3 Jun 2013 17:43:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E0E224CE3;
	Mon,  3 Jun 2013 17:43:19 +0000 (UTC)
In-Reply-To: <CANYiYbG-f+bM0jP0f-R-ciuR0sR13+8FcYkTas-X0LOh1mPRfg@mail.gmail.com>
	(Jiang Xin's message of "Mon, 3 Jun 2013 19:20:18 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14A24DC6-CC75-11E2-ADAD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226248>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2013/6/3 Ramkumar Ramachandra <artagnon@gmail.com>:
>> Jiang Xin wrote:
>>> It will be nice to add this pretty formatter automatically when run
>>> `git reflog` in verbose mode. And in order to support verbose mode, add
>>> new flag "verbose" in struct rev_info.
>>
>> Sorry I missed earlier revisions of this patch.  Generally speaking,
>> "verbose" is a bad way to control format-specifiers.  Why not add to
>> the list of pretty-format specifiers (like oneline, short, medium,
>> full)?  Also, this patch is extremely pervasive in that it teaches a
>> poorly defined "verbosity" to a very low layer: revision.c/revision.h.
>
> I also feel bad when adding new flag "verbose" into rev_info. = =b
>
> CommitDate is more significant than AuthorDate for reflog.

This is a curious statement, as I've seen it in a different context
recently.

Is it committer date that you really care about, or are you using it
as a substitute for something else you care more about, namely, the
time of the event the reflog entry was created (i.e. when you
committed, when you resetted, when you "branch -f"ed)?
