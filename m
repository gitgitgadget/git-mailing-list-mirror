Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B46630BB83
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567366; cv=none; b=qv5pKKkQF1wdPzH1pqP72Bdr+OVyYdDUUWmlz0Pol6hdyD8KQwhgCmEB2lyz13paUL0+6nB9J6SMwV//EnfikX8zUn3KuGQ4yXyWkTWFq6bs5j9XhyIUVT9HPHc7nFA/UWSGUIs9b8DsmciaSq7tUg2kKfRovstEzYioWZq/OeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567366; c=relaxed/simple;
	bh=SNTtxu2SE6gi4eMrnGpTIKGxYHJh8gRLlaL+3Pz05No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5JppyJrpJSaoqk0I9r1Q4XCeb95Kfp7NxiS8kRamI2mtDzMcw/50ISUC6iVsQ/qDfB9e1owYjxwZ47yTI+egms8MPH1PekIaAPFXGtlPOC4mnd1fRwseTAV6TK8SJZoy2vOJPMZ9At0sTS7aGq9EaLbWYuMLLnASZd8xlQXR0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=LSbZPC3Z; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="LSbZPC3Z"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-780fe73e339so524967b3.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567363; x=1761172163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mq14fEKjGB/iNkgSHTuMdXWc03RZ7gLlltrxP8Ymlo8=;
        b=LSbZPC3ZnRgaNIjLY/K1VHfVFs9HdpXDuOf4Ld8w6CS96eC73QiQvd8Jry9mPm+bbc
         v5+ztuYiDYwQv4lIeH80GsCz12EV+lhsxj3UyCkT3esSk0Tw1EONDOLCNGqlUbWJNVjQ
         H9QSV1oqHIZ03yQY687y5EfnKhSD+R2SsjcT9iEILKXQqbAsgGK3XRF0q0cElFtE808h
         lpoMjOttUXAHZ7OzOCHL3BJnZnkjcrJAWu2yTJjw1Xk+qzlxxI1hIN/8OzQ0zGBOdk1K
         ZfzmR2pvzYkbBVWi15ytDeSP1kYiOONwE939OBcdqO2NmXsH70l+e3dEqH17iEVbXOUy
         SQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567363; x=1761172163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mq14fEKjGB/iNkgSHTuMdXWc03RZ7gLlltrxP8Ymlo8=;
        b=a18RNeorMYnjdqLoVhrML6AC+BenZYhbrFJBZbas6wgkeEFlpbZ7ksRmQgUrKybb7A
         oq5YHc9tBRlvtnnXlEIGdljKt8ucNaQu5Y0iPJjlV7PuJPnJr+rtR+dhWMTzCO1RrTmO
         4sufNAKxNdaMx8npotxI1R5NNFzfv9w+KVuEvVTV/HmXbjyhOouaLTpu3Ii8F16L2ksv
         dItycoPlxgUhiI4pffJrVpvlxG5b9SerxOsa2zVfL8StAChuIOTQuEw+LYFDF8uOsUFU
         6YY6I80vYsMyKPyZS+ip/KVKLhfwBKKzlAdtJ92wATo/65ykZVqk6Na66sVISvJRtCMP
         9B/w==
X-Gm-Message-State: AOJu0Yw0SodN5Hhk2/muz+MzTSFGi/uqpu7abcbMYNtUUG0qa+C5Z/Zo
	uDOg7CnMbnm0wi+EfqQWEuyyTGnkHaJlbJN5bCEA9CJAQUQPl7hd70syuC0mq97/rLYiA8izknS
	XbLtxxNgAm8sW
