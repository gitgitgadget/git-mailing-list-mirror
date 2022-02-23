Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A694BC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 12:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbiBWMgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 07:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240491AbiBWMgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 07:36:16 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB0FA27B1
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 04:35:46 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E90D6320187F
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 07:35:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 23 Feb 2022 07:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=EOnloiPcWIzchY5d3Qqpa8v/o0Iw8YS5SpJsLi
        NtTL4=; b=AOyB6P5eN/Gq/verw8TIyftJAmlkku2YLVbQHgZQgywDEDvMt2TPlb
        cgyy5bp++mpWUddSmuxZTTdcejNRUVW7Xd7+5+yT4BN/1NEbzM4gw6uOhdS8GuuW
        Y5I2DvWkRhc8IJwXsNZuB9h6gE9It95HQMwFidmi2Y+tBz9FTbk7tkW9xJ2pBx8y
        36w+fihUYpGSmODNeEgkJpj+4JB4dm3zC9hIOOlDhRxgzpj4GfuEzZnlx8TjGdZX
        qgU6AURTbBCEQdZmd1npmC8PumNJCZoHjbAUnvegdvT5OiRc6IFSFEctKpigCl01
        eFdGDjvZMaJu0QRCEvdEu5zhw4oZtZ8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=EOnloiPcWIzchY5d3
        Qqpa8v/o0Iw8YS5SpJsLiNtTL4=; b=IIre5g0WNO4E5VoRHEftkPHtzQue+QKtB
        LjLG0ocVW1BOTm8jt+RSflE2gLfHhrC8pvnCUicaF8/WvHYszNB6iKJdgwoRW9c1
        3hBBe+SGqK7Qj+wPKY2KvaYIkOrviQNM+qqqvueQ25yDhEn10uizu7ZDvGN3Clxd
        kTp0IPA61AetjfizLEYoRJ2MxisS99+gXx3uOY1hzjSM5ZGv423kFeexE72YBulK
        kHcE2MPznWk9QbAhc6gAWXQvuw5bNgJczb3VtpBhydiEzYzChKELe/sWXQ91hH4+
        OtFOIFv3mgZekuGFzWChFi5MMz1EiYouGwwKoh1gWTyZJGxEjyZlQ==
X-ME-Sender: <xms:ISoWYv1W7cZoZgIrzjxlSII6RVAgIx7fJ7EQJgbLQDmfSoPEAugzlQ>
    <xme:ISoWYuFzZ861dV3NEDXfkuWcNs41bX0zVlX0YqrAsCpruG89kDtoV6Bho3tqriNQZ
    njfF71gk2cypx0yRw>
X-ME-Received: <xmr:ISoWYv7U9LyVwXVgLbYuptaIZR3WjEe-amP4dTPusLXZIAisG34VtaF6aCPAJV40l-nfRrE00IgKH8jcnzEWubaCEiLXA7Le0zmBgyZQ0in6FfQRJH_9xi0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrledtgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgfejueevjeetudehgffffeffvdejfeejie
    dvkeffgfekuefgheevteeufeelkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ISoWYk1Qpk4-sProiKdolaGZUBG71dQRq6oun_vHpM7MLahCdEKsjA>
    <xmx:ISoWYiEjNfLoqK99MKCev3CPzqDVXNgUcBxKinWA6XwaLxsHpiu0jw>
    <xmx:ISoWYl83gl-S-8ux_QbyHEywEFrdD1pZ2C31dBFyZzpZccGpA_WsCA>
    <xmx:ISoWYtzhl8rir1Jt8o_i46u48h2Jto-ZEc_REHMbXKG81sU5iHZSwg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Feb 2022 07:35:44 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8da4dcec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 23 Feb 2022 12:35:44 +0000 (UTC)
Date:   Wed, 23 Feb 2022 13:35:43 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 5/5] refs/files-backend: optimize reading of symbolic refs
Message-ID: <7213ffdbddc7b14c8665974e41bda9449f66de4a.1645619224.git.ps@pks.im>
References: <cover.1645619224.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t9cFUCglzotSEI4q"
Content-Disposition: inline
In-Reply-To: <cover.1645619224.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--t9cFUCglzotSEI4q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When reading references via `files_read_raw_ref()` we always consult
both the loose reference, and if that wasn't found, we also consult the
packed-refs file. While this makes sense to read a generic reference, it
is wasteful in the case where we only care about symbolic references:
the packed-refs backend does not support them, and thus it cannot ever
return one for us.

Special-case reading of symbolic references for the files backend such
that we always skip asking the packed-refs backend.

