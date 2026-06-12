Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB80E35E1C3
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275205; cv=none; b=siWz8xaz0pfLGlxdkPD71S/eKstAX4T9oWISJTrlr/VuZ7n6KTJqJshcZF59PieYLkYi9uOfWGPSbvRM4Ztw6LrXesnFV0CIhM5TOnWfqFi9R+xBMy13Ik56ElNWZ9mph+vOfgJe3ksNETEIfWH0GMJ6ETZRpUm2azyN9jAgxGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275205; c=relaxed/simple;
	bh=s6dC/yr/9I8ks5QV/B74BPmU443s1vuQbBuw9jNq484=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s8bRqPRYYus1s4Fl7NfVKXGZ2FhCTiHPhnJJsEpxDgierbnG4RyS2UUCnkJhD4Ai4lTjJmq0xr2XguoWVtCEy25d11w9omEgapC0frT3p4rvKs5d2uzEYKHvK4RBXzKk51qFYqS5psYM1dHpKrSglmpNLygp82gXpMK0KbVWFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=onVx42O/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="onVx42O/"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so4968245e9.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781275201; x=1781880001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0dDS0l0quC5ijseWLY0crtKuJENuK3xaO3mifHz7+e0=;
        b=onVx42O/I1z5EG46xAwi4ZiAVlWHvh5P9wZeFDeRefu//9q9Yd7H+amS0rCOoMpuH/
         8edqbJQP8+vGXYsmNMI4A6pdXlLoRyiMjSPVlgV5BT5kqn0yI4xMo/ZATIMDhnJiAsOh
         AtKjy+ymWvrjm8zBLQkzMPTT/KoOTiY9/3amhippM4ZxYCqpN974gDXefh4vhI/n0nzm
         vKsfhtI7TNhm8OSsQM3KN1VZn29bxVx0bXodFrdSPl4nyxI68ZUmTRM4wzR03yKylUNU
         fgQVcvdYnUSoubkPC1FWg9hCrgZ6M0cQSCZn9/Rw1CvPB4HuIi+0o+grRvGFzBBi1Nb2
         nJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275201; x=1781880001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dDS0l0quC5ijseWLY0crtKuJENuK3xaO3mifHz7+e0=;
        b=pYHCcgFkrW4uB+8PpCgCT9j5QAs1oCRJzh84PT9t6OKC8uRxZGbHpEb7YyiEh3hhju
         RSKk/XioRcwV+4an+He0F0UYaY4nze2E1VB2tHa9iGhk+MVz1ieNBDO538AigoMqbMom
         6uEVn5LzKQz3e8u+iZ8WIZRqCVGVXCCwn6/ClfWB3YSyYz/j+LXaqzSWcExAK7flLuXm
         ZeYaj6Klf7MSuRF1SIRs6Y9sSTt+ENtPkBUGNHgYjsQCahHj+KWjeiOWwXKIj5c3+Qae
         N+Rzv9gUMMZ6SXArBEA7wXHt1wcitgVZR8uc7d17XUBR19r5NHl6BnHnk5Fwxk0HlY8E
         U0wA==
X-Gm-Message-State: AOJu0Yx9/xdFaFi4x4390/YCTD/fSY/FgTIng1VYefLNrm0DmA6sZce9
	LaHuAhkCtHqIxbodU/RRSxnKwgt1J3j7Ko7DHHuEpdJsLP54t+lywtEfS2O1sex7GeflNUz+MaR
	niba1
X-Gm-Gg: Acq92OF5vEC75CXlpvkOaK7hFyeumHEUan81m9D6wJYzk+9zJPE47YRG1T5yrC/+ZP/
	jyykwVNUTRez+gm1JWCPpRp+dxzt7yAdVfNFX6E6bftIzIG1+tuMVQO0LmsNw/5aUzE8jTLZmBH
	Z/8VkNQjUxPyeSxG/afvBiVqR46WM42PJG4mAKUzRfgFfFCR9vBuUyl3FYaKb4lVD8od9kws3KW
	wYY4SQ5taKG1tjwUHfgHJaDEcIwDv4mq5vtH+5jWUv3tQJCV8DRY5ui2r+Y8cRQCSErJqxD4sB3
	wq6OsIN4xEYFCGeyUVhTkTD+iV/ehATXoxgilln0hDQClIKZ6/ROrKRcTEoTVXpii6is4miD4sC
	oF74smxaaTpMKC5OddEeLuZdhqoom0XDMQGOWQ8G8TzR4WV7dD9tqZQoIHcPMQDKS6MRIUd+Gx1
	Mnx1YPUdhJ9GbRUqKYMwez+5LNx5Z+hjbRk5fXb/qF62J7yG82rn7gZ+J0T+y0Eka1SutZ4E56N
	0DimEM0kKPmNs+w3HBsgup8ng==
