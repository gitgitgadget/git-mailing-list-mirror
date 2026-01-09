Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D76350A3D
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947753; cv=none; b=Jf/EIAIVDE0whC+nATEbZha7okNNJFcFcgs33XCpPGpqjS+buPmED0zXyvMJyAXPwkKOFBI8xq4ph+lwTOBgIT/c+mOpJZkR4VOXU79PYb/T+qqmF1SaAl+lxtr3HjnxnWUIiM4OIMAJkO8R+XAz7ojWT9cK7hbOX1H4ZioQKSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947753; c=relaxed/simple;
	bh=q3bUK1Xj+qddPkg/p6VIM+Lws484OMengRkD9zPERas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VQMrqXimWfpeMalc+f9Ly6tGSILYLdQfP4Ypd6f5TUu9cTLiiL50px2pBzTABRtDM7qncMZJIOaNpNIdHrOc8ySTQw4UCWGA7zg1vLw43surMzsg8SDT6MvMQZcYNkfNPVHpKY3EHFSsOOHlJXg61oPFuey1FkznVRsy+3byrbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LiAI0hZJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tG49zY7i; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LiAI0hZJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tG49zY7i"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id D1453EC00BE;
	Fri,  9 Jan 2026 03:35:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Jan 2026 03:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767947751;
	 x=1768034151; bh=XayjS+KOTahc3aQ28u/R6rzPUV+f2Jt0NETYyvYDdBc=; b=
	LiAI0hZJ0DTyFkZlsYPfEUJEa3PNfWxY34BsN/xPGN7qCcRGcbMt7RgfeDEXWz9b
	6n1x+ZApL4vlTBvBT2jvDTUQ+hK2hJMwRZQjbxLGsfY2w5QEVddE9EwxpJishMKJ
	J4ceYrY3M6SGTo4ZnK9it2u7DkUraVUkeeV7g5wKYCua7c/9MiVzA8S9/fz1/5Un
	hQ9KjKvyZkiaVde5/MDrJQ7fuhrxxgm3R9hMZmMvTWoWHol596U98URZW+XqlML/
	kSiX0+dbaycRBTyBpLCORffC1uzVyA8pP7lo6e/LMYg3TcHekuwuTaygWQIDQhCG
	kItbL0FfswNmve3CkTJk/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767947751; x=
	1768034151; bh=XayjS+KOTahc3aQ28u/R6rzPUV+f2Jt0NETYyvYDdBc=; b=t
	G49zY7irzISMKB6Mk/kf3jW5PmRrK3Jh8nrRS/fU8y0XRXgL5WWiJKT+Pfnls9UW
	VjGdQzhlZC1GZnzJbZJ5SVNYmA0NQ7mumfKaefoPDoa+fAJjs2Us0R2jNGTqiI4W
	4NswF62MQ1iooPtT/pAh6Id7t/p2DqrE8LDsubyPkwzOE+ZcX1gx3tAZeuZ1D0s/
	mhb4Km0fpX2lJSxuhYTAhZTFqlawcMY2U98k6RooiwghlotFc7BbOskfe+hBRlVB
	dD6CGHg+d/wilPiBPVtxMILX6Q2BC2gemYWzSWcjVKrwqCYQoUJmsGx8s9uAEulZ
	7aeoVqBygNxhly50UCijQ==
X-ME-Sender: <xms:571gafkCpF4pwzSEePV2Zoa3yiSwt-rKJz730Jaz1Kwaif27k2Be-Q>
    <xme:571gaepkPg84lcGLUI2IjKPaUROcxF9XW1KtgyqtxjGAYscPLig4xYXaT12RjxFOu
    D2x9gjNcynkG6HvcSacDBlIz0BCeCAijtN9MXUVDYR0BuozJpwbFs8>
X-ME-Received: <xmr:571gaRBtREggOdrZnkWpDdI4J52Bg3WVgLV9wDpi0GwU0USl94xPvnZWc7JYeW0LjoKQEiK2062_balNgjs2VxHyQI_LyPP6Yz3kXLclDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivg
    guvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:571gaRENjdy7xXDNzMa3LQmjKVH-QuW51IOJmx6NBndMEare5itzHQ>
    <xmx:571gab1sArITTg8zPPyV4L0CgajI0Vd6cxd6vwjdWueS9JRBquAE6w>
    <xmx:571gaSPs9EfDmf2dRVFYfvj2FrlFxg9GYmLRon0ZGI-UQQOVimHcRA>
    <xmx:571gabYKTYP6ySmW6mASxvgWBkrnI0Q1AiKecjaE1ahZfFqItyONtQ>
    <xmx:571gaamcXMiy-NjDYkppVo0U4bnNmeNxtoP8Kuzcklzjah0uVQsN4sLo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 03:35:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 537201c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 08:35:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 09:35:38 +0100
Subject: [PATCH v9 3/7] replay: small set of cleanups
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-b4-pks-history-builtin-v9-3-8766101814c6@pks.im>
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
In-Reply-To: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Matthias Beyer <mail@beyermatthias.de>
X-Mailer: b4 0.14.3

Perform a small set of cleanups so that the "replay" logic compiles with
"-Wsign-compare" and doesn't use `the_repository` anymore. Note that
there are still some implicit dependencies on `the_repository`, e.g.
because we use `get_commit_output_encoding()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replay.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/replay.c b/replay.c
index fc7186ef09..313fb2a768 100644
--- a/replay.c
+++ b/replay.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
@@ -79,7 +78,7 @@ static struct commit *create_commit(struct repository *repo,
 	obj = parse_object(repo, &ret);
 
 out:
-	repo_unuse_commit_buffer(the_repository, based_on, message);
+	repo_unuse_commit_buffer(repo, based_on, message);
 	free_commit_extra_headers(extra);
 	free_commit_list(parents);
 	strbuf_release(&msg);
@@ -91,16 +90,14 @@ struct ref_info {
 	struct commit *onto;
 	struct strset positive_refs;
 	struct strset negative_refs;
-	int positive_refexprs;
-	int negative_refexprs;
+	size_t positive_refexprs;
+	size_t negative_refexprs;
 };
 
 static void get_ref_information(struct repository *repo,
 				struct rev_cmdline_info *cmd_info,
 				struct ref_info *ref_info)
 {
-	int i;
-
 	ref_info->onto = NULL;
 	strset_init(&ref_info->positive_refs);
 	strset_init(&ref_info->negative_refs);
@@ -122,7 +119,7 @@ static void get_ref_information(struct repository *repo,
 	 * the second because they'd likely just be replaying commits on top
 	 * of the same commit and not making any difference.
 	 */
-	for (i = 0; i < cmd_info->nr; i++) {
+	for (size_t i = 0; i < cmd_info->nr; i++) {
 		struct rev_cmdline_entry *e = cmd_info->rev + i;
 		struct object_id oid;
 		const char *refexpr = e->name;

-- 
2.52.0.542.g9473a8513b.dirty

