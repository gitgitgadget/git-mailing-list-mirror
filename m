From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 7 Apr 2009 22:27:25 +0200
Message-ID: <20090407202725.GC4413@atjola.homenet>
References: <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm> <fabb9a1e0904051436i1dc9c1bdhe86a23e470c756f9@mail.gmail.com> <alpine.LFD.2.00.0904052315210.6741@xanadu.home> <20090407081019.GK20356@atjola.homenet> <m3tz5023rq.fsf@localhost.localdomain> <alpine.LFD.2.00.0904070903020.6741@xanadu.home> <20090407142147.GA4413@atjola.homenet> <alpine.LFD.2.00.0904071321520.6741@xanadu.home> <20090407181259.GB4413@atjola.homenet> <alpine.LFD.2.00.0904071454250.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 07 22:31:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrHuv-0008DA-Vi
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 22:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321AbZDGU1a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 16:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbZDGU1a
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 16:27:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:38511 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755348AbZDGU1a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 16:27:30 -0400
Received: (qmail invoked by alias); 07 Apr 2009 20:27:27 -0000
Received: from i59F5B7E9.versanet.de (EHLO atjola.local) [89.245.183.233]
  by mail.gmx.net (mp025) with SMTP; 07 Apr 2009 22:27:27 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/Wq3MbGjDWK8kWsp7Ho2wzngzQJSKjf1UdeDZA+3
	7u9ySiSwSUzi25
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904071454250.6741@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115985>

On 2009.04.07 14:56:41 -0400, Nicolas Pitre wrote:
> On Tue, 7 Apr 2009, Bj=F6rn Steinbrink wrote:
>=20
> > On 2009.04.07 13:48:02 -0400, Nicolas Pitre wrote:
> > > The first low hanging fruit to help this case is to make upload-p=
ack use=20
> > > the --revs argument with pack-object to let it do the object enum=
eration=20
> > > itself directly, instead of relying on the rev-list output throug=
h a=20
> > > pipe.  This is what 'git repack' does already.  pack-objects has =
to=20
> > > access the pack anyway, so this would eliminate an extra access f=
rom a=20
> > > different process.
> >=20
> > Hm, for an initial clone that would end up as:
> > git pack-objects --stdout --all
> > right?
> >=20
> > If so, that doesn't look it it's going to work out as easily as one
> > would hope. Robin said that both processes, git-upload-pack (which =
does
> > the rev-list) and pack-objects peaked at ~2GB of RSS (which probabl=
y
> > includes the mmapped packs). But the above pack-objects with --all =
peaks
> > at 3.1G here, so it basically seems to keep all the stuff in memory=
 that
> > the individual processes had. But this way, it's all at once, not 2=
G
> > first and then 2G in a second process, after the first one exitted.
>=20
> Right, and it is probably faster too.
>=20
> Can I get a copy of that repository somewhere?

http://git.overlays.gentoo.org/gitweb/?p=3Dexp/gentoo-x86.git;a=3Dsumma=
ry

At least that's what I cloned ;-) I hope it's the right one, but it fit=
s
the description...

Bj=F6rn
