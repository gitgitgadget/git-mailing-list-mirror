Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF2A30DD23
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567283; cv=none; b=cqTMXEM3FCOGpicsjnJBZ32zohRGx424ova7eA1hEBnJIhs1peAQMwgUNAQ+/KlWT1/C34Lwj8ktzoRCOS87QATGd6zLhLCyCP1i/essFOuKTP9qh6W4OSS6V50COIelOtYRehSNIOZm5XpAe5j/pTS+aXGYN+Qmuw78uzBkuTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567283; c=relaxed/simple;
	bh=ARy97WLu/nch2uZspZB4IH+5JZvHBdgCmEeMYsl3OJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+eYQ1pFS8tNeskuDtnlgxLe7jNdmVwDBeqSL4aI8/wX4z54Kf/IS12ucNh6YVoQZdA98sTKFePPE1tOh5ByJb0iXPkXajPbWRT2rWFLY512tsvyXykaR3hurYRdE5l5FP11gnjycRP44J9trTO7EkTvH2Fxugpc2ianCkPy0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=V3djCfck; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="V3djCfck"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7814273415cso659807b3.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567280; x=1761172080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NvzGU+URiCqVn2y1krvrIj4oyxqeh5Rl/VfN7kOGyOA=;
        b=V3djCfckGlh8OWvac8tMmUvCjOKE+g1hxip+qFUTZZNMGfPHkShSkOX6rkE2Ac4/dS
         x0VsflNI5JATWcIiOB9jSTsWvFFQnm5Q+hGpB+jmCiks33BfnSSLUDP2abNSxF7XkWhZ
         GYT1vrGxoc6shMSXM7tN4AfqDq4fz+z0TNE6RRZoAA5o8ucrt1e8pYx2vOrCWSmEwBsd
         QCTrd3fZlrbFeem2CbyeFRezavnYH1Pc1XMkdgHxcE/seYq2dIp/EC6rrxYUuu+IHHeN
         UmJjrcd7loIHtZ+sNfBRO9Za9NUqz8g/LMF//RPhq3W7otqlbxLoHSTt9IGjYJMBRzXU
         PFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567280; x=1761172080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvzGU+URiCqVn2y1krvrIj4oyxqeh5Rl/VfN7kOGyOA=;
        b=tIu64T+aDN4sY301d1KaX3Y2K5bIEFKrtLhiider8uG+WtAm6+lXk4Z7WzhaHY3DeU
         mamcohItmTk+ZVvCodORHaD+Bpz1xYOeJmxLsvaoXwlLwnsNXQS1Hr58nLZnRoyUPt6y
         p3MTw+B3FxQeHr+mN9C+26IQcsM1n5yQEVUA1kOsNh510x/l3IRFUxS7LsSCa+n+GZwa
         gGGJ72fy1wYI18+xLeZcSxAX4U9Gw03AhDq9CtKnEwgC2HLP05o1o1JVGQcRzz/w3lE1
         o7tpWcbVwo/n9+hVv9ryJEfq/1w7wc1kT9e+b5dSjLlcVYpGpuLOI2+8Bw3FY7NZ5ye2
         p8MQ==
X-Gm-Message-State: AOJu0Yxky4bXjvw/2PsPeJoofUtXVLnlWQz4W2zEeNza+LYpOSNdYb0D
	0JvkOf4x0UwcLKRHZuyHM41cOdY4pHN/MmouZ8CfzviUTafriITd7bRYDTgPzAF+5bCfJW73r3E
	li68TjZPC5w==
X-Gm-Gg: ASbGncuIs++qU+kN3L7+6P7tBC6DTcyzVzSBm4+Ok3C2v4DljNQoTZqgsPx3XjKxlD5
	t96FVGERsaBA48Qqbx20Y3xcaD1tutG4IxPL5KzW3IhRAYeqz6AAhRkm9fE/n7rOj6uqytWyBia
	FrBFQ0wqLHkxjHxPSHuSQvm+MfrJfdzwDCsrBNYJlPDjamPnhTewPewoDRpJ2XvknyA6mFa41bC
	Bp1TdGEVItDakPQZb8wgWhq8b0WwK4Ti5eiDtaxvyqp43N16++PPll9oOLNSYFCRxi809bvSz9i
	ZOOw6ygwB/usz4h9SqKVEJi9sFyJklaDmjQdvhViGKu5sm88t+0zVG91DewnusXxNx+vsdZoALq
	5Sv1zKdXOY5SpladT8BC/GgHu6o9qU4bRZIbWpQFT9GWSQ6OkO13iag/a6fGAZZOm69RZMg7wtW
	8rc2g20ZTX0HaZ6Fn+7Hy74oowR2rL0nE3NzTs6yP/m4AWPmIXlaIpuLWHUyHJ0lSp3T00WWZXK
	u7hHpQ=
