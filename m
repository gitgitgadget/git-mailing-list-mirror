Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9141A307490
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567260; cv=none; b=dZ8LmZkpkYnKnO7W7UDUMIebZzFUPQZaGm0LNux7ZVHfCSud2yXzf0iIGC5a+AKWHLkDUNz1a+j+W+30K5FYbS40ya8Xpv0rnn9qKNBfxfjFbab9X9g47b0JP/+rOnLhAdlZHoVT1wRyKs4HsacO+pmcY0x8UftIqlYf463Fch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567260; c=relaxed/simple;
	bh=q2Vu8Kd4pEpli22QkEZFlXTt3aumY0MxFMYCLdDacIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qL5wg/lO5Dnnuz2IGhNuacgCNP1Nacu65YTCnVrUuQS+BdHdmnqoiHSDztegqYKC9K45nERXsg8SDoYQQtDIo4MsSboFUCnS+y3ZFmLOXIRZGztPTMa9KGnzXhgzWvKsraAqI7rIZonjQc6p7+zaW+PFX+NfZzdFOv7DStI3bPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=hfqo1uAO; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="hfqo1uAO"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7815092cd22so837017b3.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567257; x=1761172057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQI0eyd4DOj1FF4BbrpAtsLeIKS86gMHTX7LZ70gd7s=;
        b=hfqo1uAOxdrM6MME/Hn2zvD9doQySzmSfq2CmzzSpOH/guUgdnh0wRrP1iVgLBKt18
         CcMAy8qIM6losoPCTF8yGTtkgRMnuup8VachKc9MBtF2/W9Vf+6W/0CfeOLzi2Nk106y
         aPwLGKKfES4Q7iqtRMe6/mIXjEWUdmBJgKKKh/kd0AeLFheCZyIx9PzncF93kAdvce9L
         XKB+B4/6hpKTDDfGtvA8UonOSVt0i3TkQePEyDvadv205yv1K4VWr7TFZLrfz/R0cPC2
         13psjoDnqClBzidaN+PP1aF/bFPjmgajYabwj1kGGwE1h4YX2w+B82j/7pNJYchvmSNu
         gq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567257; x=1761172057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQI0eyd4DOj1FF4BbrpAtsLeIKS86gMHTX7LZ70gd7s=;
        b=Cew+/aDVFqN/wO3fjQ3NLcBCe1N3cizfClh8HVWUYghZ+Xv91IlrG6NwKPHSVmVQoe
         V/KOYonkByGsnOx3g0bIgZw/8BT0/nM1Fg8Iw2mkceZw0wUry3Lt54MVDcxHFWzEo6ZK
         O/LyQGgXBZBbjJaZjuI8KGPOeth1nuzGj4djOngXfrusYhoYNXPgMf54SlqF7qc1UhxK
         dplyYU3K+2Mvdu1byJamRWDBSBqu0NE169KWXJC+c13iKcSkMrK/JnkJcXxOk1pNsdaO
         nz6I/wiJ+8Oy1ff+ACT8p4E8bqh0IhIr/m0Kv6gNEJLSTDFX71/E8oDuYQmkAJavHu05
         /fmg==
X-Gm-Message-State: AOJu0YzsoBWsVlgDz81hMeoFG2oFkkZYcBsVQIC2VCxXlfLc0oxoHfbG
	mfnclC3ZYzHA1SZe6jxcVRVXf655hTkVi57raR0CDLd4+S4uUxtjdIBZOhbIKcZUQXpZEa+8psI
	sZUVdvqmHfE4T
