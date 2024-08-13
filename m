Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40776181317
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540407; cv=none; b=uhdD1G9F7f6boy+VoL1fLKIve6UCUfZurlzfEErjB6yd/jaGdcyuAQr8y3IVUER1SWJClLaR2PKxF9vfElyoWv9gsIirDAXAymihNkKn0T7Z51uV+aAdZmsQkgqo4ROYtyzS4xu2sFRTJs2118JCwxOssnXd8OYZkGtsYSp9hog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540407; c=relaxed/simple;
	bh=bKQXJncqxbzAqW/wG955RcyqZ4C0S9BwXaCzPXd9qVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUj8OBGz0OorOp2Bl7qptYWOL1wKorq/LWk2l1gbAFl/YZu1jVpmN+GUwPw9a2UnXsiUKpOfZlxdCBQ5P3lMNYDjbrDIthhKAHu7NIuGJjEkLAqBzBL53cGhwf02VmVZRo8BbLFsRXk89cEDglkEijtHmOOrByd1B7uxYq6xKdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F9FrJzn7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F/X+epaW; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F9FrJzn7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F/X+epaW"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5C59F1151A82;
	Tue, 13 Aug 2024 05:13:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Aug 2024 05:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540405; x=1723626805; bh=nh8QavN4Cv
	e4RLHq9qROScs9J2rGwCHmaj9FCnbCybk=; b=F9FrJzn7d+HeZwk0MqferbgoIp
	WorciXWuop7MG9lIiNFpBCxph00aGLKTipjcXb1ymFaldXbKYMOHoSPtN6de4v7Z
	V9zcA9HHS82E45LyPDdt9JJX7IBnhQStcyrxX7bOFJDjgCtQNINy4cmqWlywE4dK
	P6itf6uOaWpHyb8/hr4CysDq5G5Nbrr0Dr4sSgplXbKTvib4kN7hxvOou/aBQ9Vt
	/P9rTZJDwypbSqnIhSzmkPtLWpdq8GYLA070yq7vTAma+Ql/ulBlKLEPzx0yl54h
	9+6djYOAnHZ4H6OQUJusf0yrUWdA6NwtdatnntV4vxT04GCRgp2ZBFepV8XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540405; x=1723626805; bh=nh8QavN4Cve4RLHq9qROScs9J2rG
	wCHmaj9FCnbCybk=; b=F/X+epaWnIPgeST91VleF/vxP9IH7rBXP/xUvF+I8Tvv
	eSFu2MkktzfDEiGGZAkViQdv52viRer4jRfQTdz7wdsN+LggIOaUwzPEqhDjLlZE
	NY5/S9IublUMHaPRHUtf6thLx/ErFHv+TB+6xxf53JGiXEwj76MoiUmZQugulvav
	X1BRibM1oEBFNVC2VlFWQ+vfoAnPuS7p+QEndauZJpYceTye1wThhUx4rOUHhWBt
	IaYu45At0DaomcL7UMtxvebHkpnjxzvVXfFKFeqCj85vqZg0+J9ToTUZ6yc870Ip
	HOteXjJ/YgtWAPvOV3+aL3V6SI7JQHIVMGy1G0//mA==
X-ME-Sender: <xms:tSO7ZktrT8wkE5HVBcPZctMGqQN1nQ_HJMzpIhXzcHpbqoSRbUy44g>
    <xme:tSO7ZhctUJPYFwvquVogXYs5IITBynLZZOu8unQGPpT9l5IUe9RUYCkDYY6tnRskx
    rK1dqWd0w6JzynZiA>
