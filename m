From: Brian Foster <brian.foster@maxim-ic.com>
Subject: Re: [Q] Branch aliases (synonyms)?
Date: Wed, 4 Jul 2012 09:24:27 +0200
Message-ID: <1352871.G8Zbg5HGke@laclwks004>
References: <1919214.YKUdgul2iY@laclwks004> <CALKQrgeAXLSwsqwTe_FZN0aNHwnoSBHBt+PO9jpCtzRM1Aeyrw@mail.gmail.com> <93495bc04d9f7426bef1b1de1b202280@ulrik.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>,
	git mailing list <git@vger.kernel.org>
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Wed Jul 04 09:24:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmJx2-0002Ni-Le
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 09:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933632Ab2GDHYg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jul 2012 03:24:36 -0400
Received: from antispam02.maxim-ic.com ([205.153.101.183]:35142 "EHLO
	antispam02.maxim-ic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933452Ab2GDHYf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jul 2012 03:24:35 -0400
X-ASG-Debug-ID: 1341387044-0520cc55ee1f5380001-QuoKaX
Received: from maxdalex01.maxim-ic.internal (maxdalex01.maxim-ic.internal [10.16.15.101]) by antispam02.maxim-ic.com with ESMTP id TsIPSlPnMZK90q1u; Wed, 04 Jul 2012 02:30:44 -0500 (CDT)
X-Barracuda-Envelope-From: brian.foster@maxim-ic.com
Received: from maxsvlex02.maxim-ic.internal (10.32.112.18) by
 maxdalex01.maxim-ic.internal (10.16.15.101) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Wed, 4 Jul 2012 02:24:31 -0500
Received: from laclwks004.localnet (10.201.0.45) by
 maxsvlex02.maxim-ic.internal (10.32.112.18) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Wed, 4 Jul 2012 00:24:29 -0700
X-ASG-Orig-Subj: Re: [Q] Branch aliases (synonyms)?
User-Agent: KMail/4.7.3 (Linux/3.0.0-22-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <93495bc04d9f7426bef1b1de1b202280@ulrik.uio.no>
X-Barracuda-Connect: maxdalex01.maxim-ic.internal[10.16.15.101]
X-Barracuda-Start-Time: 1341387044
X-Barracuda-URL: http://192.168.10.183:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at maxim-ic.com
X-Barracuda-Spam-Score: 0.12
X-Barracuda-Spam-Status: No, SCORE=0.12 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=CN_BODY_332
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.101708
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.12 CN_BODY_332            BODY: CN_BODY_332
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200992>

On Tuesday 03-July-2012 10:49:39 Hallvard Breien Furuseth wrote:
>[ ... ]
>  Yes, a symref in the master repo only seems tidy enough.
>  I should have realized that's what he meant.

 My apologies.  I just re-read my original Question,
 and realize I failed to make that clear.  YES, the
 only place there would be a symref is in the master
 repo (we call it the =E2=80=9Cmain=E2=80=9D repo).

>  I can think of one irritant to warn developers of:
>=20
>    git fetch           # Fetches both A and B
>    git checkout A      # Lemme see how this looks for A users...
>    ...
>    git checkout B      # My scripts are still using B though...
>    ...commit something...
>    git push            # Pushes B, doesn't know remote A is forwarded
>    git push            # Rejected, non-fast-forward of your old A
>=20
>  "WTF, why does that keep happening all the time?"
>=20
>    git branch -d A     # Fixes the above (if A is not checked out:)

 No developer can push to =E2=80=9Cmain=E2=80=9D (we use Gerrit as
 a front-end / staging-area),  Approved Patches go
 from Gerrit =E2=86=92 =E2=80=9Cmain=E2=80=9D (both internal) and then =
on
 to the externally-accessible mirrors.  The clients
 pull/fetch from the mirrors, and cannot push to any
 of the Gerrit, =E2=80=9Cmain=E2=80=9D, or the mirrors.
=20
 Any feedback from the clients  =E2=80=94 which is Very Rare
 (not sure if that's Good or Bad?) =E2=80=94  is currently
 done via e-mail, which is put into Gerrit as per
 the usual process.

 Nonetheless, your point is quite valid.  We would
 have to warn developers (and the clients) about
 switch-ing back and forth between A and B.  This
 is one reason I myself am less-than-keen on the
 idea, along with not liking the merge plan anyways.

>  And if you haven't already, it may be best to do
>=20
>    git config --bool receive.denyNonFastForwards  true
>    git config --bool receive.denyDeletes          true

 Ah!  That seems like a Good Idea, regardless of whether
 we do this symref'ing or not.  Many Thanks for the tip!

 We do have some access controls, both a front-end and
 hook(s?), on the mirrors which are supposed to prevent
 those sort of things (and other abuses), but I have no
 objection to yet another barrier / protective measure.

cheers!
	-blf-

--=20
Brian Foster
Principal MTS, Software        |  La Ciotat, France
Office:  +33 (0)4 42 98 15 35  |  Fax:  +33 (0)4 42 08 33 19
Maxim Integrated Products      |  Web:  http://www.maxim-ic.com/
