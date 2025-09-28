Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECBE1FB3
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097420; cv=none; b=gGNA+R14ZeCWuxWb9ep6Nyf56yHM+8e9O0ZHBTrN2vWUk3aLE5LP1gJJsYjL/4MxKTAGehEz27jIXKdoqnJ4dMMgzEMOc0/pHe2XkEoJHmn1db2vprQRFlBrb56GN11t+P3ayx4lUCTTXJsh1IbgAAwto/2FZATJTXkkkx0FgQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097420; c=relaxed/simple;
	bh=FgD3aj4cGAJGArLWqh5uclT4x2VPtNpOlZif89Do5pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2vpZ95cbVPic1nLt9T1bt7eIywkIdcG69hTzAfc/pMsSTeJw3YV+znd9YUWuj6SZnT+rEMCY9214sZfRE8MqwrEaPnfvGfokz6FKjZRxFUZE4c5l72dIxFH8/RpW5iP1KHfntOITgBCil+OESW2XAO8lEeX3PA9HRiGowIfTgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=HDCx5p8W; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="HDCx5p8W"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d60528734so43119427b3.2
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097417; x=1759702217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gTRcGXb3prFbObmCWeVVAo1Hp6u/x9hBVXOhQwUdKUA=;
        b=HDCx5p8WdyTKcBSKKsoaXzglj6/DFFq4TK1vVzpi2G1xaCAq+7vER+XvJX147uPiKc
         1JN9QHkB6Vq6PQjXX9Q7GAgdov9lGdS6IMSn4E6ZqwQe86jJNDZLVc6QNASvxlfnIlqs
         kAP4IEUpglO8S3cq3FROZz6fgF+4Z4vMr9/6J5hAu2yl+Q7fAXn8CV8BhqO+fk8ivVze
         hR8uiF3l5os8T3PGS673L8KriXjUlJlWHUTXUA7wHSWUPjmyPmJdD7JeWd402gHGY+Cc
         Zk8WLBOE7+sU6L8JE4JXkA3zR3TrIe3YLMIDwSKNRfqvt9IaP8qGGh3yTys3iiMZzTrQ
         tSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097417; x=1759702217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTRcGXb3prFbObmCWeVVAo1Hp6u/x9hBVXOhQwUdKUA=;
        b=fX86BnoZUuXelgYyrF1XrN8CjphXNg5iWC36e5Xxyg0ANEsB7TOpVIbJVSwav1WOsS
         YgldysSRJSbX8ISSdgIKV+bTyinnpnYWTfcG5d8DK13T9OXl5cuMyGRfX3cHSntxiFZQ
         syh54/ZU5BoA2ZsuLARKEpu8ED07n230jLOfF9kcN9yhC/PanErcA5BuwWYp8YlQjO1E
         KV2+POvenAevFWh8zW3gd2UxD0n76qPwMCJXHNLa/HC56hRWzo4EFWOaiNYv/xo3taAL
         H69XF04HD2Wj57+Bmo4Qn7ar//jdhBDygmLSEsJvEbdAYE/xjdfllCv/cr6W6qrpvyW5
         JsTg==
X-Gm-Message-State: AOJu0YzkqFg3AdIWPus1gfbOE6K+Uxf7tG5hW5ADb7pOaWoggc/K8KMG
	X0MmrZTJZpsT33f5Z73f9XTxqb3HR55p1n3Zboa+D8LncwwNZrgv7bejJWU8sXNdC3eEHjUffjl
	QoNSMsar7QA==
X-Gm-Gg: ASbGnctvexBffMhOSAiK8llPRZoMoFCBqr9Og7RAx8X0YtI3px9TmssQ61xz2hEDWS1
	pauEUb1ti5iY5RsUOZR6nWX3fvg+6mgh989WUdnyC7ArM7+ohV9JLTg7NJ1uhDE2rceiGAS9P+f
	24c+wCgefHRCrL3WHt4aE6TmJ7pQ8mcB0tg6L8cB+FK5OE/5NyVQ3qE1KZIGC2AdTdKfZAePxn0
	LM6O/i46KzJLqjlQiNgY1b3KSWw+/VezmtfWfmjmRAjCuyZgj6HH96qrh4XCIj64N+XFpkSuePi
	4St7rM2DwR1MdIhTiEU2LeM3MbOHov3A3CvQG35OviJHlNL0GEk+nrANdOSBH5IlKLjrN49/yCT
	iqDipuStWxBXHlug0JD03lhXeDHFp5CSkVX2dWH4QiiBM3A+OENQlj7CnKYmZnfRPJ2i3UejPZF
	QYl0CoGnPQIij42n7nvqPMQGCb7ld3escvaKaO
