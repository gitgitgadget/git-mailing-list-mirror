Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DD9C433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 09:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5FCA61220
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 09:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhDNJnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 05:43:45 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59185 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233066AbhDNJno (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Apr 2021 05:43:44 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 609815C019D;
        Wed, 14 Apr 2021 05:43:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 14 Apr 2021 05:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=1Ostu/eKSWtZRIa7/sQnnJbbnBB
        7ZI6s8al0l9j9GWY=; b=o5DMc5UC4GaNo0BqAJq1iZwZlwTKozxiTDXe2JVqAHz
        rUrNhUZtEJt/136ydBAaW4Qb3/HMVE2fxcISm8trM/d4nAdS2WeEChu7wi8GVIw/
        70BsMV9Mmh6T8aBZRrb01uODhjyL8r1j2zLT4/sjSb2RrE+l3KUOsTyQFtMySrRf
        xSr/KM4vA3GTzvhOzobRJIqVGXpWUzJTCv07KLUVzSl0NCcA2ej7DhEP9q+cB9/G
        cQ3ud0YdbHVL7Qai2jfoYwB7w46J7X5nBJ1P+E8wVQmil5pzZiTme84lHNNo1OSi
        KH9M6UVR3LVRVegPHBHuiU7fVbma+/yhkDMl3yeORrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=1Ostu/
        eKSWtZRIa7/sQnnJbbnBB7ZI6s8al0l9j9GWY=; b=VV3dv/JhtHekuo3MC0yYzf
        pP9h4BXICY9sbGiTntwAtrYYpD3HHgA9hZceZsaF3vN8B66uZaBUByFnaFDVyxcN
        Z6vZtdgJRxZ99k1P4gJqwGkDlNBgrVoDtGGj8i7GPZ2SLW4e2Spmy5lgy1oc5C2s
        +AmR+5lL7ADfmErmaV8wGfShBnlwFY9fYHTsyDuULFMyVWsRT7M7d8Zw5hQXWytp
        VKJi3L1ue6zsFqVD70sABKm2zGIpR1/Rvfl++W+kIVjWAUvmk5ZBqvunBl5VP9l2
        ZEaIYN2Tj2aG8shjpogJlAllP+7/oOtLwl2POPaUWswWO2/2xsMD/4NibxGtxVvA
        ==
X-ME-Sender: <xms:O7l2YCEmvYJ30RYMZz8-r7Z89FG57brmvM0z9bI3hPCAODII_R9F-g>
    <xme:O7l2YDX-LKebvTzLDfckij-xasBb3CjKBgsklOV6SI6uxaagj_Gjs8RDqgTTVAP5J
    kGYniEGkRDTEYdlDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeluddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepgeeuudfggfetudetuddtteffveejgfegte
    etieejfeekheegjeettdeuiedvleejnecuffhomhgrihhnpehvrghlvddrthgrrhhgvght
    pdhuphgurghtvgdrnhgvfidpuhhpuggrthgvrdhnrghmvgdpuhhpuggrthgvrdgvmhgrih
    hlnecukfhppeejkedrheehrdefgedruddtieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:O7l2YMIyyOCB0WEv8ZhqxW15aGu3TWhFLBZ_AJXuJvWjnNdpIVkbgQ>
    <xmx:O7l2YMFUk96EtF9XKSUc5RbnJewspyMhE7d8ekQoXJ5kiSyGtTGU0g>
    <xmx:O7l2YIVAEN9KoJrPWKFV9NPX8RdzrSkzu0D0EER0xwpZrs4RKzG-Jg>
    <xmx:O7l2YBcmrE36fkI31m5ECeGt5XJxzbi3a9mkaOYGdZKpXtqMyHktfg>
Received: from vm-mail.pks.im (dynamic-078-055-034-106.78.55.pool.telefonica.de [78.55.34.106])
        by mail.messagingengine.com (Postfix) with ESMTPA id 82E16108005C;
        Wed, 14 Apr 2021 05:43:22 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e439e839 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 14 Apr 2021 09:43:18 +0000 (UTC)
Date:   Wed, 14 Apr 2021 11:43:16 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: What's cooking (draft for #4's issue this month)
Message-ID: <YHa5NE3tj/R5kF8N@ncase>
References: <xmqqmtu1zn3o.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5p6EFo9hyhauGsM0"
Content-Disposition: inline
In-Reply-To: <xmqqmtu1zn3o.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5p6EFo9hyhauGsM0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 13, 2021 at 06:11:39PM -0700, Junio C Hamano wrote:
> On 'seen' there are many topics that have not seen adequately
> reviews; some tests are broken near its tip (I think they pass the
> selftests by themselves).
>=20
>     0e76df05ca Merge branch 'ps/rev-list-object-type-filter' into seen
>     956fbceb2e ### breaks 6112 6113
>     c007303ad4 Merge branch 'bc/hash-transition-interop-part-1' into seen
>     4813f16161 ### breaks 0031

