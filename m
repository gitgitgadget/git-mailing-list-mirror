Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458081F4608
	for <git@vger.kernel.org>; Thu,  1 May 2025 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135664; cv=none; b=XYKEWQKdxTnMo9rfAToOFx5fomBWUK2hIjAQHgzDCBSQTnrDqqoQ3wr+PlnlVGTyf9rjuDhARtowFp6OqLTQN85lSmXIY/PjiFVTSf5/5C17fIvimtHsNWK44KC1ldhvO9yENL0CJ0SIiMqo63d7x0Ge+Yu/2MMHRbSTa7zd1XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135664; c=relaxed/simple;
	bh=s9xW7L4yUb6PlkmdlvcGsos0maVa08R1PUbaOj9mPnM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlRvFkHrwMCMCaq9gOKCVzSDyZbiGRO4nxm00u9qfpka95Gu4wFSSHy3tAUsN3fFzNeuemqYGrWs13QfK/f9oZyYmEB6A0txBBEilAvocYKBKO3kVkq+yRKgDcyA8eE0uRFr9GUsam6ZEyQzrlRS8Y7ihz4e+xfxg7iIzSeeY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oq9gLNIc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JdpzuMB0; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oq9gLNIc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JdpzuMB0"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B2151140250;
	Thu,  1 May 2025 17:41:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 01 May 2025 17:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746135662; x=
	1746222062; bh=6/bzj2naTsJB2wyMsM36wq1DCdA71n/CI09DTLX5Eko=; b=o
	q9gLNIct9+Gau0tG+0GpxvpLOQhaAq41Ue7hwkdVs6R1Zp42RO2JI7KZ8lIURzKr
	nwIyUDUK3yacMMveuCPSfhgozNNQsa7GKDIi3LXWj5rMBzbiUMAyRIsh8/cWKdjS
	BjjlCSgXl2mzeK4Q6wUXiA7XfmXa36pFmmurOLvCAwXJEVa+jw7yfWojRGJg+b74
	lp7GEfBlXM/QkPLMCj2D1HIi1XPX6cE8lPw0nLy8/in398hc1kK0JvCvB7sk/hr1
	qk4m1xIjP+ze7Wbj0xgW/eJ6nZK2QQKThlt39hF8x8zYBS7+n553gsGqh7ovW5iT
	Xo3Y9ytLWAF0xQ7i0XJLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746135662; x=1746222062; bh=6/bzj2naTsJB2wyMsM36wq1DCdA7
	1n/CI09DTLX5Eko=; b=JdpzuMB0ktq80ngbwOKkv63gl+HUtHx0uakiTWkAL/r8
	XoBoe0cWAHh8jn3A9BJjuglZgXXHgzansOnmBwo7Rf9XPYh4d5Fw8D9Dm9urb6ET
	nK9iN+9hR0u39Uxb3Rx/+2bdNhGtjHsArJUexUmP7TM+Lzs7o9aCeJSjpU9GHgpW
	HEORot8kgloQmkDzSOrjK9hcYxlwoHdB27TMsKyIO+lMUYX28+Cgf5O1AV8JRHMN
	tzNOH+R5bf+4KjWmh2fQsds7izQ66Kfu9XTkGyOZXMpmlW7Ga4q65is3+Q0u/njo
	BxKZnDVasJliU/tMSjblVpTN2RC1tnczyeV+/xbzSQ==
X-ME-Sender: <xms:buoTaJhS4Rh_BgDt8H_AENvJrpwUcrjtSS0asdm3_1doDZzWk2NJZw>
    <xme:buoTaODWOkSiLN81G0re8mlr4kC4NAjz0zlfdiOoAnDSvOvko4nbSg0u7heLpabyR
    DqkjVpC5pTazPqRzw>
