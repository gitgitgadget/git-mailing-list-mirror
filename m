Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5C0C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B5A61350
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241897AbhDLNhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:37:42 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:51499 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239686AbhDLNhl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 09:37:41 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 0106316D9;
        Mon, 12 Apr 2021 09:37:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 12 Apr 2021 09:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=wJt1DRqH9VzoI6RnSk3LY07ur99
        w3JGZaC/dRpYS1sQ=; b=nVGrt1PWgbVvCaUvM4qGb1Z91K69hkZ9EWKJ80OtEnV
        0CAzdBPdyJYtrVr3NkkarE2YdN5JEnZCHEHhsfYxqjgJy+LXd6C1yGeKwjzmM6sO
        1ns4WAItv3wds+hzJxgiHDvrNvkqPfTZOverg8xzLtY8dFbBrhE53sbeKMEwASJB
        q4SpZgFUGvMvhgoEEmAVOxkMPW8BKM4HTiUPXd90KqVY6oadQeq+mbKgSRCT+OMh
        mofQmoioQJgx6QzM/zb8s0iAzfQG1XetEwrG/wRNRbPdSZZVKV+p+YofXyNvj+ne
        zA/MikNnyZgsUj8ZjnXxFlFUNnAuN34HpBU4aJ6WDVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wJt1DR
        qH9VzoI6RnSk3LY07ur99w3JGZaC/dRpYS1sQ=; b=Z7UYrlZpCOQSFvV8vP8xPx
        o3piZed3Qhz1uCNZRt9YWGScSfV8RGx9zqHqpFD/t6UAyOO/mysmf+VIM47yhMwg
        Fyn3iMGhifyJwCPi9Vn0fGKB4cpRjXTcHyZS2o/WxX62TQkZD6SDdcWRZSXCTg+f
        6QrzuQNZLPyB/G3ZMnvFlrdQ16ltMrA+CSikxat63jU/z8p7UnjtvVJtOD1etvEN
        n++dzK5FI0g/JQ0K9ak6UR5CJCXqG/wyqZ/mnjKj8Ufmy/9np7d85uuFePNnmrVk
        V0U8zVWW8wUiZ5nphKEjzGc5sJ69L1DUNOYrGbyxf7UdTHPWN6RHzJzZ4RIgJnDw
        ==
X-ME-Sender: <xms:Ek10YDgBUksqDccBhIEf38d-Xap0pI6nWrJUIUDf6IjyqIhVqk9kxQ>
    <xme:Ek10YP9VGNdMpAW5gYHv9AHtjd6QGDiDHNaZKEhuLI596CtPJ3C_E-NobkKnliR9g
    W7FL1bvnuoEjBtt8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekjedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedrfeehrdeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Ek10YP-s2HwKiYf2U_KYTW92mC9SlcaaN-ttYAtYcX7GyevxJ5Vd4Q>
    <xmx:Ek10YICvbTKflilHTeYVbZqMfMr9ZqemUP07ZVqypJRDEWVS7FfGWg>
    <xmx:Ek10YPzCX91nc-4ild5j1kO2HUz0zuIYkM_scWWQEns09iMt8AjHkA>
    <xmx:Ek10YHugWxP5xW4dIbeoqwEKNIk2vpXa2a4-Tm4qb80GcFMMGq01yg>
Received: from vm-mail.pks.im (dynamic-078-055-035-030.78.55.pool.telefonica.de [78.55.35.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id DFCBB24005A;
        Mon, 12 Apr 2021 09:37:21 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 59de14f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Apr 2021 13:37:21 +0000 (UTC)
Date:   Mon, 12 Apr 2021 15:37:20 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 1/8] uploadpack.txt: document implication of
 `uploadpackfilter.allow`
Message-ID: <f80b9570d49665b936e706063e42b9b00c2f7f45.1618234575.git.ps@pks.im>
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tvGpcmgVNYcBh9w5"
Content-Disposition: inline
In-Reply-To: <cover.1618234575.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tvGpcmgVNYcBh9w5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When `uploadpackfilter.allow` is set to `true`, it means that filters
are enabled by default except in the case where a filter is explicitly
disabled via `uploadpackilter.<filter>.allow`. This option will not only
enable the currently supported set of filters, but also any filters
which get added in the future. As such, an admin which wants to have
tight control over which filters are allowed and which aren't probably
shouldn't ever set `uploadpackfilter.allow=3Dtrue`.

Amend the documentation to make the ramifications more explicit so that
admins are aware of this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/uploadpack.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/upl=
oadpack.txt
index b0d761282c..6729a072ea 100644
--- a/Documentation/config/uploadpack.txt
+++ b/Documentation/config/uploadpack.txt
@@ -59,7 +59,8 @@ uploadpack.allowFilter::
=20
 uploadpackfilter.allow::
 	Provides a default value for unspecified object filters (see: the
-	below configuration variable).
+	below configuration variable). If set to `true`, this will also
+	enable all filters which get added in the future.
 	Defaults to `true`.
=20
 uploadpackfilter.<filter>.allow::
--=20
2.31.1


--tvGpcmgVNYcBh9w5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB0TQ8ACgkQVbJhu7ck
PpR7iw/+JSsXZqyrUTCFpr2VvjtEUq9mthnoD1s1RIWDAOlYPNFZgv/g3wMf4SK1
klumXuYAjK/jocdPqczTLgQZMlhMTxvxopoHSlIDsxOv0Tb/2OAN6bgmrB+qIDLW
ev46aT3dl09zbqs8jyUtoMsvMjsZZAmmvAAKag0oieJzYcDsDuUy3j/4ZqAY+11Q
nflhtIgS8lJE2n6/eg239Rc7B1DoqwzDOgIdBQuEjYy0ridVxUyqwIYWvxD18RJw
OynViIAFJ5FhLFuNqLk/vAs0Vyuqx76NHYi4ctZknmdhAAa0wUFOj/3eTngJsM4E
Y2UL1dlGh9ULN5NVtYMVxhchTv7/gTnOg60CB5pum+KW76NcwfZln4lw7mGeA1rj
YaMP2I4/4ZMA3zscZdN5+wy2qF1bCOij+dYTryb53GrOQhDK0WnAdZgzbxWt2nPy
MCmbMTsC9K5gYd80fn6r6X+6vrKnE2IlpR1KLaobpE0A5ZLCRG4KQ2oCtCo9zy3y
8NOfS9MBAfntxkAMvDVxQnmvoKrlbsOIeisVSnOrIjUvcPsK5Wqyim5IjT9SdeTC
AHNfCxDT4vVZ3Z6+/ArFor5NG9526DIJXexWVd2syYrAgSlsloEivHWA/j7hQmH7
r0SMKWuJcUkDjvYznUhnjoljh9HOymlM6EtI1PZvu59RaXjX05w=
=cMy9
-----END PGP SIGNATURE-----

--tvGpcmgVNYcBh9w5--
