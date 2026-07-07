Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B913B8130
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408920; cv=none; b=ICijYPQxO1fbR/IEAE5lgbKfQyJMCpkSFgb4L5H1RkVvs+/+by9aZvozw1t7jVmNBFcjpojxBBkNqORztvBYnGoMu7hHAsjJRbwja9U91TuatfivmAg0yVqDuvu1fBtZUDBb24fuwsBjZZn63FGWQhTA/yiWtP5RBj40aGETEfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408920; c=relaxed/simple;
	bh=9AfXF3ZEB5VM+St8qO5kwDESZkIrQPxvyZM/wNvk39c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R/++ZAMmIFE3kk9kdU7KjA5gUi8hyfm5m6f6qETatvO3ijLx9nIzSVCdtZyxaTgk8gcdVnGOXS+RGuhfmjBX22TNKtfRGgbt8nCyD0VdjbfisvKYu3AiHtWjYl3FRUnIdFRkNODq2IVNE1t5PFAtvlLE9sJd/X9IjdBLSWJeWbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mspDMakd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bojz6eZ8; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mspDMakd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bojz6eZ8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CE28F7A01AC;
	Tue,  7 Jul 2026 03:21:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 07 Jul 2026 03:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783408910;
	 x=1783495310; bh=WrxtuFlDxFT+keFu0ozSQNKBvZhs30PH/PKIxRodLm4=; b=
	mspDMakdnI10w/CzreL3OyYSlHzy/zd+B0pvda321Yr9OU9G+VrtA9CJJiuTQ5ne
	JVwX2VSfkol//kRWYqz26fHP90XZldvYzqpUQljIXvNWTc8LDwAF6c3pCBFrvkt0
	miYBum/2i1bQdz2fo+6GqnSwWtQi48DYRlR00ZNhgBiWBEcAE9iTpjDMVZhQ0Qdh
	l3lSHTMLAA/c6SnC4A6AX3VlM+mDD4k10x4K+iay3ncOu/W9jZOr8/6Lstu8gQu1
	GOh7wgsmR5YZEredN5c72BjSxl5XIA1VoRJBX9n3suaCsWTozX57oEJr5+kxHnIV
	BqIZcYMFNyE1R33bfKUAaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783408910; x=
	1783495310; bh=WrxtuFlDxFT+keFu0ozSQNKBvZhs30PH/PKIxRodLm4=; b=b
	ojz6eZ8HvAWSB2t+jscEkPJ7NZP1evxb6gr4ExClFOJafol6YpJ5yqq38oi/DzU2
	GsFaJIegV31k8Z8V5y+qassykZluMHl5ZmqstKRM3yC3MSM6HOMLzmkJyoBq4yMv
	jCT5Ij1C7A9CRMDsGgE0DL/E1oDrdwoyN/WmokJIcdzc47eeT0mteyde3rPUDJCz
	PmVoMA9tGcNQtBTpvTOjHA6stQ9tRh1m0WdUy5zvpsTQRaW70mHYHOd7mGYno9Gt
	jafKtPFqH+yYI8j/hAq/bSurc7gPqyAD88veewQ5tb5iidUyNZJK9dseJCfJduf2
	zKWN2YA1zxuVl/PC2HbEA==
X-ME-Sender: <xms:DqlMar3rl450ekIHKBy2MEc4mXIgtLk0RLNbWumpfSkKhrlfmMj2YQ>
    <xme:DqlMahgliR6w9KXLnHanMEMYGqsJfKBIW6tuYYTRgDg5nZ-NqY-2F1KaIUtJDr-m_
    vKVgYx_DHP46SiOiPPrQrq1iu41rS0wDAcb_4SsfxFzzIfDZU33>
