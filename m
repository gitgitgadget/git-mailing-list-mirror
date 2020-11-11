Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C2FC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 07:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F133C206F1
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 07:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cJ9PhSrt";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aJ1lIlGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgKKHFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 02:05:22 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42111 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbgKKHFV (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Nov 2020 02:05:21 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E636A5C03F9;
        Wed, 11 Nov 2020 02:05:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 11 Nov 2020 02:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ZQW5xT7PH5RsR4oSUL5OiXg1PDC
        ec3RWrdOxmebE4vY=; b=cJ9PhSrtVgKunj56PKSbq6l7A9LYXfoAhLT8Ve/RKaK
        utgkLV9utw+cVBMechGKqQPpFIAY9lPyVyx2OJhDLK7LpoRXbwPqFeM0+5PSOSgi
        WpfDEul0jGg2VY88btkbmmpCP4w6jEY5JyWe7Yk8lP0JMzgb/7BrfNJb/Ytpmv36
        LY4urWi90GvKLV34IoEAWJsXKOzQ9Gv39Y+BEw9wnIfmrT9aW2aIpiYfdG51NNV6
        CSvOSZZIk9xQJyTurffzKQcXr74OGNs/Aqb6B3KRGQ112NBuCGwKxft2uaA6C/Ci
        mikZFksA+pBmVWWOcTICT30mMle7P+X3jNqtwlrwwUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ZQW5xT
        7PH5RsR4oSUL5OiXg1PDCec3RWrdOxmebE4vY=; b=aJ1lIlGqWWcac9oS0i7d/J
        EhCpe0AgNDgWKJHjaNII8UdfBD7b+7HiuLL8JA8tok+ulyRSd4x2t3W5v+XvUw4N
        Ywtq0lGjEPP327DRTNyXEKFsfInCoW/FtPmpsusyopj66x9t9+DIiGyNuyOstjTJ
        2M/FeeybeVAEo07wVMMoxEqgXXBPkXFDYWW4afKo1QvenIAVb7yHzeUaKt5unuY6
        M1f9Ki+40JMy85MlZW3jluIUz/Dr+T/+2dGHBhYj2oWyKCUppdlidWR9aUSMMCS3
        N4p4lpUnpfotlmaRtgmT8DewaCNC4xvTnDA1nIccfei8b6hqtyTcuUI/08R1RBSg
        ==
X-ME-Sender: <xms:L42rX6qI-uolVToSAYUGMg7H6yXaaEjZoZ9ll2VxsrmGccZ4mDcdPQ>
    <xme:L42rX4oII9Sj5OJ5gGernDJS0X6vjC41UaG3W4d0IBu99o0T5e8ggr_Eh8PyVZCzh
    1xlMlN5FOx40joweA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeekledrudegrdeivddrkeeknecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:L42rX_P2Lk_v1uyzKEtxeHRpjz8QAYQJZlOCHpbc2CfIODL7pnd1pg>
    <xmx:L42rX57jxI_J-a_5tGb3EbkjOgJRBt1KRVuTW1VEKUfbEyXd3Qg2XA>
    <xmx:L42rX56iQDHGTwmpu9HjTRPxncCyz4VRAyEdg_Rfyj1Qypn9t2ezLw>
    <xmx:L42rX2jf2ibhIBDCN6VSiWYHmGjnitKVfQXjwrRMI9OOgLYqRHPjsQ>
Received: from vm-mail.pks.im (dynamic-089-014-062-088.89.14.pool.telefonica.de [89.14.62.88])
        by mail.messagingengine.com (Postfix) with ESMTPA id E49063063080;
        Wed, 11 Nov 2020 02:05:18 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id fe96259c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 11 Nov 2020 06:58:34 +0000 (UTC)
Date:   Wed, 11 Nov 2020 07:58:34 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH v3 0/4] update-ref: allow creation of multiple transactions
Message-ID: <cover.1605077740.git.ps@pks.im>
References: <cover.1604501265.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fmK0VEKupyXYteP6"
Content-Disposition: inline
In-Reply-To: <cover.1604501265.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fmK0VEKupyXYteP6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of this patch series implementing support for
creation of multiple reference transactions in a single git-update-ref
process.

There's three changes compared to v2:

    - Commit subjects have been changed to start with a lowercase.

    - The commit message in patch 4 has been improved.

    - t1400 has been changed to not delete HEAD anymore.

Patrick

Patrick Steinhardt (4):
  t1400: avoid touching refs on filesystem
  update-ref: allow creation of multiple transactions
  p1400: use `git-update-ref --stdin` to test multiple transactions
  update-ref: disallow "start" for ongoing transactions

 Documentation/git-update-ref.txt |   3 +-
 builtin/update-ref.c             |  15 +++-
 t/perf/p1400-update-ref.sh       |  20 ++---
 t/t1400-update-ref.sh            | 133 +++++++++++++++++++++++--------
 4 files changed, 123 insertions(+), 48 deletions(-)

--=20
2.29.2


--fmK0VEKupyXYteP6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+ri5kACgkQVbJhu7ck
PpRT2RAAnHbQMtUWJBM/T/TiAZ+v5QUZGWaSE7MMbxo9sYyMpLnMyH0xsaVVxsMK
EMQy+jZHBExm05msFHEa48/ID0d/vgMa/ORaSYG4hOE6nASK6HtcOcIbR62p2B/D
068oFNPtQp35S5kzZg2erKhGuLD69bJ4cGZrKJmrptKN2jkcKco7KiekmQC29VSg
yOKU3hAEGIyHxmN9U8Y93Dw6Zdk7/1hEnYEoHgi5UxX9dWVeLPZXr7TzEXQFX48N
/hUoIeWql17OCKgd/9xk574IyDu+WA6yvSWWUenqyOcfyq7926kbrJx6n5F7EqJY
ayAR6J9/oFWEYRWi5rOFXulz3uPf5e9OEjSbNQ49uPVVO21ZefjT6TLG3S0LsIZh
Sfl1ZAsylM58kVxpF3dwyvieZfKiDfQprdXrjWRVB7AfH7XDCfkMngePqL4BWhg0
NFmMtDRiT6mEHTntLBUOAa6t/AEzqUJpgQOitB5i9ju5N8+uvqMCb1Z28DjxKkLn
Qd0Q4Q/pmbKmae3WcMvsuuL2ThnKRg4sAqx+fEOOnM+UxoobNDKm/SYEn5W5ktg7
korXH1PRNvbSaLbo2PYsnDhtT+baGZil3GWBcP5JH5oI68uDO0DkeoyN4pXo9BcY
g5S98ZKkQUzxz+QUTUIQIlnJVnUY0Dr0I6daK+DfkQTLZypBEaw=
=h2t1
-----END PGP SIGNATURE-----

--fmK0VEKupyXYteP6--
