Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CAFC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30C2061492
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhEKXxJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 19:53:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52364 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhEKXxI (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 May 2021 19:53:08 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3A4786042E;
        Tue, 11 May 2021 23:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620777091;
        bh=q6JrMrhMOuMbXXNLkmNA57cmI2UwiH3zh105H0oPh6g=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zxRVxPjN5gi7ZAe3ydGoGILVFP8fb4aUMo9RSQ1eswsBGlrcFJ1prvr2vtvcasfHC
         UfbTZ15KJOqkW6nENcsaJaikuFtFtx4c7sYeJqkgxc7AelPmavbR5voo3zxKzW7pM6
         JozgrzB9MasllJNsL0MtoeUGH5pYJ4kt9M+LjgLc/jzQzbZDdnQJDseyb+655pSzKv
         mYt6lqx1rWbqh+98i+pz+joczMxbjhgtyoVoYIWjTw7lvRstwVhQ17P8BnaSjFpQwp
         BX1K+7B9k24I11dkxyE21h9KkkH4zJNrwzltMij9tpFVFuQwo7z39jrtf2pXUI4zRH
         UjNe+F6JAiboYh25d3nmiWKwLBs6AQq2vaUrN3zxmcbb6mIv3iU+AOsjtSivVbJb/q
         t744H25c+7clIb5rY5YqYta36IlnpDDizm08dLdf13nwDnM5fg7esS+ueVrVp2KagJ
         IUfHGc3/UyNj1Fc5oPxb51znu5TFclunJmDSkjWycMUwRvfql4X
Date:   Tue, 11 May 2021 23:51:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH] remote-curl: fix clone on sha256 repos
Message-ID: <YJsYfm36owkE92by@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
References: <20210511103730.GA15003@dcvr>
 <YJsM3sUXRYjJiwZG@camp.crustytoothpaste.net>
 <xmqq8s4kj0gs.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pYuwdo2n1usIEmTv"
Content-Disposition: inline
In-Reply-To: <xmqq8s4kj0gs.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pYuwdo2n1usIEmTv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-11 at 23:48:51, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > This seems fine as a solution for now.  I tried to keep the transport
> > code mostly independent of the local repository settings, but in this
> > case because the HTTP walker mucks around with the internals of the
> > local pack files, I don't think we can avoid this without some major
> > restructuring, which I'm not interested in sitting down and writing this
> > evening.
> >
> > I'll clean this up in a nicer way once I get interop working.  Thanks
> > for sending a patch for this.
>=20
> Thanks, both.
>=20
> As an "experimental" stuff, I do not think SHA256 "fix" is as urgent
> as (or of higher priority than) other stuff, like reducing
> inter-developer stepping-on-others-toes, so I'll refrain from
> picking Eric's patch up myself and let you include/handle it later.

No, please do pick up the patch.  The time frame for which I'm looking
at fixing this is several months out and I think some solution is best
adopted now.  Since Eric has sent a patch that works, I think it's best
to fix the immediate problem and let me clean up things later on.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--pYuwdo2n1usIEmTv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJsYfQAKCRB8DEliiIei
gZTOAQDdC+/RIROo+WI4AFO+UERDvr/7/Um5O0/hREsSljKq+AD/Z6sylsHAn/t5
yzzwV2YD7H1goezLoIg901cvp0xrwAI=
=UILo
-----END PGP SIGNATURE-----

--pYuwdo2n1usIEmTv--
