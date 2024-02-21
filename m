Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1DC69947
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519057; cv=none; b=bzyUaS2aTl8Fyyj1hi3679xaSfbGC8FX8ivMHTn5pMLFZYq4rme/YlEAq1LgSrfl1T4LHb2d9S3Nc+n6DfmNl1c9h9gsBr7K5QHOJTFqJAe4fzV/Zq2xAHtFfh7uW4NKfM5a/tcrwFi327bhJ7Vtg3lWe3uEAEbBRYpRWhzFLAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519057; c=relaxed/simple;
	bh=okYtYAbgBLlkLmVEe2+Z9pp8vWU1anEylZyzACzWfJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liysc8sZtIJE2b5QHLRRIDXPvkV+il/ncLGe3xPWjZgTANkwqy1PE4o4uD2DNyPHMHY49Qkiaf5b1qX8MHGZ8K7Sfcq5mX+beJZXXHdu/ecTSyXfxejqINEV3DsTGMi7vrilvg7X19TopkfD9Te78TW8wLdx4krMYwmuAD3HHyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KdGokoUp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PTcjaiNg; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KdGokoUp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PTcjaiNg"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 2D0EE1C000AE;
	Wed, 21 Feb 2024 07:37:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 21 Feb 2024 07:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708519054; x=1708605454; bh=Fo97+boAoi
	QbImf025d24pB3dPBErJSufOCHbJKWcXw=; b=KdGokoUpMEaKRgNE7ahoijVkZH
	DKLXVXLa4yDI0aSRlbECQZ1u/B+bieHiFnGZwMioHMjDe31jkvAeSy2kub0gIg+O
	raDE2NT8BaNhxHexVoamx15FxENOV4hYkligsDPLcOywAvJ7juyjAuK7JfVhQDXR
	46oPydURryyStl4pZ0nazitRVnWxdecil14pm3gckJF4nL5LILfSLa8JKNe6tXk3
	k+Wq90K3t5+DJOMGOvG8UOSbFxlchECvR8AWz7dz4FA51a29VlFUt2ZQEO+tgV3N
	Wv7mpJ8+27BdEUDqd5rLqwHqKVXdKOOIqVKDY3ZLyo8fwf//mTAy7LJ0T29w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708519054; x=1708605454; bh=Fo97+boAoiQbImf025d24pB3dPBE
	rJSufOCHbJKWcXw=; b=PTcjaiNgF90QNDxmdgnuVDayncHH+eEg7lhTJE1wYTab
	tnR73E47hevWGf7j0XXKk84tkTxai91gqm4K4f/a+7aWCWxVPjYYxi4E41DzEzD8
	CLpHypNS46PpGfcRaTvAykydB3SAmtJeJ/RXMFJHiZwTECkR/WI2TBEj+mKpf9fg
	VUYg95137PphDP7o1rdC/V3cBHXamQI/7+DNVmkonHsWye8gIT7CAcqiPAzo5MZs
	hFBPdBo6398wXCdY7B3LnMoF72fVxCDMLpLKW/jNsf4BgYJa29Hb9+DbwW2d/l/0
	4nJLPa1FsNwyEjKh/SLSJkBar5XupPfuh7h1ENJdLQ==
X-ME-Sender: <xms:ju7VZQqD3ITrvyGJAtncVoDRqVYNFjLcrvbtq5NTkfMXhBXubs3yJA>
    <xme:ju7VZWrjzHBpmINUtzj7EJGRMdKIttL1sX14Ab6tiTz_y3dg5SQjaA2jL-ErLYVPC
    KWIgvceSJywtBSjjQ>
X-ME-Received: <xmr:ju7VZVNopqSLyDnc8-RQwC2UYt7LhUeW_F_O9Hqb2gujm_3QBVY8ELvvIH4FyL2e7zYtgf8m7tSvMpJIIOh-NqZJLx5uPMu4kt5N4Yr_NO0C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ju7VZX5p_AfaTZTVq3cuOz1-1TyAna-DIrYIXw-dEnfsLqWjeGJCCQ>
    <xmx:ju7VZf7iq-3YePPCT_unBsCo38dAZRclUx_5iBSoHlloArT287HVdA>
    <xmx:ju7VZXh2LqcKEC1NTAcfjYXXIVxcA91Y_h-BRoPeJr5frvNhbFCQpQ>
    <xmx:ju7VZfERpbI30g_XSMUxQL8eLve6O6E69ehRqu78POaCwR_HYx1O3hYumHo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 07:37:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 30457aca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 12:33:29 +0000 (UTC)
Date: Wed, 21 Feb 2024 13:37:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/8] refs/files: sort merged worktree and common reflogs
Message-ID: <0b52f6c4afea258133b4553e8c40fffe2143e6c6.1708518982.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
 <cover.1708518982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pHrbWWfzKkTUG3q9"
Content-Disposition: inline
In-Reply-To: <cover.1708518982.git.ps@pks.im>


--pHrbWWfzKkTUG3q9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When iterating through reflogs in a worktree we create a merged iterator
that merges reflogs from both refdbs. The resulting refs are ordered so
that instead we first return all worktree reflogs before we return all
common refs.

