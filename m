Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A64230FC0E
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567343; cv=none; b=e5xFSKrP5hMjjOzrWAGtBDzSvaFdI2gqQ8s+DoDB8anEwPcB4ZE3KXJgPF+eFwJHZjkbRdsd6UnPOAOizcO8szL/xvgEvr9HIc9qTOPBG6k87R2z8su3L7OUcozFCtmfbVpPFLeyHlZu8M784SyhYrw/h89FZMwzs9WS64qkV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567343; c=relaxed/simple;
	bh=/OmwaCg3huQcezJ9jZEvUAZztmRZ8Ijw9JOTfE/DNWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbHk5JE7X50lZAuXBF0aNfwOziQj7v2LanvKahvsKzmhqc3LK5RCob9D6aReIw44Kckde4JUAuVswOFq+d4d7kpskGH4zgjJA4xIrnYlVazgJXWxfKZQ4+SzZ6zzwjiwTUX4lIq9tG8VKTLPbqC1wlMV3ZYcWCu1hyxd6zbJebg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=oycrKgWF; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="oycrKgWF"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6353ff1a78dso118275d50.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567341; x=1761172141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0rs96W+jflu8TBMVh9zo8dnAakjYDKH5ky1ATh7usIU=;
        b=oycrKgWFvqX/S5fUv0QFEhvb5OVCvUcrgDqdRSzAH2uzfIxvPSwNYw3vBMtbj6dlQO
         MgD61p/n7R+drvtiqrudxqgBWzrUOjGVTQSUPKa+hiedzUpiAk2ffTRsiTyPlYsjcGF7
         tGVu964HCKZ5OMuir7gVC8QniU0/IVKUi4CZqaOlA+B/K3aqpQLoRqO+Q0bQvmKXpk0V
         tLf/dPq6rnTzZm/+GqWdGGJESeFlEyYg9n/yHNKBKMmRzeNh44WTHwnVXlezK30yYSSL
         0HL3mvcaeEyt/m3pc+ZcG6ped3kb16Dppl0GbKzYKRNddZWi2Naw4aEeooopelWfH0B3
         LxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567341; x=1761172141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rs96W+jflu8TBMVh9zo8dnAakjYDKH5ky1ATh7usIU=;
        b=WHhdxoXqyDMkiHy/V4MWa7la8bE920qTcus1i06uAMx1vNsKhaivwS5+kLYg9jGqXb
         0b1KvPShb7hXqIYtx8y/Tgh9IBKQRmMolN8DiT2mr6K/X7xc/f3gs43BIqi0Q4BNchcd
         Y0kEakq+wU6abqoqU19CmxEkwQHbU6tHy/Pd8t/SixCxMewPl21jnVGcL5dFjyhasAxF
         vC70YLzI//x903kEJsStMkbFA428n1r7XG1oD2T1JKBvVy1frvU5db3ejAjdQ3nZUVZK
         D2JXOGpV2dp7c5kAYFAY1BfGUKfYqrnVC0+569lbFI7uO5c4fEcv2SRohJHETASLdmlA
         pvGg==
X-Gm-Message-State: AOJu0YxfvqafKtCnwKNkvN1QyslaPIQr6MYPIRPuaDzjU6d+/UiZ6uei
	cLtq+8kk7qUukpXBzyZXPs6Zh/ERosQpHGmhwjpav3XFXN0CPZ+APLp1u61bemmGp++Fl0X+GDc
	Hl3eCgu5h2Q==
X-Gm-Gg: ASbGncv3FmArVLpk/7MWE23mKIEaT2sVjaXnuXOXMaBulfcLOQlnXp1+kBQfEmcwog7
	cfG/TryWiHU69BRqqXwe3nHTO3VLM1A9bqnvsVBKpwV4nJOZnR3+3xHSaaRdObuy3HPLq+SJINv
	SpGUOiGM/8W6JWlHX10/IIi8cymszOIlFhcqxmBkmiaZziVg1e9LwYlVKJihGAwM6x7eigexXbF
	uetb9Gklpko5QFIuGbWJDqKYWUtVuHJF2V5RI4GlhHq5mu9ZGqUZZDiLp4VwH0fAqVifPGfapMb
	prnARTegl9ujv5eZqEsRvKGYin3cGZTsS7XLaDoRTpassVCQoeaH6KJuEfKFSQKGbBQleu1l9dB
	bfpS7RlUk2CnPZmaQiiPyMMSvcPO+uwSWT2gRGjYgJpU8xStsVeu7gUXSwTRq3zmReauCZUUIGi
	VVLTLBfnjbBEhjWJ/3DWXubQWOs32lhhpyOpGaPOIdRox0URHY45RPVAT9qdbhOoNLSzJ3y4uEv
	lrAWLzBCt2nf0LncA==
X-Google-Smtp-Source: AGHT+IFEP/+Oeni0IMIXe77Yw22DoyX/1AVsjXv+iuqf5NqJQWQET+ytEn4XyhYrO+UHLCfP3hc5nA==
X-Received: by 2002:a05:690e:2c3:b0:63c:dd26:331 with SMTP id 956f58d0204a3-63cdd260bb7mr16767875d50.10.1760567340448;
        Wed, 15 Oct 2025 15:29:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63cefffdd73sm4733806d50.7.2025.10.15.15.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:29:00 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 34/49] repack: keep track of MIDX pack names using
 existing_packs
Message-ID: <ec3a8a7dd29c18c71947f1d3c4b4fffe1fe799d6.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

Instead of storing the list of MIDX pack names separately, let's inline
it into the existing_packs struct, further reducing the number of
parameters we have to pass around.

