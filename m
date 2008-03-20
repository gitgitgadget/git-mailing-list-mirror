From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [SoC RFC] libsvn-fs-git: A git backend for the subversion filesystem
Date: Thu, 20 Mar 2008 11:01:48 +0100
Organization: At home
Message-ID: <frtcmc$l8m$1@ger.gmane.org>
References: <3e8340490803182108y40a9aec2q8e5bcb78b907bbb5@mail.gmail.com> <20080320045632.GB8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 11:02:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcHbg-0003ZB-Nv
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 11:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989AbYCTKCE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2008 06:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753987AbYCTKCD
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 06:02:03 -0400
Received: from main.gmane.org ([80.91.229.2]:37330 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753980AbYCTKCB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 06:02:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JcHau-0004EA-9Q
	for git@vger.kernel.org; Thu, 20 Mar 2008 10:01:56 +0000
Received: from abwi48.neoplus.adsl.tpnet.pl ([83.8.232.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 10:01:56 +0000
Received: from jnareb by abwi48.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 10:01:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwi48.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77647>

[Cc: Shawn O. Pearce <spearce@spearce.org>,=20
     Bryan Donlan <bdonlan@gmail.com>,
     git@vger.kernel.org]

Shawn O. Pearce wrote:
> Bryan Donlan <bdonlan@gmail.com> wrote:

>> /revmap/NNN - a reference to the commit hash in the .git-svn branch
>> =A0 corresponding to the given subversion revision number
>=20
> How about using a simple flat file interface? =A0To initially prime
> the file you can do something like:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0git rev-list --topo-order --date-order --reve=
rse --all \
> =A0=A0=A0=A0=A0=A0=A0=A0       >.git/svn-map=20
>=20
> and then number the revisions by the line number that they appear on.
> Locating a Git SHA-1 for a specific SVN revision would be a simple
> case of lseek(fd, 41 * rev, SEEK_SET). =A0Going the other direction
> would be more of a challenge, but is still doable.
>=20
> Updating the file should just require appending new commits; if
> the SVN client wants a new commit you append on and return the
> line number. =A0If Git has caused new commits not in this file you
> need to rebuild the log. =A0This would have to be done incrementally,
> to prevent changing a prior SVN revision number that clients may
> already know about.

By the way, have you looked into what git-svn uses? IIRC it had some
improvements to avoid spending more disk space on SVN revno <-> Git SHA=
-1
mapping than on the repository itself...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
