From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Sun, 08 Sep 2013 11:33:19 -0700
Message-ID: <xmqqvc2b5fkg.fsf@gitster.dls.corp.google.com>
References: <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
	<20130903150855.GK29840@goldbirke> <20130903170419.GA29921@google.com>
	<xmqqli3co7ov.fsf@gitster.dls.corp.google.com>
	<20130904171356.GD2582@serenity.lan>
	<xmqq1u54o5c4.fsf@gitster.dls.corp.google.com>
	<20130904183559.GA3465@sigill.intra.peff.net>
	<CAMP44s3O=cHAtHOj41MccBDOausukb49MV-E6jib6n6czs+p3Q@mail.gmail.com>
	<20130908040615.GA14019@sigill.intra.peff.net>
	<CAMP44s16RZ9JguL=NPcD8TE-gdG7vGEa5KLHzv4bf_VLLEhPRw@mail.gmail.com>
	<20130908042649.GC14019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 20:33:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIjnm-0007Gm-Ls
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 20:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977Ab3IHSdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 14:33:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54629 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab3IHSdW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 14:33:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7C1C3F9A6;
	Sun,  8 Sep 2013 18:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w4Xn/4e1zJ9ypb/jxhYFFcH/vZg=; b=PU8pnC
	fqAQC/x8h3wXtYFw03jZyRR+6qMgA8Sb+ePV78giksaoSPC+T3f0EbRzNeBm1VTq
	kQUsrFaYU/xqVWn9LkqnSHcQXn4itlO1xzRibIlIsqLokEh+5gsdSTqbm6844WY0
	Jk6t4/Tlrw5vb7HGIfk++kRdeIQzaRYMgSMvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CRZXFq2blwE8mTqA7NR50+5n9mOofCsU
	cH1PZ1ls4NuNK9Jtg6Zwj/IKK8Per+KjVPTLEZWwypmOy80U16DZ/gJzssLrxUpm
	9b/ZSPnRDpvO9/vmpd6cUETnodf0fc6RapNfZtu/01tZ2D/DaSKMdC1nKu4u1Am9
	e2fgfyMMIsg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D7B53F9A5;
	Sun,  8 Sep 2013 18:33:21 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2D353F9A4;
	Sun,  8 Sep 2013 18:33:20 +0000 (UTC)
In-Reply-To: <20130908042649.GC14019@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 8 Sep 2013 00:26:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 23417046-18B5-11E3-AC6A-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234259>

Jeff King <peff@peff.net> writes:

>> A(ny) sanely defined "compare A with B" function should yield the
>> result of subtracting B from A, i.e. cmp(A,B) should be like (A-B).
>> That is what you feed qsort() and bsearch() (it is not limited to C;
>> you see the same in "sort { $a <=> $b }").  The definition naturally
>> makes "cmp(A,B) < 0" like "A < B" and "cmp(A,B) > 0" like "A > B".
>> ---
>
> Ah, you mean "if you think that the compare function should behave like
> C *_cmp functions, it should be A-B". Perhaps it is simply that I do not
> think of the function in those terms, but more like "show me the
> differences from B to A".



>
>> > Otherwise why would so many
>> > existing test frameworks do it the other way?
>> 
>> Which many existing frameworks do it the other way?
>
> John mentioned JUnit, NUnit, and PHPUnit earlier in the thread. I
> believe that Ruby's Test::Unit::Assertions also has
> assert_equal(expected, actual).

Especially the last one can be excused.  "is A and B equal" is a
binary between "yes" and "no".  If A and B are equal, B and A are
equal, and it becomes more like "which endianness is correct?" as
you mentioned earlier.

I think the real cause of confusion is that "cmp(1)" is not a
comparison in that sense but is an equality check; "test_cmp" has a
dual purpose in that its primary use as "did the previous step
produce correct result?" is an equality check and the order does not
really matter, but its secondary purpose, to show how the actual
output deviated from the norm, has to be done by subtracting the
expected result from the actual result.

As I said, I am somewhat sympathetic to those who want to see such
subtraction spelled as cmp(Actual,Expect), but we are so used to the
order "diff(1)" takes expect and actual to do that subtraction in
that order, so using diff(Expect,Actual) order is not that wrong.

Calling the abstraction "test_diff" might have avoided the wasted
brain bandwidth in this thread, but I do not think renaming it in
test-lib-functions.sh is worth the trouble, either ;-)