This amounts to adding a new string_list to the existing_packs struct,
and populating it via `existing_packs_collect()`. This is fairly
straightforward to do, since we are already looping over all packs, all
we need to do is:

    if (p->multi_pack_index)
        string_list_append(&existing->midx_packs, pack_basename(p));

Note, however, that this check *must* come before other conditions where
we discard and do not keep track of a pack, including the condition "if
(!p->pack_local)" immediately below. This is because the existing
routine which collects MIDX pack names does so blindly, and does not
discard, for example, non-local packs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 26 ++++----------------------
 repack.c         |  5 +++++
 repack.h         |  1 +
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index dda533f171..a57a14ef60 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -118,8 +118,7 @@ struct repack_write_midx_opts {
 	int midx_must_contain_cruft;
 };
 
-static int midx_has_unknown_packs(struct string_list *midx_pack_names,
-				  struct string_list *include,
+static int midx_has_unknown_packs(struct string_list *include,
 				  struct pack_geometry *geometry,
 				  struct existing_packs *existing)
 {
@@ -127,7 +126,7 @@ static int midx_has_unknown_packs(struct string_list *midx_pack_names,
 
 	string_list_sort(include);
 
-	for_each_string_list_item(item, midx_pack_names) {
+	for_each_string_list_item(item, &existing->midx_packs) {
 		const char *pack_name = item->string;
 
 		/*
@@ -190,7 +189,6 @@ static int midx_has_unknown_packs(struct string_list *midx_pack_names,
 
 static void midx_included_packs(struct string_list *include,
 				struct existing_packs *existing,
-				struct string_list *midx_pack_names,
 				struct string_list *names,
 				struct pack_geometry *geometry)
 {
@@ -245,8 +243,7 @@ static void midx_included_packs(struct string_list *include,
 	}
 
 	if (midx_must_contain_cruft ||
-	    midx_has_unknown_packs(midx_pack_names, include, geometry,
-				   existing)) {
+	    midx_has_unknown_packs(include, geometry, existing)) {
 		/*
 		 * If there are one or more unknown pack(s) present (see
 		 * midx_has_unknown_packs() for what makes a pack
@@ -604,7 +601,6 @@ int cmd_repack(int argc,
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
 	struct string_list names = STRING_LIST_INIT_DUP;
-	struct string_list midx_pack_names = STRING_LIST_INIT_DUP;
 	struct existing_packs existing = EXISTING_PACKS_INIT;
 	struct pack_geometry geometry = { 0 };
 	struct tempfile *refs_snapshot = NULL;
@@ -978,18 +974,6 @@ int cmd_repack(int argc,
 
 	string_list_sort(&names);
 
-	if (get_multi_pack_index(repo->objects->sources)) {
-		struct multi_pack_index *m =
-			get_multi_pack_index(repo->objects->sources);
-
-		for (; m; m = m->base_midx) {
-			for (uint32_t i = 0; i < m->num_packs; i++) {
-				string_list_append(&midx_pack_names,
-						   m->pack_names[i]);
-			}
-		}
-	}
-
 	close_object_store(repo->objects);
 
 	/*
@@ -1015,8 +999,7 @@ int cmd_repack(int argc,
 			.write_bitmaps = write_bitmaps > 0,
 			.midx_must_contain_cruft = midx_must_contain_cruft
 		};
-		midx_included_packs(&include, &existing, &midx_pack_names,
-				    &names, &geometry);
+		midx_included_packs(&include, &existing, &names, &geometry);
 
 		ret = write_midx_included_packs(&opts);
 
@@ -1063,7 +1046,6 @@ int cmd_repack(int argc,
 cleanup:
 	string_list_clear(&keep_pack_list, 0);
 	string_list_clear(&names, 1);
-	string_list_clear(&midx_pack_names, 0);
 	existing_packs_release(&existing);
 	pack_geometry_release(&geometry);
 	pack_objects_args_release(&po_args);
diff --git a/repack.c b/repack.c
index d8afdd352d..1d485e0112 100644
--- a/repack.c
+++ b/repack.c
@@ -80,6 +80,9 @@ void existing_packs_collect(struct existing_packs *existing,
 		size_t i;
 		const char *base;
 
+		if (p->multi_pack_index)
+			string_list_append(&existing->midx_packs,
+					    pack_basename(p));
 		if (!p->pack_local)
 			continue;
 
@@ -104,6 +107,7 @@ void existing_packs_collect(struct existing_packs *existing,
 	string_list_sort(&existing->kept_packs);
 	string_list_sort(&existing->non_kept_packs);
 	string_list_sort(&existing->cruft_packs);
+	string_list_sort(&existing->midx_packs);
 	strbuf_release(&buf);
 }
 
@@ -220,6 +224,7 @@ void existing_packs_release(struct existing_packs *existing)
 	string_list_clear(&existing->kept_packs, 0);
 	string_list_clear(&existing->non_kept_packs, 0);
 	string_list_clear(&existing->cruft_packs, 0);
+	string_list_clear(&existing->midx_packs, 0);
 }
 
 static struct {
diff --git a/repack.h b/repack.h
index 803e129224..6aa5b4e0f0 100644
--- a/repack.h
+++ b/repack.h
@@ -40,6 +40,7 @@ struct existing_packs {
 	struct string_list kept_packs;
 	struct string_list non_kept_packs;
 	struct string_list cruft_packs;
+	struct string_list midx_packs;
 };
 
 #define EXISTING_PACKS_INIT { \
-- 
2.51.0.540.ga7423965ad8

