Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBCE2D0C83
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053114; cv=none; b=AHrvIl08TbJ+n/r7TLcEK0zvyEfxqtipFLXAF2KJN3pERiuhU8ya7+eHE3XGMFV7xKgF+QPvNW8Ouu/l9kfpMILUY9aQxOvD7V5pHHnivfjwZ/4XdLVuJrpPed6IRHGaIPQp71X57sKPShAerXhTjya1uPEqPjUGv0at4qN14oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053114; c=relaxed/simple;
	bh=8PmuCvr5ADlptLGbptyXJ0fCtxpgfAqErNgAIcGYnFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2/jN5rZ6uxlpbKKSp1hMGvWl8+FT9jaHY2tMfCBhz699Omb8I+jO7mIQbGDZqqgb9W1avZ27BhPKAp76KcWbJWRLPm1ML46MmBMIFDbYzzKhJkI61mprOKFV9SibObuI9RJ9bNG2AQIzzwqKdV9KGoncTbm1QOhza+70ZuzEP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=k09XBwLK; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="k09XBwLK"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-640f2c9cc72so2974084d50.3
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053111; x=1765657911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FBrhBNgL/QE73WQ5xFheLWcog+Ri7thR4m3cb7NU3XI=;
        b=k09XBwLKAyfJaosDV8C0ovkw0AYUhwzdYx/pHbzUdXFxHgciqywIqMl6fxXxwYEJ7/
         60pQGOlKLcN6jPc/qo+mFTrqvpns6WQkqEOomo1jvWDE1jCnreo8IwVZ7oP2vkXmORM+
         iGRIrQT14SavpLm1lzAlQ8k6logk1KGa4P5q3Gkpi6RMgXcbVOzI6B2sggTdmcAgaca4
         8MB8uaVviX6q2DbhYRta+HScvu0UH5i7C6nlwhfTwBpbMj1XyVXnsiDdIaTwNNaYl49R
         EfZPpeqx8yfyyiU51CbPVnk+URg7uJ9A1MSvCR0bQlzt15PabTvGhI6reeE7FixVjP00
         xRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053111; x=1765657911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBrhBNgL/QE73WQ5xFheLWcog+Ri7thR4m3cb7NU3XI=;
        b=OdEefcBaBEy2RVVW/2ST9zDiRCDzGA02Hfn/8S0wxWenJmD4e0UDSLrsFVWzNyAI2M
         COSnsZQnUVQFr/kUylNwrY8slJdi/6JSwH5vz9CLg6Lq800tH4fU6R4c4Ln7g55O8kYg
         ObV+VQZ61oY3n1Cv6bsemS4ZPz0ZFUVYY6iKSGnm5CCnHh80ZFJajMwS3YLAqPzIZy3h
         pQbYM2cf7LVK0LSxT8PZGgKHUtRQ0npEM5+6zmeqUWGP8ZoGBrqCuI9AVpKhtzFdoYBz
         1yCJ2fh727crSUqce8YzYwPo423tnkCs4IWkAyk1SwSmBHmN7Gh70Poy/kYULkt6Jq9c
         B9Kg==
X-Gm-Message-State: AOJu0Yy5C+ytZEi8FnsXZHJY/sJk2uW2mW0c4p37gKL+NGml0TGHNRnB
	jCea+135Vm+1POphZiv2tM7rvJ9qmkw/idnIGlyYDtW61s7TOpWzxm954w7/rwvYxJJmEZm+de5
	rchuDfcI=
