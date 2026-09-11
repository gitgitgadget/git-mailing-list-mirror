Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EB23B6366
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105931; cv=none; b=UDMHgo/6BAQGbHK0sGx0uwik8M0w7hAFCn+4QicWxEPhsY4uM/y+ldKhCjZCMfBdrf0Mb67DEaY/t3v7AAnlvtioYN4n/SF1tOePa330U/es37nrsKWo7xqBmafa1TlYzCUIG/4MG7c79510kGsB+arkxgYbTRoEt3FSuOHvWUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105931; c=relaxed/simple;
	bh=NK4ErosH9MN8VQMK+x4ZYNZE2H4e9ldbzeVcjZam5+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k8lFNjaOjfCKAmL53RMa/Mockc5WbblQJASz01/bTp+fvLFjIw+Ml3g10eRF9iNCjYaiURuhu9ybV+dTv5K3v5+RoC3QZkTW0nuMDCXqptzwh/6MK8ohRSqvgmKikAdPvBwtXxlY6zEsxC3sCuE/1CHle5LKZIY3galhabFzI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PnwJQHRc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lFkwS79j; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PnwJQHRc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lFkwS79j"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 79469EC06F4;
	Fri, 11 Sep 2026 01:52:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 11 Sep 2026 01:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789105925;
	 x=1789192325; bh=iTKWlgkaVJKRpccHadMSeiNhfPEzmoTOyXzytQOnQGU=; b=
	PnwJQHRcNwWYziMW4IobJaIKeAjNfpEebFPlDWZUGOMKtHiqbsu7KLINfXR17neZ
	gnLo+gMkozi2ERmV5UPwAhLJG6UZglLG//lPFommTUEPmOKnxhTxCi4S4fOb+RYL
	VdMedM9BCAkOupeimrJSErzFWhgHmWnCCjF4GLAvs4iMqcqWwn4TgZnzBivjkd8G
	B+grABGjudY1vS1znMTW/doU4aNoCAurh2ZXFlvbPcgWESkDB2nukuY/oCdimv4y
	76itgW53RvCdoLIlsz7xzLKN9xhgutuXQa4KNqunI8Bh1XF4SXOXusL4PKg2FxYX
	w3jJ9LkjeqPsMde2ZMm8Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789105925; x=
	1789192325; bh=iTKWlgkaVJKRpccHadMSeiNhfPEzmoTOyXzytQOnQGU=; b=l
	FkwS79jLYNj06OwZtbqe5b2Ka2WQDvavCxMQPqOOYhcN+vP3pSwBPwG+aTbNVMEJ
	q9mDSRUiXAONYNR5P5lVA8yTpbLSwgiVvHJTk5sqLMfKYNA4YEj4618R1LVUoN0a
	E8i8hHLXP/i6l9fREPHubcv7/vSJorZ4eRIqEzGdDPmKI+gXSh8HRnsLs8FK6pTW
	C0bnRCLbiM39cvUMHcqxjTmYOTAy6Rp/AmI5e9r+cwx8fGfhTg7H8EBfQqN/VBaR
	pv6d7HQT3lZktP6rtzwmn3cgEiBMBWLliZGLdzWmGd9DeuCV+sAoZtMzreJvi+nd
	JsnVGzT9wcqKw/ZOs9qSw==
X-ME-Sender: <xms:BZejahLdHHO-4go_zr8rZ72E4IAEf1L3CTFHf6QOS6nuxApWme3y-A>
    <xme:BZejaklEUgyUN3grYDD1yCYJb0-xUyvlecmxC-QTBS4PuAV7mNAIL1dKVrclaqNbg
    Qa7qoT8ESyK90bjiFl-0m0LlycVV4dpsMaRAKI6NmN4e2-XPZ44>
X-ME-Received: <xmr:BZejanGxKp4m1DxJDC5-0DvBtauHFgVKqBz1MN1gy2P7sNumWKFGW_D5y40YCpWqE2ebdQ>
X-ME-Proxy-Cause: dmFkZTFGFEz1AV46mB0H5IUnOtgcTKabM/fOWdn1U32UtnAQCX7C9Kwl1UF/lK3aecPx95
    pwrzbSMo0jFTe4y6M9wP3j4PvyZ/ZbEnXlwcVhCIODBJ2zHPDEgNd6iVKvcXKLFsvGHjJY
    vWs+JOO1zUtcRsF/A4WjHSwr6DdB/6IXCdE8e3Jyy4OKiwY0OVWLq9Z8TBsacm3WsPCloK
    ydyMq7csyq3iJZTpyMsmr5YvZ/wQUfMMCCzLj3JXj48UbmBWjnybLxvLJ7a8U/gD4J8oSE
    nUcFm76zJB8wqT3mqBkmo3OeFknnRDh7XPU0VX9uvjH+wWvsGiO52yVJkRj13Bl6YbnHcT
    QWQA9vTSWUaBq102RI/LAEDeLJzSTEl/EoixUDvUGZTe03aThhdnQ4dYfkYZ204WeY3Jqe
    9hjhpHABYyjjrhzxQ2u3RyDHHzfyIevvuZJbjYyAVobv0QM+/wFqDXj/H8Z5gRzcLr5VNr
    4cxauDI7ReMxUYTqNahubMuVSYuNt1Xougw4/kaTuKFFXnLnZyCEDxA8K2nIqdEG02XHMX
    ae5v5SbeYkZBvIAX8z5VYJsTN3kAuK1lgkKAREaZwsLbS4Z7Kj1dv8DiU3q0YgLWrfyW5A
    UqvazIeu2FAlxtuJTBJODXPYXxrvcpYTo6yuKJi2LwAkFqkSPt1UrRmkk8SA
