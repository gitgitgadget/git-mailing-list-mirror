Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3D051016
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 02:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193167; cv=none; b=GxZPfzLqeYJjgdX9B5uA9mShLiyciPi8ZnpOD+bS37pPAFlzOGtAvT56uSG23e+/wMmglvQjU6JMDBvkSxtDX20jrl1PeRsw0d5eb2/SSDGz2Cr/BY+7Ob/5YFAPJbvDBBUXHBVWbNWgN1aBG90aM5kROR58CEUtQOKDKexadVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193167; c=relaxed/simple;
	bh=wir1irPy3s1I/9PMOJJbT09j88WzHud+YjOKVoOAHI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUXeoZFsZD7qy+w0mxHB6x57sdI9dy3srS7z8BMR3ocgE2MyfLP1B87VTyzDzrsK5lc4kltz4yX9gJZqXt9wq9ikw/OH0XnX/Grnyz86shmKHwQ1OsI68hYYtRxR3/dfj+KrcWLnrWpaRl+zROF2iZxVGb5cVftbotMT9dqmGFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Un9Zjuz1; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Un9Zjuz1"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 671A51140207;
	Mon,  2 Dec 2024 21:32:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Dec 2024 21:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1733193164; x=1733279564; bh=B
	v08ScesoQKnu7df5SJSqv9IPl15lM+th33oD+O8/8I=; b=Un9Zjuz1xnO9GES5y
	Rix1jzS5XKMEMA2jkzkPeA0kSi2l9vX5oIT7fxGxr/KF7gv4wTJmg726xHjk8mwQ
	aBAdrsWndQ045Uss3JkpXQ/2sOSpqQM9oEl01v6ihPD7xQE26K3V6/eINvB2Gn9w
	4rEkjSPrW4sUrqiv2m5H+TWsxfhtas7VMdSMxrDVwdd1iLk3vgbrR9ZoopeAw1D5
	xbIjNEfNmc+TVKyUI1nW94JEh8aUp6WqRQWKL+67DycgFQZmRALWWIPwkQrYBIaK
	cWVzJ2zCB0WU8nyRztN8TzpbcgD+tAc53PVN2iCPZkD1hN/WWxLPGFUZF8Lmnd22
	65a9g==
X-ME-Sender: <xms:zG1OZwPvnJDMacgnUfRFQmBN507iMyEhTMVQTbroTRuCFKOZUtxWEw>
    <xme:zG1OZ2-SSMrqXoylqysvqj3Wss7P97bUYE4LZ8be3DbFuRnDjKZUnFNCig3IZyHnE
    ZvzDZP4gQdItFAFiQ>
X-ME-Received: <xmr:zG1OZ3RrKowN6b0agWF3EpLny4Z9ccI-pQ25QLmOaKg8fYxzoGBQqRXcHEA8IGNOJLfaWxOmwsfKU1ByNNNxXpxdPjPyOAg5_dlSXSo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpedvffelhfeutefgkeettdfhudelffduteelfeei
    ueelhfdvudeiueekhfdtvddukeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithesjhhofihilhdruggvpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehrjhhushhtohesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zG1OZ4tkbbaleK_fnKS8E6idoscoDTdGUyJQIW0N2l2QHS6UPMGpVw>
    <xmx:zG1OZ4d1UGuux0HkyiRKyJV60sypg6G2VAyvq-WIO9bQhk37-RZO5A>
    <xmx:zG1OZ83wM-ay80LAms3CHsZcVMg93Vhbl0DCsEDthaYiwae8e_ootA>
    <xmx:zG1OZ89GD-RC3NUFTeOxlgLzhnmLzl6_i53H85-A7grY-0Imrz6uYw>
    <xmx:zG1OZ9GfoCwS5dPe4cXshUFiwjMFWa37v8DvyLap425eLG15dO-TwGf6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 21:32:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: git@jowil.de,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>
Subject: [PATCH v2 1/4] refs: move ref name helpers around
Date: Tue,  3 Dec 2024 11:32:37 +0900
Message-ID: <20241203023240.3852850-2-gitster@pobox.com>
X-Mailer: git-send-email 2.47.1-515-g5132b7d2ef
In-Reply-To: <20241203023240.3852850-1-gitster@pobox.com>
References: <20241203023240.3852850-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strbuf_branchname(), strbuf_check_{branch,tag}_ref() are helper
functions to deal with branch and tag names, and the fact that they
happen to use strbuf to hold the name of a branch or a tag is not
essential.  These functions fit better in the refs API than strbuf
API, the latter of which is about string manipulations.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/tag.c | 11 -----------
 object-name.c | 36 ------------------------------------
 refs.c        | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 refs.h        | 29 +++++++++++++++++++++++++++++
 strbuf.h      | 22 ----------------------
 5 files changed, 76 insertions(+), 69 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 93d10d5915..8279dccbe0 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -447,17 +447,6 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
