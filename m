Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A631DD9AB
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 06:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417860; cv=none; b=B7Xj+Y1Z8UX5FGu9dy6EzwJVmOgOi4g0ZmGSk9HgxLSPULlu2C4Z9IKpeDoVd34hHVixXqOZS72+SnCVxF1RY6pfVvX2hQ1qL91rJrxu5YZZHBHFD9ty8iCld3LUc/fi+Zejlw0IQudC9ngXJwxevRV9nNzFa4wTIq/6bw92LbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417860; c=relaxed/simple;
	bh=8OolkDP+BZNDOleQdtXY8lIv6n914XUZhOYsxf642ZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ykwm7sSyiLu26fFmLviEhxqHpXG0Yu8DclJO0zyazePl+f8unHJ7quLu/JKxIYlUlk1LBeApDWQiFEhTvv1hyIC+b9zsfEsfY5FEiN1HgfEMZ9gwLOCebHeOFUvz+LKZPVc/AAKg8fNy0gfBGf1nUzMcv4Hz5vOebJeljpqvpmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m6g51glF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3UbHJ8Eu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m6g51glF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3UbHJ8Eu"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E014C1140252
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 17 Dec 2024 01:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734417857;
	 x=1734504257; bh=eSSSMBuguY+MQT81PJeIjyl7PbYzDXsNlpwdwRcDQ2A=; b=
	m6g51glFm6FihmewvUiABufWNuL7H40TR+DB3rXY8LQrh4NhCOntpTBSiJuk/bTP
	5C9C2neuet97UmdIwDultmNHObHSW+Znow75LyCBKmpMSCw1i4GjfNvk+v+0jFuv
	bIupTU0kewiX5fxwVE4Lh0b9IIP91byPTkZc5lVQMl3AQuKgwzMLNWNnx2JlQzXZ
	aCxkBG45g6Pr4XlcjRUSa+h+GHiNmcHQ/qhvtBvmeq4P+MdVVIYcS8RgYF//CADQ
	GbWDy1I910wDWO2SmuKyKe0GBQ9Ur44BuOxyd20xybg3GSUVetGKl7JvAJLxFRgi
	10FtgvpcEXV2GJ/elnL4Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734417857; x=
	1734504257; bh=eSSSMBuguY+MQT81PJeIjyl7PbYzDXsNlpwdwRcDQ2A=; b=3
	UbHJ8EuJbIH08pyQOrLFw8GXtnBbacPGQkkW62j3e5hjh83dkJx3lyrrSjPE67M7
	FsEVN9HvOIdBgUyurUSef5sY4FO97SYp6+WeOv4zAtkDntU0ZXBnlX6gyil4yE86
	80ScreQWKLzlCLLMOe1dtZSwwlcTttoOZxAlJMJUnjnXN6MEFPaWvUwzvjWTVEu6
	R6Akanypy4nXOpvP+Ng8Oe+FEKhsA5rKUoSXH/81CFT2X0y5BbKNj+8lh+WwngdC
	e6Ska5UzHHNEuNHstydMjOqE6gf2Tnwr0zDKrUDqtG5ctCCHJ8IdtWb7YFdxNV1M
	FdOVERT8jGAZ5mTeD1lcw==
X-ME-Sender: <xms:wR1hZ9CPbqHI58X5x17WP2lxIQgoKoDiwlHUyHtquWThX2SHr-6xjA>
    <xme:wR1hZ7g3_kxyxIupJ0LZF0xsFjk7BCJUDsNejluIeJZ3hsyMkZor0xE7GTlcbnswZ
    COCP1JKSa_WGXU6PA>
