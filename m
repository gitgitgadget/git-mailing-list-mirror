Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E763BFAD4
	for <git@vger.kernel.org>; Tue, 26 May 2026 05:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775045; cv=none; b=ups0/kBFISK0OrQ1bkS7nJyC/YxEyQ0LjWfc9SzLqfSILMlUFt1V7iThnevwyG/j4Yo4HPAaSnOubSkyEqoMigf0F9eMMiJ7I9R28Iq39Uuh/VPhPpkpFRNWt5cqnSat3owzl2jDZIk8Qm1uzsOaBmcAocR90aB9nFXAbAGmlTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775045; c=relaxed/simple;
	bh=mDVSpKYEy1y4UyQY4lfWmFC1c2wdjke39A1VJSc2u1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hR/6pFsjEu8oTQh9Lg38vkbOltKpC2hkkud+JI/Y3oTx+ZK9eBqNFWhpjw4ZNba6Ls5EOD4KilwekKEMS2LscU5zGknVsRD+2FqBJ5iZ9pAJNxa9VZ48brxAQy57s3SQqiJ8azK8DiXBFGwT3IgZJce1apN4BHbzZB+qL63ELuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ib4ba6Kf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tFPTJ6Aj; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ib4ba6Kf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tFPTJ6Aj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 39A8C1D000C8;
	Tue, 26 May 2026 01:57:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 26 May 2026 01:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779775034;
	 x=1779861434; bh=vobU9ECdTDY3qOWWR+LI064z16ugo50EGaYeNbcErdc=; b=
	ib4ba6KfuFz1s0eXypgeE0+xJfoJrfSliZT94GMEVaHdfOPfBIC6J4jpDbsQ5S7e
	u5Ycv9VgnxR+H32u/5gTBmBMXdWDqdoJHMP/g6yHSu3XUVOl0c/XiJa3/a/tAZDN
	DRbXmrwP48o9nYMFBJR4SJi1WEAf27aWlOcnIueMZzjjtrbEyKLFudrlZIheK2Rv
	F1RGtqzh5xAminJ6icxu7QaYo+HeR9C9F4Bj24t5IpssEtWLsTZHuPd81Jj1QK0+
	pb4STTphGLO2eVcW+M6zOXykaKYCmZp2yck1oII+eLyn0CFXewPuSVcGSY8QrOG4
	fhZDIsWH4FlhspWQiZ4uJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779775034; x=
	1779861434; bh=vobU9ECdTDY3qOWWR+LI064z16ugo50EGaYeNbcErdc=; b=t
	FPTJ6AjzW5ATFzD3HdcAQ/FAVWPzzj2K9wkBXHnok9QnBOr960VoFKlIFZHbqVNi
	VgFUiZxuIY9xsvG1mVAuZ4Eb7yeQyKalydX89cTsmSFXlkepqDca/FkRgyxxgiyW
	W7xgB6hjmuIvNdDrK44+KYzD2D4Gh6+HYYwKffNQnYKSg/QumDLzCUAczGAwWLIq
	9U/5+Q4yFRUxcukR1THUrbZl7Gd2y0+XSTB950fSMObyF5nrMpBgrnaBQwRcWZnB
	eMY9ZDWlh5WVZNZVYzQb1Ee1g8JD53/6nFCrN4uMEUh+43TMhXOkVO98+BSlWRFQ
	isV/UV3ITsr8ojmRThG/w==
X-ME-Sender: <xms:OjYVanQei0PwnV-KHK9Y-KMBamDBFT2W7Ir-OxjZfeBGox7NKp2F_Q>
    <xme:OjYVagMnWhyGDRpDgZ682NcX6poDTa4Qa1ugRsRLBWTNphzdJfw0LVMKrwM4-IJtO
    9y2AX0JIqB1CAcKqxrEjI2XmR98jSBMy472LafUPVRlNdbYVUbvaTU>
X-ME-Received: <xmr:OjYVaqNWsdaEgBtstzvw1PTc5G34bBsXlQ-P5U89XG1qvI85oHrihLSxnEUNjPaiWjYr3amIib8ItYeSJ8jmVcFj4kd-RWv1pShcF-QgjA>
X-ME-Proxy-Cause: dmFkZTENDWPlIMehrI0p5s3nwkhC94E3+Vziz2RDPzn8dE1M2zUbfRmFf4UZfcnyV6gcS+
    CxVZxxC3667h+nAhR6pqpNggMXlVeZYl4wzEaI+cHAj5vReVVsTehM35WU8cFIvMy7RAR2
    sq0fQV5df/lYICvHIopy1DHD/0D9dQZ+yGFyfl6DCWWUsVYBztrbDdiCcnBYzMAu7+IeCJ
    IjvSOmbtjdbu+S0zT14pNcqslKmSRNuzmYU57jfQ53GS85OjSTswjgKmMrEguMgZ2qBqI0
    mjGPmHfCy62a9sJdy7nxYZhhmNtd2tZhnvvTcAoLqkPtY+35gVYtxanNVk7O0FGv4PbDXM
    fgnuCAAfzZaDjAzP982befN2DU8amuuGdxVJMIkUroA/Ma7b/q3DdOiWMZ5wC2fl9Fniv9
    8ybCblXClt853/3yzjxaFOqtceyHSYzBhCgUUmwD6dU7AcbCuNC8ikNTsok++hIr9kj2N7
    d3Trqg7GBfdQAbuA3KZ29FpwE40OgjrO5pbJdPMvi9x4NiYv25lYwGo+7i83E92I5Jptix
    2gE+EMAs0TQlJF4kCOJJ61iVtBoHQoLsUDoVrqJt4OQF87ttP1xBpIPc+C/9CadF5ExJtV
    LSqIt20ygmfdTmZSB8F/HbxoOeVeF4Cd22CTJR9tN7WKbTZm+foO6BKq7+1w
