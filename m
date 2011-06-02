From: Tim Guirgies <lt.infiltrator@gmail.com>
Subject: Re: Can't get git rebase --onto to work
Date: Thu, 2 Jun 2011 20:38:35 +1000
Message-ID: <20110602103833.GA4709@Imperial-SSD-Overlord>
References: <BANLkTikF7p_XsU6YJ81bq10S3nL6tBsApg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Thu Jun 02 12:38:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS5Ie-0004TG-JZ
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 12:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933457Ab1FBKin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 06:38:43 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52578 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933354Ab1FBKim (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 06:38:42 -0400
Received: by pwi15 with SMTP id 15so442406pwi.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 03:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=awub9svdkBehwiBoFK3SSLjsY6/L4BJjq312uhm1smE=;
        b=fGqcnwX9AdP626e9JOu/u4NGGRPmYk27oYQ8r9BidK0cDgRad1sCGHo58PfHYbyyV1
         S6/kQaNAuSgU0JwJmKxyn9HxTTntDPX71Mo6dqE9cwR3de8PJ3g1HKwLX9u8serU54ie
         6VC9Cjum6KBKpYB61FGC/P/7Yjxzi/bkeE3W8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Yv2bJtXvPH4TXxOiSzDNFOQWcO8BVj/34VNEveFusW/xSIpVaYtOTthaHqe5IIxhyP
         qleR8lbUB+Yur9iy2D5596YqxpDyUzDTmoksSxjf5579IORft687VMeOwQCDEVwVQd0t
         dFqpQXUsrqXmXZO8/KbQCfLZDGAYL187OZpJk=
Received: by 10.68.59.169 with SMTP id a9mr234335pbr.60.1307011122152;
        Thu, 02 Jun 2011 03:38:42 -0700 (PDT)
Received: from overlord.imperial.fleet (27-32-25-138.static.tpgi.com.au [27.32.25.138])
        by mx.google.com with ESMTPS id b8sm483210pbj.30.2011.06.02.03.38.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Jun 2011 03:38:41 -0700 (PDT)
Received: from tim by overlord.imperial.fleet with local (Exim 4.76)
	(envelope-from <tim@imperial-ssd-overlord>)
	id 1QS5IR-0002Ll-FA; Thu, 02 Jun 2011 20:38:35 +1000
Content-Disposition: inline
In-Reply-To: <BANLkTikF7p_XsU6YJ81bq10S3nL6tBsApg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174937>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 02, 2011 at 11:17:41AM +0100, Howard Miller wrote:
> Trying to explain this as concisely as possible.
>=20
> I started with the following branches (names changed to protect the guilt=
y)...
>=20
> * clientA
> * clientB
>=20
> both have a common ancestry....
>=20
> I then checked out clientB created a new branch clientB_patch and did
> a load of work and commits.
>=20
> However, I actually wanted all those commits to apply to clientA
> branch instead so....
>=20
> git checkout clientA
> git checkout -b clientA_patch     (to ensure I didn't wreck original bran=
ch)
> git rebase --onto clientA_patch clientB clientB_patch
>=20
> It says "rewinding" head and then applies the commits I would have expect=
ed.
>=20
> However, I have now been switched to the 'clientB_patch' branch and it
> says that it differs from its tracked remote branch by hundreds of
> commits.
>=20
> clientA_patch is unchanged. It seems to have mangled clientB_patch and
> done nothing to clientA_patch. Where did I go wrong?

"--onto clientA_patch"

Please read that out loud.  It's meaning in git is the same as in
English.  What you did was rebase clientB_patch _onto_ clientA_patch.
For more information, see "git help rebase".

What you should have done instead:

git checkout -b clientA_patch clientB_patch
git rebase -i clientA

What that does is create and then checkout a branch called clientA_patch
at the same commit as clientB_patch, then rebase your currently checked
out branch (clientA_patch) on top of clientA; the "-i" option allows you
double check what's being rebased, as otherwise it would take a whole
lot clientB history with it.  Simply delete the lines with the commits
you don't want.


To fix what you currently have, though, you must do the following.  Take
heed, however, as I making assumptions that the situation is unchanged
=66rom what you described above.

git checkout clientB_patch
git reset --hard origin/clientB_patch

I'm assuming your remote is called origin, and also that whatever you
pushed last is the latest.  If not, you'll have to look at "git reflog"
to see which commit to reset the branch to.

Now do:

git checkout clientA_patch
git reset --hard clientB_patch
git rebase -i clientA

That should give you what you want.

Good luck.


Tim

--=20
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org   - against proprietary attachments

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJN52gpAAoJEGNoa2q+dzQWoosP/3vJkVOwdh1uwPvqc63G++fa
uGkej1awEJV6F8DFLd+d4DT8RZPCIlokA0BEHyibGnjuM7+gBobjQDbteSy/5d3y
wNCip5esdXX7u0kXKu2I2LscSkRDJimf3w8kqiVAEW9i7V7HOui/CF8v3ZTAiOGN
HWohy8h4VkcmTAL0KET095JmwqK6myjZ+LlS3ND9q3dpyNk2mWSJpbtQBMrCXJRI
EssYsmSo2P2OkdKl/83N37qrVKRPjm9imebjylWnzBT0USIDVGOhtK9+OvuS2BB1
LsoWsgWCr1XQDUpf1eqdeVTjZCEtuF3p30EoJPJhh5+90WggAjuMLqUAXiirCtqw
NV7tJbPr8ColBl5eW8lO0q0VJrG+KHyh5yDjuwkSzwYFoHnGP/JuGtHDotplmHSU
F8Pi284g1TczNcy9H30aYpwHir9SoafFDXpjMEGHshRYH2TPgO+izoDrhTaWXNk5
BmYS9RPV1vZpwfcTeAqbxiRUUofGgjpmP/PgaTXfQzLNxaXzgw+eQ7qF569Z16Sl
Y+MaHvK4KVWxVKYEts7tMUtIfpzbucP9xk846htMLFhEfRMjKvVp/77GGwN7BK+C
eY2BXzH1c9mTl1D2ALRpSzl9TAGDW4L5BtnhN5ZOxfWjyw9ydcJQHJkmEqes2HIq
LqPCg5pAmvE0NNkvfWPn
=YWDr
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
