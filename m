Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B27E2E11BC
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959652; cv=none; b=gDjoiuJAvlmfiiBjN6qaHdvrcqIxCJWZKiWdlVldZVFWrAT7FDE/epiCvtyuqkuhLP6iLzWyB2f1pOWrcJDSynbUaBcBrwahFSyI6Zhn0SGmvOYXQcHOjGNF0JcwObqyKd+zLVmmkmlouZt2VyKcc6aB6iWgvD7sHOl2JIVwssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959652; c=relaxed/simple;
	bh=kdYIpiQHX05upMqyhJCGk3lxSyxtFGHG+Cf2rCBFkCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVPdGFJbQ4giIYiIBbr3Vdo4aelvHxDCJO9y5EPVVx6ikPXEUZ+3AU1hRCB3pVcDxOWm3pzPA6Ii/oMlm7LhfFQ6lKDJ+Uag9zgsGJ87s4WC5raJ4CFuaDjMFv0dU+BDbTJSRWdjcrJcIzy7Iuu/lCwrG0o2ixC/VvrIE2PRY2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=DGb1xvls; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="DGb1xvls"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8cb3bae8d3eso574489385a.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 11:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771959650; x=1772564450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7QA/Uc7HMdlZDfpoR9PUOqGIWe4HyLecRKeyAlmgAKo=;
        b=DGb1xvlsSD9Nw75QhT7Ezr8Q6ufGXIUOuFJZs55Kk+TvN1fjk00td0apPlWeEwYnlC
         QzGcvbRJbadhk73PwRvWrEmy4v8FXUPVeFjg5JW7hb5+hZFmjAzaUc4H+c27S6WXc8/j
         /3J5DwYe8VziA3vadV3BSemo3evs67dHjTbCNDKFs4oY68ub0kHuCH9qalWrxcwytNw3
         pAvy66n838rsZgXyrXdVPljwE211VEm3N5Jaw5CmdVTTQPxE1NcnFkuy2J8ckb4BO10u
         VY2uLErYri9JTiauJ26TEN2VN4dSEC7jbbWPEBPqQF46e3mDYKG/idp/BiC3C0aER032
         apNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959650; x=1772564450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QA/Uc7HMdlZDfpoR9PUOqGIWe4HyLecRKeyAlmgAKo=;
        b=m0FWFLmP3IyILJoBnfaBP1swbQ4ZFzybZkIzIbGmSLjKS1lPg22t+gVSOLERG2g4ko
         1kbu7XPshHErlJDLyB5uAckzIAy8PPUpg8IKkH3L6k1r8XmrlhP+wzl6ffCe4JKiAiF+
         ATewMxCDAdcPCqYiDjCbkz+TI0e9JEK28cec3FV47L6ZZDOBUOQxdIHdV6K/VsanxmtV
         RdIEStbCbC5CcKLoTPAu4CjCTsnha/BIjp+G01MUNmFCiU/l1XZXXq3DrDwQmGvRM5qR
         LOgrrFZlkDj3YBcfCEXz66awT92/bDAhz0ApB3cKHbOuNm+pZSpXCAOfTjVcqUEEkJFf
         Hqww==
X-Gm-Message-State: AOJu0Yy+5nFJAaGJgLDrv7xtKpywnyA7tulFGjHmI7s4pXK4NcS8yfEn
	juydOvX/SGPWyglfwjKAylYULK6zZWAWc8qLSpBHwK3rnqB7sSPpRWEni2XlL6FBu6WSngDJLMO
	nX8bJTDkP8kTS
X-Gm-Gg: AZuq6aKSARFJ9TH0D0m+OUCXiwUQl7LguPGUgCJG/FSr0kIVyVxSHEYVA+smOdq08Dp
	1dx/3vNQJpY7MLM8iAEqIg19qExthZBIfMo7CvIEdueRcqwhcfSTes2UYh2IfsPK412fe5HLUTs
	DVDTw/pKi4tskSLVaq9I7oao9NlWpY7d4MR5JTADOMaoCxoWMRrMCHWeylGxe0zbumAW2J+O2PX
	oJqaMIFwlQxpAGb8A8guE2757JX+g1OkjcXv2Q4ZBHGVsfEyDfZQaZWsWKoYx1qPxRH7HvAFD1G
	LlwfiS20x9ouud8sRlFTlBLn36hzGrczLOB7RtC9T0iq/LBjibvbEaCgtIIuLS4TZV/lpqOmOtJ
	TRZ+BtLyvbhPSJmo9vzUJrgHnsKjbnGKWS8lOGShcWxy9FFNQ5yU7A2y4WxgDzQKq4brJj1uIP+
	Tik8yz5LYc2RxHVy//eY5MkTKLcMJvlP91M88Nup5/9G9pywsYy0IaDaxpcPMoqQpl3qt8falux
	Uxv5DH2Mq/Fb5NMZdfxzacLgwy1Yg==
