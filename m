Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D70C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 10:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347176AbiA1KRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 05:17:37 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:56905 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345674AbiA1KRO (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Jan 2022 05:17:14 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A5CA63202069
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 05:17:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 28 Jan 2022 05:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=+zodOWDJK8kYc9duP2VQbj6jPP/xgrAJ46esAP
        HZFj0=; b=Nx6nZ3M1TSRM+9m5jKLPTCXPDSiRQeFkRDJcQt/H74CL0g1BxtyZRx
        ij8zGqsMHMY75WOCT9Fc57dRYsKK7KCJ4R+5k2pEo9TWJlChqoQkT046BR5ChpN3
        vpljDBAGxW4GJTD9aQ1OdYjbRImfxGP4UZeDsQQEM3/sbooVz5UDTXX+PS4uskzP
        +8LGtli4JIUqXjA8XmrpBjC7JTzZ0xErqR9X/AqsRo20oDmsGzxLnN8T87Mw+Obz
        xTyFEdVFFALz8MvSn8QwtZtZhflP6yMhXeTfQG6X7ruw7ayQp3KjYZqwZ+V3JtrY
        LxKg+Oz5jI0a/wk3SVeCaAtBuTXGcOuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+zodOWDJK8kYc9duP
        2VQbj6jPP/xgrAJ46esAPHZFj0=; b=aproTLmV8wzzWqBRVw5xnHIoSSiDfTHZA
        zE19HgQ/5vKb7vm7ZnbbV3SkdeEiw9EOAD73dxHmmRr4owsREUB4vJoCnwCj7qX+
        HnBW/4yBPxmdSqwb9GPqqoNvog3PN16h2LNAIfodwc8SDp8U8QnKFKB9QpM29bQn
        pLlRB4+WL1H/fQuyjHxancgq8dmhjXc7FX5W5jEuz9SdROPOHTTgO7I3GBsE8LRH
        T/4d6PZ0beCb4jLulLSI60khWVxqFVSZvPv1tVzMOnAdvYgkKpRG820JRBSa1Jns
        lRWPpDejgSvQG+WmoIfztsNU4BUF3mG52/5t3/g3h2eJ0QrkLCBHg==
X-ME-Sender: <xms:qMLzYQMpqTOIRXHS_-IB9bd3E1xtNLB9j33TeAjiWUprlS7n_fNUhg>
    <xme:qMLzYW9Emaon_9bJkZTYwUPtyPVVLlUHhH4qttSpkSnocme26iZ5MDlcrxx4axTew
    RVCfnJZBHYN5bK7EA>
X-ME-Received: <xmr:qMLzYXQ1cqYIpLbzwtz_xAshO7NsvF-X1RITzyf8JLTjXDLTs7rHybUN1MCYzfszjMwzY3F6zFpMHx7x_INrcnR48_gYNpIM5ta2jJh21r-zXtH5AGRfWAs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeehgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgfejueevjeetudehgffffeffvdejfeejie
    dvkeffgfekuefgheevteeufeelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:qMLzYYtmep61R-v9U6DI_Z7Cv_YQDPJjkz82Y06WF7bjECGq7eyrDw>
    <xmx:qMLzYYdPpsD_P-Zs5PdMNtFeeC0A87p9FmFmdpypEkCMzH3aJ-7E9A>
    <xmx:qMLzYc3CnVWtSOQKecq_zo7ySZco9umam-9aUqEQIHuiKKklCSn1FA>
    <xmx:qcLzYSr2EXSKee-o0GVaTk01cAVtS1OonBDOL08VkERdHNpbpQGKJA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 28 Jan 2022 05:17:12 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 40975f70 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 28 Jan 2022 10:17:11 +0000 (UTC)
Date:   Fri, 28 Jan 2022 11:17:10 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] fetch: skip computing output width when not printing
 anything
Message-ID: <5a3fd3232fd9e19e6f0054717a1f54c71bd8f272.1643364639.git.ps@pks.im>
References: <cover.1643364639.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pOmLPJlGj4bcZmEK"
Content-Disposition: inline
In-Reply-To: <cover.1643364639.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pOmLPJlGj4bcZmEK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When updating references via git-fetch(1), then by default we report to
the user which references have been changed. This output is formatted in
a nice table such that the different columns are aligned. Because the
first column contains abbreviated object IDs we thus need to iterate
over all refs which have changed and compute the minimum length for
their respective abbreviated hashes. While this effort makes sense in
most cases, it is wasteful when the user passes the `--quiet` flag: we
don't print the summary, but still compute the length.

