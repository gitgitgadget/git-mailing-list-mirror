Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C92400DFD
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207162; cv=none; b=p/MzLWxjIko9Jjwpupjzvuqixrzp7mPIECqMQLaruoLFJFZzerrsdByRTBcayX8qFZAiEp3YI/85Uld3m1d7itUH9kv6hN2PeZtzL8IvLo3CcC1a5DyOixOS0TcMZ+y3FPNsI8eAMH5Z58Xl3+jr3CsKGltniBcnlhD2KQ5AM5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207162; c=relaxed/simple;
	bh=5sldudZK+YjHUNJMcW4J33+/E6vcl0u7TdJtGIbufH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKTQ6/+cKRLQaPTtb5hNbaJMvjjjY/7EaQgk6kvPqJZTalMMw5HcrPJ2LgNcO6NridxJhifcIGaatJb4eAcV9E55qWlSvypToiTvk4cG7qskAX0/ZItd90FnplclaZ5AhSgtY9Kdm2fKzDb0mLEqVIIo4Eot2V1kZ/hfC7Ok2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=K2wi298T; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="K2wi298T"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bdaa68cf81so32245517b3.3
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779207160; x=1779811960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEXoeUAi5wCHwxB1EuHkZebQRaNFAbPnU0GCNGFzXqg=;
        b=K2wi298T5sWYxyWScDLlKfh29CXG8FP7ozF+YjxqPqlAdmPFoAnsuanVN5dyCenzjV
         yO1KbCvbMUCm86LD73CMg5/9aka4fVu69hV5c+CDpNp8xHgMr3yO+JgGYKeWz45UBxE1
         0gnfN7it7HgJGr5/k+8dTQ8kRJ1Sisb/NdrYLG6BpeBiUgvHh6i/QqC18cK9LbSOigtB
         KUQPXiz0TJKg6YlQNpVqPhTq4QaYp5M62F27kFXRJeR6QZ77ZZVIKQAIHTf/wlRtN9y3
         zQyHDLVwWkCHkgkftks5//zUg5zFASi0ZputzytA2aCfMJIeshSNHVquyJysOci7Fz4g
         KkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207160; x=1779811960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEXoeUAi5wCHwxB1EuHkZebQRaNFAbPnU0GCNGFzXqg=;
        b=Xr8q9RwyG0G0A5NRxLUZSS8Tdkhnktgd860czEaRMKTaE9Wx3Rjb+ZBDG15aXgIoqf
         8znTnPZqgUAk0a6oAWloft+LcZiqq1i/GRaqQYMTekzTWjCDrn+p6Y/RnoNIzf5/70Cs
         Q+pknQWlkWb0v3whmGFSql2Crcldj2fWl6R7moCtAkrofSx8PUDfhlBc374+kxszpJiK
         tqv96akRKgIe5t1z475eEBiR5PYxkakgk04Rgmjc7ec85j72aVEGDiyrnWMYJZI9h+GQ
         X173eZbaKBFM0FsYFftAxQ/zRRHRv0FQqtEkuueRb9uFlYmFlAsgeX31Bo4ruKyX4LgU
         lcSQ==
X-Gm-Message-State: AOJu0YwYw74vnGVxOxcLZ1slrOeTAJ1qUg+a0odW4u6NuhKMJZKkZoRZ
	O7hCyuxu/sfwx6lZO2Oki9I5vfizAaF68iVuBTD2ex7sHF5w5ulbYT6nEHUK/YdN6q6gnWzXbB2
	zHS5lPdhPEg==
X-Gm-Gg: Acq92OHL6toPW2Li6rt8ma9lbdp5yCufHsJO6NP4XUb/5bsx5S6WkHiNswAHcXm6abK
	tIbC+kz0rDopJDNpJMi9u17cO5T3kk+hQOClEemx84ca47TPJPFVx+MyErLln4eu6XbShtqVXZt
	tfO9kP9jeCjkK2o5gZDUa5RNyPje+c/o9W/ieZmDWWq+Rd+wFlzlQB46RimAFiZ+VUH/F1nfV5z
	PqRKcUWil7QKupcaUkAyuFERdof7wb/1lgvfJlkl/mP0o7eXCaLh421f4nTMkC8I5AsOP075gXx
	a+vjG+s10/txKqKdyf+LLxDCHSPfQSgX3G0C3olCJInOnJRbgQZZtXaZ1quNaRNPIqazMBHLkbH
	/gpYT2/vk20jLQCqWPVqYL/RzhmS0lpYvSYvPKzH8a6NUgO2amKnJSP7WTNPJxZYEBZhd+w90DT
	NB0ByPJI8/4hxXVe+HBOkksALjt400WFDd2GaLXjZ0QeXdnJrgcdLbWR75Qy+rHw3vxlhdaXzTc
	HagXKCLBCOMpZg8qMQY98h4CnEC/PF+Wr/Do5r7Lm39UyZP5fawGzdRb6HgIPXSuh6yv296WFfT
	w2pC6cus0u8lV9Xv
