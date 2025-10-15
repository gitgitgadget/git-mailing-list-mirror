Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0381A307AD8
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567274; cv=none; b=WCSYGw/Ffg3idKe2+jmp/Sjo/v0slLdBkJmUEAqVJawsKt9IwdpU3PJwCo1YrcOm5sTRbGCiaC0NAqOyApkzRgXOObxFsfrcuk21ikOgQnLzY1t4qn+jD88qJUf9zHMEuGBlMfH6XZlQ4l5htf3PzhiGYB3ntlHGk/nKXzW1xms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567274; c=relaxed/simple;
	bh=avmSzvcFzwP3aYdQ4Eqkcu3XKeIE1xuKoDdbRKum/S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIkwxciesuBHfCZbTLbfvzfItMSks9WJvrM1P+dmqVquoZ9RPDAGSz7/mvAWz8S0G/Sw2lEEa6/chZzHvd4tWaierRajrtxmleSN4a4pqQCizwynB4Ek6+YBBYDdY1YWARPyuAV2+T9MlqLiovwyivkvlXi8VtEqNE43nn/uvRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=BDrJ5dJB; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="BDrJ5dJB"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78113fdfd07so630657b3.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567272; x=1761172072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Phkaa1Vx8yZsWadTH+C6kE0MLcTd8Z2yD4pgO5Do1zE=;
        b=BDrJ5dJBkfKcL4nAH/bEiQlQ5H+ur2w9Wh8lnEmmls5gz5tazRD/SpFl+xIC2xrFA8
         U+K0E1tInM/wJv2fPoWzsrF+cKXLeLqpEQwfnl8k55Lb0aeDSaIohaSVFGFLkOYvEwq6
         r7V/a47NBqX16uGDvCzGasQcjwRJc1E0T5rvv9LWeULxEY/QNn1CUnQEpHl6b92HMwAC
         MF4bppjH9mnpJZSfQeHjRb8a/CbRCSCZqBd2oEWahxaXHHLH9M1f49gF/F8tDV+Fs9N7
         i92cpJbhzF/1xO5cWaI7AtqtLyfb0pnwu+gQ0HjDgrdI4xsS6vnM+HsnODTMX7An3yMZ
         q0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567272; x=1761172072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Phkaa1Vx8yZsWadTH+C6kE0MLcTd8Z2yD4pgO5Do1zE=;
        b=Z6OPA1ixJ2hpnPmkuTBGfrggMlCxb0eflpb09nvaYM7Y72zST/+zl6biHxgqD7of2R
         s9QIxNfTJpP2yObPx0SG3j5HHTkqLTRTFyNvcbAoxNCocLVBIklWAERrXh106nuVjSnD
         i8d5Y0quLIH4pC5tKaEYOQSquBcF8vKuUE4GjsWp2QFls+i1/GZgtJis1wu4tUvatCs7
         gQjVnKU95l5qxo5QVJcuLMKD2YZubdoDjeQbREkSw26aw/Zi7g3LPL7POEq1ACHHkmp9
         kHMKsH+9NEEin8e8dD9vhwG5QAjugg5mvMA8ry6j43r1nJWlJCAL4GkfztrfoIHF0K8F
         4czQ==
X-Gm-Message-State: AOJu0YzYN41sKheMMM4KVMuMb2dRTQFGXAuAC0l6Ok/kVrLLSeo5eOAt
	KAU68WDg9KKQAYJDoyzOLOyz5cba1BRs+828aXoE+3vCth4GJjVYCJ6Qv4NQXM26oHmQ7zLDLb6
	N/rhVilQDVA==
X-Gm-Gg: ASbGncsn7sh24LEWj6l86XAqv55RyKWjR9pUEtc1J2Kd3dQq1/z6nUJ7yiXb9thewPp
	JkHegxbS8Hs4Wz43Rnb6F318KqHpeQLP4ek0TD/ZF4/UAIb4G9wTzEXjV7y5mYG2gTajseS6USK
	W3z1x9zU4OhbAUV8SOoqxbLBP1xfpOQynpjYkikTSgeMDQMatgQSlvEQ7M30NdFTQbD3C9xC6FE
	PiT4ZRWpEJDMVTccdVtE8rxlO5eWkETRfydKWs1I6apPqLFz9L33MttLKYrIl8K6XnPcQliRGts
	xyt7LRk3BJtz6sWh1ce8LiWeovD2BTR52QGhqzAXiTLr+ZlTiMtLD4VtijBWfmgmF/c3yRUGzas
	EZDrBNs1XOdUUOHd49hanviMwD99mjh6qRPbxyK5nkRNMaJCc3O4FsUKei5HovgmdvdV4mM3gk5
	0FH4tBNoETprnfKVwN7BPAa0RG17Km8uHhV88g0WdbShli95HEZkN4pC19I7ItKYBR/4UaCRePp
	ubmUGrpGxub6EjPOA==
X-Google-Smtp-Source: AGHT+IH534UOLX116Q4AWwfcmRq4haGqrPXkwnAMTkNHajdmCKEVR60/3nWkS8ywEe9+7sfTiAZJ6A==
X-Received: by 2002:a05:690c:2c11:b0:781:64f:2b57 with SMTP id 00721157ae682-781064f38aamr220177757b3.70.1760567271534;
        Wed, 15 Oct 2025 15:27:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7828d3c492esm2749337b3.22.2025.10.15.15.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:27:51 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:27:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 10/49] builtin/repack.c: avoid using `hash_to_hex()` in
 pack geometry
Message-ID: <c6787c865de6ce746096da0d5a526dc3d0be6aaf.1760567210.git.me@ttaylorr.com>
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

In previous commits, we started passing either repository or
git_hash_algo pointers around to various spots within builtin/repack.c
to reduce our dependency on the_repository in the hope of undef'ing
USE_THE_REPOSITORY_VARIABLE.

This commit takes us as far as we can (easily) go in that direction by
removing the only use of a convenience function that only exists when
USE_THE_REPOSITORY_VARIABLE is defined.

Unfortunately, the only other such function is "is_bare_repository()",
which is less than straightforward to convert into, say,
"repo_is_bare()", the latter of the two accepting a repository pointer.

Punt on that for now, and declare this commit as the stopping point for
our efforts in the direction of undef'ing USE_THE_REPOSITORY_VARIABLE.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a043704aa8..0d35f15b4b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -683,12 +683,14 @@ static void geometry_remove_redundant_packs(struct pack_geometry *geometry,
 					    struct string_list *names,
 					    struct existing_packs *existing)
 {
+	const struct git_hash_algo *algop = existing->repo->hash_algo;
 	struct strbuf buf = STRBUF_INIT;
 	uint32_t i;
 
 	for (i = 0; i < geometry->split; i++) {
 		struct packed_git *p = geometry->pack[i];
-		if (string_list_has_string(names, hash_to_hex(p->hash)))
+		if (string_list_has_string(names, hash_to_hex_algop(p->hash,
+								    algop)))
 			continue;
 
 		strbuf_reset(&buf);
-- 
2.51.0.540.ga7423965ad8

