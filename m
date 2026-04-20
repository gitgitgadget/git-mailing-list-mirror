Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E139E312825
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673374; cv=none; b=lICEesf7Tmd+vc9UQbJGthx0Mldfo/YscgWHm22H2CfH7tPLCNCEEcnNaDrkwvJe7h1tZebFJojYfBvtrD8Y9W/UH63ixzi5nWXjMPG9b68g3OIt8DtA5XGaeuIg0xkFJIXHNheQ5bMpqNOy31JNxzWAN4RKQAk8iLtwha5VCGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673374; c=relaxed/simple;
	bh=Pz5z2lh3bWMzsEbF4sHpvKrQjNqpLy74Uxf1e2yvvgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ByL/agU5oqIlzXPDPNi7A+TY5XnrXJcCGTnFNR+PzMvF5pxY3dmOziYH2seBfMsOV5Rh5asg4FiFosO3yzjnE81Q9tPKKTUjn8iiLt6lCf5yTaG5sTgbeiTINFNc6DbBdpmgudsNm6rIS9AQsrgx1SzEVhU5awznrBlN+3KCWsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XYCxxbUw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ABsBcQMJ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XYCxxbUw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ABsBcQMJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 428591400114;
	Mon, 20 Apr 2026 04:22:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 20 Apr 2026 04:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776673372;
	 x=1776759772; bh=+5hhDW2drCtdckppWKIv/Fz1g9vmqkQIScJ34OHoBmY=; b=
	XYCxxbUwQmgsB3CpWXcfQbkNNQqE0TV3ZYuWlFMnGFrOvpNCdg1zy28iyIHgv2AH
	sRraIwLQHwPI3/mrRMpUM810C2JG6YIl+68Mcxl/ClwRqPtPiFQk1gStfN4GexbU
	tuMO1e6BzBNfW0CU3Ua2Ekw4bXAE7wrCrP0bZ3kKZ6S/7x2xYEeCmUjqXbjw1bEc
	AxznZK2x4lvXPSW3fJQGjEFdM4UVmno1rr/QjUkocPIEFInwaMiQAD5/CTlochzP
	SgCHSd+3eSXFo3Le1SUzGG8xu5v0o1zF1mgf7XFB3keNkLZSwcH9S0pD6QRIPacj
	YvYGaXS8mLCdy9djJOVPCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776673372; x=
	1776759772; bh=+5hhDW2drCtdckppWKIv/Fz1g9vmqkQIScJ34OHoBmY=; b=A
	BsBcQMJ7DXS2E9r3HRRCJN/+fuCcRLvp9OT4EB1QkyK4A9z9A5GEMtheZFYCcLfj
	srHIac6uuOQSniaSO3rvoqvZKv8xrXQJoAX3nqphSqSA0zSm7zFCBX24+ZyWb+AS
	a+T07NKIwUX+0XgK+OO4jJGLx3VwNADsjKn07rQ2Dkj2iFpgb+ovqjJONWlikcEL
	apfZcjMRKXgZeIwfXtHFqH37Z0+c3Dcd4SRyfqNdfNc2KcsGeXCYfQn5SRa58Kgm
	txWXeNrIuEziI67OrgkJmH6jK+rb1AcNTBKrcz+kE1407hcD+KFhpUKRhGFNZ/Mf
	ncmcWHXszpxchRTfesXOA==
X-ME-Sender: <xms:XOLlaVB8EWnIFLPtkV3l-nwKhFe_0bN_mkhxxcY9Kit9AIGuW8OdZw>
    <xme:XOLlaaiOEM9HCKjIrYIffB_jNCi9ZW7C_EMYNfd6dUObWBjBUJINRygaTwGjPA0oI
    28Ii8kMoP2V6k0SZZrrvPAnwea4YP9xQ5CEzre6kUrF2Qj1gK6_Pg>
