Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849F83B7B99
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408931; cv=none; b=RRGppV+kEO3hpV8lrwaClEljt/amXGcdPY9R+9MbZ1C9P0P+gBwDweYUjB3s7ddX87BxIZwXIU+5F9XnG24+c7fDFzvI1PO8PQT4VMulIoJkMZgWgEEdLujasmv/2n6Yr/hJnpwApS4mS/e6x1x52f3JwsfodAxlf9ZRP2DVzbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408931; c=relaxed/simple;
	bh=CjznlPQe4FMw4GvRsV5Lz/PFqbxt3xDvJ8Fao+D8TTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q9kM+0jN/QsoX+xczFcvbonADqJuH/vKZNGb6kmy0WbKlTCiekHRzo+/lrQpbo82B54HemupkvSLMxrQH3emLek21anBQre9Dlp6DP1dOlb5W4PO1/QDryTQG3WlVtZIve5dAz/CDqd8zJCVAqAUOXDoPe3Xwpz1EsWxMDtkTQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UYoSBrAV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ln0bKaRr; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UYoSBrAV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ln0bKaRr"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E04117A01A9;
	Tue,  7 Jul 2026 03:22:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 07 Jul 2026 03:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783408923;
	 x=1783495323; bh=pKxF4ikz+/Id46g6ZjwkuOMTyADQ5jo7TtOvsPzb6nk=; b=
	UYoSBrAVA0ONB0OWxS2sID76ZtPjxo7Dzb+rwxb090ZN33wM0WgJaziadkgUkFYE
	p8nSfRi/Yd96uTY0hTTJJCQnwenEiWNF7sNuGOqls2SJ4TFyAy4Ohdrnlq8KVeCR
	s48K+zUfZTJmTKiIrpEzkAPgtMcF4pkDrx0bfWqmzRq4hEfadZwPTSqA35ldr1hM
	30kb/DMiIMVvJQsNMwA4KkxbywfuKpQ4WgVV10ajwsB6NvI8s+ceoZ1DHZs0LRSW
	vc69/EX0wH9G5G84frHwqH2nmidEKWpQS2bn3OO8h6ZZQbyugoY3ieqvHHcfPWmt
	uPER3iisBbyaL4HjFKQypQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783408923; x=
	1783495323; bh=pKxF4ikz+/Id46g6ZjwkuOMTyADQ5jo7TtOvsPzb6nk=; b=L
	n0bKaRrSBc3DMh3wmacjah0MaK5iBxjXlGuse4/VSZ/LgxgnobNqMEAqaefvJBNY
	RtS69PEgYnhqLEcLegOgg029wag2XdYAx7TwSMPZ35rofN2dSJqV/f8k5Ui6dIFD
	q5fHPA1DzEyBO1E5/IWvXx6azy+cv2D132AGM+yqYkotJ79d2G0sFYjzuPh4sBSo
	O/p1Tl2FaRzsw3KxaYLY4eC49jHVR5KK9r2q5gBvuYTF3dZS+Hl4+7ayJjmJ2oNG
	7irzH/sTLfFRXRUrIwZRILXYmW7FW++9Ny41JdoDFMaZwmpQP2lOhfJ9ciSG/4HY
	Rsxkk3j8ZjzLImr8XGxlA==
X-ME-Sender: <xms:G6lMau4-DFf4BtMc8gwmSBTDTx-h6i2TfWTK0fts3VCxjNb6zclLpQ>
    <xme:G6lMavWW-ikob-OA4doCgYUSH3T-4B4a9krRFV5uZ4xj8OKih3d63f6X4i4wWv3fd
    4KWGT4itpexQtvMcva78Ei7GJR0fSoUIxO6seyDzPZ3hbi5Rci2>
