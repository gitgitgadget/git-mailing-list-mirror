From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Add SVN->Git conversion example to documentation
Date: Sun, 15 Jun 2008 00:47:58 +0200
Message-ID: <20080614224758.GL29404@genesis.frugalware.org>
References: <20080614215812.GA28574@zakalwe.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PesaOPe2z2CaM1eN"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Sun Jun 15 00:48:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7eYI-0001pD-4v
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 00:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472AbYFNWsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 18:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755449AbYFNWsA
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 18:48:00 -0400
Received: from virgo.iok.hu ([193.202.89.103]:48349 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755241AbYFNWr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 18:47:59 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 9390B1B24F0;
	Sun, 15 Jun 2008 00:47:58 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 190BA4469F;
	Sun, 15 Jun 2008 00:28:29 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 28E2B1770022; Sun, 15 Jun 2008 00:47:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080614215812.GA28574@zakalwe.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85049>


--PesaOPe2z2CaM1eN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 15, 2008 at 12:58:12AM +0300, Heikki Orsila <heikki.orsila@iki.fi> wrote:
> +After that, the new repository should be cleaned, and fetch heads should
> +be set.
> +------------------------------------------------------------------------
> +	cd foo.git/.git

Heh, I was confused. foo.git is usually a bare repo, if the repo has a
working directory as well, then just call it foo.

And then: if you convert an svn repo to a git one, don't you want to
convert it to a bare repo?

I haven't tried git-svn clone but the following will work for sure:

git --bare init
git --bare svn init -s URL
git --bare svn fetch

> +	rm -rf svn
> +	git config --remove-section svn-remote.svn
> +	git config remote.origin.url .
> +	git config remote.origin.fetch +refs/remotes/tags/*:refs/tags/*
> +	git config --add remote.origin.fetch +refs/remotes/*:refs/heads/*
> +	git fetch
> +	git gc

If you remove the svn dir, why don't you remove refs/remotes as well?
(Probably via update-ref since git svn will pack refs before it ends for
big repos, I think.)

Also I think it would be a good idea to give a hint how to do
incremental updates. Something like not deleting the svn dir and using
git --bare svn fetch; git fetch.

PS: I'm not a git-svn contributor or anything, just thought I give you
some advices, I hope it helped. :-)

--PesaOPe2z2CaM1eN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhUSp4ACgkQe81tAgORUJaSVACfduE7WCdAkS8k4lN96PTKDR4g
03AAn1BTQGLaRWjNRqucf05IgQz5n8dg
=M8mL
-----END PGP SIGNATURE-----

--PesaOPe2z2CaM1eN--
