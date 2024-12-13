Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E1A1CEEA8
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086219; cv=none; b=Yfzn2mJjIc+P9wuFYinJnx7keqJzseS0UrRDCasGP2CGU5KO1mh9evWpdXFEwgInOLerX4gxXTWC6PSBceg1hb0I3tOclDl9rtkn1c08GGjx7baEu8/n9vhzrnI8j6uxXthDWmitYEc9oQskX/yxAy+lU/iZErTyORtFg4oOnTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086219; c=relaxed/simple;
	bh=3aiM2iKCsTC1wp82pEkuMQZAxTWB2iCSybVMKz62p7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LgIZm7UuRVJkh/z6TG7Jmbi7vMAuRDTE+gOR/e8jntMox1rpOB05ZSfmzCdQ+wHEgYJ8AeREuSv2i1sCGEfvlDDs0jkfbzqFgFeGkOKWAygV55MsMmPLa40fkSjDkdgHon1torsHpnY5zP/ZQexcBMLKmf3c66fU2XydCpEoKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOcR+DvF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOcR+DvF"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso209857166b.2
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 02:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734086216; x=1734691016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1AU86NkiDthAajwqrAXEV0XCKO0VDecZ2AEpp6U//0=;
        b=SOcR+DvFbTf3dSgJfHtrMEpEkY4hLBggBXT6auMUZDbcY8KPxDA2g0uwuhl9+W67lF
         geWeUjwJwDGq4jWdOmWjKkTNYuk7F34rbq5x1sBbmEVl/vM4YTSXgVeRLQJ9wqUOstBC
         zMyGNEjIoPRmkQwKLyDtK0dcuPPKPyZIsKMNvqrf0tH5gKHtHJhJ0KMZhM/pA0Mcq/m8
         QJxiduIhtF7KY7GA4rf/dEd3TehrhTqPLprqiZaXdTTUvCjtBfIIQWQygFE9e9o3YeYn
         jXGOJWGcGNSY1LtdUdM5WBpQ719D0Qx43uZxBd0GD+6ZZjXWhBLskUZ5jtokGWwDcW09
         WJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734086216; x=1734691016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1AU86NkiDthAajwqrAXEV0XCKO0VDecZ2AEpp6U//0=;
        b=TzbqnnVZES5tcMvYPhuMHatHW+iqGYf8avyaM7G6WW2CBkEyH1fFFV3t3JVb97dHGe
         +QIRVN90qzkLRLiuKTcAzuzSt848KJR/cL189V5q3DzPfReLzHFjD2nrrJTFqpUycrF3
         HVpPv9XUqYpdzZZWP4Kod2gyXkiOil3yt3gk9B61RWyXXNMOQoULprfLXKzPSggZbySV
         UhChrVHVIqypBaKD1p84KtOVeKUs2jJ08ccoXy1oT1T1JSyV/lGN3XgKC6bjTOK0v081
         YV49ovlamWcehv7LlvAxUpfNcEB/rZ2WxVckfX4GHTODf1KsWQQKQheSXFOGpvExKbae
         BiNw==
X-Gm-Message-State: AOJu0Yyk/m6JVuA/ICD4+ifFvHYn7WgW04vwvHlYwPb1PH2UJTmkBWHd
	4lfuJBgBTTvezpQcPkdXLqiggozhPJ2dPwfiHlKmmqiRZkV2EQol
X-Gm-Gg: ASbGncsW3NXpWAAFGnIsWx4yPPVBRDvv6ht6mEFFSYUcndjeq346GGVB1jJcmfIddMy
	IWUBOnBrJhSzhxseo3B8tZid9lywDamoIdM27gcCgD9ZTwEAVB/NLZQCCJM8v8Tt0PyAkVxllfV
	MULmoB9/qDmMY9/UoZEsURM0U2WZx1nVoKer6tUUnEp17+m8Oeh0Gzm9OjE9QflyRxe2Q+8efIW
	QOJztBLLeig9M9JSvlacKmjZNTktnEe+x6aw5sO8DCWOLijaYjLjre+B+0DYfTXdAMLFA==
X-Google-Smtp-Source: AGHT+IF82MqGPA7OPdZz3P1afszwa9n+ofh+6b0rCET7SnHArLdAgihRzAMdC82Le/W03M/eVJ4n7A==
X-Received: by 2002:a05:6402:270f:b0:5d0:8f1c:d9d7 with SMTP id 4fb4d7f45d1cf-5d63c3007e4mr4783167a12.4.1734086215460;
        Fri, 13 Dec 2024 02:36:55 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6883f65c3sm686785266b.157.2024.12.13.02.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 02:36:55 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 13 Dec 2024 11:36:51 +0100
