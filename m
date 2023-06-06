Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3B9C77B73
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 04:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjFFEwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 00:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjFFEwT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 00:52:19 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCFB83
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 21:52:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 14DDC32002D8;
        Tue,  6 Jun 2023 00:52:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 06 Jun 2023 00:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686027134; x=1686113534; bh=gp
        rLau4OppZ5kYyLTnUhnFg50UQUjwBfIvudhC2jvXY=; b=fd6pjccKKXpo240nkt
        kOUyVzpT5HpclgveF+X7scaNIxDu3ldOb7LqVW0th309Vp9KbLWecBxTHIoZYdir
        myHKv0ijRdig8zRtt7d1cWm0lC5evcweRwiKnA2M8fA3I2tSPra8sBzpsjOxSwYR
        MX4p1iNaaDDWjUgFMDdQwLLeFHM9WsIJEMQTmy2ClQf2/Abqd8oeWzYwsa+ILnEa
        Cf/UToT5f/UVD+EiBDMIgoLO4M2VX6ZbA0H8yF2NVNEQvvSwFtMeJcwLAXaNeC6V
        /Xq0NLrmNj+izNv7s9Kx36LRbdI+V2KANC2eeuvj2BJQaBobdWakfg8Nsi3LcLBv
        dPZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686027134; x=1686113534; bh=gprLau4OppZ5k
        YyLTnUhnFg50UQUjwBfIvudhC2jvXY=; b=kJvUe8xFlaU19mv+cz2TpIaJ8Hbbf
        FZiihOBuIN2+WR+ctSvRHtiSlA17TMnoZUHj5O5L1PxCS03IYVoDjamKB6qnHp3j
        z2RvNQLorOx8ojzBoHgYuQtkUMA169msFWeGTKGltTpzsT+WJGNpPKuTGQsuWDAf
        jmDULo44EwQC4UiRTtTEYsHBeL5cSEUoRKFcME0i/pTYE2eCPl4SRIivS1tJp1kp
        7rhhQ/BzNkA0WUQFPs8RczNvNMfVJwDC7AJgjA6a3x1opopzsF1M6T9P5GkBye7N
        Crm8K4150kTmdmhsQ4b0GExeKqd1jEgvCq7el8EQuQ1HpQ1UKVMQqIHHg==
X-ME-Sender: <xms:frt-ZEeljM0AvPfnnTVwOIGtbkYpyKQSFt8HA1t_RFx7bgtxYfkQ6A>
    <xme:frt-ZGNFyhh_isY9CIaHpNoy8Xrlpy10nhAsMe2Z1s53C-Bkt8kp6NrhJIXtTphV4
    SHGi9VELHRRFUME7A>
X-ME-Received: <xmr:frt-ZFjVGhGsW89qhTD47-C2NtKophK2Fd-jht6GCKSXLgVvCzbf-ruZeddii06XuLW-eDDqXR6v-nTi7AYP5a2yqZvJ2Cq_p2Uw3aZ_qHY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:frt-ZJ9SHaYlvJZsq7p7oYdsYwv7xzWWT2TrxUm9V9VzcHHbkEA1Eg>
    <xmx:frt-ZAvMjluX6hamFfnPe79D0D4D1ML0PmjiYG1UcKtnDEYz9O2C_g>
    <xmx:frt-ZAFfKWwJmRQ8uIASsgPU9y_DaDgK8lnDXcIjsL6Tc60-N86jLw>
    <xmx:frt-ZMJDJOOZEtM-F8S8AMaPK8tTyEA-aA7o-e0a3kcF2vMVdgmPkw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 00:52:13 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 7948d130 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 6 Jun 2023 04:51:06 +0000 (UTC)
Date:   Tue, 6 Jun 2023 06:52:08 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH 5/5] cat-file: Introduce new option to delimit output
 with NUL characters
Message-ID: <ZH67eBAtFxo95aBL@ncase>
References: <cover.1685710884.git.ps@pks.im>
 <07a7c34615ec68fa42c725fd34d6144b6b191f03.1685710884.git.ps@pks.im>
 <9900512f-b0da-2e47-f1ab-ed51ec2c78ff@gmail.com>
 <xmqq35355utz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8nwHKXDSjX29v71M"
