Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C57246AA7B
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632962; cv=none; b=QC/mJ18/uHtk8EKP6wCv6IasWY4S2mHw1Kdc2Sdq/pV/W27PM//Llkcd+3GM8M6Y6NuiQnQ8EW+zhxNwLqR928K0vDFMUs/OGjsMRmYUbr3tWAtKJC+yw133ytsTbrMWa2GWAVQ/kJ2PRxe7KyY4hyzE8PoJAo3/UVH72it8m0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632962; c=relaxed/simple;
	bh=YNGnyhvQ+aXZSnD9yxBIwF4sNWi7EWGl/SHmOLLRaTY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NF3dWcSLxjBz6PvQC5xjvaur2uCxZLNjZBUxsGSj++v05cWZXteP0pWf4WfCUQOgp63ugVdnDefEN6Lf1GfvGJrgN88O3HyJsP/57QnMpN8xQtHGZacQuhf/R1A5cHsKaLkUzmT/T0BDRcr4ph6nEcyZ9xMAqya5AdjKIYuUcD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD1Vw1lo; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD1Vw1lo"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4583b1703d3so373650fac.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786632959; x=1787237759; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NkN0X+fKhjqByZ/LMuLq95T9hx3OvhcZJG4a7lGfnkA=;
        b=YD1Vw1loYto8isinJbxel/Uua7WFYpqRGIWlUKkGeuoNjo1BPYpqHV7qwOv0t9nqb6
         o87HSxHXFuO20yek/pHx0cK9qknJYXg393LtJHu6AX5AyHDhMCGIq453QUPuBLLaGBpj
         W2szHOXI+1r7m7Odg2P6STzRHa3Cl893utf0IiaVP5L+T+jpwwe3o6poSQDKr3scD0+5
         q/z667awtdpi4BOAeCqlKe8UPka5yQjErgpZpf8x+4kHA407HdaCuMW4wxPa4Y7jR9kT
         WL7dLGMY+cyBtTJPz9EiRiZMdTGZW6UhXoXUlOG7IStbaNq63+t0xeusds32hmxJyg2h
         HCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786632959; x=1787237759;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NkN0X+fKhjqByZ/LMuLq95T9hx3OvhcZJG4a7lGfnkA=;
        b=BjH7bXi+lCrDkxVpYe+A2YDRCWwboXeZB/1+biSEPh5CU1VqXee/SzNHa3TFIxeXag
         EYqY8CibdyMR728AZYXuWeW5guOGktsrC+e78YZgOR8LmMSFt2B+/tkOqs4ZjqZCCfvS
         +41wDLYVUWRWCFcPbTdc6sx7I791cYWEH/52BFFkZiN791xhFVfhKeZHN3VKIWr0Kz2b
         HqvOt9Ric1l9YKj+mQnesDOhFtdEk3wdcIvV4VluAaN+rq5LBj6NE8p1N3j8/yamyWu0
         QlWcCC3QKdu1icvAShgxQv8j2+OsWV91Y73WyAHacsUJVKWR/edMgQo/f+KCb4/xnW1P
         0oOA==
X-Gm-Message-State: AOJu0Yxp3vS2bsUJkqWcN69iULeQOZkIDkH+TGWGhE4dF335+8BLMGck
	22Xz1vuDP6FfhC4EvmWpkpA+1F5az09eT6qWEtCRAmNTaWPxGxuh3teRHpMpkg==
X-Gm-Gg: AR+sD13dxCNHbtgXDza4kMj8hsCJoOg8CwIO6rmS2vOK1vJx9C54IVLrsJPkys8MPPA
	l5177CqYFWLvcNtw9ubRMdgSkYFzBXP0gLM36mNHwE9zmvelMGAmiBHCEBJ7v4jgg0XW2pxP7ML
	ZOx2+6Ntie34D9g+Dw+T3I4MlakduxC18lAtHSA5V+hPgLkhDPCZHkHup/KVgn03G9EgdDxtmFf
	JKosLViumnJMXYEBXmHO1yVmlysGIWze2A82bDSOeK5QFaz3npXS9J+OWiGA1FVTDKQGT4V1nk8
	waVuosFs9C8NnvMNujo267hWf2aLnMWMpReGg8XT/iNYXNvLLDxg3CZtDarCes6Z4+/nxm1ny2N
	uOwWfYWBDz4QnAb1OrBwOMsrewlySg6VPfEfciuYehWK5FWtyUEHoZmC9GXF9uBN9DCigO9U4HL
	TqZZ0iyGH7TtAd9LpAuoklIt5yZMRabdIHgjdAEpIdQYjJJsZ8CQPZMHMtfYOlQrNnXz6N0xFVC
	/I=