X-Received: by 2002:a05:620a:28cf:b0:8cb:4543:c5c5 with SMTP id af79cd13be357-8cb8c9fbee5mr1633327285a.22.1771959648023;
        Tue, 24 Feb 2026 11:00:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0eba54sm1171977985a.30.2026.02.24.11.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:00:47 -0800 (PST)
Date: Tue, 24 Feb 2026 14:00:45 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 17/17] midx: enable reachability bitmaps during MIDX
 compaction
Message-ID: <ac6221686db11ba802ced8ea6b8b2fa8388b21b2.1771959555.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1771959555.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771959555.git.me@ttaylorr.com>

Enable callers to generate reachability bitmaps when performing MIDX
layer compaction by combining all existing bitmaps from the compacted
layers.

Note that because of the object/pack ordering described by the previous
commit, the pseudo-pack order for the compacted MIDX is the same as
concatenating the individual pseudo-pack orderings for each layer in the
compaction range.

As a result, the only non-test or documentation change necessary is to
treat all objects as non-preferred during compaction so as not to
disturb the object ordering.

In the future, we may want to adjust which commit(s) receive
reachability bitmaps when compacting multiple .bitmap files into one, or
even generate new bitmaps (e.g., if the references have moved
significantly since the .bitmap was generated). This commit only
implements combining all existing bitmaps in range together in order to
demonstrate and lay the groundwork for more exotic strategies.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc |   5 +-
 builtin/multi-pack-index.c              |   4 +-
 midx-write.c                            |   2 +-
 t/t5335-compact-multi-pack-index.sh     | 122 +++++++++++++++++++++++-
 4 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index 883a0529741..61256830141 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -13,7 +13,7 @@ SYNOPSIS
 		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
 		         [--refs-snapshot=<path>]
 'git multi-pack-index' [<options>] compact [--[no-]incremental]
-		         <from> <to>
+		         [--[no-]bitmap] <from> <to>
 'git multi-pack-index' [<options>] verify
 'git multi-pack-index' [<options>] expire
 'git multi-pack-index' [<options>] repack [--batch-size=<size>]
@@ -94,6 +94,9 @@ compact::
 	--incremental::
 		Write the result to a MIDX chain instead of writing a
 		stand-alone MIDX.
+
+	--[no-]bitmap::
+		Control whether or not a multi-pack bitmap is written.
 --
 
 verify::
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 043ee8c478a..2f24c113c8f 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -19,7 +19,7 @@
 
 #define BUILTIN_MIDX_COMPACT_USAGE \
 	N_("git multi-pack-index [<options>] compact [--[no-]incremental]\n" \
-	   "  <from> <to>")
+	   "  [--[no-]bitmap] <from> <to>")
 
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
@@ -216,6 +216,8 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 
 	struct option *options;
 	static struct option builtin_multi_pack_index_compact_options[] = {
+		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
+			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
 		OPT_BIT(0, "incremental", &opts.flags,
 			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
 		OPT_END(),
diff --git a/midx-write.c b/midx-write.c
index bf53ad1c4b7..0ff2e45aa7a 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -676,7 +676,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 		struct pack_midx_entry *e = &ctx->entries[i];
 		data[i].nr = i;
 		data[i].pack = midx_pack_perm(ctx, e->pack_int_id);
-		if (!e->preferred)
+		if (!e->preferred || ctx->compact)
 			data[i].pack |= (1U << 31);
 		data[i].offset = e->offset;
 	}
diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
index 797ae05c3bd..40f3844282f 100755
--- a/t/t5335-compact-multi-pack-index.sh
+++ b/t/t5335-compact-multi-pack-index.sh
@@ -67,7 +67,7 @@ test_expect_success 'MIDX compaction with lex-ordered pack names' '
 		write_packs A B C D E &&
 		test_line_count = 5 $midx_chain &&
 
-		git multi-pack-index compact --incremental \
+		git multi-pack-index compact --incremental --bitmap \
 			"$(nth_line 2 "$midx_chain")" \
 			"$(nth_line 4 "$midx_chain")" &&
 		test_line_count = 3 $midx_chain &&
@@ -90,7 +90,7 @@ test_expect_success 'MIDX compaction with non-lex-ordered pack names' '
 		write_packs D C A B E &&
 		test_line_count = 5 $midx_chain &&
 
-		git multi-pack-index compact --incremental \
+		git multi-pack-index compact --incremental --bitmap \
 			"$(nth_line 2 "$midx_chain")" \
 			"$(nth_line 4 "$midx_chain")" &&
 		test_line_count = 3 $midx_chain &&
@@ -172,4 +172,122 @@ test_expect_success 'MIDX compaction with midx.version=1' '
 	)
 '
 
