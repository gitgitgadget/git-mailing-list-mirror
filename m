Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A942673A5
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097408; cv=none; b=WWzKvO4GVokhivAC9ltm0lBo5N4pcJFvNjFeqqmhnj0RNyqZTJ5nCZSVqanPvfmhonT8WRTJs5pynuh/RH+pYAh3GLMrzIUwwZwsAA1ElxMk6XBbUaK9aofxKE3i4K1aImMXy2vzGqzGs09iXuGpXGp/+YezTvQhOemSXEkt/ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097408; c=relaxed/simple;
	bh=gOBNJreyH2wimbekOBlQbmOB4HOSGzaoXBIP1IESxeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSoUjcPp+flIFrhRXo0OP3dkkqfVG76Hc5IAOPxE/7MCVjuofWPfUce58PrJZqE878oT3aD/bzTOFHMMVODkwUDLQkH3aEdBSiOZys096xFUb9bJ30QVgiBOunnSVnqfdV+VH4GbcLhkzDgW2v0sTVgYzQkeZX0GB13CAztLxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=iDKs5Yvp; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="iDKs5Yvp"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-71d60504788so39627687b3.2
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097406; x=1759702206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9V5EnoM9Mdm32d1+XWoqgzML085bue++qQw3g0EpUzc=;
        b=iDKs5YvpULAfJ80DtSEFkVA9M3rpVvJWp/l5URegtCVJgkNuDXTGqQBYMPKLa73CSS
         EPr5UTwwIrDuarGRgLM1PvSoxluSZMTl3+N1PdBgA9pW4VZ+cQn3ZRAmSfT+JiCR/P56
         0Gg++vj8IHuOLGsZ7B2Ipfmwkg9vZGON2xQfsGFGwy8flneTXEKLErYkggLh4BziGsH2
         H+RwDnIbQcDiRYt8gF9IfQ7depM0ycCMp8RCc44ZqACja5U2Jnp1uHUCSSC9PPJuR0kA
         0oulPbctLok9mSGq11Zdes2kjEdikUZv4M6jYAAQMdrTMAShoj3MbvWdmpgvfaV+83pW
         RLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097406; x=1759702206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9V5EnoM9Mdm32d1+XWoqgzML085bue++qQw3g0EpUzc=;
        b=q0Ucq8VqpUg7VuTZJ+8kF3WkDDWwNnimUc5V/KHIGcO3XgbJCqy+zO66gFyUb4gjRb
         v31zw/MnQSHDOL0KbAPcGwu3trP1EFcX5rhXGimxkzI+ZYRFO5CegWIkFR1mhAu8FR1/
         kK9hXizScM6xp/lQvOgK4YSZZBz0TsVmhbW0gUAxdDJJC0FjArkkCCfVqjkAgMkhUjMY
         sTxjd8rPhlSRLxzH4ZC7U285709d9Dqxl2ihPasPUc6pQpOuO7N3wcYVfG0ZDYpgq0a6
         z8+Jr+yii46PA76Qa6P0eBVXCEFAird0ZIIeV6VEcCjQJhF1BuRLG3PWjPKKA7gumHu1
         CN6A==
X-Gm-Message-State: AOJu0Yw/JTGCmsoYz94rYNSsuK4qY4LCHWpNuc8j1xt8erzAPBELkcMK
	+0auQOWQYrqJ9a3FGs+AMUBaCxtIJUXSQFYv821Q4UFqXgsktH3xG4E9Au7zOrcyi8PEDNSlkhs
	zCRpCmRrVhpDM
X-Gm-Gg: ASbGncs39LNnqhrex79TeaEP7sgnYC7QUv15SUBHfKPVkmsKKDWChciMNzekvvfiOpb
	xtLGtLiQA/ZqBK3yB479iNabfh7dX60TND4GO8u1Fj4RWEb39IiJt5ytULZTV6yX1xtG7MzRllw
	A8OIpEU68o18jYkUlZUlRYVoOGN+zucw5Rp7RRefsIBUpH4QbmyqCLregSHD9OU24zmxz9sKlBA
	Xs1Upm00fuRZIn0zXAVUN/wvQXmA0qUSCmvbPBal+NJ4FEdt52wV+bYJn40SRzGip477UyL6zb+
	VQAPN/6WNR45/7uCyCFCKSKZC77H7ruuFc503rvxbdG3g3KiiWYptusIuuzuk0t9GVbD8CbNSl7
	GwXufjewz7kQ/4sf8HV1NQTrhZYO/nklSYd41I6CPf0JqYb2QJuY4RVRowjJvjP+Y2WlhGqk7oF
	SGO6Sg8kBU44bxUkWplysEuuilmOr8jc6kIhfh
X-Google-Smtp-Source: AGHT+IGxAxgTMwc5NbJW3s7zfRgcPPpJAbXo5N2tCtXit15noTMGa56i8Xb85DXh0Y9XF6ghvdwrPw==
X-Received: by 2002:a05:690c:a9b:b0:749:d874:e66e with SMTP id 00721157ae682-763fd9e5686mr175953517b3.24.1759097406055;
        Sun, 28 Sep 2025 15:10:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-765c60b7a41sm22691367b3.35.2025.09.28.15.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:10:05 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:10:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 42/49] repack: move `find_pack_prefix()` out of the builtin
