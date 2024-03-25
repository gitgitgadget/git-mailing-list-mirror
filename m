Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2F683CD9
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409162; cv=none; b=EGDW29rsU+7bOaE4vW9iXFflNFZqQ9xXmCTEx1xqc3zZOnbfgh4j03cobKV7dDKXdtv/AxJi9x8ColabBJHjAleiN1Oye79ODRTurL4qLTWQC9iHmIjTcHTBqryp9AKfv3tVh1X1a2SoweEYR8xRHZs/HBTUKxYx0nI9RLyzM7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409162; c=relaxed/simple;
	bh=KcrM4kJudctfiS1tprgGHSuztrZYBZcF9MB97+BAA/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEZwQHJH3X8VdqfjfahUfqLYQl1Uq/rS9PIvQJcS6x0dUVHHSB/wp+hIgpwVsGY0ak/zGkZv8Oi5WTdGmgcAKvLX4ynr1HTsNsZqgQUnExaPjg8klaQ92iApgzSVq6i8GAgiLjrkMlTv8lJ3b2nzhF25JCluXTTiMucNKLGtXD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPdgGCLP; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPdgGCLP"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-221e1910c3bso2490557fac.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711409159; x=1712013959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAPZzTwBueJYzUhj4GNpW++75DXiSEqummJ0WACiLWk=;
        b=TPdgGCLPKHgK5pve0b2LXxFJyzbHWjQw0jaG9uIBPRBm0s/oX4XtFeUC7SkSsM+dat
         0wR25KwEun6bhAPHdLs7D5GlXUQmdDAg+JFVP/zoqT1I0uSATby+BXKTLcX1Rd2Q3A+e
         Y2z/+2uTo8WOauHGMlBxiWEIsMzp9HA7AXObqOHAVXx7GIRe1pomGtoistRS41FvKpB9
         XzMaMO9Sc+ES4U9xUti/z2oRycdhAz0QMOGgw+poGsOZR2y3qN0pcX9MwhYAvpU2+hJH
         6zyot4TCmdZNvCNegx3jwurQI5ZNrlhgYNdvIo6biMFktB2y1mfGr5ItXN/tD16j9Sxh
         FbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711409159; x=1712013959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAPZzTwBueJYzUhj4GNpW++75DXiSEqummJ0WACiLWk=;
        b=Sph8G75yEp460F5s49r2k3dPbEiobmVlNLnybG21AvBlbsxzuQUD4fBH0nYCaxQkgU
         G90hB68efz4USP5HgJK3F/vGa/sJUe6sB9Ym953RuSLnoUtI9Hp36gqEUI7o+zbWx1gS
         6VeZ0lKEckt1tkhit9562aG02pdj+46youqMSYJvNUxGjzh+w3KX7TMg1aS+WV4rFLTc
         cX12hgZ8hzDEuNz9ebzg6dcPf3I/5dI9Iq6obFxhJpXg4ogqKSXvEAoIl085bOv0DKgB
         KzhcSJphZOW88OYJuHGwuNJrRA2TsSre2u+9vtj9jtXvZUEbL6o5JBdQLwZMj8ApfHRP
         fTBA==
X-Gm-Message-State: AOJu0YzxUUlJHAWjsY7VT+Wtk7g4ux4qw5i+9j7GNl/MTHzT4dlTKPJu
	p0uDy87i6WVz9VIWkaQosMFV5pdgOwEVdo1J6jI+FJ+i6kwfWlTNxy0eN98aTWE=
X-Google-Smtp-Source: AGHT+IGqudqL5/Px1LM6/ZetbvMJdCHRnXV64G1i2jjsOakij5OVY2kbL3WLCeurtSJT94TYKgkTdg==
X-Received: by 2002:a05:6870:210b:b0:221:ca43:7655 with SMTP id f11-20020a056870210b00b00221ca437655mr9711790oae.19.1711409159371;
        Mon, 25 Mar 2024 16:25:59 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id vp8-20020a056871a00800b0022a1d794bb8sm1454868oab.22.2024.03.25.16.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:25:59 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v5 5/7] sequencer: do not require `allow_empty` for redundant commit options
Date: Mon, 25 Mar 2024 18:16:52 -0500
Message-ID: <20240325232451.963946-6-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
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
index e3f0a52f72..04ee94bd81 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1732,34 +1732,25 @@ static int allow_empty(struct repository *r,
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
2.43.2

