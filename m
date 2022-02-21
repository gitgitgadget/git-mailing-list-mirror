Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA25BC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 08:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346753AbiBUIDD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 03:03:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346770AbiBUICx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 03:02:53 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF75B7DD
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 00:02:30 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C94CA5C01BB;
        Mon, 21 Feb 2022 03:02:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 21 Feb 2022 03:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=V4tjAGBbHvpLW7pnlVDcdjMx04NRXmr1D98T/F
        ietXU=; b=CoEYWlmUHEjQdcMqdWB1GDiTE1j63lpiTREychvSlVp/FW+WngcX5+
        8Kn0QqrwsCwFjELoP3tRto+74XXu9G6xj38ps0PapBRo7JVNzVUi5nYX94p/6Ygo
        VugcfLr5edi7+5S3Jgdro7E4QcvYkHmohe+lDfuKpN/avT3xxdW/apYIq1Bo+9Pf
        vZlo4lrZHerFrnyDdRUDoPuIvlFyA7ul6WqmRJ/pag36LKs1JE8++tU4dlQTKyno
        kNCPppsVXG4vLBPKaKSuQHwiIsVDX9zuYE/RkwMqOZSB2GaBc3nXb4ulDe/uCzZJ
        K8njUg4zW/EM0SHG8iUSRu7e+XFYPldw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=V4tjAGBbHvpLW7pnl
        VDcdjMx04NRXmr1D98T/FietXU=; b=PqRoGxeWQmqT8WyNCabJ0InNUhVDfwbI6
        ZNVueSdRtjmNBw2VBy7hWX/2/ebDx9ztNkbkw7qiwWOdLyTemB7ShXeMBM+pTaeN
        DniIWPHUP30R4Ebg34Nm+Dr5zJ7LS/z6DId2J2e/yY6ug9oo6PaVqk6ltFNjyNPg
        S+34lHmvzaJDsqRlPJACkbzuLbQXNp0phJX4/B6sy0DrVrQggnTqmgEqEkoaL01/
        mbDp9pEV05tXSwWHvAiNMaZ0vGWNPu7rmN0Dwh8BYqUU1TfENlvv7fqLd4l4gBGi
        yNNLsOr8hKKx+5KfZIWttXNXdSoH63ASzzgaVbiNWcTVOvfsH3xBA==
X-ME-Sender: <xms:FUcTYvUL9g6Wjdo8N9YB3jBUymBrQ9-GJlh4Xfj0nXxBt9xtAXaBgA>
    <xme:FUcTYnlRUzGPOtiY-Fm32LF767l2ZyGUO922B3V1Pl_yfuwjf8JTs44UuDGof176O
    7f8yGcQjws_BOiW9Q>
X-ME-Received: <xmr:FUcTYra-mNwkSMpcWgO8dzL-auVnkdJmiQHBrHlEcu76iillYMWgabnG9StTIarMor8brhdtmZ2nyrewtx0QTBBW-ELISHnbjMZORo9bz7LLThyuZgYTEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeehgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:FUcTYqUjDBGxNdJ86gaXEyKTCYrqfj-zpPdE12udEYu7hAR5234t8Q>
    <xmx:FUcTYpkvkVhfIJeFWs3Mn-xZ-xZQyIf-OXoWv5mXvvvXNEn0xxM0VA>
    <xmx:FUcTYndWhzaEFHVVW-w8q8EevVaWqblVQrp2g5vRXy2hQiIl5pO08A>
    <xmx:FUcTYvhzAWQvvLQOTgOtoTrRJaKhWw_Sov9GOdZ8d7Jq_m4wTGnzqA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 03:02:28 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a12ce5fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 21 Feb 2022 08:02:27 +0000 (UTC)
Date:   Mon, 21 Feb 2022 09:02:26 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/7] refs: add interface to iterate over queued
 transactional updates
Message-ID: <0316d770e9590641a942370c84e4d8a42df2ffcd.1645430423.git.ps@pks.im>
References: <cover.1645102965.git.ps@pks.im>
 <cover.1645430423.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TFMq/h6FsriGYWkY"
