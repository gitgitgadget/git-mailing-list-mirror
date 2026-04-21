Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C43D9DDA
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801735; cv=none; b=cyOSYp+nyozuY++zsyGIQM7IRjRVqarLXKNAz8uj6WgjblRR14j9vk4D465nqwlYnB98JhUIaTsW3y/3EbyEeLaMWDK+3u65fMZDE7X86Pd8IRpF90X+8AYRDETS5WUsb2XkSBXcQNrpusuKjkPMKXhGohJSojUYfkZGQL6UX80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801735; c=relaxed/simple;
	bh=RxLVyw5jbLZXSg1bjRD4RawkYJ4dYPeXG0Iy1g3aakQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1+Opq9wcZW199ylLHP8xfdpU5Ttjr0BxAo3tujdjDa7L/Obs1YynZnsJT36nQf3+zlFKuVMKmYzuA6Q2scBY4S3fkbI6dUPPJDCeRLyXnevqqJ2L/VegJwvWmxMi3MUQXvGLFEDlrfE5wpY3mnCH0q/aIDr+jvKZY3XvUqXeys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=m4hM9Vkz; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="m4hM9Vkz"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dccb8644c4so980608a34.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776801733; x=1777406533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wRMIQcUlvJRCvyg6MTF3fGNo4vsSa+Z+x5hkFgTT/JM=;
        b=m4hM9VkzzE8KQImzaQLMwD35VNhVzFjr+IudXyop4WHkks/RZw+SU+4/ps2MaS6N2b
         1BBHk03vZYGVngaNlkX24AdrUr4rrh8wImSUx0ax6G5AhhOPrtp65e80RtSZtg9xeVPX
         Swv2Ae/sU73gZu1jBW4fCX1VloJfVgnAGVG4cRWbbWP2c2Mh5i00CjMfyWTWZ4/ImNGo
         736qrZVDMD0UYS6mclUYYe5RihjaQIvMlK3pNuFdCucC7TTncrY9vP2KmxQCjJKUWtBB
         QiVK+TKHtdmHLzGMzj6fm1QpwHhVwmHLhZNYV6Zd7LYDmvp2kTAiQC8Fpvb0LQXiZR6X
         tGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776801733; x=1777406533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRMIQcUlvJRCvyg6MTF3fGNo4vsSa+Z+x5hkFgTT/JM=;
        b=do3NEpvZNJ/1t6Uy8lcIdH1fpVPheS7dnMMD5UPPVwnHEEimUh4BGM1tFKeChjG/mn
         /RWQKeLMPxw+D2HqTW+qDzKSt3y+aUDZql42ImfHGryVOQJ5aN6kkoGernilBT31mwZ+
         Y92SgsA4psVk1Kp3CPpS2z3mXkTv+hc3oFBIzJNgVOzZ8C5xXYF/60pwqEstAzMpW5N8
         tTgGk0ZzYjevYd5prSRV3xOyd4L3n14LZ2zjtQpkfvJlV5Obc5QBgdBcEekdBXlvMW4j
         N66GUOpbTj4eSYbNeW4hzzaJrKn6c/rEXqllhXjRC+ogDnbGIL7g1mEndexTa5E0rCx8
         DoKA==
X-Gm-Message-State: AOJu0Yx2JHhN3JcK9BroZJecaXvAYBn0B40ulE1okXM4Zf/9ks6cR5q4
	IvcVoMS7gaFj5gSruTUByeOy0ixGf3kLuMEy58jdgeBy75lMvuaAJUpbhc+yEYUP8DUDIkVCnm0
	tttt9UDI=
X-Gm-Gg: AeBDiesKCHbQCU8lo6Sn/+hcOWKgYZPEveXwTJbMf34fGByyVaoh0/NijpV4ImbhUMh
	FrSnuFO7ZJuAkQUw/Kktn9d31aqebNyfn0FQ8DZaPiTX7560q7PL+lIRuOj0vejbo/LsCvOoH+Q
	tuzZd0rM5m0F9Bnl7CE3vnhKmKh/OoL1T/7g9oCv06q5zAP6NaYq72ckNRzvsLWCKuFzzzI1UDe
	nExLZYTfdhR281MrnVZDxYSlOfOdBdkMffVevxEKTfoiQyFGLtvHDKqvE8U/kMADVcaLJuf7HiB
	RajGbeFR6s6mrQ9IlBGEsFGdlnPJYjmSnMcr4dJBD+TkAcvwafzo+FyeqMTvJo/DhOESrinkeb2
	kedlxwre4flSzhaNhL9L/0ZxiS2Rv+fsz9H8Hg52tARzXpe2CtLp8cge1s8wgHS/GPVp0d5KRxm
	/t0jiqQR689ADDwwLFJTeDZlet067UQjpqGTZu96nEN3pbWHZgRwXKazU/dD78LfyeZD8JPsBuD
	qSZCI2g/qRaJUNwR2RCFKuFratGb4JbODgtcqpWWA7lWYiue9CZBhcmR3fe7bbiCwrtmXf9I1bj
	huPx+6vyqhRFCkHq8LrvYTGUWjY=
X-Received: by 2002:a05:6830:33e3:b0:7dc:cd0b:58ac with SMTP id 46e09a7af769-7dccd0b6c4cmr3381086a34.9.1776801733025;
        Tue, 21 Apr 2026 13:02:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dce20ff8c3sm1052321a34.22.2026.04.21.13.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:02:12 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:02:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 6/9] pack-bitmap: parse commits in
 `find_pseudo_merge_group_for_ref()`
Message-ID: <95f847211f339ab8a32350198902e113d85b8e5d.1776801694.git.me@ttaylorr.com>
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
index f558e87ab21..e27f9850dc4 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -593,32 +593,34 @@ test_expect_success 'apply pseudo-merges with overlapping groups during fill-in'
 	)
 '
 
-test_expect_failure 'pseudo-merge commits are correctly classified by date' '
+test_expect_success 'pseudo-merge commits are correctly classified by date' '
 	test_when_finished "rm -fr pseudo-merge-date-classification" &&
 	git init pseudo-merge-date-classification &&
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
@@ -638,7 +640,7 @@ test_expect_failure 'pseudo-merge commits are correctly classified by date' '
 	)
 '
 
-test_expect_success 'sampleRate=0 does not cause division by zero' '
+test_expect_failure 'sampleRate=0 does not cause division by zero' '
 	test_when_finished "rm -fr pseudo-merge-sample-rate-zero" &&
 	git init pseudo-merge-sample-rate-zero &&
 	(
-- 
2.54.0.9.gb905fd5d0ae

