From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC v3 6/8] Add case insensitivity support when using git ls-files
Date: Sun, 3 Oct 2010 20:19:09 +0200
Message-ID: <201010032019.09244.j6t@kdbg.org>
References: <4CA847D5.4000903@workspacewhiz.com> <1286099806-25774-7-git-send-email-avarab@gmail.com> <AANLkTimH8Lj69qcOCmR3+5HYfgKnr5nyMvQU=9h0=FaB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brandon Casey <drafnel@gmail.com>
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Sun Oct 03 20:19:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2T9c-0007yy-P8
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 20:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab0JCSTP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 14:19:15 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:30055 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754401Ab0JCSTP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 14:19:15 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B208BCDF87;
	Sun,  3 Oct 2010 20:19:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5038A19F609;
	Sun,  3 Oct 2010 20:19:09 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTimH8Lj69qcOCmR3+5HYfgKnr5nyMvQU=9h0=FaB@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157890>

On Sonntag, 3. Oktober 2010, Thomas Adam wrote:
> Hi --
>
> On 3 October 2010 10:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> > + =C2=A0 =C2=A0 =C2=A0 if (ignore_case) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (;;) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 unsigned char c1 =3D tolower(*match);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 unsigned char c2 =3D tolower(*name);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (c1 =3D=3D '\0' || is_glob_special(c1))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (c1 !=3D c2)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 match++;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 name++;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 namelen--;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 } else {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (;;) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 unsigned char c1 =3D *match;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 unsigned char c2 =3D *name;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (c1 =3D=3D '\0' || is_glob_special(c1))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (c1 !=3D c2)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 match++;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 name++;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 namelen--;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> It's a real shame about the code duplication here.  Can we not avoid
> it just by doing:
>
> unsigned char c1 =3D (ignore_case) ? tolower(*match) : *match;
> unisgned char c2 =3D (ignore_case) ? tolower(*name) : *name;
>
> I appreciate that to some it might look like perl golf, but...

It has been discussed, and IIRC, the concensus was to keep the code=20
duplication because this is an inner loop.

-- Hannes
