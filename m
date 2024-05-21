Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9517D142910
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318128; cv=none; b=gGk1FAsV090AfVYhPXlEzz19on1nSDwfEE/+xRlcKaiyZ3dfc0FUfCDdMpgmyho0tJqL9H+MZrGwKdpbxYh91Qbs1taEYj82DQfFThpqRcxYC/eejDIAxOtR7l9HZtFt1kGdMFie+fnfYH8Djap0JJknoL9Z4wxqn8P/I/c0Vs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318128; c=relaxed/simple;
	bh=uG2VeWxyNu+y9XCRxT3eBN3ROPalKcbRovJk6gABMlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiTn6+N3lDJgUUbQQv9rlEB70eZ7T1OzWuc233XeJieIB473vt6lxOv77r648zgDZKOk+mPbg7g7Jmb5855eTn38PQNItvM/IT1NuyXS+VFDBfynj455CBJ6vY3YvV0VSkGJZZ6ZOuM01qwottTFAsYIhcpwKkxQya/i2sYSt9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cp/EHThH; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cp/EHThH"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7948b50225bso38937585a.3
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318125; x=1716922925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CwhWHFflON3YqISFMkfOPz3bJpv//U/ZSMzwtdbnnRs=;
        b=cp/EHThHbjGrFxtQjYayIV+4Zo4sw8cKVhKXzd9Nog8H3/rmWgDQy0ZJNmvhXvJkBS
         HqBYmihQACJDgBrXKoW1EWQDWE4EA6ghu+jsUO4+315NfiMBElrWmXDEOj4Dbnkd6HU5
         TBpD/p9crZy09RzyJZCBs9cwF343N9BCPPRwAqIgFPozydvq+q1qmJbRYgttUE9RUmu6
         j62kIfu/o8qvlWeNeQpbd0uDjJPZ9x7+zONHzvVVIETt0Z3lbCeOz3WS1iL0gSqOyLIn
         KpSuNJtqabDJVgaOhDxLCGmzDxLoq0EpjzPrrf6MdLoan/gTJCCOnJCxtou1XHcqNCCQ
         z0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318125; x=1716922925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwhWHFflON3YqISFMkfOPz3bJpv//U/ZSMzwtdbnnRs=;
        b=PZbVYGgpGcJ4JzA4MFQFieFAj1IBn8FuLPN/Imtg0lyvbaft2rU6w66zuYxT+YFCv6
         yIxS0L5LE24XpKipjMKetMIay6ij5TiUV3CAkmrmEsd3AoG7QFjhXtFh636HpzLRHHsb
         VEmuI+H2dUeV+yLjejiGDamhvGtjn/rBrl8g35d5r7QSIQpeJ2oD6gAxpMVNfFxOPMkf
         JwuTP4MixAhwIww1a8ZDbdZczdEXXfl8rshsJZnEoLGqSo6zQnGU0grsn41OAQEadVYc
         XP+6foT62/PNiX/uFIIM75isECLTTbRAHTK2p1DqWLOnCKjwfgGYxFab28YyYl5cHZHy
         LC+A==
X-Gm-Message-State: AOJu0YzfGem8GJ91MEv8MTCoDoFpyHKPnnWBOfZmfB6X/8Tr3B0lT5OM
	j3Zy3/5gCFi3XXnJqSSZ1smNWEFivyDUr+FRsuzcaGIB8dkKukGnp3vNtULl4idiH8aLx8+Af6z
	R
X-Google-Smtp-Source: AGHT+IGplrmGOt1vruyiZ4ZDfHE1dg/fHxWIe1VNAfttv/hRVAS1DbvDpKjuNxuJfX68SYRcLJVbFA==
X-Received: by 2002:a05:620a:1272:b0:792:c25e:2d49 with SMTP id af79cd13be357-792c7576fc2mr3784978685a.4.1716318125040;
        Tue, 21 May 2024 12:02:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792e564e4dbsm907513485a.82.2024.05.21.12.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:04 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/30] Documentation/gitpacking.txt: describe pseudo-merge
 bitmaps
