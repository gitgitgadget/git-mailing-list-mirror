From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: What's cooking in git.git (Aug 2008, #05; Tue, 19)
Date: Tue, 19 Aug 2008 22:59:17 +0200
Message-ID: <20080819205917.GJ23800@genesis.frugalware.org>
References: <7vpro5cr2x.fsf@gitster.siamese.dyndns.org> <20080819125429.GD17582@genesis.frugalware.org> <7vabf83j9u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 23:00:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVYJX-0007PN-Rd
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 23:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbYHSU7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 16:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbYHSU7W
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 16:59:22 -0400
Received: from virgo.iok.hu ([193.202.89.103]:35836 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbYHSU7W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 16:59:22 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E2E5B1B250C;
	Tue, 19 Aug 2008 22:59:20 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 3F8554465E;
	Tue, 19 Aug 2008 22:03:09 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5DD561770019; Tue, 19 Aug 2008 22:59:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vabf83j9u.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92922>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 19, 2008 at 12:19:09PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Since the latter is what everybody else ("checkout -m", "revert",
> "cherry-pick", "am -3", "stash apply") should be using, I think it is
> pretty much up to "git-merge" and "git-merge-recursive" implementations
> how the caller of merge_recursive() function is structured.  I suspect
> that you would not need two separate functions, _setup() and _generic(),
> for these two codepaths, but I didn't look closely.

Sure, I can avoid _generic() and use merge_recursive() directly, that's
why I asked.

> And make_virtual_commit() should become static inside merge_recursive.c;
> use of these fake commits is strictly an internal implementation issue of
> how merge_recursive() function works and does not concern the caller, does
> it?

Not exactly. builtin-merge-recursive uses get_ref() - which should not
be in merge-recursive.c IMHO - and get_ref() uses make_virtual_commit().
merge_recursive() itself takes commits, so it can be only static if we
copy it builtin-merge-recursive as well, causing a code duplication. Or
have I missed something here?

Thanks.

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkirNCUACgkQe81tAgORUJY0TQCeOsQK5QcqBnHIMOT+FNUBtiEH
sqsAmQExizBCWT6JY5Y8vKOZZnQI7Pvw
=mPtE
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
