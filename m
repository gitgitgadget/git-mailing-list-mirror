Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C053BE162
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869515; cv=none; b=BU4PtKcK4a52hUGaanwORDREzn37PzoCRW3VwrgEaTUWYuXJENj+7RZw2vn9esyhpKF+1kyVw2gSFTShDZ3rPtRN3/Lm+6HO70+nLt6FWGCFDDjfYFIF1RpJ9nADGYXhb2Ybp5mhlxjWS4pxpkJu6wy6bWxMrojnDEjo3uk9kJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869515; c=relaxed/simple;
	bh=4us9NdqjXktdOB5DrQmEwBmTdu9gscP+FbcXRUyJPmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSflywOxuzssMihjcHX2B2kgeNHavUur3GXfncfG3NeNK/mpA6Exal05b+vZpRf++lsZMtCCF53Owkr4WBDo+bjJ5UstW7Iy2yHfqsA/VlX4MJpzOQxqnUKpn/sxiduUMedB7vWqkCqCobPrjSy3uFDsD255as2GUDol5R5cu6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sat6OoG4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sat6OoG4"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso37215045e9.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 04:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774869512; x=1775474312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAr76w/8nuY25D41bRliWjfASlIW5tpCyvgaWvZqilQ=;
        b=Sat6OoG43DKTtR0h2++bkP0XWyFhufgljr3/NeGedUv35I8GLbCKV1+1OITcYhVxqn
         WXOQyr3D5sSiUl/aHcs0r3HAIkR9R38fDTwc5IqH/W3aO578Cb8+yrcEuc8CA0z5tyIC
         wrIaXGERZBIigSXfEMxRq0ViOJJLy5An+zuOg0lBrYVW6agCKXijQG9Ox5LBnM71eNEH
         Ao27G+477fAVev4yDaAOXmPAx59eacPlHHjnhpDzqqYxzd4RNFTBGOmyO4SU6Zs6+P1w
         VFLaRxLXph/bL0WZKJlT/yN3f0rLOPP5oJUfuS/9RHquVrHH75gN+snGvmMrKmUJyxEX
         rvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774869512; x=1775474312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EAr76w/8nuY25D41bRliWjfASlIW5tpCyvgaWvZqilQ=;
        b=mm/FsB/OYHkTOwdnKbQrXbqCPipg+1UyctScf/bV4ha2cZny1f4bJZBwhDX9/5NWuI
         zxznV71Vdgqv/i1BGzsM0J9Wd7Ih5X+GtH/JpLbOcJyJ6SSYA8r7ETr6Cy4y1e4UEc6M
         bNa2w7jdAKtSMN3aGIgNv/YFjWU9yrFCHWP72/hc31/saO3/NhGMpEoBZQBInwd1tWxw
         H8gkkHHI/NzWASt2Clz7sdlEFkyyDSLNYIWBmrFTk+pm9WmhulCe3BkW1fvGZSVD/+/e
         i+HNTUXxgmdq6w6ARdlKmvpzLVTGm96Kl7nit/M/xW5w397+blfmF63Yu2lDmmqSwbCF
         q9GQ==
X-Gm-Message-State: AOJu0YyM+ylgZev3COSR5w0yWCYd2M/1M34Q6UJ8kpByI3NfpLloDhvQ
	GWDUYw08OOGNcX0sGnMjjpB1YWwVqdesqKx9io8a88fZ3A+CEeCoqAyMz9O1yqgF2mw=
