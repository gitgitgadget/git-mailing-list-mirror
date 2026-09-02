Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703BF49E5E6
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356117; cv=none; b=L/9ZVMwyuW2HwsPrOyv/t++x59ATWommmj9z8f15hk5/mxxVgo/nA6Z4hW4wC6uxvKDoe1oduMwdiDMYBuaosfkd/xzgnhCedfhmOxUvoUEWiyWvD0HPAFpLSD/qunO+X/aXH6DFejqpvz039N6noQf1DU13s3/QfEgYI6lzU0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356117; c=relaxed/simple;
	bh=g5to7um8cVXQtARvuhZ/NmwkNatRoYV1mbc2bTt3FMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m92iMwLMIxWXuB9bdT+++KVe+1Db/dwb65G1CyWhdgFJVvLT1hPbOtp028n4XQ+hP6iWb9cvCAWhtGtZjqJ3MWKUFMC/Sz6ld9xxY9NIMvl7MVhyHP52PTguNbEffHErWpNa3B90shtXBw+t8breLh2YQ9LNNnpt8+7OmguRkl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OvZ5DFsf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HmRU5Xz8; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OvZ5DFsf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HmRU5Xz8"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id B65861D0014E;
	Wed,  2 Sep 2026 09:35:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 02 Sep 2026 09:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788356114;
	 x=1788442514; bh=P92uI5T9jjdVvNJ+ml4jNJklaVU6G6K6eWrMiEBkmO4=; b=
	OvZ5DFsf5ePHUDnTWEWIRYttw6FHGoOqNBu2v3jbTqCOHgPPDGkglpJwtY5m7Iqf
	L6qUB4gsZ+7G9RvovIKE8+VTrduNWbYVkeEe2Zf42WpyR7o+bcSQGUlH2SL2bwoq
	0i8eN+llsxprwYz4aiAl18qJQSQgbMgl2Hx5Elur16tYlLxu0Op6VpYrtZH5wVz5
	sAIZVxuFrzBc4jANoHb4yb2TUtwVyar+2giEXjttYSADvv1a8CxJMK8OeUmbcbE+
	uzVE4pWb8J0jaN+Obpivj/Qx1bfaHa1D8yorkjsXFK7f2rjZSNTpLLAAIBZRQExj
	4wNPTB3BYYQ0rmieYKeA2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788356114; x=
	1788442514; bh=P92uI5T9jjdVvNJ+ml4jNJklaVU6G6K6eWrMiEBkmO4=; b=H
	mRU5Xz8/S3HGwIvwPw1f5Z45qZHQ13XVKyD3xdxVLSIbl0USZmGg0+7lMAjRFNsN
	IDmjw5+LPCOiJdI28AJnB98UsZpYo79pWQF6ddwPe9fcFd83MctSoUMLJjd74L6L
	30MoSFXS7MVreQdJ/47ZKzXKgh19sF0QbTpLxubr31icBqKUvAEz4lDtthiM0uZb
	BWG/reDGHsL9eviWR5I9TbUeB/zhq2Zho47XUS6sQzOSuPx6CubXc/D3tBVAS27E
	PqeVmAmzkV2XXc2+VxcWhSnhMPBo2nAEBp5jh1qPdIWtErDq9+OO0HtMo0gU2jS5
	E6+481zRpOoAqclTyteWA==
X-ME-Sender: <xms:EiaYajQ-ON0D7IPSjcfG13QeZmBTW1ZPMOpoY2RsM3imsh-eIihLCQ>
    <xme:EiaYaqzTWAHq7A9HBkO0L8Bv3ld5eUWNUUfj913wJy1foHicoMUeExCIvqf60cp9f
    XKZYV1LJRDT1fYJAU-i0g3DIsW5ixEI8ceQlhv0yiWNZtaO2wOrOEA>
X-ME-Received: <xmr:EiaYamee198grNwsYcqPK3qIReYDyArG06FoPUHWYNIvAeCWvbkCRI-LD2k0A3Hea1R8P20>
X-ME-Proxy-Cause: dmFkZTEYhr9e4Ywlb1TBHLwsOW3Qx1tjtKD+uhP71WKh33QJrNZx9AVMt7nD22Jis4lPrv
    MTCD/EPB8RsDNVjlqEtIpjdnI06qWWOaQew+wKEg9KR8NEV3XDj5+C+lq0GNXMUCyo4igS
    5U9v+KFkw0Evpwnc6cWUohg4b6qCrXyvPX0B7hrQw7zRUjz5YwzGQrgU3UxDXxxyR53YC+
    YQIYAIRjLTSjVluUg4RI0n2rU5GvrWBHjQHZRsaSRDQMiPpgohYZUdgz5LN2ECLLwBR9zC
    HYaTCafKUfTxhWvjtOGLyd4VXGi9YWUXrplxaROw1Cvb4DVWcs3zD8ZSMBcPlpw1IaHWG7
    exaNJoTrNUV6UUqlY/STHtyLA9XQI7Bgi0XCzfD0nfjdRr/Ee4y2pio2p5a4eN8LSdTcF+
    pxtmY7lIYKoVwf2UtaSJJrDEMH4aKnQqfGn/IBlM3mMU74eyI783IKGsgYpZvOgB5/nbEv
    QrVUNwEnU+V5wSR76YWONGdh90WWpAkybDLcrv7wmdQNuTNnYl23UycLYZCmoYb4q1dwat
    fsDi9y/THuDrut26n+eKedETcUsVw9511h5HBl9wiIgWXyAoCEp1T8iv7zp9oVD9g4xcv6
    dJudBXWhbpAzYAHEHamJA9yAjTo5xeFSVfx2X0Yw4jfx9yldABok8tAfbF3g
X-ME-Proxy: <xmx:EiaYauJE7YePAkMTdUjoHNHdlyMAGEg5_Z5sptqfFE4sSHetAiO2zg>
    <xmx:EiaYavHdB3Ls_liL_QSCxK9zXTdpf4xUJI_pwmrzACdfN7FWcWOoiQ>
    <xmx:EiaYagrxg9TXpsh0DE-PhxxVlkO983JlCVauGKfAs-kE-nxB-_1rDw>
    <xmx:EiaYagRQicMKxbGlIqZVf7IDBqabA2YAQXrUv-QvtquBXVId1NsY7w>
    <xmx:EiaYamp2rCLeRLCg6OkoP6UnP0yeq7r_b0rfw5FLUo7zy8fIJfYYS7Gz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 09:35:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 65492073 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 13:35:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Sep 2026 15:34:54 +0200
Subject: [PATCH v2 06/13] builtin/grep: stop registering submodule ODB as
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-pks-odb-registering-in-memory-sources-v2-6-c6ca12fdea4d@pks.im>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
In-Reply-To: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
2.55.0.979.g7e5102b832.dirty

