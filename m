From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 7/7] t/README: Document the do's and don'ts of tests
Date: Mon, 05 Jul 2010 19:35:44 -0700
Message-ID: <7vaaq58hhb.fsf@alter.siamese.dyndns.org>
References: <1278082789-19872-1-git-send-email-avarab@gmail.com>
 <1278082789-19872-8-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 04:36:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVy0x-0006Za-0P
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 04:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756736Ab0GFCf5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Jul 2010 22:35:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45928 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009Ab0GFCf4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 22:35:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2563AC2B20;
	Mon,  5 Jul 2010 22:35:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=7YTbSiocvfwnOAtzwBldcSoFd
	J0=; b=bSJWeaTiPoBn3lNwLXT5o/yYAzDcyNPsvCZ8kmtMcbAp6OkebV/NE/wPq
	urcFPIeVGI+Ro3kZdeQNo73H8VU0hqYv6urM+gqhbd99sWC68ivtNwMT3NsSJhJY
	mpBG4DLKGgJ8vESxXk3z8C2ZwHC9rCsFLz++xIrSF1zy8wrgbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=p2C+Aqh4kGdCfXV+OfZ
	xIZ4SDgt7qY4NJvvs1Dxi7QDC5a0OX38YCE6BQVu1jm9x6l1X75yk2VgpKXIBUtj
	p4ehrw3aFMlxm4Trk8zNRiBMcRJiZBcPy3DRW7/tGAmo56pUQbvPl99OJQ1l6MnL
	Kjbnc6ClNnb4wUAwZMZZrGsM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E7F43C2B1E;
	Mon,  5 Jul 2010 22:35:49 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00B4AC2B1A; Mon,  5 Jul
 2010 22:35:45 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3082D066-88A7-11DF-80F5-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150307>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> +Do's, don'ts & things to keep in mind
> +-------------------------------------
> +
> +Here's a few examples of things you probably should and shouldn't do
> +when writing tests.

"Here are" perhaps?

> +Do:
> +
> + - Put as much code as possible inside test_expect_success and other
> +   assertions.
> +
> +   Even code that isn't a test per se, but merely some setup code
> +   should be inside a test assertion if at all possible. Test script=
s
> +   should only have trivial code outside of their assertions.

Let's make it even stronger; "should only have trivial" -> "shouldn't h=
ave
any ... unless there is a good reason."

> +Don't:
> +
> + - exit() within a <script> part.
> +
> +   The harness will catch this as a programming error of the test.
> +   Use test_done instead if you need to stop the tests early (see
> +   "Skipping tests" below).
> +
> + - Break the TAP output
> +
> +   The raw output from your test might be interpreted by a TAP
> +   harness. You usually don't have to worry about that. TAP harnesse=
s

I'd recommend dropping "You usually...about that"  You do care, but the
limitation may be not so severe.

> +   will ignore everything they don't know about, but don't step on
> +   their toes in these areas:
> +
> +   - Don't print lines like "$x..$y" where $x and $y are integers.
> +
> +   - Don't print lines that begin with "ok" or "not ok".
> +
> +   A TAP harness expect a line that begins with either "ok" and "not
> +   ok" to signal a test passed or failed (and our harness already
> +   produces such lines), so your script shouldn't emit such lines to
> +   their output.
> +
> +   You can glean some further possible issues from the TAP grammar
> +   (see http://search.cpan.org/perldoc?TAP::Parser::Grammar#TAP_Gram=
mar)
> +   but the best indication is to just run the tests with prove(1),
> +   it'll complain if anything is amiss.
> +
> +Keep in mind:
> +
> + - That what you print to stderr and stdout is usually ignored
> +
> +   Inside <script> part, the standard output and standard error

Splitting the above into two sentences (or a header and a body) makes i=
t
unclear that your "usually" comes from the earlier "Do Put as much code
inside test_expect_success...".  I think you can simply drop "That what
you print ... ignored".

Everything else in the series looked good.  Thanks.
