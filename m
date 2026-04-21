Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6055A35DA48
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801729; cv=none; b=WPrI2535vqSJ47kSDTcULUKRCUTPzhZfJF5JOym4KrPBF4xBFd/AeO5Rj1M9vDF32x47Z7ts+cAN5YxB0RyGvfTfOmHHWAinTKqVl3ZuNh2YR64PsZjziftBfy4JZblOOEp1dHk28tBRGCCJqSJAdB41R7WDKtnqIogH5Di+Ii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801729; c=relaxed/simple;
	bh=2P+S4iWbdPpNW1UoE+ae6w6i3aVJu0wj9m284+W9jOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxmXbxQwyExXv2c22IbnaxRK11G/0kgaeIIqPz3/CaaB0+l0YJdQZKVXCYSFXXhTdCdnnt9cAB4gUJBxE9x8VMztH5ogImXUIEk6jtDRoX4WFhkSAXO/wM05wFeZl6KiDlW0CC2jRvpsiRbE/bFpFoBWnPcNolM7d2SI1+goS6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=j0CB4Wnr; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="j0CB4Wnr"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-479d85152c9so908406b6e.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776801727; x=1777406527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cQWPDNF3GXOVxkzkz5h8YKNR9zQ00y4Pc2Vd9fjURho=;
        b=j0CB4Wnra1TDrvbNNbQU8wk5WfwwbCXdtX2Jp5E5DhIvTRP6WjeKezpI4ZBmEbaA4J
         Z/FBeNKcDMFgaBwADUITzSBqrEp1rFv/GwLVF/aPwni5H7x4SDjwhrCsUzMbyHxvyP7Y
         7mrPdB8ickB/VbET6ylqh0ipgqB5B30rFYQ41YfMZlBLqPS/na0QueHjTmXgSPaeZqh9
         tWJgrCxD7iuL7oekd0wTG2HliymNUPPB+aCTHzCXsDJbNhUyxoMR0KE92+Si/OfSZgha
         Xh0p0mD86YK9v5codwFn/fnsiOsfpXNJEQlw1LFx8zuELNgMoPt+iG20dncWulb/bU2J
         5khQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776801727; x=1777406527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQWPDNF3GXOVxkzkz5h8YKNR9zQ00y4Pc2Vd9fjURho=;
        b=R24EKQ5vpfKr0NWZl81Pj9CEHamyrAF77SaDMpfg5jTLq+c4Ow0YhevlBlbpBvrmU3
         pZg96cKE8+vCx8cz0AnvPHr0SnwCKehd8ZvuVxERzFxNNYER6+9LCFw7mOYE/GJSlhmB
         kXMOHUc7xRIUlxhKLUe212mYbNB0rJ+WsSQrR0N9OjlGjaeh3owK9L1O1iZlEZGlQTU2
         kagk1hRqulfmFHDWlJl+jDm8IVaKa8iWHRCzX5xMhuu00Yp7ieQUEfNVdRVHKourivLg
         Nc5VThOYHpCf51G2KaHpiCXK6yyscofa+UX71QNsek0JI9wCYG6HnZ25SFv+k6gmt8rC
         ZRzw==
X-Gm-Message-State: AOJu0YzQOPyNRk9Z7ZPEKVEkhj7zVLLJWBJCqa/Hrh70vafA9cSO03Wh
	kErfT8qSfvJjsLFR3DMsSEDfWnoBfirfesexle7twW9yAjwoa3r54XBuBysKQOkdWIQC4tmug5B
	gWBSq+mo=
X-Gm-Gg: AeBDieuylLv85qE8lSBQpjTYqQHpk70Z4E8Tbdm/mx541NCWpO1XKG2pg9WmvDGjaU3
	dt3+SAWQpfzk+7VDSyrzgmoZR2elCTsLofQX/nAtSj2Nzf8TVNlGGyVL0MIIfPcL+cT9u2IZVe4
	a31U1lgCS/jCjfGZ2q4xqH+OZI58LkdmFSy58gOQY3to7UfxudqQ4QgsJfzWB4db6zo2aim5hv9
	MudXXkZw+w2o9xkQx6NO0VxzUyxzUZ+uCdrmt+Zgg+NDX1eXcP1K6kmYgsa1PgH0EqZhFGrP9YT
	423MRX2T2dNNnBP8jx9ZqpQcuJ4AD8cJgXSslQyVTnBFgoDzHENN2b+CxTKe68Z8j2sR7haKJzw
	H0UZE58JlZp3uKkgt0f18EtvU09E3tnJ1lGKfCexDswdWFb/Wghwv5PzKi1VBeFQEHdJM1Jbe7E
	5NaxxAY3EGKIrk0A6Wcsy7ovw/HFSlgh477WaIpoiRbjC2bQmwwxVOre3Jb2NERznJB5rvDCNyX
	hkyW1Dio8L760lZpwSPSfPEivFhqaJpxANnk+lVahKwIUpl6vyHyFlSDMvVJXTOoLb8mzd3nl5p
	TCNtAk9UBqat9Db5w2QE3sDT4laAMq+boqY7ww==
X-Received: by 2002:a05:6808:8955:b0:479:eb19:6e71 with SMTP id 5614622812f47-479eb19b0femr3358963b6e.5.1776801727057;
        Tue, 21 Apr 2026 13:02:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479f6705d7asm1180230b6e.10.2026.04.21.13.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:02:06 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:02:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 4/9] pack-bitmap: fix inverted binary search in
 `pseudo_merge_at()`
Message-ID: <07f70a07c2034ae6bfc718d0e599a1a41dd77290.1776801694.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
 <cover.1776801694.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776801694.git.me@ttaylorr.com>

The binary search in `pseudo_merge_at()` has its "lo" and "hi" updates
swapped: when the midpoint's offset is less than the target, it sets `hi
= mi` (searching left) instead of `lo = mi + 1` (searching right), and
vice versa.

This means that lookups for pseudo-merges whose offset is not near the
midpoint of the pseudo-merge table are likely to fail.

In practice, with a single pseudo-merge group this is masked because the
lone entry is always at the midpoint. With multiple groups, the inverted
comparisons cause lookups to search in the wrong direction, potentially
missing entries.

Swap the "lo" and "hi" assignments to search in the correct direction,
making it possible to apply pseudo-merges during fill-in when more than
one pseudo-merge exists in a group.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pseudo-merge.c                  | 4 ++--
 t/t5333-pseudo-merge-bitmaps.sh | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index ff18b6c3642..fb71c761792 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -559,9 +559,9 @@ static struct pseudo_merge *pseudo_merge_at(const struct pseudo_merge_map *pm,
 		if (got == want)
 			return use_pseudo_merge(pm, &pm->v[mi]);
 		else if (got < want)
-			hi = mi;
-		else
 			lo = mi + 1;
+		else
+			hi = mi;
 	}
 
 	warning(_("could not find pseudo-merge for commit %s at offset %"PRIuMAX),
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 3d7a7668121..c5db6a11f6a 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -496,9 +496,10 @@ test_expect_success 'apply pseudo-merges during fill-in traversal' '
 	)
 '
 
-test_expect_failure 'apply pseudo-merges from multiple groups during fill-in' '
+test_expect_success 'apply pseudo-merges from multiple groups during fill-in' '
 	test_when_finished "rm -fr pseudo-merge-fill-in-multi" &&
 	git init pseudo-merge-fill-in-multi &&
+	git init pseudo-merge-fill-in-multi &&
 	(
 		cd pseudo-merge-fill-in-multi &&
 
-- 
2.54.0.9.gb905fd5d0ae

