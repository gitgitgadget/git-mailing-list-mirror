Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4A7C433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 22:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D1422241
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 22:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgJHWLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 18:11:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46314 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbgJHWLj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Oct 2020 18:11:39 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 783AA60479;
        Thu,  8 Oct 2020 22:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1602195067;
        bh=Oik9C55xnjp186vqLmbZ246qyJmijofvdUpyxoTuyuc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=e/gkfHBTVZWPhkKuDftYEnZ7YCdrK8Kk3CPrZbkvhGRnIWT+vwolUtQf1zAboJvF4
         22NV5dMPfsGSOPnV8jhOmGaUzwyJvfffzlWWp/2JPOtUIUdCEzc4V4WQqc1JvY5vi2
         5JSoufh+eOFetyrH5K6znR8j/o4sH1KywUymU5/c0ZEdQ/0UuyqmbP005AYTZMalj+
         k4wRxe8zMTrJV2rkDcj/CmN4Wzuelu+hnx02/7ToxP+acqzAMr+ntFViRahSDljtyi
         rqHeBImztFcjoI6av2PBFwMI0XK6PqI17GXTN8nVbThEpX8NpGzB1ueFxv6/i5TckD
         s2qUSXJR4LRtT5b5RAv6vEjJAUOBzRk9j0YvQHeQaO4O/d7S4LObFDgLbnvEVyrUGj
         OBjRvVB+Ri5zzHt6h2htm3dmd+o+ab7XtGmb9Hrf0l4j52PXBbxJLxdaeW7poESFk8
         fukIJ9YiBrdcNSUQ2CtGU681OzlHghyBBbv44ViQsVw1bf+WnxP
Date:   Thu, 8 Oct 2020 22:11:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] contrib/git-resurrect.sh: use hash-agnostic OID
 pattern
Message-ID: <20201008221101.GO1392312@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <cover.1602139448.git.liu.denton@gmail.com>
 <6fad1fc7fdad98c3dda1ec334a10a6a9e311fef8.1602139448.git.liu.denton@gmail.com>
 <20201008161345.GD2823778@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V7BlxAaPrdhzdIM1"
Content-Disposition: inline
In-Reply-To: <20201008161345.GD2823778@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--V7BlxAaPrdhzdIM1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-10-08 at 16:13:45, Jeff King wrote:
> On Wed, Oct 07, 2020 at 11:44:40PM -0700, Denton Liu wrote:
>=20
> > diff --git a/contrib/git-resurrect.sh b/contrib/git-resurrect.sh
> > index 57a77c03f9..d843df3afd 100755
> > --- a/contrib/git-resurrect.sh
> > +++ b/contrib/git-resurrect.sh
> > @@ -37,19 +37,18 @@ search_reflog_merges () {
> >  	)
> >  }
> > =20
> > -_x40=3D"[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]"
> > -_x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
> > +oid_pattern=3D$(git hash-object --stdin </dev/null | sed -e 's/./[0-9a=
-f]/g')
>=20
> This looks correct, although...

We could write this more simply as this:

  oid_pattern=3D$(git hash-object /dev/null | sed -e 's/./[0-9a-f]/g')

I'm almost certain that works just fine, even on Windows, and I think
the hashing code may be able to optimize better if we avoid --stdin
(since it knows the size ahead of time).  The performance benefit, if
any, won't be that significant, though, since we're only hashing 7
bytes.

This is, of course, not worth a reroll in itself.

> >  search_merges () {
> >  	git rev-list --all --grep=3D"Merge branch '$1'" \
> >  		--pretty=3Dtformat:"%P %s" |
> > -	sed -ne "/^$_x40 \($_x40\) Merge .*/ {s//\1/p;$early_exit}"
> > +	sed -ne "/^$oid_pattern \($oid_pattern\) Merge .*/ {s//\1/p;$early_ex=
it}"
> >  }
> > =20
> >  search_merge_targets () {
> >  	git rev-list --all --grep=3D"Merge branch '[^']*' into $branch\$" \
> >  		--pretty=3Dtformat:"%H %s" --all |
> > -	sed -ne "/^\($_x40\) Merge .*/ {s//\1/p;$early_exit} "
> > +	sed -ne "/^\($oid_pattern\) Merge .*/ {s//\1/p;$early_exit} "
> >  }
>=20
> in both cases we are matching output we asked for, so we really matching
> [0-9a-f]\+ would be correct and sufficient. That's a little simpler. I
> don't feel too strongly either way, though.

The problem here is that we'd need to write [0-9a-f][0-9a-f]* because
this is a BRE and a backslashed + here is a GNU extension.

I'm fine with this patch (and patch 1) as it stands or with that change.
I don't think this can be ambiguous, although if we think it can be
(even with silly user behavior), then we should adopt this solution.

>   Side note: It's a shame that there is no way to convince rev-list not
>   to print the "commit ..." header, which is really what we're avoiding
>   here. We probably should have suppressed it with user-formats when
>   they were introduced, but it's too late to make that change. I wonder
>   if it would be worth adding a command-line option, though. I've often
>   had to hack around this when parsing rev-list output (and sometimes
>   even resort to using git-log if it's a one-off).

Yeah, I use git log for scripting more often than I'd like because
rev-list can't remove the header.  That would indeed be a welcome
feature.
--=20
brian m. carlson: Houston, Texas, US

--V7BlxAaPrdhzdIM1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX3+OdQAKCRB8DEliiIei
gYc9AP9EkVW37xMIblUgcnTVRTatwZKdP607JgUvGNx4rjW+DgEA+kpRUruXjWHQ
amFJqg4Zk1eKZnXZlstvWQQOSfD7mwU=
=pZqG
-----END PGP SIGNATURE-----

--V7BlxAaPrdhzdIM1--
