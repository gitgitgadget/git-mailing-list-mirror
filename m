Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C5947D935
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260988; cv=none; b=DJ7Bxr2E5mPxu7FY8LxSEyLcZwe7Vt5MN4Wwx0Ej0nAaAFMl7mp6Us9oQ709wBD4YfLwOdQjSOHfhSqoaH36zBVxzQHxgFBHshtQZpDXARYbiIJtqkGRuBIjrb2za/zUSUAFehnILF7vsNY43uFG0JDQXCRL81KwbLLdPWxcs9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260988; c=relaxed/simple;
	bh=g5to7um8cVXQtARvuhZ/NmwkNatRoYV1mbc2bTt3FMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rp9ToTwW4xwV+F0hUCovRcY2GFQ4NqLuoEZCr9Jj7JKZk9aoM9+PMOmnWATIy9RyoAB2/+9AzlCxzWe3d+CUG3Pc+69roJeub0jl9dFd0a/2oFDsM1pQ+hAQcPQzCnX6zSJqMR98uM629WH0XQZ8uuFiSCZUA555XWVSzm+fohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WgpxEgI3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aqlf6Enl; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WgpxEgI3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aqlf6Enl"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5DB0CEC01E5
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 07:09:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 01 Sep 2026 07:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788260986;
	 x=1788347386; bh=P92uI5T9jjdVvNJ+ml4jNJklaVU6G6K6eWrMiEBkmO4=; b=
	WgpxEgI3py8pJA24PMJXK9jfBee4vSy+g61yIsMAX4W/0U32lqcxx20fmry0z9Jo
	8wJ33pLDbMRX/JbiOE94+lBRqlocjTX3pbQuyEtu3aT/YITnMDPEtkMtY/Xm8/cP
	AkY3pj30bn4GkpwO6Q3QhMisHHvV/IsOxu9L7BSafb9b3K7P9L2JfsJ9GHKJCLxV
	SdCrE8xVKsYl6W4piTH57hr3KFgyubr9ujCOx3oT1q9UgUGx1is26um3oqn1VF3r
	Pb6WJu/yqvDo97sO8rEbmCdlV7SOz4HKZIOahGWDnkdTqk9frO2T0G0x4MdqjFY4
	h6OLxFpun+RJgS1tt913uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788260986; x=
	1788347386; bh=P92uI5T9jjdVvNJ+ml4jNJklaVU6G6K6eWrMiEBkmO4=; b=a
	qlf6EnlpOnwTFCDzD4K92Jj/++kSXW0AR1B1t9l4FUgzDz1sYDBl6afQI0Bc1AXm
	/1YA6S3yq/nitbb8K61V+xr7xiyAVKN87pmTEW7A9xlaaz54A94g+XDI+cgUP2Ub
	ypaxG6Yx/Tp37pNt2iBldVc0Jl7+vfr0Fk5sLRXjyxJjakGRQlW0cIPIZorcPZrV
	mg+K+JQ58dYVa7JqmLQqBHiFqQkKFRS/PF3/XzgE7Sbic8gO1h4uJXraimMilrGn
	kvjsZxtSA1JcBkn08s7nJsIALKuCgCf7akODYJXDzT8CWFyS/gs3LSbvafHEZDLl
	0YvibXc1PKVfMQktkx3Dw==
X-ME-Sender: <xms:erKWaheBA-ZyO24NceZL9Re5gu1850Nxrc_ff01Yi19k-pNDwWgCNQ>
    <xme:erKWamK1TK8H8OL49wDjqUwUBPvbCTrw_UnxsS8K0s4sQBnMk8k33CBLQPuHYZH7O
    mDLW9JbOfkliHhp0ijye3JqhPHqJ9LFvdxG03kFpVz7Uzl-Nw5hQl4>
X-ME-Received: <xmr:erKWagKyGT0jWo1xwUPqI4L5EgnloFeTuFwdb08DK6sHjY6oCxROLg>
X-ME-Proxy-Cause: dmFkZTGkwAxdD3rfUrEN+Zrml2ZOe3GlKEB8iLKVrBKaiZHxGwvIv5VuWz2Ym2XRZ6WG68
    X8B4CErn+WGUoj8xkMlDafNSIL8R++ncZ/BkYo+9LSjWcNiOd/wKVagO0zk8Wy8D4hwSHa
    6r3/+lbOAcajyrrP3cx40NutZ94zNfpwXu11m1jJ56e1KTGJELUAYyb3kCdo6TvqrMeH1T
    r2C/qu7V4Ni7HQhWiQJWEDv0H/4x5qUAyuf+ct1axIeQrKgYw/Usvtg1+BZrZKiXuOFfxh
    XiBb/5MSpVsLfY3iA9qGT34FuwQFfcaCw+S2g8Y8smfYRw55SQddZygbhU5Wjf5vnhJrrn
    V4FLPw8F26ugF0M9HnHrPM7clZK2grXxsK6ZXFsdQ4nHuLWr69eyH/8FV6Fj9uJzpwPxxc
    Llg5oamn7mGxsRXXZ0ZDrY4uDsTVpR8f3qT9sQwW+bCUyr85UtZl0d/WeE7bOqnrBsIqzI
    MOEFx8TmnRd3u52RpQ2VQuGvPJAFCQQ4x9VwkzkvOvhLQ3KlykULQ0GwgQsNGAUIJCPzUB
    Lvftm4WxBL0m0eUIv4YRcDTfdeI8BWYo8iWZfih5lddAwUgnGZ/RUMOqCE6w7Mfn0c9Mmd
    au6IJWeyiCSpMWel6kYG4gx5xrCqP4sL6rMKgiej+ztYBcAJgJQcgmAIqfxQ
X-ME-Proxy: <xmx:erKWagEYLFgDTtV-_-SvUaCKnqAL5KMd_cYXUFB5jKYCZeMt3AUbCg>
    <xmx:erKWatkTaMjL3HV9KzXrrcITPRHhboG9Mn_zooTImPZKUay9z1ohyw>
    <xmx:erKWalJW3BENE8HxaSOY43lf-eaCH_gkNhKVShtbg1oVoV6N5Aipzw>
    <xmx:erKWamZ29U4d66_NfxyD1znvmB7JcIRMj9AOrJ-mBTFG3VY9nc5GTg>
    <xmx:erKWarNpyl1gAcmLr9gLsimDH6qKEYsSnYyr3U9E8zXmIQrJEFa8izMM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 1 Sep 2026 07:09:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eba20f11 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 1 Sep 2026 11:09:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Sep 2026 13:09:04 +0200
Subject: [PATCH 05/12] builtin/grep: stop registering submodule ODB as
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-pks-odb-registering-in-memory-sources-v1-5-97a312d5fa25@pks.im>
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
In-Reply-To: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
To: git@vger.kernel.org
Cc: 
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