X-Received: by 2002:a05:6870:7083:b0:447:9474:df1c with SMTP id 586e51a60fabf-45e627e9da7mr5543817fac.14.1786632958631;
        Thu, 13 Aug 2026 07:55:58 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e64efd5d0sm1730672fac.4.2026.08.13.07.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:55:58 -0700 (PDT)
Message-Id: <5b54041bafca1de826ddb4466b3d5d8fcceba3af.1786632952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 14:55:41 +0000
Subject: [PATCH v3 03/13] pack-objects: widen delta-cache accounting to
 `size_t`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

These three are a single accounting tuple (the globals tracking
cumulative cached-delta bytes, plus the helper that compares them
against an incoming delta size) and are latently 32-bit on Windows where
`unsigned long` != `size_t`: a pack with many large cached deltas could
wrap silently.

The widening is internally consistent on its own: the additions and
subtractions against delta_cache_size already come from `size_t` sources
(`DELTA_SIZE()` returns `size_t`), and `delta_cacheable()`'s sole caller
in `try_delta()` still passes `unsigned long`, which promotes.

Prerequisite for dropping `try_delta()`'s `cast_size_t_to_ulong()`
shims, which becomes possible once 1create_delta()` and `diff_delta()`
are widened in a later commit.

Note: since `max_delta_cache_size` changes data type to `size_t`, a pair
of new helpers is introduced to parse config values of that type, too.

Assisted-by: Opus 4.7
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c | 10 +++++-----
 config.c               |  9 +++++++++
 config.h               |  3 +++
 parse.c                |  9 +++++++++
 parse.h                |  1 +
 5 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e3760b3492..97246c69ae 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -260,8 +260,8 @@ static int exclude_promisor_objects_best_effort;
 
 static int use_delta_islands;
 
-static unsigned long delta_cache_size = 0;
-static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
+static size_t delta_cache_size = 0;
+static size_t max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
@@ -2688,8 +2688,8 @@ struct unpacked {
 	unsigned depth;
 };
 
-static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
-			   unsigned long delta_size)
+static int delta_cacheable(size_t src_size, size_t trg_size,
+			   size_t delta_size)
 {
 	if (max_delta_cache_size && delta_cache_size + delta_size > max_delta_cache_size)
 		return 0;
@@ -3701,7 +3701,7 @@ static int git_pack_config(const char *k, const char *v,
 		return 0;
 	}
 	if (!strcmp(k, "pack.deltacachesize")) {
-		max_delta_cache_size = git_config_int(k, v, ctx->kvi);
+		max_delta_cache_size = git_config_size_t(k, v, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(k, "pack.deltacachelimit")) {
diff --git a/config.c b/config.c
index 6a0de86e3a..010a58d307 100644
--- a/config.c
+++ b/config.c
@@ -1268,6 +1268,15 @@ ssize_t git_config_ssize_t(const char *name, const char *value,
 	return ret;
 }
 
+size_t git_config_size_t(const char *name, const char *value,
+			 const struct key_value_info *kvi)
+{
+	size_t ret;
+	if (!git_parse_size_t(value, &ret))
+		die_bad_number(name, value, kvi);
+	return ret;
+}
+
 double git_config_double(const char *name, const char *value,
 			 const struct key_value_info *kvi)
 {
diff --git a/config.h b/config.h
index 31fe3e2961..b66dd08007 100644
--- a/config.h
+++ b/config.h
@@ -282,6 +282,9 @@ unsigned long git_config_ulong(const char *, const char *,
 ssize_t git_config_ssize_t(const char *, const char *,
 			   const struct key_value_info *);
 
+size_t git_config_size_t(const char *, const char *,
+			 const struct key_value_info *);
+
 /**
  * Identically to `git_config_double`, but for double-precision floating point
  * values.
diff --git a/parse.c b/parse.c
index d77f28046a..266bbd539b 100644
--- a/parse.c
+++ b/parse.c
@@ -134,6 +134,15 @@ int git_parse_ssize_t(const char *value, ssize_t *ret)
 	return 1;
 }
 
+int git_parse_size_t(const char *value, size_t *ret)
+{
+	uintmax_t tmp;
+	if (!git_parse_unsigned(value, &tmp, maximum_signed_value_of_type(size_t)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
 int git_parse_double(const char *value, double *ret)
 {
 	char *end;
diff --git a/parse.h b/parse.h
index a6dd37c4cb..db742f35fb 100644
--- a/parse.h
+++ b/parse.h
@@ -4,6 +4,7 @@
 int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
 int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max);
 int git_parse_ssize_t(const char *, ssize_t *);
+int git_parse_size_t(const char *, size_t *);
 int git_parse_ulong(const char *, unsigned long *);
 int git_parse_uint(const char *value, unsigned int *ret);
 int git_parse_int(const char *value, int *ret);
-- 
gitgitgadget

