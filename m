From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Is anyone working on a next-gen Git protocol?
Date: Sun, 7 Oct 2012 23:22:20 +0300
Message-ID: <20121007202220.GA16115@LK-Perkele-VI.localdomain>
References: <CACBZZX6b+3P8M+z+X13k9Pq3tvVUfs_k1=foQVreX8K801=efQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, spearce@spearce.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 22:28:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKxT1-0008AW-Ur
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 22:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967Ab2JGU2d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2012 16:28:33 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:48138 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867Ab2JGU2c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Oct 2012 16:28:32 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Oct 2012 16:28:32 EDT
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02.mail.saunalahti.fi (Postfix) with SMTP id 51A1D81817;
	Sun,  7 Oct 2012 23:22:27 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A05C8650617; Sun, 07 Oct 2012 23:22:27 +0300
Received: from LK-Perkele-VI (a88-112-55-20.elisa-laajakaista.fi [88.112.55.20])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id A1A64188774;
	Sun,  7 Oct 2012 23:22:22 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <CACBZZX6b+3P8M+z+X13k9Pq3tvVUfs_k1=foQVreX8K801=efQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207192>

On Sun, Oct 07, 2012 at 09:57:56PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>=20
> Has anyone started working on a next-gen Git protocol as a result of
> this discussion? If not I thought I'd give it a shot if/when I have
> time.

Unfortunately, client signaling the version is nasty to do in ways that
wouldn't cause current servers to hang up or do other undesirable thing=
s.

git://: Git-daemon will hang up[1] if it receives command it won't
understand (and one can't add arguments either).

ssh://: Commands are NAKed in non-standard ways (e.g. Gitolite vs. shel=
l)
and one can't add arguments.

file://: That's easy.

CONNECT: The helper needs to be told that v2 is supported (helper doing
the rest).

Maybe with git://, one could hack the stuff in similar way as virtual
hosting was added. But that won't work with SSH (nor one can use enviro=
nment
with SSH).

:-/

[1] And there is no guarantee that the server end of git:// is git-daem=
on.
There's at least one git:// server implemetation that responds to unkno=
wn
commands by ERR packet followed by hangup.=20

-Ilari
