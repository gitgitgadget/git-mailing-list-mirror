Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E5EC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbiCINnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiCINnM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:43:12 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E561C17B897
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:42:12 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 94C063200D25;
        Wed,  9 Mar 2022 08:42:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 09 Mar 2022 08:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=fYMXyqAbMJqoX+XBmSW4VtcUSJ6CmV7KPSJG7B
        b3QJA=; b=fXRsuP9yaBmhBaq9pX25PFFqeCEqNgkulHXEYzbRZFU96g/W6IXAFK
        I5527fkRhu3xE4hBKWHOCf8WehabifETYQgGffursG86Mcd7hNPPfXVhY+74m7oG
        G31VUAwzu3oKgaQOzFD80pV5QDs0iGlCLCwyqAaUetSGDb95DyQNY1Je446lGBoa
        es+/PpUGO75Oy/cYwMcjfaURKE8L6CQPJNl2bOqC63TFkmUau1HNty5DMpuNNORr
        +qFAk6cUPQ2NSG016eJjWXuup9mMfWi+ZnckndoekKjoo9BPWgZEZcxbA4k6Zq+5
        oMQC83ds3kNmzh7H/+Uxz9OZ+9wX0njQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=fYMXyqAbMJqoX+XBm
        SW4VtcUSJ6CmV7KPSJG7Bb3QJA=; b=LTwGPF/bhi1cz+mLpqjmueQfrwBB0GJ9q
        /pdT4dwP+8nl0Fyg23KaeZR7aKAz1XLC5hK35vF/jq7JjeYkSi1eymZdXWT9lw1C
        E7AvGSJBjbblIi3yyczpBUldBr7QE3qNlSv8XQosnXWolzGeWEDhwzv4+ETY8pIW
        DHHxQRcwM1/qn2QoQr0dH71LFh168BI4XBdQmd2kHj4u8wmml+vKpZmuYTcReLiz
        gDAckVnROrXqGv2urPrSbnRJWQ5AkjVw6pjVMRg1Su5gPs6YzisB0E2Fe+D8A0l1
        9ON9aka4k8tQqyGAj7w/aiuGkA83DQDOl6+wnuftmwJeSIEpMct6Q==
X-ME-Sender: <xms:sK4oYiB25bQRLDOC3goSRNUwlMwXIXIioQ1TI7OUlnK2LQtywwcnGw>
    <xme:sK4oYsgnShsle7vrpM2Ar7I57qVIjR8TbByBTSOfSDa2yoRzJ60Ap_y_56bHZFNwx
    du2epo8MhXtTQ0I_g>
X-ME-Received: <xmr:sK4oYln4EFITlms5TA3kMugSsqIqxhm8uqgzJu3ml3E1wwEE9U0tLaPCr322fBsDT5FTVne9Twn85K78f2thKR7GMz1CRw9TkDBQUaATwm9iDJlEO09_JfnX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddukedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeiieelgfekvdfhhffhfffgheejgeejudetleeifffftdeigeefkedvgeegheeifeen
    ucffohhmrghinhepphhusghlihgtqdhinhgsohigrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:sK4oYgwgSZUlN-Rz6FFicmjtB-VPv2kQFd4cz8zWZhIPzYCyntICIg>
    <xmx:sK4oYnQxQXL-iL3uzOeDtbi6BA39vYGuMsj6gj-RsStmfOeKkC-FzQ>
    <xmx:sK4oYrbiBui7o66Lsaf1mXb-0nXKtIEcIysqqcI2pFS1YNaVHxdlXw>
    <xmx:sa4oYgQ0LXt8DjYbEV13GXTZY1A6xzimtK5EdGmHzqvXAwVhTHmIPA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Mar 2022 08:42:07 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 89f0830e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 9 Mar 2022 13:42:02 +0000 (UTC)
