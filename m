Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596D2C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 23:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15563206DA
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 23:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AUk8m1v0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgAMXLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 18:11:47 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38126 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728829AbgAMXLr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 18:11:47 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 78E7760787;
        Mon, 13 Jan 2020 23:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578957105;
        bh=RrAtCEpLVZOLyMapFCb8+2FxxlXg1A6Ge3mAO0e/QBI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=AUk8m1v0lm2tp7WuQCbMnn6V6IKyj3XpgptCTAwyS14RKkkDKZRFYgzKMWo9yi19Y
         MI+AMqjmtVDH056Ibe3vA+tArECUhoaGE0F8c0Y/vOgvUPzkTi2U3DPmue0oqEDQFN
         1Czub97+swX5CsCU30zexvtZIeBnuYTb+QTPKtYu3/uRJ/PBPG5tZ4GUBj7EzRutv7
         Zov04KEYrGwwdovtJ7UEEnB8/ArtC4ruP4Pdbh1Gfzw9DBXR5sD2FZGOfZFJ52bSqo
         yv/kYrA/L6ckI9IxelMzbqYgGwK8BCFvxYNynQFKnleyQoKB60cC+IWCpntaDeM4/2
         t8Co2KxuAhLVFyisetzsq5REuWluCo2V3SxKLoJVqlYi31bENvLVgt6kkQWIfe1h9u
         +oaG5sL3/PcRF94S1/R8OxeGCL8RmaiqjiYJz36wDn/EB9rfDkhs8laXDYDhgqZWUw
         cNUt+JzKwQOrbMQ5nFeqogsekCWclUedX+3gECH2sPIgnLOjYp8
Date:   Mon, 13 Jan 2020 23:11:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t5616: make robust to delta base change
Message-ID: <20200113231141.GR6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20200113123857.3684632-19-sandals@crustytoothpaste.net>
 <20200113202823.228062-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s9pXJW6w71JX4l3T"
Content-Disposition: inline
In-Reply-To: <20200113202823.228062-1-jonathantanmy@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--s9pXJW6w71JX4l3T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-13 at 20:28:23, Jonathan Tan wrote:
> Commit 6462d5eb9a ("fetch: remove fetch_if_missing=3D0", 2019-11-08)
> contains a test that relies on having to lazily fetch the delta base of
> a blob, but assumes that the tree being fetched (as part of the test) is
> sent as a non-delta object. This assumption may not hold in the future;
> for example, a change in the length of the object hash might result in
> the tree being sent as a delta instead.
>=20
> Make the test more robust by relying on having to lazily fetch the delta
> base of the tree instead, and by making no assumptions on whether the
> blobs are sent as delta or non-delta.
>=20
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Thanks, brian, for bringing this to my attention. I think that the
> change in the length of the object hash made the tree a delta and thus
> require a lazy-fetch of its delta base. Can you see if this patch
> eliminates the need for your t5616 patch?
>=20
> In any case, this change passes at master and I think should go in
> independent of brian's changes - if the delta base algorithm changes for
> whatever reason, this is still needed to make the test more robust.

Yup, this does indeed fix the problem.  Reverting my patch and applying
this one makes the test pass, so I'll drop my patch in the reroll.

Thanks for the quick fix.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--s9pXJW6w71JX4l3T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4c+S0ACgkQv1NdgR9S
9osKaRAAwhM3so7blR3LyEmFXg1r2Y1HIwJS4iBZfiC6YUO9lzA4d0WdKlXY0r7M
V7SxFAaAek/qAeR0NUFx0QtyXRpB5mMxNS/Cv7ANGhz+nQVB/vGnnr7NSgAM5IS0
a4gI4jZlvOCtnUOn5rx0LUKq4jVoo7/ux7PPgKCnWZl+dc/xjgj8ytdmMG4hFBzX
3AJ0VF08inga/I0V5xtj5bzCLyIcDCD2eK6ek7vkW12vJDPW8uX4o+6d9hOw54R7
0Nh8XnktZ3YL7VBrRxHcLn6UARJQtVXc6WPYOh2Ibj3dMnfokC9zp3+mmWw90dBa
iHL6f5iwjJB32zy+yG9aqc2SOzV2aiYcLbiodNnz5TgdJmeoBY8rHG1nVOTAmB/h
Hp/7aNzNv5m2TqixWZ+ejKReXzm8sE8HfdiMQoLHR0/91h2IeZorvdR9/YXE9RzV
eL98kFSM30o647hNZZ1m/3zJCSDIVewV/V8NULX20qUt2ir48eA8cg68HmRh5gn9
se1Pq/tPYrsnLx1ZSK04mSOZ/aOPcjEQ1DkO3nVrBGZEjc2HEUDj9admymE+32Yu
U8AJ/RK1W7igY45RVR5665lx7tbOMQ/W6yHa/vpvRJyPA1i2Kpvh9hv6ho09NtYJ
MYwAfZy94PJTNx0Rv+4ChiOKQBQsgsdhfda9F9LNKzyRSWlR5Vw=
=W6+n
-----END PGP SIGNATURE-----

--s9pXJW6w71JX4l3T--
