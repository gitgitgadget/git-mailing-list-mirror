From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] xdl_merge(): fix a segmentation fault when refining conflicts
Date: Sat, 30 Dec 2006 20:47:34 +0100
Organization: At home
Message-ID: <en6fj1$ji5$1@sea.gmane.org>
References: <20061227041644.GA22449@spearce.org> <Pine.LNX.4.63.0612271214120.19693@wbgn013.biozentrum.uni-wuerzburg.de> <87fyb11ouy.fsf@wine.dyndns.org> <Pine.LNX.4.63.0612281710350.19693@wbgn013.biozentrum.uni-wuerzburg.de> <20061229041626.GA12072@spearce.org> <Pine.LNX.4.63.0612301944350.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Dec 30 20:45:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0k8n-00023j-Hb
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 20:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWL3To7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 30 Dec 2006 14:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWL3To7
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 14:44:59 -0500
Received: from main.gmane.org ([80.91.229.2]:41765 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030317AbWL3To6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 14:44:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H0k8N-0000dx-4D
	for git@vger.kernel.org; Sat, 30 Dec 2006 20:44:47 +0100
Received: from host-81-190-24-56.torun.mm.pl ([81.190.24.56])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Dec 2006 20:44:47 +0100
Received: from jnareb by host-81-190-24-56.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Dec 2006 20:44:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-56.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35630>

<opublikowany i wys=B3any>

Johannes Schindelin wrote:

> On Thu, 28 Dec 2006, Shawn Pearce wrote:
>=20
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> >    Thank you Alexandre! I looked for the bug for quite some time, =
but=20
>> >    was never close to the real culprit.
>>=20
>> Thanks for fixing this!
>> =20
>> > +<<<<<<< orig.txt
>> > +=3D=3D=3D=3D=3D=3D=3D
>> > +Nam et si ambulavero in medio umbrae mortis,
>> > +non timebo mala, quoniam TU mecum es:
>> > +virga tua et baculus tuus ipsa me consolata sunt.
>> > +>>>>>>> new5.txt
>>=20
>> As a side note I lately have noticed that xdl_merge is producing a
>> conflict like the above when one branch added the lower half and
>> the other branch didn't change anything in the area.
>>=20
>> I haven't spent any time to try to reproduce it, or to see if RCS'
>> merge utility would automatically merge the file without producing
>> a conflict.  But right now it does seem like xdl_merge is producing
>> conflicts when I didn't think it should be.
>=20
> I thought very long about that problem. It looks like a bug, but it i=
s=20
> not. At least in my humble opinion.
>=20
> If you touched the same spot in two different versions, say you added=
 a=20
> fix in one branch, and that fix and a comment in the other one, you m=
ight=20
> be tempted to automatically resolve that conflict, taking the version=
 with=20
> the comment.
>=20
> But it helps you catch mismerges: If you add a chunk of identical cod=
e in=20
> the two branches, but with an increment _before_ it in one branch, an=
d=20
> _after_ it in the other branch, both should be marked as a conflict.=20
>=20
> Of course, you can hit mismerges like the illustrated one _without_ b=
eing=20
> marked as conflict (e.g. if the chunk of identical code is _not_ adde=
d,=20
> but only the increments), but we should at least avoid them where=20
> possible.

Perhaps you could make it even more conservating merge conflicts option
(to tighten merge conflicts even more) to xdl_merge, but not used by de=
fault
because as it removes accidental conflicts it increases mismerges (fals=
ely
not conflicted).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
