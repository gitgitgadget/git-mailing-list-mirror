Received: from mail-oi2-f41.google.com (mail-oi2-f41.google.com [74.125.231.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FCC418A4E
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 04:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827927; cv=none; b=pLW+Ya8PLv6GGIc2fZumgqB5AISX5+OfiCuR2s5M64Ytkqz+KNFeJRG06XwhrzXBL/gESuiP8zgOxlsZfuaswiU3mJCJAT5Hub8mqwId0ouY4DYsLYxooAwo9rADEYoELRBq46GtYO6xhVS6boN2z7C9tQphm2JuAKsORwDYChc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827927; c=relaxed/simple;
	bh=Eo0nlcLcBJinx+1t7hO3kYNkc3OeqHzxWrEVOmu+aDI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahDCgD9x4ywY8TJeEqlc4LGtoHK5GBhZ2+nwDolpeR+aGZqV7hjz5/MulaH8Ciwz/R8Q097zmkhIxFCQofRsbi87kGmgKlsiBmM5MVfEvVy76iVX33TbDlFvfgv1aTRxqG+6YO7RcqsR4Fz8AZFHk53LMKuonMa2Z8VNNKc8ctA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=OrYckheS; arc=none smtp.client-ip=74.125.231.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="OrYckheS"
Received: by mail-oi2-f41.google.com with SMTP id 5614622812f47-4f20258a10cso228042b6e.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790827925; x=1791432725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jgDUMvJ8POAXrAMxq3DYGgrBdzBTtMlb0sN+ctWaeSI=;
        b=OrYckheSCG+rZ9u6BnaioEdic2mljwuU3NMU5CYEKo3eFtLxJS9NKdjuB6M9bz7wre
         YuwAtChZGdNo1enFYz8njE4MTeBBWGzepLUvmO+CnQ9xQxCs3rSHfi8A/ZmNObezjPzF
         DPwmJ/pg/1dkydG/PkHBXqUd/vGLqyTRz+Yvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827925; x=1791432725;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jgDUMvJ8POAXrAMxq3DYGgrBdzBTtMlb0sN+ctWaeSI=;
        b=KxiREbQn5xp4/JKHS0TYMVQ7MGJ3txPR3qvM2kXUcdfgS1z3J7c0qkk6wilF/1dXOE
         Kn7KoJCMQrXytN+EV045MzlV+YTgojg5UQICoB6ODgWqNR6SNT40+g4OXVwFA1xrt7c1
         mCa/FKCKD1EVLCO6PvGdAHNu2Mi4w+VwimrHf6d8a7FAJUoyWzDGmhtJvLys4BHwrdi6
         DpEPz0PaWDXEQ0n8feVPn0qmWxWzKlFTqjGvjnHVFimikBKtyJjjMhtQkuETMmMNLX0p
         7wb7dcE6ywjqh2VLPWYJDX9RtPuXE2Qiulg1Kxqf4zxqlxsgZP7nHWrhG8DVjFvRqT2J
         Mbeg==
X-Gm-Message-State: AFuF++l705scLiqyXCeTN8NpcoZm3mi3L0K9wswjgkw4nUZuY6KUgjAa
	b2hFBUEDXVYrOaAVBXT/jAxDKA5Po+w9VEaofxAjyox3uJJXxMpMzZVb1ZZlueoewUEqwNxyi+l
	aVNQmfuU=
X-Gm-Gg: AYBFou0yZ7fh/qJQ7CwtvrTF4UHjQH5XJpR5zBqt470age9JPTJHAJJgi9Ph1GG6UXf
	+iHN2usNuaxQaPccLuDGpuqvmcUA1fiDPeMK+yrT4yC/wu+JPyUYc14p3sseodOgVBD7jGHAwau
	uiC+dVYG37huYL330NfuFf7JJZUNYLxpWypGcPm2k/b90skIUhsoyFHPa7R1d6FceRBxveJoJ/S
	IKpz2h5IG9OL/ge65Duy9zUyt2mkLeGMYdKbixFp/mkSXr0W5U8J3cibMIYuR0X5CBSVYTFC3Oc
	KoQoVVDPizpQ7UMl/Nl82tdyIuPOwQu1YYUHoMpffimwb6vVO+sZkk4JCypq9uBxASOp6R3eIYC
	6xey4daSDHDqr4eUUJ8XoTkAZNat7dxUjHGuAE3WpUf9QKHnhpPeh/fBEaHPLLecHa2NQ7H6+KD
	nFeBQlwJtYogLCRRtZb3f3fnW8DIBkCIxfLPougZSoUBTX1/mybEJRSvqX+2xq8k9yqO8FNdoJU
	etlNzNtiziBw4HGPv9Skdo4+U9/+X8yaVhjlQBBheV9l6MYfXDEr57H5WoOr62hxSN/gMshCtWM
	+5r5C7mv
X-Received: by 2002:a05:6808:17a2:b0:4d6:9133:cff9 with SMTP id 5614622812f47-4f307534e1emr1876178b6e.32.1790827924851;
        Wed, 30 Sep 2026 21:12:04 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f34c19be5dsm1345690b6e.12.2026.09.30.21.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:12:04 -0700 (PDT)
From: Taylor Blau <ttaylorr@openai.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date: Wed, 30 Sep 2026 23:12:02 -0500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: [PATCH v2 7/8] repack: defer allocating the append plan's write step
Message-ID: <4a6504629a24cc802462f44b36f02b7118d2a9b7.1790827875.git.me@ttaylorr.com>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1790827875.git.me@ttaylorr.com>

The append plan creates a write step before iterating over newly
written packs. The next change will consider additional packs and skip
those already covered by the MIDX chain, so a non-empty candidate list
will no longer imply that a write step is needed.

Allocate the step when adding its first pack instead. Continue to
consider only newly written packs here, preserving the existing plan.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 repack-midx.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/repack-midx.c b/repack-midx.c
index 61832114671..06eadb9df82 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -559,33 +559,28 @@ static void repack_make_midx_append_plan(struct repack_write_midx_opts *opts,
 	struct odb_source_files *files = odb_source_files_downcast(opts->existing->source);
 	struct multi_pack_index *m;
 	struct midx_compaction_step *steps = NULL;
-	struct midx_compaction_step *step;
+	struct midx_compaction_step *step = NULL;
+	struct strbuf buf = STRBUF_INIT;
 	size_t steps_nr = 0, steps_alloc = 0;
+	uint32_t i;
 
 	odb_reprepare(opts->existing->repo->objects);
 	m = get_multi_pack_index(files->packed);
 
-	if (opts->names->nr) {
-		struct strbuf buf = STRBUF_INIT;
-		uint32_t i;
-
-		ALLOC_GROW(steps, st_add(steps_nr, 1), steps_alloc);
-
-		step = &steps[steps_nr++];
-		memset(step, 0, sizeof(*step));
-
-		step->type = MIDX_COMPACTION_STEP_WRITE;
-		string_list_init_dup(&step->u.write);
-
-		for (i = 0; i < opts->names->nr; i++) {
-			strbuf_reset(&buf);
-			strbuf_addf(&buf, "pack-%s.idx",
-				    opts->names->items[i].string);
-			string_list_append(&step->u.write, buf.buf);
+	for (i = 0; i < opts->names->nr; i++) {
+		if (!step) {
+			ALLOC_GROW(steps, st_add(steps_nr, 1), steps_alloc);
+			step = &steps[steps_nr++];
+			memset(step, 0, sizeof(*step));
+			step->type = MIDX_COMPACTION_STEP_WRITE;
+			string_list_init_dup(&step->u.write);
 		}
-
-		strbuf_release(&buf);
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "pack-%s.idx",
+			    opts->names->items[i].string);
+		string_list_append(&step->u.write, buf.buf);
 	}
+	strbuf_release(&buf);
 
 	for (; m; m = m->base_midx) {
 		ALLOC_GROW(steps, st_add(steps_nr, 1), steps_alloc);
-- 
2.56.0.8.ga42f775cbe2

