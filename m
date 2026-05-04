Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9103E4C95
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914517; cv=none; b=s/6wUNeTFmYs5LTVUhxyfOz9gqKnK50/NjLCJ59YRtTll3ZASfYA1eAIuE5d/bWG+SxBDjfUW97belDnAa7UokR2CjFU+imomF+POvJcYcShYoUTnOorSP/jCdsPS/cIQO4XpHeLy3njZgeQkrSNHObypAbWNIWpoeADtIgEbJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914517; c=relaxed/simple;
	bh=Ch4ZBErVbusY8xMbrJ5XYeRQDTufxLWyl7o+Gu9/3+k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DoHeIxn8qCzyDlcrwt2GQWjNjwuypoROOlsJiv6HWj9ix+pkisYUyUG9rY9TMalu9QSqkC/Wnu/3oosOxuHIIWAnYEq63MQVHK7Gk6aMTB4zCz851WAvkjjrrzKuvwAkpnBYl432/pj3u1fe1hhF9ExNXZ9riMEVdwsEpV5gSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTtOnTxk; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTtOnTxk"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-62f4c4e6694so330450137.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777914515; x=1778519315; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhEmXpTPl9UV9prc2XZBCvUOi1tEp9rSq6HI2bWF4+U=;
        b=FTtOnTxk3Uj5Q/Z7VsG6es9dviyAr4BqAiFUOeeZ5uPhhHPT6ntKt7C9KtZM0iHV34
         NBX145UTZ5P2KzJjhfZ4aRC1bD1PatGJ+2uF5b49XJeW6CUYE9d+tQ4o7YB5gU/YTQip
         3lfUKO6Zdsg3+AX9hr3s04IDckwFw4f1nqqb0JqHT00B/dA8OpG+4vWCVUFx8nqa+wrQ
         eQOdxmo5yJwXoHqagS7uqf/mq3S4ejaCMvomv3dWO0ARyGsfj4PB6ehm9E7PWG9s9PaG
         1pFnztr2lw+6IApzC93rd2ZYIVD0C8wNT1g4dhprNH8LilS5f8SldR9fLDf6IvwxT9+5
         HrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777914515; x=1778519315;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uhEmXpTPl9UV9prc2XZBCvUOi1tEp9rSq6HI2bWF4+U=;
        b=aKsOW+myY+MaV9i/f94p8PkCUfz+p4rjaN0M8mTroq/qMsGmESqhIxxW8SwKbkjEbB
         +Ayth4tyT8J7v2wXfLViO+FM2VmJNFtJXrt5RTM8kD57i6P8uBgVVa7bzHogPKZ86YY/
         ek+JOwDNameA7o4iU5iDfkX1E/xjRC9mz+ECD6nLQKXrzthu+yBdz4uQ1L+ZxGoYaxu0
         U6RrQ9cdXUH3bqjyTofliiZaBH+KxLxAB7AeW+1fLhCsEimS4o+MCnkTMIuwYOqtt7Y/
         FvIjeGuSYp7QDP9zvUdjbblUUPGOySzjXwLq73OWDQ+Hnqk8YM+qmIy3L2+6hAsXyOaI
         IOSQ==
X-Gm-Message-State: AOJu0YxuoAI21KzYR9T0cRDPMfGchfB/12Jv3Jj+QFAMqpE3MLNvlvu2
	TAf2gS0ksl351ikkTYpBQEc8EZNTbgu9N/thGgx0fA0QzLrLZS1AbuC4nuJB8QY2
X-Gm-Gg: AeBDiesfOZvz+jBH/rwlGST5d5GG8CF9j1ab+lB8+YQw56HK4Ob95f86b6EdOVKoEcE
	WAl4ITizD0KHoreip0I0NsMeKcZOIXnZRwizw6LRkKHJ9hOlU7WAP7Pl7QZVo+YDZajaAxlxSSQ
	Y9SHhsy2/dlN7e85+69rwMW6w6pwQcY9v4YSrIbz9P3BWlc7ezyToNQDhAQli43gk+fzgHlx38s
	Cmwljf4Ntq+yHvZk+wRQcIN0WIfGogqo1tJ89CuNd+hNb6bj59H+M1wWRp1aqDwnYUfg9Po1wv4
	VKTo3cY6yZqVFZioYGb6IkE7fXwEjJqRGr9+ZNZuwk6iATIP1Udwu/FNc6Re8TaPX5VKl3FkvWg
	lA9TUop8Dd2QzmJxfGo3WL9dfS4+zbCRau7YoziCz90MS7kf/midf/D2Zlj2uMcuJP713ujMlgE
	ofTFTx4ek+ItHj3lhWryrJB7LJ41TOBqEXlYDn
