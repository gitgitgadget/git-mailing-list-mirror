Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59444EB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 16:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjF0QMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 12:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjF0QMb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 12:12:31 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD90A1727
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 09:12:29 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E844F5A210;
        Tue, 27 Jun 2023 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687882348;
        bh=RPexhfkbH8Po0uF3RL4iqKkCmi+V0RxR63UzfXV6dYg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=RZj9zqbtxuplB4/kUb2Z/rmSHNZLae/IwOsOLQojSl9/MXiu1nYxAWioTrpEtJHEp
         xHMZkLWlhaPDbWaJjhvWR1s2dM8VkxhEd2bQOmowLTO0alHNx58pjRjJ/LQt8xew5I
         L6trWAr9vSdfIgIfTdac6zOOZHPGhCEeUOYmsNaqx621vvaHr8hzB/YeF2CKxqzQ99
         jMaxpxQM3m5hXhBkTH6x5FKxPlbizZ9r+oKjvhsqmejxLcwlNkZKwCrg39Pg612X4Y
         gNLmLPr8c1loyxM4VcLWriEJAmaaL4kYtITo1sLBTCBgeICunJzxOydTw6zRmQ1GqF
         ZqE/7ePOHAAQjhYan77WoZZI3ZHjTz5+MJP4PQ+baqdBP35fOgsxgJz1Bx5SipEkGS
         XRpHPsJxMRhPesNKisdD3GFQbZfeMO0TpiI0AmyxhIKbNN7dIDjONPR1g2/oiUmrPh
         jaB48LSu21praUqd8U6mi9VSAbUwS7cC6qV15+wY+9iFwymowKP
Date:   Tue, 27 Jun 2023 16:12:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 6/7] var: add attributes files locations
Message-ID: <ZJsKa6ZNq7nnh0gf@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230626190008.644769-1-sandals@crustytoothpaste.net>
 <20230626190008.644769-7-sandals@crustytoothpaste.net>
 <20230627070557.GB1226768@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7s6liEh4D+FsW0yV"
Content-Disposition: inline
In-Reply-To: <20230627070557.GB1226768@coredump.intra.peff.net>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7s6liEh4D+FsW0yV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-06-27 at 07:05:57, Jeff King wrote:
> On Mon, Jun 26, 2023 at 07:00:07PM +0000, brian m. carlson wrote:
>=20
> > @@ -51,6 +52,26 @@ static char *shell_path(int flag)
> >  	return xstrdup(SHELL_PATH);
> >  }
> > =20
> > +static char *git_attr_val_system(int flag)
> > +{
> > +	if (git_attr_system_is_enabled()) {
> > +		char *file =3D xstrdup(git_attr_system_file());
> > +		normalize_path_copy(file, file);
> > +		return file;
> > +	}
> > +	return NULL;
> > +}
>=20
> These new ones would ideally mark the "flag" variable with the UNUSED
> attribute (in preparation for building with -Wunused-parameter).
>=20
> I can also come through later and fix them up in a separate patch. It's
> slightly awkward, just because I was about to post a patch that fixed
> the existing functions in that file, and I'd have to either rebase on
> top, or make a second pass once this is merged.
>=20
> That said, I also renamed the "flag" variable in my patch because it's
> super confusing (see my patch below for reference). So adjusting your
> new callers to match (without my changes) would be a little weird. The
> least-weird thing would be sticking my patch at the front of your
> series, but I don't want to make you do extra work.
>=20
> So I dunno. I'm mostly giving a heads-up, and seeing if you (or other
> reviewers in the thread) have an idea to make this "flag" thing less
> awful. I'm also happy to just do my topic separately, and then
> eventually circle back after yours is merged.

I've picked up your patch as the first patch in the series and will send
it out in v3 in just a few minutes.  Since I plan to have v3 be the last
round of this series, I'll let you send out any further changes as
fixups on top of that.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--7s6liEh4D+FsW0yV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZJsKawAKCRB8DEliiIei
gZ63AQDH9EO8+Lg3Y6nTa0jke4+EN492FrUKpEbaTjiYsmAZvAD+KPlkH5npQkmu
oML1/ki2N3hsSlxAD3uS6ezzgayQ0gQ=
=aTnG
-----END PGP SIGNATURE-----

--7s6liEh4D+FsW0yV--
