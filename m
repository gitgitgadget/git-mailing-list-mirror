From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH 3/3] git-checkout.txt: a note about multiple checkout
 support for submodules
Date: Tue, 6 Jan 2015 23:30:15 +0200
Message-ID: <20150106213015.GA32489@wheezy.local>
References: <1420278087-14613-1-git-send-email-pclouds@gmail.com>
 <1420278087-14613-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 22:38:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8bp1-0008LC-2E
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 22:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933017AbbAFVhq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jan 2015 16:37:46 -0500
Received: from p3plsmtpa07-06.prod.phx3.secureserver.net ([173.201.192.235]:40035
	"EHLO p3plsmtpa07-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932918AbbAFVhp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jan 2015 16:37:45 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jan 2015 16:37:45 EST
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-06.prod.phx3.secureserver.net with 
	id clWT1p0095B68XE01lWYfb; Tue, 06 Jan 2015 14:30:34 -0700
Content-Disposition: inline
In-Reply-To: <1420278087-14613-4-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262101>

On Sat, Jan 03, 2015 at 04:41:27PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> The goal seems to be using multiple checkouts to reduce disk space.
> But we have not reached an agreement how things should be. There are =
a
> couple options.
>=20
>  - You may want to keep $SUB repos elsewhere (perhaps in a central
>    place) outside $SUPER. This is also true for nested submodules
>    where a superproject may be a submodule of another superproject.
>=20
>  - You may want to keep all $SUB repos in $SUPER/modules (or some
>    other place in $SUPER)
>=20
>  - We could even push it further and merge all $SUB repos into $SUPER
>    instead of storing them separately. But that would at least requir=
e
>    ref namespace enabled.
>=20
> On top of that, git-submodule.sh expects $GIT_DIR/config to be
> per-worktree, at least for the submodule.* part. Here I think we have
> two options, either update config.c to also read
> $GIT_DIR/config.worktree (which is per worktree) in addition to
> $GIT_DIR/config (shared) and store worktree-specific vars in the new
> place, or update git-submodule.sh to read/write submodule.* directly
> from $GIT_DIR/config.submodule (per worktree).
>=20
> These take time to address properly. Meanwhile, make a note to the
> user that they should not use multiple worktrees in submodule context=
=2E

I'd like to describe though how much the glass is full:

If all submodules exist in same paths in all checked-out
commits, and there is no special settings, only
`submodule.<name>.url` is set, then user can inspect, commit
and update the submodule content. Submodules can be either
independedntly initalized with `submodule update --init`
(being a fully independet clone), or checked-out with
`checkout --to` to the submodule worktree.

It is even verified by tests, so does it worth mentioning in
some manpage or at least commit message?

--=20
Max
