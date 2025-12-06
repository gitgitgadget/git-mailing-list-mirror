Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A0B260566
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053104; cv=none; b=ar01zSKaT2Tt8i0s1Iboy4dN1ncsbONaFXUHtsFKknyGb9q3oIOeNOiVG0MO+2LRPw2XExgfp3e3IOmxw8F5UGT2vpEk1PwYTmDWJwLZuRdcum+mc2k9+TLTxWcQ02bAAMervDIk+VqMH4wQRGFn18rV+ZoCregN9XkrSlP3+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053104; c=relaxed/simple;
	bh=AU3XvrYfgaqzZDEsxYsJdUxLfFSOo7d89PCxmx+GNls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHJA8+0mEAxIbPzOlZO0JodVBogLDYubEdl46bTeOONU7A2NxJpekxwSV9C9bBVrLh/fuvWRwNBgC9/MM7UUKL27voziRdo3ftQz3s9XRDd25NU1xshaCPU6wY1OlBWEig13UTpGnlt3v6sGs59SJGQyY0s64E2ofipb2eqA6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=A6t/EVP1; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="A6t/EVP1"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63fc6d9fde5so3178060d50.3
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053101; x=1765657901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6uYyUok4kCkUbfDq1iks+lVpJMVX7yI3LYf81468PjA=;
        b=A6t/EVP1WS+3cvttg5THnrYJ5vJxCCVAaK49ujPWDxTvSGHJRkXzFfIl4LvIwjiEbR
         0KNYyhdph2rZB/DqhLb4f8L8tm8JzFxtH5NB4HNEHH+kspRlTmM88YdQYUzUoSonOux1
         W0U0YjfGU0LNrHayb1KISpDNALQu61C/OwFHThon7l0TXWMzTlni8HnviyVM3DfZkY+Y
         A7b/YITKyPUpUQCeHrGNo6PLtkq6ad/xVxPsHEmuAuBYP4ZTufQ75UWtZU5D7K9jATey
         ZHqAOInYD3LA7FssHA8RgNfoNB3tGVZ5BJQbTrTBtgNwuXeof6VvcTtYeC6PtIwkJwp0
         UBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053101; x=1765657901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uYyUok4kCkUbfDq1iks+lVpJMVX7yI3LYf81468PjA=;
        b=kCDP0yoyiZ67zV4WygjFiKN1psiDw7B9iBd49Th3/t7FDFCMgMm0aF+nv1fbx/I3kg
         EO/AJe1jvaqucZk3UqMSDfdU16f2vk59MFbBGpjFNCGZIS8aTmtele054ChDY13bQnIx
         2AJ9zqJZjosV5NIEDhwmZ48M6fCLcHjaSXW3nUFtfImV9cALpLFW5EyuH8IpvHO7Adtu
         rvxI3dWWestm7ldRKVaP2gI9lUnsmBzSNGU9YSuyWUw0F+QlpVHJGjzYDU0njP7QQ0aE
         Q31MIyD8l6QBtyW2OSOJkc5zl/jrboVr5y97oBJPp90EOlTH2+zwzAvDaU+4XWD3qBHd
         NVXg==
X-Gm-Message-State: AOJu0YxPCZIRp6wgauF7owhXGNR8ncum4AeJKKlV75ApBZEysCjh49gG
	PVI0sNhydYr2KnGJybJBhSlWnxDbbOWjiUDP+F13/ZMIvGa4gTgBRU0a1X99IZFS8feHqkh27zH
	BkfrWvJI=
X-Gm-Gg: ASbGnctzPFFE3/yYmBkWMyJImlgyl47YB4eSjiySw6NHDyTLlJTbtzY0a/8qBt2KxNk
	KgCuVtvPcvhjqnj1trJiqczIoR/T5Snxr2R5/kPh99OHSkUG6s8+MYFwVxuNgSnNAaSfXksXSYw
	KRj+DO6RCiIrwtOHEtF1TovPmlE+riLr4WyJ1FAFH0AyIiLrS6Jby6a+3GGiG4qxej73CKhEQAT
	XW//IIRLHKiV/bl0RaOCVJA3dxe0BPeK4TTmjyiC4YF9tpDhDw6+pU2kNrAUXCmRr/nCeJeHEFP
	d/gSvl+5du8YN9p+ikH5etEs6XrDX+o/P2ytURLaAkVSI8z6L6wfRbCXqUyZDPH+Xbzb1LwaSwy
	Smz39RSlgLF2qHdA6joFf82S8jwUiNLNW9z/74+FUAU/LvuPjwRyZyqHSFCVVyw/w6B63BDNHQT
	ck3Xwc2bOhIMNvOPcsZqOYuSrxppBKweGW8Wnx0z4kvaRHBxyT8F4YnrFGm07W6a+rsstp2SCeB
	jnuwgVFHtUgQOAkPw==
