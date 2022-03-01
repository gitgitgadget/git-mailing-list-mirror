Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE30CC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 09:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiCAJfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiCAJex (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 04:34:53 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0DE5DA78
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 01:34:00 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 18BCB5C0145;
        Tue,  1 Mar 2022 04:33:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 01 Mar 2022 04:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=6peoBySk0X0zZGaI1WUxEctTky5N6/+PBxulkD
        R1fVM=; b=fec+ZOf73PeVx9SXTrjOd2coiyJFkd1NXRIv9gFf314QgAnybehDr2
        zKzjqwaT0z6toxe+RRra/YJiEpnWW1XRezyhppsgq7+9X1JZb0q94tcIicFejtUY
        gP9TFcPvZtod9OIght5ywSFu0Ta3KrRJh6NvwmGzSvee5qFMCx1DGPpj3lVSZI4Z
        TUb9uughnjYIpeyLwPInxijDxg34ZrY6vC8k3A3WfmHcxQhwjfcUYW2v9bLQ9laB
        H6Euf1ctlUnVA4YalihRlwt5tKS4oENgaq5AJbkNFdYqdhxUI9hqQiNnWUUsKbf1
        zdSGFllG4kGIE8miGdnJOrcghcSVhqPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6peoBySk0X0zZGaI1
        WUxEctTky5N6/+PBxulkDR1fVM=; b=Jpyp0Bvl0+2sD1Dw/C7pFuFkJnMaOt9BU
        DBVOvLckb8sj/i6ycUQfAsMZGFPqC0DOs5DH+bxBnXfyA+xJKIlNzXE5rzuiYbJy
        N51hWGqtU9Y4hEerrv2kuJRe7uizaYEXMiInVbT4aCJSQy8jdtxDJ63EPlGVUgL6
        872bcKtVtUiSYmq+NRtks9VnLmoABuyvO0rIvHHFQfstGIz+xDfDdRKa3hC26F3X
        fuu/yiF4WITZTBq6P9HDSoRnK2UFZkn3PCA8pDi7DlqXXUn97HbsWDZjgC5bp+Eq
        cpE7IS0aUAUVveTiZXv1dbfqCcPuenEwZans4ZDJhYYPjWqzRTuDA==
X-ME-Sender: <xms:hOgdYlNvL3qR0pWv86d__h494em5Kjc5HaQIOg63cbVAMvhSxCjEig>
    <xme:hOgdYn8UsYaPYEb_STpAU5JYp4xP5LnVDNrQjUjVVZep-H9TdGkhn0JESvWRhNj64
    OTzYzx7aj_l9Z7dGA>
X-ME-Received: <xmr:hOgdYkQsRHBNzEdaWXVlXf1l7p21alxIZFhAptzH4qBZNfBKAwmCONHxn6OzzZFEDgXKlyF7GXMQF8Ysccgh7Q6iF8tBxtdooo76Y4ZYA2KSNTbzHVsn5wBt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtvddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:hOgdYhtdXxhaRy2__vsQ5df6as-em3Lb2hdNEnPXeyqrBIvUj_DYIg>
    <xmx:hOgdYteqaIn9XNC4uoTM-p-PFrdstSxPRDq5U-pWJvds70x6WlVLUA>
    <xmx:hOgdYt2DKPyhl4EKuQOZWcIMjDdpRlGdrv3B-h1XxYJhcDys3tufUw>
    <xmx:hegdYtkNaZpSGN-0YmeWEaRv7SVE8BTkOSQzGoFKGcLmuKlysGoj7w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Mar 2022 04:33:56 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2a21fc06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Mar 2022 09:33:55 +0000 (UTC)
Date:   Tue, 1 Mar 2022 10:33:54 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v2 5/5] refs/files-backend: optimize reading of symbolic refs
Message-ID: <b6eca63d3b9d9ff60778d6dabe13e4d087f2ff63.1646127015.git.ps@pks.im>
References: <cover.1645619224.git.ps@pks.im>
 <cover.1646127015.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jSkBbGPWum49NfSC"
Content-Disposition: inline
In-Reply-To: <cover.1646127015.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jSkBbGPWum49NfSC
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
executes a mirror-fetch in a repository with about 2 million references
via `git fetch --prune --no-write-fetch-head +refs/*:refs/*`:

    Benchmark 1: HEAD~
      Time (mean =C2=B1 =CF=83):     68.372 s =C2=B1  2.344 s    [User: 65.=
629 s, System: 8.786 s]
      Range (min =E2=80=A6 max):   65.745 s =E2=80=A6 70.246 s    3 runs

    Benchmark 2: HEAD
      Time (mean =C2=B1 =CF=83):     60.259 s =C2=B1  0.343 s    [User: 61.=
019 s, System: 7.245 s]
      Range (min =E2=80=A6 max):   60.003 s =E2=80=A6 60.649 s    3 runs

    Summary
      'HEAD' ran
        1.13 =C2=B1 0.04 times faster than 'HEAD~'

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


--jSkBbGPWum49NfSC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmId6IEACgkQVbJhu7ck
PpTEAQ/+IUli2Sx/ZnH0pn4Wg2kLxCilyUAUkn16ibEBLu8LEvW73VZdyvbwAc/d
oTcHeB29Z/CKHbrq9pZJirbRSSwDMnX9Xv0OTuw+HRGB3l8lGrLADYVYpFvEBmEx
FcK1uJclWKpZd8Av8u3JxmM21802A9PxylpVWGmt7vmT/mnGBVUkvegf0VCcs6gj
GNeQFQSRRu+NBcVzbYpzI/uUxBIJxM+AxXid6mIEPzmc4PD5s2zITkCBM9vqi654
OMms4nin81d2dVhEh1RIOWR1qLFQZZW9rgGUxyS1pXsNlt8dDlN41eKZP+x+ECLL
omgJ2t+ehAy/Mj4MWLA1DriSB/nYdgJEHO0KmtIth528Jmvo1oJKlWQEp56nUrv1
QdvkUAyJTM5ngaQG1rDL/ej7XbFqSXHbxj55Hhkkw1OWgPLClR1sWiMMGF5LE7kR
d723gibBcaD0/zsdDNK3/RQYKIegUeSf4VuS1v27Xz/xhEanDRTqEDxyl8iQeIwI
HMWqqlAlXf5qeTqCecH6jsQWWfjDaboCP3yZjzdd3aLEST4jpEpJIY4v13EFctbH
0W8KU96yXrpav+VjFWnpOOe0jFO6qSmRqE6J5qD3Jj24tqdGOFNOKFKfHedeaGVn
Zyr9bpHhfVwl97ScoVdJVXzRBTGRjcUxy0s0/0N6YIXK8jMfOM8=
=dB3Q
-----END PGP SIGNATURE-----

--jSkBbGPWum49NfSC--
