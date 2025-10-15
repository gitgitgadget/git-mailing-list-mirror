Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090630BB91
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567257; cv=none; b=OxhfkEer1ep8x3hS9ORrMo0sJ3M3rVZkj2z34wpBNX2RPXgWGSLh9l9MsCVJq6fHT6FW83WsVj3/l5KJ+1r8gxcnWe5jvOHW06QQMFX6kRlToJIP14FCjd0Dws3fOC1/oiNqXFets6NGrf+Q+tL7KZomecRWGzVdJ0Uo3GG071A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567257; c=relaxed/simple;
	bh=iTbvUNqgZaJF4SFVG8ecULujCubMLXgr23C1rGIs0w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9lL5UokE5GaLDyIh0JI1rMIkg6g/cxm9oJinl2rZTZhii0GtQ5W/fG7bZJAqxL87x6OyhxTALSrpf0vPhPNq1nAbiC4vPsNRqPC+ilobRtslI3XBLafinQAbR/VbKPvDv+yxN5QFVdDcivVGLF5VroqsB/Ze0YBaJvJfg7Xq9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=FxTNU+Dy; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="FxTNU+Dy"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-780fe73e339so512227b3.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567255; x=1761172055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C30MsSLMk5JAbTwNpfKo2vGBUQ2RDlilIB7xB7+J9uU=;
        b=FxTNU+Dy9defNhO/YoOOKp3FPmf1tYK49G9ZQI9cH48ix2l88h800cLxCpm5XmPRFS
         lFCGhrANIP7sYl4npK9xmTyc/1gkZt/oI8K63Fu6LlXU1yMaV9IjBr8UW1AANKKPDRxQ
         WYgfPfpwy/TLqfY12fbWHuJ5owHHsfvl8gMm7bPHhngKUEPERmOrwROP+Ar1GUoZzq/9
         W09HpJPO1h6+FQH8Hz5tdEfwaBX2VMgBhz5TO+h7d5N0yBbFYJW0v7/mZO5XXgJc1HwK
         8db6wBcPmJ5i0N6Ora+Qwcehkm2nw8j3rwaqRSUhgpERPqL70s4pazNQBKC5fgLpZtay
         Yt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567255; x=1761172055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C30MsSLMk5JAbTwNpfKo2vGBUQ2RDlilIB7xB7+J9uU=;
        b=o3XxrrTTZ8zPGh7EYRcfA/qy65oOG5FQl2Q8j8spZc3mgV4R1BPqGRrm3Bn8Xuq9PJ
         WSHjWy6NtwwBfYAzgXf1ZJZfwxEoSC656NdcA6eB6O+Dx9jby9mVu+IskubH2CglTT+t
         /cxg4HF41FvD/6RA2i1dZv8/orDP3091ST9acbHOA3Pj2e5xsQi0/wslBzPo2TpqGRHk
         zo0NI4M8R4GabLvtKMmyEHyFTGV1uOE5au2C3otCCzxZYzeQhPj+QHIBXMyMpGQB59t9
         wUFeNz/V9SZYWEtrXsX+upsgyXSgTKz2bf0cyS9oTzVlj/s7IkGfuhJvvRP/Yl9PG/nK
         04vA==
X-Gm-Message-State: AOJu0Yy8wIQEZs++MRfRvKaueNTnwZ7tn9RRn1HW1wGFXaCW76vjPq1+
	EyZ5jI15YKfHtDO9rAhj9a8yFk/Py20+Y9xQuMuLfS5uXwWDNjC5T9/APJvGvDtRZO3EAUfhIyG
	sa0I+WpBF8A==
X-Gm-Gg: ASbGnctHMjOJocXp3N/r1kisl3rWDHXMRVwKTg/Y0pfDS8Jik4LgkAgXMeBhyCKX4Te
	64L7hSJwNgDtOOB4M9ePvCZFe/J25iQMUTMnclXDrPsmoxIhfMPEv7A9JHSy159XrqAYm0UnNSE
	G7d/1k6W/PwOZO1FOuC0Ddy5TBdQx1CSeaq/FY5OY9dBjDOFBBIQuU0F+YTGEpcbdWkcptGVmmg
	obDjLms4ndrPkzcCxyYhXuQdISIZ0TD4tO5LbUs297GL9XiKpZkDkvNeqskCLCaZqk51uvvRNqx
	r5MVYK1lK9UuzW5OHObLn73O3ND6BTaJwmzgRheCsiLaI3oEBvGZBBThcJxZH/E5SiAeCogqCiH
	YuWACg3gt2XF1D2MBECM31Mc+e0jDobGNXQec3kJVV8V+Bmp0txHKcQzJ7YkvoTxKShPk4qIsE+
	bFWLwJiXJlxIzC1GZ/kPzLSsioujzzwM5R8AB4bDaWi+6d9Or/puNKu9nEwUhN4SFtkhqO+QDpK
	Qz6/ww=
X-Google-Smtp-Source: AGHT+IHOthu4M91N5zgI4ci2LNhhmaVYIjqPXiZ1mC2bXB4czRh3bAkJaVArGaCd2j75wLldFkBK9g==
X-Received: by 2002:a05:690c:6f92:b0:781:64f:2b70 with SMTP id 00721157ae682-7826a07748emr15460337b3.33.1760567254779;
        Wed, 15 Oct 2025 15:27:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-782935f0bb7sm2570867b3.54.2025.10.15.15.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:27:34 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:27:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 06/49] builtin/repack.c: avoid "the_hash_algo" when
 deleting packs
Message-ID: <238f3d87a05c577a8864073b06cd62cc84611a39.1760567210.git.me@ttaylorr.com>
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

The "mark_packs_for_deletion_1" function uses "the_hash_algo->hexsz" to
isolate a pack's checksum before deleting it to avoid deleting a newly
written pack having the same checksum (that is, some generated pack
wound up identical to an existing pack).

Avoid this by passing down a "struct git_hash_algo" pointer, and refer to
the hash algorithm through it instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 4f08b57ddb..094f5a0cc2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -168,11 +168,12 @@ static int pack_is_retained(struct string_list_item *item)
 	return (uintptr_t)item->util & RETAIN_PACK;
 }
 
-static void mark_packs_for_deletion_1(struct string_list *names,
+static void mark_packs_for_deletion_1(const struct git_hash_algo *algop,
+				      struct string_list *names,
 				      struct string_list *list)
 {
 	struct string_list_item *item;
-	const int hexsz = the_hash_algo->hexsz;
+	const int hexsz = algop->hexsz;
 
 	for_each_string_list_item(item, list) {
 		char *sha1;
@@ -217,8 +218,9 @@ static void mark_packs_for_deletion(struct existing_packs *existing,
 				    struct string_list *names)
 
 {
-	mark_packs_for_deletion_1(names, &existing->non_kept_packs);
-	mark_packs_for_deletion_1(names, &existing->cruft_packs);
+	const struct git_hash_algo *algop = existing->repo->hash_algo;
+	mark_packs_for_deletion_1(algop, names, &existing->non_kept_packs);
+	mark_packs_for_deletion_1(algop, names, &existing->cruft_packs);
 }
 
 static void remove_redundant_pack(struct repository *repo,
-- 
2.51.0.540.ga7423965ad8

