Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D175FC433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 08:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbiAQIMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:12:32 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58469 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230177AbiAQIMc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Jan 2022 03:12:32 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CD4125C0117;
        Mon, 17 Jan 2022 03:12:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Jan 2022 03:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=11yE82MLGGvqOLPptgdf3wZI8GF
        18kBGn1LWOpIvjdQ=; b=SrUJU4qWIvbuuMESVqfHrXqiJ8kcgYx8ebOIRdzc55u
        /tTmqCAK52/P7Q9RvVUi49JtxnTrsYBTBkq3AtVmiIoF3hz+gbjFqN0P8bxghuzm
        NVyrrHSKljcyruBihnW3MGv2xML8XBR3KOJW1++fD+bLRMdJIHSqnBp5lgGfKr7B
        CPHQR1kMJXxlACDbmuxQH9cVmMm1luVfiN0ke5kMSuOoN47Y8YmrlHyOfmimYRGX
        7lI/wtRM1Wv4CHggHxJsm9HOk3GaB+tTdJXVZYP92n7pY2IPgopX6hVEiEaqHyRW
        WPLCmTN3daP0xlrxlV/AvNTREaUjg1WG9MsPUBUmiHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=11yE82
        MLGGvqOLPptgdf3wZI8GF18kBGn1LWOpIvjdQ=; b=n0mAHQdRftlWWCioK26mlh
        s4Yb7sD8deibkCtDXG5co/hFCiQK6Iv3jCL2cAqMw6s/AqX4xb+2fhLFz/3u3tPj
        iEYsFvCylzl31ZCw9ACWScHfsMF6bCkFTBWNee8We0B5iFeHYJKCtoHNLYuXWCDk
        cvNKq1agQuY/QGI7Mlrj+gbibrEgS4aoJ1nbNLA5AnrK23qaEfiayIKIGCmawWgN
        omPdkAfpmI5I83Z/saBgqeYO1GyMmEFIetww5+OQ7H8XMaMYtULLQ91g9LRM65he
        nKg7oGfGC5L1hHwzZrcDspl49z3WwMShmgNri0ve3izWYuB2NjkAIzbG6rIJzWwA
        ==
X-ME-Sender: <xms:7yTlYcuCpGcwmoDL_nEJ05APnbVGN3XubQmAuGdkKE0Ttb6iat36XQ>
    <xme:7yTlYZcuqNPG2rdEzPLvoBU1yKtcJJnUav8R_rIthKEnNjhgqvxPZSXKqtXk_NDcV
    kJlP4UK8OeMLqeDpA>
X-ME-Received: <xmr:7yTlYXzYCxXaIYkR4c-mhQrZgNer86mM8kIQTjryD5FhcVeCkHe-cNTorzaAGWBF83zYd-o-ZuGrMOMv_vjJ5APNVY_pVi4YNXpmpL-Dz0AUeNZqVlnm_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:7yTlYfMAvvmZO3ml1808vNnXX_YIyLo44QifjWidrWQkKpuJZGcSyw>
    <xmx:7yTlYc99COEkjmzwZQydA9cxptzGUIkM30BQm2rA5ZFfxlHrdqFCcQ>
    <xmx:7yTlYXUnYG_GtEV0wHTwR7s173ftW25ZIbHE-MlghpShI-VLqfwxuA>
    <xmx:7yTlYQafS_qfMc6povjdTuOKMu0C6mRaCbN9AkVkWNwNh0_vDv_r6A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jan 2022 03:12:30 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 641116e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 17 Jan 2022 08:12:28 +0000 (UTC)
Date:   Mon, 17 Jan 2022 09:12:27 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 0/6] refs: excessive hook execution with packed refs
Message-ID: <cover.1642406989.git.ps@pks.im>
References: <cover.1641556319.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oStT3ECbCIzMNKII"
Content-Disposition: inline
In-Reply-To: <cover.1641556319.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oStT3ECbCIzMNKII
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of this patch series, which addresses an
issue where the reference-transaction hook is being invoked twice when
deleting refs both in the packed-refs and loose-refs file.

The following things changed in comparison to v3:

    - Fixed a memory leak in `files_delete_refs()`.

    - Refactored the `packed_downcast()` invocation such that we don't
      have to mark its unused returned variable as used.

    - Removed a spurious whitespace change.

Patrick

Patrick Steinhardt (6):
  refs: extract packed_refs_delete_refs() to allow control of
    transaction
  refs: allow passing flags when beginning transactions
  refs: allow skipping the reference-transaction hook
  refs: demonstrate excessive execution of the reference-transaction
    hook
  refs: do not execute reference-transaction hook on packing refs
  refs: skip hooks when deleting uncovered packed refs

 refs.c                           | 11 +++++--
 refs.h                           |  8 ++++-
 refs/files-backend.c             | 26 ++++++++++++-----
 refs/packed-backend.c            | 28 +++++++++++++-----
 refs/packed-backend.h            |  7 +++++
 refs/refs-internal.h             |  1 +
 sequencer.c                      |  2 +-
 t/t1416-ref-transaction-hooks.sh | 50 ++++++++++++++++++++++++++++++++
 8 files changed, 114 insertions(+), 19 deletions(-)

