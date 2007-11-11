From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui messes up the diff view on non ASCII characters
Date: Sun, 11 Nov 2007 00:59:59 -0500
Message-ID: <20071111055959.GW14735@spearce.org>
References: <20071109154935.GC28800@xp.machine.xx> <200711092230.37905.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Baumann <waste.manager@gmx.de>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 07:00:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir5rp-0006jA-L6
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 07:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbXKKGAG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 01:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbXKKGAG
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 01:00:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39306 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbXKKGAF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2007 01:00:05 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ir5rW-0006b5-EH; Sun, 11 Nov 2007 01:00:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8BA2820FBAE; Sun, 11 Nov 2007 00:59:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200711092230.37905.barra_cuda@katamail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64407>

Michele Ballabio <barra_cuda@katamail.com> wrote:
> On Friday 09 November 2007, Peter Baumann wrote:
> > I'm managing some UTF-8 encoded LaTeX files in git, which include s=
ome
> > non ASCII characters like the german =C3=A4,=C3=B6 and =C3=BC. If I=
 view the diff with
> > git-diff on an UTF8 enabled terminal, all looks nice. So does the d=
iff
> > view in gitk after I commited my changes. Only git-gui shows some
> > "strange" characters, so I assume it is an encoding problem.
> >=20
> > I have to admit that I'm totally unaware how this should work, but =
at
> > least I think my configuration is correct here, because otherwise g=
it-diff
> > or gitk would show the same behaviour. Is there anything which coul=
d be
> > done to make git-gui happy, too?
>=20
> It's a known issue, and already on Shawn's ToDo list. I have to add t=
hat
> viewing untracked UTF8 files in git-gui works just fine. Weird.

Cute.  That's because in the untracked case we open the file and
let the platform's chosen encoding be used to convert it into the
text viewer.  In the tracked diff case we force the encoding to
be in binary.

Now gitk works because it assumes the diff is in the same character
encoding as the commit message itself.  Since commit messages are
typically in UTF-8 (as that is the Git default encoding) then a
UTF-8 encoded file shows correctly in gitk.

What's the right behavior here?  Just assume the platform encoding
is correct for the file we are showing and show it?  Assume the
commit encoding configured in i18n.commitencoding is the correct
one for the file content?  Something else?

--=20
Shawn.
