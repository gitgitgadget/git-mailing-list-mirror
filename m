Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C961ECAAD8
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 00:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiIWAuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 20:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiIWAts (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 20:49:48 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A80115F76
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 17:49:13 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id BF16F5A1DF;
        Fri, 23 Sep 2022 00:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1663894149;
        bh=DMMNFWqzjfXUD6JSShs7R+xkm6ynpkOsXn6sarLuALE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EeH+UjofoPSrC9uChTfQsPQmm37O5nwuKM2Udr3fS0o+PSrZVQSObtniC0UZGxFJi
         38DgCAokhjXv04B+2FQHCrYQxNUOUCeudag6hWtDyKcuWoJfwPuE2mjqOunSIrY07b
         +DBp5CWdKOOqsjJkKop2M+YDk49IONVjkNxl+ZksuLEQtCQZUxwcJhWzDeqwtLpRMW
         uJVPq0cT8rDhTZEf4v6LPdOFtA5v3t8vjsmDazleHB6h5h+gT1a014ypQkzTZdXROM
         OHEFFPNebpb7O3rjA37yDPEBkYbTJrx9r8pqFkrUVoJphnoZpGbvgOgcp+H0M9OES9
         Bmc52CwpnMa82+Cgk6gFn9vRIwcm45lVgIHYcbdOTshvHgn7Z+saCDv166WR1+yZ8Z
         XbPGf9rlpqz/rHPO6HyIV4Gtkrf4R6AvZcky6IiFJXm5KqDVKEDjDm05KlmAZqu5QX
         bzYzmP4S9p5ZBZqCaxYebY6ldE1g/UaKZkB5uihk5BSeXe33k4i
Date:   Fri, 23 Sep 2022 00:49:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Scheffenegger, Richard" <Richard.Scheffenegger@netapp.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git --archive
Message-ID: <Yy0ChPPqZUwVFyAt@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Scheffenegger, Richard" <Richard.Scheffenegger@netapp.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <PH0PR06MB763962EB6321F85803C5CE2D864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
 <xmqqleqbxj4h.fsf@gitster.g>
 <PH0PR06MB7639720FB3A1611F4C96E52C864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9p2Cfk6FKP9O0CqQ"
Content-Disposition: inline
In-Reply-To: <PH0PR06MB7639720FB3A1611F4C96E52C864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9p2Cfk6FKP9O0CqQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-09-22 at 20:35:08, Scheffenegger, Richard wrote:
> Also, at least for ZIP (not so much for TAR), objects residing in
> different subdirectories can be stored in any order - and only need to
> be referenced properly in the central directory. Thus whenever a
> subthread has completed the reading of a (sufficiently small) object
> to be in (git program) memory, it should be sent immediately to the
> ZIP writer thread. The result would be that small and hot files (which
> can be read in quickly) end up at the beginning of the zip file, but
> the parallel threads can already, in parallel, read-in larger and
> colder object - the absolute wait time within the worker thread
> reading those objects may be slightly higher, but as many objects are
> read in in parallel, the absolute time to create the archive would be
> minimized.

Maybe they can technically be stored in any order, but people don't want
git archive to produce non-deterministic archives.  I'm one of the folks
responsible for the service at GitHub that serves archives (which uses
git archive under the hood) and people become very unhappy when the
archives are not bit-for-bit identical, even though neither Git nor
GitHub guarantee that.  That's because people want to use those archives
with cryptographic hashes like SHA-256, and if the file changes, the
hash breaks.  (We tell them to generate a tarball as part of the release
process and upload it as a release asset instead.)

What Git does implicitly guarantee is that the result is deterministic:
that is, given the same repository and the same version of Git, that the
archive is identical.  The encoding may change across versions, but not
within a version.  I feel like it would be very difficult to achieve the
speedups you want and still produce a deterministic archive.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--9p2Cfk6FKP9O0CqQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYy0ChAAKCRB8DEliiIei
gfZZAP4p3Bf9b9/DiI+ArkoShKmAQGR81P6dzbHsqors4SqL+QEAu6RP9Kq57R5a
qhhkwtaiILa6jzeDU3Y7NsqUqub0BQc=
=VnPN
-----END PGP SIGNATURE-----

--9p2Cfk6FKP9O0CqQ--