X-ME-Proxy: <xmx:OjYVagvZZt5x8S4bWnA1cx-AF15_LvyqEaEmOaFVeeD6LtueSZreUg>
    <xmx:OjYVakXHTyOFp_4WRzlL-c4atDAxCqHj60P2W_MZU2dKqzyI2MoMJA>
    <xmx:OjYVaotXLUoBL4k6P6d81heBBFwwA7KYdQB7XbtGkfKQO3rb6YFf2g>
    <xmx:OjYVagUy7P1DbDA57hrkAtNAaL24oY2PftCoCEIDPkOALMvJPCUF6g>
    <xmx:OjYVaoVSfHRgD8x-8RVjHtud3WPn7MXtmjO3NlDFEVUKXN5Rze3V-hPY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 01:57:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a17007d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 May 2026 05:57:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 May 2026 07:56:59 +0200
Subject: [PATCH v2 4/8] repository: stop initializing the object database
 in `repo_set_gitdir()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-pks-setup-centralize-odb-creation-v2-4-2fa5b385c13e@pks.im>
References: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
In-Reply-To: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The function `repo_set_gitdir()` obviously sets the Git directory for a
given repository. Less obviously though, the function also configures a
couple of auxiliary settings.

One such thing is that we create the object database in this function.
This logic only happens conditionally though, as `set_git_dir()` may be
called multiple times during repository setup, and we don't want to
create the object database multiple times. This is somewhat tangled and
hard to follow.

Remove the logic from `repo_set_gitdir()` and instead initialize the
object database outside of it. This leads to some duplication right now,
but that duplication will be removed in a subsequent step where we will
start initializing the object database as part of applying the repo's
format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 8 ++------
 repository.h | 3 ---
 setup.c      | 7 ++++---
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/repository.c b/repository.c
index 58a13f7c4f..2c2395105f 100644
--- a/repository.c
+++ b/repository.c
@@ -181,12 +181,6 @@ void repo_set_gitdir(struct repository *repo,
 	free(old_gitdir);
 
 	repo_set_commondir(repo, o->commondir);
-
-	if (!repo->objects)
-		repo->objects = odb_new(repo, o->object_dir, o->alternate_db);
-	else if (!o->skip_initializing_odb)
-		BUG("cannot reinitialize an already-initialized object directory");
-
 	repo->disable_ref_updates = o->disable_ref_updates;
 
 	expand_base_dir(&repo->graft_file, o->graft_file,
@@ -302,6 +296,8 @@ int repo_init(struct repository *repo,
 		goto error;
 	}
 
+	repo->objects = odb_new(repo, NULL, NULL);
+
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
diff --git a/repository.h b/repository.h
index c3ec0f4b79..36e2db2633 100644
--- a/repository.h
+++ b/repository.h
@@ -221,12 +221,9 @@ const char *repo_get_work_tree(struct repository *repo);
  */
 struct set_gitdir_args {
 	const char *commondir;
-	const char *object_dir;
 	const char *graft_file;
 	const char *index_file;
-	const char *alternate_db;
 	bool disable_ref_updates;
-	bool skip_initializing_odb;
 };
 
 void repo_set_gitdir(struct repository *repo, const char *root,
diff --git a/setup.c b/setup.c
index c5015923f1..3bd3f6c592 100644
--- a/setup.c
+++ b/setup.c
@@ -1045,17 +1045,18 @@ static void setup_git_env_internal(struct repository *repo,
 	struct strvec to_free = STRVEC_INIT;
 
 	args.commondir = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
-	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
 	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
 	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
-	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
 	if (getenv(GIT_QUARANTINE_ENVIRONMENT))
 		args.disable_ref_updates = true;
-	args.skip_initializing_odb = skip_initializing_odb;
 
 	repo_set_gitdir(repo, git_dir, &args);
 	strvec_clear(&to_free);
 
+	if (!skip_initializing_odb)
+		repo->objects = odb_new(repo, getenv_safe(&to_free, DB_ENVIRONMENT),
+					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
+
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		disable_replace_refs();
 	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);

-- 
2.54.0.926.g75ba10bac6.dirty

