Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7DE0207D6
	for <e@80x24.org>; Fri, 28 Apr 2017 00:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967219AbdD1ASG (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 20:18:06 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:38826 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754271AbdD1ASD (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Apr 2017 20:18:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 87658280AD;
        Fri, 28 Apr 2017 00:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493338681;
        bh=BSEkSnbdMhDCa2oNQScHBZ5lyGlnG9RQbWe/3umGdA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wM9f5snXqqtAghpTGaMiHQabn6+MZMXvq69BnSAMN7cBduZ8AnXqxyoxx0FTSZnfV
         u2Xt37dXGhPiaMR3WW1b7x5xVJT66sa0kYqVxTfIrQRtnJcADvjkxNvVQYC0dth59G
         my3pXz7gQsbeNXkykthl5gzcdIcRyBGwKn2UIagO6T1bbWXF27BkfhdoFXCGiXvrse
         +e4Px3qvGo/MHv5Bqjf7dLFeS6XZkHeG/Bmo0nJOXvzMKbnhHzRBwLEy3AcnRra9Up
         vvqbH6dRdhfBeJKXvPDtIn7dzuQmm37yOlyqM9wTtcypXDLrDF4IlckcRQNBfkStjV
         umuU89rMTM2WrkbGYhHgaV+sGYXzNdKhC7jHNW9NNIo6+BjnJyoL51CJujc52mEwR4
         U8pAlD3QTxiNYFN9symXFAWcc6k7eSwAnfnHfCGsGGRqb8qNCWe6NDTUb8mnlb56K6
         /DIAuJbYhaEMn6wQ2colS6BPz2+euViueAg6XtFtWsV24CQubq6
Date:   Fri, 28 Apr 2017 00:17:54 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 35/53] Convert the verify_pack callback to struct
 object_id
Message-ID: <20170428001754.7h7gblafh2faz4vf@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
 <20170423213453.253425-36-sandals@crustytoothpaste.net>
 <20170427055209.ock533opgzans6ew@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ueihqg3szvx7ini"
Content-Disposition: inline
In-Reply-To: <20170427055209.ock533opgzans6ew@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4ueihqg3szvx7ini
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 01:52:09AM -0400, Jeff King wrote:
> On Sun, Apr 23, 2017 at 09:34:35PM +0000, brian m. carlson wrote:
> > Use a
> > struct object_id to hold the pack checksum, even though it is not
> > strictly an object ID.  Doing so ensures resilience against future hash
> > size changes, and allows us to remove hard-coded assumptions about how
> > big the buffer needs to be.
>=20
> But this part seems questionable to me. Sure, we may change the pack
> checksum in the future. But there is a reasonable chance that it won't
> follow the same rules for selecting a hash as object_id. And even if it
> does, calling it object_id just seems misleading.
>=20
> What's the gain in converting it here? I know we want to get rid of the
> bare "20", but we could switch it out for GIT_SHA1_RAWSZ. I suspect you
> prefer in the long run to get rid of even those GIT_SHA1_RAWSZ defines,
> though.  Could we define a new struct csumfile_hash, csumfile_cmp, etc
> (and arguably change the name of "struct sha1file" and friends).  They'd
> be boring wrappers around sha1 now, but I think the endgame will involve
> us being able to read multiple versions of packs, with distinct
> checksum algorithms.

When I wrote this originally, the GIT_MAX_*SZ patch was in
object-id-part9 and hadn't been merged yet.  And I think your concerns
about this being kinda gross are legitimate.  I'll admit I had some
hesitance about it at first.

So I'll reroll this leaving it as an unsigned char with GIT_MAX_RAWSZ.
I feel confident that we're not going to pick a third, different
algorithm for the pack checksum, so that will get us to the point that
we have a big enough buffer, and we can incrementally improve on it
later by using a different struct if we like.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--4ueihqg3szvx7ini
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlkCijIACgkQv1NdgR9S
9ot+aA/+L4WaZ82AAmJEaCmJZ8a4cLR2VUSu5IVQrBp2ew4MqrlAthNzJ09sLNQU
r5sfH7SZbAXj1A9Z2VmZVJdtmEc71l1shFj9DiS6wQOJ6IXYkWfWCTuN27FAs8Xh
RqUzZantTilBgmsSwsTyNLGfZl86UMVaTo+WxQdJ3BNGnAntdpi6P/p2VHZXN1NY
TRZm1EWyKjx7B49I608DKcoocECKjmJd7oeVL/RqJVL0wynIKINsovcBLSuXGLYy
Etb9zMSKgmkHz1bOFj1prrd9NS89Wevwygnu3tyzU253W/vNRZD8Vj1SW7xV6BuH
SdXqCOTMEOFdmdfM+8TMSgYR7lZZAfAChADjumb396882/d7wycbcO/s6aaFh+1G
k6AwghpN40OwOUrjtkrpOVAF1z9aQaqTMWRzFOncApH//2DXTv98HUtIboxnMkqP
iNlZ8rOBt4E2pH0wXlM1woSzQdK6WBPSdn0YHiJ/ZytaCLhr9LgEsqwTDndomq+i
W1JN/zqg78LnIdsmxEK5T4XtSUdDrsAi4ZjdBn1F1lwykc837yY49fislU6hH9Xj
NYrcFT445MjWWTMjFr0XBnZMH30+MaNOU1+RMSy9vs1zQt6ppc5kMPXLGbUGjMie
SzEAeg8MHa5IXIa3LAAYpDt/fxhsJYrrGRyDpVsWscBIaBab2z4=
=vafg
-----END PGP SIGNATURE-----

--4ueihqg3szvx7ini--
