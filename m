Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A633F2F691F
	for <git@vger.kernel.org>; Thu, 28 May 2026 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779951662; cv=none; b=OzkpMHqI4NCeuK6uQTA5mO/6dmZjL/NPuUPplwkNB06bF/zEN7MTjfn2OWhMW+RFkwsKjNrrnm/HxgdXeI9FdeJcc3y9C17AU5A+0dSH0+0ow0cKAA4wJ4Spm3FWDUMwQKJaxT5BLeL4qKyvHUwvLftrm/E7CLsLFQDRfNgTUsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779951662; c=relaxed/simple;
	bh=FnKr3sDcCOYwmKhLTh7L1efCvZ9u88PG/UPL2PDf2Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyTVJQjSYxHe5GIWxjN4Zyo2iwFkZ++C/yleFLLrHdhRNtZJ6N0pmuniC930BMh1+6NVC30eLbXOtNU8tSxqmC6PPg7XwpUcjEYtE/2GHsAAr1itkkUhHAI94Ng2dK/yJG3SgvRb/lv5fHQd5m5sbS854DArbkzzsfekqleB5xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HLOg8A3Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AmFKtLBF; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HLOg8A3Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AmFKtLBF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F06507A0078;
	Thu, 28 May 2026 03:01:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 28 May 2026 03:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779951660;
	 x=1780038060; bh=vgYjhXmGgyHyNMeb51JQxhG/NN99JPMnjHKRruyw2Oc=; b=
	HLOg8A3YK1/PR6zYAmQMS3+D+AXdrU9r3gPIyqrfhbTH33xRGXsF0T4RKMecY7qp
	a9MJhkd8Hm1A9MhaDZjepj+E6A2IFhv9pdZhmjXH7QHPK4epgWVCcZPy+UABxXNt
	DxSWyavfAuPslE3HiTkNBNl34vUcOBHWtNuV/x+MqN8LQoh9XZ5fP1PV3YsQQUzo
	wLihwCMPs6tbU3XRBnGfJSGSNpPNh4VfL/I8USyOxA9fmVTsv/Gko8QoEP3HIMN9
	tCRF/YqZk05EYfBcpEjRXMeS5iMajEx0m1INRLkN7c5wu6tUDq9fn88Rr3Up4u6k
	rpLzwii3tzdz7OPHOK24aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779951660; x=
	1780038060; bh=vgYjhXmGgyHyNMeb51JQxhG/NN99JPMnjHKRruyw2Oc=; b=A
	mFKtLBFgElF7oMeJxpJoK6WHCDHW+Mjv6OetS27iN9gvzQ/+5nl8Pyru3uoBtKHb
	nh17DhSZ0pXQZ7yxIKBprJS0oPsKF399ju3WaoafCnPqQ17v14F8OkTLmVQelrR9
	y+IHssWgt9DzDm1/EF9ZhdV+XnE03MRQv5qgUZ/EvAT9pwQSFy+BiOZb5N+5RGV4
	k02c5vMZYz2FOu98L1Pxmj+QZiXnq5MqXYYGWzN/X3AEj4HaYS430D7yJVQiePNW
	NxhKGvDiI0XEbryE67MBAGsAvZcE2W1H1iA4DF3F+vsdYvJpQ0uytL8x0o9qn1Rr
	I9kkMU5DhD7+RDjx1UgiA==
X-ME-Sender: <xms:LOgXarJYYJ65_nx5q2g8lMh9msWUN8m_9193AtLEPBGmNtmvfRoi0c0>
    <xme:LOgXamJw_IGCe3eHaptWCoChLRQjR4D8fB4k8A-dzHL2ywPiyX595g5KfgEdpMcDv
    yaf2o-qGlHI5-zMLUKnDBr8eSohwOnPYj5m0iVRYa_TFmHpbB3yRQ>
X-ME-Received: <xmr:LOgXaovztSlKhIf0wTu1H64e7F7-u2oe8_DMT3YpLp8-Rk0EAmlQhZuqnhZZ0-cTnVT-KifeQbwkQk3kOoWBf56vv1zsHBVHDYRewhE>
X-ME-Proxy-Cause: dmFkZTEH2Rdwx7FKE7iMRW7TdVfz3RH45rhXLGoxngb7PIDg/BCyg6uHQeoxrV7kkiNR1z
    ZCYs+trgGbzOyawDS9A4Nwvk4dmPF+UTnPx97fc7fDMKR69wky+l52cmHKIR+Q2c4RRnhA
    5gp1cVYu+y9jUEYZCzh36M/hkkfX4T0kedXxBAGBcvz4LLcP8j8jbkoi1024d8CyQSyqFo
    ANA76IsGZCAXMLs676I+Z49U8cgoLQwxS6XL1gpQoBTmlmwsgD+gDOXycn5C/nqRJtd4fi
    pGHsIAmtZ5mUnlG7pw+HQ55V6Fw8clvOfpYM2yayL1Gg0K2MkKVzvWYR92epugCwgCrzGN
    ESb7HvM3NZWT3E6rIhFDfQ5JWPeRlp1UnUFTvcVF6CXqsOmrJUsAxe6PUEcOWFq6zUNTL7
    2ihTL0KKGoOYIQV0qW2RXreBhuGgvJlmISORBKeRrFfBzEtcoFuUhemw+b882dD5DWeO/3
    kAcLGYWn+GXhOm3BhTwS2aBSylix3mb7mpolVAEJMKqQDf3dqnuQVsVss+DJGDNgVzWlCZ
    97gONhYUfLqGqPDfQez86DKOQ3rs0xzcGfIEfp8nWQJY1JCJ+ecPoT2NLcSgQX0v0kJ8dP
    SATFJAnExebSWchXa5NYV9pR0hOXe4oHPwZBp/IWHeZ90oGT32lujxRjpyXA
