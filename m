Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E80C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8FC6128E
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241767AbhDLNNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:13:19 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:55311 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241705AbhDLNNR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 09:13:17 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 07641CBA;
        Mon, 12 Apr 2021 09:12:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 12 Apr 2021 09:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=dvqBIMrek8eia4hjbyPWCQqbD5Z
        uq19Z6cWCYkwQCIg=; b=BuLgdvRyL2ugKRUw/Qa/1uL7DCHU6ZKzJ7t2jaf+ipG
        6rHEV/+aGFm64fAyw64TkUkoxoxSXMi6vIcYrDpcRo3ZFw0djnSSXsFcBDxWkprJ
        D7rjc+b2SOSkssD0yIXwG8UjeOggsmlsMJrAcThfBUI/DsMHp7RX2uidPrBOkuNm
        sxMceLZ8PCAZMPN3JLwUFYi9vTVrNU7WwJ0YRDoQEUyCor++FEG0K7rUYummrWTS
        uBGHKFLsmu3YA1SzOtSFRkJZdCAQJKW2AZuU5KrBMGiB+w3+Udwyh1HF9xj6FwsS
        vmwucytv0EGgX4XhK8XU4QHlrjGeNAz+sJpipH3nG3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dvqBIM
        rek8eia4hjbyPWCQqbD5Zuq19Z6cWCYkwQCIg=; b=PEX1sdCLEwksLBnJc3hfU0
        WaWdbkw/JUzVgYVLj2zY8xT1EuDxnQu5L8usURsUHFrpQtZZebQzJIoaxQZk2ENE
        SuIgVthGfBGJyAL2kTwNkquEXHfoxiE1FihwQy5p0oR9HuZRlAi3+wtNOGuphf0y
        S5ZOKomB4HIpBIhbjww24h6MIIRuRlUu2xhOcEeDfNlvvT3xaKXLsFychHkRHSVC
        5vqafbEv5yddta69sRk33u2NxEeVUN9kUrtbMC7E6oF5smE6fwy+hkMCnv5OUIw8
        ogFvGcB/uKMksBk1jofLJcT+/1uzCzc07JnFCxNg7U8tmXglAeElP8YujIcImMUw
        ==
X-ME-Sender: <xms:Wkd0YD4wbc43vKvjshPoxOdpjyN_z_Dg9FKStuXNyEEmLolXW-QXEA>
    <xme:Wkd0YI5a84IfIRMhm3RJ2D8qPwGJiHVlcsMrXkgZQNuqV2pZFeByis7UakHCoGjxC
    vaWJvPAXT2DN_UOEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekjedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedrfeehrdeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Wkd0YKd6QfvoinJY2wG8fuDYFfkCjFSH6KOO6vjRE-MgU0TRoGD4Yg>
    <xmx:Wkd0YEKv6vckzwVMfe796VoVrYvsVKKJirUDZauYJCVqsc6fKUkCLA>
    <xmx:Wkd0YHKvfXHYvzv02izhBrEaQztcA4NsmQeouvI_WCJbvAVgkNftpQ>
    <xmx:Wkd0YOV4cJeJBzXyxvfjv0Tv0sfkdUywfni0847j_LsF-qVdoL1eOA>
Received: from vm-mail.pks.im (dynamic-078-055-035-030.78.55.pool.telefonica.de [78.55.35.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 55B9B108005C;
        Mon, 12 Apr 2021 09:12:57 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a24fc9a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Apr 2021 13:12:45 +0000 (UTC)
Date:   Mon, 12 Apr 2021 15:12:44 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/8] rev-parse: implement object type filter
Message-ID: <YHRHTCHnV9dypO9s@ncase>
References: <cover.1615813673.git.ps@pks.im>
 <cover.1617967252.git.ps@pks.im>
 <xmqqpmz1icj4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9lyQj1TNAOBA0cLH"
Content-Disposition: inline
In-Reply-To: <xmqqpmz1icj4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9lyQj1TNAOBA0cLH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 10, 2021 at 11:02:55PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Subject: Re: [PATCH v3 0/8] rev-parse: implement object type filter
> >
> > this is the third version of my patch series which implements a new
> > `object:type` filter for git-rev-parse(1) and git-upload-pack(1) and
> > extends support for bitmap indices to work with combined filters.
>=20
> Do you truly mean rev-parse, or is it just a typo for rev-list?

It's a typo both in the series' title and here in the text.

Patrick

--9lyQj1TNAOBA0cLH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB0R0sACgkQVbJhu7ck
PpSGZA//SsjDJoE/sxm9d2maBh+CD0e0ZE1OlefTz1SrSwfiNAzswELg0a5wIaMi
+gkhQoBIGbaBQNbd8wxIKTnKm91Dd6oVbDARFjYJZ9ISOi20csX3XlIE3rm315w2
4xrnqalUjYl/A8QPNjxywojbumsQQET3GM+fmnDvce/cZ2PL/PjInkluI9hAMBbj
MfCD7pWjcgmDBSjuoCK1lvqln2QS6aVjxb4biljSF0KV36OO3Y6VQGzxJ8uXpRPG
BdBEJcCY441CvPntdKZYR55i1R9n/11pbeC92BeAYboEDGoZiisESgziD6EHaYvm
QbkBGwXo1s0b7qZ8gFMcMWkqSS/E68EZ5t94fvdeWJeTNWz0gNQ+1/pLK1L4zti7
dgHkys34vBlBfWeyeq54d/p4UNU3VM5nqzEOC+snxaUU7ZGIVg/8ksbaxUfJtHN6
1eQWyo6wpvnTWk0s3qu1F1eFgV+B5S2hbtBenGRztJ3q1/LknxVes7uAVUHx7VdM
KQFqWRRDBDvdjXyLvn9odyqGHg+UqJ91gJQ8H97BK7v2RmYnUgs125gmDlyIbhGe
dmLQu+QED/tsFLzJDx7WqqEildASO83g9C7nY14cgOHnUvjdPCuMLeF5l77Lnc7u
pJ2R3sDRTKVtuRz+JXEM0rm434GM17+t4OtEwPIg1ReBN+RYizo=
=qas6
-----END PGP SIGNATURE-----

--9lyQj1TNAOBA0cLH--