X-Google-Smtp-Source: AGHT+IHPa6WlIN+01uVTw7GrLDRxLPYLleEKlS6DO1QXdMrwKCBTT1rQMibxAUe46InMUboCTg3wzQ==
X-Received: by 2002:a05:690c:2c10:b0:771:36c9:2426 with SMTP id 00721157ae682-77136c9290emr85298457b3.32.1759097417439;
        Sun, 28 Sep 2025 15:10:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-636d5b1d976sm1939377d50.16.2025.09.28.15.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:10:17 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:10:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 44/49] builtin/repack.c: pass `write_pack_opts` to
 `finish_pack_objects_cmd()`
Message-ID: <11f78993f1d2d56b204398788780b30318d83afa.1759097191.git.me@ttaylorr.com>
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

To prepare to move the `finish_pack_objects_cmd()` function out of the
builtin and into the repack.h API, there are a couple of things we need
to do first:

 - First, let's take advantage of `write_pack_opts_is_local()` function
   introduced in the previous commit instead of passing "local"
   explicitly.

 - Let's also avoid referring to the static 'packtmp' field within
   builtin/repack.c by instead accessing it through the write_pack_opts
   argument.

There are three callers which need to adjust themselves in order to
account for this change. The callers which reside in write_cruft_pack()
and write_filtered_pack() both already have an "opts" in scope, so they
can pass it through transparently.

The other call (at the bottom of `cmd_repack()`) needs to initialize its
own write_pack_opts to pass the necessary fields over to the direct call
to `finish_pack_objects_cmd()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index be8e6689fc..8db95305c8 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -108,11 +108,12 @@ static int repack_config(const char *var, const char *value,
 }
 
 static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
+				   struct write_pack_opts *opts,
 				   struct child_process *cmd,
-				   struct string_list *names,
-				   int local)
+				   struct string_list *names)
 {
 	FILE *out;
+	int local = write_pack_opts_is_local(opts);
 	struct strbuf line = STRBUF_INIT;
 
 	out = xfdopen(cmd->out, "r");
@@ -128,7 +129,8 @@ static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
 		 */
 		if (local) {
 			item = string_list_append(names, line.buf);
-			item->util = generated_pack_populate(line.buf, packtmp);
+			item->util = generated_pack_populate(line.buf,
+							     opts->packtmp);
 		}
 	}
 	fclose(out);
@@ -147,7 +149,6 @@ static int write_filtered_pack(struct write_pack_opts *opts,
 	FILE *in;
 	int ret;
 	const char *caret;
-	int local = write_pack_opts_is_local(opts);
 	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
 
 	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
@@ -183,8 +184,8 @@ static int write_filtered_pack(struct write_pack_opts *opts,
 		fprintf(in, "%s%s.pack\n", caret, item->string);
 	fclose(in);
 
-	return finish_pack_objects_cmd(existing->repo->hash_algo, &cmd, names,
-				       local);
+	return finish_pack_objects_cmd(existing->repo->hash_algo, opts, &cmd,
+				       names);
 }
 
 static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
@@ -231,7 +232,6 @@ static int write_cruft_pack(struct write_pack_opts *opts,
 	struct string_list_item *item;
 	FILE *in;
 	int ret;
-	int local = write_pack_opts_is_local(opts);
 	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
 
 	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
@@ -279,8 +279,8 @@ static int write_cruft_pack(struct write_pack_opts *opts,
 		fprintf(in, "%s.pack\n", item->string);
 	fclose(in);
 
-	return finish_pack_objects_cmd(existing->repo->hash_algo, &cmd, names,
-				       local);
+	return finish_pack_objects_cmd(existing->repo->hash_algo, opts, &cmd,
+				       names);
 }
 
 int cmd_repack(int argc,
@@ -294,6 +294,7 @@ int cmd_repack(int argc,
 	struct existing_packs existing = EXISTING_PACKS_INIT;
 	struct pack_geometry geometry = { 0 };
 	struct tempfile *refs_snapshot = NULL;
+	struct write_pack_opts opts = { 0 };
 	int i, ret;
 	int show_progress;
 
@@ -560,7 +561,10 @@ int cmd_repack(int argc,
 		fclose(in);
 	}
 
-	ret = finish_pack_objects_cmd(repo->hash_algo, &cmd, &names, 1);
+	opts.packdir = packdir;
+	opts.destination = packdir;
+	opts.packtmp = packtmp;
+	ret = finish_pack_objects_cmd(repo->hash_algo, &opts, &cmd, &names);
 	if (ret)
 		goto cleanup;
 
-- 
2.51.0.243.g16eca91f2c0