X-Google-Smtp-Source: AGHT+IE8uFEq+yqqteDt78FnrznBa7msKvReMvfxilKCgGGz5f9ZryaGmK/w0Gcy8iBW0fwfSzPk3g==
X-Received: by 2002:a53:d049:0:10b0:640:d119:d339 with SMTP id 956f58d0204a3-6444e778bd9mr2044299d50.33.1765053101458;
        Sat, 06 Dec 2025 12:31:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c2fb791a2sm15036237b3.7.2025.12.06.12.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:31:41 -0800 (PST)
Date: Sat, 6 Dec 2025 15:31:40 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 14/17] midx-write.c: factor fanout layering from
 `compute_sorted_entries()`
Message-ID: <d94222ba33050e69ed59d363873cd98ee31f8b6b.1765053054.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

When computing the set of objects to appear in a MIDX, we use
compute_sorted_entries(), which handles objects from various existing
sources one fanout layer at a time.

The process for computing this set is slightly different during MIDX
compaction, so factor out the existing functionality into its own
routine to prevent `compute_sorted_entries()` from becoming too
difficult to read.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index d3644276aad..7854561359d 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -323,6 +323,30 @@ static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout,
 	}
 }
 
+static void midx_fanout_add(struct midx_fanout *fanout,
+			    struct write_midx_context *ctx,
+			    uint32_t start_pack,
+			    uint32_t cur_fanout)
+{
+	uint32_t cur_pack;
+
+	if (ctx->m && !ctx->incremental)
+		midx_fanout_add_midx_fanout(fanout, ctx->m, cur_fanout,
+					    ctx->preferred_pack_idx);
+
+	for (cur_pack = start_pack; cur_pack < ctx->nr; cur_pack++) {
+		int preferred = cur_pack == ctx->preferred_pack_idx;
+		midx_fanout_add_pack_fanout(fanout, ctx->info, cur_pack,
+					    preferred, cur_fanout);
+	}
+
+	if (ctx->preferred_pack_idx != NO_PREFERRED_PACK &&
+	    ctx->preferred_pack_idx < start_pack)
+		midx_fanout_add_pack_fanout(fanout, ctx->info,
+					    ctx->preferred_pack_idx, 1,
+					    cur_fanout);
+}
+
 /*
  * It is possible to artificially get into a state where there are many
  * duplicate copies of objects. That can create high memory pressure if
@@ -359,23 +383,7 @@ static void compute_sorted_entries(struct write_midx_context *ctx,
 	for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
 		fanout.nr = 0;
 
-		if (ctx->m && !ctx->incremental)
-			midx_fanout_add_midx_fanout(&fanout, ctx->m, cur_fanout,
-						    ctx->preferred_pack_idx);
-
-		for (cur_pack = start_pack; cur_pack < ctx->nr; cur_pack++) {
-			int preferred = cur_pack == ctx->preferred_pack_idx;
-			midx_fanout_add_pack_fanout(&fanout,
-						    ctx->info, cur_pack,
-						    preferred, cur_fanout);
-		}
-
-		if (ctx->preferred_pack_idx != NO_PREFERRED_PACK &&
-		    ctx->preferred_pack_idx < start_pack)
-			midx_fanout_add_pack_fanout(&fanout, ctx->info,
-						    ctx->preferred_pack_idx, 1,
-						    cur_fanout);
-
+		midx_fanout_add(&fanout, ctx, start_pack, cur_fanout);
 		midx_fanout_sort(&fanout);
 
 		/*
-- 
2.52.0.171.gd6a4e6b6955