X-ME-Received: <xmr:XOLlaVm7AatV5pwlrLQFD9rT_-xTryRIbDKqZP25X4xQZ0ofhUkgJNLZhnHUoCPSKTaOI66Ykr8fW39on4cPHQ9YitWpIlBMQoX2IKtHzAhj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XOLlaerIOhsJAhX238WmCozmm4mgkrIJAu4aAkwq2vqSQY5JN-ojvQ>
    <xmx:XOLlaWH9gjkHEkIMc1YdD6w8h-jSdhs8QnFZspXhovd2jEwctBczOw>
    <xmx:XOLlaSxWbS7MHZuqntkjhfIsAIinFiSPRYiARwOesgzJwKx6PvcSlA>
    <xmx:XOLlaTpMdCCxb5DCJdUyl4L1egUoQjqKBSHyJC0476cRun8HsmOwDw>
    <xmx:XOLladEq5k0zpr3fiSAQnlEMYw4KHdde3ry-aNvfSOQ4pGUdZbkhVQp_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 04:22:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0ffd67e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 08:22:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 10:22:33 +0200
Subject: [PATCH 03/18] setup: stop using `the_repository` in
 `is_inside_git_dir()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-pks-setup-wo-the-repository-v1-3-f4a81c4988e8@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

Similar as with the preceding commit, `is_inside_git_dir()` determines
whether the current working directory is located inside the gitdir of
`the_repository`. Perform the same refactoring by dropping the caching
mechanism and injecting the repository that shall be checked.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-parse.c |  2 +-
 setup.c             | 12 ++++--------
 setup.h             |  2 +-
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 9629e1ccf7..6dd49ae3f4 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1063,7 +1063,7 @@ int cmd_rev_parse(int argc,
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
-				printf("%s\n", is_inside_git_dir() ? "true"
+				printf("%s\n", is_inside_git_dir(the_repository) ? "true"
 						: "false");
 				continue;
 			}
diff --git a/setup.c b/setup.c
index 4df65ba2e8..864ce41116 100644
--- a/setup.c
+++ b/setup.c
@@ -26,7 +26,6 @@
 #include "trace2.h"
 #include "worktree.h"
 
-static int inside_git_dir = -1;
 static int work_tree_config_is_bogus;
 enum allowed_bare_repo {
 	ALLOWED_BARE_REPO_EXPLICIT = 0,
@@ -298,7 +297,7 @@ void verify_filename(const char *prefix,
  */
 void verify_non_filename(const char *prefix, const char *arg)
 {
-	if (!is_inside_work_tree(the_repository) || is_inside_git_dir())
+	if (!is_inside_work_tree(the_repository) || is_inside_git_dir(the_repository))
 		return;
 	if (*arg == '-')
 		return; /* flag */
@@ -469,11 +468,10 @@ int is_nonbare_repository_dir(struct strbuf *path)
 	return ret;
 }
 
-int is_inside_git_dir(void)
+int is_inside_git_dir(struct repository *repo)
 {
-	if (inside_git_dir < 0)
-		inside_git_dir = is_inside_dir(repo_get_git_dir(the_repository));
-	return inside_git_dir;
+	static struct strbuf buf = STRBUF_INIT;
+	return is_inside_dir(strbuf_realpath(&buf, repo_get_git_dir(repo), 1));
 }
 
 int is_inside_work_tree(struct repository *repo)
@@ -1249,7 +1247,6 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 	set_git_work_tree(".");
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
 		set_git_dir(repo, gitdir, 0);
-	inside_git_dir = 0;
 	if (offset >= cwd->len)
 		return NULL;
 
@@ -1284,7 +1281,6 @@ static const char *setup_bare_git_dir(struct repository *repo,
 		return setup_explicit_git_dir(repo, gitdir, cwd, repo_fmt, nongit_ok);
 	}
 
-	inside_git_dir = 1;
 	if (offset != cwd->len) {
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
diff --git a/setup.h b/setup.h
index 7c0aa75319..71d3f91883 100644
--- a/setup.h
+++ b/setup.h
@@ -4,7 +4,7 @@
 #include "refs.h"
 #include "string-list.h"
 
-int is_inside_git_dir(void);
+int is_inside_git_dir(struct repository *repo);
 int is_inside_work_tree(struct repository *repo);
 int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 int get_common_dir(struct strbuf *sb, const char *gitdir);

-- 
2.54.0.rc2.529.gd9106f7525.dirty