X-ME-Received: <xmr:DqlMapRjVm5KFlYCLdJD_8-GuQ27udg7PrahiL46vztxkNq-nlDd23t3UZ-HiviQxNxO5g1ZYq9ObYY878W8qD7xFeYJfKxZOCo3KSg4IA>
X-ME-Proxy-Cause: dmFkZTFN07fpeAwIdFA5eCgep2AOjsiEaP04Mlvgy9Ah3YME15YMbmq/Ntbbmj9flmgWOP
    YUd6xlLT60gPLlvn5eoAeFv2GQauScLkpTTsy1/lg94j9wKzz4pMNXoVcba7mhrnX25KvA
    I/BM6T+Ax//Q/gAlTwc3RHLcdMR2wXvaHiX8jPAGHILjd4TtzoOncQjSXABcwzwxXMFLXF
    FEXkxotjf8v9NPBv9lIqWGPDkq5HdoNIaB5cnDSgPi46AM4xr8F4y99mqT9fJ2wHeBAp5d
    tO9ZY7r8XEpkp85FAWQ15GyyXu16nJOUAuVfw6CFWoYgMl9m+zD8dqJy1csrdX8Q2wi+nW
    KQ44vVzvm86pya/u+O0VgClox0bVqwxnx0J5IaJon7gcAXB4CLPyEpKvU4XFe3WYmEdswp
    zb73wXLQZ57nXJHVI3ezXlTnq9bK39l4DAgQ2h+lgRMAVU65JNHJHx4g9THq0msG5pPEAE
    WsVx9ygaRbxN9AqSY1T10lNfbVpuffJzdAU1Afm/6SijeHgCyKo39UUtF3GTUSpPB4/rz5
    PloP5GDcDX0LrM65MVyUEVOm0nbJIqALYfPCxfZuYS8nJHB2xWqufeJJrXq6wYurZf7sD3
    C0d+tFibAyQIwBgWdTTRsdh1oU4SFSdNK5XOFvSjkcKETzAo04JIVe5MnLMg
X-ME-Proxy: <xmx:DqlMaqjheaWWJjL4Jo8sqnHzOYoztnEL1Qlxq46KD6EiytTX_07Z6Q>
    <xmx:DqlMah6A4xYikdXOfGsTGR5qID8XuGeEcoVHlnGL7MmTy3PyRSdnDg>
    <xmx:DqlMavABMk4RK14MahMlmz8wg16HmRnGoP7Yjmr9zJTBq08CgEpaSA>
    <xmx:DqlMagZ9G5BibvAy1fMjUiAuwx3I1XiRwrGfoQGdQ_lnMaMmrl-YEw>
    <xmx:DqlMalgdl4Ua-UE1WFnmqgnldXx_x3HIqLn33h-bbtI9mmmOcFnvVUW4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 03:21:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed4fbab9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 07:21:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 09:21:27 +0200
Subject: [PATCH v2 08/13] setup: drop static `cwd` variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-pks-setup-split-discovery-and-setup-v2-8-aab372cd227c@pks.im>
References: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
In-Reply-To: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The current working directory is stored as part of a static strbuf
variable. This variable had to have a lifetime longer than its
containing function because the value we return typically points into
that buffer.

In the preceding commit we have moved the prefix into the repository
though. Consequently, we can now return the repository's prefix instead
of the local one and thus properly manage the lifecycle of this local
variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 6cc9fa2de8..f8e4cf100b 100644
--- a/setup.c
+++ b/setup.c
@@ -1933,7 +1933,7 @@ void set_git_work_tree(struct repository *repo, const char *new_work_tree)
 
 const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 {
-	static struct strbuf cwd = STRBUF_INIT;
+	struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
 	struct repo_discovery discovery = REPO_DISCOVERY_INIT;
 	const char *prefix = NULL;
@@ -2116,9 +2116,10 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 
 	repo_discovery_release(&discovery);
 	strbuf_release(&dir);
+	strbuf_release(&cwd);
 	strbuf_release(&gitdir);
 	strbuf_release(&report);
-	return prefix;
+	return repo->prefix;
 }
 
 int git_config_perm(const char *var, const char *value)

-- 
2.55.0.141.g00534a21ce.dirty