Skip computing the summary width when the user asked for us to be quiet.
This gives us a small speedup of nearly 10% when doing a dry-run
mirror-fetch in a repository with thousands of references being updated:

    Benchmark 1: git fetch --prune --dry-run +refs/*:refs/* (HEAD~)
      Time (mean =C2=B1 =CF=83):     34.048 s =C2=B1  0.233 s    [User: 30.=
739 s, System: 4.640 s]
      Range (min =E2=80=A6 max):   33.785 s =E2=80=A6 34.296 s    5 runs

    Benchmark 2: git fetch --prune --dry-run +refs/*:refs/* (HEAD)
      Time (mean =C2=B1 =CF=83):     30.768 s =C2=B1  0.287 s    [User: 27.=
534 s, System: 4.565 s]
      Range (min =E2=80=A6 max):   30.432 s =E2=80=A6 31.181 s    5 runs

    Summary
      'git fetch --prune --dry-run +refs/*:refs/* (HEAD)' ran
        1.11 =C2=B1 0.01 times faster than 'git fetch --prune --dry-run +re=
fs/*:refs/* (HEAD~)'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f06b21f8e..ebbde5d56d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1093,12 +1093,15 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 	struct ref *rm;
 	char *url;
 	int want_status;
-	int summary_width =3D transport_summary_width(ref_map);
+	int summary_width =3D 0;
=20
 	rc =3D open_fetch_head(&fetch_head);
 	if (rc)
 		return -1;
=20
+	if (verbosity >=3D 0)
+		summary_width =3D transport_summary_width(ref_map);
+
 	if (raw_url)
 		url =3D transport_anonymize_url(raw_url);
 	else
@@ -1344,7 +1347,6 @@ static int prune_refs(struct refspec *rs, struct ref =
*ref_map,
 	int url_len, i, result =3D 0;
 	struct ref *ref, *stale_refs =3D get_stale_heads(rs, ref_map);
 	char *url;
-	int summary_width =3D transport_summary_width(stale_refs);
 	const char *dangling_msg =3D dry_run
 		? _("   (%s will become dangling)")
 		: _("   (%s has become dangling)");
@@ -1373,6 +1375,8 @@ static int prune_refs(struct refspec *rs, struct ref =
*ref_map,
 	}
=20
 	if (verbosity >=3D 0) {
+		int summary_width =3D transport_summary_width(stale_refs);
+
 		for (ref =3D stale_refs; ref; ref =3D ref->next) {
 			struct strbuf sb =3D STRBUF_INIT;
 			if (!shown_url) {
--=20
2.35.0


--pOmLPJlGj4bcZmEK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHzwqUACgkQVbJhu7ck
PpQ+8BAAoehrJgW8Y5sa2CCJ2H/XkAbSj5kzDbkQYvnwZrvKR72Vqvk74KD/0hsN
zSSbaDycYdEVDUyhsm/N1CgKLFn6KwzALsRyEQMBgCGtLEJbw+GRTlBPpP16fnjy
D1hnxSfq5Ekn2WC/YlJUXMvaIEjumvn0g+/MBBxTrJsNXl4NwzdgInVqgT6P+E7M
TGYM2av6EDoYtAmAFoqqAomUJU9rX6kLncc1dYhkspQr/3Q/+YTzxk1A9tt311Ip
SuRvViHpM61p/8eqYsvs54y+Zw3bzt3qt8iUzsb9OdymDuaLn9KgVhxur919A9vC
Ba2X8EZQ9pN2FOG3BjrCSJ03j8U6HNsf8O78Fb5KhJYlV6odsR7UaDfCGGq3saBH
I9zLTqCRxF+GnME2c7BpZqWKPbFUg1KMOSyCH7m63awq1hv3Gv4i6oRFyvR0l0Iq
lgAqAZUcLbv1zonIJ+EBkmVf4nEwuU7KSHNfvzkEO0aNWHS2Hgc4+HHpkiFJui8g
/Jp+/evHTTIHozilW+rdg/UjpgwQl6n9n2vguzECUBN2+Dp8ee1O7Ds0Lw2DuqUW
k+kmNq8hNx8IaIAn0oz6eIfbFAS/Fsx0bnAg9ukJK1AQQAqVryMLotb++Eyh2QQT
4DxnGK4iuoDy3NNmZXq+K1N36uey9/v0ReNrwxVs6xW7Kl7VcjU=
=hAZW
-----END PGP SIGNATURE-----

--pOmLPJlGj4bcZmEK--