X-Gm-Gg: ATEYQzyxCYH+ZklJ39mOyrTL+wcYq8uZPsfqEgiKTjTpn6xfm5a2OcvOSlms6GopZV6
	X4L44U8RsiPyJCBFeapI/5gTxGfqq7wSfrd5+n5t/wE3gn0eEuirM1YeD0jxfH+WMz543PTfCx7
	AtvsQLuBdO7QWxQEiucZdBOCmTlV0Y+CNy9UNSUqimbjhDD0YLaIqLzlicRQvN9d9berY+wRon0
	wd8SmoFph+pEIQwnz7aAaX3h79McmRpbKmbXdIUGgHvhXVX7nahoeophskshOLpxbIT+ygTbfF5
	oRVAQleN4fqXBocpWTw0MHb8b5i7P2LahvRYxn0KNxXQqZn/pGSpam8ipS+dINNNwGuR5DyPO0I
	ZoAi9ltVlr103Xhb0fLiOX/PLpyy7NhQOTQ4phr4DJG3bXj0j/GsWaU+wraG3bWqu4B4sGXYb7r
	ZwVFwM7wFesX4Ri86yfuKoJVZBddbTRF1un/5to3crrpHQczVe+kVWU9LCnBLJolgSW640wQBeN
	i5c66bRm269clvCF9YZMOCYzUmDaGEieYkLAJ4XGLpnDsCDO4hQcxWG+RQ=
X-Received: by 2002:a05:600c:8485:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-48727d73642mr224162225e9.8.1774869511777;
        Mon, 30 Mar 2026 04:18:31 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21eba4dsm19140821f8f.11.2026.03.30.04.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:18:31 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: me@runxiyu.org,
	gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com
Subject: [GSoC PATCH 1/3] t5516: test updateInstead with worktree and unborn bare HEAD
Date: Mon, 30 Mar 2026 13:18:20 +0200
Message-ID: <20260330111822.165188-2-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330111822.165188-1-pabloosabaterr@gmail.com>
References: <20260223141236.22476-1-me@runxiyu.org>
 <20260330111822.165188-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Runxi Yu <me@runxiyu.org>

This is a regression test which should presently fail, to demonstrate
the behavior I encountered that looks like a bug.

When a bare repository has a worktree checked out on a separate branch,
receive.denyCurrentBranch=updateInstead should allow a push to that
branch and update the linked worktree, as long as the linked worktree is
clean.

But, if the bare repository's own HEAD is repointed to an unborn branch,
the push is rejected with "Working directory has staged changes", even
though the linked worktree itself is clean.

This test is essentially a minimal working example of what I encountered
while actually using Git; it might not be the optimal way to demonstrate
the underlying bug. I suspect builtin/receive-pack.c is using the bare
repository's HEAD even when comparing it to the worktree's index.

Signed-off-by: Runxi Yu <me@runxiyu.org>
---
 t/t5516-fetch-push.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 29e2f17608..f44250c38f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1816,6 +1816,24 @@ test_expect_success 'denyCurrentBranch and bare repository worktrees' '
 	test_must_fail git push --delete bare.git wt
 '
 
+# NEEDSWORK: updateInstead unexpectedly fails when bare HEAD points to unborn
+# branch (or probably any ref that differs from the target worktree) despite
+# the target worktree being clean. This seems to be because receive-pack.c
+# diffs the target worktree index against the bare repository HEAD.
+test_expect_failure 'updateInstead with bare repository worktree and unborn bare HEAD' '
+	test_when_finished "rm -fr bare.git cloned" &&
+	git clone --bare . bare.git &&
+	git -C bare.git worktree add wt &&
+	git -C bare.git config receive.denyCurrentBranch updateInstead &&
+	git -C bare.git symbolic-ref HEAD refs/heads/unborn &&
+	test_must_fail git -C bare.git rev-parse -q --verify HEAD^{commit} &&
+	git clone . cloned &&
+	test_commit -C cloned mozzarella &&
+	git -C cloned push ../bare.git HEAD:wt &&
+	test_path_exists bare.git/wt/mozzarella.t &&
+	test "$(git -C cloned rev-parse HEAD)" = "$(git -C bare.git/wt rev-parse HEAD)"
+'
+
 test_expect_success 'refuse fetch to current branch of worktree' '
 	test_when_finished "git worktree remove --force wt && git branch -D wt" &&
 	git worktree add wt &&
-- 
2.43.0

