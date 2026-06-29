Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6298E40960F
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739168; cv=none; b=PrDAYiFQedqd7tteH4Cc41uZ2GbrVW9NVd0amhY7y2O/cijrdKDpZ9zRs/WK0L2+G55yTeujLld+6BomKp7qnzuGkN/yue+GlL2tTkGZ2/7Dg50ESzICGOR1jSza7gaW2XXG8QEEwhXUGLcuJeog04kgttJ7eyo1qU8nbgJ+5kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739168; c=relaxed/simple;
	bh=HG5/I9EfOZt2XSK+rLk3okdSWzYGjAmrIY8OUjJPwsQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SBAnejV+nKnMyFBVsR3scN8QsNXSyiAG3kLjMe86abC010HB97mzCVEPlVWwpjZAPVd2zWoeRKCge3veFTDZffs+WZZVHDCBHOx00FvVppXQXRI3Yc71ejI5NOoyg481b0U8ht0FHkdNrBMRhnm5CDu1yH41omphBH016kUqVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bs+ObRs0; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs+ObRs0"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8f0079614b2so16142276d6.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 06:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782739166; x=1783343966; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bV7MOyO1gmM3iCSxZrFJ91IRVa5aCJaTXod9YpC0NPg=;
        b=Bs+ObRs0MnTRX9jTaCvUyB+1NUHx12Fp4vzeCpgJesfVmAxwrh4tuKt1WrGM94LqlN
         9edGLI0niydXRqpjGkmrdrLIriov6nDVMLrCnyzC9bx+CBU9yiOcN+M+MUwTxXat2MiW
         ZI/Z6gWWy9FLWHZoSh7IbBmSqmm4D3xQNyDbspvYTTlh9D9O4RTZWAC87Jp9ATb/dK8v
         umxy6cJ0s48m5f1sSzTTNqHDwJimOcfr2DLK6PnH+Yli991k+cY/O1VmpyhJRlerZ5iJ
         uUv4NlomT1oVJ26jbyObW8OW23nhX8rV54+FKqvnZFQCxC0iEhGvcwt8mnJa6uZQdUbJ
         zwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782739166; x=1783343966;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bV7MOyO1gmM3iCSxZrFJ91IRVa5aCJaTXod9YpC0NPg=;
        b=BWU1mpC61IDzgad959MFB90xKi4nPJtEpyvTQlih9S3+lB0AInhYcYg20zTY/a9JND
         S6UqOnFiOESk9Z7l+M78rpGhez/oWEj2Xq9eIcMMW65/SiGEw6T5+Z9nJEfG5RSXANbV
         /9NtnCUA3T2QWDuGqXai4OIr2awZVaYdIeTcREtDgjFZsW5RytvO8piceX6TOIldln97
         XnsmZN13CSvDy15EFDuSxn1GWqGGswAqriH0EYIwdMcwlVjyCrWQyOmPEBkXfFrs0xFk
         OP+BjDm67Jv8bAyr6TBDKiG1OytSdPy6gQGkReShxU81GTjiPAprS66IFoqwuASD9X3l
         1oeQ==
X-Gm-Message-State: AOJu0YzzeYiGwjm43N+5jTFIlL3LQo6aYKCr0F2cPujhFhBZJPPkV9jQ
	UJbdK6xDX1hzsOcf6wuvE6XoC2YgSnB30RNeVjjSCcHqSwQfrILvlH1EVsg6LCCf
X-Gm-Gg: AfdE7clJimL4yjg5GXRaqwq5GuK5Zpi2bJMp+HABUQsmMQnIirIcV4U2csreIiZQ55w
	2mIHSSPYeH7GEUDKTNxHxjVQCaIh2rlbjgOo3BzBbyQIsOUrEX8wm36tcorkmpFkVr3Uf+Y5nRw
	YyLFbmemNkBO9yDz80oEBhGZ0CxeFO6QgVLh4djTzkuibowJ+5sqbxTdDuX2njEij0VNo37sSHd
	eHpCt0Tp09Qz7kFkX5MyT9zaRiAXq0HHmKRiQpOYTQmtPjxC3f0OCQ0Q0VCRPR9Z3aDw6UEs7Kt
	Pjv0jPgZ6JiUD7kR93AhWvG84cvn0Mzm47pVqi4hGonA+ct7ezChLYX6uM1nts1wwNQ4L0mYF+g
	XYmM5QhTvjFEsXL9iyWrYhTzvTeBa7ZhLK1Ol+LatGrCTVPGtRQTI2EG+M5fhrKcoZyHQ1YBdnd
	TUFEQ08xzVXli1gTWnXD7Q7c+MFg==
X-Received: by 2002:ad4:5fc5:0:b0:8ef:5122:db84 with SMTP id 6a1803df08f44-8ef5122dd8dmr70483906d6.15.1782739166113;
        Mon, 29 Jun 2026 06:19:26 -0700 (PDT)
Received: from [127.0.0.1] ([20.119.102.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81fcb55csm306008596d6.34.2026.06.29.06.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 06:19:25 -0700 (PDT)
Message-Id: <ba3f2bb6e8463eb2f101ebf5c7d8d83d353731a2.1782739162.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2162.git.1782739162.gitgitgadget@gmail.com>
References: <pull.2162.git.1782739162.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Jun 2026 13:19:21 +0000
Subject: [PATCH 2/2] commit-reach: guard !FIND_ALL early exit with generation
 ordering check
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Derrick Stolee <stolee@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

When paint_down_to_common() falls back to commit-date ordering (for
v1 commit graphs without corrected commit dates), the !FIND_ALL early
exit incorrectly fires.  The exit assumes the queue is generation-
ordered, so the first RESULT commit found must be the shallowest.
With date ordering this is not guaranteed: a closer merge base with
a lower committer date (clock skew) may still be in the queue behind
deeper commits.

Add a gen_ordered flag that is cleared when the date fallback fires,
and require it for the early exit.

Update the test from the previous commit to test_expect_success.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c        | 10 +++++++---
 t/t6600-test-reach.sh |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 5df471a313..708798a39b 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -108,11 +108,14 @@ static int paint_down_to_common(struct repository *r,
 		{ compare_commits_by_gen_then_commit_date }
 	};
 	int i;
+	int gen_ordered = 1;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
-	if (!min_generation && !corrected_commit_dates_enabled(r))
+	if (!min_generation && !corrected_commit_dates_enabled(r)) {
 		queue.pq.compare = compare_commits_by_commit_date;
+		gen_ordered = 0;
+	}
 
 	one->object.flags |= PARENT1;
 	if (!n) {
@@ -147,11 +150,12 @@ static int paint_down_to_common(struct repository *r,
 				commit->object.flags |= RESULT;
 				tail = commit_list_append(commit, tail);
 				/*
-				 * The queue is generation-ordered; no
-				 * remaining common ancestor can be a
+				 * When the queue is generation-ordered,
+				 * no remaining common ancestor can be a
 				 * descendant of this one.
 				 */
 				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
+				    gen_ordered &&
 				    generation < GENERATION_NUMBER_INFINITY)
 					break;
 			}
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 1090104220..0ff41381ff 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -1003,7 +1003,7 @@ test_expect_success 'merge-base without --all is one of --all results' '
 	grep -F -f single all
 '
 
-test_expect_failure 'merge-base without --all, clock skew, v1 commit-graph' '
+test_expect_success 'merge-base without --all, clock skew, v1 commit-graph' '
 	git rev-parse skew-M2 >expect &&
 	merge_base_all_modes skew-P1 skew-P2
 '
-- 
gitgitgadget
