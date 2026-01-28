Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D93311946
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590179; cv=none; b=PUn93J4uY/2O0dL70xH1FGKm8kh5ooAjUDCLf6FfbTAmKiTuYQHXOOBdt9DoNLl4OdmN/SFg1dMcUwocaCmP4/MrlmFGVfMgTJyRfVKAVh1pM6UJI3ted66a7iSGeJVzfQTGNfwvsQwSXQuDRvoCpEBkyEVz2TVrKqwBzHBEhmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590179; c=relaxed/simple;
	bh=I8+MyBISlIMgEXWRFKbUIgI7mICut4EUZ/B0/2E4Mus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZUcn1W+WPH2FTauKAHXMMVr37CyEr3IacGpZcOa0GFqiVb6inxMx06qTuFexV0YHf7Xi/tN809R1zxGeneo2SUZSDGcZAFqEq2Fs2G2vr99ahIhTdxh/pBUTknWJk90I/Fw6jQOnsyFN1EtAebb7OBMkDVIiWlL5zCntmqpS2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dQAltA9w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X8LzHJIA; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dQAltA9w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X8LzHJIA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2EE3DEC0184;
	Wed, 28 Jan 2026 03:49:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 28 Jan 2026 03:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769590177;
	 x=1769676577; bh=E5Leae8LV3MhWfuCgKTWyz+f6BY3ELiIiRzIiI44S0I=; b=
	dQAltA9wSZNeah1vwsJqFZuTINW7rB6RH0sbZwRLfWrAGFLq+FwVZGiFKNHZtNLZ
	DEnrk3WB2LeQvr2sQP/BeV8ivTtpA2ZbtQNa6RcVFbjSvfpcB6wT4c5tVTiDLU7Y
	jyF14QSP5E0dcc61i1JhKlRkzA0bi3I5Lw58nCmaqJDbj6OroW3XxhQnKZIioPFx
	bJgjwQgwOj0FAVMT08hZXym/UIdBDk6CsKo3EbFjxgMfiATw0DnB6lDGUOsPJcE2
	sDbunHrUnNGe91lInzkm6LI6hSg47Y2msgpMYPbvNEE7Rj0T1pGeE79V3whDSvEW
	iYXr2N2/bKdLNSQ4qKzWiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769590177; x=
	1769676577; bh=E5Leae8LV3MhWfuCgKTWyz+f6BY3ELiIiRzIiI44S0I=; b=X
	8LzHJIAr6+VYoOrucBy/Kiu93h1a/5iWDobegDTcuZ5eCpGOO4tk2hJnsRhsh2Xr
	bsAqWlC+xpWMBGZPYsSbM4wRw1UA7WPp/y2gyNIIEn523o7pWKARe4MCdi0antpy
	lnROHd70jtvxrles2nBZuFeA1MbpyxpXhFfHE62x+oz360m6HkibHKPQQiX1bepz
	cL+b9xwyB/ei3AXrqV1jzdUWyPH38bxy7zs3RekzPkcMMj22Y6oIihEDH/6XBg+m
	uYqrwdVZolka5jYnGFo9ejv+KMQdCx/qYz8ylmNvXgEaNGgIhslqLos7Oi/w/YIE
	jEwdjEkmRpNMPwiwUap4Q==
X-ME-Sender: <xms:oc15aQnbSVwJtiDOeP749LyRyIoYX3QvmrC_1bARttVPWQw8rox16g>
    <xme:oc15aV34GzmjIJQg0IOo4R4siV_HbVEeSKbPKsD7W0QFsFje0y6qzleKE6-p-BAHi
    ym_8CsKbg2A2xwIyoTnpaxtJyGSE23Dy4g1aTs_UMCbXVo67COnEP0>
X-ME-Received: <xmr:oc15acRDEUJTeH5cRId_9lSHBK_9vzwhKMNrKThrnMZxypUX6ODvSbMHVljLSGxkTe1sPTYsKJe17mpJcBV-vMRfLI8k3J4u4J84-ROOfnE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedvleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:oc15aXs7xjyAUCKXm8rWB2jLHfSToW737HkewoTDD4iskOUJmlbcCQ>
    <xmx:oc15aRZTAmPaQFYxZ_yhVVhW0SA1fULH9jJpTIYdc1T55RhrvyJSsA>
    <xmx:oc15acsPg4jyl-inucg7N0OjkcjU2pRiVK4Ee6laQNstE2Wesym_CA>
    <xmx:oc15aTHOtlQ3C4lmSGqCLkJzxKzcdGYexRz0UVaiGpHNvH27NJCLww>
    <xmx:oc15aavETQ826PUU1xAEwRyKKLJuyYm87kAkEUM-Bap2TvgXY7An1DIe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 03:49:36 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dd081e49 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Jan 2026 08:49:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 Jan 2026 09:49:22 +0100
Subject: [PATCH 3/3] bisect: fix misuse of `refs_for_each_ref_in()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-3-deccae3ea725@pks.im>
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
In-Reply-To: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

All callers of `refs_for_each_ref_in()` pass in a string that is
terminated with a trailing slash to indicate that they only want to see
refs in that specific ref hierarchy. This is in fact a requirement if
one wants to use this function, as the function trims the prefix from
each yielded ref. So if there was a reference that was called
"refs/bisect" as in our example, the result after trimming would be the
empty string, and that's something we disallow.

Fix this by adding the trailing slash.

Furthermore, taking a closer look, we strip the prefix only to re-add it
in `mark_for_removal()`. This is somewhat roundabout, as we can instead
call `refs_for_each_fullref_in()` to not do any stripping at all. Do so
to simplify the code a bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index 326b59c0dc..4f0d1a1853 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1180,7 +1180,7 @@ int estimate_bisect_steps(int all)
 static int mark_for_removal(const struct reference *ref, void *cb_data)
 {
 	struct string_list *refs = cb_data;
-	char *bisect_ref = xstrfmt("refs/bisect%s", ref->name);
+	char *bisect_ref = xstrdup(ref->name);
 	string_list_append(refs, bisect_ref);
 	return 0;
 }
@@ -1191,9 +1191,9 @@ int bisect_clean_state(void)
 
 	/* There may be some refs packed during bisection */
 	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
-	refs_for_each_ref_in(get_main_ref_store(the_repository),
-			     "refs/bisect", mark_for_removal,
-			     (void *) &refs_for_removal);
+	refs_for_each_fullref_in(get_main_ref_store(the_repository),
+				 "refs/bisect/", NULL, mark_for_removal,
+				 &refs_for_removal);
 	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
 	string_list_append(&refs_for_removal, xstrdup("BISECT_EXPECTED_REV"));
 	result = refs_delete_refs(get_main_ref_store(the_repository),

-- 
2.53.0.rc2.206.g60c1bca835.dirty