X-ME-Proxy: <xmx:BZejasGWjy7fHH5sbt1X_n96b3dSh3hAtHwQ_SRArKPlC6eDKNQgEQ>
    <xmx:BZejasMR4pZU3GS-J1mUhnHxTTlapnj3L5O2O8_CW9x_H3bUGEKfCQ>
    <xmx:BZejajFDjN7mLRqBXXoN-ZpYzm409-RpY6ep6RiFs7WVRNqc6Q0X-w>
    <xmx:BZejarOrFaMM6rvkkkiOywnwh1CoWSQoZgqkvZiLKFzQ8RZjUMXbAw>
    <xmx:BZejasnDe76SUmxHQp8OVQU-e640JWsIblg2rrMnd-PtpibI7OZC50_S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 01:52:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d124be71 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 05:52:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 07:51:49 +0200
Subject: [PATCH v3 06/13] builtin/grep: stop registering submodule ODB as
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-registering-in-memory-sources-v3-6-447e6882ed14@pks.im>
References: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
In-Reply-To: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Same as with the preceding commit, git-grep(1) registers each
submodule's object database as an in-memory source of the main object
database before grepping it. This was introduced as an eager alternate
registration and converted into the lazy mechanism via 8d33c3af0b (grep:
use submodule-ODB-as-alternate lazy-addition, 2021-08-16).

Starting with 0693806bf8 (grep: add repository to OID grep sources,
2021-08-16), the command instead knows to pass submodule repositories to
our workers, which means that those now use that repository to look up
objects, too. As a consequence, registering submodule sources as
alternates is not required anymore.

Remove the logic to register submodule sources. Unfortunately, this does
not allow us to get rid of the object read lock as initializing the
subrepository is still racy.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 073dfaaf45..b045f8a488 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -463,16 +463,6 @@ static int grep_submodule(struct grep_opt *opt,
 	ALLOC_GROW(repos_to_free, repos_to_free_nr + 1, repos_to_free_alloc);
 	repos_to_free[repos_to_free_nr++] = subrepo;
 
-	/*
-	 * NEEDSWORK: repo_read_gitmodules() might call
-	 * odb_add_to_alternates_memory() via config_from_gitmodules(). This
-	 * operation causes a race condition with concurrent object readings
-	 * performed by the worker threads. That's why we need obj_read_lock()
-	 * here. It should be removed once it's no longer necessary to add the
-	 * subrepo's odbs to the in-memory alternates list.
-	 */
-	obj_read_lock();
-
 	/*
 	 * NEEDSWORK: when reading a submodule, the sparsity settings in the
 	 * superproject are incorrectly forgotten or misused. For example:
@@ -498,18 +488,14 @@ static int grep_submodule(struct grep_opt *opt,
 	 *	ditto.
 	 *
 	 * Note that this list is not exhaustive.
+	 *
+	 * NEEDSWORK: initializing the subrepository is not thread-safe,
+	 * either, as it may cause us to race around `get_main_ref_store()`. We
+	 * thus need to hold the object-read lock to serialize all readers with
+	 * one another.
 	 */
+	obj_read_lock();
 	repo_read_gitmodules(subrepo, 0);
-
-	/*
-	 * All code paths tested by test code no longer need submodule ODBs to
-	 * be added as alternates, but add it to the list just in case.
-	 * Submodule ODBs added through add_submodule_odb_by_path() will be
-	 * lazily registered as alternates when needed (and except in an
-	 * unexpected code interaction, it won't be needed).
-	 */
-	odb_add_submodule_source_by_path(the_repository->objects,
-					 subrepo->objects->sources->path);
 	obj_read_unlock();
 
 	memcpy(&subopt, opt, sizeof(subopt));

-- 
2.55.0.1074.ge7621b4bad.dirty

