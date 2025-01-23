Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EE9629
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737592583; cv=none; b=Hx8uvbn8ukud2lfgUSXfsD6zdEiYX0blkGp6xE7mYoXtUGb2ET8g2lgDvmG06ebukxS+J513faCxDf5DzEOTmr8jW6Y0z8wHvndeGEPYBKEwVANBVBGuIBEwiq/Hio5QX5/rkst7PzcvDyvmT6ZGn/V24Em5kkvUxYvFD2RJvaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737592583; c=relaxed/simple;
	bh=jz9v/BS9XckaiGo2+8dar5zF4D/VbMCVchvJODh54po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKGB7axYRDSe5MVgU8oKgXZazzOej436QTYBdncWrnfAK8jnvZloCrOgPUSgfobxb6RtxAMlmivmKdDrwXFbQm+L2Kqt/ozqVOgaJmiesKGRRGoaepVuwdtMf7MvvVzciMWO9fQjVKvKRKIAW8oWyon1Zycr08tr8cjY5aAPlTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=h9tj9bgj; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="h9tj9bgj"
Received: (qmail 19418 invoked by uid 109); 23 Jan 2025 00:36:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jz9v/BS9XckaiGo2+8dar5zF4D/VbMCVchvJODh54po=; b=h9tj9bgjETPav7r9kDry5xtzN4eVb6cwEDcV5LG7KYe5bUSWKke9sZEDzDcKzcEWOgz1IO/woKYF9YCkjeApn+5CKvsiaIkpDQZ8BEsDutsQl67ts7M0ZXHAYsdrgSLZ6LwH97LEnjLB9WwfiSJ8ifHHmpUiUC0dw3AzsGCh6yeZasbsiLRmTTItpumUv9fBRaF+wHSc5hOyRLTn4Yv6XwQQrhlZu7t552jT8T2sAOalDK+Q4R1qCEpl4FZHeDSWEvZ2/B+UywoFCYZPoBWyhZ5IVTM7c5qTr/utWqYARtlOFtzCvgXr9BsQAcielz8aaIdj+m+jWrC/4tS3HfJCiQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Jan 2025 00:36:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19626 invoked by uid 111); 23 Jan 2025 00:36:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Jan 2025 19:36:16 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 22 Jan 2025 19:36:13 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
Message-ID: <20250123003613.GA3900660@coredump.intra.peff.net>
References: <xmqqbjvyv510.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbjvyv510.fsf@gitster.g>

On Wed, Jan 22, 2025 at 02:48:43PM -0800, Junio C Hamano wrote:

> * ds/path-walk-1 (2024-12-20) 7 commits
>   (merged to 'next' on 2025-01-22 at 3171845b73)
>  + path-walk: reorder object visits
>  + path-walk: mark trees and blobs as UNINTERESTING
>  + path-walk: visit tags and cached objects
>  + path-walk: allow consumer to specify object types
>  + t6601: add helper for testing path-walk API
>  + test-lib-functions: add test_cmp_sorted
>  + path-walk: introduce an object walk by path
>  (this branch is used by ds/backfill.)
> 
>  Introduce a new API to visit objects in batches based on a common
>  path, or by type.
> 
>  Will merge to 'master'.
>  cf. <Z4jeQSLmARruE5l3@pks.im>
>  source: <pull.1818.v4.git.1734711675.gitgitgadget@gmail.com>

Since this hit 'next', it made it into my Coverity runs, producing the
small fixup below.

-- >8 --
Subject: [PATCH] path-walk: drop redundant parse_tree() call

This call to parse_tree() was flagged by Coverity for ignoring the
return value. But if we look a little further up the function, we can
see that there is already a call to parse_tree_gently(), and we'll
return early if that fails. So by this point the tree will always be
parsed, and the call is redundant.

Signed-off-by: Jeff King <peff@peff.net>
---
 path-walk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/path-walk.c b/path-walk.c
index 136ec08fb0..9715a5550e 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -116,27 +116,26 @@ static int add_tree_entries(struct path_walk_context *ctx,
 
 	if (!tree) {
 		error(_("failed to walk children of tree %s: not found"),
 		      oid_to_hex(oid));
 		return -1;
 	} else if (parse_tree_gently(tree, 1)) {
 		error("bad tree object %s", oid_to_hex(oid));
 		return -1;
 	}
 
 	strbuf_addstr(&path, base_path);
 	base_len = path.len;
 
-	parse_tree(tree);
 	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
 	while (tree_entry(&desc, &entry)) {
 		struct type_and_oid_list *list;
 		struct object *o;
 		/* Not actually true, but we will ignore submodules later. */
 		enum object_type type = S_ISDIR(entry.mode) ? OBJ_TREE : OBJ_BLOB;
 
 		/* Skip submodules. */
 		if (S_ISGITLINK(entry.mode))
 			continue;
 
 		/* If the caller doesn't want blobs, then don't bother. */
 		if (!ctx->info->blobs && type == OBJ_BLOB)
-- 
2.48.1.519.gaa5dee9535

