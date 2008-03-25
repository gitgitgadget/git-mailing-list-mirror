From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH 4/4] git-rebase -i: New option to support rebase with
	merges
Date: Tue, 25 Mar 2008 11:13:45 +0100
Message-ID: <20080325101345.GA990@alea.gnuu.de>
References: <1206308562-31489-1-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-2-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-3-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-4-git-send-email-joerg@alea.gnuu.de> <alpine.LSU.1.00.0803232334130.4353@racer.site> <20080324111413.GA18488@alea.gnuu.de> <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, B.Steinbrink@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 11:16:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je6CX-0000Xo-MO
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 11:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbYCYKPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 06:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbYCYKPV
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 06:15:21 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:2842 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849AbYCYKPR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 06:15:17 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 007AE488036; Tue, 25 Mar 2008 11:15:15 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Je6A5-0005ij-KW; Tue, 25 Mar 2008 11:13:45 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Je6A5-0000GI-Bj; Tue, 25 Mar 2008 11:13:45 +0100
Content-Disposition: inline
In-Reply-To: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78171>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Junio C Hamano schrieb am Mon 24. Mar, 11:35 (-0700):
> If you have this history:
>
>       o---o---o---o---o---Z
>      /
>     X---Y---A---B
>          \       \
>           C---D---M---E


I would like to extend this example:

      o---o---o---o---o---Z
     /
    X---Y---A-------B
         \           \
          C---D---N---M---E
                 /
                V

> and you want to transplant the history  between X..E on top of Z, from the
> command line you would say:
>=20
> 	$ git rebase --interactive -p --onto Z X E
>=20
> First let's think what you would do if you want to do this by hand.  The
> sequence would be:
>=20
> 	$ git checkout Z^0 ;# detach at Z
>=20
>         $ git cherry-pick Y
>         $ git tag new-Y ;# remember it
>         $ git cherry-pick A
>         $ git cherry-pick B
>         $ git tag new-B ;# remember it
>         $ git checkout new-Y
>         $ git cherry-pick C
>         $ git cherry-pick D
% git merge V
>         $ git merge new-B ;# this reproduces M
>         $ git cherry-pick E
>=20
> 	$ git branch -f $the_branch && git checkout $the_branch


> Perhaps we can make it clearer by introducing a few more primitives to the
> todo language: mark, reset and merge.  The above illustrated history would
> then become:
>=20
> 	pick Y
>         mark #0
> 	pick A
>         pick B
>         mark #1
>         reset #0
>         pick C
>         pick D
merge V

V is not a mark.

> 	mark #2
>         merge #1 #2
>         pick E
>=20
> You can change any of the "pick" to "edit, or drop it, and you can reorder
> "pick" in a sequence of "pick", but you cannot change "mark", "reset",
> "merge", or move "pick" across insn that was not originally "pick".

This way we can also merge more than two branches. Your idea sounds good.

Bye, J=C3=B6rg.
--=20
Nichts ist so langweilig, wie die Wiederholung seinerselbst.
                                        (Marcel Reich=E2=80=90Ranicki)

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH6NBZwe0mZwH1VIARAqwNAJ41kV1qe0MmreKoOciia0o0sf7sXwCfefnd
EOxt1ZRQGSPCP0GsWN9E5xo=
=/9lt
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
