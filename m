Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92877383C70
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673420; cv=none; b=DOd0NveRU/q1FtYc8Fx1R9IOQWodBOZ0tGboPFFpvkwQXIc1jwAAmwec1pkWtWcpa26ncjfJX4zzqxE3tWM2nDxOtVgs5BOLXnknc5T7S65ceANP7UilX+QXWiteLNDEToKr1IW+QesXtW/KQ9ppDQxvOc1Uo3/TQcQdsY5nUDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673420; c=relaxed/simple;
	bh=s0GVGuo4n64+sV48j18a90m75PPWOzH2spGWXyIsZGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkkI9T0PKSRe7Td45hbXQ9NWvvmtEI6b/K2glCR/RPqm34YQUVnY3qEZWIXt70DcTwt+tLPLFk1uPRMczQe5KkZuXZgxS3XN9K1xwFHtOYNm/ZCIr1mrfrW302TeOkP2VE22RopgDXh5eX8M87FSdy3jnJhvSTsGcpFfRZ1khL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iFsw4Z/F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TMYpSCaW; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iFsw4Z/F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TMYpSCaW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF23A140011C;
	Mon, 20 Apr 2026 04:23:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 20 Apr 2026 04:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776673418;
	 x=1776759818; bh=1uPxvzP3Ojjga0R15MrEoOeQN+QhSjswK/zEUzMGspI=; b=
	iFsw4Z/FQyCTsTVw8zpqJW2bFYZ2GakCoyPEQjXQee0vxxpz1pgYYF9PtzZjsta+
	Vp/WgZ+vZ8ymTdJTymh+pfiZC50drIC44VX2FCAZpUPP64L2Ap4ZSrtU24V2837Z
	lX+WnHOo1ddxHhwnQxaWdfnuU0wTet6RsQZ6N4JwzwuqN3dGrdxZA0ZKmotistPk
	nSgIEaaGLSP5PIDdQIRtFNGHeL/8ukuJYs1RiRrEwIfjwuh450+K86DBk5MgwObK
	D0e4JMHYuGIYlqotwKzj1LL9TFWkOPETh2ab3TTvJQaOzLIHcmy39wYP6oA7zhzH
	bCgAe+uRExxu7xMK0+kYgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776673418; x=
	1776759818; bh=1uPxvzP3Ojjga0R15MrEoOeQN+QhSjswK/zEUzMGspI=; b=T
	MYpSCaWti5N/f+5nd+m4LSgOCxv7DtjAb9xjMAzBMKaIclPknApxQpSUvugq0XN8
	3tu926+KD41cX90w/kN5TAgyDZyBEvxWzal0ywYqOvF8hsVwIHTaVUZiOSXKat75
	nNRJNovQLZlpCbeuvuzlSlaBBrHInHOQeQW+VFN7MWmQAn0A2jxpTMnylJt+pQnt
	gpZrSysufWWqfM6L8vgm7v3AdW1P+RQX6X7tTMSiDafa5RmNU8bIrWu2xJiLn09R
	m+gfwN6wO3vQPPk3iUl05f0Cq7Hnt+SUE6NpVkZNMBxgAyxhzmw5JYMTKKsPDWIL
	TTb544Guopnho7MV7gKaA==
X-ME-Sender: <xms:iuLlac6j0so2IHx9xGsHUzS59rb04HbCGVcQkPUo3ilpT6amenxQng>
    <xme:iuLlaU6T8aPc3NjqOUwlFC3M96YH0e4tnD0KeCxAOJQ8ZQ6KOzc_VkbyYvLOjaR2S
    PN95a6aXuRtjCTx9TPKSua-PLWxXVlVC3eXGSfg6jKxtnbHnCQ7mA>
