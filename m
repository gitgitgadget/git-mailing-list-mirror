From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: remote set-* <name> and <branch>
Date: Wed, 22 Feb 2012 01:03:10 +0100
Message-ID: <20120222000310.GA13237@goldbirke>
References: <1329571973-20796-1-git-send-email-philip@foolip.org>
	<7vvcn2lyw6.fsf@alter.siamese.dyndns.org>
	<CAKHWUkZjQYnf=LwS_RC-E_7gV73AzbWjxs33E5-FL25s6_qX4g@mail.gmail.com>
	<7v8vjvg71s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip =?iso-8859-1?Q?J=E4genstedt?= <philip@foolip.org>,
	git@vger.kernel.org,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 01:03:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzzgD-0006ZR-DQ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 01:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636Ab2BVAD2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 19:03:28 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:58665 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596Ab2BVAD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 19:03:28 -0500
Received: from localhost6.localdomain6 (p5B130361.dip0.t-ipconnect.de [91.19.3.97])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0Lfneo-1SpEiU3vf0-00pVli; Wed, 22 Feb 2012 01:03:09 +0100
Content-Disposition: inline
In-Reply-To: <7v8vjvg71s.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:B6qFGg3AkFj3LO6R7rpW+Yt83JhBayt095CrlsR4uSp
 bWJRr5oBnLfGbY0J3wlaq4VFmgWM3O+b5sc+8rrXzWNgdDX0VO
 P8QAf4HrZeeD0jBEAoS92e08sSY1VC6Mb+T6UUE3/CxpHcrFTq
 B6BjyjmvZLE1imfS9vO1Q0Ht0pEHOZgbTxPehEfskEpUhilRTj
 jYlMB+NE+sVKauYY+POPUMcKhqtNVSuIcmPSMMBYBjoOLV92N2
 QHYO2zI4bcSbVN0HMl67PF1r/r5IQAUZHkX1Pi7Qkx5H0fcdrn
 Hn2MYEkHLogu4eYHPDF6nzAYhVmMWR4xDcgGW7qLDtohnY6tNO
 ZV7IDhR8FQd3xLXYHdAo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191201>

On Tue, Feb 21, 2012 at 02:23:11PM -0800, Junio C Hamano wrote:
> >>> =A0{
> >>> =A0 =A0 =A0 local cur_=3D"$cur" cmd=3D"${words[1]}"
> >>> =A0 =A0 =A0 local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complet=
e_refspec=3D0
> >>> + =A0 =A0 if [ "$cmd" =3D "remote" ]; then
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 c=3D$((++c))
> >>> + =A0 =A0 fi
> >>
> >> I don't know about others, but auto-incrementing a variable and as=
signing
> >> the result to the same variable, while not wrong at all, hurts my =
brain.
> >>
> >> =A0 =A0 =A0 =A0c=3D$(($c + 1))
> >>
> >> is far more readable and does not suggest there is any funky magic
> >> involved. =A0Also it is a good habit to get into not to omit $ fro=
m
> >> variables inside arithmetic substitution, even though bash allows =
it and
> >> this script is meant to be consumed only by shells that understand=
 this
> >> bash-ism.
> >>
> >> I do not know offhand if zsh groks it, but the point is that you d=
o not
> >> have to worry about it if you write "$(($c+1))" instead of "$((c+1=
))".

This c=3D$((++c)) style increment is used in several completion
functions, even in the main entry function _git() itself.  If zsh
didn't grok it, then completion wouldn't work at all on zsh, because
the while loop in _git() would be an endless loop.

> > CodingGuidlines suggests to follow local convention, which was
> > "c=3D$((++c))". This file also uses "++n", "i++" and "((i++))". I w=
ill
> > send a v2 patch that normalizes these, open to discussion of course=
=2E
>=20
> OK, it was my mistake to suggest $c++ in this file; it liberally uses
> dollar-less variables, and I agree that it is a good idea to stick to=
 that
> local convention.
>=20
> But I think you went too far in your follow-up patch to make the incr=
ement
> and decrement uniform.
>=20
> "i++" is so much easier on the eye unless you must use "++i" in order=
 to
> use the value of the incremented "i" in an expression, and the change=
s to
> turn existing instances of free-standing "i++" to "++i" done only for=
 the
> side effect of incrementing the variables look totally backwards.
>=20
> Although I do not deeply care.  Just leaving the new one as you origi=
nally
> wrote, i.e.
>=20
> 	c=3D$((++c))
>=20
> would have been easier to review for the area experts, I would think.

The issue of this weird increment came up before

  http://thread.gmane.org/gmane.comp.version-control.git/87650/focus=3D=
87806

and the conclusion back then was that we kept the existing style.  But
otherwise I agree, it hurts my brain, too.


Best,
G=E1bor
