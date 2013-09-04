From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Wed, 04 Sep 2013 12:14:30 -0700
Message-ID: <xmqqob88mmax.fsf@gitster.dls.corp.google.com>
References: <20130903075107.GA25540@goldbirke>
	<20130903080358.GA30158@sigill.intra.peff.net>
	<CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
	<20130903111006.GJ29840@goldbirke>
	<CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
	<20130903150855.GK29840@goldbirke> <20130903170419.GA29921@google.com>
	<xmqqli3co7ov.fsf@gitster.dls.corp.google.com>
	<20130904171356.GD2582@serenity.lan>
	<xmqq1u54o5c4.fsf@gitster.dls.corp.google.com>
	<20130904183559.GA3465@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 04 21:14:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHIXJ-0006dL-4U
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 21:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935Ab3IDTOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 15:14:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37787 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616Ab3IDTOg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 15:14:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D713D3EF99;
	Wed,  4 Sep 2013 19:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XZUf54U2dhg01TVdmsQWQQgpSmk=; b=wgC1ja
	KfTxGI6mVfhIPX6OFpvkr23DnpGIZrjgnNIcCxR0w4l+EFEsaMx3Sz9cU+juyPZh
	B1rfpKN7DHxvdjyVJRpNt7rbP1HXAo74V07ktPJkhOovm5k/PdqFFk23aHUxhKph
	gwg3pSS0OS91li9jlnlPdo4Xkg9oCXujedwDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rTe5HHRUW65fs02iDe3Ylkl8XfEplHHx
	g4y4pzmOoaAYUrb7JQ1cBotQmC/IRlOJ6uVy+cajPvlxcIowJj5aZ5NDgCFaBYhy
	/3u+LMoHNEaoH40JDiCKcHropMklGiyqvqBlInmcXQ3jPO+tp4ay0R84RzMGkCdK
	23KVGAADaAo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 353803EF95;
	Wed,  4 Sep 2013 19:14:34 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CDFE3EF89;
	Wed,  4 Sep 2013 19:14:32 +0000 (UTC)
In-Reply-To: <20130904183559.GA3465@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 4 Sep 2013 14:36:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3AD8C46A-1596-11E3-8594-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233864>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 04, 2013 at 10:38:03AM -0700, Junio C Hamano wrote:
>
>> >> This is way off tangent, but I am somewhat sympathetic to Felipe's
>> >> "compare actual with expect", with reservations.
>> >
>> > This isn't an argument either way, but note that JUnit (and NUnit and
>> > PHPUnit) all have assertEquals methods that take the arguments in the
>> > order "expect, actual".  I've always assumed that Git's test framework
>> > was imitating that,...
>> 
>> No.  See 82ebb0b6 (add test_cmp function for test scripts,
>> 2008-03-12).  The "test_cmp" was a replacement for "diff -u", and
>> the same order we fed "diff -u", i.e. expect then actual, was
>> carried over.
>
> I don't think it was intentional at the time.

I do not think so, either. The only thing we cared about was "are
they equal".  And from the point of view of test_cmp exit status,
that still the only thing we care about.  Comparison to see which is
greater is a superset of equality check we needed, and in that
context, the order did not and does not matter.

One only starts to notice the order of comparison when one starts
thinking about the comparison in terms of "what is subtracted from
what", and at that point, one realizes that "diff A B" that gives us
what was lost from A to B as "-" and what was gained in B relative
to A as "+" is showing the result of subtracting A from B.  And that
subtraction is backwards from the cmp(A,B) that subtracts B from A,
which is the usual convention.

> Though I prefer the current, I can certainly live and adapt to a changed
> standard, and I do not mind doing so if there is a good reason. But I've
> yet to see any argument beyond "it is not what I like". Which to me
> argues for the status quo as the path of least resistance.

As I think test_cmp is primarily about equality comparison, I do not
think it is worth switching and adapting.  Switching makes sense
only in my dreams where we did not have to worry about in-flight
topics and people's brains that are used to the current order.

That is exactly where my "with reservations" came from.
