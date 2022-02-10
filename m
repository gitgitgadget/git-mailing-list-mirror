Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485ECC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 12:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbiBJM2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 07:28:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241541AbiBJM2T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 07:28:19 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4469E34
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 04:28:19 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 14F805C009E;
        Thu, 10 Feb 2022 07:28:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 10 Feb 2022 07:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=oxykHxvSU6aItsfh9KyImFXEsg639j+oG6cbc6
        GCuys=; b=Si0PKL2crcNq3PfyQpDA1DJccLZ+DSCCjQa57DYyuyBc/2s7Vf22RR
        NjJcAU3ihAQdoi6wYnz2Imv56fefg3AkGfmmxbgm77MrPEDvlvcDANxi12zrtWDE
        seCc0eWRO9U5J6XIQpRPwas7o/rIVAUPInCEkb+kbaudRdjegAiXPH/5BkHgp38o
        iW3rGGt9CnQGFNeLeF6MAB0FQutEWCmvZ8E/96FjxCg1I8G7sYLaKlNJ/bpUAUnc
        85cEe9rnFu+mbXO3/lSGUupWZ+c9Nj0Gv4aZpRAintwkEuuwNv4vAVHbxxjhX2Xf
        F0kkZazkjM4y5T7WDH7atBgsOirLPCsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=oxykHxvSU6aItsfh9
        KyImFXEsg639j+oG6cbc6GCuys=; b=kkHNVSKtVbUhMBVRlOdnRR0P56RrZ88CU
        UjRrF1F8nIHXw4jCGeKxerofju5B4H3wMcyly7RYeQ39iBDcv5MVSYzuX3jYse2e
        xNGR0YIxYw+zKl/kxuWmEA8yCCvBSVpuJhE/DlC4vyF5Iezm6u0+FvYIBOiZJsne
        wD+ydwgSdFpj2s/9RWfKwSIow82gODSBVmyQ++ovgp+5HPxA0PJ0eAhxOcW0l7O8
        tYeQa7ZvF9JGL6+TvUqsEk+/pAjT4OrwN+lRJ41y5OcupNUAzgEuARsbywXax53W
        LBHX8w8aA8ctYvOrTF9AiTA6683KvvskVDVENMTYYo0hfwjEcGfow==
X-ME-Sender: <xms:4gQFYledms69udhKd1n-MgdTRrjjk05uNmOFbT6fflgHRYMxS7iHeQ>
    <xme:4gQFYjNEW6eH-2WhAb4SjV5p7TLmapRs_MRvWJmQ4xm6ZU8m1V8Ljzcj6ai6SPhzC
    jwT-hj54i4N4Q7kow>
X-ME-Received: <xmr:4gQFYugzhlGscEefAxWFnBL6iyrBSf-fOMKh7vrh9ZUiWIMk8hvx7_BKCT6ESP03OVK24rByUTruXmiqwpnpKUhTmCvBn-Ad5hTC6rQX6O93nkzEFJBCZTI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddriedugdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:4gQFYu_1iZevPpJDrl-PRFp9AgWQc4ONueziOBTzXWFvEy7XwcH5yA>
    <xmx:4gQFYhs1Sq_zxZCTnWwstINfyDsGFxBVGFotfjtH-HM1UzVkZ2JIEw>
    <xmx:4gQFYtF6GS4RQ-Gf44068t2S8rYfymEd3pgTwfkK3w-cPat31sBUXQ>
    <xmx:4wQFYq6qPt4SiOO_Lr1JHYC8gitGZpLJYs6opZJOVfOy1-k3qf1NDQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Feb 2022 07:28:17 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2ca441bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 10 Feb 2022 12:28:17 +0000 (UTC)
Date:   Thu, 10 Feb 2022 13:28:16 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 2/2] fetch: skip computing output width when not printing
 anything
