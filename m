Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFEAC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E36D61265
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbhHXKiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:38:01 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42105 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236232AbhHXKh4 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Aug 2021 06:37:56 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3826C5C0079;
        Tue, 24 Aug 2021 06:37:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 24 Aug 2021 06:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=UWWOdz6xMcmICbFqoU/c4SXkFdY
        tjN6tbnvPKpberVs=; b=Bsn3zcUryceQ/H9vqpmZVR5FZHuZyImL7DpXvEPG0B5
        4sX+/a37bttd/2zBYu51/1IKCb4XUh7HBKS/xD73dXwLHEfcBIPciJ74+hGeZS2x
        btYxmZVz+ZfK5QwrzOWHTjgYKDwSjW3rRHwd7wKxroZW6XdgYN+PPbpGzt4AYek/
        RFI91To5IlvSewXSuhPcwsYjURcL7OjWhEGoFPKz22dgONawT7UrgV77iOPv7b1g
        +Z6mvJIQbWJ1U6+ZP6WU1SOnyJhaJoPwBGcqVfQsObSluieM6hJgAyEjg0XgB6ux
        36hMlm9S8O8XG0nVcb5WB5UttSXtgToIEhI0792p10A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=UWWOdz
        6xMcmICbFqoU/c4SXkFdYtjN6tbnvPKpberVs=; b=La0KxQ/pkVWrkHLcL+8/kk
        L1B0kvMVs085AHkUg5GFnzlgFKrnBDge/YEdJuMw2WlxmERFwqfSB8CPvcZcwNPm
        OG6GUEU3X/zZpnQo/l1rBBzzkXb6TwviP3vAB0BOCfhwYHuFwZQlaOX46kv1ncvd
        NuNzdiaMrOAdk6RmScf0E6xCOq1A5v5CvPb5DpWeBgrq7L9Ir7KOmRjnb6yb4n8w
        Uc43n8aIrOv6Tg4OWmDC62paPb3iAVInoPlrkfaxdiOsMl26gc2+ta/Qi92Y0PJG
        kOU58MiqKS5fFHWhcG/LTsFYysH4IQ1xvteRhomvCxoWu/955NdOoCPMxv7Qm5oA
        ==
X-ME-Sender: <xms:18skYYlrdoT-aiBKJVeJt06ieMzwc61xSmBZWDZ1RKnMO75u0cTcNw>
    <xme:18skYX37SgP-S35WYi3obDRhU-DioLecLCt04kKJ_pt_xJ_UiwqOOvPCPCwKhbhee
    Gr91lVedbv9hezVag>
X-ME-Received: <xmr:18skYWq6e_npzA6SyZlCEC2smD9waxmDSGKC8Hskw8Nbq7oVvGGXcI8d2sCvWE8NjUW5eNHfE46v3Gy1cftt0VCpUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:18skYUkHxW3Cic5D4x-WtI6UPABQ6LAq0T_HBjZHVEognIHyxmkkNA>
    <xmx:18skYW10_wKwJJIHoCLtD_1sEPTEhk7gPJAP8Bs9MtKpOqmsjocHow>
    <xmx:18skYbscwSS_3VzF831SbjuFLR_to_cZA-VJM8kzbZ3Hshuw9mMPIg>
    <xmx:2MskYZQ9Vxc2_WUCzXTQvC8UhIj5tih-EiHrlJ8HKBgJj7GfOKg8Jw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Aug 2021 06:37:10 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 96b2a443 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 24 Aug 2021 10:37:10 +0000 (UTC)
Date:   Tue, 24 Aug 2021 12:37:09 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 4/7] fetch-pack: optimize loading of refs via commit graph
Message-ID: <6311203f08219a8fa3884af5d288340a3fa5f47a.1629800774.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
 <cover.1629800774.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JsxHjCMK6dwEQCPP"
Content-Disposition: inline
In-Reply-To: <cover.1629800774.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JsxHjCMK6dwEQCPP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to negotiate a packfile, we need to dereference refs to see
which commits we have in common with the remote. To do so, we first look
up the object's type -- if it's a tag, we peel until we hit a non-tag
object. If we hit a commit eventually, then we return that commit.