X-Received: by 2002:a05:600c:314a:b0:490:bcc1:4edb with SMTP id 5b1f17b1804b1-490ec504eb5mr37776485e9.27.1781275201042;
        Fri, 12 Jun 2026 07:40:01 -0700 (PDT)
Received: from localhost (p200300f65f47db04dede74d38750489c.dip0.t-ipconnect.de. [2003:f6:5f47:db04:dede:74d3:8750:489c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490e2c7ea21sm161208015e9.1.2026.06.12.07.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:40:00 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: git@vger.kernel.org
Subject: [PATCH] Add a test about broken notes handling on rebase
Date: Fri, 12 Jun 2026 16:39:53 +0200
Message-ID: <20260612143952.3281115-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2624; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=s6dC/yr/9I8ks5QV/B74BPmU443s1vuQbBuw9jNq484=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqLBo4rlJprKEe4qtuKRldyEKGanhEYhOrOeB82 gkrT5ooxDOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaiwaOAAKCRCPgPtYfRL+ TuMpCACWHgyBXWSJpaCSJUnF3UyXZaKaGy8jWugMC2b3HO3dBlgte61Hu3T0KmW5w6L67Oia7f8 p3UP9u+pY1qcQoQshzgDsL2BLEe5aWU/sY4X/GtidVBt5pIQop2vinUujqI3Z7AlxG8PTdth/Oo gSNK3yEW+UpSmV9HGAhKvMBFztHPhWr8xc8XE0FsT+9zoviYzdekdVs5LEbK8iKokvm/MdgBjJ7 capcxiCMWr6KwSPIZ3mMsj/kQE6fVeFCUcS5wue2Sr7nk1WZo7yJVNX20A/2PonT3yOLGe37x52 vD2wjqmYAza5TX4kuKlByyljJawA49eE0KtJ7kHtqyN5JAfN
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When a commit disappears during rebase because the patch content is
already there (but not by the same patch in which case the commit would
be skipped) the notes of that disappearing commit still survives and is
added to the (rebased) parent of the disappearing commit.

So with the commit graph

 A -- B -- C
  `
   `-BD

where BD includes the changes done in B, when rebasing C on top of BD,
the note for B should disappear and not be added to BD.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

this is a behaviour of git that really bothers me when working on big
patch series. I use notes to track the Message-Id of the patches when I
send them out. Then when rebasing to a newer upstream version, the
tracking gets confused because the Message-Id notes end up on commits
that were not sent out yet (or I got two Message-Ids in them).

I reported that already back in 2023[1], but obviously not in a way that
resulted in a fix. So I'm trying again with a patch that adds a failing
test.

Best regards
Uwe

[1] https://lore.kernel.org/git/20230530092155.3zbb5uxa7eisdzxb@pengutronix.de/

 t/meson.build           |  1 +
 t/t3322-notes-rebase.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 t/t3322-notes-rebase.sh

diff --git a/t/meson.build b/t/meson.build
index c5832fee0535..6927bd9c794f 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -358,6 +358,7 @@ integration_tests = [
   't3311-notes-merge-fanout.sh',
   't3320-notes-merge-worktrees.sh',
   't3321-notes-stripspace.sh',
+  't3322-notes-rebase.sh',
   't3400-rebase.sh',
   't3401-rebase-and-am-rename.sh',
   't3402-rebase-merge.sh',
diff --git a/t/t3322-notes-rebase.sh b/t/t3322-notes-rebase.sh
new file mode 100644
index 000000000000..64c40a523b50
--- /dev/null
+++ b/t/t3322-notes-rebase.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description='Test notes on rebase'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	git init &&
+	echo A > A &&
+	git add A &&
+	git commit -m A &&
+	git branch branch &&
+	echo B > B &&
+	git add B &&
+	git commit -m B &&
+	git notes add -m "This is B" @ &&
+	echo C > C &&
+	git add C &&
+	git commit -m C &&
+	git checkout branch &&
+	echo B > B &&
+	echo D > D &&
+	git add B D &&
+	git commit -m BD
+'
+
+test_expect_success 'rebase B + C on top of BD' '
+	git rebase @ master
+'
+
+test_expect_failure 'assert there is no note on BD' '
+	git notes show branch
+'
+
+test_done

base-commit: 3e65291872de10c3f0bf05ea8c24187e7a71ebf0
-- 
2.47.3

