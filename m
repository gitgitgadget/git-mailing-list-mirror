Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2A93451B0
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770364215; cv=none; b=UlF67c3lTAghjJxsrtklybX7R+iCtCFC6dx/6Fm/U+t/wEw8tA5BaqMuLm89BBg2mNGqsDd6Pw4G5Q3uYbq0kSPhL8hQm/bL/PVFIt6+W3Q4T6KR8O6RNp/xzchzNndGgK4HNN3lzsrfY5igFVfBJvP98vDdPRVLaQ7tnJVGsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770364215; c=relaxed/simple;
	bh=JqGZkDva/JwmPAnAWROpzC7UtPxINCmKntlSahiKKz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KcVqbuZm9Ecjz4MqU5RuJbKwdmfzy28REqb6sCm2rioJ/2wnWjQWsnHkMnjYMCXqKuefI3o2NYNotwGb5doC2mclvrgVkayCbjJqS2rTi6xPd9qlMioDusHz9jtFC/pBosKMVjhKsB9c8kIQA9lBKEIJzxg25Y/61B3zE3c8Iq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OpYbn69Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jvjpk0qt; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OpYbn69Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jvjpk0qt"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BFB877A0137;
	Fri,  6 Feb 2026 02:50:14 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Feb 2026 02:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770364214;
	 x=1770450614; bh=khCG9c8LeWaAWT6WZ57yGYADaqpoWM9+d4e/VzvI4Ak=; b=
	OpYbn69YwpR6iSpf3FutExXpG7iZ0qJSUPQQ/1Zf2L49ZA7FnZrJBmrls23P6jUX
	dSLhLphJaYveGJrvY3TpWPgq4r1oJ8tsg+CO8IZo/DZBAzS5duodwrfBjINoHSQK
	vvsv9m8snHHt5biIlIKk4lq5yzkm/Cx7HOvwiA487Vnr6K9unCzGytGplgp6JBAD
	EZ71/k7Hyhdvv3cMbxsAN7Ek6U6rpoidgzMxcPDmRK//+UTb39QgZmuWS9Yd6/UM
	k1yHn0kXc4uqR+lJMNgS742RivcIfsf52sSy8kMaKFVi+iQMyg+xcW5oyBJkANeD
	e3Ycl+hDk/QCTOOQzUkwJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770364214; x=
	1770450614; bh=khCG9c8LeWaAWT6WZ57yGYADaqpoWM9+d4e/VzvI4Ak=; b=J
	vjpk0qtQdiICpZm+XGz36LNlVgWI4QfdSy2eWeuNnYtHZVFpKKP9dm0y0zOIhnRm
	Azf6i9V21+nCbJHBFCqHQE3hhwrsPG8tQ/TriMGxYFhHbx5MlnWl06wd0sRb0xdO
	i8qTPnBczT81vg5c/l8jr3in6H8dR2oTmeLaA68Ypa7eSb8P+Gw0poiUEPr8IG4A
	GlDCe+zw8uRzNEHeprfK/qCaBKqwSLmyPfSdbwt9XpNyEMu4lMhn2FjjVGjIFTGC
	LhNyd9yxPmaJ3sbgBQrZvTDN5888fcB95zcJ5XCORurrqGjO7USKc2ZXUU0s6XeW
	GMULblyLAObgsW35aaegQ==
X-ME-Sender: <xms:Np2FaVdtcXNlgCPTmMoLoysTWudoA29Yj-CA48pmYawjG3ADUR4jfQ>
    <xme:Np2FaaN46rDvjz2GDkCqsVm4TtWHkhK-BziY81Qzkpg6TLrBSVliF683Iwxaz1qhM
    XBh_P2Jr5yh9LQaIVczEKxs7wEddOGV6JiVabWG_1M3m_rxYMZcuw>
X-ME-Received: <xmr:Np2FaTjdZfrc34UmgzgXteNmCsDDVHzRuXgq0Epu-R2L4mu9O0ZBidxCbL7S3wMPu6sdCJc998SazFDUA6d1bYN8FYsu1rNQS_33-jh0XeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeejieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:Np2Fad2O33q64VtPCXlg0taJsJFPI0PsIUGr4C1kWV7lrdfaciFIZw>
    <xmx:Np2FadiXhzLlDMmzEKABa18aCphO33rfT2Cg45zHzlAxAMkudm0RfA>
    <xmx:Np2FadcE3u_QYlhrlCqiE_TfY8koaXMJywdarTYwttgDhAnusk8LcQ>
    <xmx:Np2FaQlNAAozvT9y3AMOxjw2_EFpnekAwFEZFUcht9ddjJX27vrcVg>
    <xmx:Np2FaXC51IuuRNgP5ci7cRFHmst4hlbJeJ3FwhTRoSbWuDA_haAzbgz6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 02:50:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d78f5ac9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 07:50:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Feb 2026 08:49:59 +0100
Subject: [PATCH v3 4/4] bisect: simplify string_list memory handling
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-4-1e050c3d6a50@pks.im>
References: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im>
In-Reply-To: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

From: Jeff King <peff@peff.net>

We declare the refs_for_removal string_list as NODUP, forcing us to
manually allocate strings we insert. And then when it comes time to
clean up, we set strdup_strings so that string_list_clear() will free
them for us.

This is a confusing pattern, and can be done much more simply by just
declaring the list with the DUP initializer in the first place.

It was written this way originally because one of the callsites
generated the item using xstrfmt(). But that spot switched to a plain
xstrdup() in the preceding commit. That means we can now just let the
string_list code handle allocation itself.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/bisect.c b/bisect.c
index 4f0d1a1853..268f5e36f8 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1180,8 +1180,7 @@ int estimate_bisect_steps(int all)
 static int mark_for_removal(const struct reference *ref, void *cb_data)
 {
 	struct string_list *refs = cb_data;
-	char *bisect_ref = xstrdup(ref->name);
-	string_list_append(refs, bisect_ref);
+	string_list_append(refs, ref->name);
 	return 0;
 }
 
@@ -1190,16 +1189,15 @@ int bisect_clean_state(void)
 	int result = 0;
 
 	/* There may be some refs packed during bisection */
-	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
+	struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
 	refs_for_each_fullref_in(get_main_ref_store(the_repository),
 				 "refs/bisect/", NULL, mark_for_removal,
 				 &refs_for_removal);
-	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
-	string_list_append(&refs_for_removal, xstrdup("BISECT_EXPECTED_REV"));
+	string_list_append(&refs_for_removal, "BISECT_HEAD");
+	string_list_append(&refs_for_removal, "BISECT_EXPECTED_REV");
 	result = refs_delete_refs(get_main_ref_store(the_repository),
 				  "bisect: remove", &refs_for_removal,
 				  REF_NO_DEREF);
-	refs_for_removal.strdup_strings = 1;
 	string_list_clear(&refs_for_removal, 0);
 	unlink_or_warn(git_path_bisect_ancestors_ok());
 	unlink_or_warn(git_path_bisect_log());

-- 
2.53.0.239.g8d8fc8a987.dirty