Message-ID: <ef1fd07be5e4c50fc096a4a373fbcdc36dd4cbea.1644495978.git.ps@pks.im>
References: <cover.1643806143.git.ps@pks.im>
 <cover.1644495978.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cEwsGKrfGhf8HRl9"
Content-Disposition: inline
In-Reply-To: <cover.1644495978.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cEwsGKrfGhf8HRl9
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
This gives us a speedup of nearly 10% when doing a mirror-fetch in a
repository with thousands of references being updated:

    Benchmark 1: git fetch --quiet +refs/*:refs/* (HEAD~)
      Time (mean =C2=B1 =CF=83):     96.078 s =C2=B1  0.508 s    [User: 91.=
378 s, System: 10.870 s]
      Range (min =E2=80=A6 max):   95.449 s =E2=80=A6 96.760 s    5 runs

    Benchmark 2: git fetch --quiet +refs/*:refs/* (HEAD)
      Time (mean =C2=B1 =CF=83):     88.214 s =C2=B1  0.192 s    [User: 83.=
274 s, System: 10.978 s]
      Range (min =E2=80=A6 max):   87.998 s =E2=80=A6 88.446 s    5 runs

    Summary
      'git fetch --quiet +refs/*:refs/* (HEAD)' ran
        1.09 =C2=B1 0.01 times faster than 'git fetch --quiet +refs/*:refs/=
* (HEAD~)'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5b3b18a72f..7ef305c66d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1094,12 +1094,15 @@ static int store_updated_refs(const char *raw_url, =
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
@@ -1345,7 +1348,6 @@ static int prune_refs(struct refspec *rs, struct ref =
*ref_map,
 	int url_len, i, result =3D 0;
 	struct ref *ref, *stale_refs =3D get_stale_heads(rs, ref_map);
 	char *url;
-	int summary_width =3D transport_summary_width(stale_refs);
 	const char *dangling_msg =3D dry_run
 		? _("   (%s will become dangling)")
 		: _("   (%s has become dangling)");
@@ -1374,6 +1376,8 @@ static int prune_refs(struct refspec *rs, struct ref =
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


--cEwsGKrfGhf8HRl9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIFBN8ACgkQVbJhu7ck
PpSxZA/+N/I5KRii5EhtEd2xiFOnVEapTRCtwUN9/SOufQKe6GAFOqg2h63yzLNb
8fWx2D7L9/aGWnZjN7tnJ5x087jJ9J54bBUjh09bHn4iEC+1/5YkrEvoTFyWYjxS
ft6JbK219BjHQNXd0PiLSbpEJqKpd/zu9VM6H9jA/roM9JIDM4fBuu4jg52hNJio
PSQbF1p6FGUMgAq68LFZnBe2kxwkod5zIcc2u9BnuupblAim3x51/LuX8I1iq3ut
MMjiSildqlNUbc82zDKUZuS7iiVQZUhj5t0Et79d8CCuEY66+lwoNq/aChguYrrx
4eZB3I/c7N2Z9xYp2I8BUPe7Dru1JgVwtQsO2nn7aW4fpOtVk5jz3EJua0CtwDI+
JL+2vtu0kEUZGGuOX8mrddcyAyuOqM7dF161NwGhvqXqHGaWdiOSLLxgdpm0xI4G
6dylGg4fOvXhI9GvaLpy9dcA0tWnba8l96P2PLVysLSU1wq8WspHdjjmtAeSCr4C
tX1sJsj28JcO1nT/t0f0KUzxYz8CUINrANn/ya80uW+Q3vE+ZlnhcM8pC9vMtsYl
urKhC7yHcbqBSz1jZevZxzbp96WuhB45y+BpGnvcSByD6V5nSh7xeCgTnH7GVivS
mXmyjzLwRloEfyAoE6d3Dw6gq/HBzQXNsdtyfwwduA4e186SIY4=
=Uzpm
-----END PGP SIGNATURE-----

--cEwsGKrfGhf8HRl9--
