Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ED120E02B
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367485; cv=none; b=jXmjhiPoHfQfCBpNhWDNZal1XhUaFtNx0ZpRgJxldMB+tdLPw/T6esnHMzPbIA0R3nyxtcnGtrLNAOif75vWZk0ZGAsg9TvjcHtXfOiVw4aAkYS2yd7qYLb3chys1Lawzm7lbBu24gmJsvGpjN3/q+ki4InJFafhcv1PnbjXOyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367485; c=relaxed/simple;
	bh=KzZfc3eupGdaCgu8IhgU0wTKwFN0zZpW2VhtYjGjgj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YzFnIQ/HixBflgLtCZhEOlWeGshsoMxiBt4gU8N7NB1FhK9oORomdSQpVGon3lTjx8MV2dW1TxT6Vh6P3QcMLVNr6V7285GGN6oqyCNKnPGP1fqnzCah3FDDdyWhTKkxy4VxyWY+tpJOl7fzZy3vkgx6h0xPJKuM6wwk+K741Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoIyVcKZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoIyVcKZ"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa670ffe302so812163566b.2
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 08:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734367480; x=1734972280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbLgtM6fZRugS/23dnDGKiBeriksEAzT/0GxzT9Q5yo=;
        b=IoIyVcKZBtAw8DxLkGLdjezgwSxReItCnr7gowiS5JPn8VUQ1EMws79gvM0370vTkK
         yx8eCQgrrf4UJXLToPZNk5IRz5iQuDZ6yoH3CYu6VJIcgcAijeSXC6uO5TQj/t+RxcRY
         XD49edR6Gmtdh0PlAKP/4aJqzVWgQO7x7ih+pjhv30+K8VLZgBAJBox3UOoOk6ejTR9c
         z4C3GOVnD7LUNA53QvZBb38XQeXoUAxU2csrIY5858UsX9VMUKg2Y9HXPRJ93qL8G1EZ
         k0OgRPJQk1laTfnxGzGweAYYkMl5TtQy4KV/3bObdBxnWMOEVUsxyR+ZtUEONj5MPhyR
         GeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367480; x=1734972280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbLgtM6fZRugS/23dnDGKiBeriksEAzT/0GxzT9Q5yo=;
        b=QLSVREpyqY6qOOfU+1WB0Jn52yJQr84dfSL+hhCK7FGywzKwCzgj1mSJvjT6VZQG5k
         p4DM6Pkss5RFzR0e++x8lFnJmeLVscalVTy/XZ+p6ZojcimA6CoYkTNJUtN6lk4H256p
         g3lViQ1BMXz0+9kyc1mxzJVYaSXPnoEr7oot+bDtPXW6Sl+Ky11ti833nx8hja5JSbdM
         CDdpanZXEkiEnZXLJj30ty/uDpajXNCAY5yq4p+/6jXQMK1TIbazyvKH6zl7d1zz0pIx
         b/j9XXrVdEaM1hkFTZrfV0i/07lrnMP9L0Z1N+gi96gJjSZ7Jr/D/Qwavx7SReByVdou
         2Hbg==
X-Gm-Message-State: AOJu0YyTLvkLEzoQf3HSzC9cM9qcourJVgdg0A5bYi9LS1xLoB9eSb1I
	IClkR1dQZwJ0Xv62reas1U9hvdP0LJZt4zG9e7WrWwCd/fCitX1BqAoZXJr/
X-Gm-Gg: ASbGncsZ6CrCguQQpW4pbZoKg0zQclIEm/WA034gnFzIv/7aXONa/JX8jjoFIOuLlzo
	iMVxHgXlbCVzm5fUCSOev8GX7uVqWSD+SNhywBauA2POXVIuLGZ1z1tqAh608R+WD7fkJx0vJX0
	jbSWKz1/EqZ0uAPbO2fQCs6dQKL08p78YyvCCJ5cshovcHaV186az1CWnnXcdBbHfGOxtqjzeft
	zqhDbEyfp53gEW8zObmpbaI2s6ZVgO5s7kvTuKCMFkEOG9rIiNbIdK9t8o=
