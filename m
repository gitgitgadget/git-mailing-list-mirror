Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3752415531A
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760951; cv=none; b=F1XdL/v8UwgRacuvaz25ma1IRdGIerWZ+ZPGDMcaNQQ+ESeL4M+Q2qpmey5hqg81V8dyHnW3i8yiWqLGrSe9ys2Awr/9cIaYT4T118XL7mAfnDxUjfh8UTGo6wQG2EWx+lxM3x18t1qXNkxMRhnJc51WnxvKV3sk24U0LoirZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760951; c=relaxed/simple;
	bh=9Puj252JCV+0q7nJxCgFKrPXVpStAKFjh04Ubmwpwfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZvV/3Gg8Q1ZmxGhH3qW4dzlk76iiFc1pZQvFQN88l2iD+Ysh8iZ1MKVCoSJyXHuky1ugENQWN71UHfZ0ShCmX59jrzIn/XY73zxeNjCFQKgO9zyioFyNYFkjBs+Eb/7ZCaPEnoNW3JuHatx21qCz3GxCV3PihJARJmLEUKQgC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tEfMkE/w; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tEfMkE/w"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dfef5980a69so1402644276.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723760949; x=1724365749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+PkomJj2aPqY5XbmAPT9lA21lSx7aPQei2ZpLNKbdI0=;
        b=tEfMkE/wNqSz1dMlTczKg5QseNyGM198cX8ty3/0L3pCg6D9Retc9DEC9bUFPjO3gV
         TSqnKoio+akgBcqHm5xFwWI5KufF6OQm4yUZ4eX0u1d2Vn3j1uTp8rk+yOXpynn9UjoM
         0w8Ukp9590//ghSPS6wsjU8tDVxMNChrNeoQtpOYuP6vIe6JQvtzmjuDgRIAvjCr7CW4
         5KcIreHMutVW1JnSYDqjal7k03sx2Jo7jOJGflpZFURq235HBgJK5NA9MiYets2nzLhy
         EVEKMWk+QkOBt8cWkF+O/5BbP8wX6lQUDOHN7rghJ9YqSPp6ViWVQ0lw4kN76B01iuUj
         ci5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760949; x=1724365749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PkomJj2aPqY5XbmAPT9lA21lSx7aPQei2ZpLNKbdI0=;
        b=Qd4dHYUPh5QSFh0PmQ5J0xYGgD87uz4vrNYjUruUf4r5oxscTtqJwkIxJTmrZy7Mf0
         fXoD5NzBkDTmce46SivMr6NMAQq9l9iRxym9IrlypAkef/+Y2whyfyLR+Hok9HTVUdc6
         Tr7x9CsXAOnRQbNXPH/79a0Ql9bjnFfmqbiYBH1bk3P7W6EVZ4FKA3FZuWGVnb3zBcAH
         QBrDkIIXJBrJyVbaA7o5WK8lBhYDWNcA3JCtMZLuMTFxGsYfOZYJlAHWavbxAbQw2FL5
         Se32pxQM69xsDqKrB4avUvJk5aF0J5icqEbhJFg9oE+QLyJVkfzhzT7Z8Ow12+kMG9+0
         Uwdw==
X-Gm-Message-State: AOJu0YzrNnzNSXK7SPJFZoDjPzxWP/ZdJ84S0p66aV00jTGfcuh9kIVB
	9oCEqx9TBC6UvfX2TAcnLl0lgvyTIInRYQQoHqvQge8/X7eXULgt8uPM/iNjkT+lrgsn9ChuKcj
	U
X-Google-Smtp-Source: AGHT+IHrUAj2tv2y7Nnm2TaLM3cicn3uqMR9GDDB3yoX87wSH90nDYPwQ3FSeRLk1WBGjtn9zWQHUw==
X-Received: by 2002:a05:6902:2b91:b0:e11:5a47:eb9d with SMTP id 3f1490d57ef6-e1180e96b10mr1524200276.6.1723760948762;
        Thu, 15 Aug 2024 15:29:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1171e3ddc1sm498664276.21.2024.08.15.15.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:29:08 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:29:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/13] pack-bitmap.c: support bitmap pack-reuse with
 incremental MIDXs
Message-ID: <9716d022e0b7a6992dd4630f9719079652b7de35.1723760847.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1723760847.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723760847.git.me@ttaylorr.com>

In a similar fashion as previous commits in the first phase of
incremental MIDXs, enumerate not just the packs in the current
incremental MIDX layer, but previous ones as well.

Likewise, in reuse_partial_packfile_from_bitmap(), when reusing only a
single pack from a MIDX, use the oldest layer's preferred pack as it is
likely to contain the most amount of reusable sections.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index f91ab1b572..2b3c53d882 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2320,7 +2320,8 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		multi_pack_reuse = 0;
 
 	if (multi_pack_reuse) {
-		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
+		struct multi_pack_index *m = bitmap_git->midx;
+		for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
 			struct bitmapped_pack pack;
 			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
 				warning(_("unable to load pack: '%s', disabling pack-reuse"),
@@ -2344,14 +2345,18 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		uint32_t pack_int_id;
 
 		if (bitmap_is_midx(bitmap_git)) {
+			struct multi_pack_index *m = bitmap_git->midx;
 			uint32_t preferred_pack_pos;
 
-			if (midx_preferred_pack(bitmap_git->midx, &preferred_pack_pos) < 0) {
+			while (m->base_midx)
+				m = m->base_midx;
+
+			if (midx_preferred_pack(m, &preferred_pack_pos) < 0) {
 				warning(_("unable to compute preferred pack, disabling pack-reuse"));
 				return;
 			}
 
-			pack = bitmap_git->midx->packs[preferred_pack_pos];
+			pack = nth_midxed_pack(m, preferred_pack_pos);
 			pack_int_id = preferred_pack_pos;
 		} else {
 			pack = bitmap_git->pack;
-- 
2.46.0.86.ge766d390f0.dirty

