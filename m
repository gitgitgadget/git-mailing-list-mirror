Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D029CB49
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749382; cv=none; b=PIxKGcPrT6vMAjkJxuKdTVUZZZnz3qBhIALpZiPNajsCUXR756/NHRJVP11KFTDTpMORnStYADWjq9SO5qNq2iTRAgLPmSAs12b94tyIbG31YngP3AVg652gqxP00oOUehc3D1Md+GU7Cr/iRRjaxDI/UYJ5tX4sX7CB7Eyvk5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749382; c=relaxed/simple;
	bh=rxIepfNrfX055GqcYDxb4QVa905b/czmzmJU3wE49oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OT8dhp+7Snao4ZZSkgP+5ctYcMPdzPBDJbh4/8zGLs6o4ABok5KRerZB1wwAgjgsU3Sj+s1FqnQ0pDEG0tHRid4qaRur4i6nZrTaT9pbwcl6aFQ2dwHOBe4sIOt9ALk4hXjV4jIIom3g07W6L7G5VgrZ51Wdb0H9cH2vi3qtPlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=buKmYs+z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kWqKGsCI; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="buKmYs+z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kWqKGsCI"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9702C7A0200
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 17 Jul 2025 06:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752749379;
	 x=1752835779; bh=TcPnWj7le1iydt7vQNMMXj/9ZsreXa6SwAHWUKPpRrM=; b=
	buKmYs+zLiMV5qdwo3KZzXr1HP6pjwLx8m1dwt4NMjeGE5rOvDLnxijlLa3GV+h1
	truFUWeFv/rM/aXByC7VX6XD1qAXTajIAsWRyDfuM/2lD3+XhVsdvJx2bta6rxcd
	/Xjzty9EqnMVrTvi8DD3+tY4lQ8CUx0BbLmaCv7dm8WnYGVzLR61rrQO/IFBGwJq
	YTQgFB6X+yErp9qj9Zsc1BGuRY8pHp1Y3tmR6+WPvtXlvKHYDwuwhD1ez2f2aw/u
	STknB5C1BAk+ilp8Y5Uc01Whg+anCO6SIL5v62Wc5zb1ous0FfSeYBJJscs64Dy6
	/oRdRY9+8wXcj9dTNA6t4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752749379; x=
	1752835779; bh=TcPnWj7le1iydt7vQNMMXj/9ZsreXa6SwAHWUKPpRrM=; b=k
	WqKGsCIRGWW51YScVZin+wiGf6GbfJjTs27oKW+utIAzvMEYFlCLlzrOFYznNhkw
	3aFeEiG3rlZzfic/b/woqW/JbUBnLfgCei9vGU58uMXdqkcqrv1wHGaFRvysPyL8
	guJE3HAW/efSnL1kJnpKcH+W3ocO1jFBoEGtUQ0RuAU4hmFjduVvXHhY+F1iWJ/2
	ZMHyTl8tFoLDusfFcvLLm5DRA+EIAHkJ02HMPAkQEFPMjMAzdyhD31u2Lm1iEVBJ
	EfXi3mkwyZfPyX3NWEf4g9X0LT5G742FLQClBI7CHBntfWtmRk1xvrVc6xt1wsBE
	uqHjKfjE7NzDcYedXL/Fg==
X-ME-Sender: <xms:Q9V4aJ6heNSMxkskhOGI5SZG2IRzfjOJezKydCZCJArNEpDVm9mU-g>
    <xme:Q9V4aI4vW1Y0R5NcQT32VHoYCwMUMgczwhQBGh9ZVXXLMGKPp6VZc0PXMBRrq-Zhl
    NTPU2KEGNA5NdVgtw>