X-Received: by 2002:a05:6102:80a5:b0:62f:3a60:1716 with SMTP id ada2fe7eead31-62f3a603fe6mr2711383137.6.1777914514619;
        Mon, 04 May 2026 10:08:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.231.101.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53ca982a1sm140268286d6.38.2026.05.04.10.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:08:33 -0700 (PDT)
Message-Id: <3274cba862ae42a6813710410274a692ec0f5d29.1777914508.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
	<pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 17:08:21 +0000
Subject: [PATCH v2 04/11] delta, packfile: use size_t for delta header sizes
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The delta header decoding functions return unsigned long, which
truncates on Windows for objects larger than 4GB. Introduce size_t
variants get_delta_hdr_size_sz() and get_size_from_delta_sz() that
preserve the full 64-bit size, and use them in packed_object_info()
where the size is needed for streaming decisions.

This was originally authored by LordKiRon <https://github.com/LordKiRon>,
who preferred not to reveal their real name and therefore agreed that I
take over authorship.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 delta.h    | 14 ++++++++++++--
 packfile.c | 33 ++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/delta.h b/delta.h
index 8a56ec0799..fad68cfc45 100644
--- a/delta.h
+++ b/delta.h
@@ -86,8 +86,11 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
  * This must be called twice on the delta data buffer, first to get the
  * expected source buffer size, and again to get the target buffer size.
  */
-static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
-					       const unsigned char *top)
+/*
+ * Size_t variant that doesn't truncate - use for >4GB objects on Windows.
+ */
+static inline size_t get_delta_hdr_size_sz(const unsigned char **datap,
+					   const unsigned char *top)
 {
 	const unsigned char *data = *datap;
 	size_t cmd, size = 0;
@@ -98,6 +101,13 @@ static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
 		i += 7;
 	} while (cmd & 0x80 && data < top);
 	*datap = data;
+	return size;
+}
+
+static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
+					       const unsigned char *top)
+{
+	size_t size = get_delta_hdr_size_sz(datap, top);
 	return cast_size_t_to_ulong(size);
 }
 
diff --git a/packfile.c b/packfile.c
index fdae91dd11..4208f53046 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1161,9 +1161,12 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 	return used;
 }
 
-unsigned long get_size_from_delta(struct packed_git *p,
-				  struct pack_window **w_curs,
-				  off_t curpos)
+/*
+ * Size_t variant for >4GB delta results on Windows.
+ */
+static size_t get_size_from_delta_sz(struct packed_git *p,
+				     struct pack_window **w_curs,
+				     off_t curpos)
 {
 	const unsigned char *data;
 	unsigned char delta_head[20], *in;
@@ -1210,10 +1213,18 @@ unsigned long get_size_from_delta(struct packed_git *p,
 	data = delta_head;
 
 	/* ignore base size */
-	get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
+	get_delta_hdr_size_sz(&data, delta_head+sizeof(delta_head));
 
 	/* Read the result size */
-	return get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
+	return get_delta_hdr_size_sz(&data, delta_head+sizeof(delta_head));
+}
+
+unsigned long get_size_from_delta(struct packed_git *p,
+				  struct pack_window **w_curs,
+				  off_t curpos)
+{
+	size_t size = get_size_from_delta_sz(p, w_curs, curpos);
+	return cast_size_t_to_ulong(size);
 }
 
 int unpack_object_header(struct packed_git *p,
@@ -1618,14 +1629,18 @@ static int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_off
 				ret = -1;
 				goto out;
 			}
-			*oi->sizep = get_size_from_delta(p, &w_curs, tmp_pos);
-			if (*oi->sizep == 0) {
+			/*
+			 * Use size_t variant to avoid die() on >4GB deltas.
+			 * oi->sizep is unsigned long, so truncation may occur,
+			 * but streaming code uses its own size_t tracking.
+			 */
+			size = get_size_from_delta_sz(p, &w_curs, tmp_pos);
+			if (size == 0) {
 				ret = -1;
 				goto out;
 			}
-		} else {
-			*oi->sizep = size;
 		}
+		*oi->sizep = (unsigned long)size;
 	}
 
 	if (oi->disk_sizep || (oi->mtimep && p->is_cruft)) {
-- 
gitgitgadget

