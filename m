Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FEA32ED4E
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781294833; cv=none; b=SD7h7rAZUPjoHWmpqa+6thaCHig1PdsX5qb1V/I6P+HHSf0cIMG4k0fDTeZSnDAOFYEqVEZyWHBQu6rMJyc6Ulzqv3nv9Rvp1VI8Znglrw28xjo3LeBckS3pwYvNlRrpIMjKt4g3WttcRiZFhmWUq2/ctUy6G7UgDLuKboJf0YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781294833; c=relaxed/simple;
	bh=eY1sVEyHsUq340FX9NH0eukHt2Ceq8UixgbfvayREwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqt44zKtk3JOVGuGEcn3v51QTJeHpvsRx/fjO/hDf/oF6MPNJlzu3zPEs7iphtq14E35wGhgUekHv2IGmol7WwxQVcCRBk7HymD4/VEQz++FgKO7EUAh8pmpiwW+VOWX3sVtjabRrgFETPn9GGdtjtVPpct2P5Hw1UmXZFAVkhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=OFEjMV7d; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="OFEjMV7d"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66039d3efcbso1575500d50.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1781294830; x=1781899630; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O86olij25scdQFWLKd0AL/KtKcz0GcEdZBiaYiw+nrs=;
        b=OFEjMV7dQXcWTvcqH0kckTw6fJ1xmwS4WXRzJO9N+XtVfSrqy2gb845C9T5ZrRIlKH
         HolJXNoHj3BiF7sLs13/hSzpI5P9bV5H2f3uoNKc2ZCtiH6McrTCnVIt5hYXMjrQz2Jz
         xbBPbVHCXkgoxOT7xw37DqPZuzhOJphNr7jqzwdlhsQCNrB3EBD+HYrZuIbph7JXat+2
         HamCM9mCmx7xHnz9xu8ZjQkvsARF8zhfFzolfT/lYyz8IHby6ItnVQ180D6EvU3VIcYZ
         i02yo5OEIiiglj3AXPxJot1RmO1RCd5gOD0LQZAfcSiBhorrczNTuutsmeV1DLoCg7CI
         V1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781294830; x=1781899630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O86olij25scdQFWLKd0AL/KtKcz0GcEdZBiaYiw+nrs=;
        b=V5wNZHMt03ajcjdbOwHF8FaUqHVyURyXSPOui3ZZ2xnbP0DZN+W+mdDQG5HEi10XqO
         VYzcvdPTAYOVDyFPBO/obOA6+NWBe8zKPg2oYJuoBccRoE34jdz010cChUVitJX8dksN
         Ylfb2XVBdzf+TVxLQWA8wQ3WuDIZYNdSVb46AntPig+LEL6uvRWHrQZLknZDNmu/nP4d
         jTX+EtoRua8MXAW4HJTZZEdMlHskkDKXrd/+u/9Qhj80ITfb2Jy5RIIplSmoD7LzyI8U
         Tihu9sobM4qCMxkeCCXHV1yXGZejwseHxhwjk+FNlmm0LsBqUVMu1Qskdv7zTmSJQ23x
         cXgw==
X-Gm-Message-State: AOJu0Yzrs1lq4ZB2amU76Tc2GRSSzm/GcYCbIxXDzDb9sr91Aqa+YcuM
	NIMtetRd4sNDpT5hQwqjeRTuQRkXf5wvBB1nD4YjNJM1tQ2BRSSXVinRkBvSbaPwJpeScVEr/0Y
	/8hTTsTA=
X-Gm-Gg: Acq92OE5wCdVm3exHczJ88KIWvEDlQwrTHXtqlveCdfzmljc4eKHmsK0r56c+Zrbq9E
	ftNkodqh/5sJDYU9YR5lJrU8xT7+AWNeFE+WNCx9m9jYkuMZ5ls4tie5e+nuLzkzfOewezE07jf
	hjaO+2WiAUOZcySI/mK2jn9VxZCasBWGXPKvqGeQDYHJbcu2p+nIOqEJ6pCZzA0w7xPrvecYgpA
	3vgY3A5VvDmaxDKhMpdg1pc6bhaUd4oWyL+sGzTRSN2CRUWW/NJKEWmjziRtvfjZDk5QwbBk9VO
	Jj4jgBUokTRaV3RQwlg3HbU4WOT6aWittfZDmaWxh/L8u34MSs+l2cx9RIBCdktTihoh4L9+jO+
	gyhC7m48i+Iq96UqKO4NWXg4d0cc/m+hxr5/5KVP3aKJSmlzJqvd19dd9yy71bdffeYceix/P0h
	joy4PYTETYJBHwiGARDVlcjxAaYbt56a0Xk+3mPnh/yOwDOysUdSQjzKBEsg505l2sVSdqIuIZL
	28bB32UM5J/CiWgrcoH+bglBnLkFQIxhKGf23fTAMQWg1LWhfajkNlNOB96ocq7PVvzs+PpEjGa
	aFp32Y/0DJqG4zF0
X-Received: by 2002:a05:690e:169c:b0:65e:1bf6:1386 with SMTP id 956f58d0204a3-66277f8a49emr3647004d50.17.1781294829893;
        Fri, 12 Jun 2026 13:07:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66274e02e28sm1603747d50.13.2026.06.12.13.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 13:07:09 -0700 (PDT)
Date: Fri, 12 Jun 2026 16:07:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH 1/3] t5334: expose shared `nth_line()` helper
Message-ID: <a3a51a1ebbf1ba67592a1c884ae7ace526c6aae1.1781294771.git.me@ttaylorr.com>
References: <cover.1781294771.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781294771.git.me@ttaylorr.com>

Since commit 0cd2255e64b (midx: support custom `--base` for incremental
MIDX writes, 2026-05-19), t5334 has referred to a non-existent helper
function 'nth_line', which is defined in t5335, but not here.

Move the helper to lib-midx.sh so that both tests can use the same
implementation. Ensure likewise that `nth_line()` remains visible from
within t5335 by sourcing lib-midx.sh there appropriately.

Curiously, t5334 passes both before and after this change. Before this
change, the failed command substitution leaves '--base' with an empty
value, and after this change, the custom base value is still ignored by
the normal incremental write path. The following commits will explain
and address that behavior.

Noticed-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/lib-midx.sh                       | 6 ++++++
 t/t5335-compact-multi-pack-index.sh | 7 +------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/lib-midx.sh b/t/lib-midx.sh
index e38c609604c..b522dbdb0f4 100644
--- a/t/lib-midx.sh
+++ b/t/lib-midx.sh
@@ -34,3 +34,9 @@ compare_results_with_midx () {
 		midx_git_two_modes "cat-file --batch-all-objects --batch-check --unordered" sorted
 	'
 }
+
+nth_line() {
+	local n="$1"
+	shift
+	awk "NR==$n" "$@"
+}
diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
index ec1dafe89fc..6a4b799b9c9 100755
--- a/t/t5335-compact-multi-pack-index.sh
+++ b/t/t5335-compact-multi-pack-index.sh
@@ -3,6 +3,7 @@
 test_description='multi-pack-index compaction'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-midx.sh
 
 GIT_TEST_MULTI_PACK_INDEX=0
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
@@ -13,12 +14,6 @@ packdir=$objdir/pack
 midxdir=$packdir/multi-pack-index.d
 midx_chain=$midxdir/multi-pack-index-chain
 
-nth_line() {
-	local n="$1"
-	shift
-	awk "NR==$n" "$@"
-}
-
 write_packs () {
 	for c in "$@"
 	do
-- 
2.55.0.rc0.3.g7bf7c87b605