X-ME-Received: <xmr:Q9V4aJ1U6hQJdFDJeBSdtkXwIQ0aE0RlI5_FjVLwAvi2ynbrZRlEAXmCSx6vDT3I278GzpS9efqr-ffwNQYIWp0BW5fvGKeX1oVmNyH-bx-t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecuogfvvgigthfqnhhlhidqqdetfeejfedqtdegucdlhedtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgr
    thhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrth
    htvghrnhepuddufedutdevueelteeikedujeffjeehfedvieehfeeutdegffefkeeijeel
    heejnecuffhomhgrihhnpehsuhgsmhhoughulhgvrdgrtghtihhvvgenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Q9V4aEUKrDf-QJtMVygLlTgDkZmkFt574KwrAArMxVnWCycLkTM8xg>
    <xmx:Q9V4aE5KwVRn_G2H1thlKhj3xmIKoB1BqUH6Ts51ILLn5iWARSxxQA>
    <xmx:Q9V4aLLA9fH3ty86LXkRC4s1yNOXd-czPh5KND9ti3FbHijmJcocPA>
    <xmx:Q9V4aFKXbqm379778Oz-0bPMLlqIbEr5Wuc267LmmxLU1INSmEmOFw>
    <xmx:Q9V4aHRKMtSFp-LPe4QIfsBf8CMBuOngzRW-6DKs_mFfcaNWYZHPQZU4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d631ed5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:49:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 12:49:23 +0200
Subject: [PATCH 03/21] config: drop `git_config_get()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-config-wo-the-repository-v1-3-d888e4a17de1@pks.im>
References: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
In-Reply-To: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In 036876a1067 (config: hide functions using `the_repository` by
default, 2024-08-13) we have moved around a bunch of functions in the
config subsystem that depend on `the_repository`. Those function have
been converted into mere wrappers around their equivalent function that
takes in a repository as parameter, and the intent was that we'll
eventually remove those wrappers to make the dependency on the global
repository variable explicit at the callsite.

Follow through with that intent and remove `git_config_get()`. All
callsites are adjusted so that they use `repo_config_get(the_repository,
...)` instead. While some callsites might already have a repository
available, this mechanical conversion is the exact same as the current
situation and thus cannot cause any regression. Those sites should
eventually be cleaned up in a later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c                | 2 +-
 builtin/submodule--helper.c | 6 +++---
 config.h                    | 5 -----
 t/helper/test-config.c      | 2 +-
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index d9e3b9d2ec3..e5c3d082eda 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1916,7 +1916,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix,
 	git_config_set("maintenance.auto", "false");
 
 	/* Set maintenance strategy, if unset */
-	if (git_config_get("maintenance.strategy"))
+	if (repo_config_get(the_repository, "maintenance.strategy"))
 		git_config_set("maintenance.strategy", "incremental");
 
 	if (!git_config_get_string_multi(key, &list)) {
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 89ee09abea6..6bcc741a6ac 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -549,7 +549,7 @@ static int module_init(int argc, const char **argv, const char *prefix,
 	 * If there are no path args and submodule.active is set then,
 	 * by default, only initialize 'active' modules.
 	 */
-	if (!argc && !git_config_get("submodule.active"))
+	if (!argc && !repo_config_get(the_repository, "submodule.active"))
 		module_list_active(&list);
 
 	info.prefix = prefix;
@@ -2878,7 +2878,7 @@ static int module_update(int argc, const char **argv, const char *prefix,
 		 * If there are no path args and submodule.active is set then,
 		 * by default, only initialize 'active' modules.
 		 */
-		if (!argc && !git_config_get("submodule.active"))
+		if (!argc && !repo_config_get(the_repository, "submodule.active"))
 			module_list_active(&list);
 
 		info.prefix = opt.prefix;
@@ -3349,7 +3349,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get("submodule.active")) {
+	if (!repo_config_get(the_repository, "submodule.active")) {
 		/*
 		 * If the submodule being added isn't already covered by the
 		 * current configured pathspec, set the submodule's active flag
diff --git a/config.h b/config.h
index 4eea99e9b95..9261ed0f8d7 100644
--- a/config.h
+++ b/config.h
@@ -719,11 +719,6 @@ NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
 
 # ifdef USE_THE_REPOSITORY_VARIABLE
-static inline int git_config_get(const char *key)
-{
-	return repo_config_get(the_repository, key);
-}
-
 static inline int git_config_get_value(const char *key, const char **value)
 {
 	return repo_config_get_value(the_repository, key, value);
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 41ba8647900..cacf6f306b1 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -137,7 +137,7 @@ int cmd__config(int argc, const char **argv)
 	} else if (argc == 3 && !strcmp(argv[1], "get")) {
 		int ret;
 
-		if (!(ret = git_config_get(argv[2])))
+		if (!(ret = repo_config_get(the_repository, argv[2])))
 			goto exit0;
 		else if (ret == 1)
 			printf("Value not found for \"%s\"\n", argv[2]);

-- 
2.50.1.465.gcb3da1c9e6.dirty