X-ME-Received: <xmr:G6lMaq1srNe2nBOWbV6UvNMJ4lR566IJqj1ulB_Af_lLnndxN9ayqzTxMHL-gI-OQvHE3RPZltoTeSgJ30J3SYQVMOwYy6az_qgZ5hXVqg>
X-ME-Proxy-Cause: dmFkZTGomioUiHYnWpDoPUhdAmR9I7dqVaEHetQ5+YM1W+jDtBm0Kde/Fy3ikeFpi8hzA0
    oBzpzCZlTaRL43+aE5094ahYwDC3jzOH1vcT19QLr0ETwXdRhRCcAtLgAOrEmLMKXMMNvA
    l8kQIXQEwRkhR9TvHCqCIE9rePoXRNYhOVXPI3h5LS1k0B40dHXVFkJmTH0Kl3XUcgfpLL
    L6ieIXUbr19e92eAiOuNGzkxuZJsl7xoQeE1qCZcbuKTBYR2/o6iXOm6ZeKjNTcG1ZI1kl
    bhUOGyGZD1As9R+Za/xgdLezrYw/x85BTHjMsoUJg4kwBdWLTuf6f8AUD2TD3Cu671WLWx
    mTebAxweS0JFdK5Na+G6+VF4EkoN8P46pJ8rBJJ38w5sfAbzFjXivyUQhlhzB9DkrTFalI
    XyLxT5MXmhobbKKkPKfhA1Cgo7w81sBv1C15l0TKfNSSKF78QuUK1B+P9kbIuX2DCoTm9P
    DQbwim21LcBDncDrEzagtdWzJJEwaKwlKVqt3O+c2CvMO4SIAR1og6zBq92aUvxIYx4aX+
    cPK/LZ9RdSjEP5CE4zeVWcGqNYB6CwJdC2jKsJPD5uQJvc/8TxPMlaLqMVedz1L4aadIif
    4CU0ohhUDlDpFLp/K2hGrzsq2cCVriSJj17gYwg1NJvqVEAIJRQnGLWA85YA
X-ME-Proxy: <xmx:G6lMak03VNwBfNtKjRhOwbPy03R0hbdleEKQSneKshMmDQApKOtiqw>
    <xmx:G6lMal816KTIqBfJIxhdPZepHNQajSv-6Rk30-FVdXzTVAv_VHdnBA>
    <xmx:G6lMap2U93ZJ3sqYOoLKDzG5uJxogjdd-ea-ksG8o7-kaweZCiWeyg>
    <xmx:G6lMaq9efqtNOJI-i_jjFVEkeAoWibHdMSAEY5jJFz15HHqpyAO0eA>
    <xmx:G6lManebmQDVrcl7aQCiDEJh9IhgIF4ef2jh1-tQP0xNa240LYGY8DvU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 03:22:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6d039d81 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 07:22:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 09:21:32 +0200
Subject: [PATCH v2 13/13] setup: mark `set_git_work_tree()` as file-local
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-pks-setup-split-discovery-and-setup-v2-13-aab372cd227c@pks.im>
References: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
In-Reply-To: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

In the preceding commit we have removed the last callers of
`set_git_work_tree()` that is located outside of "setup.c". Remove its
declaration and mark the function as file-local.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 2 +-
 setup.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index 683b8e65a2..b632c2bf8c 100644
--- a/setup.c
+++ b/setup.c
@@ -1904,7 +1904,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
  * primarily to support git-clone to work in a new repository it just
  * created, and is not meant to flip between different work trees.
  */
-void set_git_work_tree(struct repository *repo, const char *new_work_tree)
+static void set_git_work_tree(struct repository *repo, const char *new_work_tree)
 {
 	if (repo->worktree_initialized) {
 		struct strbuf realpath = STRBUF_INIT;
diff --git a/setup.h b/setup.h
index bf3e3f3ea6..bb24ee8f0f 100644
--- a/setup.h
+++ b/setup.h
@@ -96,8 +96,6 @@ static inline int discover_git_directory(struct strbuf *commondir,
 	return 0;
 }
 
-void set_git_work_tree(struct repository *repo, const char *tree);
-
 /* Flags that can be passed to `enter_repo()`. */
 enum {
 	/*

-- 
2.55.0.141.g00534a21ce.dirty

