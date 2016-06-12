From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Repacking a repository uses up all available disk space
Date: Sun, 12 Jun 2016 17:54:36 -0400
Message-ID: <20160612215436.GB4584@gmail.com>
References: <20160612212514.GA4584@gmail.com>
 <20160612213804.GA5428@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 12 23:54:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCDLD-0006h8-Pt
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 23:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932965AbcFLVym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2016 17:54:42 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36242 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbcFLVyl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 17:54:41 -0400
Received: by mail-io0-f179.google.com with SMTP id n127so106038351iof.3
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 14:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=79oB+1meBksHQUBmimp71xyBZIUec18reTG7ykx9818=;
        b=YrjKRWuzt9v9xNRWF4zk3PaDANBb2BFBgy+CbapfxDoH6c275Witrz63lzoKJYtPib
         iKR6nfOUUP9imIhhQ29p9J+8gGbtWEVsBrgpTNpuwonMdbOQurHFIEP1u6KALEluFrUM
         ea9Y8WvaY3LZTDYCWRl4Lq/L6/io9tI7X269M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=79oB+1meBksHQUBmimp71xyBZIUec18reTG7ykx9818=;
        b=fJU0NRgmfQ54NOAe0+ldAvHBKZmHjE+q7idgUr02Iqz1b10WRyEI1NddQ2fR8nsPHc
         xsYFUv6+o6I3+gyTVNgcVg+ssQWEcGQXX7qZ/pffmN/fc5fF6odqv9xh4OuVZkOUlTQ2
         E/C0RhaUxwAtMQQzTd8/whnt4B+QCx4funiO/D5D/FZ5BE9oCYHXkdMbG2V9CQrKc07F
         04grIWqRptmlsbHl90KA38ygMoeLXlQG7IVqj7Tzv5cyh0BpAVh3ktQcCgCi8qQ5BRIJ
         qrP8nTqnErAQPKqVGgyAtQRafJS1S2CJKu93/oKRMvKbTzR2euzeJqtMzqhuVFLj71SM
         B9uA==
X-Gm-Message-State: ALyK8tJp5MjgJd6yC590psom345Ra0HyAAF9adJnMsn29BC7N35c3jnBIapNyHQwtRA0hBJc
X-Received: by 10.107.135.90 with SMTP id j87mr17366283iod.158.1465768479997;
        Sun, 12 Jun 2016 14:54:39 -0700 (PDT)
Received: from gmail.com ([2001:470:1c:4d3::ada])
        by smtp.gmail.com with ESMTPSA id e126sm4916177ith.21.2016.06.12.14.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 14:54:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160612213804.GA5428@sigill.intra.peff.net>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297142>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 12, 2016 at 05:38:04PM -0400, Jeff King wrote:
> > - When attempting to repack, creates millions of files and eventually
> >   eats up all available disk space
>=20
> That means these objects fall into the unreachable category. Git will
> prune unreachable loose objects after a grace period based on the
> filesystem mtime of the objects; the default is 2 weeks.
>=20
> For unreachable packed objects, their mtime is jumbled in with the rest
> of the objects in the packfile.  So Git's strategy is to "eject" such
> objects from the packfiles into individual loose objects, and let them
> "age out" of the grace period individually.
>=20
> Generally this works just fine, but there are corner cases where you
> might have a very large number of such objects, and the loose storage is
> much more expensive than the packed (e.g., because each object is stored
> individually, not as a delta).
>=20
> It sounds like this is the case you're running into.
>=20
> The solution is to lower the grace period time, with something like:
>=20
>   git gc --prune=3D5.minutes.ago
>=20
> or even:
>=20
>   git gc --prune=3Dnow

You are correct, this solves the problem, however I'm curious. The usual
maintenance for these repositories is a regular run of:

- git fsck --full
- git repack -Adl -b --pack-kept-objects
- git pack-refs --all
- git prune

The reason it's split into repack + prune instead of just gc is because
we use alternates to save on disk space and try not to prune repos that
are used as alternates by other repos in order to avoid potential
corruption.

Am I not doing something that needs to be doing in order to avoid the
same problem?

Thanks for your help.

Regards,
--=20
Konstantin Ryabitsev
Linux Foundation Collab Projects
Montr=C3=A9al, Qu=C3=A9bec

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXXdoZAAoJEDS6uAr58ke40xgQAIqEx0uXoDgCfCWcQPWYOTlJ
PiCVWSLIR63ocOcBpNItPNPzVdbPDSb7s0pN5ntsjMRYB5F8bi10nKl8zDPLJ2Zb
atpNmuhewaY2ldx4h+dZcH8yjYCsDlNOC+dg4MtH2/poMuK/D9/i3I/hZdLX/6/g
xMJnrB+RnTlu383MQhhtugkuEYm/aomQK1uje9bMa0wyJCFupQjIorPg0jCMNe6H
EoOgUD6dQaqir6ikl2SK7DIUDzERXvVeWf0c+xOc0Mly3Fo1sB7q9MNUY0Scwlrf
T1oPlD/CxdX+eFDyTzSj9sExjdhdr+vGgfqfPKfV40eWA6S+Yffv58pGd+z9LUmR
EOpNn9kQqkn/CpAwksgzRt3mUn8wPlF0BzJfBxL6ljIYsKbFTcvxov1k0Jgr686W
mvJPglreULg88VzSSxtOscd4EVZSKCKM/UTY49Mz94GCzlR5vC+anCqoprShRHrz
bMOnT47+vyXSLxDIrW/2NPMprfPiXWKUwKFY//OgxbbMvZjzzu2hlu/qsE6KXHZz
UVBAfDwdzNjy3NRIzwhhyJ3RO+x3mEO0cTVDx1XYjb2J9as6zt7dsMRuvN+0uvs0
ykzz9zPSfGKI1JXrXDxgSEOUlmuSTzaQiycQ9C/u6AwfG55NjKSjhi6O/0Dlnhug
fZvOI7vg5eVJkMPRn+5e
=mOQb
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
