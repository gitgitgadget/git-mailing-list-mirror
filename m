Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13B535BDDE
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 09:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469766; cv=none; b=E4iPv/mY86nY7Q1RRD54vfqsasubtDcr+faYWbulhaIk3RJX7CkTJmd27f3Q+HGFg7on53AIcF3JhZYj8xXl0ycaCAwXKZeGGMNfQ2ORZ4a/B5RJCyRchB9TEoiC9lMFUJsPCyUebgk6FS3rFRfyHuHLJeZzvDijFyyoW9a6lFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469766; c=relaxed/simple;
	bh=6OjeReyPWRWXKVnRLmpIBPMNMYc7bZwZEDe7IKjmoE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=klTIKmJioOBEU+L2pQSqN4sVZSNPHdT9HJkNrvhtECnUJdtNqSr88pDo3PxTf3JM5Zi04hNm/Ej8RoLRP1xku8qgKgUKCFSqv8tku1L2245R08Ry57d6JWGv+2aCAzbk0vXuBQdk1lcUcnY1aifRYBjnmkuLmXPkjROieg8Msns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jVsy/I2H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BdXxxCkt; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jVsy/I2H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BdXxxCkt"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F150C7A0081
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 04:36:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 15 Jan 2026 04:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768469763;
	 x=1768556163; bh=+n8VY3FatFfnmGHh8yzJFv8wLQ2NxASXMLDyF3ZAqFI=; b=
	jVsy/I2Hmc/h78PpYxfFmozv+6Lgp9TmphTZ/W/gJsn5mPhLn4LE/FiFl4Yh1zB2
	zrC/laxgqCvqm3iQY2ED0yjAXFeCgVahJMdICn84GFS6UyLiG0yu4guAQfQNCidw
	Q8klDJB8TZo0z++VNY8Y1LXWTWvq/bWrBB6LK3ZR97PAA67oK1NNA9S+RvaH0uNq
	6HbWJ2+UsyrBzssgJqn/ndu7omEGBL+2niK9KRWRs7zZOAOuFQ1lekt/uTJNIKGO
	1Gg0pc43nmBD2gqVtmeipyD7wHHVoN3+iZwJ13n3ArWmYYc0GGs87K+x4uCaZETy
	7AOPMIhCNAp3UOOiJ/z3Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768469763; x=
	1768556163; bh=+n8VY3FatFfnmGHh8yzJFv8wLQ2NxASXMLDyF3ZAqFI=; b=B
	dXxxCkttPn0KITwmZ+qbDey4ARCnadzefbfrSl4G21t9ilpIPeVvqXwtMNwS8bQu
	58dCl84h0ZVC0F8wWqV+k45oNMPn7cDKr7wtNiuPIO810tNM8jLRKq/OQEFAija2
	Q9+6TyDwdagdqRsK939uAgJqaAQRrscD12hLLEQzMTKsyvzx2v40rjQlogUr7zss
	rWSVQHZnUOHYV3XFbLjXrI6l6Ab3wt5u4YNzJEC2eF9VxTvPMfhH68Jz951cAIGl
	SS6vr9PDDNHMc9QeiU3zsxhPYKmFVtbyzHPO5RCtKuT+oepB6iT/wQwraAxASkm/
	KdqBhgDigJY+0BxtW+tjg==
X-ME-Sender: <xms:A7VoabZa3p2j7fPanB-zw2MopNTnuatvMVYM2e3ONfj6GnboEiISsg>
    <xme:A7VoaRU4lBf94lepWC1t961LTkYg11K59evNyfPR5hf3GLPD6JyGBdrbgnA0mfAVt
    ztIsAuWckbfhwtUotOZ7Wm2Tu-8Qv8I-K3Cp9MHkA_Se0-r-4j-DJ4>
X-ME-Received: <xmr:A7VoaTkq_ZlPCAvywyfUxVvz8qvE_BAV84SvjAURUbpV-hRV4KuzwrfyIAsEYstTXfGNP0KXlSlzQlDspTFcR2_db-ojKq2iq1oOIOY_YI9b5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:A7VoaWyxu8f2HnFVvOafQHjzMc2mrHggcIUAXN7fnuJYrD7WGibGAQ>
    <xmx:A7VoaWiIBoV5VmC3uluKQiYPO-0j3-TEcPgQnhgXu3hjgMZGo2qr5A>
    <xmx:A7VoaTVx4DPUIN05B2tDC7j3qSg-QfMW7q6XTss82E3oOfBoT5a-Rw>
    <xmx:A7VoaQ3bIB5y0Q0GCzI5eeLpunBZllMe7TIXU7qQr2-JNxzFmsf9Aw>
    <xmx:A7Voad4z73R8fyMOY3VNQ_mBgbbY4qnhsDlNrBAl2-W--Pne8pmZopYG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 04:36:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97a8605f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 09:36:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Jan 2026 10:35:32 +0100
