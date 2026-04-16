Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A72536BCD7
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370028; cv=none; b=KBSoyLcJbKAEM9S2Vc8SpHYDru7fB10g9pNQJ9/S3qo3AhAp+frgPV9tp4fmXqTAPshhJfDNGzIzgFlBilwt/9WcervJNLGjX2qiEDvByqXdh/vTXRIOGmX3HgNhN7sNqGOsvPWRIJe8pxnF3iTquMuLBTHK/xR/Ehy6Rqiwz5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370028; c=relaxed/simple;
	bh=w94QZ9xe/hCqCxdUxywUZFBqu40aVbITfuBZ8m854Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8K/jxzRdOoXIOODbOBaX2qRsJLgiqglslPuY5WyZEv1U8/u0UGuLudiUBrcfg1dzEm1QlrY7u76pF1az0kbOOgBr2PXe81o5usfCjIgaF5XLDT6j82gm1NabcS2bD/OiWqIigqmAjUFf8OjP0D84ergk6Vg1Xu/OX/7tULoGC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ibgGbH1G; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ibgGbH1G"
Received: (qmail 373843 invoked by uid 106); 16 Apr 2026 20:07:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=w94QZ9xe/hCqCxdUxywUZFBqu40aVbITfuBZ8m854Pc=; b=ibgGbH1GK8eCKTh+uK55H6T6wmSPEjzKeNcAqIpVuils6twzCmaakUN3yq3nP5pSxS8nzxan8tZ75Ug5XGJbqQNEoQE16Eh1AhpUkyYNT+Xv7G5dj0XwUhCDKzaMtgftXc2a8EAK7NYHIewVFWE4Cmpe/eEB0izQxYUfNTBDW/FwdrlbW63Rjf2uZv8AKIxJi9yjUpT4y4he+uzNruY6aqJsVfZ0ebwNsGBC2fYnVS4QjdN3Rgx6yVkySf/t7ZoiEHJqS3rmODzdhpWGOEb7xc0hyXk2PdzyUa8+UIshoUvVhmLNRrbDMEPtcF+/bm8aP9h+kpK7Z2TNTWyLnHioOQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Apr 2026 20:07:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 622295 invoked by uid 111); 16 Apr 2026 20:06:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Apr 2026 16:06:59 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Apr 2026 16:06:59 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] MIDX: revert the default version to v1
Message-ID: <20260416200659.GB1887222@coredump.intra.peff.net>
References: <xmqqqzohd0sh.fsf@gitster.g>
 <8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
 <xmqq5x5s540j.fsf@gitster.g>
 <20260416051732.GA48541@coredump.intra.peff.net>
 <20260416053435.GA646718@coredump.intra.peff.net>
 <xmqqldem22uw.fsf@gitster.g>
 <xmqq8qam217m.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8qam217m.fsf_-_@gitster.g>

On Thu, Apr 16, 2026 at 11:45:49AM -0700, Junio C Hamano wrote:

> From: Jeff King <peff@peff.net>
> 
> Dscho reports that fetching into a repository with Git 2.54-rc2 made
> it unusable with Git 2.53, as the recent code by default writes
> version 2 multi-pack-index files.  Version 2 is the base of more
> advanced features to come, but using it where these features are not
> used is a strict regression.
> 
> As deployed versions of Git and its reimplementations may not be
> ready for the format bump, let's revert the default version of MIDX
> file we write back to V1, and adjust tests that exercise V2-specific
> features to explicitly request V2.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

This looks fine to me, and you can add my S-o-b if you want. But let me
propose a slight alternative that reduces the test churn and may make
things easier going forward.

-- >8 --
Subject: [PATCH] MIDX: revert the default version to v1

We introduced midx version 2 in b2ec8e90c2 (midx: do not require packs
to be sorted in lexicographic order, 2026-02-24) and now write it by
default. The rationale was that older versions should ignore the v2 midx
and fall back to using the packs (just like we do for other midx
errors). Unfortunately this is not the case, as we have a hard die()
when we see an unknown midx version.

As a result, writing a midx with Git 2.54-rc2 puts the repository into a
state that is unusable with Git 2.53. And this midx write may happen
behind the scenes as part of normal operations, like fetch.

Let's switch back to writing v1 by default to avoid regressing the case
where multiple versions of Git are used on the same repository.

There is one gotcha, though: the v2 format is required for some new
features, like midx compaction, and running "git multi-pack-index
compact" will complain when asked to write a v1 index. The user must set
midx.version to "2" to make the feature work.

So instead of always using v1, we'll base the default on whether the
requested feature requires v2. That does mean that running midx
compaction will create a repository that can't be read by older versions
of Git. But we never do that by default; only people experimenting with
the new feature will be affected.

We have to adjust the test expectation in t5319, since it will now
generate v1 files. And our "auto-select v2" is covered by the tests in
t5335, which continue to check that compaction works without having to
set midx.version manually (and also explicitly check that asking for v1
with compaction reports the problem).

Signed-off-by: Jeff King <peff@peff.net>
---
I have a feeling there are probably some gaps in v2 testing in t5319,
since we are no longer using v2 for the bulk of the tests. IMHO that is
OK to sort out post-release.

 Documentation/git-multi-pack-index.adoc | 3 +++
 midx-write.c                            | 4 +++-
 t/t5319-multi-pack-index.sh             | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index 6125683014..3a5aa22778 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -98,6 +98,9 @@ compact::
 	--[no-]bitmap::
 		Control whether or not a multi-pack bitmap is written.
 --
++
+Note that the compact command requires writing a version-2 midx that
+cannot be read by versions of Git prior to v2.54.
 
 verify::
 	Verify the contents of the MIDX file.
diff --git a/midx-write.c b/midx-write.c
index 0ff2e45aa7..a89ac53045 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1259,7 +1259,6 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	struct tempfile *incr;
 	struct write_midx_context ctx = {
 		.preferred_pack_idx = NO_PREFERRED_PACK,
-		.version = MIDX_VERSION_V2,
 	 };
 	struct multi_pack_index *midx_to_free = NULL;
 	int bitmapped_packs_concat_len = 0;
@@ -1275,6 +1274,9 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	ctx.repo = r;
 	ctx.source = opts->source;
 
+	ctx.version = opts->flags & MIDX_WRITE_COMPACT ?
+		MIDX_VERSION_V2 :
+		MIDX_VERSION_V1;
 	repo_config_get_int(ctx.repo, "midx.version", &ctx.version);
 	if (ctx.version != MIDX_VERSION_V1 && ctx.version != MIDX_VERSION_V2)
 		die(_("unknown MIDX version: %d"), ctx.version);
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 58e0b685b1..fa0d4046f7 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -21,7 +21,7 @@ midx_read_expect () {
 	EXTRA_CHUNKS="$5"
 	{
 		cat <<-EOF &&
-		header: 4d494458 2 $HASH_LEN $NUM_CHUNKS $NUM_PACKS
+		header: 4d494458 1 $HASH_LEN $NUM_CHUNKS $NUM_PACKS
 		chunks: pack-names oid-fanout oid-lookup object-offsets$EXTRA_CHUNKS
 		num_objects: $NUM_OBJECTS
 		packs:
-- 
2.54.0.rc2.265.g593c85fc46