X-Google-Smtp-Source: AGHT+IH2DZW4mrv/K5qe88/5zyluS6nQ06m0KxBo3qO6R55zOel8qjg4gKnGpaxwwlELK9dfl26Rjw==
X-Received: by 2002:a17:906:c10b:b0:aa6:841a:dff0 with SMTP id a640c23a62f3a-aab779ba4f8mr1547977666b.32.1734367480415;
        Mon, 16 Dec 2024 08:44:40 -0800 (PST)
Received: from [10.82.4.202] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635957fsm354834366b.109.2024.12.16.08.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:44:40 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 16 Dec 2024 17:44:31 +0100
Subject: [PATCH v4 6/8] refs: introduce the `ref_transaction_update_reflog`
 function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-320-git-refs-migrate-reflogs-v4-6-d7cd3f197453@gmail.com>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
In-Reply-To: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6145; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=KzZfc3eupGdaCgu8IhgU0wTKwFN0zZpW2VhtYjGjgj0=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnYFjwO7CJOsljWtADPbh2n5psDqeFZ/y2akPxg
 DUIRlb2wd+JAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ2BY8AAKCRA+1Z8kjkaM
 f1ESC/oDqppgxXdB4BOr1RuwWmCqylhn95hrliiv4PecN4Id/A2c1Pz4xSIA8GObNv4XeiP6VE4
 DGeeM+JlyCk6L79z8xV7WH+U+pLkP4EptMntZXXnDslb0Uan/8iJlxBvV3aw5wNtIrzwgI9yqHS
 hHT7EVrWzTK/ic3g/mknNUSSk/LJ+Mn55y4hkDZ3CjcF1Eg/cjMWQ775t0eGe1fkZXnotXIv2WW
 kDhNYrEcm1DNSdSdOfai0tbc02T65PXisUG5hZLnBl/haH/gLYTMtP1ip6LrGIEgJ3zRTWONDHo
 IdYxU1UHAuZ7cdmJ9quCvqh6KhK8b5xgho2Mqvqjr1ccviSRqImYTbndrL1yhbpQ9DVV4y99XxK
 HhJNMWtvcU9ZYQ6eNJHOx6HP4qRvLuz7yGiZ9TU0x5vuqeiVjTqHFCKeXlHEHscE0nGQOZaQYgB
 BsQSZ81NXewdaIZgadKu6LEMxZRpYeDwlHv0bCvIWs/OotilPjE6ky2k7f/SbKISzUYcI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Introduce a new function `ref_transaction_update_reflog`, for clients to
add a reflog update to a transaction. While the existing function
`ref_transaction_update` also allows clients to add a reflog entry, this
function does a few things more, It:
  - Enforces that only a reflog entry is added and does not update the
  ref itself.
  - Allows the users to also provide the committer information. This
  means clients can add reflog entries with custom committer
  information.

The `transaction_refname_valid()` function also modifies the error
message selectively based on the type of the update. This change also
affects reflog updates which go through `ref_transaction_update()`.

A follow up commit will utilize this function to add reflog support to
`git refs migrate`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               | 39 +++++++++++++++++++++++++++++++++++----
 refs.h               | 14 ++++++++++++++
 refs/files-backend.c | 24 ++++++++++++++++--------
 3 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 782bf1090af65196263a3c35ed18d878bb4f2967..8b3882cff17e5e3b0376f75654e32f81a23e5cb2 100644
--- a/refs.c
+++ b/refs.c
@@ -1207,14 +1207,14 @@ static int transaction_refname_valid(const char *refname,
 		return 1;
 
 	if (is_pseudo_ref(refname)) {
-		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
-			    refname);
+		const char *what = flags & REF_LOG_ONLY ? "reflog for pseudoref" : "pseudoref";
+		strbuf_addf(err, _("refusing to update %s '%s'"), what, refname);
 		return 0;
 	} else if ((new_oid && !is_null_oid(new_oid)) ?
 		 check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
 		 !refname_is_safe(refname)) {
-		strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
-			    refname);
+		const char *what = flags & REF_LOG_ONLY ? "reflog with bad name" : "ref with bad name";
+		strbuf_addf(err, _("refusing to update %s '%s'"), what, refname);
 		return 0;
 	}
 