Content-Disposition: inline
In-Reply-To: <xmqq35355utz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8nwHKXDSjX29v71M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 08:54:16AM +0900, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>=20
> >> Instead, introduce a new option `-Z` that switches to NUL-delimited
> >> input and output. The old `-z` option is marked as deprecated with a
> >> hint that its output may become unparsable.
> >
> > The commit message explains the problem well, I agree adding a new
> > option is the cleanest solution.
> >
> >...
> >>   @@ -246,6 +246,12 @@ respectively print:
> >>   -z::
> >>   	Only meaningful with `--batch`, `--batch-check`, or
> >>   	`--batch-command`; input is NUL-delimited instead of
> >> +	newline-delimited. This option is deprecated in favor of
> >> +	`-Z` as the output can otherwise be ambiguous.
> >> +
> >> +-Z::
> >> +	Only meaningful with `--batch`, `--batch-check`, or
> >> +	`--batch-command`; input and output is NUL-delimited instead of
> >>   	newline-delimited.
> >
> > The documentation changes look good. I wonder if we should put the
> > documentation for "-Z" above "-z" so users see the preferred option
> > first.
>=20
> Hmph, I expected "-z" and "-Z" to be orthogonal, the former
> controlling how input records are delimited, the latter controlling
> how output records are delimited, as it usually is a good idea to
> keep things that could be orthogonal to be orthogonal to avoid
> unnecessarily robbing users flexibility.  "-Z is a new way that is
> preferred over -z" was something I did not expect, actually.
>=20
> I am not outright rejecting such a deliberately limiting design, but
> I'll have to think about it a bit.

Well, the way I see it we shouldn't have ever decoupled the input and
output format, and I consider it a bug that `-z` did as it makes it
unusable with arbitrary input. So I'd rather be helping the user of
these modes to do the right thing and NUL-delimit both input and output
than running into these edge cases later down the road.

That being said I'd be fine to change this series to mean "-Z changes
stdout" if you insist. In that case we should be pointing out in our
documentation that "You should never use `-z` without `-Z` when you
process arbitrary input".

Patrick

--8nwHKXDSjX29v71M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR+u3cACgkQVbJhu7ck
PpQXjA/9HTmOEiRdNFdyu7w00dcXyhiDgorIoARQjVRzCR6OA6lTWRtvfRRZNgE4
e/qalFvror5QstKWJAS9/zCzDSYcaAe9tVL4eKShan7d5TgYTQGxuH3akpXjNV88
M/Crh22nRBboB1Sv0k4xoFNj69AOntryE0tyzzKJ3k+cVOsa4dkVJzL4FGQEhG5W
fPYV2aLicEEALcbVkiUxTxXOhdQEHBUM1PwvLHLS9DL2oGZ1QRde2CZeRb6/D8FQ
jaD3E0teTnOuXF0BArUzLi1eJUnEh5kNXBSoTcFJcKoSHU4IzGJYTb4aX3PgMPXG
tyWMytEa8PcfLwP2J1BbS4GbJ8xpWPvv36mg4h69IXE/7WrWFY/+oRk6P40byy10
G4l/XyzzFK3ixCfk+JWmtpRihoXMeWKa324QVYhiUWwqj/M1aHp8fhPDG4HqvOfn
AMpzBIhYSU5IsAC6n9ONfoxBKZ7eutvODOWaQ+aSEu1MlrNIEyJFreuJQm/LTCvY
Qf+rQEjxSGbFUDaouJmVKwJS3RFY8VjTHO5W5aQJCocXIP5ElfxN3srUAgzypVXF
ZhVNWh5KVJ9pbhbumJDAr1lt+mLpBiYTjMGbj2KqhUa+4PIdXZlVsl5SYBnGh35z
XET80jv4HlVBDYuyhnxxkJIt0dyrh6q4V4kfHWctrgi1gjU0HfA=
=mwd2
-----END PGP SIGNATURE-----

--8nwHKXDSjX29v71M--