X-Gm-Gg: ASbGncse+DWA8haQymJSeDUJywo1KFNb+QgusfZ/w2n+6pumrWvOFU0PfQdP4vOPkkf
	N/+iJ1gJARxn0iwo2Iq7qpSffUFxhKU/f7VqYT0Cpk+98osQMeBoNaxqxwb9Fk4bGWwQR5WB+5H
	jPe4vwDbUIg2AVz1b9cJbPbye5YluKyyz5e6baYfru6oIMw/i1PyL8NKtT0BPMDwkF/m/FOYnlE
	RPzOZqFsRaMf2T9/LtVvb6H4d6nVeIqt5qwypfH1yhApbKR+s8RniF9BECNO8+rEiaj3pXFYowe
	cyJeRnkZ6koZckg1YCI4oc4bPGpn+IfPijzRzWE2vcAo4q/oi1uR5FoBSsZwAm1afLih4ecwjvb
	v6p9VjT244WtlBljgaeZjeBCRbWJfA/4fm+0wfRXU/qeathcWzdI7AWtqSLgQFqnAzTHXSc/j+H
	wCLUAPwSHkniJAExUXYWjYiUKr6poXQVSEItXf0aeb/FEQH9EZFHw5yTyDi8AqRXM5nMxuGiZQW
	l3ud+gbXhjkuubz9g==
X-Google-Smtp-Source: AGHT+IHPhDQAbZx27hmnWDXhkCSQomoAB8vR0yylXpga1juNhPH8mIbLIWJxPnIVHRREzHVsMKHSHg==
X-Received: by 2002:a05:690c:690c:b0:787:ca0f:2687 with SMTP id 00721157ae682-78c33c16cf0mr56955967b3.34.1765053111283;
        Sat, 06 Dec 2025 12:31:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b779485sm30516087b3.28.2025.12.06.12.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:31:51 -0800 (PST)
Date: Sat, 6 Dec 2025 15:31:50 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 17/17] midx: enable reachability bitmaps during MIDX
 compaction
Message-ID: <d6a4e6b69552d8626e6df2d7cd042b9fe151914a.1765053054.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

Enable callers to generate reachability bitmaps when performing MIDX
layer compaction by combining all existing bitmaps from the compacted
layers.

Note that the because of the object/pack ordering described by the
previous commit, the pseudo-pack order for the compacted MIDX is the
same as concatenating the individual pseudo-pack orderings for each
layer in the compaction range.

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
 Documentation/git-multi-pack-index.adoc |   2 +-
 builtin/multi-pack-index.c              |   4 +-
 midx-write.c                            |   2 +-
 t/t5335-compact-multi-pack-index.sh     | 120 +++++++++++++++++++++++-
 4 files changed, 123 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index a9664e77411..458bb873633 100644
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
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 9b0c2082cb3..40afa8f1ed8 100644
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
index fcbfedcd913..f2dbacef4cd 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -657,7 +657,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 		struct pack_midx_entry *e = &ctx->entries[i];
 		data[i].nr = i;
 		data[i].pack = midx_pack_perm(ctx, e->pack_int_id);
-		if (!e->preferred)
+		if (!e->preferred || ctx->compact)
 			data[i].pack |= (1U << 31);
 		data[i].offset = e->offset;
 	}
diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
index f889af7fb1d..a306f504305 100755
--- a/t/t5335-compact-multi-pack-index.sh
+++ b/t/t5335-compact-multi-pack-index.sh
@@ -65,7 +65,7 @@ test_expect_success 'MIDX compaction with lex-ordered pack names' '
 		write_packs A B C D E &&
 		test_line_count = 5 $midx_chain &&
 
-		git multi-pack-index compact --incremental \
+		git multi-pack-index compact --incremental --bitmap \
 			"$(nth_line 2 "$midx_chain")" \
 			"$(nth_line 4 "$midx_chain")" &&
 		test_line_count = 3 $midx_chain &&
@@ -86,7 +86,7 @@ test_expect_success 'MIDX compaction with non-lex-ordered pack names' '
 		write_packs D C A B E &&
 		test_line_count = 5 $midx_chain &&
 
-		git multi-pack-index compact --incremental \
+		git multi-pack-index compact --incremental --bitmap \
 			"$(nth_line 2 "$midx_chain")" \
 			"$(nth_line 4 "$midx_chain")" &&
 		test_line_count = 3 $midx_chain &&
@@ -99,4 +99,120 @@ test_expect_success 'MIDX compaction with non-lex-ordered pack names' '
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
+		cat $midx_chain &&
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
+			"$(nth_line 5 "$midx_chain")" &&
+
+		cat $midx_chain
+	)
+'
+
 test_done
-- 
2.52.0.171.gd6a4e6b6955
