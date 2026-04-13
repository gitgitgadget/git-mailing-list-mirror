Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ED01C68F
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 23:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124619; cv=none; b=f8lNRvDK+JXMiwwaszEzzwKcgy4/e5niK5q1GsLwIxhCCjLpf0pvEdeWoX7LojNA9HzGGgFDEl+IjN92NUjhxw4ugtsrolOiXp40Ib1Ch8K2SH9r3IBYGGxHPnz7m0CZDFtD4f3prrLo85qjmPm9iH9LT3ywRYtUhj1tY/v0BZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124619; c=relaxed/simple;
	bh=UgRtuaraaHdK58Vc0TbFipgC0rzvHOacphBnXsW0pL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgOxea/RTaek3BWVx2MLBY3vkA9o/kCRt9Kr4DbAdfOnFrBAJ8Inyf8ycIr6wg7lGTuZcz5YYgG7/KGCazreiyxlXE0jxVYwE9Wfxp0tZSGxaNPcp0etchOFkEWd/tmoZ7Cxdwa55AWZJrRFBu9Y81ea7gODFhnkuegynFudej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=iDPA7RBD; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="iDPA7RBD"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79a60975dc5so54887577b3.0
        for <git@vger.kernel.org>; Mon, 13 Apr 2026 16:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776124617; x=1776729417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMhb1Uxogf5In6s2Cr8f72u4hDnr9HdlPwQDlxKDP/g=;
        b=iDPA7RBDJo8ScNdQixMnSbHv+lQ97PeNloBjqsMTMzlEU9iC7NhloYjIuFO+jwI1py
         FsNmbt9MXLtEix/hjBT2Ss5hpYaibUNSgjconLIhQeSYsQLPtWe84H8cG4Sfvv9z86WI
         UnvDikd6QNXEP+Fm7rVdTjkYEoEUOyWyaKvmGjN2973CUjGpRR0V5dyPelOR9sDKMr85
         X5zwKumxBAnZwvFg7vBpUAqndBy4Gs5BxMgFCPFTeiwVw0HPgmCuqG5+I44s5+J9RqbC
         1P9sJVXzZMrz/LbVqbzj9+x3/H3t2UWkPv3cuIKr/0sU930ENrl/5WbEIuq2/Exna9wn
         +D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776124617; x=1776729417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMhb1Uxogf5In6s2Cr8f72u4hDnr9HdlPwQDlxKDP/g=;
        b=OwOz/TbJ58HUlAZQ6Ni6RECXOhyPke6OJrXjmlYKqDpvWU2oZKb6T54UEXF1KaWeYW
         VCdlA+H5W4ZiWXJNeHmRp5dDSaKMGZFjVtXo+Fs1t3D6zfzxzl60ZR1m0xUZX0hxCJPp
         As3XHqG6do1WeEDFSlZ6lS6KuubTs9NZLJVXM1/Dfkbcexm7jJZQuquVeJb/QLJsiAdq
         xTVmO5hTXA/6Ma7fNN9KDWqrKpZVPsTJqP4QK99UA+dVo4EM1OFUlnxeqCJQzf4CV+EW
         P2LLU+rLOszeGrQIPcFPgEXlvAfQw7IWrN9XNHBYwQ6GHGEfQaBSOReio2oTWVQxuGth
         R73w==
X-Gm-Message-State: AOJu0YzU+0W3nxzd5Yv0mZF7NLYycA5A6NPy730Z9FGu1rIy1sHYWSYl
	UOAZzamdC1IlDExZK1emifZaGqtk1GMHCb89ZABHwd90PwffcCSjp4fcsqiD68W4DxxL8PWVF2Q
	YvqyIKDQ=
X-Gm-Gg: AeBDiesP+iAuAFzVfzYgxCE+M9jJxY31+Ea/8b6d0nhiS7BVdZtp9vvhETEsVNv+Ep9
	cXvzjae2mhm2mubtg78nFbTD8c15DwEmGIxSwxcnrFZzwWqlzRfYflduhVdJ+r8e6peBXFsLaxf
	7vdDjqvM+rZ/l2OfyakkdBKZ/V+/9hC63hMS07QF6K6uIZt55wWZXiKDMN/qsmpNGd8UXwUAeUE
	or05WhyZNDxfcXiP9fGrBUmwgaRQn5XJHhlC/bCsg28zStyeztWUyVr8X0QkWSVjGvCurhpbsuz
	wACfdZV4O948KQemGWlvYRickkIEBoB+fx7V4wjFazMP/es6RMgmIL19MlCkiyJH0s2t5WXpHoh
	2tdF+NgZvzJU2AMrvh3J/MqxsdyK5XXY82qnshIVejpRdpWsS1QdFtqiogu3nGvGw7a1TGKxI4z
	2+PgflAuEgo/+BV92GtBF/sGcVQUAULNtRPzq9xpSpFsxvgpyasTclIQw59NuzVqoxEpMPBnj3F
	g2nPXWNiRaWsDgaWxceQb2mx9iKwZCuxOTKKGsuGaS7/1c3SCijjRsVA15hL4e82lVIC+uTSHib
	zJqJq7xF17rlmJq+QoFh85wiCaQ=
