From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Wed, 04 Sep 2013 09:47:12 -0700
Message-ID: <xmqqli3co7ov.fsf@gitster.dls.corp.google.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
	<1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
	<20130903071256.GD3608@sigill.intra.peff.net>
	<20130903075107.GA25540@goldbirke>
	<20130903080358.GA30158@sigill.intra.peff.net>
	<CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
	<20130903111006.GJ29840@goldbirke>
	<CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
	<20130903150855.GK29840@goldbirke> <20130903170419.GA29921@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 18:47:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHGEj-0006Dd-Eo
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 18:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935304Ab3IDQrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 12:47:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43709 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934560Ab3IDQrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 12:47:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D3D03FCC3;
	Wed,  4 Sep 2013 16:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZnfsUlROh9anvwD/h6NfIB5lT9g=; b=Mh/uQM
	4ylNX3zHmH3acx/YhX8CMkN8MhYEBiN0wrNamaV1MzyR0IzlWOudFBzlIIZc5iGE
	O7D4GrMTZBvVi/h70cQsKXXkCaO3gxpv9p57JxSqU8lEBRJ2bJTN1v/T6H5yL54L
	7QDO+EaSt0VBj6t9gCMuieKfSxfkL7/VlsfQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HqoabKq/BEm5mlvXYetTHREW1+veEkMo
	sJm5Vrd7GH7IWl+l0SJgFhGDYPKSX6yMezb7QjZGP3j0pUrsLb+mDPtgAhKB0g3w
	dwM0UAY4Ef5SnRbhzzevIpRdfvQ+PWZht9ClNeml2Zs8l7klrzosDZCeYQQ3SsuJ
	vRep3FfXWlw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7903D3FCC2;
	Wed,  4 Sep 2013 16:47:15 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB79C3FCBD;
	Wed,  4 Sep 2013 16:47:14 +0000 (UTC)
In-Reply-To: <20130903170419.GA29921@google.com> (Jonathan Nieder's message of
	"Tue, 3 Sep 2013 10:04:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A706B9AE-1581-11E3-9744-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233847>

Jonathan Nieder <jrnieder@gmail.com> writes:

> test_cmp_rev follows the same order of arguments a "diff -u" and
> produces the same output as plain "git diff".  It's perfectly readable
> and normal.

This is way off tangent, but I am somewhat sympathetic to Felipe's
"compare actual with expect", with reservations.

If one ignores all other constraints and focuses solely on the order
of argument test_cmp takes, one would realize that it is backwards.
A(ny) sanely defined "compare A with B" function should yield the
result of subtracting B from A, i.e. cmp(A,B) should be like (A-B).
That is what you feed qsort() and bsearch() (it is not limited to C;
you see the same in "sort { $a <=> $b }").  The definition naturally
makes "cmp(A,B) < 0" like "A < B" and "cmp(A,B) > 0" like "A > B".

But unfortunately, test_cmp is defined in terms of "diff -u" by
feeding its parameters in the same order as given.  "test_cmp A B"
just turns into "diff -u A B".

Now, we _do_ want to see "diff -u expect actual", so that in the
output, what is _missing_ in the actual output compared to the
expected output is marked with "-", and what is _excess_ is marked
with "+".  If you think about it, this output from "diff -u expect
actual" is giving us the result of subtracting expect from actual.

If we want to express it in terms of "cmp", we should be writing
"cmp(actual,expect)", not "cmp(expect,actual)".  The latter is to
subtract actual from expect, which is backwards.

It would have been better if a wrapper around "diff" to give us a
higher level "comparison" semantics, test_cmp, had been written in
such a way that hid this backward behaviour of "diff", when it was
introduced to replace hardcoded "diff -u".

I'd actually be ecstatic if one morning when I get up, I find that
test_cmp implementation were replaced with (the moral equivalent of)

	test_cmp () {
		diff -u "$2" "$1"
	}

and all the callsites of test_cmp in the test scripts in all the
topic branches in flight were also swapped to "test_cmp actual
expect" without anybody having to worry about mismerges, merge
conflicts and confusing people who are used to the current order for
the past 5 years.

But I do not think that is going to happen without a careful
planning.  We may be able to manage the code somehow (we can drop
all the topics in flight immediately after a release, apply the
"swap the order" big patch, and rebase all the topics on top), but
retraining people would not be instantaneous "flag day" event, and
we will see mistakes for a few months after doing so.

Oh, well.
