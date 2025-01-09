Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1AE21504D
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412172; cv=none; b=b8DRVydoPVRjdtP8pvJCziVekrUZ8w5tnrEO+SzGsy09bKvu6OfBf9KUoHa6CwAV9jRR2HC7gfR34zKeiEn2J3AQLNYA4EyIq3uHDKwWzLSxBDq4uaMU5Nvv1tKMcHOa329fHUhYNbIArqz297FFti0nJhTPOkk5OyVNmaNLmWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412172; c=relaxed/simple;
	bh=gFvL8BljVac3ilqMROs6Y0Fh9+0/DlQHjo3x0wR8BoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/JHIfHGh20NY4npEJYe+Ancj8liTcZEVMQyJB2CL9+u2sc4zs2PEuJxZ7EYup7MSGwY+YhIPsuQRyQtvTlEB22UgyRpF5+jLBXVgSESNfFdfk8fjvO7saVW2XjqF9Lk7F+yBkOFGTTyoj6JUqkczNIutDJM9VJOr8s3Ofo7juE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AdYOmrrI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AdYOmrrI"
Received: (qmail 25665 invoked by uid 109); 9 Jan 2025 08:42:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gFvL8BljVac3ilqMROs6Y0Fh9+0/DlQHjo3x0wR8BoQ=; b=AdYOmrrI+wtoLEep+PmwguKNg50TEbd1bpNWNEB9NgF6GqIL9FUks8fLTo6OwCFphL1G9KIkEdd7yknn9fu95DdpVr7cnG1+tIXzzoGDFFQN/b3D093fp8N+p0QWuaW0QwM7POvM8WFl//TA1Ynt1DTIqEwrr7mEyDiwMFIQn3QdOICQ/uurYN6CqgRG91470NTsWarXsmt1GKETN3qtFzV2mu3vL3++G9v3HGDDF/eYVmunoSei6Erj8DCMhbePFB8JRrpG5pfbDEOg+FLBVCh80oSvMNxvqBPG6pMs23Gu+22GNAYDFK0Gt4fMnxZI6oqbOHFF2hxpCCMCXryBFg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 08:42:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20293 invoked by uid 111); 9 Jan 2025 08:42:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 03:42:49 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 03:42:48 -0500
From: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Wink Saville <wink@saville.com>
Subject: [PATCH 05/14] diff: add a comment about combine_diff_path.parent.path
Message-ID: <20250109084248.GE2748836@coredump.intra.peff.net>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109082723.GA2748497@coredump.intra.peff.net>

We only fill in the per-parent "path" field when it differs from what's
in combine_diff_path.path (and even then only when the option is
appropriate). Let's document that.

Suggested-by: Wink Saville <wink@saville.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 diff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/diff.h b/diff.h
index f5f6ea00fb..60e7db4ad6 100644
--- a/diff.h
+++ b/diff.h
@@ -480,6 +480,12 @@ struct combine_diff_path {
 		char status;
 		unsigned int mode;
 		struct object_id oid;
+		/*
+		 * This per-parent path is filled only when doing a combined
+		 * diff with revs.combined_all_paths set, and only if the path
+		 * differs from the post-image (e.g., a rename or copy).
+		 * Otherwise it is left NULL.
+		 */
 		char *path;
 	} parent[FLEX_ARRAY];
 };
-- 
2.48.0.rc2.413.gc1c80375a3