X-Received: by 2002:a05:690c:2701:b0:798:ff2f:267a with SMTP id 00721157ae682-7af7282e2c3mr171668067b3.52.1776124616640;
        Mon, 13 Apr 2026 16:56:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3c8dec10sm60071407b3.7.2026.04.13.16.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:56:56 -0700 (PDT)
Date: Mon, 13 Apr 2026 19:56:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 6/8] pack-bitmap: parse commits in
 `find_pseudo_merge_group_for_ref()`
Message-ID: <6d74c0a177a8d910aa0394add38f5d57573eebd9.1776124589.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776124588.git.me@ttaylorr.com>

`find_pseudo_merge_group_for_ref()` uses the commit's date to classify
it as either "stable" (older than the stable threshold) or "unstable"
(otherwise).

However, to find the relevant commit from a given OID, the function
`find_pseudo_merge_group_for_ref()` uses `lookup_commit()` which does
not parse commits.

Because an unparsed commit has its "date" set to zero, every candidate
is placed in the "stable" bucket regardless of its actual committer
timestamp. This means the `bitmapPseudoMerge.*.threshold` and
`stableThreshold` configuration options have no effect: the
stable/unstable split is always determined by comparing against zero
rather than the real commit date.

The net result is that pseudo-merge groups are partitioned by
`stableSize` instead of the intended decay-based sizing, and the
`sampleRate` knob (which only applies to the unstable path) is never
exercised.

Fix this by calling `repo_parse_commit()` after `lookup_commit()`,
bailing out of the callback if parsing fails.

The corresponding test configures two pseudo-merge groups that both
match all tags. The "stable" group uses `threshold=1.month.ago`, and the
"all" group uses `threshold=now`. The test use our custom
"GIT_TEST_DATE_NOW" environment variable by setting it to the value of
"$test_tick" to align Git's notion of "now" (and therefore
"1.month.ago") with the `test_tick` timestamps, so the commits appear to
be younger than one month: only the "all" group matches them, producing
exactly one pseudo-merge.

Without the fix every commit has `date == 0`, which satisfies `date <=
threshold` for both groups (since 0 is older than one month ago), and
the "stable" group erroneously matches as well.

Now that commits are correctly classified as "unstable", the bug
described in the test exercising the "sampleRate=0" test is reachable,
and the test is marked as failing. It will be fixed in a following
commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pseudo-merge.c                  |  2 ++
 t/t5333-pseudo-merge-bitmaps.sh | 22 ++++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index 34e1da00b4e..d79e5fb649a 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -236,6 +236,8 @@ static int find_pseudo_merge_group_for_ref(const struct reference *ref, void *_d
 	c = lookup_commit(the_repository, maybe_peeled);
 	if (!c)
 		return 0;
+	if (repo_parse_commit(the_repository, c))
+		return 0;
 	if (!packlist_find(writer->to_pack, maybe_peeled))
 		return 0;
 
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 8844a3bced9..63d2f64361d 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -592,32 +592,34 @@ test_expect_success 'apply pseudo-merges with overlapping groups during fill-in'
 	)
 '
 
-test_expect_failure 'pseudo-merge commits are correctly classified by date' '
+test_expect_success 'pseudo-merge commits are correctly classified by date' '
 	git init pseudo-merge-date-classification &&
 	test_when_finished "rm -fr pseudo-merge-date-classification" &&
 	(
 		cd pseudo-merge-date-classification &&
 
 		test_commit_bulk 64 &&
+
 		tag_everything &&
 		git repack -ad &&
 
 		pack="$(ls .git/objects/pack/pack-*.pack)" &&
 
 		# Configure two pseudo-merge groups: one that only
-		# matches "stable" refs (older than one month), and one
-		# that matches all refs. With 64 freshly-created tags
-		# (all younger than one month) the stable group should
-		# have zero pseudo-merges and the catch-all group should
-		# have one.
+		# matches "stable" refs (older than one month), and
+		# one that matches all refs. With 64 tags whose
+		# commits are all younger than one month, the
+		# "stable" group should have zero pseudo-merges and
+		# the "all" group should have one.
 		#
 		# Use GIT_TEST_DATE_NOW to align "now" (and therefore
 		# "1.month.ago") with the test_tick timestamps so that
 		# the commits are within the last month.
 		#
-		# This exercises the date-based classification in
-		# find_pseudo_merge_group_for_ref(), which requires
-		# that commits are parsed before inspecting their date.
+		# Without parsing the commit, its date field would
+		# be zero, causing it to satisfy date <= threshold
+		# for the "stable" group as well, and both groups
+		# would produce pseudo-merges.
 		git config bitmapPseudoMerge.stable.pattern "refs/tags/" &&
 		git config bitmapPseudoMerge.stable.maxMerges 64 &&
 		git config bitmapPseudoMerge.stable.stableThreshold never &&
@@ -637,7 +639,7 @@ test_expect_failure 'pseudo-merge commits are correctly classified by date' '
 	)
 '
 
-test_expect_success 'sampleRate=0 does not cause division by zero' '
+test_expect_failure 'sampleRate=0 does not cause division by zero' '
 	git init pseudo-merge-sample-rate-zero &&
 	test_when_finished "rm -fr pseudo-merge-sample-rate-zero" &&
 	(
-- 
2.54.0.rc1.73.g8f4e0170952