This is the only remaining case where a ref iterator returns entries in
a non-lexicographic order. The result would look something like the
following (listed with a command we introduce in a subsequent commit):

```
$ git reflog list
HEAD
refs/worktree/per-worktree
refs/heads/main
refs/heads/wt
```

So we first print the per-worktree reflogs in lexicographic order, then
the common reflogs in lexicographic order. This is confusing and not
consistent with how we print per-worktree refs, which are exclusively
sorted lexicographically.

Sort reflogs lexicographically in the same way as we sort normal refs.
As this is already implemented properly by the "reftable" backend via a
separate selection function, we simply pull out that logic and reuse it
for the "files" backend. As logs are properly sorted now, mark the
merged reflog iterator as sorted.

Tests will be added in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c    | 30 ++------------------------
 refs/iterator.c         | 43 +++++++++++++++++++++++++++++++++++++
 refs/refs-internal.h    |  9 ++++++++
 refs/reftable-backend.c | 47 ++---------------------------------------
 4 files changed, 56 insertions(+), 73 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2ffc63185f..551cafdf76 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2210,32 +2210,6 @@ static struct ref_iterator *reflog_iterator_begin(st=
ruct ref_store *ref_store,
 	return ref_iterator;
 }
=20
-static enum iterator_selection reflog_iterator_select(
-	struct ref_iterator *iter_worktree,
-	struct ref_iterator *iter_common,
-	void *cb_data UNUSED)
-{
-	if (iter_worktree) {
-		/*
-		 * We're a bit loose here. We probably should ignore
-		 * common refs if they are accidentally added as
-		 * per-worktree refs.
-		 */
-		return ITER_SELECT_0;
-	} else if (iter_common) {
-		if (parse_worktree_ref(iter_common->refname, NULL, NULL,
-				       NULL) =3D=3D REF_WORKTREE_SHARED)
-			return ITER_SELECT_1;
-
-		/*
-		 * The main ref store may contain main worktree's
-		 * per-worktree refs, which should be ignored
-		 */
-		return ITER_SKIP_1;
-	} else
-		return ITER_DONE;
-}
-
 static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *=
ref_store)
 {
 	struct files_ref_store *refs =3D
@@ -2246,9 +2220,9 @@ static struct ref_iterator *files_reflog_iterator_beg=
in(struct ref_store *ref_st
 		return reflog_iterator_begin(ref_store, refs->gitcommondir);
 	} else {
 		return merge_ref_iterator_begin(
-			0, reflog_iterator_begin(ref_store, refs->base.gitdir),
+			1, reflog_iterator_begin(ref_store, refs->base.gitdir),
 			reflog_iterator_begin(ref_store, refs->gitcommondir),
-			reflog_iterator_select, refs);
+			ref_iterator_select, refs);
 	}
 }
=20
diff --git a/refs/iterator.c b/refs/iterator.c
index 6b680f610e..b7ab5dc92f 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -98,6 +98,49 @@ struct merge_ref_iterator {
 	struct ref_iterator **current;
 };