Content-Disposition: inline
In-Reply-To: <cover.1645430423.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TFMq/h6FsriGYWkY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There is no way for a caller to see whether a reference update has
already been queued up for a given reference transaction. There are
multiple alternatives to provide this functionality:

    - We may add a function that simply tells us whether a specific
      reference has already been queued. If implemented naively then
      this would potentially be quadratic in runtime behaviour if this
      question is asked repeatedly because we have to iterate over all
      references every time. The alternative would be to add a hashmap
      of all queued reference updates to speed up the lookup, but this
      adds overhead to all callers.

    - We may add a flag to `ref_transaction_add_update()` that causes it
      to skip duplicates, but this has the same runtime concerns as the
      first alternative.

    - We may add an interface which lets callers collect all updates
      which have already been queued such that he can avoid re-adding
      them. This is the most flexible approach and puts the burden on
      the caller, but also allows us to not impact any of the existing
      callsites which don't need this information.

This commit implements the last approach: it allows us to compute the
map of already-queued updates once up front such that we can then skip
all subsequent references which are already part of this map.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 16 ++++++++++++++++
 refs.h | 14 ++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/refs.c b/refs.c
index d680de3bc0..35d4e69687 100644
--- a/refs.c
+++ b/refs.c
@@ -2417,6 +2417,22 @@ int initial_ref_transaction_commit(struct ref_transa=
ction *transaction,
 	return refs->be->initial_transaction_commit(refs, transaction, err);
 }
=20
+void ref_transaction_for_each_queued_update(struct ref_transaction *transa=
ction,
+					    ref_transaction_for_each_queued_update_fn cb,
+					    void *cb_data)
+{
+	int i;
+
+	for (i =3D 0; i < transaction->nr; i++) {
+		struct ref_update *update =3D transaction->updates[i];
+
+		cb(update->refname,
+		   (update->flags & REF_HAVE_OLD) ? &update->old_oid : NULL,
+		   (update->flags & REF_HAVE_NEW) ? &update->new_oid : NULL,
+		   cb_data);
+	}
+}
+
 int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 		     struct string_list *refnames, unsigned int flags)
 {
diff --git a/refs.h b/refs.h
index ff859d5951..1ae12c410a 100644
--- a/refs.h
+++ b/refs.h
@@ -776,6 +776,20 @@ int ref_transaction_abort(struct ref_transaction *tran=
saction,
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err);
=20
+/*
+ * Execute the given callback function for each of the reference updates w=
hich
+ * have been queued in the given transaction. `old_oid` and `new_oid` may =
be
+ * `NULL` pointers depending on whether the update has these object IDs se=
t or
+ * not.
+ */
+typedef void ref_transaction_for_each_queued_update_fn(const char *refname,
+						       const struct object_id *old_oid,
+						       const struct object_id *new_oid,
+						       void *cb_data);
+void ref_transaction_for_each_queued_update(struct ref_transaction *transa=
ction,
+					    ref_transaction_for_each_queued_update_fn cb,
+					    void *cb_data);
+
 /*
  * Free `*transaction` and all associated data.
  */
--=20
2.35.1


--TFMq/h6FsriGYWkY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmITRxEACgkQVbJhu7ck
PpShsw//TSX+44kxU0wOPVUimjUPJAffQGKX2U//mka99BLJROhi/Nr4+B6EdfxL
odeKLzX4xEv4Awuidpp/hxLiG94xoNPrYIJPSO1EDHcJJyuvJeRt5cOnbIetkx6K
0cRgTnfz+Udrr5G3YcnTThT29J77TzukaLCkylXQhtCeFFASSpX5CVi8hbylDdQV
0njwWhR2QgdRIRPh5wB/WOqbkC7AfnNpiQknGBeJS0muj2tBck3egqyFZR6vAWST
oVQQxLN4/ggkLp7EcwqOUQI37PFyXRwNPu0xyaNOK1EGKmtBmvckdFx51fUs8CJ3
YgddIusBMAzURbxziBrGm94B0IQ+Zc8XiOkS9tsKtEx5+DFOFVwJPHLHlLXiSSsV
ED74/tGfTjs0r/mCjIe8e7MrW9LZBxJfmvV4/sv5sdCLrUBE+y4yC6VdaVDcEF5y
e22zXriI667KW3bJGRfpe2LHHKb0/F87ug8LWnMxskNPz8TuTpeAtLhtR98RYlhM
kqf69HXGj3Hvx4iIuuNFBECQSs3y3GUtEN7hB63UHULUGaDpXdiNATEZCMWZWh4w
R1gl0astEoWgy/dGM3CQyuEJg7CNh0EQBnXgu8RxmOI54GvpXw+6+2fE+abvdx+i
U433ZUnkIduFUV5Z2Zb/6OpSMyhG9cVxEKKeVU58Y2aIVLRyHew=
=qdCu
-----END PGP SIGNATURE-----

--TFMq/h6FsriGYWkY--
