Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73FA3A1D8
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710096424; cv=none; b=HwYkNXnCYt69zjdMhx8RMAQ6YmRwe7r+XS04rEo6efUcfT78EL532KONrV1uqxz/m/jWjq0FiVBp7jELCiyFEJyuo+z+79TeD34E0/l+2RaBob8A/xZdK0yMRuFlsRVK7sgRqXPYTzSZ7KRl9xmAzvFzgMKAUkkx0tpnHkA/mvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710096424; c=relaxed/simple;
	bh=JSFJHgTKmfLQZaoxc5yPCru3x4J9zY312NMCxjjWUfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmbzoMqOq3iVgF4i6vinpj+lEl7zWB9rZqsJaUc0DXLEWkkZLbs3APU7q2xVz2YXRmGv3o4IGwRjlVql6YRTUA+4suKfp6NQ8IOJx0j9rnxa5dtrRrf2PMllG+joPl1UZ2qmiZF5HKkDgK/8kNoL3VCgT6S3ELhsDrN8HFhctmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNdaTLTo; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNdaTLTo"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6dc8b280155so2740301a34.0
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 11:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710096421; x=1710701221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNOUqu/cpZskM2xrPuxfX/dbhHGmKYMp44oiqsoxYRo=;
        b=KNdaTLTod6bCcdRHDbXJx26x9fo1JnamcM5YyA+bywENKvC8CDPzmlXuSidI8cd/ia
         Ngd55QZLyqa3NkDqrclHkW0CXwl13AgwU214JfiJ7L4UHV/S4DqCfOgZbk8GPgdsEYs4
         TbHtVolNSVxcNwZgiiHB/KR9jCPlUpJ0bAjvP0a2M9KZiO8XTNnT1n65P5cIlYSFQxYc
         Q59ohmsgWow68uf0jqMg2Ah64mwDR/7MuOQlbaOfaD2HjBOv01mPINf7efpl0gmyoPbr
         pTXNkpTv6WImeAqvJf01pJiH/1mYYF1P/fb8HCijcN/794rlAIHc+sNsG9oqFwCt1Qj5
         3sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710096421; x=1710701221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNOUqu/cpZskM2xrPuxfX/dbhHGmKYMp44oiqsoxYRo=;
        b=xBKVscuh+mHBXBw2/yytXpcIUEZV6nAq/pXzf0u57MnEUmB1JrvBPkgVMDjSQ6tgxH
         MPxay/Lo0GPFZqpXdh+4W4CPdEOIYHrZFszCtZ+/lsoSg6bgWJ7ACfWRo2FHqkoKSQl4
         UWozGdowuh/MRvhOgc4hHilT7xo8XIKyS7Np/NXyPjiyj+r/EENpvz0UkHPINL7tvhEU
         +YnORcte6we6xyGoHIOgYh9NGg1EXWZ9IIr/yOm2aqxonbmimX9HHthkvn9/2hghDAjI
         huHLT4brEekLZuwwmOmPBQjJoSoArQMuGVRactVTB+cGh6aMgBXIJUbba8VPogp2nGaU
         Kx0g==
X-Gm-Message-State: AOJu0YzJvROpim8rxcyRVB4/MVoeNF+0ujnnBtz2LR7pUMvg0PYkcTlH
	9nXL7Dlq/4gqLZA3FNvh3HN67GidWTYZmgq1dWJV0YMdJPkyil2hxhJ2SGb61kM=
X-Google-Smtp-Source: AGHT+IF/HJcgL205cUKgAM+h0wWasT8eFcqiHXRspKV/e2POEMYGTvE2ucMwoc81hJuyivixLO3EZg==
X-Received: by 2002:a9d:67c8:0:b0:6e5:2dc9:11e1 with SMTP id c8-20020a9d67c8000000b006e52dc911e1mr830676otn.6.1710096420915;
        Sun, 10 Mar 2024 11:47:00 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id l8-20020a0568302b0800b006e4c97ec1f4sm742131otv.69.2024.03.10.11.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:47:00 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v3 5/7] sequencer: do not require `allow_empty` for redundant commit options
Date: Sun, 10 Mar 2024 13:42:04 -0500
Message-ID: <20240310184602.539656-6-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A consumer of the sequencer that wishes to take advantage of either the
`keep_redundant_commits` or `drop_redundant_commits` feature must also
specify `allow_empty`. However, these refer to two distinct types of
empty commits:

- `allow_empty` refers specifically to commits which start empty
- `keep_redundant_commits` refers specifically to commits that do not
  start empty, but become empty due to the content already existing in
  the target history

Conceptually, there is no reason that the behavior for handling one of
these should be entangled with the other. It is particularly unintuitive
to require `allow_empty` in order for `drop_redundant_commits` to have
an effect: in order to prevent redundant commits automatically,
initially-empty commits would need to be kept automatically as well.

Instead, rewrite the `allow_empty()` logic to remove the over-arching
requirement that `allow_empty` be specified in order to reach any of the
keep/drop behaviors. Only if the commit was originally empty will
`allow_empty` have an effect.

Note that no behavioral changes should result from this commit -- it
merely sets the stage for future commits. In one such future commit, an
`--empty` option will be added to git-cherry-pick(1), meaning that
`drop_redundant_commits` will be used by that command.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 sequencer.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a62ce244c1..8dce175f2e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1726,34 +1726,25 @@ static int allow_empty(struct repository *r,
 	int index_unchanged, originally_empty;
 
 	/*
-	 * Four cases:
+	 * For a commit that is initially empty, allow_empty determines if it
+	 * should be kept or not
 	 *
-	 * (1) we do not allow empty at all and error out.
-	 *
-	 * (2) we allow ones that were initially empty, and
-	 *     just drop the ones that become empty
-	 *
-	 * (3) we allow ones that were initially empty, but
-	 *     halt for the ones that become empty;
-	 *
-	 * (4) we allow both.
+	 * For a commit that becomes empty, keep_redundant_commits and
+	 * drop_redundant_commits determine whether the commit should be kept or
+	 * dropped. If neither is specified, halt.
 	 */
-	if (!opts->allow_empty)
-		return 0; /* let "git commit" barf as necessary */
-
 	index_unchanged = is_index_unchanged(r);
 	if (index_unchanged < 0)
 		return index_unchanged;
 	if (!index_unchanged)
 		return 0; /* we do not have to say --allow-empty */
 
-	if (opts->keep_redundant_commits)
-		return 1;
-
 	originally_empty = is_original_commit_empty(commit);
 	if (originally_empty < 0)
 		return originally_empty;
 	if (originally_empty)
+		return opts->allow_empty;
+	else if (opts->keep_redundant_commits)
 		return 1;
 	else if (opts->drop_redundant_commits)
 		return 2;
-- 
2.43.0

