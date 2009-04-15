From: Holger =?iso-8859-1?Q?Wei=DF?= <holger@zedat.fu-berlin.de>
Subject: Re: [PATCH/RESEND] gitweb: Fix snapshots requested via PATH_INFO
Date: Wed, 15 Apr 2009 12:09:55 +0200
Organization: Freie =?iso-8859-1?Q?Universit=E4t?= Berlin
Message-ID: <20090415100955.GA33221014@CIS.FU-Berlin.DE>
References: <20090414104648.GA36554444@CIS.FU-Berlin.DE> <7vvdp6xvv3.fsf@gitster.siamese.dyndns.org> <cb7bb73a0904150233wfa72b1fn85692f81880f6848@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git List <git@vger.kernel.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 12:12:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu267-0007vO-PA
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 12:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757472AbZDOKKA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2009 06:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753784AbZDOKKA
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 06:10:00 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:51478 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753375AbZDOKJ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Apr 2009 06:09:59 -0400
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1Lu245-0000jQ-AG>; Wed, 15 Apr 2009 12:09:57 +0200
Received: from mail.cis.fu-berlin.de ([160.45.11.138])
          by relay1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1Lu243-0004X6-Ff>; Wed, 15 Apr 2009 12:09:55 +0200
Received: by Mail.CIS.FU-Berlin.DE (Exim 4.69)
          with local
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1Lu243-02UCwt-CE>; Wed, 15 Apr 2009 12:09:55 +0200
Mail-Followup-To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cb7bb73a0904150233wfa72b1fn85692f81880f6848@mail.gmail.com>
X-Operating-System: IRIX64 6.5.30f
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Originating-IP: 160.45.11.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116601>

* Giuseppe Bilotta <giuseppe.bilotta@gmail.com> [2009-04-15 11:33]:
> On Wed, Apr 15, 2009 at 8:40 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
> > Holger Wei=DF <holger@zedat.fu-berlin.de> writes:
> >> Fix the detection of the requested snapshot format, which failed f=
or
> >> PATH_INFO URLs since the references to the hashes which describe t=
he
> >> supported snapshot formats weren't dereferenced appropriately.
> >>
> >> Signed-off-by: Holger Wei=DF <holger@zedat.fu-berlin.de>
> >> ---
> >> I guess this one got lost. =A0Without this patch, snapshots won't =
work if
> >> Gitweb is configured to generate PATH_INFO URLs. =A0(Original Mess=
age-ID:
> >> <20090331161636.GV30233737@CIS.FU-Berlin.DE>).
> >
> > The patch looks obviously correct; "our %known_snapshort_formats" m=
aps a
> > name to a hashref, but the current code makes a nonsense assignment=
,
> > essentialy doing ($fmt, %opt) =3D ($name, $hashref), but what would=
 I
> > know... =A0I am not using gitweb actively.
>=20
> My gitweb over at http://git.oblomov.eu/ supports snapshots with
> PATH_INFO just fine even without the need for this patch.

Really?  If I try to download a snapshot from your site, I get an empty
tarball (and the server appends an additional ".tar.gz" suffix to the
filename within the "Content-disposition" header).  For example:

$ wget -q -O - http://git.oblomov.eu/git/snapshot/v1.6.2.3.tar.gz | gzi=
p -d | tar -t | wc -l
0

That's the bug which is fixed by my patch.

Holger
