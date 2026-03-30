Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D723D4138
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876695; cv=none; b=bi3gQWUem57fzyE451YyAHL0lldw82pkpLUAyiVWOSLrXJ50ZWOIpCqx9YiSlZxVPFhnb5fWUrSW/rgN1FNV+tUFP7pUhsBEiGKv60kOJ/cJazMo9yetDmCE06DL1ah4TJUUyRhflraOpKM/u8nojKHrkWf3dfyvIUckEZZ3/GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876695; c=relaxed/simple;
	bh=FdckGM4m2yBj02nPEIG+Z1Es1F6psEux3FJJZLBsyGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fWhQ16vN8oxtINLhcl4O0sqZrjGNsEkeJQAWRfR4YUn0ZjikP4zlVeOM3/aaYNkXECY1j55kyfQRfnUh6Q6IbLXSOjYu70LeOh0bnF+s2yv0aYKoNBgoSQlnCXmYeyEUTxjiSlsNMGI5B6e8o3Wm0wUDHSoobeYggdwMuSGclmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hg+T+PFR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b5m6aOiK; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hg+T+PFR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b5m6aOiK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id BC9A81D00026
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 30 Mar 2026 09:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876693;
	 x=1774963093; bh=TXqiU8075DiOFfXv+M2rtxOZJwV0qCrrD67IBDVWqaY=; b=
	Hg+T+PFRAICIBhAS/AhNsQjUcH4bTDYKZLltOg9Kb0yT174uDZiSph7eCd9Nwbvt
	vuGfAksej83kLMzx96hOCVv/9UFEOTyZftzwsVrvVw0ZGC0ro2XDGjg8g3pM0NrS
	3UoR43O+XN/tHTgs7+96o0w3ngkLy9suf/34UvCfjr52AITMnXK+4sSCAWn6B9tm
	amkEHTzPwnh9O7djhpuRx8k9+wXf0tlLIs/Yh/+Jq5Yjp1jC1yBODadl0R7sgqyM
	3n2wrMXBqQu6UHlGitV2iqAovT7uY45dH2ZD30PFDRP/CzNrK03msw+J+tFeZnBZ
	hQaDlZssdEQmgjoYj1EtfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876693; x=
	1774963093; bh=TXqiU8075DiOFfXv+M2rtxOZJwV0qCrrD67IBDVWqaY=; b=b
	5m6aOiKlSKvU8mu5d02vkGiVkQiYh1uhPYA/LkqjrHDQhfFP5c0lxypkrl6jtf2J
	AwVktMY1OuOSLgJOqlXRO0smOXA7lUvhAIXVBg4fCSJZu8as/YvdKq8Jxyz4MNXI
	34UouBbOoPz66mlY/4694+UFsPwb/BzUQF/sV6CcFKUl+XciuavYaE/7I2so7ELr
	NKk2f21IS0Vz51W0cXWcfr2LSggJ/Amc4SJdwz/eE43DN8oLuBzHg4gCdPG5UggQ
	k/CSib0lLc25rRCICd5P/kipFdvU32k9anWQXLytNbAVAPt4uq/d/4FaipFfZvZ8
	BdYkXSUxMDM3IKicOlSAA==
X-ME-Sender: <xms:FXjKaQtq3bOIyfJ1iHJFOMMAmUaOnqwD9Api7FfyIYQYv_KyOGIUlw>
    <xme:FXjKaUYdUHXYNI0jZlvfTXm9FMRwcRlAO_K-elR9mbxjugG_5ZAkhWJMv5aE6FQo1
    iRWMR07nNM2veRgTNK7a_ngUMsgtyDmZmQO_rVImU3F1jXFcP5pDw>
X-ME-Received: <xmr:FXjKaRbGExqnP6pk__w21iIUM9M_dLWf9TqVA5Njki9mHLY4IHIvAWM-wroDYoFvxtv10Gjl20MM8h-RIbuKVuIkTKhUkHYoUesuThzToaWX-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:FXjKaYWcIPe_GXWcoOrdQFasa8PLtu2NGNR9-aSTfV8_4R4-s8IBFA>
    <xmx:FXjKaQ0YQ8eNYJEXkt6prNcwIxUG6CHYFcIU4AmpW5H-9aSR0RLlgA>
    <xmx:FXjKaXbY01Ihy6V_BuDh6EKqMyjwsG8bBgjoTaCQ52e93k1t_R_iZg>
    <xmx:FXjKabo3dIjCVtDPEVyEGrgfs8a5eFP5uuhJsUzhMlD5Y3xAkN7BTA>
    <xmx:FXjKaTcXuS7yI3QtcADXF0mqhFyN2jAsvFWaH9Q58bjP0vTIfPbZEUWa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bda53f8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:18:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:33 +0200
Subject: [PATCH 11/18] setup: stop using `the_repository` in
 `setup_git_env()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pks-setup-wo-the-repository-v1-11-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

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
index 2a917e3a5b..e1814fb8e6 100644
--- a/setup.c
+++ b/setup.c
@@ -1071,9 +1071,9 @@ static void setup_git_env_internal(struct repository *repo,
 		fetch_if_missing = 0;
 }
 
-void setup_git_env(const char *git_dir)
+static void setup_git_env(struct repository *repo, const char *git_dir)
 {
-	setup_git_env_internal(the_repository, git_dir, false);
+	setup_git_env_internal(repo, git_dir, false);
 }
 
 static void set_git_dir_1(struct repository *repo, const char *path, bool skip_initializing_odb)
@@ -1985,7 +1985,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
-			setup_git_env(gitdir);
+			setup_git_env(the_repository, gitdir);
 		}
 		if (startup_info->have_repository) {
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);

-- 
2.53.0.1185.g05d4b7b318.dirty