X-ME-Proxy: <xmx:LOgXajSiiyKGPV3tylTylCgmLukCsAS1FBpbmD5c4tDIzxYaw7A4NQ>
    <xmx:LOgXauP9X3aJ3spkh35-NmAc9ycHSO9K3-V7LkgHDBdjVuxd9IE8mQ>
    <xmx:LOgXaoZZ09oXSm2BfyUl0CwP2x6k_94nQUif7Y-HvEuN84x6g9SYPg>
    <xmx:LOgXaoyV3lGG60SoYtnlHdcFV0z54L5oy-FgD_mZJc9F9HBd00fm0w>
    <xmx:LOgXanUJQ_-VD55aWr78-a2nQqbwaP6cSs1pthU-SNEKdkXboG5D0Xs0>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 03:00:59 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: [PATCH v2 1/2] *: replace deprecated free_commit_list
Date: Thu, 28 May 2026 09:00:10 +0200
Message-ID: <V2_commit.h_replace_deprecated.733@msgid.xyz>
X-Mailer: git-send-email 2.54.0.16.g8f27b399cbe
In-Reply-To: <V2_CV_commit.h_remove_deprecated.732@msgid.xyz>
References: <CV_commit.h_remove_deprecated.714@msgid.xyz> <V2_CV_commit.h_remove_deprecated.732@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Replace `free_commit_list` with `commit_list_free`. The former was
deprecated in 9f18d089 (commit: rename `free_commit_list()` to conform
to coding guidelines, 2026-01-15).

This allows us to remove all the deprecated functions in the
next commit:

• `copy_commit_list`
• `reverse_commit_list`
• `free_commit_list`

Acked-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: add ack

 builtin/history.c | 4 ++--
 replay.c          | 2 +-
 upload-pack.c     | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 0fc06fb2045..091465a59e2 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -284,7 +284,7 @@ static int setup_revwalk(struct repository *repo,
 
 		commit_list_insert(original, &from_list);
 		ret = repo_is_descendant_of(repo, head, from_list);
-		free_commit_list(from_list);
+		commit_list_free(from_list);
 
 		if (ret < 0) {
 			ret = error(_("cannot determine descendance"));
@@ -892,7 +892,7 @@ static int split_commit(struct repository *repo,
 	if (index_file.len)
 		unlink(index_file.buf);
 	strbuf_release(&index_file);
-	free_commit_list(parents);
+	commit_list_free(parents);
 	release_index(&index);
 	return ret;
 }
diff --git a/replay.c b/replay.c
index 4ef8abb6077..da531d5bc68 100644
--- a/replay.c
+++ b/replay.c
@@ -120,7 +120,7 @@ static struct commit *create_commit(struct repository *repo,
 out:
 	repo_unuse_commit_buffer(repo, based_on, message);
 	free_commit_extra_headers(extra);
-	free_commit_list(parents);
+	commit_list_free(parents);
 	strbuf_release(&msg);
 	free(author);
 	return (struct commit *)obj;
diff --git a/upload-pack.c b/upload-pack.c
index 9f6d6fe48c8..2bf450ab288 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -886,7 +886,7 @@ static void deepen(struct upload_pack_data *data, int depth)
 					     data->deepen_relative, depth,
 					     SHALLOW, NOT_SHALLOW);
 		send_shallow(data, result);
-		free_commit_list(result);
+		commit_list_free(result);
 	}
 
 	send_unshallow(data);
@@ -900,7 +900,7 @@ static void deepen_by_rev_list(struct upload_pack_data *data,
 	disable_commit_graph(the_repository);
 	result = get_shallow_commits_by_rev_list(argv, SHALLOW, NOT_SHALLOW);
 	send_shallow(data, result);
-	free_commit_list(result);
+	commit_list_free(result);
 	send_unshallow(data);
 }
 
-- 
2.54.0.16.g8f27b399cbe

