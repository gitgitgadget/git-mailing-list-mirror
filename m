From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 --
 mark
Date: Tue, 25 Aug 2009 20:03:44 -0700
Message-ID: <7veiqzjmy7.fsf@alter.siamese.dyndns.org>
References: <7v3a7g501e.fsf@alter.siamese.dyndns.org>
 <fc2ecb5cf28cabb7d183e2835ce46aa9afb2a322.1251215299.git.nicolas.s.dev@gmx.fr> <7vvdkbl4ul.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Wed Aug 26 05:04:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg8nx-0007xD-II
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 05:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594AbZHZDD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 23:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756585AbZHZDD7
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 23:03:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756583AbZHZDD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 23:03:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CF9E319359;
	Tue, 25 Aug 2009 23:03:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UvtRf19AaTobIaeyBC24DdQY/F8=; b=JYkwit
	WeZsDKe2F/UG/duMHy3UZjjsRMs9oNJYdaTCNS51EvfEa/5IllozQqpv7zK6N+vW
	4tSrlUPApVBJ3xwnq/tS8V/nfNnw7rCs6CdD5zxE+xUK0IUiGp4KpqJZGQsw4ZAo
	Jo8ZDY/kvnBHb4kQVlX6Uz63M6smw/sH4rN+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TR26Z2zqEQSNkGVBxeFIH80KD6DDgody
	EIPI00ud6BmUVZdpMt7CSZZCW4EBW3kXFwy1WzPwuCoUXnelxCQRAE4rWUMA5yfq
	8FMTBmvptlGZYg5b63U+hulcpFxSi2ezRFMsCkj/S8D1/LkqiUzD/EK/7DHDi6gx
	XyESC40UYTc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8388319358;
	Tue, 25 Aug 2009 23:03:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A23619357; Tue, 25 Aug
 2009 23:03:46 -0400 (EDT)
In-Reply-To: <7vvdkbl4ul.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 25 Aug 2009 18\:51\:46 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 164C1100-91ED-11DE-A3C4-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127061>

Junio C Hamano <gitster@pobox.com> writes:

> I think --ignore-scissors is a good thing to add, regardless of what the
> definition of scissors should be.  So your patch should definitely be
> separated into two parts.

Having thought about this a bit more, I do not think --ignore-scissors
makes much sense, for several reasons.

Traditionally, a few lines of "background material" that accompanies a
patch, without being a part of discussion thread that quotes large chunks
of original message with ">" (like you see above), are given below the
three-dash line, not above "scissors".  This is a good practice not only
because we did not have "scissors" support in mailinfo, but because it
forced the author to be concise and to the point, and also immediately
below the three-dash lines is where the diffstat comes, and it is a place
designed to be used for memory refreshers (e.g. "I changed this and that
from the previous round based on comments by ...").

The scissors feature shouldn't be used as the replacement for this, not
from technical but from human efficiency reasons, as you have to first
read above scissors and then jump your eyes down to diffstat, before
deciding if it is worth your time to read the commit log message and the
patch.

When there is a long discussion, a message in the thread, after following
the usual discussion style, may give a (counter)proposal as a "how about
this" patch.  Such a patch is still _primarily_ for discussion, but it
sometimes turn out to be a good solution to the problem discussed in the
thread.  The maintainer (or participant) then deliberately picks that
message and feeds it to "am", and it would be nice if things above
scissors are removed automatically.  This is the _only_ intended use case
of the "scissors" line.

I therefore conclude that using the "remove above scissors" should be a
conscious decision, and should not be enabled by default.  --obey-scissors
would be a good option for this reason.

Besides, if you _lost_ information because the scissors that is on by
default gave a false positive, you have to reset HEAD^ and re-apply.  If
on the other hand we mistakenly kept cruft above a scissors, we can edit
it away using "rebase -i".  So the failure recovery is much nicer if the
feature is not on by default.
