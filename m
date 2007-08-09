From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: Bug in git-svn: dcommit commits in the wrong branch after a rebase
Date: Thu, 9 Aug 2007 17:45:38 +0200
Message-ID: <6E86FCDA-F2A9-4516-8CE7-E1CC385FA9E2@lrde.epita.fr>
References: <21FC6D7F-5459-406D-AA06-D16E525B3C17@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-4-61225096"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 09 17:45:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJACu-0007e7-Ge
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 17:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765244AbXHIPpt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 11:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760191AbXHIPps
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 11:45:48 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:46610 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384AbXHIPps (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 11:45:48 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA:16)
	(Exim 4.50)
	id 1IJACo-00069d-8S; Thu, 09 Aug 2007 17:45:46 +0200
In-Reply-To: <21FC6D7F-5459-406D-AA06-D16E525B3C17@lrde.epita.fr>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55456>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-4-61225096
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Aug 8, 2007, at 11:35 PM, Benoit SIGOURE wrote:

> Test case:
>
> svnadmin create repos
> svn co file://`pwd`/repos wc
> cd wc
> svn mkdir branches
> svn mkdir branches/a
> echo foo >branches/a/foo
> svn add branches/a/foo
> svn ci -m 'branch a'
> cd ..
> git-svn clone --branches=branches file://`pwd`/repos wc.git
> cd wc.git
> echo git is cool >>foo
> git-commit -a -m 'commit in git in branch a'
> cd ../wc
> svn cp branches/a branches/b
> svn ci -m 'branch b'
> cd ../wc.git
> git-svn fetch


> git-checkout -b myb b
> git-rebase master
> git-svn dcommit # sends the commit to SVN branch `a' instead of SVN  
> branch `b'!
>

Actually the test case is wrong, it should end in:
git-rebase b # while being on `master' branch
git-svn dcommit # this works as expected

Thanks to siprbaum for spotting this on IRC.  Sorry for the noise.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-4-61225096
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFGuzaiwwE67wC8PUkRAlk1AJ9l6ph1Z57A6Tiq/0oouFHqtSauQwCggfxF
4hlYYxa+Ev2OgqXbXfTbHJ0=
=6BOJ
-----END PGP SIGNATURE-----

--Apple-Mail-4-61225096--