X-Received: by 2002:a05:690c:7681:b0:7bd:4792:66ef with SMTP id 00721157ae682-7c95c2f7dcbmr178216747b3.42.1779207160287;
        Tue, 19 May 2026 09:12:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9c6ce14dsm38709217b3.37.2026.05.19.09.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:12:39 -0700 (PDT)
Date: Tue, 19 May 2026 12:12:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 2/8] pack-bitmap: check subtree bits before recursing
Message-ID: <7d6d1cec0dd2706ba176c7fa070da46c98155018.1779207127.git.me@ttaylorr.com>
References: <cover.1779207127.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779207127.git.me@ttaylorr.com>

In the previous commit, we adjusted the callers of `fill_bitmap_tree()`
to pass in the bit position of the tree they wish to fill.

This commit makes use of that information at the call site to avoid
setting up a stack frame for fill_bitmap_tree() entirely whenever a
tree's bit position is already set.

Since this is such a hot path, the avoided cost of setting up and
tearing down stack frames for each noop'd call to `fill_bitmap_tree()`
is significant:

    +--------------+-------------+-------------+-------------------+
    |              | HEAD^       | HEAD        | Delta             |
    +--------------+-------------+-------------+-------------------+
    | elapsed      |   582.4 s   |   562.8 s   |  -19.6 s  (-3.4%) |
    | cycles       | 2,713.3 B   | 2,621.3 B   |  -92.0 B  (-3.4%) |
    | instructions | 2,415.5 B   | 2,348.9 B   |  -66.6 B  (-2.8%) |
    | CPI          |     1.123   |     1.116   |  -0.007   (-0.7%) |
    +--------------+-------------+-------------+-------------------+

In the same repository as in the previous commit, our timings dropped
from ~582.4 seconds down to ~562.77 seconds.

While the cycles-per-instruction ratio is basically unchanged, we
execute significantly fewer instructions, and correspondingly fewer
cycles.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 2d5ff8fd406..72610397020 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -463,12 +463,6 @@ static int fill_bitmap_tree(struct bitmap_writer *writer,
 	struct tree_desc desc;
 	struct name_entry entry;
 
-	/*
-	 * If our bit is already set, then there is nothing to do. Both this
-	 * tree and all of its children will be set.
-	 */
-	if (bitmap_get(bitmap, pos))
-		return 0;
 	bitmap_set(bitmap, pos);
 
 	if (repo_parse_tree(writer->repo, tree) < 0)
@@ -482,6 +476,15 @@ static int fill_bitmap_tree(struct bitmap_writer *writer,
 			pos = find_object_pos(writer, &entry.oid, &found);
 			if (!found)
 				return -1;
+			if (bitmap_get(bitmap, pos)) {
+				/*
+				 * If our bit is already set, then there
+				 * is nothing to do. Both this tree and
+				 * all of its children will be set.
+				 */
+				break;
+			}
+
 			if (fill_bitmap_tree(writer, bitmap,
 					     lookup_tree(writer->repo,
 							 &entry.oid), pos) < 0)
@@ -582,6 +585,14 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 		pos = find_object_pos(writer, &t->object.oid, &found);
 		if (!found)
 			return -1;
+		if (bitmap_get(ent->bitmap, pos)) {
+			/*
+			 * If our bit is already set, then there is
+			 * nothing to do. Both this tree and all of its
+			 * children will be set.
+			 */
+			continue;
+		}
 
 		if (fill_bitmap_tree(writer, ent->bitmap, t, pos) < 0)
 			return -1;
-- 
2.54.0.rc1.84.g30ce254312c

