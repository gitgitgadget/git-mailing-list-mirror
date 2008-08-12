From: Petr Baudis <pasky@suse.cz>
Subject: Re: TopGit: problem with patch series generation
Date: Wed, 13 Aug 2008 00:59:16 +0200
Message-ID: <20080812225916.GN10151@machine.or.cz>
References: <20080812161854.GB30067@lapse.rw.madduck.net> <8aa486160808121428t259f5340x6d1a14cadedac30c@mail.gmail.com> <20080812224155.GB15521@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?iso-8859-2?Q?B=E9jar?= <sbejar@gmail.com>,
	git discussion list <git@vger.kernel.org>,
	Manoj Srivastava <srivasta@debian.org>,
	vcs distro packaging discussion list 
	<vcs-pkg-discuss@lists.alioth.debian.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Aug 13 01:00:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT2qi-0006MS-OZ
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 01:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbYHLW7U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Aug 2008 18:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbYHLW7T
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 18:59:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33456 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457AbYHLW7T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 18:59:19 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id DF89A393A807; Wed, 13 Aug 2008 00:59:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080812224155.GB15521@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92151>

On Tue, Aug 12, 2008 at 07:41:55PM -0300, martin f krafft wrote:
> also sprach Santi B=E9jar <sbejar@gmail.com> [2008.08.12.1828 -0300]:
> > I don=B4t know if it fits topgit, but this is what Junio uses:
> >=20
> > http://article.gmane.org/gmane.comp.version-control.git/24498
>=20
> I think this is definitely something TopGit can automate.

This seems to be in principle the same as the tie branches. It might
make sense to have a way to _optionally_ make a tie branch.

How should that work? Maybe there needs to be even an explicit support
for this - should TopGit just check the dependency tree when
sequencing the topic branches and have a step that says:

	"I'm going to sequence branch A. If there is branch T that has
	only already sequenced branches + branch A as dependencies,
	use T's content instead of A."

Would that be satisfactory?

=46inding out this information would be very expensive, of course. But =
for
other reasons, we might want to keep a cache of branch dependencies.

Of course, in the case of

        A1--A2--A3--A4--C
                       /
        B1--B2--B3--B4.

the sequenced branches would still be like

        A1--A2--A3--A4--B1--B2--B3--C

unless you create the T1..T4 branches manually.

--=20
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