In case the object ID points to a commit directly, we can avoid the
initial lookup of the object type by opportunistically looking up the
commit via the commit-graph, if available, which gives us a slight speed
bump of about 2% in a huge repository with about 2.3M refs:

    Benchmark #1: HEAD~: git-fetch
      Time (mean =C2=B1 =CF=83):     31.634 s =C2=B1  0.258 s    [User: 28.=
400 s, System: 5.090 s]
      Range (min =E2=80=A6 max):   31.280 s =E2=80=A6 31.896 s    5 runs

    Benchmark #2: HEAD: git-fetch
      Time (mean =C2=B1 =CF=83):     31.129 s =C2=B1  0.543 s    [User: 27.=
976 s, System: 5.056 s]
      Range (min =E2=80=A6 max):   30.172 s =E2=80=A6 31.479 s    5 runs

    Summary
      'HEAD: git-fetch' ran
        1.02 =C2=B1 0.02 times faster than 'HEAD~: git-fetch'

In case this fails, we fall back to the old code which peels the
objects to a commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 fetch-pack.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index e6ec79f81a..dc800879cb 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -119,6 +119,11 @@ static struct commit *deref_without_lazy_fetch(const s=
truct object_id *oid,
 {
 	enum object_type type;
 	struct object_info info =3D { .typep =3D &type };
+	struct commit *commit;
+
+	commit =3D lookup_commit_in_graph(the_repository, oid);
+	if (commit)
+		return commit;
=20
 	while (1) {
 		if (oid_object_info_extended(the_repository, oid, &info,
@@ -139,7 +144,7 @@ static struct commit *deref_without_lazy_fetch(const st=
ruct object_id *oid,
 	}
=20
 	if (type =3D=3D OBJ_COMMIT) {
-		struct commit *commit =3D lookup_commit(the_repository, oid);
+		commit =3D lookup_commit(the_repository, oid);
 		if (!commit || repo_parse_commit(the_repository, commit))
 			return NULL;
 		return commit;
--=20
2.33.0


--JsxHjCMK6dwEQCPP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEky9QACgkQVbJhu7ck
PpRKSg//ZoYyUWdegg2LZAVkfB/j/Riv67/ux+S/lpxvpwFTUEhTvxiU5Bu6d4Wh
HZApIwptqvP4OfkXiycnzn9I0Hh2KVe9E19DNzXiaahGY4peW99evz3R8/7pQ8MJ
qxWBz2Feu/jwj64+aQyM/iBtS/5N/a4XmDHIzN4onl0FAejoHnhKtVUvkti5n3nq
CKVKkMRX2u9cNwhuz3Oj7tCypBljVLIl9rC1hpvOhXznXwDhMl7n/v6twsPXCSbL
PGYFIC73cmhQBOcaPV4wU0qKTPMzT/rX4yVaTLlWoG0NTXyeiaR+kY2wEduJuDE/
gGxd0XYGDqmxKIehG553YRfBP/rbwj/vPsJg9V2BS9Xynm5Y/Yp4Esc5WOrH1XC/
oo2YIGytRS+gIlS0sYISOA6Fah89uW+RwHvH4phfhYV7L29WMNitbgdVJm2KEKFb
uJJ0WzAyQ5lOubdYsGd3cL2ATkOw+qGIkv3/tZhN6XgYz/i+4GjOgnFBmc0VyIL7
MQEf1khc9TcjR78/CrkSLNdpusxKaPHVlIOrJSag316oYmeqKFWZuRhdRxzueuO7
5eOwrNQTo66+1mMtOpvkRavP0ThbosJVCxkoADiVk57TC//0WnowjbNcwXUCq5IV
7GoqM8PpR1Aa5mf8ndxPxu96wZpdQY7mC+SMihqk90w/eyvqA5s=
=fOdY
-----END PGP SIGNATURE-----

--JsxHjCMK6dwEQCPP--
