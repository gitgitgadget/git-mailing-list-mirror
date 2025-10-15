Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD723101D5
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567368; cv=none; b=u3alj7ReATPjz3p8cAOXJYYilZC96aPa9vnFjhBGF0DgnoFKRWIlO7qKFqPnO3TMYBzvPY7OL+/g31MBcWUSr63HyfsOLti/L21xU1hyJamapEyB+lKDxOJfNqYepUNDXQD5or2sE7PhertYT2YybH4WlYxgX4UFSQsBrblv+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567368; c=relaxed/simple;
	bh=ttF6ZOYy7UBB6H98WzQreLTxQtdp9M/cLezsBMjnUFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ow5gRMR79pwLIf7AtglBPCPYp3w/R5WZ0UMwelVQcKj8AIFE0QFHYUBqz8A1FA51ktPfUHaq6Zvkp2R/EX/ojfZ5DZ98B5+/cyz3gmRAF2aosjUMgHKhngzg/47LrolsWwCBd8ylCmmgEjdtWiOY1oDPsbbjAbpqXyNYVkUhegI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=c9VbrOy9; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="c9VbrOy9"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-72e565bf2feso776937b3.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567366; x=1761172166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2mlAzcDreKCS1sE2wfxIubtOAAq8K3A1IW7VGbrRKE=;
        b=c9VbrOy9IRLaTqXJ7P8gAsklGsh8PDiFzCeMPkG6HzNptYBzyIBVPx/0M7+WKoV4eL
         3m51ye/IZPVS4Oitx6TvuDfhQGALZWjCJ/YX0K4zvuklFGkBopv4yZOGagk5ecpCtCiw
         MGDR4Dr2JVHCfkaZASb/sMQvHZ0rkCTyW4kBSNADUbojBm9j8FxR5xiGAvpRYixYjKbs
         pq7tLbYQCKyeSIL2zbyBThiE+QTftXLjz7czeyoR+1QkY13I5gGR+apx7pF5Y5ueMi07
         d328Z9Q2EbxmR/96B/pwtuJqq5FpFk4acT+Jn1iB8ZGMK6+cm+VXbwwnPi0vRWmIEnm8
         bUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567366; x=1761172166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2mlAzcDreKCS1sE2wfxIubtOAAq8K3A1IW7VGbrRKE=;
        b=bX4KVGj95RHVrdlGJnZ6Da+v/qiYzDynSJz7Duq/+Lw6xmWRLlzc0Sn/0Q6mTkIlTR
         2RgGoIlU25lcrNgZbVVA8cp0XHfxdisuCEhKfuvjP2a7T3ijXKG9JeQ9oij9UU0Eg0cu
         FTSg6BSNOyKyUF4KuBo96SGFV/6tU/LvrZPUqiHMiyc8VMkf5zseXK3IwYNXYZg0huZn
         pyxIxsWfDuQiNHFykT45wagpqiKxMh5dwEkG/ky3wXeBRh8kDMME+Q8U2a9M0vVwhTa7
         Quc/hk07h2gJ/nFGFYitZguegxiptk2l5KUSWpGSM4l3NZ05uJogrP5MArzCUGR+V5IT
         En/w==
X-Gm-Message-State: AOJu0YzDH2BqzFFp+bj1TlVVfdkK272NKWviP72Dk0rOUHQwTGeHsOiS
	oCyaySO4i4DE8n7sRkvKMhK9SaLUW9LsiKPqmWzt7LPUbTuzUvbsHtQVeIs6j5nyCfaKlZSGW3H
	hMl3R50jmow==
X-Gm-Gg: ASbGncsmQDKdv0a9OY64dGBO6oEH7LV3eFCFLE6Dp4NV6UCLH3leQqfebvKifEEqP1C
	IJ2SN+jDkmNvWN1sWGgnZjIr0vGFKZGp0XVLkwUKZTtITw4i7JqaLZMCfZv8rCmWE4X3rk3Tz+/
	ochLv+4QXqlC+NfRj8XvEJoN5pEuMt9koYSnKRfCFZkK7OblXmclAyjYGx58PM3XWXeXF28TQLc
	n/+8dxmBKGA1gbXPLQDZX+AYN0nbD6zLDVDFfHy6H1atYoLkF0FqKWZAWT6KPeSNhz4fq4LKYCe
	oSNPW8U20FECMuEkm5cDSZsJPz1mxPGfVHrTCeGoSIzrf15DcuWrCKcIQH4Mbln52v0Kraq2Ywo
	iEnWCshT2QqK8Zj1e4TqyCsl7lN34Vkl6VHmqz0GwHIFUpTjhGTZaE8WOeABPN7NVnorIx4pzxH
	NAPPWjChjMKN2i63uZywQIs/wNYC8YBV4vkt+z21nsm6mHY8nMAipFMq6ZkUng/5X8Ze7Ff0zTr
	B3GETI=