X-Gm-Gg: ASbGncs5j43YAztCLeABImXXpXgicAPT3s3pC5D1ppCZA+AcPA2pAwCDtKJvg2GvdY2
	MuJRRdXjCB5BshmzOhWznVQTgJkXlIZvHwb2wh360hklwa1ev1Jc9xuq6r5uj8fdqU+rqIpnQIZ
	XiP7y/HE2jPWt0Vc7qHn1NzgQz+70cmXmaqwvXQ59V/6JAvXLcnuhMYHg/o76fglqy+8xZeHJD4
	XRR+foRkYwH5bbOic5ViJsfXNzhZ884PtSdRKtQWm+s7Tj+XEOvcz2TWkWmZyeV9UE/755hbn5n
	IIuNqmtzHDYHmHyI45/YI7+ckF38y0XZUe8V+hCyBTg0aIUxfS8hg1f/KDaZTx9vdcjW/n1v1nc
	HVSIURPXT9IJ+nc73V4lQgWD0nwbk//N0BFrQGYbmaOflM6spf8JKQXRHn/lKbdoN4IKASZPS2q
	aJHkdtw09viCHfJhHP6Y+WmuyOfnUgkMKHNH3XsZL6IiGVwi5IhWgd3jkxdmoBV+FJWoeoeeqj+
	EPT1Ck=
X-Google-Smtp-Source: AGHT+IEwYLL+AJ9tnH5Z7u4tJPQ0A4FxPPsRZ4xAMk0SsmPo/8NdVrZEh0lxjsrfNbojbeRArs9jCQ==
X-Received: by 2002:a05:690c:998f:b0:746:ab85:ef4f with SMTP id 00721157ae682-78269ff0089mr16760207b3.25.1760567363154;
        Wed, 15 Oct 2025 15:29:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-782932f3299sm2579347b3.46.2025.10.15.15.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:29:22 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:29:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 42/49] repack: move `find_pack_prefix()` out of the builtin
Message-ID: <43116b8942a487724d0172a7977d7c92533143e3.1760567210.git.me@ttaylorr.com>
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
index 7295135ec2..b21799c650 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -149,6 +149,7 @@ static int write_filtered_pack(const struct write_pack_opts *opts,
 	const char *caret;
 	const char *scratch;
 	int local = skip_prefix(opts->destination, opts->packdir, &scratch);
+	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
 
 	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
 
@@ -173,7 +174,7 @@ static int write_filtered_pack(const struct write_pack_opts *opts,
 	 */
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, names)
-		fprintf(in, "^%s-%s.pack\n", opts->pack_prefix, item->string);
+		fprintf(in, "^%s-%s.pack\n", pack_prefix, item->string);
 	for_each_string_list_item(item, &existing->non_kept_packs)
 		fprintf(in, "%s.pack\n", item->string);
 	for_each_string_list_item(item, &existing->cruft_packs)
@@ -233,6 +234,7 @@ static int write_cruft_pack(const struct write_pack_opts *opts,
 	int ret;
 	const char *scratch;
 	int local = skip_prefix(opts->destination, opts->packdir, &scratch);
+	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
 
 	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
 
@@ -265,7 +267,7 @@ static int write_cruft_pack(const struct write_pack_opts *opts,
 	 */
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, names)
-		fprintf(in, "%s-%s.pack\n", opts->pack_prefix, item->string);
+		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
 	if (combine_cruft_below_size && !cruft_expiration) {
 		combine_small_cruft_packs(in, combine_cruft_below_size,
 					  existing);
@@ -283,17 +285,6 @@ static int write_cruft_pack(const struct write_pack_opts *opts,
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
index 1d485e0112..19fd1d6d5b 100644
--- a/repack.c
+++ b/repack.c
@@ -66,6 +66,17 @@ void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
 	strbuf_release(&buf);
 }
 
+const char *write_pack_opts_pack_prefix(const struct write_pack_opts *opts)
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
index 6ef503f623..5852e2407f 100644
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
 
+const char *write_pack_opts_pack_prefix(const struct write_pack_opts *opts);
+
 struct repository;
 struct packed_git;
 
-- 
2.51.0.540.ga7423965ad8

