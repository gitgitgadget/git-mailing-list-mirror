Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540CCC433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 13:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbiBQNFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:05:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbiBQNEy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 08:04:54 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A652AE299
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:04:36 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CE89032009C3;
        Thu, 17 Feb 2022 08:04:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 17 Feb 2022 08:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=e7DUM/Ff9ckc4P2LFxV82gO8XksDoCQb6zRdKr
        ob0Y8=; b=npVw1Ksn6o3KDfHjh87/TTidYO7cGrUTJbtKsqGe+mOE+hnuTA3B/2
        kelbO57ADgZtuXzs9A1WSxKoiHvoZzgPLwsuBrI/1DLbhYk6h78TSck8Xpg/jcrh
        XXvtY7svfnj7csFaapEy/PIfW9YO9A4SbW1daFJAvqgS+MiywSpGa8kaUC1fZjLm
        /AJ8Zeb4LHxbJq/w4chXWB9XCTYc4IuGGGNhB0AccZ9rbprryglo7uMGxHYuiJHL
        yWstWQoGpzWgCYrxpwD6eEtZv4GcRv9MCS5dwY1NeUhXwU7N9vIB9lYiNDWdht77
        j5QThQXCmQvJFJGP4aT5KCZdxwFbzXnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=e7DUM/Ff9ckc4P2LF
        xV82gO8XksDoCQb6zRdKrob0Y8=; b=hcffq5IBbznr3cCyR3jqvknaOvM6e2R7X
        ig7FeRMdpWqEiYmcDlL2ZlZOeNxzh2mZFSzw0+s70CVpxmsZ3dgf0EiHG6D7NQ3W
        DUlOylK6a3kS3Onjc4jAPg9N703vg9oY0jMQMGOuUhFZRn3/zbNIxaUYiZjfJSMf
        dnrV+ZMnjcLQfLDeab1T0miMU0op015B0Vk1zqOuy+QxKAFVjaZ5mEBF1AIur1mi
        lBf1mzZXQ9lWtagQmecFCfoyeqim/TgDrCoJOa3KGwiQ/e8qOX7QlFh3bLXsN/25
        MQ2TpRKavACAQIA/gfSekU9q+RGLkTQyVcwUky3L1KCMEgjsnXNTg==
X-ME-Sender: <xms:40cOYhx-niuTwRBmZulP5RSBNZUfpk45-fiv7uBxKxk5PaDj_DVMhg>
    <xme:40cOYhT2jslpWi9TRi_8i67GDTnnhL9q88r5BX3pu4j5JbT5Pn1jFez5bSt48nKyR
    yKmrsPI4oREeLYYQw>
X-ME-Received: <xmr:40cOYrUWxWyKQT2NnQCyR43stJSery0_cbLr1LCpAnOzsxfMM3iO2ypY1Li01l6g0Kzk-du6DF6FVIxEmt5M46d_lmHgJem-NYCXhpPSlJH8UyXex_HG8Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:40cOYji1EIzNAa2gvaLWK5OXs93jVTxI6U8bLPasvQI8IyppgEGbAA>
    <xmx:40cOYjA90YEH-o7oFwUVgw3xAVIl28KhgAwZsVXsqFXFCZLHkyAN0w>
    <xmx:40cOYsLJNswygzPBSV-Wi8TZ4TW9Cyjl3VTPhf8SC_-wrVSnMTtFXA>
    <xmx:40cOYmPAtBWbVMFwPwKDwkHo0hWe7-DR9TBQKGQAXc47EVnFMG-o0g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 08:04:34 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 78831698 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Feb 2022 13:04:33 +0000 (UTC)
Date:   Thu, 17 Feb 2022 14:04:32 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 5/7] refs: add interface to iterate over queued
 transactional updates
Message-ID: <fac2e3555a4ce976252697e7898e125b5e521bdf.1645102965.git.ps@pks.im>
References: <cover.1645102965.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RpYpvLhytB7XfLED"
Content-Disposition: inline
In-Reply-To: <cover.1645102965.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RpYpvLhytB7XfLED
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


--RpYpvLhytB7XfLED
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIOR98ACgkQVbJhu7ck
PpS9WA//VNEAUwfUTbqfKLh5YMY4ryfOf/262X5RTkKPmPQvRFajasBL7DpNKqf5
ifPSsGIt7AHgYm0VD5FC19hkX+fu2Ze0CiwBZ44yYWwjzVwmj91/shVUeBChwH+7
SdJRhl+m8rwyxzM5a51N78tIYgzib1s3Rw2+8/n8dVvACt77LxfsffthkxAcrZ66
/vJBIwiGghVAhG44EkTDNy4imloU94Gupakrhl4AHGw2Jb7/yrq7tHQA2D3E/BWE
hd9unw4g+Pvk0nj64u0EYJyMbm/8CoY58+HZjrMNm3Qc8swNIgEudVCXpnPrJD42
QTAatOBzTKRHTo8bhUsOOys1W0RbJH1POQNIfcs+FizdEB+Q+IwQTwyP0OTSzV4w
tJZ+hcbfVN0S/BcuTF8mzhfDTt943OIlojw+mb96ErHgAok3ZetFd8bMhNSuITf4
KvCXtc83tSiNVwr0bpC31r3ixvRqdwzu9qczxdN1amwQAo7o0ZDwOmQcymL9ZTfJ
BNKn9P14sYDpN+SmVxBJsdM2yRtPNfyKxv/6RAXm8AUKYE5lIY/HllnRjM6Wv3nt
RSAJ57MbPp2lSX5WlZrOxJv5DgTs08OkkQTu/nJRmNqx99InKmIisVccchyHAalT
wW6gKACqvTWLpENDIyazBFjWpiTCTwhaYuJ0kGaeX4lT8uIH+Eg=
=0/qW
-----END PGP SIGNATURE-----

--RpYpvLhytB7XfLED--
