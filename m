Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BECC19C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097398; cv=none; b=MEvKFSAviFYgNjQPnfIzwd7Ip6dUS5WeDifPCuy7ImuBfSV4Ohc69M9wyaJzCwcoKdZdR23EHqxgmCpPE3rskZOyzgvTO72VniZCq0OLybIFVTFE0f7IOnpYKZoDPfh0C4zHQcuTl+rpk0eQY+KieIk8gicrd/2s+Qy/KcCMXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097398; c=relaxed/simple;
	bh=6wr3ixb98+ZqOMhKZHKdsg4Q7iWK9qaNYSCaJK5khw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgTBOdi+DohWInVSCsUwbXFnjZSCM9soGIODb5KkFwb29uzchGRTHfCLCNuR/0swc01jpp0kWxncbn2J6DJMhBRRAEzjxwDsmxoPsIL+GdGAux2UvqAbQcaMHbqB1p8I+yo0S4/68dxcaI++lAH7VEqMyIqwuv+zkvn8cceZhNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=kqQkBSEt; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="kqQkBSEt"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-723ad237d1eso41802157b3.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097395; x=1759702195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PlcxYRkmmeTbZUIG8NBAby2nVHE4zbKx84egJgcxo5k=;
        b=kqQkBSEtcIF1jTDGXayRme8vyhsCd6gdqMk1Lx+jQIFIcftVdymzNDSSQobcE/tDO5
         2LwHFpprb2urTsbUQniBf2fjmwPHWw1Ujve5UbfL34MN0rCgadstVyBBWookvJfcrZZe
         eyGeXHISH5w9qJ/o/5gTCWWhNeSpk221EshE/j8ly/xKmKX9YXKJSIHHKWUnEVXCziMj
         elgSPWOsU5cp+jKjv8JQ7wYP0hxUd+BIHMf4x90Q9JkFt5wOJvZjBwcM7/a0QxXNWGeV
         UyPL+ldVzl+dX7bvAkl7WDKSmQcX0otzRvpVqXAMBTLnMotCqXD7UcHxC5yotNlXByU9
         /iNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097395; x=1759702195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlcxYRkmmeTbZUIG8NBAby2nVHE4zbKx84egJgcxo5k=;
        b=uhTjLHkN6CcD1OUW10nKJmaZBOsWAQrjXPMiRMEiRG2gpBKZMmzEf3RpHm2SA1KR2k
         +IvhfdAPEaSVVwhB/GgM9loPf7RhS/672bqAXniuhKy+EUxrxExi61tyjoaZ/JDriH+e
         59keRFZ+xUIOkvyXf8X6/QOYbHYK1+3UKbO1cmgnnA0+PhSj6JOj7WGJDUBQGdGL/y10
         43JTWwX0dcT98BCVkse4mhWARz1/bC9THyFmPpUlQEkqSBjxFh8DGbsGR10Jng4gztR9
         kIy8l5U98GKVxJX4xvolwl2Xcdb3hrKI3WsgdMKOl5o+Py+2n+jF8OJI9n1thiweN/aT
         nSfw==
X-Gm-Message-State: AOJu0Yw6JRE2GZlzWPFc/3aVi4BUdBLrm4yyx5YOzDbX7R3+3mQRGss+
	LfKtDLhxpaJ85ff/G0LhElj8/2ZSEbt4N/AACS0BaO12o9/G73HZmJ+5QPod2X7kZy46N7Kv+Nu
	G+J+oShw=
X-Gm-Gg: ASbGncsdXkEel+xytmb1f+tEaeWzLRS6JeiohEkGW6h0OcTFpeQX04CTIp5+CBhPMiB
	MJMPUjqWW4PIjvZa/bWEs/9F0TN+kduZJBucqboGkMTDS5IeXDo8D2oCanNIW+TT/RF5MutPbxk
	eFZSkw0fTGAAyqJGlCqbE2tZN5Iel+l/ME2OMtgZUDouzF4PKYelPgTvoogPwDOcKYj/rsmY89x
	OUlicGQvqqoje+CUkY+WaFP6BjX8mlL2r5b9M/i7sTg9fX/TGQAZyS/PTpCoOC2myi15lguqsYE
	3QrseFMOquBiaBWYPOUxb3WJ1MDMfuzHzjAhjt9fPaWjZFFkva0kKV3DxW4DADMsG3dD3f1cEED
	loGxJ0cC1mjIhOJwwPq2N8oH6DjrdYojSkyDVcFhI8+A8oNMqISllNsdVwCDAkLb4hm+ZokP14f
	EFgVXz7wvcGyX+OM8uj5MkYEyYRg==