We use `refs_read_symbolic_ref()` extensively to determine whether we
need to skip updating local symbolic references during a fetch, which is
why the change results in a significant speedup when doing fetches in
repositories with huge numbers of references. The following benchmark
executes a mirror-fetch in a repository with about 2 million references:

    Benchmark 1: git fetch --prune --no-write-fetch-head +refs/*:refs/* (HE=
AD~)
      Time (mean =C2=B1 =CF=83):     68.372 s =C2=B1  2.344 s    [User: 65.=
629 s, System: 8.786 s]
      Range (min =E2=80=A6 max):   65.745 s =E2=80=A6 70.246 s    3 runs

    Benchmark 2: git fetch --prune --no-write-fetch-head +refs/*:refs/* (HE=
AD)
      Time (mean =C2=B1 =CF=83):     60.259 s =C2=B1  0.343 s    [User: 61.=
019 s, System: 7.245 s]
      Range (min =E2=80=A6 max):   60.003 s =E2=80=A6 60.649 s    3 runs

    Summary
      'git fetch --prune --no-write-fetch-head +refs/*:refs/* (HEAD)' ran
        1.13 =C2=B1 0.04 times faster than 'git fetch --prune --no-write-fe=
tch-head +refs/*:refs/* (HEAD~)'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f3428a9f12..0457ecdb42 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -338,9 +338,9 @@ static struct ref_cache *get_loose_ref_cache(struct fil=
es_ref_store *refs)
 	return refs->loose;
 }
=20
-static int files_read_raw_ref(struct ref_store *ref_store, const char *ref=
name,
-			      struct object_id *oid, struct strbuf *referent,
-			      unsigned int *type, int *failure_errno)
+static int read_ref_internal(struct ref_store *ref_store, const char *refn=
ame,
+			     struct object_id *oid, struct strbuf *referent,
+			     unsigned int *type, int *failure_errno, int skip_packed_refs)
 {
 	struct files_ref_store *refs =3D
 		files_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
@@ -381,7 +381,7 @@ static int files_read_raw_ref(struct ref_store *ref_sto=
re, const char *refname,
 	if (lstat(path, &st) < 0) {
 		int ignore_errno;
 		myerr =3D errno;
-		if (myerr !=3D ENOENT)
+		if (myerr !=3D ENOENT || skip_packed_refs)
 			goto out;
 		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
 				      referent, type, &ignore_errno)) {
@@ -425,7 +425,8 @@ static int files_read_raw_ref(struct ref_store *ref_sto=
re, const char *refname,
 		 * ref is supposed to be, there could still be a
 		 * packed ref:
 		 */
-		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
+		if (skip_packed_refs ||
+		    refs_read_raw_ref(refs->packed_ref_store, refname, oid,
 				      referent, type, &ignore_errno)) {
 			myerr =3D EISDIR;
 			goto out;
@@ -470,6 +471,27 @@ static int files_read_raw_ref(struct ref_store *ref_st=
ore, const char *refname,
 	return ret;
 }
=20
+static int files_read_raw_ref(struct ref_store *ref_store, const char *ref=
name,
+			      struct object_id *oid, struct strbuf *referent,
+			      unsigned int *type, int *failure_errno)
+{
+	return read_ref_internal(ref_store, refname, oid, referent, type, failure=
_errno, 0);
+}
+
+static int files_read_symbolic_ref(struct ref_store *ref_store, const char=
 *refname,
+				   struct strbuf *referent)
+{
+	struct object_id oid;
+	int failure_errno, ret;
+	unsigned int type;
+
+	ret =3D read_ref_internal(ref_store, refname, &oid, referent, &type, &fai=
lure_errno, 1);
+	if (ret)
+		return ret;
+
+	return !(type & REF_ISSYMREF);
+}
+
 int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
 			     int *failure_errno)
@@ -3286,7 +3308,7 @@ struct ref_storage_be refs_be_files =3D {
=20
 	files_ref_iterator_begin,
 	files_read_raw_ref,
-	NULL,
+	files_read_symbolic_ref,
=20
 	files_reflog_iterator_begin,
 	files_for_each_reflog_ent,
--=20
2.35.1


--t9cFUCglzotSEI4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIWKh4ACgkQVbJhu7ck
PpRdvg//ZDHxyEIKESQv9rDAS+x4kwaqyUuj3zy8uLFcrhebgKTBjJbHPg07jdI4
gmjrco+YL+i7duaOKoZdgrwDf6Fux5p4iQl+fpdYaTBIFetWbnVAShfIKxQh0NlE
FFjyPcivCuROJC78Hv+70wo4DYnYinXy2eV2pXqpQPzDz7lDxI22Q/jNjogqNK7J
ekMS2EbauSfLtwmXzg8Iwbb0vPar/yDZkFbhvFh8QI5vdA6ALt7yAaNT14aRAFZO
dqd0VYF+EHPdKHO33Yk/JxdW7JB+fZz4Xptmm29Ck2pzeZiCtOsUDef3/r8Nb10Y
oeos+QzjIdnJ+3q2eyjFxBQeP+s4gabcblYZjKyxBEdz87xjcHa4urWSyaorvCcF
U/WvRZTq3UBZcRKgsEFAS4ZVzNmSI0gOeiWxYXFLyE0mE9NRoevZEz2BHrWSv68J
XvDTWfqtTTJEbmbc6HZlAVKsMJzKb9cWUvzxajgNXq7b0YzJh6SpOo1q6ktaHFAA
0aoFPTynjWbGmOtfx4WBctVddqY1IXyQLqKJQ4QXVRVFxtGtpLTZWooVSfAIyXDz
UgkGEBFTlYfXYfoFqswMVe2ZxSNC8o2BRiwWRY0+RqREhoo4EFptxfgKp3FNDcjg
Nwzfwmio4rniSmXei/Sd5ukgx3GogKUnTDN52FUlzUcR/jiUH7I=
=CzXm
-----END PGP SIGNATURE-----

--t9cFUCglzotSEI4q--
