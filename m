Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB351991A0
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694810; cv=none; b=A0stC7G1AnAVc/RPD7gv88AxFToUH1+NP6Oo/VWLLSStgctQqYYOKvrxO2wzuNBq99zb54GaE0mCqK4NpzV30izBF3bNgH0IYFgOKGLKqQmuI9pFpjM61RmkHnbnnMIVChpmE0I08EUMOe/TYw6ce8qfKoZJginpdw2jAKG9lag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694810; c=relaxed/simple;
	bh=WKy6Ew8aBr4WYV+3wQI7PpDs4Kf00n8qoPms4AY6HjA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EbNKJfVgUrX9ShWllWnWC/QsNVXXN6W56UWhxz0fMRV/UrGFyh6C/FBQOrE9iP9NLHPsThnHVVIEdXRp7LxHd4VctVZbFFdSANErjw8lSb/44aJKX0jvegiBENfWkBRDnB5G8P5b5EY6ZVP/KuAP/3yMfRYYvIUWr6Jde4A1SHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zah/rfSf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zah/rfSf"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4215ac379fdso11864725e9.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717694807; x=1718299607; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf+zKG7gppPa+fZpWzVYCKKzyRfTOzP8PioMoGHRVf4=;
        b=Zah/rfSfl76J7N1X2ycuh+6keO3iGRmyjm0otOybOgjbz++WZnY51WwJLkZk90+SKv
         PaG9lhtrd9unQInUcGBVytiNun8K/mS+Dgavj8/12FzftnqTHeM+7fpHANbIVySI1dAC
         MUOe7pmyGZxpN6c8+ZDjADeYYc7DQ0DW02w/K9tB6l+B6NfXoy3Hf693UHEoSOUd3jQb
         jXb0tXn7XpUO4Nv6qOUVYEMmuJor2LMxSvy9vBOl3narysexbx5jyxoD5Ks/kJUIhTTd
         U4KyesDbcR7u08wPjGMnNgBc64zDVMzndGG/tfhw/Dn32rrf7XTVlQ0B1zFhp2/P/dBi
         LllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717694807; x=1718299607;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mf+zKG7gppPa+fZpWzVYCKKzyRfTOzP8PioMoGHRVf4=;
        b=mHfEIQ/PJG3xisU2R8oP+J8+yCCyDnICVGWWzuRWsXukxzi2NCyXbpEoMdRO8s4eh4
         7liiIljwWVh/rAB5GiwwUe7AwgYG4I2c+Y7lU4gyBZXy9o/KZEMjojTQoBcm5Bcmfwwp
         A0HGv/iy8d477CIqIm6w2cUk7bduiCzQN/OZxmRyqsfeyznTL0fJ4375Sq/jUs6OQJQn
         sojDFwKP3nFgx1rnAa0jzbiRUP4R76sG7qqHSplm0O4nXZ2bWwElsDucA+KDb9r8dLoJ
         OCobmS2oq7LUCSH09CAgiKBIhonYbn1ImKoNd60wzDD/V4i8csyTgJcAyj+Y1s9aDZai
         BtNg==
X-Gm-Message-State: AOJu0Yyd28nUVVWIbsKgP8MY8KVEAAozSeWt5vt0k91gmnZymzKA05vy
	l6a0SwI7J1Xjvj89l8aU8RieC1SvxADpkZeEx7O+4kXDiJ8F1DAF85037Q==
X-Google-Smtp-Source: AGHT+IFSFg5OOoLxfzX1rBMCoR3NT2pDIyUgBoIj6Wx1KtFQikZ5PfkxBJBrejb2k1qtaYbFX3BUhw==
X-Received: by 2002:a05:600c:4c11:b0:421:2a2d:2bfc with SMTP id 5b1f17b1804b1-421649fe32bmr3416485e9.12.1717694806879;
        Thu, 06 Jun 2024 10:26:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35efa97b15dsm1065065f8f.81.2024.06.06.10.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 10:26:46 -0700 (PDT)
Message-Id: <6d5b1b62e6c59ecc0f49d11e08732c6dc4d573fa.1717694802.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Jun 2024 17:26:40 +0000
Subject: [PATCH 4/4] ref-filter: populate symref from iterator
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
Cc: "Phillip Wood [ ]" <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <[code@khaugsbakk.name]>,
    "Jeff King [ ]" <peff@peff.net>,
    "Patrick Steinhardt [ ]" <ps@pks.im>,
    "=?UTF-8?Q?Jean-No=C3=ABl?= Avila [ ]" <avila.jn@gmail.com>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

With a previous commit, the reference the symbolic ref points is saved
in the ref iterator records. Instead of making a separate call to
resolve_refdup() each time, we can just populate the ref_array_item with
the value from the iterator.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 ref-filter.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 0b4b6bb8d71..c7c2117f9cd 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2781,7 +2781,7 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 	return ref_kind_from_refname(refname);
 }
 
-static struct ref_array_item *apply_ref_filter(const char *refname, const struct object_id *oid,
+static struct ref_array_item *apply_ref_filter(const char *refname, const char *referent, const struct object_id *oid,
 			    int flag, struct ref_filter *filter)
 {
 	struct ref_array_item *ref;
@@ -2850,6 +2850,7 @@ static struct ref_array_item *apply_ref_filter(const char *refname, const struct
 	ref->commit = commit;
 	ref->flag = flag;
 	ref->kind = kind;
+	ref->symref = referent;
 
 	return ref;
 }
@@ -2863,12 +2864,12 @@ struct ref_filter_cbdata {
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
 
@@ -2898,13 +2899,13 @@ struct ref_filter_and_format_cbdata {
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
