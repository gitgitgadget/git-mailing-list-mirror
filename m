Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2581448D7
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723059778; cv=none; b=rIZlTdRGspmNewlSfX39u41TaMbrm7kHI0+j1e7iMX1igsaP+NGtBs+TobOrXKvP6RePPlIWVr5Jnmaje+CJgUPrCtvfFruwUT37t24MboW048b9KTydi5bDhwJPuYgjysh9lYRkD/6P8peRKYX5qUP3x23lazukOEK2KqW1mRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723059778; c=relaxed/simple;
	bh=a2yIn2+IzTEn3yyzmvLR2PkJdBxUyySG7Vm1F9Gux50=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lrxl0pZn2TYtyxuUgi5ysiJvMYubM8Moi+WplttAS93PWEfVJMtHMrTkZ9maOh53QKKm20Txh5kOzmydX+Z6yduzzN5ZvrDWixTuP00KGtJjPNgbqyBtvISu8L6j/Iq47kCFMF3uh7s00pRiOcf0CpoyvDKM/BQBtbuEsuHN7QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmW/hDZy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmW/hDZy"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4281faefea9so1597145e9.2
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723059774; x=1723664574; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+jVgXCXFRNurdNyelC4oTNBDe8r9mXUPEwVy6OJzg0=;
        b=OmW/hDZy3qcMnBi/G0EaB3Tu3VJmWyXhezrOizhAFa5wIvVYM+UBXPI+DMIWTksN58
         4doGe/086h/ZmpgVpUx9EexkLhFaxdRsIeGjpJ0QF1NEnpHgXo39Luh85uQYCgRAr9zO
         5z2P3G+viCx2EC3kbX4WlzCTov0rdQ3jgTJu9kNVzp1e7dTEt8Ptb/q9hoi/Kh8GH2K2
         Nb5TmwENDiP2Nr4NMQ7nEH9nBzsNAitMr2Ynwc5pfRw1BaC9KP7y75FHCaUorXxoyP9h
         NW0YeyAVXNkwetNAImQi8pghUlrcUOAKYA8DCEO3bDSB6VU2JB/ZSMZxvl6pfnrZ9pOm
         j/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723059774; x=1723664574;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+jVgXCXFRNurdNyelC4oTNBDe8r9mXUPEwVy6OJzg0=;
        b=Ed8vXdPDs/gvbbKTewWNwbAjNqeetTIzU5nSc0B56N1DMbA9CCLqFOTXi53XwnilYc
         1Ht6k4WNnocPZknGgRX6GlQC1ZUanaDH1n/q4d20sRi0t4pW70qAQE/SkZxkCRO/xX+g
         gxCd9WkqzAUT87ehmoP2zGsJ5iEcs2+/i2SjwhYW6Xu20DZqj1GvznY5L2QxIdJxw+RX
         PBYcJkOUKRfQmCcqNHo6qgAY2p51AtIgs4xRzMkpdez6yiaZb31ehuaqSYs6m778d2sh
         W/TifGEQJVyc7DqubwJcsdJTQP05pVGDueLzF/14IVBb0QZT9WiOVV0Ieq6llBxkhWIh
         zNYQ==
X-Gm-Message-State: AOJu0YyodzwcEx/F2pKUZQrBaXluCw4xOAcS4BakoSoAp4Rr7SVmVfQb
	eSm6V/pcemZfxegJCqRNlV/Kcawsmt7n5asXVCpZPvHpYVUMP4qsIzMbiw==
X-Google-Smtp-Source: AGHT+IHSx2nIbR0fa9zl1B/GYpu32TlK1KB2VjaVhe5dZxpHr8bflcjIrwxvecmcSzeucIVZqptYPA==
X-Received: by 2002:a05:600c:46cc:b0:426:5e0b:5823 with SMTP id 5b1f17b1804b1-428e6b92fdcmr132626575e9.34.1723059774108;
        Wed, 07 Aug 2024 12:42:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057968d8sm43600405e9.9.2024.08.07.12.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:42:53 -0700 (PDT)
Message-Id: <83b70ab8287ae2c929fbbdce24770b61ef64c602.1723059769.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1712.v3.git.git.1723059768.gitgitgadget@gmail.com>
References: <pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
	<pull.1712.v3.git.git.1723059768.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Aug 2024 19:42:48 +0000
Subject: [PATCH v3 3/3] ref-filter: populate symref from iterator
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
    Linus Arver <linusarver@gmail.com>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

With a previous commit, the reference the symbolic ref points to is saved
in the ref iterator records. Instead of making a separate call to
resolve_refdup() each time, we can just populate the ref_array_item with
the value from the iterator.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 ref-filter.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 39997890feb..4d1f3ff3d23 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2343,6 +2343,12 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 	CALLOC_ARRAY(ref->value, used_atom_cnt);
 
+	/**
+	 * NEEDSWORK: The following code might be unncessary if all codepaths
+	 * that call populate_value() populates the symref member of ref_array_item
+	 * like in apply_ref_filter(). Currently pretty_print_ref() is the only codepath
+	 * that calls populate_value() without first populating symref.
+	 */
 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
 		ref->symref = refs_resolve_refdup(get_main_ref_store(the_repository),
 						  ref->refname,
@@ -2783,7 +2789,7 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 	return ref_kind_from_refname(refname);
 }
 
-static struct ref_array_item *apply_ref_filter(const char *refname, const struct object_id *oid,
+static struct ref_array_item *apply_ref_filter(const char *refname, const char *referent, const struct object_id *oid,
 			    int flag, struct ref_filter *filter)
 {
 	struct ref_array_item *ref;
@@ -2852,6 +2858,7 @@ static struct ref_array_item *apply_ref_filter(const char *refname, const struct
 	ref->commit = commit;
 	ref->flag = flag;
 	ref->kind = kind;
+	ref->symref = xstrdup_or_null(referent);
 
 	return ref;
 }
@@ -2865,12 +2872,12 @@ struct ref_filter_cbdata {
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
  */
-static int filter_one(const char *refname, const char *referent UNUSED, const struct object_id *oid, int flag, void *cb_data)
+static int filter_one(const char *refname, const char *referent, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
 	struct ref_array_item *ref;
 
-	ref = apply_ref_filter(refname, oid, flag, ref_cbdata->filter);
+	ref = apply_ref_filter(refname, referent, oid, flag, ref_cbdata->filter);
 	if (ref)
 		ref_array_append(ref_cbdata->array, ref);
 
@@ -2900,13 +2907,13 @@ struct ref_filter_and_format_cbdata {
 	} internal;
 };
 
-static int filter_and_format_one(const char *refname, const char *referent UNUSED, const struct object_id *oid, int flag, void *cb_data)
+static int filter_and_format_one(const char *refname, const char *referent, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct ref_filter_and_format_cbdata *ref_cbdata = cb_data;
 	struct ref_array_item *ref;
 	struct strbuf output = STRBUF_INIT, err = STRBUF_INIT;
 
-	ref = apply_ref_filter(refname, oid, flag, ref_cbdata->filter);
+	ref = apply_ref_filter(refname, referent, oid, flag, ref_cbdata->filter);
 	if (!ref)
 		return 0;
 
-- 
gitgitgadget