Test breakage for the rev-list filter series has been a bad interaction
of d8883ed540 (object.c: stop supporting len =3D=3D -1 in
type_from_string_gently(), 2021-03-28) and
ps/rev-list-object-type-filter. The following patch fixes this, which
I'll include in my next reroll of this series.

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 19e128ef11..33c7718a7a 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -100,7 +100,7 @@ static int gently_parse_list_objects_filter(
 		return 1;

 	} else if (skip_prefix(arg, "object:type=3D", &v0)) {
-		int type =3D type_from_string_gently(v0, -1);
+		int type =3D type_from_string_gently(v0, strlen(v0));
 		if (type < 0) {
 			strbuf_addstr(errbuf, _("expected 'object:type=3D<type>'"));
 			return 1;


The other breakages I see are caused by hn/reftable, where all tests in
t0031-reftables.sh cause segfaults. The root cause seems to be that
reading refs via the reftable backend doesn't initialize the `algo`
field of the OID, which is fixed via the following patch.

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 130fd90e45..35fb7dd0a2 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -251,10 +251,10 @@ static int reftable_ref_iterator_advance(struct ref_i=
terator *ref_iterator)
 		ri->base.flags =3D 0;
 		switch (ri->ref.value_type) {
 		case REFTABLE_REF_VAL1:
-			hashcpy(ri->oid.hash, ri->ref.value.val1);
+			oidread(&ri->oid, ri->ref.value.val1);
 			break;
 		case REFTABLE_REF_VAL2:
-			hashcpy(ri->oid.hash, ri->ref.value.val2.value);
+			oidread(&ri->oid, ri->ref.value.val2.value);
 			break;
 		case REFTABLE_REF_SYMREF: {
 			int out_flags =3D 0;
@@ -299,7 +299,7 @@ static int reftable_ref_iterator_peel(struct ref_iterat=
or *ref_iterator,
 	struct git_reftable_iterator *ri =3D
 		(struct git_reftable_iterator *)ref_iterator;
 	if (ri->ref.value_type =3D=3D REFTABLE_REF_VAL2) {
-		hashcpy(peeled->hash, ri->ref.value.val2.target_value);
+		oidread(peeled, ri->ref.value.val2.target_value);
 		return 0;
 	}

@@ -977,7 +977,7 @@ git_reftable_reflog_ref_iterator_advance(struct ref_ite=
rator *ref_iterator)

 		free(ri->last_name);
 		ri->last_name =3D xstrdup(ri->log.refname);
-		hashcpy(ri->oid.hash, ri->log.update.new_hash);
+		oidread(&ri->oid, ri->log.update.new_hash);
 		return ITER_OK;
 	}
 }
@@ -1090,8 +1090,8 @@ static int git_reftable_for_each_reflog_ent_newest_fi=
rst(
 			break;
 		}

-		hashcpy(old_oid.hash, log.update.old_hash);
-		hashcpy(new_oid.hash, log.update.new_hash);
+		oidread(&old_oid, log.update.old_hash);
+		oidread(&new_oid, log.update.new_hash);

 		full_committer =3D fmt_ident(log.update.name, log.update.email,
 					   WANT_COMMITTER_IDENT,
@@ -1157,8 +1157,8 @@ static int git_reftable_for_each_reflog_ent_oldest_fi=
rst(
 		struct object_id new_oid;
 		const char *full_committer =3D "";

-		hashcpy(old_oid.hash, log->update.old_hash);
-		hashcpy(new_oid.hash, log->update.new_hash);
+		oidread(&old_oid, log->update.old_hash);
+		oidread(&new_oid, log->update.new_hash);

 		full_committer =3D fmt_ident(log->update.name, log->update.email,
 					   WANT_COMMITTER_IDENT, NULL,
@@ -1330,8 +1330,8 @@ git_reftable_reflog_expire(struct ref_store *ref_stor=
e, const char *refname,
 		if (err > 0 || strcmp(log.refname, refname)) {
 			break;
 		}
-		hashcpy(ooid.hash, log.update.old_hash);
-		hashcpy(noid.hash, log.update.new_hash);
+		oidread(&ooid, log.update.old_hash);
+		oidread(&noid, log.update.new_hash);

 		if (should_prune_fn(&ooid, &noid, log.update.email,
 				    (timestamp_t)log.update.time,
@@ -1410,7 +1410,7 @@ static int git_reftable_read_raw_ref(struct ref_store=
 *ref_store,
 		strbuf_addstr(referent, ref.value.symref);
 		*type |=3D REF_ISSYMREF;
 	} else if (reftable_ref_record_val1(&ref) !=3D NULL) {
-		hashcpy(oid->hash, reftable_ref_record_val1(&ref));
+		oidread(oid, reftable_ref_record_val1(&ref));
 	} else {
 		*type |=3D REF_ISBROKEN;
 		errno =3D EINVAL;


Patrick

--5p6EFo9hyhauGsM0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB2uTQACgkQVbJhu7ck
PpQ60hAArnpoBvBBFeiiCIr7y+k8Hl5viEoPMN5VCXcjZC5kGfxigvJqSGUbDWin
P7ZBniJgO+6gQQboP4L7sDKGma8F+DrnImjV7pqkf/WpZ7oe9zi2CwJHfLPPiApA
0k1XEOg1E//EceX1CRGGAasbQcM0vpdIbt6r5z3vFi5rRw9Z7Eqs5ciuMTw3IqFU
vN6mooLAW0WDAfSCDX6xN2DpUxluBpfAkXzy7KUv1VW/8LrsN+vo6lpnPVNO47wm
AU2j8RwALjlUZKbFEUkBUCqTunSn0BqlTJoLiiWlsfX35Jvf+pb1P9tsRpfZ4Nru
utUY+7YVUe8gYLSjCf08rjAbss3KOeXzuV7pB5aVzr9hthptzfveY7lmWuQcejC+
Svt+LrenjGulAdVbDLzXgaPYKBzMohGEtD0fsVvmHgatmq8JYaKqhHsVOBV87Jso
91/dEXnmU2x5R2YaHDxDDc+E7y7bnXs1+K+mdsv5NjmEnWInw7fEy5hMZ5Xaukbt
BMM6il6nnGeY8sqWELWO0AXDMVasN6uETJMLxgRVRHEQ+/Y/WT5t7AQvxoVCSz38
1M7tRbGFOLiUsaN1A10SxCekD30TGIju6PlFWEfQV8QZy6FFGzucFSoUlb4MtAOG
TGeuB417q6ZNM4gpk6pTKLYts0N0OJrRbxcikZ9MJd0q1L9LIgA=
=NWA9
-----END PGP SIGNATURE-----

--5p6EFo9hyhauGsM0--
