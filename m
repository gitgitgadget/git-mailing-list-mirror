Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476731991DC
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217881; cv=none; b=KI+6I448BkzU+vBxAftVJQjxhHiLiArhJGbCDWVSe91SNe6yX3ydZiWAun6I0wl0x6VHhP7MBpohYKg5ow9eUpa6EWX31ZYM8hrHYDchaicvG1M5TXKDfsSwzD7Bd9mgn0XhV9CRptUS7XvOUBcS3FYxxOUyvXIs7KMJnA2sAZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217881; c=relaxed/simple;
	bh=a2yIn2+IzTEn3yyzmvLR2PkJdBxUyySG7Vm1F9Gux50=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ouppzir92kY72wKnmVIxNcLaLgn4aJmloJk+KFYx1TAnfbOjJr8yP8c4Sk+omIOejugedbUudx+M81g6OvjF/XHt3CWTr0NeRofFjFCnoG9HBlohrb3HD06KcRrY/w7doVVCMD9vEa9BzT51Zje38M9bTLMjaWTSrFy7Tnav2k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJktOoFR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJktOoFR"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-367ab76d5e1so1059885f8f.3
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723217877; x=1723822677; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+jVgXCXFRNurdNyelC4oTNBDe8r9mXUPEwVy6OJzg0=;
        b=mJktOoFRH6zpMYIMkzYav10s5BcdeQmu2lxacsi0UstHhBMiSZdH6lGVC5uT6ppv8H
         vnhA7WQfSYGUGzU8zIeOpL3Dv+oy4hX9zLsbutYFGIfJCcVdnufWKRycMsCbJwoj4y3+
         bUIkiyfp4akAVhFwygUYIdVNHW057asRNkB0Xne5tI0OFCaRf04f2xH80LHfooJC0czd
         uxkSOYaQuzOvyM3U+jabd7Bo69iytuBwhSsdjpTo6LH7pwSJDNrNV9gPQU6N6I9y63BJ
         373BbS3oUcrJ7URfp79fcdsS9uV2IR/8rsBDMtgdEm4O/YFyBBuKXxbNkgo0gM8NU4Z4
         1jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723217877; x=1723822677;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+jVgXCXFRNurdNyelC4oTNBDe8r9mXUPEwVy6OJzg0=;
        b=AfwT2Wzp9F8x9L5I7+Es5YBjHXEx10/Nbhr659WKJcb4WzIVhuo1juEEchgpqLn82t
         gI07ivdD/RH7UKsWFCDsKlyTknvWVWx4Fju185cSiC9ruOyIMjXFqbTGA8gcSfLtPWtl
         gQa8WEDwr0FwbL3oYk9fuRAUABbWOoLG2kUPOzWT5I+H1I8u+5JGdOTxLEZ1aCzY6eFi
         3gLV8EpuXPqK7NwvNsuoUmfsa0X5M8B7KUHTx1S8CVMJO+wk9RD2D8CX5YwdY70RAnGB
         GBfs30xRRfnx2CPf7yWIlNFkEvcSBShqzpdEHItr0EnsBnWMV2/Q2udZBuz1YmbjF9s+
         sdwA==
X-Gm-Message-State: AOJu0YymUlBPI2U1tLt67TRIfFGfl4S8m7/xb8Br37Q0394/cbbTp+wq
	48RMr5g3W6IgubKlbz/Ce5ST0hL2FJ5cqJfZIjNkRrAyqx/u73fZXMbvpQ==
X-Google-Smtp-Source: AGHT+IGPICwKRlCNMPIIpb8as0Z9tLI/sGGjo5dcJp+sltIPmmG0/ZoOv8ad/c+LdKtC10u57KwwGw==
X-Received: by 2002:a05:6000:4022:b0:368:4bc0:9211 with SMTP id ffacd0b85a97d-36d5fb92ddemr1541003f8f.17.1723217877206;
        Fri, 09 Aug 2024 08:37:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2716cc62sm5587023f8f.32.2024.08.09.08.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 08:37:56 -0700 (PDT)
Message-Id: <9f609f4d0f50758cd32b172e6e2ed7b3e71cf29f.1723217872.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1712.v4.git.git.1723217871.gitgitgadget@gmail.com>
References: <pull.1712.v3.git.git.1723059768.gitgitgadget@gmail.com>
	<pull.1712.v4.git.git.1723217871.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Aug 2024 15:37:51 +0000
Subject: [PATCH v4 3/3] ref-filter: populate symref from iterator
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