X-ME-Received: <xmr:buoTaJEV-zc3qtE0r5MBjdkl2p5nyUnn8ufqct2KMDuOmB94VxTYzs9Ypy-4E5o51sHfQvd-1QI8CarwO5C32LxGV8YeF9Je_Pzy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:buoTaOTg1082pCOXcLYHVjsuNgTUowFE8fg1qTiGH27eH2ruFJRIsQ>
    <xmx:buoTaGxdazkAlwodi3Rw27hQZjNmwhRlc-T_p-3J7kO70-B0vM-05g>
    <xmx:buoTaE5rHDHaBHtzpFzEzXqyg-vQLvbX02sqdaDLDgDPEWLjd6MG6g>
    <xmx:buoTaLxVB3SRdk09BCx77ukCQc5IvgSZ2UTiEyK9xiJXThU0opda-g>
    <xmx:buoTaNiYqxaMKB3kEKHRakRNC0tRgu2a8D2MC_jH_QJduJCeEwURK0Kz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 17:41:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/3] config: values of pathname type can be prefixed with :(optional)
Date: Thu,  1 May 2025 14:40:56 -0700
Message-ID: <20250501214057.371711-3-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-599-gc9a5c860a0
In-Reply-To: <20250501214057.371711-1-gitster@pobox.com>
References: <CAPig+cQUycUyto6=cDadaCahzDBQ_GDngAEEtK0bshLr15ok8g@mail.gmail.com>
 <20250501214057.371711-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes people want to specify additional configuration data
as "best effort" basis.  Maybe commit.template configuration file points
at somewhere in ~/template/ but on a particular system, the file may not
exist and the user may be OK without using the template in such a case.

When the value given to a configuration variable whose type is
pathname wants to signal such an optional file, it can be marked by
prepending ":(optional)" in front of it.  Such a setting that is
marked optional would avoid getting the command barf for a missing
file, as an optional configuration setting that names a missing or
an empty file is not even seen.

cf. <xmqq5ywehb69.fsf@gitster.g>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt                  |  5 ++++-
 config.c                                  | 16 ++++++++++++++--
 t/t7500-commit-template-squash-signoff.sh |  9 +++++++++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8c0b3ed807..199e29ccea 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -358,7 +358,10 @@ compiled without runtime prefix support, the compiled-in prefix will be
 substituted instead. In the unlikely event that a literal path needs to
 be specified that should _not_ be expanded, it needs to be prefixed by
 `./`, like so: `./%(prefix)/bin`.
-
++
+If prefixed with `:(optional)`, the configuration variable is treated
+as if it does not exist, if the named path does not exist or names an
+empty file.
 
 Variables
 ~~~~~~~~~
diff --git a/config.c b/config.c
index a11bb85da3..4a060f1d82 100644
--- a/config.c
+++ b/config.c
@@ -1364,11 +1364,23 @@ int git_config_string(char **dest, const char *var, const char *value)
 
 int git_config_pathname(char **dest, const char *var, const char *value)
 {
+	int is_optional;
+	char *path;
+
 	if (!value)
 		return config_error_nonbool(var);
-	*dest = interpolate_path(value, 0);
-	if (!*dest)
+
+	is_optional = skip_prefix(value, ":(optional)", &value);
+	path = interpolate_path(value, 0);
+	if (!path)
 		die(_("failed to expand user dir in: '%s'"), value);
+
+	if (is_optional && is_empty_or_missing_file(path)) {
+		free(path);
+		return 0;
+	}
+
+	*dest = path;
 	return 0;
 }
 
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 4927b7260d..e28a79987d 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -46,6 +46,15 @@ test_expect_success 'nonexistent template file in config should return error' '
 	)
 '
 
+test_expect_success 'nonexistent optional template file in config' '
+	test_config commit.template ":(optional)$PWD"/notexist &&
+	(
+		GIT_EDITOR="echo hello >\"\$1\"" &&
+		export GIT_EDITOR &&
+		git commit --allow-empty
+	)
+'
+
 # From now on we'll use a template file that exists.
 TEMPLATE="$PWD"/template
 
-- 
2.47.0-148-g19c85929c5