X-Google-Smtp-Source: AGHT+IEfy8TpYNpjzLrnR0MPHrPtLi5zz3YaoNkaiNy6Dd8X0rDpO24Mpleslu5kGdJCVdC/T8IuyQ==
X-Received: by 2002:a53:ec89:0:b0:629:9c6b:b3ab with SMTP id 956f58d0204a3-63ccb825baamr18978179d50.1.1760567280228;
        Wed, 15 Oct 2025 15:28:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-782931f6613sm2583557b3.48.2025.10.15.15.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:00 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:27:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 13/49] repack: move 'delta_base_offset' to 'struct
 pack_objects_args'
Message-ID: <f2d1fa51e36e7500efdd32eebfc3e8016777b715.1760567210.git.me@ttaylorr.com>
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

The static variable 'delta_base_offset' determines whether or not we
pass the "--delta-base-offset" command-line argument when spawning
pack-objects as a child process. Its introduction dates back to when
repack was rewritten in C, all the way back in a1bbc6c017 (repack:
rewrite the shell script in C, 2013-09-15).

'struct pack_objects_args' was introduced much later on in 4571324b99
(builtin/repack.c: allow configuring cruft pack generation, 2022-05-20),
but did not move the 'delta_base_offset' variable.

Since the 'delta_base_offset' is a property of an individual
pack-objects command, re-introduce that variable as a member of 'struct
pack_objects_args', which will enable further code movement in the
subsequent commits.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 11 ++++++-----
 repack.h         |  3 +++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index af6de8d77a..f4af830353 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -34,7 +34,6 @@
 #define RETAIN_PACK 2
 
 static int pack_everything;
-static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
 static int write_bitmaps = -1;
 static int use_delta_islands;
@@ -63,9 +62,10 @@ static int repack_config(const char *var, const char *value,
 			 const struct config_context *ctx, void *cb)
 {
 	struct repack_config_ctx *repack_ctx = cb;
+	struct pack_objects_args *po_args = repack_ctx->po_args;
 	struct pack_objects_args *cruft_po_args = repack_ctx->cruft_po_args;
 	if (!strcmp(var, "repack.usedeltabaseoffset")) {
-		delta_base_offset = git_config_bool(var, value);
+		po_args->delta_base_offset = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "repack.packkeptobjects")) {
@@ -315,7 +315,7 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_push(&cmd->args,  "--local");
 	if (args->quiet)
 		strvec_push(&cmd->args,  "--quiet");
-	if (delta_base_offset)
+	if (args->delta_base_offset)
 		strvec_push(&cmd->args,  "--delta-base-offset");
 	strvec_push(&cmd->args, out);
 	cmd->git_cmd = 1;
@@ -1271,8 +1271,8 @@ int cmd_repack(int argc,
 	const char *unpack_unreachable = NULL;
 	int keep_unreachable = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
-	struct pack_objects_args po_args = { 0 };
-	struct pack_objects_args cruft_po_args = { 0 };
+	struct pack_objects_args po_args = PACK_OBJECTS_ARGS_INIT;
+	struct pack_objects_args cruft_po_args = PACK_OBJECTS_ARGS_INIT;
 	int write_midx = 0;
 	const char *cruft_expiration = NULL;
 	const char *expire_to = NULL;
@@ -1567,6 +1567,7 @@ int cmd_repack(int argc,
 
 		cruft_po_args.local = po_args.local;
 		cruft_po_args.quiet = po_args.quiet;
+		cruft_po_args.delta_base_offset = po_args.delta_base_offset;
 
 		ret = write_cruft_pack(&cruft_po_args, packtmp, pack_prefix,
 				       cruft_expiration,
diff --git a/repack.h b/repack.h
index 421d439d5a..12632d7fec 100644
--- a/repack.h
+++ b/repack.h
@@ -15,9 +15,12 @@ struct pack_objects_args {
 	int local;
 	int name_hash_version;
 	int path_walk;
+	int delta_base_offset;
 	struct list_objects_filter_options filter_options;
 };
 
+#define PACK_OBJECTS_ARGS_INIT { .delta_base_offset = 1 }
+
 void pack_objects_args_release(struct pack_objects_args *args);
 
 #endif /* REPACK_H */
-- 
2.51.0.540.ga7423965ad8

