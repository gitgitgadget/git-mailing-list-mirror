Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A61C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 23:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243223AbiCGXZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 18:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343915AbiCGXZp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 18:25:45 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC55656D
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 15:24:49 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B079C5A093;
        Mon,  7 Mar 2022 23:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1646695488;
        bh=o04JF0LhVdGwnsGjBm+iv50nRM+HInd/1SZO85KZwZM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=i8rxIdg55Pg2XLoZsQsDN6KZP2i07YtPxydcgz5DC7aGFMNYqfuGajl77hgIscuax
         g82xh9579pq+dg8KjOf6OqcM2SL3o33cTeEj3Gp4/dzbFQ1w42s/8NrNAzuv6FxF9O
         PXvf0hftqY+y99JWzDprI9XXjFP2gkm78VoH8KMMhfOurVMGk3YVenh2Q5meEfA4Wi
         frw+VYJF1U16rRUll00P3sF52Gpcn5NBZ6ccwnPIQCz12PHyFwfN22tqcJLi6xe2PJ
         bDxPaAGPEefOqnqT2HnjqQRY7L2KU6XhKuZV5CoviLwO9VrOAF2Ak7GAQG84x1Pcmh
         mQP5DHxcYWpqrRP5WIYV85dfdGI3ZZY93amY3d3a8266ARs4FrPWQYQsioR3QJDSo0
         W9MpXqnURHQqsnA7bICO1qnEzwIVXQXLTMqrxlQRbnLs57CL3jXQvxTlJC29Buw2Kp
         9BSb1anGB82u0bwop2Ip4BEzhbwBzjfsJB30KHT4C5DDA6eW+P7
Date:   Mon, 7 Mar 2022 23:24:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jason Yundt <jason@jasonyundt.email>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] gitweb: remove invalid http-equiv="content-type"
Message-ID: <YiaUP3b3PJWZx+AY@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jason Yundt <jason@jasonyundt.email>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
References: <20220307033723.175553-1-jason@jasonyundt.email>
 <20220307033723.175553-3-jason@jasonyundt.email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RCYtp+tn0nVNH06k"
Content-Disposition: inline
In-Reply-To: <20220307033723.175553-3-jason@jasonyundt.email>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RCYtp+tn0nVNH06k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-07 at 03:37:23, Jason Yundt wrote:
> Before this change, gitweb would generate pages which included:
>=20
> 	<meta http-equiv=3D"content-type" content=3D"application/xhtml+xml; char=
set=3Dutf-8"/>
>=20
> A meta element with http-equiv=3D"content-type" is said to be in the
> "Encoding declaration state". According to the HTML Standard,
>=20
> 	The Encoding declaration state may be used in HTML documents,
> 	but elements with an http-equiv attribute in that state must not
> 	be used in XML documents.
>=20
> 	Source: <https://html.spec.whatwg.org/multipage/semantics.html#attr-meta=
-http-equiv-content-type>
>=20
> This change removes that meta element since gitweb always generates XML
> documents.

This change seems fine.  We do specify this in the HTTP header,
including the character set, which is what matters, so this should work
in every browser, and the http-equiv is unneeded.

I also don't think we need a meta header here, since we have an XML
declaration, and that's controlling in this situation.  This isn't
regular HTML and we don't declare it as such, so using a meta header to
control this isn't correct: the XML declaration should be used instead
in the event a user downloads this to a local disk and processes it
outside the context of an HTTP request.

Since we control the HTTP headers, I'd actually argue that your test
might well reject all http-equiv headers since they could be done much
better with actual HTTP headers (and would therefore work with
non-browser clients), but I don't think that's worth a reroll, nor do I
think a test is even needed here (but bonus points for adding one).

So I think this looks good as is.  Thanks for the patch.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--RCYtp+tn0nVNH06k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYiaUPgAKCRB8DEliiIei
gRUSAP0ZJ7MYrYAfT29qLIu3IiWfMwnDosWXgX87U5MhytTjzwEA4WKSoCxJZhLl
dgWV4LvyiPU49Igte7xz0GbJqBDu3Aw=
=kst0
-----END PGP SIGNATURE-----

--RCYtp+tn0nVNH06k--