-{
-	if (name[0] == '-')
-		return -1;
-
-	strbuf_reset(sb);
-	strbuf_addf(sb, "refs/tags/%s", name);
-
-	return check_refname_format(sb->buf, 0);
-}
-
 int cmd_tag(int argc,
 	    const char **argv,
 	    const char *prefix,
diff --git a/object-name.c b/object-name.c
index c892fbe80a..9f2ae164e4 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1734,42 +1734,6 @@ int repo_interpret_branch_name(struct repository *r,
 	return -1;
 }
 
-void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
-{
-	int len = strlen(name);
-	struct interpret_branch_name_options options = {
-		.allowed = allowed
-	};
-	int used = repo_interpret_branch_name(the_repository, name, len, sb,
-					      &options);
-
-	if (used < 0)
-		used = 0;
-	strbuf_add(sb, name + used, len - used);
-}
-
-int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
-{
-	if (startup_info->have_repository)
-		strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
-	else
-		strbuf_addstr(sb, name);
-
-	/*
-	 * This splice must be done even if we end up rejecting the
-	 * name; builtin/branch.c::copy_or_rename_branch() still wants
-	 * to see what the name expanded to so that "branch -m" can be
-	 * used as a tool to correct earlier mistakes.
-	 */
-	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
-
-	if (*name == '-' ||
-	    !strcmp(sb->buf, "refs/heads/HEAD"))
-		return -1;
-
-	return check_refname_format(sb->buf, 0);
-}
-
 void object_context_release(struct object_context *ctx)
 {
 	free(ctx->path);
diff --git a/refs.c b/refs.c
index 5f729ed412..59a9223d4c 100644
--- a/refs.c
+++ b/refs.c
@@ -697,6 +697,53 @@ static char *substitute_branch_name(struct repository *r,
 	return NULL;
 }
 
+void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
+{
+	int len = strlen(name);
+	struct interpret_branch_name_options options = {
+		.allowed = allowed
+	};
+	int used = repo_interpret_branch_name(the_repository, name, len, sb,
+					      &options);
+
+	if (used < 0)
+		used = 0;
+	strbuf_add(sb, name + used, len - used);
+}
+
+int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
+{
+	if (startup_info->have_repository)
+		strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
+	else
+		strbuf_addstr(sb, name);
+
+	/*
+	 * This splice must be done even if we end up rejecting the
+	 * name; builtin/branch.c::copy_or_rename_branch() still wants
+	 * to see what the name expanded to so that "branch -m" can be
+	 * used as a tool to correct earlier mistakes.
+	 */
+	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
+
+	if (*name == '-' ||
+	    !strcmp(sb->buf, "refs/heads/HEAD"))
+		return -1;
+
+	return check_refname_format(sb->buf, 0);
+}
+
+int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
+{
+	if (name[0] == '-')
+		return -1;
+
+	strbuf_reset(sb);
+	strbuf_addf(sb, "refs/tags/%s", name);
+
+	return check_refname_format(sb->buf, 0);
+}
+
 int repo_dwim_ref(struct repository *r, const char *str, int len,
 		  struct object_id *oid, char **ref, int nonfatal_dangling_mark)
 {
diff --git a/refs.h b/refs.h
index 108dfc93b3..f19b0ad92f 100644
--- a/refs.h
+++ b/refs.h
@@ -180,6 +180,35 @@ int repo_dwim_log(struct repository *r, const char *str, int len, struct object_
  */
 char *repo_default_branch_name(struct repository *r, int quiet);
 
+/*
+ * Copy "name" to "sb", expanding any special @-marks as handled by
+ * repo_interpret_branch_name(). The result is a non-qualified branch name
+ * (so "foo" or "origin/master" instead of "refs/heads/foo" or
+ * "refs/remotes/origin/master").
+ *
+ * Note that the resulting name may not be a syntactically valid refname.
+ *
+ * If "allowed" is non-zero, restrict the set of allowed expansions. See
+ * repo_interpret_branch_name() for details.
+ */
+void strbuf_branchname(struct strbuf *sb, const char *name,
+		       unsigned allowed);
+
+/*
+ * Like strbuf_branchname() above, but confirm that the result is
+ * syntactically valid to be used as a local branch name in refs/heads/.
+ *
+ * The return value is "0" if the result is valid, and "-1" otherwise.
+ */
+int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
+
+/*
+ * Similar for a tag name in refs/tags/.
+ *
+ * The return value is "0" if the result is valid, and "-1" otherwise.
+ */
+int strbuf_check_tag_ref(struct strbuf *sb, const char *name);
+
 /*
  * A ref_transaction represents a collection of reference updates that
  * should succeed or fail together.
diff --git a/strbuf.h b/strbuf.h
index 003f880ff7..4dc05b4ba7 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -637,28 +637,6 @@ static inline void strbuf_complete_line(struct strbuf *sb)
 	strbuf_complete(sb, '\n');
 }
 
-/*
- * Copy "name" to "sb", expanding any special @-marks as handled by
- * repo_interpret_branch_name(). The result is a non-qualified branch name
- * (so "foo" or "origin/master" instead of "refs/heads/foo" or
- * "refs/remotes/origin/master").
- *
- * Note that the resulting name may not be a syntactically valid refname.
- *
- * If "allowed" is non-zero, restrict the set of allowed expansions. See
- * repo_interpret_branch_name() for details.
- */
-void strbuf_branchname(struct strbuf *sb, const char *name,
-		       unsigned allowed);
-
-/*
- * Like strbuf_branchname() above, but confirm that the result is
- * syntactically valid to be used as a local branch name in refs/heads/.
- *
- * The return value is "0" if the result is valid, and "-1" otherwise.
- */
-int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
-
 typedef int (*char_predicate)(char ch);
 
 void strbuf_addstr_urlencode(struct strbuf *sb, const char *name,
-- 
2.47.1-515-g5132b7d2ef