+midx_objs_by_pack () {
+	awk '/\.pack$/ { split($3, a, "-"); print a[2], $1 }' | sort
+}
+
+tag_objs_from_pack () {
+	objs="$(git rev-list --objects --no-object-names "$2")" &&
+	printf "$1 %s\n" $objs | sort
+}
+
+test_expect_success 'MIDX compaction preserves pack object selection' '
+	git init midx-compact-preserve-selection &&
+	(
+		cd midx-compact-preserve-selection &&
+
+		git config maintenance.auto false &&
+
+		test_commit A &&
+		test_commit B &&
+
+		# Create two packs, one containing just the objects from
+		# A, and another containing all objects from the
+		# repository.
+		p1="$(echo A | git pack-objects --revs --delta-base-offset \
+			$packdir/pack-1)" &&
+		p0="$(echo B | git pack-objects --revs --delta-base-offset \
+			$packdir/pack-0)" &&
+
+		echo "pack-1-$p1.idx" | git multi-pack-index write \
+			--incremental --bitmap --stdin-packs &&
+		echo "pack-0-$p0.idx" | git multi-pack-index write \
+			--incremental --bitmap --stdin-packs &&
+
+		write_packs C &&
+
+		git multi-pack-index compact --incremental --bitmap \
+			"$(nth_line 1 "$midx_chain")" \
+			"$(nth_line 2 "$midx_chain")" &&
+
+
+		test-tool read-midx --show-objects $objdir \
+			"$(nth_line 1 "$midx_chain")" >AB.info &&
+		test-tool read-midx --show-objects $objdir \
+			"$(nth_line 2 "$midx_chain")" >C.info &&
+
+		midx_objs_by_pack <AB.info >AB.actual &&
+		midx_objs_by_pack <C.info >C.actual &&
+
+		{
+			tag_objs_from_pack 1 A &&
+			tag_objs_from_pack 0 A..B
+		} | sort >AB.expect &&
+		tag_objs_from_pack C B..C >C.expect &&
+
+		test_cmp AB.expect AB.actual &&
+		test_cmp C.expect C.actual
+	)
+'
+
+test_expect_success 'MIDX compaction with bitmaps' '
+	git init midx-compact-with-bitmaps &&
+	(
+		cd midx-compact-with-bitmaps &&
+
+		git config maintenance.auto false &&
+
+		write_packs foo bar baz quux woot &&
+
+		test-tool read-midx --bitmap $objdir >bitmap.expect &&
+		git multi-pack-index compact --incremental --bitmap \
+			"$(nth_line 2 "$midx_chain")" \
+			"$(nth_line 4 "$midx_chain")" &&
+		test-tool read-midx --bitmap $objdir >bitmap.actual &&
+
+		test_cmp bitmap.expect bitmap.actual &&
+
+		true
+	)
+'
+
+test_expect_success 'MIDX compaction with bitmaps (non-trivial)' '
+	git init midx-compact-with-bitmaps-non-trivial &&
+	(
+		cd midx-compact-with-bitmaps-non-trivial &&
+
+		git config maintenance.auto false &&
+
+		git branch -m main &&
+
+		#               D(4)
+		#              /
+		# A(1) --- B(2) --- C(3) --- G(7)
+		#              \
+		#               E(5) --- F(6)
+		write_packs A B C &&
+		git checkout -b side &&
+		write_packs D &&
+		git checkout -b other B &&
+		write_packs E F &&
+		git checkout main &&
+		write_packs G &&
+
+		# Compact layers 2-4, leaving us with:
+		#
+		#  [A, [B, C, D], E, F, G]
+		git multi-pack-index compact --incremental --bitmap \
+			"$(nth_line 2 "$midx_chain")" \
+			"$(nth_line 4 "$midx_chain")" &&
+
+		# Then compact the top two layers, condensing the above
+		# such that the new 4th layer contains F and G.
+		#
+		#  [A, [B, C, D], E, [F, G]]
+		git multi-pack-index compact --incremental --bitmap \
+			"$(nth_line 4 "$midx_chain")" \
+			"$(nth_line 5 "$midx_chain")"
+	)
+'
+
 test_done
-- 
2.53.0.171.gde83996e422