@@ -1257,6 +1257,37 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	ref_transaction_add_update(transaction, refname, flags,
 				   new_oid, old_oid, new_target,
 				   old_target, NULL, msg);
+
+	return 0;
+}
+
+int ref_transaction_update_reflog(struct ref_transaction *transaction,
+				  const char *refname,
+				  const struct object_id *new_oid,
+				  const struct object_id *old_oid,
+				  const char *committer_info, unsigned int flags,
+				  const char *msg, unsigned int index,
+				  struct strbuf *err)
+{
+	struct ref_update *update;
+
+	assert(err);
+
+	flags |= REF_LOG_ONLY | REF_NO_DEREF;
+
+	if (!transaction_refname_valid(refname, new_oid, flags, err))
+		return -1;
+
+	update = ref_transaction_add_update(transaction, refname, flags,
+					    new_oid, old_oid, NULL, NULL,
+					    committer_info, msg);
+	/*
+	 * While we do set the old_oid value, we unset the flag to skip
+	 * old_oid verification which only makes sense for refs.
+	 */
+	update->flags &= ~REF_HAVE_OLD;
+	update->index = index;
+
 	return 0;
 }
 
diff --git a/refs.h b/refs.h
index a5bedf48cf6de91005a7e8d0bf58ca98350397a6..b0dfc65ed2e59c4b66967840339f81e7746a96d3 100644
--- a/refs.h
+++ b/refs.h
@@ -727,6 +727,20 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
+/*
+ * Similar to`ref_transaction_update`, but this function is only for adding
+ * a reflog update. Supports providing custom committer information. The index
+ * field can be utiltized to order updates as desired. When not used, the
+ * updates default to being ordered by refname.
+ */
+int ref_transaction_update_reflog(struct ref_transaction *transaction,
+				  const char *refname,
+				  const struct object_id *new_oid,
+				  const struct object_id *old_oid,
+				  const char *committer_info, unsigned int flags,
+				  const char *msg, unsigned int index,
+				  struct strbuf *err);
+
 /*
  * Add a reference creation to transaction. new_oid is the value that
  * the reference should have after the update; it must not be
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 255fed8354cae982f785b1b85340e2a1eeecf2a6..c11213f52065bcf2fa7612df8f9500692ee2d02c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3080,10 +3080,12 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 		}
 
 		/*
-		 * packed-refs don't support symbolic refs and root refs, so we
-		 * have to queue these references via the loose transaction.
+		 * packed-refs don't support symbolic refs, root refs and reflogs,
+		 * so we have to queue these references via the loose transaction.
 		 */
-		if (update->new_target || is_root_ref(update->refname)) {
+		if (update->new_target ||
+		    is_root_ref(update->refname) ||
+		    (update->flags & REF_LOG_ONLY)) {
 			if (!loose_transaction) {
 				loose_transaction = ref_store_transaction_begin(&refs->base, 0, err);
 				if (!loose_transaction) {
@@ -3092,11 +3094,17 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 				}
 			}
 
-			ref_transaction_add_update(loose_transaction, update->refname,
-						   update->flags & ~REF_HAVE_OLD,
-						   update->new_target ? NULL : &update->new_oid, NULL,
-						   update->new_target, NULL, update->committer_info,
-						   NULL);
+			if (update->flags & REF_LOG_ONLY)
+				ref_transaction_add_update(loose_transaction, update->refname,
+							   update->flags, &update->new_oid,
+							   &update->old_oid, NULL, NULL,
+							   update->committer_info, update->msg);
+			else
+				ref_transaction_add_update(loose_transaction, update->refname,
+							   update->flags & ~REF_HAVE_OLD,
+							   update->new_target ? NULL : &update->new_oid, NULL,
+							   update->new_target, NULL, update->committer_info,
+							   NULL);
 		} else {
 			ref_transaction_add_update(packed_transaction, update->refname,
 						   update->flags & ~REF_HAVE_OLD,

-- 
2.47.1