X-Google-Smtp-Source: AGHT+IFQ82WtIH//5F/SagPP0UKpdadcpRzKgd0oYaoQbB6suvfG9QQ+y84wcFDvXI0jgrpdUEtxCQ==
X-Received: by 2002:a05:690c:9a13:b0:765:d606:307c with SMTP id 00721157ae682-780e167f4d8mr326379457b3.22.1760567365880;
        Wed, 15 Oct 2025 15:29:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78290c61527sm2655327b3.7.2025.10.15.15.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:29:25 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:29:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 43/49] repack: extract `write_pack_opts_is_local()`
Message-ID: <5e3b615993e7f672a71eeca53235ee34aa799609.1760567210.git.me@ttaylorr.com>
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

Similar to the previous commit, the functions `write_cruft_pack()` and
`write_filtered_pack()` both compute a "local" variable via the exact
same mechanism:

    const char *scratch;
    int local = skip_prefix(opts->destination, opts->packdir, &scratch);

Not only does this cause us to repeat the same pair of lines, it also
introduces an unnecessary "scratch" variable that is common between both
functions.

Instead of repeating ourselves, let's extract that functionality into a
new function in the repack.h API called "write_pack_opts_is_local()".
That function takes a pointer to a "struct write_pack_opts" (which has
as fields both "destination" and "packdir"), and can encapsulate the
dangling "scratch" field.

Extract that function and make it visible within the repack.h API, and
use it within both `write_cruft_pack()` and `write_filtered_pack()`.
While we're at it, match our modern conventions by returning a "bool"
instead of "int", and use `starts_with()` instead of `skip_prefix()` to
avoid storing the dummy "scratch" variable.

The remaining duplication (that is, that both `write_cruft_pack()` and
`write_filtered_pack()` still both call `write_pack_opts_is_local()`)
will be addressed in the following commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 6 ++----
 repack.c         | 5 +++++
 repack.h         | 1 +
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index b21799c650..d1449cfe13 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -147,8 +147,7 @@ static int write_filtered_pack(const struct write_pack_opts *opts,
 	FILE *in;
 	int ret;
 	const char *caret;
-	const char *scratch;
-	int local = skip_prefix(opts->destination, opts->packdir, &scratch);
+	bool local = write_pack_opts_is_local(opts);
 	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
 
 	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
@@ -232,8 +231,7 @@ static int write_cruft_pack(const struct write_pack_opts *opts,
 	struct string_list_item *item;
 	FILE *in;
 	int ret;
-	const char *scratch;
-	int local = skip_prefix(opts->destination, opts->packdir, &scratch);
+	bool local = write_pack_opts_is_local(opts);
 	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
 
 	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
diff --git a/repack.c b/repack.c
index 19fd1d6d5b..d2ee9f2460 100644
--- a/repack.c
+++ b/repack.c
@@ -77,6 +77,11 @@ const char *write_pack_opts_pack_prefix(const struct write_pack_opts *opts)
 	return pack_prefix;
 }
 
+bool write_pack_opts_is_local(const struct write_pack_opts *opts)
+{
+	return starts_with(opts->destination, opts->packdir);
+}
+
 #define DELETE_PACK 1
 #define RETAIN_PACK 2
 
diff --git a/repack.h b/repack.h
index 5852e2407f..26d1954ae2 100644
--- a/repack.h
+++ b/repack.h
@@ -40,6 +40,7 @@ struct write_pack_opts {
 };
 
 const char *write_pack_opts_pack_prefix(const struct write_pack_opts *opts);
+bool write_pack_opts_is_local(const struct write_pack_opts *opts);
 
 struct repository;
 struct packed_git;
-- 
2.51.0.540.ga7423965ad8

