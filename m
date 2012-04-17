From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 1/2] tests: move code to run completion tests under
	bash into a helper library
Date: Tue, 17 Apr 2012 02:42:44 +0200
Message-ID: <20120417004244.GD2299@goldbirke>
References: <20120416160124.GL5813@burratino>
	<1334614176-2963-1-git-send-email-szeder@ira.uka.de>
	<20120416234923.GZ12613@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 02:42:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJwVU-0005LN-9c
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 02:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427Ab2DQAmv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 20:42:51 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:60550 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755Ab2DQAmv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 20:42:51 -0400
Received: from localhost6.localdomain6 (p5B130635.dip0.t-ipconnect.de [91.19.6.53])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MWORa-1Sn6Ny1uAs-00X6Fr; Tue, 17 Apr 2012 02:42:44 +0200
Content-Disposition: inline
In-Reply-To: <20120416234923.GZ12613@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:nFoo8A+HA3D/WXKqSC90yAkDouL6TgqQPfp6mv5s+vq
 VU05TSLcKddRWyFF1HpXlOMSBcMEzsg4uQ0Ud2Umw2liHHK/1M
 4yigcjfU87hA/Yhs/Pz8Ak1vC2HFXOothnGVfrXncGfVkMTrY0
 dB8KeaMSdjAxsjxXRnnC74R0fV6lbKLng3EpRY3Mvp6DWr2m6U
 ttuRA1uwOmi9LjP7jD/RIzU+WrrBGDir893fmfurxfjgypgR8A
 HKRVlyDtDOwjshtJF29nnAfyDECwF0demwBJ4loYTWlF8tK2VU
 /k9O+gIbCVdgv91O/be078WEU4Bqi+uhsqNT3DnLUNr7gyv9zB
 UQ88kEsp47D1u+rg6ooA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195729>

On Mon, Apr 16, 2012 at 06:49:24PM -0500, Jonathan Nieder wrote:
> SZEDER G=E1bor wrote:
>=20
> > --- a/t/t9902-completion.sh
> > +++ b/t/t9902-completion.sh
> > @@ -3,21 +3,9 @@
> >  # Copyright (c) 2012 Felipe Contreras
> >  #
> > =20
> > -if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
> > -	# we are in full-on bash mode
> > -	true
> > -elif type bash >/dev/null 2>&1; then
> > -	# execute in full-on bash mode
> > -	unset POSIXLY_CORRECT
> > -	exec bash "$0" "$@"
> > -else
> > -	echo '1..0 #SKIP skipping bash completion tests; bash not availab=
le'
> > -	exit 0
> > -fi
> > -
> >  test_description=3D'test bash completion'
> > =20
> > -. ./test-lib.sh
> > +. ./lib-completion.sh
>=20
> If I understand correctly, this sources lib-completion immediately
> instead of following the usual pattern of
>=20
> 	. ./test-lib.sh
> 	. "$TEST_DIRECTORY/lib-completion.sh"

There are a couple of other test libs that source test-lib.sh
themselves, similarly to the new t/lib-completion.sh.

> to get the self-execing over with ASAP.

Exactly, like the original t/t9902-completion.sh.

> "$0" always refers to the
> original shell script and not the file being sourced so this should b=
e
> safe.  Looks good.

Yeah, I tested the tests ;) with dash as /bin/sh; works for me.
