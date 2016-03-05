From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Making git apply always work relative to current directory
Date: Sat, 5 Mar 2016 19:42:00 +0000
Message-ID: <20160305194200.GB48536@vauxhall.crustytoothpaste.net>
References: <20160305181125.GA48536@vauxhall.crustytoothpaste.net>
 <xmqq4mckvhzq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 20:42:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acI5d-000136-BR
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 20:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbcCETmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 14:42:09 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49756 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750966AbcCETmH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Mar 2016 14:42:07 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3E20E282A1;
	Sat,  5 Mar 2016 19:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1457206926;
	bh=YcsQq/HRDOgEkWzV7TqPJ0O26IgtLDQxNSDWWPtF1lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLJ5Ww06MD9lRtHPZon+ah0UUt+fBVGL1xrj8avT4FSSvCNf7U7u52fJcNb2tkCnc
	 lmMNgyPZtgUemTo5L3KJIiqSHS5vivcUxgUBY598oL5SEN+zM0W1T895GinDAPNrLQ
	 YtUz3XrZ3mOt0x82tPdyKLmWHD1lJjlJ9rDo1IOM8NgSiDo7gVCAN2E5eCg72R9TNb
	 YiJYYaz7yIChx3jTOIO5rscxe0xywhwqbK/wJtAUwXogqm6dqvTT0yrI4Lgex8lf+Y
	 081n3bzrRxZ8QNIJ/NQuGGTMa4xytFZvdao9pmhhZoT9PNb8nSaIzpYVMEgIiCoBWG
	 PkSAnaE/vTCFQc8vuj2J0DhssxfcpSm3BpkVqKHitwPyJiXQ5QrbtRb+HR0FP+k0aP
	 k2eGHYD8kNI7NrmPDOfUDEqi6QPL5QHjj9WwNDgFWTaT73cRqItrHw2UGzj6Lc056H
	 7MsAX5fTuD97M8ROZ3vdEhyYNNhLZIt40y6Ur9xLvyNtmrIU+W6
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqq4mckvhzq.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.4.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288326>


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 05, 2016 at 11:31:53AM -0800, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > If I run git apply --no-index --verbose <patch>, it succeeds in both
> > cases, but when I'm in the git repository, it *silently does nothing*.
>=20
> That originally sounded peculiar to me and I suspected it to be a
> bug, but it looks like a designed-in feature and with us since
>=20
> commit edf2e37002eeb30a2ccad5db3b3e1fe41cdc7eb0
> Author: Junio C Hamano <junkio@cox.net>
> Date:   Fri Nov 25 23:14:15 2005 -0800
>=20
>     git-apply: work from subdirectory.
>    =20
>     When applying a patch to index file, we need to know where GIT_DIR is;
>     use setup_git_directory() to find it out.  This also allows us to work
>     from a subdirectory if we wanted to.
>    =20
>     When git-apply is run from a subdirectory, it applies the given patch
>     only to the files under the current directory and below.
>    =20
>     Signed-off-by: Junio C Hamano <junkio@cox.net>
>=20
> So exclusion by use_patch() for paths outside the current directory
> seems to be a feature; the log message does not say "why", but if I
> have to guess, the reasoning was probably "The old world order was
> that the command has to always be run from the top level.  A user
> who wants to run it from a subdirectory must be doing so for a
> reason, e.g. 'I am currently working in this directory, do not touch
> outside this area'".  In any case, I suspect that the existing tooling
> people built over the past 10 years around "git apply" already depends
> on this behaviour, so we cannot lightly change it.

I was planning to add a --here option (maybe spelled
--current-directory) that would change that behavior, since I figured
that people would be relying on the current behavior.  The man page
clearly indicates that some people are using it as a better GNU patch,
so an option that does that might be useful.

Regardless, I'd say that --verbose should cause git apply to say
something.  I'm not a newbie with Git, and I spent about an hour trying
to figure this out.  I've also been bitten by it before elsewhere.

> Is it so hard to temporarily go up to the root, run "git apply", and
> come back?  You can use "--no-index --directory=3Dtrash" for both
> cases that way.

The existing code used patch until we realized that older versions of
GNU patch can't apply certain git diffs.  It's not super easy to change
it, but I suppose we could.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.11 (GNU/Linux)

iQIcBAEBCgAGBQJW2zaIAAoJEL9TXYEfUvaLuvIP+gMkFyVw2izmvaiD0JdQLJXV
32QZSnMY/kEveplNluK5t+hkTXIDqxv6YmxrlVudUX/ipo5q5LERps016Nbft4tl
LKrZh2lzEYtOCWULERrNUm5gpe3c3tIcR2T407CFEcglkdGH/wq3HP6pa/xH/nfr
rRwKRAsMPRYVPVoQvzWGV047jmryb+BETZFTxQsCibF+VNsht+JN+sI65sxOT9/x
Ly/fwx9eQGYqmO+QsZnqX5wUhQLZTdrkZYpIWDMwMdQrG3OPzQ/n9SDq9+EcIRSr
2cKtL4gqp/tCxkVpdraLlcdqjZncqq1rvxJc5Lfiji7Pd8ahB3iZzwKfxC0gjmxT
8D7vM7qEps72NiPbCbL8sMDVZGATSDTYLEPsd6hsqGEJS1VacBhol0azYVPkvbdR
C6ds+zhmjGcoHNUSE7GTG6OCxwLomoAl4Rc1HaBhVQfpE2JTnKikfx4xmQkgRMHb
xqPG19jtm6ZRwcjuSB8jF9xPXTBiUqcu/zMVPN2FuRXcBCbJ/crgZ4TQQR2UbUy1
IrJdwftnAFYWJrz/eRjmxfFCYB6ikmDLZf/jL3LcMd7xBHaRQ/FE78nEJXzuEovx
LaW2QE914QZLB4D6S8snCAUmxK8YM7ZD6WtMeHG0ho7vhgtxAhUGTV/fsF5Ruh5D
6oTuQcjAHATLUxm5if+7
=GLIv
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
