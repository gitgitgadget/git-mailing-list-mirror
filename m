From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [ANNOUNCE] GIT 1.6.1
Date: Thu, 25 Dec 2008 12:42:15 +0100
Message-ID: <49537197.1000805@lsrfire.ath.cx>
References: <7v7i5odams.fsf@gitster.siamese.dyndns.org> <20081225100033.GA8451@b2j> <7v3agca7fp.fsf@gitster.siamese.dyndns.org> <20081225102527.GB8451@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 12:43:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFocv-0001HL-Qi
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 12:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbYLYLmW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Dec 2008 06:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbYLYLmW
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 06:42:22 -0500
Received: from india601.server4you.de ([85.25.151.105]:51308 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbYLYLmW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 06:42:22 -0500
Received: from [10.0.1.101] (p57B7FA84.dip.t-dialin.net [87.183.250.132])
	by india601.server4you.de (Postfix) with ESMTPSA id A9C3B2F8003;
	Thu, 25 Dec 2008 12:42:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (X11/20081125)
In-Reply-To: <20081225102527.GB8451@b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103900>

bill lam schrieb:
>> Why are you building with NO_UINTMAX_T to begin with?  Isn't ubuntu =
8.10 a
>> recent enough platform that ships with modern enough header files th=
at
>> define ANSI uintmax_t type?
>=20
> No, I did not do anything on that,=20
>=20
> make clean
> ./configure --prefix=3D/usr
> make=20
>=20
> and this is the error logged.
> =20
> GIT_VERSION =3D 1.6.1
>     * new build flags or prefix
> In file included from /usr/include/netinet/in.h:24,
>                  from git-compat-util.h:78,
>                  from builtin.h:4,
>                  from fast-import.c:142:
> /usr/include/stdint.h:136: error: conflicting types for =E2=80=98uint=
32_t=E2=80=99
> /usr/include/stdint.h:52: error: previous declaration of =E2=80=98uin=
t32_t=E2=80=99 was here
> fast-import.c: In function =E2=80=98parse_progress=E2=80=99:
> fast-import.c:2339: warning: ignoring return value of =E2=80=98fwrite=
=E2=80=99, declared with attribute warn_unused_result
> make: *** [fast-import.o] Error 1
>=20
> version of gcc:
> gcc (Ubuntu 4.3.2-1ubuntu11) 4.3.2

I don't get any error on Ubuntu 8.10 on x86_64 (but several of those=20
warnings about ignored return values), neither with the tar file nor a=20
cloned repository (in the former case I had to add a "make configure"=20
step, though).

Line 52 of /usr/include/stdint.h:
	typedef unsigned int		uint32_t;

Lines 134-136 of /usr/include/stdint.h:
	#if __WORDSIZE =3D=3D 64
	typedef long int		intmax_t;
	typedef unsigned long int	uintmax_t;

If you get to line 136, you probably are on a 64 bit installation, too,=
=20
correct?

configure seems to be confused.  What happens if you take it out of the=
=20
equation, i.e. run the following commands?

	$ make distclean
	$ make prefix=3D/usr

Ren=C3=A9