X-Gm-Gg: ASbGnctvboNMEmjTv+AnKfUAN+rC69jSwq/GPr94C3nZ4yxZ9SscadsC7tQbQZwdGad
	JzWESTVEJMIexm/O9YcdNeB5OvwcTA/p70vqNUAp57ALl8UuwbhOZdZSkiUOXynvoV65uAxn0CP
	xdUTsky185KUMgFoBhRHf9mSz4pUXCTiDQCfz45WlpNgEtQNc9dfZ5+zDbRmUGj2uL4is9kU8PJ
	RLvwbYQlECJ4T8JX+ruDzSDJyKY6Mu4MIRdw3TgS/O7oh2z+WczKwncyMzZWDmBg96rh36VipgF
	FKRLL8D2Txmzhh/I9w6UOLr75ay8/Do+eOqKBXb22RVbvQXSVaYSKUGmUqUrlObDtmIw51oU0CR
	TgJWc1S2FAciOoacDf7TzeJc3p1QiZQbIyrTRuNLOIN1N5EQ5Ngnz8yKiaZNQcWsMV1kNCvDWrk
	H9q9gKrbgR7shX2/OUZsB9ziSdQcfSq7IYUNal3DRfUhPzR8Q0o2DvS+eo4HP0x3imGj0eTGihb
	Po5JGF15xS9fR25dg==
X-Google-Smtp-Source: AGHT+IG1IS8ORZGv7M6HpYnHatfuUdJwXofl7PL0xSyG4nyKYhxy2xVAvwmTqyn3RumJqMVCTPIr8Q==
X-Received: by 2002:a05:690c:9991:b0:761:26fa:22c3 with SMTP id 00721157ae682-780e1534a67mr305205417b3.33.1760567257519;
        Wed, 15 Oct 2025 15:27:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-782934f7d0esm2562267b3.53.2025.10.15.15.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:27:37 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:27:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 07/49] builtin/repack.c: avoid "the_hash_algo" in
 `write_oid()`
Message-ID: <ca3c8a782a76c1660852784d8160a7680d7e607a.1760567210.git.me@ttaylorr.com>
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

In a similar spirit as the previous commit, avoid referring directly to
"the_hash_algo" within builtin/repack.c::write_oid().

Unlike the previous commit, we are within a callback function, so must
introduce a new struct to pass additional data through its "data"
pointer.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 094f5a0cc2..7d62959dc2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -339,6 +339,11 @@ static void prepare_pack_objects(struct child_process *cmd,
 	cmd->out = -1;
 }
 
+struct write_oid_context {
+	struct child_process *cmd;
+	const struct git_hash_algo *algop;
+};
+
 /*
  * Write oid to the given struct child_process's stdin, starting it first if
  * necessary.
@@ -347,14 +352,15 @@ static int write_oid(const struct object_id *oid,
 		     struct packed_git *pack UNUSED,
 		     uint32_t pos UNUSED, void *data)
 {
-	struct child_process *cmd = data;
+	struct write_oid_context *ctx = data;
+	struct child_process *cmd = ctx->cmd;
 
 	if (cmd->in == -1) {
 		if (start_command(cmd))
 			die(_("could not start pack-objects to repack promisor objects"));
 	}
 
-	if (write_in_full(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
+	if (write_in_full(cmd->in, oid_to_hex(oid), ctx->algop->hexsz) < 0 ||
 	    write_in_full(cmd->in, "\n", 1) < 0)
 		die(_("failed to feed promisor objects to pack-objects"));
 	return 0;
@@ -413,6 +419,7 @@ static void repack_promisor_objects(struct repository *repo,
 				    const struct pack_objects_args *args,
 				    struct string_list *names)
 {
+	struct write_oid_context ctx;
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *out;
 	struct strbuf line = STRBUF_INIT;
@@ -427,7 +434,9 @@ static void repack_promisor_objects(struct repository *repo,
 	 * {type -> existing pack order} ordering when computing deltas instead
 	 * of a {type -> size} ordering, which may produce better deltas.
 	 */
-	for_each_packed_object(repo, write_oid, &cmd,
+	ctx.cmd = &cmd;
+	ctx.algop = repo->hash_algo;
+	for_each_packed_object(repo, write_oid, &ctx,
 			       FOR_EACH_OBJECT_PROMISOR_ONLY);
 
 	if (cmd.in == -1) {
-- 
2.51.0.540.ga7423965ad8