X-Google-Smtp-Source: AGHT+IFmfpvmkhN+iH3E5zsUf/Fc+QYUS/A1VTD7JVPj8f4dAPZ1Cw7ZappjhZkOupB6U8MHntAWhA==
X-Received: by 2002:a05:690c:d84:b0:76b:c002:71bb with SMTP id 00721157ae682-76bc0027599mr126791207b3.4.1759097395468;
        Sun, 28 Sep 2025 15:09:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-765c60b7c4asm22748497b3.36.2025.09.28.15.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:09:55 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:09:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 40/49] builtin/repack.c: introduce `struct write_pack_opts`
Message-ID: <109109618687efeb932bee7dd5882557ab0576f4.1759097191.git.me@ttaylorr.com>
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

There are various functions within the 'repack' builtin which are
responsible for writing different kinds of packs. They include:

 - `static int write_filtered_pack(...)`
 - `static int write_cruft_pack(...)`

as well as the function `finish_pack_objects_cmd()`, which is
responsible for finalizing a new pack write, and recording the checksum
of its contents in the 'names' list.

Both of these `write_` functions have a few things in common. They both
take a pointer to the 'pack_objects_args' struct, as well as a pair of
character pointers for `destination` and `pack_prefix`.

Instead of repeating those arguments for each function, let's extract an
options struct called "write_pack_opts" which has these three parameters
as member fields. While we're at it, add fields for "packdir," and
"packtmp", both of which are static variables within the builtin, and
need to be read from within these two functions.

This will shorten the list of parameters that callers have to provide to
`write_filtered_pack()`, avoid ambiguity when passing multiple variables
of the same type, and provide a unified interface for the two functions
mentioned earlier.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 28 +++++++++++++++-------------
 repack.h         |  8 ++++++++
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 5fed79e826..6df7c88085 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -138,9 +138,7 @@ static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
 	return finish_command(cmd);
 }
 
-static int write_filtered_pack(const struct pack_objects_args *args,
-			       const char *destination,
-			       const char *pack_prefix,
+static int write_filtered_pack(struct write_pack_opts *opts,
 			       struct existing_packs *existing,
 			       struct string_list *names)
 {
@@ -150,9 +148,9 @@ static int write_filtered_pack(const struct pack_objects_args *args,
 	int ret;
 	const char *caret;
 	const char *scratch;
-	int local = skip_prefix(destination, packdir, &scratch);
+	int local = skip_prefix(opts->destination, opts->packdir, &scratch);
 
-	prepare_pack_objects(&cmd, args, destination);
+	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
 
 	strvec_push(&cmd.args, "--stdin-packs");
 
@@ -175,7 +173,7 @@ static int write_filtered_pack(const struct pack_objects_args *args,
 	 */
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, names)
-		fprintf(in, "^%s-%s.pack\n", pack_prefix, item->string);
+		fprintf(in, "^%s-%s.pack\n", opts->pack_prefix, item->string);
 	for_each_string_list_item(item, &existing->non_kept_packs)
 		fprintf(in, "%s.pack\n", item->string);
 	for_each_string_list_item(item, &existing->cruft_packs)
@@ -665,14 +663,18 @@ int cmd_repack(int argc,
 	}
 
 	if (po_args.filter_options.choice) {
-		if (!filter_to)
-			filter_to = packtmp;
+		struct write_pack_opts opts = {
+			.po_args = &po_args,
+			.destination = filter_to,
+			.pack_prefix = find_pack_prefix(packdir, packtmp),
+			.packdir = packdir,
+			.packtmp = packtmp,
+		};
 
-		ret = write_filtered_pack(&po_args,
-					  filter_to,
-					  find_pack_prefix(packdir, packtmp),
-					  &existing,
-					  &names);
+		if (!opts.destination)
+			opts.destination = packtmp;
+
+		ret = write_filtered_pack(&opts, &existing, &names);
 		if (ret)
 			goto cleanup;
 	}
diff --git a/repack.h b/repack.h
index 25a31ac0a0..6ef503f623 100644
--- a/repack.h
+++ b/repack.h
@@ -32,6 +32,14 @@ void pack_objects_args_release(struct pack_objects_args *args);
 void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
 				  const char *base_name);
 
+struct write_pack_opts {
+	struct pack_objects_args *po_args;
+	const char *destination;
+	const char *pack_prefix;
+	const char *packdir;
+	const char *packtmp;
+};
+
 struct repository;
 struct packed_git;
 
-- 
2.51.0.243.g16eca91f2c0