X-ME-Received: <xmr:tSO7Zvw0Ojwz-1vi7wLJVVUionIEGKrOT4NrFyfEfKgiO03Tn2eB1bOBnSF2glpRPSNLFs1XeD8SqrBR8FS5mSUwOTrUU0SSW25_U-de51Txvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:tSO7ZnNjlpWvNxx9pBUWzDya9uxYlp-kXb1iDMZrTfSrpsBS-ADjxQ>
    <xmx:tSO7Zk9uqXI1qez2YT_snU5weejCj9YgshYqRC8yKm-1t2BdJlvuRw>
    <xmx:tSO7ZvWN-b7T2h-lTNOgF8vfT9CFLEm7uYQSgJ80e2dab3ueTGKg_A>
    <xmx:tSO7ZtcgRUzYnfC5WP_L76wlehO-sdjmZxnozdJoL7MNKGcoaG9unA>
    <xmx:tSO7ZjbdZzIkaFbJbUovcqyMeWiPn_nRkU51Y_BUukSeE4FgQLXXyPiF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:13:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0889a2c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:13:08 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:13:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/20] path: expose `do_git_common_path()` as
 `repo_common_pathv()`
Message-ID: <2e3f474e5d7df6e8ad676d50f2191a28e580f5fe.1723540226.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
 <cover.1723540226.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540226.git.ps@pks.im>

With the same reasoning as the preceding commit, expose the function
`do_git_common_path()` as `repo_common_pathv()`. While at it, reorder
parameters such that they match the order we have in `repo_git_pathv()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.c | 22 +++++++++++-----------
 path.h |  5 ++++-
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/path.c b/path.c
index 71f1cb4dfb..069db6ff8f 100644
--- a/path.c
+++ b/path.c
@@ -617,16 +617,16 @@ int strbuf_git_path_submodule(struct strbuf *buf, const char *path,
 	return err;
 }
 
-static void do_git_common_path(const struct repository *repo,
-			       struct strbuf *buf,
-			       const char *fmt,
-			       va_list args)
+void repo_common_pathv(const struct repository *repo,
+		       struct strbuf *sb,
+		       const char *fmt,
+		       va_list args)
 {
-	strbuf_addstr(buf, repo->commondir);
-	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
-		strbuf_addch(buf, '/');
-	strbuf_vaddf(buf, fmt, args);
-	strbuf_cleanup_path(buf);
+	strbuf_addstr(sb, repo->commondir);
+	if (sb->len && !is_dir_sep(sb->buf[sb->len - 1]))
+		strbuf_addch(sb, '/');
+	strbuf_vaddf(sb, fmt, args);
+	strbuf_cleanup_path(sb);
 }
 
 const char *git_common_path(const char *fmt, ...)
@@ -634,7 +634,7 @@ const char *git_common_path(const char *fmt, ...)
 	struct strbuf *pathname = get_pathname();
 	va_list args;
 	va_start(args, fmt);
-	do_git_common_path(the_repository, pathname, fmt, args);
+	repo_common_pathv(the_repository, pathname, fmt, args);
 	va_end(args);
 	return pathname->buf;
 }
@@ -645,7 +645,7 @@ void strbuf_git_common_path(struct strbuf *sb,
 {
 	va_list args;
 	va_start(args, fmt);
-	do_git_common_path(repo, sb, fmt, args);
+	repo_common_pathv(repo, sb, fmt, args);
 	va_end(args);
 }
 
diff --git a/path.h b/path.h
index 94e7030f0b..05aff5f4c3 100644
--- a/path.h
+++ b/path.h
@@ -37,6 +37,10 @@ void strbuf_git_common_path(struct strbuf *sb,
 			    const struct repository *repo,
 			    const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
+void repo_common_pathv(const struct repository *repo,
+		       struct strbuf *buf,
+		       const char *fmt,
+		       va_list args);
 
 /*
  * Return a statically allocated path into the main repository's
@@ -45,7 +49,6 @@ void strbuf_git_common_path(struct strbuf *sb,
 const char *git_common_path(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 
-
 /*
  * The `git_path` family of functions will construct a path into a repository's
  * git directory.
-- 
2.46.0.46.g406f326d27.dirty

