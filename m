From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 7 Apr 2009 22:35:36 +0200
Message-ID: <20090407203536.GD4413@atjola.homenet>
References: <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm> <fabb9a1e0904051436i1dc9c1bdhe86a23e470c756f9@mail.gmail.com> <alpine.LFD.2.00.0904052315210.6741@xanadu.home> <20090407081019.GK20356@atjola.homenet> <m3tz5023rq.fsf@localhost.localdomain> <alpine.LFD.2.00.0904070903020.6741@xanadu.home> <20090407142147.GA4413@atjola.homenet> <alpine.LFD.2.00.0904071321520.6741@xanadu.home> <20090407181259.GB4413@atjola.homenet> <20090407202954.GA13501@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 07 22:37:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrI2m-0003Lg-O3
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 22:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503AbZDGUfm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 16:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756252AbZDGUfm
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 16:35:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:35231 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755503AbZDGUfl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 16:35:41 -0400
Received: (qmail invoked by alias); 07 Apr 2009 20:35:39 -0000
Received: from i59F5B7E9.versanet.de (EHLO atjola.local) [89.245.183.233]
  by mail.gmx.net (mp043) with SMTP; 07 Apr 2009 22:35:39 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX198rWUt9tt8HUUAjKArZVl4UL4O9vST8edbgJSHkE
	oAW7dRAFWwPnN3
Content-Disposition: inline
In-Reply-To: <20090407202954.GA13501@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115987>

On 2009.04.07 16:29:54 -0400, Jeff King wrote:
> On Tue, Apr 07, 2009 at 08:12:59PM +0200, Bj=F6rn Steinbrink wrote:
>=20
> > If so, that doesn't look it it's going to work out as easily as one
> > would hope. Robin said that both processes, git-upload-pack (which =
does
> > the rev-list) and pack-objects peaked at ~2GB of RSS (which probabl=
y
> > includes the mmapped packs). But the above pack-objects with --all =
peaks
>=20
> I thought he said this, too, but look at the ps output he posted here=
:
>=20
>   http://article.gmane.org/gmane.comp.version-control.git/115739
>=20
> It clearly shows upload-pack with a tiny RSS, and pack-objects doing =
all
> of the damage.

That second git-upload-pack is the interesting one. upload-pack forks t=
o
do the rev-list stuff, without changing its process name, so it keeps
being listed as upload-pack. And as the process already died, its
RSS/VZS dropped to zero.

Bj=F6rn
