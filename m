From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] gitweb-lib.sh: Set up PATH to use perl from /usr/bin
Date: Tue, 01 May 2012 19:03:39 +0200
Message-ID: <4FA0176B.50300@in.waw.pl>
References: <201205011323.45190.tboegi@web.de> <4FA00E09.2090708@in.waw.pl> <7vsjfjalx6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	jnareb@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 19:04:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPGUV-00009p-54
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756638Ab2EARDt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 13:03:49 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35786 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756174Ab2EARDt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:03:49 -0400
Received: from ip-37-209-134-178.free.aero2.net.pl ([37.209.134.178])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SPGUM-0003rq-Ri; Tue, 01 May 2012 19:03:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <7vsjfjalx6.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196695>

On 05/01/2012 06:47 PM, Junio C Hamano wrote:
> Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:
>=20
>> Hm, I see that most scripts have #!/usr/bin/perl, and only two have
>> #!env perl [1]. So in general we usally rely on using perl in /usr/b=
in.
>=20
> The #!/usr/bin/env variants should be eradicated.  Our Makefile rewri=
tes
> "#!.*perl" with "#!$PERL_PATH" in scripted Porcelains before installi=
ng,
> so /usr/bin/perl is the right thing to write there.
This would be trivial, as it is only two files.

But I don't see why we would use a different perl in
git-am.sh:                      perl -ne 'BEGIN { $subject =3D 0 }
git-am.sh:                      perl -M'POSIX qw(strftime)' -ne 'BEGIN =
{ $subject =3D 0 }
git-request-pull.sh:ref=3D$(git ls-remote "$url" | perl -e "$find_match=
ing_ref" "$head" "$headrev")
git-submodule.sh:       perl -e '
test-sha1.sh:                   perl -pe 'y/\000/g/'
test-sha1.sh:                   perl -pe 'y/\000/g/'
and lot of files in t/. Shouldn't those be replaced too?

Jeff King wrote:
> The Makefile substitutes $PERL_PATH on the #!-line of each perl scrip=
t
> during its "build" step (which is really just copying the file to its
> final name and running "chmod +x").
Thank you for the explanation. I never noticed this, since I don't set
PERL_PATH myself.

Zbyszek
