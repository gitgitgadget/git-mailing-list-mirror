Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762B43D3D0E
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876674; cv=none; b=Fg/uYXuaSpwhNYTwaByRBoKUhB8YfyXPbYn6owa0ORtHow1MlHCejIIF4b8hbMnz8X5j2nTyiSo5eVASjVMilKmRczH2XbN921mLScgvMWdTl+heyltJyBGygrZXz7uS6kJpLWkUbLI56RDnhPyXQXfbcLFlBSJGiq47sU8T9hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876674; c=relaxed/simple;
	bh=G+j8riVvlYoQQ5y82SVA0agOubjFtRN638XJSBBZzq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nio0ylo++erxD0Ll2M1ggS+BxVQG4PxJxXMO1Ssq4aaZpHaY4XjAQntkcsnqxo8bWnDw/JFRn8s2SbvKMkHhWVBL6bRdKN0jpRVWmeVgipg29in4H5POZ4pK/G2N3cnD4//Ywz4JSE/JETG+ZmGumkUv8/7u+YbaMPpvQLASAYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ux95DUcw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JiD1aS06; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ux95DUcw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JiD1aS06"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D83621D00026
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:17:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 30 Mar 2026 09:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876672;
	 x=1774963072; bh=QMd6S4ZNtsfq1aZFbF2Bm/S3QVF9fpbeU5s5w7OsWiM=; b=
	Ux95DUcwDHMG4NubOHBljmhscCm0mGgU56eUx1+G3Y71o38MynUZQoH5EYuetXhL
	6gjkK2+eNxKZJBn/EgXwoGIVe5s4X09KJ0n5Qrv1UC8Fq9SyKiw/z6/Bo5phVvmw
	CwY0xMCeJuIYvCVHmzyaChh+MqaJFJFzNCMJhW4ss4mId6cAshm50/6D21BleLc5
	YiplVeW6/DMhDH1Sscn7edaCmbRGB3GSblDlMG1ZAG9dPoYZD+MlIPzhM8/4FCy1
	VdWGep0ocxQvCJQFxbMePFq0S5AVl/cvjDpEPzCQVO1zHZxl90CTufYAP4/iKFyc
	9+9gWR5xEpyNcPyyV0F88A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876672; x=
	1774963072; bh=QMd6S4ZNtsfq1aZFbF2Bm/S3QVF9fpbeU5s5w7OsWiM=; b=J
	iD1aS06D/CNPlfUJOCA7nrWEGU30lVGDnRzi8kCxJrQSevvBrIlCGYwvKXeV7R1Z
	x+H8QSKNg6rYzl/nreQOfRnT5W8gE4l4B+ECT7r+iHARpBU6ZKbOQO5x7A0qdTjl
	k1EUW4jPCYO7kRSMu9HBFhQ4SS7R8kt2OCE6LNK1gRce9wvFA2uFsoSKQjB78YR0
	geGrJ2gGb8ccceX2B/ULk4ekvY2IZKfUmX5QWSxwPMOTLo46zbS8Kj4vUIKwKXqk
	OtDRrgxiKFX1bakq7vEt2YgI0t1SiqNj9yABJe99rM2F8nH1zgMS0NGWuYNPwqbg
	zlPHFMd6Q6Dw0jg/9xJ1w==
X-ME-Sender: <xms:AHjKaf3JzeZBYkE1Z0Inxp930DBgzBZ2xWH8h6GKscGMMXNIWONlOQ>
    <xme:AHjKaVBj9Gp9hvrxZoWMXEUtkhhy-NLuKcCXmM9Z9ZYR1vOLr8_zlPlx1TwmPIk01
    PxV9Ffemhcn7DeH_pHPRb47XssIc2SSvNDCR1pZEmVEEROenjVUmg>
X-ME-Received: <xmr:AHjKaViUKoUb1TWNpmg1LU3Dn0WcRW7X_MPhKawMUrwz9dB_CZyjc5Yr0iIi18v-QerYNEAUFEvcH1M4T9LOoRQsZvBpO2Nb9h_gENHmmn9llQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:AHjKaZ-6_W1xYVyeP2CDY0XuYzT9z7lLbvV54xm-FEFHlAOMu3XVsQ>
    <xmx:AHjKaR9FbFhxQI_nGz986mRyTVKt9l_5-YYLN6P3Km3r07jd2NHftg>
    <xmx:AHjKaSA1ckjXHwMXgKWy3jl1z0pAdQ_CRVXnAYDijnTgH0tt8laLMA>
    <xmx:AHjKaRxo2jx5DaqyYCKu3WORGb15xkVQ8LAE7pTIc5YPnCVrM8oxQw>
    <xmx:AHjKadHv4XqRN6HMUw-pVm2HUBpaaBwv2jqrRd96crengs0QM4DdS0Nz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:17:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fe80a2b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:17:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:25 +0200
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
Message-Id: <20260330-pks-setup-wo-the-repository-v1-3-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

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
2.53.0.1185.g05d4b7b318.dirty

