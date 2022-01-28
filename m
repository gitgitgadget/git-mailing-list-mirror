Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72935C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 10:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245062AbiA1KPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 05:15:45 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:34629 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231378AbiA1KPl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Jan 2022 05:15:41 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 2B23C320208F
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 05:15:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 28 Jan 2022 05:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; bh=l
        rwrMGukQRW2pz5lQstM+mVeMHx9wPArUjOGU3x845I=; b=BL6K9FkHl7Xk7yOax
        RWjSpWAvN0Zf9R53lHqb5iAK+snypSb/Kq3t87cjySNggJbLRAbtyxixElJv65VS
        eXv7NccMJvVeanfW88bRo3+9eSCKWHSK9+4qCDUsXMzavu4HMKp417n9wxj2pxEy
        RUl5PDJvhiRdzs3Kgfv3iqXBhzwm26JnUap5U+Wt7IOmObNtKS+2vOhK+oYMFx2R
        2m47bNV9toH6B8GWVNg1XZHaQwRn3MRucOOUS3xdRg2oJVVxqbeYJKri5bfY9cxU
        p8qtlPkcq7jYz3aNYSgJRT+pFdc2RVS3fS9IHlZPVpiZcorIFDChvM7zfddQwZR5
        RFuZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=lrwrMGukQRW2pz5lQstM+mVeMHx9wPArUjOGU3x84
        5I=; b=K3vH67cMmqy9mopM52M6wSdbW/jqwUTV/n2O5Pifh7DO9fDojL5NohXeS
        ZCLQM5qUqe/SGl2dHlC3MgQUdiGVBhpNsX3bBOXTgZu+HMzRCDXo7YYQUigq9Y67
        KNTU/nIj8nz6JJqlK6/f5vJKzGUmcbfIWRlB1hESM2C+pkKfMOPcbY0L/RfWqmkY
        om+vsi5bjvyABhddFNzMatJwwMrAeaAsn9DSOSsudMdPfuKw1XHBMTRofSNrrhtU
        17w3vLa7yh97zTzVQl3pSKP7MfINHOeOpV/UYB2PAqa+kv3I69uQbRkw1PbvR1UX
        kEjwKAo2lhFs5zgOI4/kIJuDaIWfw==
X-ME-Sender: <xms:SsLzYVKkv1E5K5q8sAVxA-UqpDzrG4Kaq7WI5JxnhZublWEntFuZpQ>
    <xme:SsLzYRK_yNsUz52BUJYdgD-GAcc-_MXYFOC56bhaKqiqepmTBa6ysOwyBT6MHWznD
    HpvMrpOEe6Y-uqLeA>
X-ME-Received: <xmr:SsLzYdveG6jEkeb5NbSx3SEkd9fi4AJcsyVwxWv-pJnpwvuk-BiEFmd8YprUOdx4weshPkhOBIgdjNTHFIskXJ6A-TKqQLclK6fObYhSygg3HyyepOJupdY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeehgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgfdvvd
    efudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:SsLzYWYR3j7zoIE9puHjvvznQCaNG2UVTIa7Lqb_hTH4FcCIpJev2w>
    <xmx:SsLzYcbQegK8b1J4SM9DpICFvBT6QIn0S7d3K1fUt9q0OwKAqV1usQ>
    <xmx:SsLzYaBkSxEm8BqeBgBX_XwSunQUSXPK0pCNt-ymfAl7NVJYYFb_UQ>
    <xmx:SsLzYS0C6z4PSGUa6busQZmcfVTbHDzCqqfwy_XZzdANKxpM815dNA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 28 Jan 2022 05:15:38 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 82179c68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 28 Jan 2022 10:15:35 +0000 (UTC)
Date:   Fri, 28 Jan 2022 11:15:34 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] fetch: speed up mirror-fetches with many refs
Message-ID: <cover.1643364888.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uSX+oYmJxgpYlCiR"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uSX+oYmJxgpYlCiR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series aims to speed up mirror-fetches in repositories with
huge amounts of refs. It contains two patches which together speed up
git-fetch(1) in a repository with about 2,1 million references by
roughly 30%.

Patrick

Patrick Steinhardt (2):
  fetch-pack: use commit-graph when computing cutoff
  fetch: skip computing output width when not printing anything

 builtin/fetch.c |  8 ++++++--
 fetch-pack.c    | 28 ++++++++++++++++------------
 2 files changed, 22 insertions(+), 14 deletions(-)

--=20
2.35.0


--uSX+oYmJxgpYlCiR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHzwkUACgkQVbJhu7ck
PpTMXxAAj1GOysipah4qvXvbj7KpOOwow8zMnsuTGr5DdnwuBHngbaoCYsiC6QqQ
hs0UqCQTJuAc+lUMUtm47Naenhq1/ylJwDsqGBk6ng7d039KJn1gV7MNFek+Cnpj
mOn3ZQqDuOXJcwVayCAISboZUK3Ehn8UOwNTBN+ulcXMv4JAtu8441TfP8tLaJUE
4zDt6amqkfpBYJxGdQDtQGBJ21oGXUetTEx+q/SRgbEsuku9bFhjgXrluv7nBw9L
OVjZlUeEqQz5Gbu0yXrwaPOqdZ01Vc9BEUpPts/QfFprG035b/ZxUXwzZT7F7fwL
D866zSeIAjJ2U2n0PP6Dcr5EAiFeeTRhYtXhSWeQ0DEcToYMgE5xj1xXNHRHcV2f
FVMoBhFEUyUI1k0EMEOwAqKO6+4t7lnA5kkOcKAazahg2rX4O4xbn6sJbA2q0cV1
TFsOD6cab1Xm9jwqB8EGFTizXoGs+DZae9rfnctdypJ4fb8Qnd2k/uIw60Lc9KkB
VFU9JVFlZaccCoqRIezpUZuZEira1i2O5Rk/M0eu1Q3isFKaNjddblC6/e6MmoMT
2ntD7WSoHq7KCZ3md2LRO2g0D6alyy1plOcOTn11bb2wwAZLH8rKZaRNcp7vZ4qM
HWx6mtcTv27zo75az9JNmRUiLDHP0sQXXRFC93TaqVPU6gIo2io=
=INLm
-----END PGP SIGNATURE-----

--uSX+oYmJxgpYlCiR--