X-ME-Received: <xmr:iuLlaQfaBbYHB4oNe0xKGC2KpwYn28ukvef-cCMQjfx3Ng-9bpA2-uvxMyH5Tp_JL-yF5kB9SNEfzFZPe-sUQyCCMgebeERtA7QpZFATlzPT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:iuLlaQAt9KsPEW9jxW1oVRaZvYHCVjX7AAR2vV-WiyZON1HKKo7T4A>
    <xmx:iuLlab9epsAMvuCSyqUa-JI8kYPb3SN0GFNBUg2YRLqePFHZoD4XjQ>
    <xmx:iuLlaTI_oMihGOA95KqW3o5wMp1vTchhpGZlpHWKBg5688I3HB563A>
    <xmx:iuLlacjnBIu3aPse0CHMhRxzJWe1Lw8W12BZHKYawCO1_PC2Eji4uQ>
    <xmx:iuLlaf8uVNTrRFIHXgeaJ4SsqwfCXL9CqlrpDEmG33JnwLfy9qHQa_Dx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 04:23:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 90128b3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 08:23:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 10:22:47 +0200
Subject: [PATCH 17/18] setup: stop using `the_repository` in
 `create_reference_database()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-pks-setup-wo-the-repository-v1-17-f4a81c4988e8@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

Stop using `the_repository` in `create_reference_database()` and instead
accept the repository as a parameter. The injection of `the_repository`
is thus bumped one level higher, where callers now pass it in
explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c |  2 +-
 setup.c         | 13 +++++++------
 setup.h         |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 663ef0b524..d864022214 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1442,7 +1442,7 @@ int cmd_clone(int argc,
 	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 	initialize_repository_version(the_repository, hash_algo, the_repository->ref_storage_format, 1);
 	repo_set_hash_algo(the_repository, hash_algo);
-	create_reference_database(NULL, 1);
+	create_reference_database(the_repository, NULL, 1);
 
 	/*
 	 * Before fetching from the remote, download and install bundle
diff --git a/setup.c b/setup.c
index f1d640ea74..8616f5e619 100644
--- a/setup.c
+++ b/setup.c
@@ -2459,13 +2459,14 @@ static int is_reinit(struct repository *repo)
 	return ret;
 }
 
-void create_reference_database(const char *initial_branch, int quiet)
+void create_reference_database(struct repository *repo,
+			       const char *initial_branch, int quiet)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *to_free = NULL;
-	int reinit = is_reinit(the_repository);
+	int reinit = is_reinit(repo);
 
-	if (ref_store_create_on_disk(get_main_ref_store(the_repository), 0, &err))
+	if (ref_store_create_on_disk(get_main_ref_store(repo), 0, &err))
 		die("failed to set up refs db: %s", err.buf);
 
 	/*
@@ -2477,14 +2478,14 @@ void create_reference_database(const char *initial_branch, int quiet)
 
 		if (!initial_branch)
 			initial_branch = to_free =
-				repo_default_branch_name(the_repository, quiet);
+				repo_default_branch_name(repo, quiet);
 
 		ref = xstrfmt("refs/heads/%s", initial_branch);
 		if (check_refname_format(ref, 0) < 0)
 			die(_("invalid initial branch name: '%s'"),
 			    initial_branch);
 
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", ref, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(repo), "HEAD", ref, NULL) < 0)
 			exit(1);
 		free(ref);
 	}
@@ -2821,7 +2822,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 				      &repo_fmt, init_shared_repository);
 
 	if (!(flags & INIT_DB_SKIP_REFDB))
-		create_reference_database(initial_branch, flags & INIT_DB_QUIET);
+		create_reference_database(the_repository, initial_branch, flags & INIT_DB_QUIET);
 	create_object_directory(the_repository);
 
 	if (repo_settings_get_shared_repository(the_repository)) {
diff --git a/setup.h b/setup.h
index c33b675ccf..21737e9bd6 100644
--- a/setup.h
+++ b/setup.h
@@ -236,7 +236,7 @@ void initialize_repository_version(struct repository *repo,
 				   int hash_algo,
 				   enum ref_storage_format ref_storage_format,
 				   int reinit);
-void create_reference_database(const char *initial_branch, int quiet);
+void create_reference_database(struct repository *repo, const char *initial_branch, int quiet);
 
 /*
  * NOTE NOTE NOTE!!

-- 
2.54.0.rc2.529.gd9106f7525.dirty

