Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D93480324
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184369; cv=none; b=Ml8ZuM2ygyVd6wnJW4YrJQvF8a3/NMuIi1uhXsSD3dsoy28QprHCdil6FvIORKF7TEKIt31Ou/ue4f3qvd+GwTutFJUMiE7x3L1xEd8CYQexdmH32ZvXyLC2NK9Rmiu6ByYW2VbBXmYa8cm5QbCCp6w0oTO4FVp1HYD+DqetBSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184369; c=relaxed/simple;
	bh=dj2dJjhAVhgdvyTdm4ayP1fffZk/he6PiE07t8cJbPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7ZQxv9w3lhf0+Y+a/QJe2qhrDGWsllGT4mIfEsX4IuA/ewopD1mdcvTC0e+PTf5JohH9Pt5zRQT7KI3owDKkxSCqdJv0LnStAVTu8Mv2vr/kMSHcbof2KDu5G2u9Timm284ih7RXUuR6gnBJNjXoMrpkwV/TEllG7KlqxFPGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bhu1i3h0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aAe5+lcE; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bhu1i3h0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aAe5+lcE"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CFD637A0104;
	Tue, 19 May 2026 05:52:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 19 May 2026 05:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779184361;
	 x=1779270761; bh=qCPXRpNvGVyexBG1g0jN71a43FBiF/GB1fAhwRE+mV4=; b=
	bhu1i3h09FExQRdoQbcGLOhZPwAtfPe3TeMDUleKnez9ctLdCiR3qqNX+sOM6dSl
	gUQP9hqa4WAvGtuYgijsmoUuOxQp47CknGP4C2tH6ARJusvhXJOe6dfrAM2Vmx7b
	z6OyeZqHNggNltiLfTZptTigNSLoZJ2ddQscYzVEg5lkML6cugz9X4R44y5YdIYx
	aEkoVx2euj1vKPWID82pRhI7fqM6N7zefIQLXs9twot4+wcTNTu0oFC1yjIM12Of
	H1y5wBu6axqSb3t2Pd4GSejXZnXaDFHhuaQv4pxR18wDGAUeRX95l/VvFbdl18MH
	YNIU4sj0pQrL/03ApNqp4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779184361; x=
	1779270761; bh=qCPXRpNvGVyexBG1g0jN71a43FBiF/GB1fAhwRE+mV4=; b=a
	Ae5+lcEcQ2mHjaDTKjznp6CxmHqxhFFaeYXtMleY/KZU41drYUk6/tHUHOJvysMM
	J942/qKk7STdWO2Ga0HyBWWsglJAUaFEC2uEDvA5S0G9foP/WMpZ8dqwTr7cvEDG
	3qyaPcgGUeYhGtBX4MCxsKCmXhSipSu4ffyqwYYhnz3krnQInqq8Cpx3i3LFIULq
	+eMd8/uiNPRGcafrZtHhWvOpT3Ziu+9+LLbw7AK3VkQlUG/JOn5rV54z3kM5rSg8
	jNUW6mojGuyzXkqtSX0EIOo+EHkUcjL75VpTffJcZq7jlByP5iw7/iDcYkmij+Al
	Ov2FUqzcXOAKVYMw6tI8Q==
X-ME-Sender: <xms:6TIMat6tjdziLgoSwVL7haruBv5YJvW-e8b6MxNR7u0vY5b_Si0BIw>
    <xme:6TIMahxiXRpStxxNmA02JSaiKZ40H_hrsQ5bBv3NA5rWKwSpE6oqEed36RYaNYTpB
    RuXKiplKVs2GI4Pu66tiEegmnB9pvVy6vDnkGrz03eWg-F-U2acFL8>
X-ME-Received: <xmr:6TIMasyAynwLXg_S6G5ZGqQTwMJ73F7fjPJuq5N9ShlafCksmb1LINNCPlQ0pzkJtk5OkChooMYxiW-h6BBlYeWiWIwUGfoUlg1MpbBUMtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrth
    esmhgrlhhonhdruggvvhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6TIMahxJoTvVswhGNV1Al-KuHW4UtuyMHqsbl0x5JQW9aRAe9dCl4Q>
    <xmx:6TIMauYFQS6OoPTuhq7FpbM6h25qKNj20_6N_MvZJ6zPtPQBmzH4xg>
    <xmx:6TIMaqWAAAUL0EUMYM4O4RZdMqXBvoi6-yxKxuqWDHWyp4Pl3htbjQ>
    <xmx:6TIMakhMIJnc13RB1XpeEaqIo42kWLKzbnSws4tCUM6tABic-BHyRw>
    <xmx:6TIMatAqpC3J7Uq1kD1Z51fIJRpMs_yBdaJ3EACmjYdSe96llFez6K9E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:52:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bf5e86ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:52:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 May 2026 11:52:15 +0200
Subject: [PATCH v3 11/18] setup: stop using `the_repository` in
 `setup_git_env()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-pks-setup-wo-the-repository-v3-11-a00d8ea8b07f@pks.im>
References: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
In-Reply-To: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Stop using `the_repository` in `setup_git_env()` and instead accept the
repository as a parameter. The injection of `the_repository` is thus
bumped one level higher, where callers now pass it in explicitly.

Furthermore, the function is never used outside of "setup.c". Drop the
declaration in "environment.h" and make it static.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 environment.h | 2 --
 setup.c       | 6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/environment.h b/environment.h
index 123a71cdc8..9eb97b3869 100644
--- a/environment.h
+++ b/environment.h
@@ -147,8 +147,6 @@ void repo_config_values_init(struct repo_config_values *cfg);
  * Please do not add new global config variables here.
  */
 # ifdef USE_THE_REPOSITORY_VARIABLE
-void setup_git_env(const char *git_dir);
-
 /*
  * Returns true iff we have a configured git repository (either via
  * setup_git_directory, or in the environment via $GIT_DIR).
diff --git a/setup.c b/setup.c
index 796ac5792f..8965f8ccaf 100644
--- a/setup.c
+++ b/setup.c
@@ -1074,9 +1074,9 @@ static void setup_git_env_internal(struct repository *repo,
 		fetch_if_missing = 0;
 }
 
-void setup_git_env(const char *git_dir)
+static void setup_git_env(struct repository *repo, const char *git_dir)
 {
-	setup_git_env_internal(the_repository, git_dir, false);
+	setup_git_env_internal(repo, git_dir, false);
 }
 
 static void set_git_dir_1(struct repository *repo, const char *path, bool skip_initializing_odb)
@@ -1988,7 +1988,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
-			setup_git_env(gitdir);
+			setup_git_env(the_repository, gitdir);
 		}
 		if (startup_info->have_repository) {
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);

-- 
2.54.0.771.g3ed373ac14.dirty

