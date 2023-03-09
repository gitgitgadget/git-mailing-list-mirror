Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EDAC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 22:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjCIWn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 17:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjCIWni (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 17:43:38 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511AD38661
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 14:43:02 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 6A1E25A45F;
        Thu,  9 Mar 2023 22:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1678401717;
        bh=5epWJQkqmgpLFOK8uKoq+Gm+ciJvKE3IHqilt0sVk9s=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bX9+3RdlRdKu6SpeoIkbGs4mDMQbvhwais7g0FxqTfdzEaeDvXoHiizfU4dmfoQqz
         BCXrX5CT9f0Yx8bpy4Xk1Jz5dP6f/94CpQBARUJ0tZxKO/2P2KXwjX1IcwBRnHxwKu
         HXt4AzouHD3+j+aLq2PBEXVB2LghaiSh0A5CW/DGV9v0rIDWuNxgYCv+bh+OB6l0Zp
         bQ/ySbNW7yAGjUvK3G1mDBAQQ13bk7QBf+pAgQzl6jVXeJBBYuX5EgpTxujSYVa7MK
         198/KklXwrrNUiLFLEqydrr0kFZJbC5VHC0WRAjO62kH3tIVAB7M0c4+6Gf8dek5y7
         QemPklFdohCMNvIY+BwHc+gDlgp/Kq/MXoqEoN8mK/LnsRy/oqVu/I21m53mRI+QHP
         BhDB38+oneNbUANsIIwzN1k3w3KiDIXtzh96fWSUsXQrsHzz1jVdC0SmcOlvUQfRz+
         feSMS6wh7S34cQYlkikPNVU6nDKAWC3rePhbJNL2Y+eficto+XS
Date:   Thu, 9 Mar 2023 22:41:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emir SARI <emir_sari@icloud.com>, git@vger.kernel.org
Subject: Re: Feature Request - Better i18n support
Message-ID: <ZApgtJqVxkory4/B@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Emir SARI <emir_sari@icloud.com>, git@vger.kernel.org
References: <ZAnXddDN7v0AOBdm@mbp.local>
 <ZApdaAMrkmFcxarq@tapette.crustytoothpaste.net>
 <xmqq7cvp8sdu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UOel1KmqdQPXsA3K"
Content-Disposition: inline
In-Reply-To: <xmqq7cvp8sdu.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UOel1KmqdQPXsA3K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-03-09 at 22:35:57, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > More specifically, I think it could be fixed for progress output, but
> > there are a few places in diff output where it couldn't because it might
> > be parsed.  Would you be willing to try a patch for this?  I think the
> > code you're probably thinking about is in progress.c (search for "%%"),
> > but there might be other places you have in mind as well.
>=20
> Ah, my earlier grep missed this, as it tried only to catch [fdi]%%
> and the progress thing uses "%u%%" like so:
>=20
> 		if (percent !=3D progress->last_percent || progress_update) {
> 			progress->last_percent =3D percent;
>=20
> 			strbuf_reset(counters_sb);
> 			strbuf_addf(counters_sb,
> 				    "%3u%% (%"PRIuMAX"/%"PRIuMAX")%s", percent,
> 				    (uintmax_t)n, (uintmax_t)progress->total,
> 				    tp);
> 			show_update =3D 1;
> 		}
>=20
> With the PRIuMAX thing, it won't be as simple as enclosing the
> entire format string inside _(), though.

Sure, but we can split it into two invocations of strbuf_addf, one
localized, one not, no big deal.  This was the place that immediately
stood out to me as the place we see lots of percentages, but I'm glad
you mentioned a couple other places as well.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--UOel1KmqdQPXsA3K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZApgtAAKCRB8DEliiIei
gZrfAP975SQDTrWARq+U4co/HMdE2KJ09GgRb3tW581vI3eM0gD+PkokBtazoqcU
qxEYek+zbptECSonz2OKSCwG2vU2agU=
=7MFv
-----END PGP SIGNATURE-----

--UOel1KmqdQPXsA3K--
