Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCB9C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 12:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344227AbiBBMv6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 07:51:58 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44295 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344230AbiBBMvz (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 2 Feb 2022 07:51:55 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 903545C013A;
        Wed,  2 Feb 2022 07:51:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 02 Feb 2022 07:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=ydSS7V3sA45Kb1BVH1BLS58jRWvrBsDMLxRgfP
        MapPk=; b=qFpZtYd/nrkLWVD+ojvIpY19MJa92BMNlRk16pqcp7D1s5b/ERkYQi
        hG07rsdgO6LJtBE6gIChQrj6CghqDwBcxK4t/EbhYEOmNkgs4upjijwxWRoXiLQX
        ew52lKx5evR1iNJA2Mkgr00I8r6Yq6HMaUJOvLCEch2A5DlXMd6KXinjAWB90e/F
        A+ib8otADjX2NuUZajtys7bMFNh+XAOp+pqaJlRkfSkZ8E7xdH+qg9POZk4LrZ1I
        RP9so8sRohfdh32YCoyccFVOg5+QGHa1qDxqH6xBKaxchxXJCWk1PsbQ40Ix3U8l
        XSNehuXFj+uUs4T9ga7Sojai9eWFKY0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ydSS7V3sA45Kb1BVH
        1BLS58jRWvrBsDMLxRgfPMapPk=; b=iYwI6/q2tGSFbI5tkN9wtEKLpH4XEqP7B
        oxG31MGXGsV6IUSE2gmqK91PW8u1GiC/DPSpIY7t/ufLr88kJd6lzeKe7Nv4CvK5
        F0/Ijh75F5KiFIPr5xzSdvSrIachzQIbp7nn0itB/Fa60aUVHgsafbN7hQ2HIJZM
        r1dmFTcOrrhrUmhzH65lVsZrBpEmVAxJlPxFZA1fql+b4XyHlfdpk/myjdI3slld
        YBDawIpy93ZP1n5Xu4zKY4mvzmIkz6niYLGAQY3jF8UmlrhyGwIA75Tr3jmv4uPN
        K5qFBxJVoL4EimMgXE34FNxtfMjRyVUV83voUIDaKZnMloQYn90Cw==
X-ME-Sender: <xms:a376Ydin94vssbZXGnNyCnk6XLbE60ZqVQOQSSjWjzcFbC8E6EDbmQ>
    <xme:a376YSCjVGwp2a7P6jqLujiMQYzGg3zWaBZqcw_IlQ4JvbQO5rWYqNdLdaaANhmjk
    zRuHCGODGhY3gF-NA>
X-ME-Received: <xmr:a376YdGMeEOIBjmcrE95frRDR8GTsCtxtkLt_iWawIdb98BktqQYJkvo9k_9hKZcx59Zs0LXx5XjMX7Jbg5L2m2q-EfjbrB9vJSCd7d2YBVa9dz29bFBo5vA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeehgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:a376YSQnZ1yaU81DuoDcnIslM1fdWQ-La1KWO_s-YrNIuDUe06jdTg>
    <xmx:a376YazGiY7Nm1EwN4dblsTpKh0subrMLengIo95wqdUAteiGQ-bMA>
    <xmx:a376YY67nkjWDP-RF96N5Vq2GKpctp_t-f-5DTFw5wC3YlMzpqyRCw>
    <xmx:a376YfpyJhrTboPG5KWmrlu8UPIWNVcWRARA7S14_GlRwnYmsBoQNA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 07:51:54 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3fe5e561 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 2 Feb 2022 12:51:53 +0000 (UTC)
Date:   Wed, 2 Feb 2022 13:51:52 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 2/2] fetch: skip computing output width when not printing
 anything
Message-ID: <4b9bbcf7958da6db2be771f910974a6bffb2d94a.1643806143.git.ps@pks.im>
References: <cover.1643364888.git.ps@pks.im>
 <cover.1643806143.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CXqTFHOH/TABUmFI"
Content-Disposition: inline
In-Reply-To: <cover.1643806143.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CXqTFHOH/TABUmFI
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
2.35.1


--CXqTFHOH/TABUmFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmH6fmcACgkQVbJhu7ck
PpRqvw/+JqIbjYMHsGObC2PjPio4zt8njSCZxj9qL1Sczcf1tjd8lFGCErK+h1hh
5xF3P4SH0mrU/tG8iUPa8VL2pDbDpG+fc+1hw03KEU5xEUWymdw1SSz9e2J07ZI6
zFpoGBaikKt6RvAwW9Ns0gMDNHJGT3IW850bEPRePdt02WI59j2sU0uMY9h8v7Gq
2k/iJZ39E32rNtmAjogd9JAdwayTQZZWkESBA1bI14gvVJmnnawSsx0X+P5v5GuN
xyM7DT1xItmUF45Mx6Uv/VQhUNlVNt1iPsOm349PJoKmTgFi5qv7YwQ6Xq82UM6b
q0w+lgRbTxinHSGgC1jeOWZzfBMKrFpiXbRWtg3nYzaRBTePAKR+BqHBRWtRj93n
y577WXj7b6kkylkHpxgcmYvGA2V7H+HkXFkLbagUcVOW3fYRr2BwLHj/P3GvWvqv
/7BF6s5RVV20mqF7ZYXgdgDRX8Q/u8bSkfgr5gFC+006YyE9SEunnohs4TT6lVLF
SBIWJcW+MwNahjauMEb3C8EcBJ1J6tiXfyWCY4KYZCbaDc6KrLtG3J4KEe55kI79
CKkIDXPi8iAeshapye7djhs5V/q9OlHX2fG1XPpiLinzb+ClBMENUF4SIr8gSmYY
MztMrV5+D8EffkeGbypsARaaK38LG0AYTuBXkEiX36mY86G/hoU=
=qu8P
-----END PGP SIGNATURE-----

--CXqTFHOH/TABUmFI--
