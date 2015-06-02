From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFCv3 2/2] git rebase -i: warn about removed commits
Date: Tue, 2 Jun 2015 18:32:16 +0200 (CEST)
Message-ID: <133653833.39653.1433262736640.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433252180-25591-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1433252180-25591-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <vpqzj4ignwe.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 18:32:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzp6z-0003sA-UL
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 18:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbbFBQcS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2015 12:32:18 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:49381 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752615AbbFBQcQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 12:32:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id A6C3A280E;
	Tue,  2 Jun 2015 18:32:13 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gzTsmXTgrqSl; Tue,  2 Jun 2015 18:32:13 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 95A0827A4;
	Tue,  2 Jun 2015 18:32:13 +0200 (CEST)
In-Reply-To: <vpqzj4ignwe.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git rebase -i: warn about removed commits
Thread-Index: +89WAzknqfOdsxtImoahEJAlOHNHtg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270561>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> > Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes=
:
> > +                # Sort the SHA-1 and compare them
> > +                echo "$(sort -u "$todo".oldsha1)" >"$todo".oldsha1
> > +                echo "$(sort -u "$todo".newsha1)" >"$todo".newsha1
>=20
> Useless uses of echo.
>=20
> echo $(foo) -> foo

In this case it is not true, because of the infile and outfile being
identical. However sort does have a -o (-output) that I missed that
allows avoiding using echo or writing in another file; I'm correcting
with this.

> You should test also that
>=20
> git rebase --edit-todo # playing with $EDITOR to restore the original=
 lines.
> git rebase --continue
>=20
> actually continues. You did have problems with this in early
> implementations, so it's not straightforward, so it deserves a test.

In this patch, the error is dealt with a die_abort and not die, thus
there is no rebase --edit-todo or rebase --continue possible
afterward.

> You should check the output of git rebase -i too.

Checking that the warning was correctly displayed like in the test for
"warn" if I understood correctly. About that, is checking that the
first line is "Warning: some commits may have been dropped
accidentally." (like in the test for "warn") enough, or should I check
that the commit displayed as removed is the correct one?

The other points have been corrected, or their correction is in
progress.

Thanks,

R=C3=A9mi
