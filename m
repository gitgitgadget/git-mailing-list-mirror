Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D55187552
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540410; cv=none; b=WkOqKnqVrr9vrvO5OAwRTNnoosvrQfBCJazExMvJ3lV5jjUHsTNUTkB28FKpc5xVsFidYEQJKAo1jxG9fQrdqP1V7H7TwQ1YDq3Be1m8qgkGWW2hq7z1BBNKnqZpeiqS0CYNdXa9e190B6pRj9la0VPE2pqctWIx40NDTtB8mPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540410; c=relaxed/simple;
	bh=eTd85LiwD/0TYRbbrdMNzi9XlLbGBR9kiqF7Ddi1k5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ch5rBSso6jlFKLcQCl36PSzUbUgzxC0k6UOs6AhfmEnLw6AZRpS3uko4uIzq5cXn/sZ2+bHtGdSX1GxwEQpzuwiWqTs+ctD8AX8dJBwoBiHBLcjug/5AuN6KUjl3nakdYDXz56ILpvh6+KH+gtMHJCWo75wJmZlmo3NVaucl7s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S+DQH1Ml; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U9xOaiUb; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S+DQH1Ml";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U9xOaiUb"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 941C7138FD24;
	Tue, 13 Aug 2024 05:13:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 Aug 2024 05:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540408; x=1723626808; bh=DYLiJD/qLN
	W3wxiUFB7QyIpwwmvInSS5N9yItzMJcK0=; b=S+DQH1MloK/XYPkYM+Vq+pFV9h
	d5b7tp8I0p0eFI5OrekT/Dir+uR6BTP4XAM+fMrda/5b2j/85t1WZWZ0whGBVWuh
	a9jQeXaJK9By8R1DQq5etx4N/gLfw22/aKqiMEVEAdE7pwTocyWMP6wVCtdTm20s
	Idd0d8eDCIoHFqxcAgO0eF/FHfTHAn1rmytNgmh3RjLOftzPbmiVLDmTiiVTs01s
	QlRiFA6Ik+C1T7KoyQg06lWoDqn1mAZoU4Vgd10xDe77Yqk81FX9OkE/fwOLSXQB
	bzmRLnuuU9cB98nO2zi+qVcVFi5/X4Kn72i5tL2ar3CRIrVujpnohb0+vUoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540408; x=1723626808; bh=DYLiJD/qLNW3wxiUFB7QyIpwwmvI
	nSS5N9yItzMJcK0=; b=U9xOaiUbOhBdR+G17AzY5kI121iJfZsmqOk0vExc/XXf
	YlcXC1b1u1aTeRYEzUs4xSqNv7qFFCd4uIY6B/odTm0BWnPPablmi0FGaH/45E91
	PBN8++PPC6eTC7yNAAu2jarF8YeqCNe0+z/ZJNnvqeLjV5P5OaVOZ5JRVrLU1eP7
	qSWf6cTBXu3QBUcUnfNHUDJ8yWylPAGXjk5IoSAXcbmdeVV6Ur6XWLjFuh7gTDMP
	AHhD91bvb8RKr3itYI76zxJcQL7OmMJ0t/5X6thafGP5p02Ujn/oGaxJ0Ex37Cg8
	/GejAdlKqnHjcnD1YtqzVLrdPc4nwNCocRAjylxSuQ==
X-ME-Sender: <xms:uCO7Zpf0J8ZD_dNTSllqwHaDLe9haAaj4P8-dMGClFk0XI8DeJ8CNg>
    <xme:uCO7ZnPq7PmyX7OE-0R6ztVRvwpDXHAjCPCn7SF7bDfKChdywjHMxV0-Fgx9YAbvS
    FfTRSB0EUZ-Y45anQ>
X-ME-Received: <xmr:uCO7Zih95xfePQRom-coJKXMPVnW5Jmv77y6-I9sjxbXLK3FRuEAFGRf8Wk9CifI-byGXg5m-s9Q98pXouYWTbSTLYUiq4nKCveD0FoEz1XLEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:uCO7Zi-mxX1FL63iiGpchbzjSotwgrrtx_oeSPslolpIGDjavB2yHg>
    <xmx:uCO7ZlvADVK6w9_rAhC3R7HIvWrYxmII73DQgmmRzD_AzITuS3MFYw>
    <xmx:uCO7ZhFFdwntCHPR8AYstNE8pOxD7uEY_odw4rwhvoYWknvyRroA1g>
    <xmx:uCO7ZsM_HwwIVEio8TIdf1mLO8X-T-YFhnqiezO6xAI5qU23coPSLA>
    <xmx:uCO7ZtLbYrw2xzwojMusGumPoulT1WYOXG9eWFS46uqg6rQcpQTN92wW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:13:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b19166f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:13:10 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:13:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/20] editor: do not rely on `the_repository` for
 interactive edits
Message-ID: <2f73e0efcd4304d191636edf662564dabc48e18c.1723540226.git.ps@pks.im>
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

We implicitly rely on `the_repository` when editing a file interactively
because we call `git_path()`. Adapt the function to instead take a
`struct repository` as a parameter so that we can remove this hidden
dependency.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-patch.c |  3 ++-
 editor.c    | 13 ++++++++-----
 editor.h    |  5 +++--
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 46f6bddfe5..218dda3e79 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1140,7 +1140,8 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 				"removed, then the edit is\n"
 				"aborted and the hunk is left unchanged.\n"));
 
-	if (strbuf_edit_interactively(&s->buf, "addp-hunk-edit.diff", NULL) < 0)
+	if (strbuf_edit_interactively(the_repository, &s->buf,
+				      "addp-hunk-edit.diff", NULL) < 0)
 		return -1;
 
 	/* strip out commented lines */
diff --git a/editor.c b/editor.c
index d1ba2d7c34..e93b4fdb09 100644
--- a/editor.c
+++ b/editor.c
@@ -133,14 +133,17 @@ int launch_sequence_editor(const char *path, struct strbuf *buffer,
 	return launch_specified_editor(git_sequence_editor(), path, buffer, env);
 }
 
-int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
+int strbuf_edit_interactively(struct repository *r,
+			      struct strbuf *buffer, const char *path,
 			      const char *const *env)
 {
-	char *path2 = NULL;
+	struct strbuf sb = STRBUF_INIT;
 	int fd, res = 0;
 
-	if (!is_absolute_path(path))
-		path = path2 = xstrdup(git_path("%s", path));
+	if (!is_absolute_path(path)) {
+		strbuf_repo_git_path(&sb, r, "%s", path);
+		path = sb.buf;
+	}
 
 	fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 	if (fd < 0)
@@ -157,6 +160,6 @@ int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
 		unlink(path);
 	}
 
-	free(path2);
+	strbuf_release(&sb);
 	return res;
 }
diff --git a/editor.h b/editor.h
index 8016bb5e00..f1c41df378 100644
--- a/editor.h
+++ b/editor.h
@@ -1,6 +1,7 @@
 #ifndef EDITOR_H
 #define EDITOR_H
 
+struct repository;
 struct strbuf;
 
 const char *git_editor(void);
@@ -28,7 +29,7 @@ int launch_sequence_editor(const char *path, struct strbuf *buffer,
  *
  * If `path` is relative, it refers to a file in the `.git` directory.
  */
-int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
-			      const char *const *env);
+int strbuf_edit_interactively(struct repository *r, struct strbuf *buffer,
+			      const char *path, const char *const *env);
 
 #endif
-- 
2.46.0.46.g406f326d27.dirty