Message-ID: <528b591bd84e189d7d48e01deb8e876f74fc471b.1716318089.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

Add some details to the gitpacking(7) manual page which motivate and
describe pseudo-merge bitmaps.

The exact on-disk format and many of the configuration knobs will be
described in subsequent commits.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/gitpacking.txt | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/gitpacking.txt b/Documentation/gitpacking.txt
index 50e9900d845..ff18077129b 100644
--- a/Documentation/gitpacking.txt
+++ b/Documentation/gitpacking.txt
@@ -24,6 +24,75 @@ There are many aspects of packing in Git that are not covered in this
 document that instead live in the aforementioned areas. Over time, those
 scattered bits may coalesce into this document.
 
+== Pseudo-merge bitmaps
+
+=== Background
+
+Reachability bitmaps are most efficient when we have on-disk stored
+bitmaps for one or more of the starting points of a traversal. For this
+reason, Git prefers storing bitmaps for commits at the tips of refs,
+because traversals tend to start with those points.
+
+But if you have a large number of refs, it's not feasible to store a
+bitmap for _every_ ref tip. It takes up space, and just OR-ing all of
+those bitmaps together is expensive.
+
+One way we can deal with that is to create bitmaps that represent
+_groups_ of refs. When a traversal asks about the entire group, then we
+can use this single bitmap instead of considering each ref individually.
+Because these bitmaps represent the set of objects which would be
+reachable in a hypothetical merge of all of the commits, we call them
+pseudo-merge bitmaps.
+
+=== Overview
+
+A "pseudo-merge bitmap" is used to refer to a pair of bitmaps, as
+follows:
+
+Commit bitmap::
+
+  A bitmap whose set bits describe the set of commits included in the
+  pseudo-merge's "merge" bitmap (as below).
+
+Merge bitmap::
+
+  A bitmap whose set bits describe the reachability closure over the set
+  of commits in the pseudo-merge's "commits" bitmap (as above). An
+  identical bitmap would be generated for an octopus merge with the same
+  set of parents as described in the commits bitmap.
+
+Pseudo-merge bitmaps can accelerate bitmap traversals when all commits
+for a given pseudo-merge are listed on either side of the traversal,
+either directly (by explicitly asking for them as part of the `HAVES`
+or `WANTS`) or indirectly (by encountering them during a fill-in
+traversal).
+
+=== Use-cases
+
+For example, suppose there exists a pseudo-merge bitmap with a large
+number of commits, all of which are listed in the `WANTS` section of
+some bitmap traversal query. When pseudo-merge bitmaps are enabled, the
+bitmap machinery can quickly determine there is a pseudo-merge which
+satisfies some subset of the wanted objects on either side of the query.
+Then, we can inflate the EWAH-compressed bitmap, and `OR` it in to the
+resulting bitmap. By contrast, without pseudo-merge bitmaps, we would
+have to repeat the decompression and `OR`-ing step over a potentially
+large number of individual bitmaps, which can take proportionally more
+time.
+
+Another benefit of pseudo-merges arises when there is some combination
+of (a) a large number of references, with (b) poor bitmap coverage, and
+(c) deep, nested trees, making fill-in traversal relatively expensive.
+For example, suppose that there are a large enough number of tags where
+bitmapping each of the tags individually is infeasible. Without
+pseudo-merge bitmaps, computing the result of, say, `git rev-list
+--use-bitmap-index --count --objects --tags` would likely require a
+large amount of fill-in traversal. But when a large quantity of those
+tags are stored together in a pseudo-merge bitmap, the bitmap machinery
+can take advantage of the fact that we only care about the union of
+objects reachable from all of those tags, and answer the query much
+faster.
+
 SEE ALSO
 --------
 linkgit:git-pack-objects[1]
-- 
2.45.1.175.gbea44add9db