Message-ID: <c50ffce0781d0fbb24eb72f437dab257694a6b99.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

Both callers within the repack builtin which call functions that take a
'write_pack_opts' structure have the following pattern:

    struct write_pack_opts opts = {
        .packdir = packdir,
        .packtmp = packtmp,
        .pack_prefix = find_pack_prefix(packdir, packtmp),
        /* ... */
    };
    int ret = write_some_kind_of_pack(&opts, /* ... */);

, but both "packdir" and "packtmp" are fields within the write_pack_opts
struct itself!

Instead of also computing the pack_prefix ahead of time, let's have the
callees compute it themselves by moving `find_pack_prefix()` out of the
repack builtin, and have it take a write_pack_opts pointer instead of
the "packdir" and "packtmp" fields directly.

This avoids the callers having to do some prep work that is common
between the two of them, but also avoids the potential pitfall of
accidentally writing:

    .pack_prefix = find_pack_prefix(packtmp, packdir),

(which is well-typed) when the caller meant to instead write:

    .pack_prefix = find_pack_prefix(packdir, packtmp),

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 20 ++++----------------
 repack.c         | 11 +++++++++++
 repack.h         |  3 ++-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 501359c580..4d86920618 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -149,6 +149,7 @@ static int write_filtered_pack(struct write_pack_opts *opts,
 	const char *caret;
 	const char *scratch;
 	int local = skip_prefix(opts->destination, opts->packdir, &scratch);
+	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
 
 	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
 
@@ -173,7 +174,7 @@ static int write_filtered_pack(struct write_pack_opts *opts,
 	 */
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, names)
-		fprintf(in, "^%s-%s.pack\n", opts->pack_prefix, item->string);
+		fprintf(in, "^%s-%s.pack\n", pack_prefix, item->string);
 	for_each_string_list_item(item, &existing->non_kept_packs)
 		fprintf(in, "%s.pack\n", item->string);
 	for_each_string_list_item(item, &existing->cruft_packs)
@@ -233,6 +234,7 @@ static int write_cruft_pack(struct write_pack_opts *opts,
 	int ret;
 	const char *scratch;
 	int local = skip_prefix(opts->destination, opts->packdir, &scratch);
+	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
 
 	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
 
@@ -265,7 +267,7 @@ static int write_cruft_pack(struct write_pack_opts *opts,
 	 */
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, names)
-		fprintf(in, "%s-%s.pack\n", opts->pack_prefix, item->string);
+		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
 	if (combine_cruft_below_size && !cruft_expiration) {
 		combine_small_cruft_packs(in, combine_cruft_below_size,
 					  existing);
@@ -283,17 +285,6 @@ static int write_cruft_pack(struct write_pack_opts *opts,
 				       local);
 }
 
-static const char *find_pack_prefix(const char *packdir, const char *packtmp)
-{
-	const char *pack_prefix;
-	if (!skip_prefix(packtmp, packdir, &pack_prefix))
-		die(_("pack prefix %s does not begin with objdir %s"),
-		    packtmp, packdir);
-	if (*pack_prefix == '/')
-		pack_prefix++;
-	return pack_prefix;
-}
-
 int cmd_repack(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -596,11 +587,9 @@ int cmd_repack(int argc,
 	}
 
 	if (pack_everything & PACK_CRUFT) {
-		const char *pack_prefix = find_pack_prefix(packdir, packtmp);
 		struct write_pack_opts opts = {
 			.po_args = &cruft_po_args,
 			.destination = packtmp,
-			.pack_prefix = pack_prefix,
 			.packtmp = packtmp,
 			.packdir = packdir,
 		};
@@ -667,7 +656,6 @@ int cmd_repack(int argc,
 		struct write_pack_opts opts = {
 			.po_args = &po_args,
 			.destination = filter_to,
-			.pack_prefix = find_pack_prefix(packdir, packtmp),
 			.packdir = packdir,
 			.packtmp = packtmp,
 		};
diff --git a/repack.c b/repack.c
index 1d485e0112..c4326a532d 100644
--- a/repack.c
+++ b/repack.c
@@ -66,6 +66,17 @@ void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
 	strbuf_release(&buf);
 }
 
+const char *write_pack_opts_pack_prefix(struct write_pack_opts *opts)
+{
+	const char *pack_prefix;
+	if (!skip_prefix(opts->packtmp, opts->packdir, &pack_prefix))
+		die(_("pack prefix %s does not begin with objdir %s"),
+		    opts->packtmp, opts->packdir);
+	if (*pack_prefix == '/')
+		pack_prefix++;
+	return pack_prefix;
+}
+
 #define DELETE_PACK 1
 #define RETAIN_PACK 2
 
diff --git a/repack.h b/repack.h
index 6ef503f623..46d2312fa9 100644
--- a/repack.h
+++ b/repack.h
@@ -35,11 +35,12 @@ void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
 struct write_pack_opts {
 	struct pack_objects_args *po_args;
 	const char *destination;
-	const char *pack_prefix;
 	const char *packdir;
 	const char *packtmp;
 };
 
+const char *write_pack_opts_pack_prefix(struct write_pack_opts *opts);
+
 struct repository;
 struct packed_git;
 
-- 
2.51.0.243.g16eca91f2c0

