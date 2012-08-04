From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] tests: Introduce test_seq
Date: Sat, 04 Aug 2012 18:38:08 +0200
Message-ID: <501D4FF0.4060109@kdbg.org>
References: <20120803160229.GA13094@sigill.intra.peff.net> <1344023835-8947-1-git-send-email-michal.kiedrowicz@gmail.com> <20120803200201.GA10344@sigill.intra.peff.net> <7v3943bsuc.fsf@alter.siamese.dyndns.org> <20120804000904.13c4162b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBLaWVkcm93aWN6?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 18:38:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxhMr-00045q-3s
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 18:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301Ab2HDQiQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Aug 2012 12:38:16 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:27216 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751002Ab2HDQiP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 12:38:15 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 26041130049;
	Sat,  4 Aug 2012 18:38:08 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8D32319F6F8;
	Sat,  4 Aug 2012 18:38:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <20120804000904.13c4162b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202880>

Am 04.08.2012 00:09, schrieb Micha=C5=82 Kiedrowicz:
> Junio C Hamano <gitster@pobox.com> wrote:
>> I do not have strong
>> opinion on calling this test_seq when it acts differently from seq;
>> it is not confusing enough to make me push something longer that is
>> different from "seq", e.g. test_sequence.
>=20
> I prefer "test_seq" because it reminds seq which helps learning how t=
o
> use it.  If some other seq feature is ever needed (e.g. increment val=
ue,
> decrementing), it may be added at any time (but I don't think so, the=
re
> are only few usages after years of test suite existence).

And the reason for this is that we always told people "don't use seq"
and they submitted an updated patch. What would we have to do now? We
have to tell them "don't use seq, use test_seq". Therefore, the patch
does not accomplish anything useful, IMO.

The function should really just be named 'seq'.

Or how about this strategy:

seq () {
	unset -f seq
	if ! seq 1 2 >/dev/null 2>&1
	then
		# don't have a working seq; provide it as a function
		seq () {
			insert your definition here
		}
	fi
	seq "$@"
}

but it is not my favorite.

-- Hannes
