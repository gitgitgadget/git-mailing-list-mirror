Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4444A2058
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168358; cv=none; b=D3tEO9dDwqocEPh5y15LexJiRWeQM1Ot9Fti6/SM4EDfmm5GVR4g9Zi3b/RQNmmrJO6c7TKJ3GDEptZwS+tzX01aLllPuBwOS6jFlJoWRCCyCgIQMwu/3N2VRBTzT/h92pTcjOvj6VnzBLwq4xn6JZsUxH+QUvqL7ofBViE6QT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168358; c=relaxed/simple;
	bh=OZ+s8du0KFoxd2eJvaA0IHd0ufY3oybcVB1+iuC3g2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cz3bDhJFIQkNZAUc1tqUv2E41SD9ZyPtTo4x58d1bQAXFah9mUHjeFjFx3EWqKKajNNhVuQ+DXHxNCQDJOL4tXQFoJi9ZJIy64vqGVK5d4N1GA3xGOfZIrhF9e7KFogt3aK2FQpLelxaoaD/3tfOFfmP74Z4SJiNSHkfCqau1BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EipIPycF; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EipIPycF"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8a45b788a71so7605147b3.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 05:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790168356; x=1790773156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5j2hBrswZiTmOG7kXb4bKL+B5c79CylYMjcd4jkukAQ=;
        b=EipIPycFBWXCmiklE8r2dDWUlJ1uX2Qc4Sz7HuWXsAZ9+vUVC/nvgNDccGT8ajy3Sv
         yHKxVFbjiwMNVgscQsxToMREDnmBDbM98UNESAaBh4iC3UiXxXgOeG6nIUzK2GS37WB+
         mmySHi1dH30bvOeE/RMaTkmrIXIyI5yWhEmo6S754jR9POKGuyG5AEV1A7FsjZE/7Lv2
         5Tsl+F2u3E94DgC2Zg2BxxDIjSaZ+HwElsxbAXdwEStHseUs31mKhdHVRHP+T93E6aKZ
         Fu9Rfo2PQejDgFPn1plBXffvHWheSV9MQKzM32ClKn6w0IBdmNDj4ukbRM0tS15IGMp5
         w5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790168356; x=1790773156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5j2hBrswZiTmOG7kXb4bKL+B5c79CylYMjcd4jkukAQ=;
        b=TouzFEJyVnfhJSIavwTOQR5YXZ1tD7A85HrZdrpYwwJQwJzG4ztNz4CZ3gmT6NiQfw
         d9sa9eij8i1C7yhpv9P6FSnN2iD/fn5ScRcNmMsL2Env1yIOUV5v25odODXkDf9sSIVW
         vsLwRjyFpIbokjK3ND92Je9yVhCqgo8UoElA5Fz/NT5HUmPpS9w/IBK+KkKLMQP4Y1V4
         Pc5hernHTEz6rR3fi6dYeP2TfrF5jYyvG6HrYgdggcrDi5gj3WsKsLM1027+L8Lcztl1
         JNWLQSGzwDdvib990lPfZUCQwmiRXUSDi7vI1Q1pybzxvdy1e4bx1AVRB3Jh3sspW4+P
         dklw==
X-Gm-Message-State: AFuF++nnP25wJ7tZ9x0KZwEIOmLbH/YQBx3Czqe8ubIPQAu87ADGZIrt
	d9x6QZEUASUHRhnzjeAZPSxwAsO+TrO36M1+Y7nNjRK5fwUaZ6Jp3L9Hg8JidXM9
X-Gm-Gg: AYBFou3JxFUOeyBxHGHNnS5S0kjKDmDZ+GcIJtatn0miRlwViA0I3BbEC9lFDOJrgfX
	MuYzo4OxKjo9CNpBoQ+TcKtcHucFXYH7vT3yJmpWFA/58uTDNeBrgnAWdlqHRE5FRKdjOTpsSPE
	dH7IW0Y2EwfoJPov004QqIcbOQCTcg0TEtw/kSwYeIv40qUYA8yyV1NFJ94NpS3n5Pw+xbAhXdr
	8x5qY/FbQm5hPUv+GDWddS+xR3mz5unvGADNs+elt6S+qZM3MUFsS4f/sX3ekaxpMEmskJuT+Hc
	cCngrulzEbyXO7Q6Fbl6VEK/dWPOzi1tf10oyhafLrZiDd8+3iNKXB9KXCVHJravP5GHQZf9GFO
	cycpYm49SKajxp0c8VzumkBp1k4KSIKlagFMt65MHbOcnh2DnGe2stm5R59w1MxDyfZpLQy2coJ
	AKQAsdkCh+AcY3mtJfF6qyCLW/RkFa/uGMWiGbIvFgJIZC2yEKLddrgVVicMJ/BY6ud9ysF08Xh
	frTZAzUV/+/0/SzkHGC0jJ09a8Wkk9I0+pYGMaN1Yy7FFMosQbhdxmpIVM0SlpMUaKd/rd1Byc0
	vvi2MkGmp1vj8N+4lHd6yVHqC0s9WIL6
X-Received: by 2002:a53:490c:0:b0:671:2081:e4b3 with SMTP id 956f58d0204a3-672d58b0a33mr1016471d50.62.1790168355929;
        Wed, 23 Sep 2026 05:59:15 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672d81ce7dcsm833063d50.18.2026.09.23.05.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 05:59:15 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Antonin Delpeuch <antonin@delpeuch.eu>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/4] stash: prepare merge options earlier
Date: Wed, 23 Sep 2026 08:58:05 -0400
Message-ID: <1e2343c7fcb17137389d740701336f6c885ba928.1790168285.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790168285.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790168285.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a future commit, we will reuse these options for the index merge of
"apply --index", not just for the worktree.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 builtin/stash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index dfea2d2c4c..043a38cc6d 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -664,6 +664,8 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 				repo_get_index_file(the_repository), 0, NULL))
 		return error(_("cannot apply a stash in the middle of a merge"));
 
+	init_ui_merge_options(&o, the_repository);
+
 	if (index) {
 		if (oideq(&info->b_tree, &info->i_tree) ||
 		    oideq(&c_tree, &info->i_tree)) {
@@ -695,8 +697,6 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 		}
 	}
 
-	init_ui_merge_options(&o, the_repository);
-
 	o.branch1 = label_ours ? label_ours : "Updated upstream";
 	o.branch2 = label_theirs ? label_theirs : "Stashed changes";
 	o.ancestor = label_base ? label_base : "Stash base";
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

