From: Rudolf Polzer <divVerent@alientrap.org>
Subject: Re: [PATCH v2] Add push --set-upstream
Date: Sat, 16 Jan 2010 19:13:51 +0100
Message-ID: <20100116181350.GA28938@rm.endoftheinternet.org>
References: <1263595630-18962-1-git-send-email-ilari.liusvaara@elisanet.fi> <be6fef0d1001151700se963950i6932d30bae3ca940@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miles Bader <miles@gnu.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 19:14:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWDA7-0004r8-HA
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 19:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657Ab0APSOM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jan 2010 13:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198Ab0APSOM
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 13:14:12 -0500
Received: from rm.endoftheinternet.org ([94.23.21.40]:37258 "EHLO
	r23604.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752573Ab0APSOL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 13:14:11 -0500
Received: from rpolzer by r23604.ovh.net with local (Exim 4.69)
	(envelope-from <divVerent@alientrap.org>)
	id 1NWD9j-0007cE-Kv; Sat, 16 Jan 2010 19:13:52 +0100
Content-Disposition: inline
In-Reply-To: <be6fef0d1001151700se963950i6932d30bae3ca940@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137245>

On Sat, Jan 16, 2010 at 09:00:30AM +0800, Tay Ray Chuan wrote:
> Hi,
>=20
> I'm adding people from the "git push --track" thread here, since this
> feature is related to what they want.
>=20
> (sorry for any line-wrap mangling in the patch.)

Looks perfect to me, and if people want it, one could add the same opti=
on as an
alias to the current --track option to the checkout and branch commands=
=2E

> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Chase symbolic refs (mainly for HE=
AD). */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 localname =3D i->peer_ref->name;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 remotename =3D i->name;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D resolve_ref(localname, sha, 1=
, &flag);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tmp && flag & REF_ISSYMREF &&
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !prefixcmp(tmp, "refs=
/heads/"))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 localname =3D tmp;

I would never have thought of that case - good catch.

> > @@ -974,6 +1016,10 @@ int transport_push(struct transport *transpor=
t,
> > =A0 =A0 =A0 =A0verify_remote_names(refspec_nr, refspec);
> >
> > =A0 =A0 =A0 =A0if (transport->push) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Maybe FIXME. But no important tran=
sport uses this case. */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flags & TRANSPORT_PUSH_SET_UPSTRE=
AM)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("This transport d=
oes not support using --set-upstream");
> > +

That's ONE way to do it - and seriously, I don't know if anyone uses th=
at
transport :P

However, one possible improvement for this case would be setting ALL pu=
shed
refs as tracking if the push succeeded, and none otherwise.

Are new transports going to be added that use transport->push, or is th=
at
interface deprecated anyway?

Best regards,

Rudolf Polzer
