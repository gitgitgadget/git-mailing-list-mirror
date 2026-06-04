Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC4B3DD52F
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559212; cv=none; b=KEpEc4BnlgHrECvb+paLl1j/F0p4BpZ5nsIC7rpIVI5Y6ehao98wcycNaf9Eb46iRKWwvuVl53LdVZ7DhyU6tZpzZMDtQL+NN3rUl66+7H+e1kxqXG1Cnl1tRhTGeZjQdO60t1Nbf/Z5JF6xwKSHmkCUOb8dzzj7ryEOTGsSqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559212; c=relaxed/simple;
	bh=LEnlm9ALAOyMlGRJOyheZc09r18P1RQGsFUtFyLDwQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQOITXqdNsGGg7vnZj3yL2APaWxLNGdWyQ7NSqA9vcq0q3IsbITRYBlFh+uuSIkQ7wLjhNYvD2973Zkr+NBxHT2570qL0lKemkRfb9FiVOJqxFN1vyy6a/w3Rd5BBZVh0fogV0Z0jQmhCBq60Wud4D9rgIaOx1czD/QRiF31yck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jCjQngX7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R32vMfQ1; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jCjQngX7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R32vMfQ1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2C6F6EC011D;
	Thu,  4 Jun 2026 03:46:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 04 Jun 2026 03:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780559209;
	 x=1780645609; bh=IzUFcJuhedGQI4gxoEzjq9905Iozpmy9J3facGFZCFQ=; b=
	jCjQngX75JBUGv+/RET1heGSFwqTFNlGUUPAfpAZo9YkqKBYH3+KiE/cmcBqE/ip
	t14rOIDWG6j+roUTkEyISzkl+SmS6d9qqkDMBoYmLYClUHYsOyvFK2vfcmDeT3v7
	/XXwo2AAA1dCgxFATke7ZM5Fh1op3DN/zMIsPjH9XV8SjG676hyxLxIy6M+DzRkj
	NMQjwj1KIrudnxFbCLBTe3Nh+egsjKjaRXe4qmRn5bq9CgR9iatHueCUTlUsDnKz
	Nq/gzkrZMMDBH5Zfpm37KvJU2kvlK5K4r/4nBw1dFolI8vVdC3AQTalwiaF6WkPh
	ZCSMKjLB1SvAsAgiAJimrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780559209; x=
	1780645609; bh=IzUFcJuhedGQI4gxoEzjq9905Iozpmy9J3facGFZCFQ=; b=R
	32vMfQ1BeT+K7zpS2rNHn4i2tdi8zANdo3JB7JhQx3QI4I2iU6tyxYfK0aqn6hpQ
	pBJXvwQNu8kghjvTuC418HxNi7KRfZ/zf6f7SMOzdA5yzP995BQFwpj9BYnkmfKU
	dDYv86MX2HAAvGOUprdj1QshRn2WXxgB94hP3NIkeI5ANZelaVUR5mgGPw3nELJs
	mp1UP88zwNwhXAbphKEMm23IX3SdCfnNNEQeWC2Rnd6ka3O4YjYBZ4cAoAxSsaIZ
	nv3BKFzeNJ0ZuvOvxjZ3PfAQuUH1SHW0FjXslxykahnNmepKlgU0nYxUzGqWmNky
	FQjzQeDURwG1AJeQBqwQQ==
X-ME-Sender: <xms:aS0has2NQutC_RWP_eWorNBGiJjcPzOa-xmq8WCpflwD1shkFnuruA>
    <xme:aS0hauFO59hx4G3bP5CwD-VuQYIqU1ZHmriq31lvZKskUb7OXoKv6CN18Wbg_nt-2
    tiZfwj0aUz7uOg-YS8w10ZPWnP31dYv4nApnqQkwCQrs1cz1Q>
X-ME-Received: <xmr:aS0hap7JsG73IJ0847_ik7BnGHj5i9O9e1O_YOHnP6mYOFNVYmK9sPeX_OSxh0wPrsDfnxYMUh8Cn8LglRgelBiSrI6BrrJPVriJAkw2hqo>
X-ME-Proxy-Cause: dmFkZTEd/wZLSFtwQVPACQsVX2yDwAf383Bdc0tR+p5729Mhi1e1AtQtMA/g4VsWVwTHWh
    qNGwVXDbahu4NS5MYTuI9+B1lU0FBMXXLiwn9ZqB110XnpphPlKVjFK3FhLqRHKvjreL1U
    yuoB+rAmnu1kGr6OEVbLdtfFIPdukJpb2g+cdusvr+IsCsfFhyCkU6GEnIeasfFMr6lZSb
    +QF/0+sNY7nCuL1JSEVuSB9JACtDjtW1A3ItArUYDI94gYKQXlalAIgs1sw1gOr6oAP8m7
    imLnOAyRssO3edUNJEt3F6n1O+rJ72/l35UYyExqEDoPNd76lDZol9HoPYjXnUtpTaCXE0
    1VBDjZW7vNshiPr0206yfWw6vqJhcw2+yyO1bJ6GbEmJpb20TxXwG62RKi4fog8X/qbskS
    Gt8ayiLw/s1d9subN9T8939edVfu8suvsmnpsmZonQ2VioSkoDf0rH/a0pjqDJsaYrjKU3
    XewxbFtRfaGtbbJy1OvaQVwdn8RFLR/JuXl5AsF0S3RJu578twNKu6s7oo6nAxzKGljgwn
    m3fkq5sx+isMmoM/LjN7YDrRoeWT2R9maprsQmwYanUozSTQHh76L4VvFj9vLTq32tcLqN
    E3Lkm3dWg2oN0iobGlbNUPfcrjmV/HtYxiLBi8e/cKkGeQy3k7RPeKd1SoIg
X-ME-Proxy: <xmx:aS0hakvaMbHuHHI2v2OumwCHEcBBrrqxvUAEqYtFp5fOa9xGfce6lA>
    <xmx:aS0haq6JvjBQS3Rsm2SWo9ZjxKwphb-rs2Fg8mWOJz21IZ-S65tW9w>
    <xmx:aS0havVA0Q9s2wneD6UsLPi4dK9WKtdAGza3DUqZZys02czxF1WLeg>
    <xmx:aS0has_ZO5zwnF4QjnRzYcWJtIPbTEGNBXGsLwnwgb0trdadX_AUxQ>
    <xmx:aS0halbhNnrObVpiaYjUxIA0Aa5au9EgvHd2URW-tSPvQwpTzVVH1Dru>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 03:46:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8bb4ca06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 07:46:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 09:46:28 +0200
Subject: [PATCH v3 4/8] repository: stop initializing the object database
 in `repo_set_gitdir()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-b4-pks-setup-centralize-odb-creation-v3-4-0691834f318a@pks.im>
References: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
In-Reply-To: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
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
2.54.0.1064.gd145956f57.dirty