Date:   Wed, 9 Mar 2022 14:42:00 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 2/4] core.fsync: introduce granular fsync control
Message-ID: <YiiuqK/tCnQOXrSV@ncase>
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
 <7a164ba95710b4231d07982fd27ec51022929b81.1643686425.git.gitgitgadget@gmail.com>
 <xmqqr18m8514.fsf@gitster.g>
 <xmqqy22u6o3d.fsf@gitster.g>
 <CANQDOdfVg4e=nLLAynm261_R5z+rjZV3QgE8nLwGEmj1wQm_uA@mail.gmail.com>
 <xmqqczjt9hbz.fsf@gitster.g>
 <CANQDOdcRM-GdxQ6iiV6pSBZifzpn+vJrBi0f88um9Rk4YJMFng@mail.gmail.com>
 <xmqq35kp806v.fsf@gitster.g>
 <Ygn/GvLEjbCxN3Cc@ncase>
 <xmqqh7914bbo.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WuNnOlzZkz2j7oOc"
Content-Disposition: inline
In-Reply-To: <xmqqh7914bbo.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WuNnOlzZkz2j7oOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 09:17:31AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > To summarize my take: while the degree of durability may be something
> > that's up for discussions, I think that the current defaults for
> > atomicity are bad for users because they can and do lead to repository
> > corruption.
>=20
> Good summary.
>=20
> If the user cares about fsynching loose object files in the right
> way, we shouldn't leave loose ref files not following the safe
> safety level, regardless of how this new core.fsync knobs would look
> like.
>=20
> I think we three are in agreement on that.

Is there anything I can specifically do to help out with this topic? We
have again hit data loss in production because we don't sync loose refs
to disk before renaming them into place, so I'd really love to sort out
this issue somehow so that I can revive my patch series which fixes the
known repository corruption [1].

Alternatively, can we maybe find a way forward with applying a version
of my patch series without first settling the bigger question of how we
want the overall design to look like? In my opinion repository
corruption is a severe bug that needs to be fixed, and it doesn't feel
sensible to block such a fix over a discussion that potentially will
take a long time to settle.

Patrick

[1]: http://public-inbox.org/git/cover.1636544377.git.ps@pks.im/

--WuNnOlzZkz2j7oOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIorqcACgkQVbJhu7ck
PpTvgQ/+PyNwRnMgjrWlaTABJF99cYrK9wr38gE/9bM5Ra1/h8UhQgds0UgZ/Vk3
H8HQLdKAr3IXsVk37FiM2gH62kOtVv8PHEyH/cMH3C3b58VytQvrOmFd34g5RZ+b
yp79QLrkJOOytdZWA8SUYED8GYqgsNzA5dsxG70KsEC6SfczUYtacjX01X1gk5vE
oQmCvtfYCZQTrF+WsxzCFZfJ064om+WoKBIV0/l8yU4FrIdnWTCWX6s6LadYJyZu
Pn7u+oMkjnWHaSEa/cxYvtZcIX3R5G2ppM2Cjb/IxKBqOz7fZPWIVL/bCjfWLlA/
UIKN87i1vYCF9UKlpjAm/j18fAJir9TWBlWzehg7oG5pGhF/uW4dINHIfYuYjlgz
8AuS6tuOI5b4on9MyQSla2AC0keIJYQe9YpcNY+PcNA2l+c7PxQ3dtdlXJ0SoVbs
LVj6XW1miu4BN3lZQFIbL7rDtLKr9mH+rWcsKPHdLeiAHTWkovS+imi6nsnmJxyA
hgNJnVTfNH9x5m5rgwtC2Qq8Ncq9qUNDcSlVYY8gkIY01ngNK8/4Jyjkg7TOs5/K
c7bx/ntrhCduut2a/8xPHHt2ftExglGzdfOI28CZLXSBlFrhN1NvF0GA0/2KR0Lc
PQM7eFzLCrsPwsFU/N9Kma/LX8XBymL3l2rbZPdOTAZg5HFn4wE=
=QKDH
-----END PGP SIGNATURE-----

--WuNnOlzZkz2j7oOc--