Range-diff against v3:
1:  abbc28822b ! 1:  14775046e1 refs: extract packed_refs_delete_refs() to =
allow control of transaction
    @@ refs/files-backend.c: static int files_delete_refs(struct ref_store =
*ref_store,
     =20
      	packed_refs_unlock(refs->packed_ref_store);
     =20
    +@@ refs/files-backend.c: static int files_delete_refs(struct ref_store=
 *ref_store, const char *msg,
    + 			result |=3D error(_("could not remove reference %s"), refname);
    + 	}
    +=20
    ++	ref_transaction_free(transaction);
    + 	strbuf_release(&err);
    + 	return result;
    +=20
     @@ refs/files-backend.c: static int files_delete_refs(struct ref_store=
 *ref_store, const char *msg,
      	else
      		error(_("could not delete references: %s"), err.buf);
    @@ refs/packed-backend.c: static int packed_delete_refs(struct ref_stor=
e *ref_store
     +			    struct string_list *refnames,
     +			    unsigned int flags)
     +{
    -+	struct packed_ref_store *refs =3D
    -+		packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
     +	struct strbuf err =3D STRBUF_INIT;
     +	struct string_list_item *item;
     +	int ret;
     +
    -+	(void)(refs); /* We need the check above, but don't use the variable=
 */
    ++	/* Assert that the ref store refers to a packed backend. */
    ++	packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
     +
      	for_each_string_list_item(item, refnames) {
      		if (ref_transaction_delete(transaction, item->string, NULL,
      					   flags, msg, &err)) {
    -@@ refs/packed-backend.c: static int packed_delete_refs(struct ref_sto=
re *ref_store, const char *msg,
    - 	}
    -=20
    - 	ret =3D ref_transaction_commit(transaction, &err);
    --
    - 	if (ret) {
    - 		if (refnames->nr =3D=3D 1)
    - 			error(_("could not delete reference %s: %s"),
     @@ refs/packed-backend.c: static int packed_delete_refs(struct ref_sto=
re *ref_store, const char *msg,
      			error(_("could not delete references: %s"), err.buf);
      	}
2:  9dd172a757 =3D 2:  d4ac24c8b8 refs: allow passing flags when beginning =
transactions
3:  be826bae3b =3D 3:  f4a07fe9a8 refs: allow skipping the reference-transa=
ction hook
4:  662a6e6244 =3D 4:  a8981baef7 refs: demonstrate excessive execution of =
the reference-transaction hook
5:  d83f309b9c =3D 5:  23c344854e refs: do not execute reference-transactio=
n hook on packing refs
6:  279eadc41c =3D 6:  d6c7d765af refs: skip hooks when deleting uncovered =
packed refs
--=20
2.34.1


--oStT3ECbCIzMNKII
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHlJOoACgkQVbJhu7ck
PpS5KRAAqYqBfAetY04Gdd3Gi8VKiVp0vARMYJcusOV+bLW+vZLnmxFjSQ3GzSKY
1/MDQTPaUBOVU8N2rzyG+hJvwFC9OwuCmyoXcd85Sz224Q3s9K04oUqDv6QQHT1u
j1IFtKZ+KNNa746r40OwL6SrU2GjDBDNlRV8oHhWjjwtKSI3Xf8JCgINq29mFFZB
6VX8QBUb4S2nWtcLWtmUWAK/XHln1taO1tPTazdnDwBmIcjHdeqpzmb373UR9o7x
9gGrsZZZog+hYk7RrRtfRmajYWhBAafOrCuGwB0KwOVerBmV609Qka+CuvA22zKW
v8G7HNysZoXitZf0U6GBg1X+eGJiObkUs2j3yCM6CUegiU836cJs5H/LBN6wTNNF
Ukjj9f+VvRBwrKmq2UyRQTX+6KbJItgPzJIKtAA4G1Qpuc/iy5YF28JjEVtZVD2e
cwNMhsYcICkG5v4M3ckCsNaDjo35/SmnT3fCLq63NmsoMBomX8+KbcPnkBx18CR2
OKC4bqBIGriMmNGl0FeCg+V1p7unThbq7+P6vch+4mFsjM8ugSzRjrgXnDTJVGiW
doPBGvgVKOtWVPzB+zJr7J6dHm8HBv58Xdo2c0xq9aNNa0DNWJuk7xvEbjqeFQzW
Rn/pTD8EbSuJJGRjugAGbtlfma+VE+P5KpJ4cr4+PETbXde4T7M=
=ap67
-----END PGP SIGNATURE-----

--oStT3ECbCIzMNKII--