Subject: [PATCH 1/3] commit: rename `copy_commit_list()` to conform to
 coding guidelines
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pks-commit-list-coding-guidelines-v1-1-c58868dbf412@pks.im>
References: <20260115-pks-commit-list-coding-guidelines-v1-0-c58868dbf412@pks.im>
In-Reply-To: <20260115-pks-commit-list-coding-guidelines-v1-0-c58868dbf412@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Our coding guidelines say that:

  Functions that operate on `struct S` are named `S_<verb>()` and should
  generally receive a pointer to `struct S` as first parameter.

While most of the functions related to `struct commit_list` already
follow that naming schema, `copy_commit_list()` doesn't.

Rename the function to address this and adjust all of its callers. Add a
compatibility wrapper for the old function name to ease the transition
and avoid any semantic conflicts with in-flight patch series. This
wrapper will be removed once Git 2.53 has been released.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit.c |  2 +-
 commit.c         |  2 +-
 commit.h         | 11 ++++++++++-
 merge-ort.c      |  2 +-
 revision.c       |  4 ++--
 sequencer.c      |  2 +-
 6 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0243f17d53..0aa3690b04 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1849,7 +1849,7 @@ int cmd_commit(int argc,
 	} else if (amend) {
 		if (!reflog_msg)
 			reflog_msg = "commit (amend)";
-		parents = copy_commit_list(current_head->parents);
+		parents = commit_list_copy(current_head->parents);
 	} else if (whence == FROM_MERGE) {
 		struct strbuf m = STRBUF_INIT;
 		FILE *fp;
diff --git a/commit.c b/commit.c
index efd0c02683..c5c66d3a6b 100644
--- a/commit.c
+++ b/commit.c
@@ -680,7 +680,7 @@ unsigned commit_list_count(const struct commit_list *l)
 	return c;
 }
 
-struct commit_list *copy_commit_list(const struct commit_list *list)
+struct commit_list *commit_list_copy(const struct commit_list *list)
 {
 	struct commit_list *head = NULL;
 	struct commit_list **pp = &head;
diff --git a/commit.h b/commit.h
index 79a761c37d..2faf08cd18 100644
--- a/commit.h
+++ b/commit.h
@@ -186,13 +186,22 @@ struct commit_list *commit_list_insert_by_date(struct commit *item,
 void commit_list_sort_by_date(struct commit_list **list);
 
 /* Shallow copy of the input list */
-struct commit_list *copy_commit_list(const struct commit_list *list);
+struct commit_list *commit_list_copy(const struct commit_list *list);
 
 /* Modify list in-place to reverse it, returning new head; list will be tail */
 struct commit_list *reverse_commit_list(struct commit_list *list);
 
 void free_commit_list(struct commit_list *list);
 
+/*
+ * Deprecated compatibility functions for `struct commit_list`, to be removed
+ * once Git 2.53 is released.
+ */
+static inline struct commit_list *copy_commit_list(struct commit_list *l)
+{
+	return commit_list_copy(l);
+}
+
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 
 const char *repo_logmsg_reencode(struct repository *r,
diff --git a/merge-ort.c b/merge-ort.c
index 2b837a58c3..f31754c361 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5301,7 +5301,7 @@ static void merge_ort_internal(struct merge_options *opt,
 			       struct commit *h2,
 			       struct merge_result *result)
 {
-	struct commit_list *merge_bases = copy_commit_list(_merge_bases);
+	struct commit_list *merge_bases = commit_list_copy(_merge_bases);
 	struct commit *next;
 	struct commit *merged_merge_bases;
 	const char *ancestor_name;
diff --git a/revision.c b/revision.c
index 1858e093ee..9f5baceb85 100644
--- a/revision.c
+++ b/revision.c
@@ -4224,7 +4224,7 @@ static void save_parents(struct rev_info *revs, struct commit *commit)
 	if (*pp)
 		return;
 	if (commit->parents)
-		*pp = copy_commit_list(commit->parents);
+		*pp = commit_list_copy(commit->parents);
 	else
 		*pp = EMPTY_PARENT_LIST;
 }
@@ -4294,7 +4294,7 @@ static void track_linear(struct rev_info *revs, struct commit *commit)
 			commit->object.flags |= TRACK_LINEAR;
 	}
 	free_commit_list(revs->previous_parents);
-	revs->previous_parents = copy_commit_list(commit->parents);
+	revs->previous_parents = commit_list_copy(commit->parents);
 }
 
 static struct commit *get_revision_1(struct rev_info *revs)
diff --git a/sequencer.c b/sequencer.c
index 71ed31c774..f38d247b10 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1566,7 +1566,7 @@ static int try_to_commit(struct repository *r,
 			res = error(_("unable to parse commit author"));
 			goto out;
 		}
-		parents = copy_commit_list(current_head->parents);
+		parents = commit_list_copy(current_head->parents);
 		extra = read_commit_extra_headers(current_head, exclude_gpgsig);
 	} else if (current_head &&
 		   (!(flags & CREATE_ROOT_COMMIT) || (flags & AMEND_MSG))) {

-- 
2.52.0.660.gd05f3a8ea5.dirty