X-ME-Received: <xmr:wR1hZ4lhTRMln0QYvLW9oYVmMyWzAO3K9LM3voSTxjH6GCjbxfJ6NcnxGKwa4iOv5PfJrrpgwaOud9sCXnLonWX4s61TitzoyVTykGRsWdYs33I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfvvgigthfqnhhlhidqqd
    etfeejfedqtdegucdlhedtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredt
    redtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkh
    hsrdhimheqnecuggftrfgrthhtvghrnhepgeeljedtleefffeltedviedvueeugfehteej
    heduteejheehhfehjeetuefgffdvnecuffhomhgrihhnpehgnhhurdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wR1hZ3wJw7rQWBkjrKdMQBtLlD3f89B9gPp2C122Fthd6XHvmfFSnQ>
    <xmx:wR1hZyQ2JELdSzSRkugU8auHG0XrFoy7cm6TzzkupKK0o15wM3Bo6g>
    <xmx:wR1hZ6YBJlQDuqz4uVwCSSErzfyMaPWaCDdAL-AFRGgd59yEV-G1Wg>
    <xmx:wR1hZzRpT-VPdrUfI4R80xn08pRovzrOU5BSpkZbmPXNWsq6CvguNw>
    <xmx:wR1hZ1JIS7SmpP_5RClqwVm-f6MnJ1xxZ4yfpTnFesyWwgPOYTDaH6oj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8dd4c845 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Dec 2024 06:42:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Dec 2024 07:43:50 +0100
Subject: [PATCH 03/14] trace: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-pks-use-the-repository-conversion-v1-3-0dba48bcc239@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Stop using `the_repository` in the "trace" subsystem by passing in a
repository when setting up tracing.

Adjust the only caller accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c   | 2 +-
 trace.c | 9 ++++-----
 trace.h | 4 +++-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/git.c b/git.c
index d977ebc84cfba611c3e452cace3bda1ce13faf5d..a94dab3770251fa8b7b466daa85c2d61ca730670 100644
--- a/git.c
+++ b/git.c
@@ -467,7 +467,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 		use_pager = 1;
 	if (run_setup && startup_info->have_repository)
 		/* get_git_dir() may set up repo, avoid that */
-		trace_repo_setup();
+		trace_repo_setup(the_repository);
 	commit_pager_choice();
 
 	if (!help && p->option & NEED_WORK_TREE)
diff --git a/trace.c b/trace.c
index 2cfd25942ee725b022e8dea26096f01f2164a407..9b99460db82a28634c09260b42f311f7c69f4d59 100644
--- a/trace.c
+++ b/trace.c
@@ -21,7 +21,6 @@
  *  along with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -298,7 +297,7 @@ static const char *quote_crnl(const char *path)
 	return new_path.buf;
 }
 
-void trace_repo_setup(void)
+void trace_repo_setup(struct repository *r)
 {
 	const char *git_work_tree, *prefix = startup_info->prefix;
 	char *cwd;
@@ -308,14 +307,14 @@ void trace_repo_setup(void)
 
 	cwd = xgetcwd();
 
-	if (!(git_work_tree = repo_get_work_tree(the_repository)))
+	if (!(git_work_tree = repo_get_work_tree(r)))
 		git_work_tree = "(null)";
 
 	if (!startup_info->prefix)
 		prefix = "(null)";
 
-	trace_printf_key(&trace_setup_key, "setup: git_dir: %s\n", quote_crnl(repo_get_git_dir(the_repository)));
-	trace_printf_key(&trace_setup_key, "setup: git_common_dir: %s\n", quote_crnl(repo_get_common_dir(the_repository)));
+	trace_printf_key(&trace_setup_key, "setup: git_dir: %s\n", quote_crnl(repo_get_git_dir(r)));
+	trace_printf_key(&trace_setup_key, "setup: git_common_dir: %s\n", quote_crnl(repo_get_common_dir(r)));
 	trace_printf_key(&trace_setup_key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
 	trace_printf_key(&trace_setup_key, "setup: cwd: %s\n", quote_crnl(cwd));
 	trace_printf_key(&trace_setup_key, "setup: prefix: %s\n", quote_crnl(prefix));
diff --git a/trace.h b/trace.h
index d304d55aa1d706dc3f65bbf15c7b2506bc0e9499..9152fe9b3e565ee8dde1ddf185f30f021812a416 100644
--- a/trace.h
+++ b/trace.h
@@ -92,7 +92,9 @@ extern struct trace_key trace_default_key;
 extern struct trace_key trace_perf_key;
 extern struct trace_key trace_setup_key;
 
-void trace_repo_setup(void);
+struct repository;
+
+void trace_repo_setup(struct repository *r);
 
 /**
  * Checks whether the trace key is enabled. Used to prevent expensive

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