Subject: [PATCH v2 6/8] refs: introduce the `ref_transaction_update_reflog`
 function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-320-git-refs-migrate-reflogs-v2-6-f28312cdb6c0@gmail.com>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
In-Reply-To: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6372; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=3aiM2iKCsTC1wp82pEkuMQZAxTWB2iCSybVMKz62p7s=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnXA5BwJcGSf/ohWwQ8RxdWaRhvm6z8Fu7/fRQR
 +S3bwvCLVmJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1wOQQAKCRA+1Z8kjkaM
 f2gBDAChPrNL4jeY87Uu/ixIAS2CTC0jzTibIV0KJNivEgv1lCwR0nUm7vjOidKM+JL+3oT4ZIP
 egOizca4D6IVY5dL/i5Vh3IHnqgYpt9mDFxlENzfdiLhVg/wj+c+anBWCY9enxNPIQJLIclwJTO
 69iFF2EI8Z8EK9m0Izdk7VDX3RHuQ0z342E8Y63qEFBSkxBFSYpJYsllpfp9x2zlukZEU8vinm/
 LDuR3v+6Zg9736J636Lo+ETrP4XOA7X31wSRUCzBlu6Y5NtzXE6IiwVVPv8sB+4SwnPhkBX3jjF
 gz09n0QCqk/H4OpgI+x5z+x/GYStJIQskn5LFdcCKb/d7hx2fpIzKXJIvKVaj2+eSthKGaDaAW4
 zyh3KCTAgaNVHSjpg8Lo1aqJklAVl8Jii3tVx09LXO7zLSG+Z1ckEteopBkx6JDgTI/3OakLUy5
 uaHuZQQTL2zapK9xtmxaBAswNc+EYLfAVjNn7kY0xhbFzRy4KvAOrDo2wgnoXUPuA5dPI=
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

A follow up commit will utilize this function to add reflog support to
`git refs migrate`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               | 44 ++++++++++++++++++++++++++++++++++++++------
 refs.h               | 12 ++++++++++++
 refs/files-backend.c | 24 ++++++++++++++++--------
 3 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 428ca256f3e5860554e9a7fa42a8368bb2689b31..9f539369bc94a25594adc3e95847f2fe72f58a08 100644
--- a/refs.c
+++ b/refs.c
@@ -1203,20 +1203,21 @@ struct ref_update *ref_transaction_add_update(
 
 static int transaction_refname_valid(const char *refname,
 				     const struct object_id *new_oid,
-				     unsigned int flags, struct strbuf *err)
+				     unsigned int flags, unsigned int reflog,
+				     struct strbuf *err)
 {
 	if (flags & REF_SKIP_REFNAME_VERIFICATION)
 		return 1;
 
 	if (is_pseudo_ref(refname)) {
-		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
-			    refname);
+		const char *what = reflog ? "reflog for pseudoref" : "pseudoref";
+		strbuf_addf(err, _("refusing to update %s '%s'"), what, refname);
 		return 0;
 	} else if ((new_oid && !is_null_oid(new_oid)) ?
 		 check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
 		 !refname_is_safe(refname)) {
-		strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
-			    refname);
+		const char *what = reflog ? "reflog with bad name" : "ref with bad name";
+		strbuf_addf(err, _("refusing to update %s '%s'"), what, refname);
 		return 0;
 	}
 
@@ -1240,7 +1241,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 		return -1;
 	}
 
-	if (!transaction_refname_valid(refname, new_oid, flags, err))
+	if (!transaction_refname_valid(refname, new_oid, flags, 0, err))
 		return -1;
 
 	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
@@ -1259,6 +1260,37 @@ int ref_transaction_update(struct ref_transaction *transaction,
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
+	if (!transaction_refname_valid(refname, new_oid, flags, 1, err))
+		return -1;
+
+	flags |= REF_LOG_ONLY | REF_NO_DEREF;
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
index a5bedf48cf6de91005a7e8d0bf58ca98350397a6..67f8b3eef3f2101409e5cc6eb2241d99e9f7d95c 100644
--- a/refs.h
+++ b/refs.h
@@ -727,6 +727,18 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
+/*
+ * Similar to`ref_transaction_update`, but this function is only for adding
+ * a reflog update. Supports providing custom committer information.
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