=20
+enum iterator_selection ref_iterator_select(struct ref_iterator *iter_work=
tree,
+					    struct ref_iterator *iter_common,
+					    void *cb_data UNUSED)
+{
+	if (iter_worktree && !iter_common) {
+		/*
+		 * Return the worktree ref if there are no more common refs.
+		 */
+		return ITER_SELECT_0;
+	} else if (iter_common) {
+		/*
+		 * In case we have pending worktree and common refs we need to
+		 * yield them based on their lexicographical order. Worktree
+		 * refs that have the same name as common refs shadow the
+		 * latter.
+		 */
+		if (iter_worktree) {
+			int cmp =3D strcmp(iter_worktree->refname,
+					 iter_common->refname);
+			if (cmp < 0)
+				return ITER_SELECT_0;
+			else if (!cmp)
+				return ITER_SELECT_0_SKIP_1;
+		}
+
+		 /*
+		  * We now know that the lexicographically-next ref is a common
+		  * ref. When the common ref is a shared one we return it.
+		  */
+		if (parse_worktree_ref(iter_common->refname, NULL, NULL,
+				       NULL) =3D=3D REF_WORKTREE_SHARED)
+			return ITER_SELECT_1;
+
+		/*
+		 * Otherwise, if the common ref is a per-worktree ref we skip
+		 * it because it would belong to the main worktree, not ours.
+		 */
+		return ITER_SKIP_1;
+	} else {
+		return ITER_DONE;
+	}
+}
+
 static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 {
 	struct merge_ref_iterator *iter =3D
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 83e0f0bba3..51f612e122 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -386,6 +386,15 @@ typedef enum iterator_selection ref_iterator_select_fn(
 		struct ref_iterator *iter0, struct ref_iterator *iter1,
 		void *cb_data);
=20
+/*
+ * An implementation of ref_iterator_select_fn that merges worktree and co=
mmon
+ * refs. Per-worktree refs from the common iterator are ignored, worktree =
refs
+ * override common refs. Refs are selected lexicographically.
+ */
+enum iterator_selection ref_iterator_select(struct ref_iterator *iter_work=
tree,
+					    struct ref_iterator *iter_common,
+					    void *cb_data);
+
 /*
  * Iterate over the entries from iter0 and iter1, with the values
  * interleaved as directed by the select function. The iterator takes
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index a14f2ad7f4..68d32a9101 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -504,49 +504,6 @@ static struct reftable_ref_iterator *ref_iterator_for_=
stack(struct reftable_ref_
 	return iter;
 }
=20
-static enum iterator_selection iterator_select(struct ref_iterator *iter_w=
orktree,
-					       struct ref_iterator *iter_common,
-					       void *cb_data UNUSED)
-{
-	if (iter_worktree && !iter_common) {
-		/*
-		 * Return the worktree ref if there are no more common refs.
-		 */
-		return ITER_SELECT_0;
-	} else if (iter_common) {
-		/*
-		 * In case we have pending worktree and common refs we need to
-		 * yield them based on their lexicographical order. Worktree
-		 * refs that have the same name as common refs shadow the
-		 * latter.
-		 */
-		if (iter_worktree) {
-			int cmp =3D strcmp(iter_worktree->refname,
-					 iter_common->refname);
-			if (cmp < 0)
-				return ITER_SELECT_0;
-			else if (!cmp)
-				return ITER_SELECT_0_SKIP_1;
-		}
-
-		 /*
-		  * We now know that the lexicographically-next ref is a common
-		  * ref. When the common ref is a shared one we return it.
-		  */
-		if (parse_worktree_ref(iter_common->refname, NULL, NULL,
-				       NULL) =3D=3D REF_WORKTREE_SHARED)
-			return ITER_SELECT_1;
-
-		/*
-		 * Otherwise, if the common ref is a per-worktree ref we skip
-		 * it because it would belong to the main worktree, not ours.
-		 */
-		return ITER_SKIP_1;
-	} else {
-		return ITER_DONE;
-	}
-}
-
 static struct ref_iterator *reftable_be_iterator_begin(struct ref_store *r=
ef_store,
 						       const char *prefix,
 						       const char **exclude_patterns,
@@ -576,7 +533,7 @@ static struct ref_iterator *reftable_be_iterator_begin(=
struct ref_store *ref_sto
 	 */
 	worktree_iter =3D ref_iterator_for_stack(refs, refs->worktree_stack, pref=
ix, flags);
 	return merge_ref_iterator_begin(1, &worktree_iter->base, &main_iter->base,
-					iterator_select, NULL);
+					ref_iterator_select, NULL);
 }
=20
 static int reftable_be_read_raw_ref(struct ref_store *ref_store,
@@ -1759,7 +1716,7 @@ static struct ref_iterator *reftable_be_reflog_iterat=
or_begin(struct ref_store *
 	worktree_iter =3D reflog_iterator_for_stack(refs, refs->worktree_stack);
=20
 	return merge_ref_iterator_begin(1, &worktree_iter->base, &main_iter->base,
-					iterator_select, NULL);
+					ref_iterator_select, NULL);
 }
=20
 static int yield_log_record(struct reftable_log_record *log,
--=20
2.44.0-rc1


--pHrbWWfzKkTUG3q9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXV7ooACgkQVbJhu7ck
PpRFMQ//fHmFVnshMGF6IBVI0g0/cxjvDG/X9zwnvz27tRp7ZgkDA/0r/4fQ5ojb
ZYv43YsHeOwRCOyu398kv9ZMjFzzZ5XVQq6Nnq4obQdFwQ97EeAfR+qblIraZtpu
zw8GmVc/sZekzc7Nvp7Ssevw3yf95w1Z5VN2b5A3DjYa/DSRA8gL4M+DYUYVxWOD
G8SCLzxljb8YSFSsFlX5od56zYzWObc8tmlQrKSgYQOpxIQtSrkizTYFSGbhn0YQ
TtKhTMBAEpuCwokR1DqkizISWnT3irnDe2SY/xVTuz3UL34MJFn/D1fwPs3wHoLe
tu+ZSV9GPSoRlfW60E3ywhwZvFtqubjzDjfrmPLE8/TvVNhVz3GIExfpvTIHUbjj
+UgfBWXCtokzIWTSVinptPS6ExXzT2llwPi+cNcqjTbXRjuHWyOMGB214CxFH6Yq
N31ER7mGXgWZdOHxHunT2cDjeYlZiHYpfgQyaBLxtUElP69w4sTncfw9rqns2RiY
8VqEkINPcMAj5n/H/VQ/h9sDSOFMUfBD8VosFjzHBcmcLgKZ8QAPJodFRM+q5uZR
S4nv5+zWKfZsuW2y5q7A1UvG9NfwB5MOqHgGTw10Cf96eXjGvdyG3SXL7UNvr/r1
aGbLslyfgVT2MHZgksPxZ19hVWkFqc+H4Pr3NekvHgjOqdn+DUA=
=/19T
-----END PGP SIGNATURE-----

--pHrbWWfzKkTUG3q9--
