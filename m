From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/RFC 01/10] Teach rebase interactive the mark command
Date: Mon, 14 Apr 2008 02:24:25 -0400
Message-ID: <20080414062425.GB20979@spearce.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de> <7vskxsneau.fsf@gitster.siamese.dyndns.org> <20080412101110.GD31356@alea.gnuu.de> <20080413035648.GY10274@spearce.org> <20080413165011.GB3179@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: =?utf-8?B?SsO2cmc=?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon Apr 14 08:25:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlI7w-0007Hs-UO
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 08:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbYDNGYc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Apr 2008 02:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754030AbYDNGYc
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 02:24:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47431 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959AbYDNGYb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2008 02:24:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JlI77-0008Mn-Ti; Mon, 14 Apr 2008 02:24:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AEF4220FBAE; Mon, 14 Apr 2008 02:24:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080413165011.GB3179@alea.gnuu.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79461>

Jrg Sommer <joerg@alea.gnuu.de> wrote:
> Shawn O. Pearce schrieb am Sat 12. Apr, 23:56 (-0400):
> >=20
> > Why not use the mark syntax that fast-import uses?
>=20
> I didn't know it.
>=20
> > In fast-import we use ":n" anytime we need to refer to a mark, e.g.
> > ":1" or ":5".
>=20
> Currently, I don't restrict the mark to be a number. It can anything =
that
> is a valid ref. Should I restrict it?

In fast-import a mark can *only* be a number.  It cannot be a ref
string or anything complex like that.  This reduces the memory load
of fast-import, but does cause a burden on the import frontend.
=20
> And how do you handle the :/ syntax? =E2=80=9Creset :/Bla=E2=80=9D is=
 than not valid.
> Mmm, I'll add an exception for :/.

I think the ':/' syntax came along after fast-import had already starte=
d
to use ':' as the mark syntax.  I forgot to object to this bastard form
of looking up a commit when it was introduced by Dscho and now we have
a SHA-1 expression syntax that fast-import will confuse with a mark.  I
originally had chosen to start a mark off with ':' because it is not an
allowed character in a ref, due to its use to split src:dst in a fetch
or push refspec.
=20
> Except of this, I prefer to use the colon to be much closer to the sy=
ntax
> of fast-import.

Me too, but it looks like in a human edited "TODO" script we may want
to be more friendly and allow named marks.  Though I'm not sure that is
really all that useful.  If you are merging something because it used t=
o
be merged before the rebase I doubt we'd generate a meaningful mark nam=
e
when the TODO script is initially formatted.

--=20
Shawn.
