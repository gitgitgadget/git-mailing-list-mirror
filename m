From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH] tests: Introduce test_seq
Date: Sat, 4 Aug 2012 00:09:04 +0200
Message-ID: <20120804000904.13c4162b@gmail.com>
References: <20120803160229.GA13094@sigill.intra.peff.net>
	<1344023835-8947-1-git-send-email-michal.kiedrowicz@gmail.com>
	<20120803200201.GA10344@sigill.intra.peff.net>
	<7v3943bsuc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 00:09:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxQ3d-00028q-9K
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 00:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab2HCWJP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 18:09:15 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35793 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab2HCWJN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2012 18:09:13 -0400
Received: by wgbdr13 with SMTP id dr13so1053825wgb.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 15:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=7Cs6oPwqGleVn8ATQWDUp0b5+Z8WyM93hIiZgnSlBzo=;
        b=DIMdYrNcdN2FBeU7IUUVtJbIbz03nbsG8gqCy0kHYh7e4bkzDyQNoXEybXCssyEfTs
         8pCl1hvhdaTJEMQ7TbiWqmtx59NW5VnZq5Da0qikg0Joru2nDrP2p7l0e0Cl2Xx+Rhvb
         HwD/6vyfbn0UnOySVr1AZ0KkBA92lLJmRpQqq60fAf5BLJBNRAXeEAPp8qVy/urcB2Z0
         sOAZ0BLumQAsEprnHTyopOEmFbyhC8augbi+M98XznV8OQm/glq+Oi/wxW7fQZxqEjbW
         g2y8q0BEIJtlSKQyJfkbRYMv/l3tS166QKkDamowE863sqw5pdbOu4LmjCxe6gZh9LzI
         I3IQ==
Received: by 10.180.14.34 with SMTP id m2mr7464244wic.21.1344031749374;
        Fri, 03 Aug 2012 15:09:09 -0700 (PDT)
Received: from localhost (94-178-78-94.net.stream.pl. [94.78.178.94])
        by mx.google.com with ESMTPS id ef5sm29332287wib.3.2012.08.03.15.09.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 15:09:08 -0700 (PDT)
In-Reply-To: <7v3943bsuc.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202866>

Junio C Hamano <gitster@pobox.com> wrote:

> Jeff King <peff@peff.net> writes:
>=20
> > On Fri, Aug 03, 2012 at 09:57:15PM +0200, Micha=C5=82 Kiedrowicz wr=
ote:
> >
> >> Jeff King wrote:
> >>=20
> >> 	The seq command is GNU-ism, and is missing at least in older BSD
> >> 	releases and their derivatives, not to mention antique
> >> 	commercial Unixes.
> >>=20
> >> 	We already purged it in b3431bc (Don't use seq in tests, not
> >> 	everyone has it, 2007-05-02), but a few new instances have crept
> >> 	in. They went unnoticed because they are in scripts that are not
> >> 	run by default.
> >>=20
> >> This commit replaces them with test_seq that is implemented with a=
 Perl
> >> snippet (proposed by Jeff).
>=20
> Just say "Replace them with test_seq...", without "This commit".
>=20
> > Fine explanation, but...
> >
> >> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> >> index 5580c22..a1361e5 100644
> >> --- a/t/perf/perf-lib.sh
> >> +++ b/t/perf/perf-lib.sh
> >> @@ -163,7 +163,7 @@ test_perf () {
> >>  		else
> >>  			echo "perf $test_count - $1:"
> >>  		fi
> >> -		for i in $(seq 1 $GIT_PERF_REPEAT_COUNT); do
> >> +		for i in $(test_seq 1 $GIT_PERF_REPEAT_COUNT); do
> >
> > Two args to test_seq, but...
> >
> >> +# test_seq is a portable replacement for seq(1).
> >> +# It may be used like:
> >> +#
> >> +#	for i in `test_seq 100`; do
> >> +#		echo $i
> >> +#	done
> >> +
> >> +test_seq () {
> >> +	test $# =3D 1 ||
> >> +	error "bug in the test script: not 1 parameter to test_seq"
> >> +	last=3D$1
> >> +	"$PERL_PATH" -le "print for 1..$last"
> >> +}
> >
> > it wants only one.
> >
> > I think you would want:
> >
> >   test $# =3D 1 && set -- 1 "$@"
> >   "$PERL_PATH" -le "print for $1..$2"
> >
> > It might also be worth quoting the parameters like this:
> >
> >   "$PERL_PATH" -le "print for '$1'..'$2'"
> >
> > so that "test_seq a f" works, too.
>=20
> Yeah, I like that last one, but then unlike the claim in the comment
> before the function definition, it is not "a portable replacement
> for seq(1)" at all, but something a lot more suited for our purpose.
> So at least the comment needs to be updated.  I do not have strong
> opinion on calling this test_seq when it acts differently from seq;
> it is not confusing enough to make me push something longer that is
> different from "seq", e.g. test_sequence.
>=20

I prefer "test_seq" because it reminds seq which helps learning how to
use it.  If some other seq feature is ever needed (e.g. increment value=
,
decrementing), it may be added at any time (but I don't think so, there
are only few usages after years of test suite existence).

> Wouldn't it be cleaner and readable to write it like this
>=20
> 	"$PERL_PATH" -le 'print for $ARGV[0]..$ARGV[1]' "$1" "$2"
>=20
> by the way?
