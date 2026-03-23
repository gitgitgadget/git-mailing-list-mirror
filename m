Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33442280CD2
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278215; cv=none; b=rHZjvxYHvPqkjxDEJFvsLw9JwZ6EJ/G5XOIj9rmIFLeQ0Xkq+IR3ZfLc3dMaXGcopY0lb7IkMIZ4i+mCiqskg9529RI3f283Zjmu2hN010fOaGHEXKR4W93V/4pituOS4ExLdvxh3L5GESplVaCuKS/cccJduQd7pWi2JnxksYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278215; c=relaxed/simple;
	bh=qLAH9tA3UU1p/IlF8rIna3/bLZC21XqTpq2OK1aCnL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e/GZkmQMhC07ELkhq8ZDSCNhDQNJF8cWLrvORS1U+JQq1DYV3LjWtCtAVegylVnIkSqBqWnGoSRGbZ5ciltMPTQfUzBo045U/NFGUWxE3HDUTR0ktWE8Hd/VeU1lxt1ZnRKlWYwjM+5VqHQbbIgBbKi+YIok4lmeuf/d2yxJLPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Su5Mtk8Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gz8mYpBz; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Su5Mtk8Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gz8mYpBz"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 884741D001C1;
	Mon, 23 Mar 2026 11:03:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 23 Mar 2026 11:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774278213;
	 x=1774364613; bh=YyRbVxbQ25adYpzT/Hh9asWg5Yv3fnCIUfWxZxj+ga8=; b=
	Su5Mtk8YRWjwaqzNt7JfPCbLnNY7jkDe+pbgjFmawC9SgJ+M7CxI0E5RDdxc1mtC
	PesUSfTfEt10kLlf49ygIGQQKar2412MNqB58/qom7krt7N1mWyRuFRGO/BYF9HH
	oU5CLaF1vb14cnGNi/iM1IRlyHHyYGhzGOIJ/A2EIPgK0w02aZcCAGx6Iyi2Ew5z
	XiQ9aPgE9UJHTZk2nMHvD5EveD9Q8KNxjdCDJMgt8Aj+qhiSXX9U89MON5baP5Qk
	Zz7MIczuVjLOWRrIIO9bFrU+yZDaTXad3MY5SkPrr9cTj0kyAjLpah87jEa4aD+l
	ZjOXubJq/NZ0HEMSZp4+VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774278213; x=
	1774364613; bh=YyRbVxbQ25adYpzT/Hh9asWg5Yv3fnCIUfWxZxj+ga8=; b=G
	z8mYpBzEa4VFYrpQvlMZHCIYYvPiMB4/a5GXX4/6wDuSV5SrGWIppCIKBlsRxKRs
	uAzq7MfI0oY42bg4MYnkpFktbKOsZjBKWleIDqQirRQQLKFY+fBQMm8wr2IXfJbV
	g3wiwvnCqiuH9oLtSinhuyJo9+fYI16BeNbAoUyxtUKr6uNQgTUUVcnpbSt5kMLK
	sVVk2ndim1cPeyts1cmHHn+ycXxl83KLELPMbk/tCoJraT9FOhtB4/qJkoUdrbZh
	ZgZzRDvDfcIjo+1NoLJxWdTLnlVSwA5JrVcGxtLdJP+voHj2OgMRs+XImXGfcZMZ
	9ayNkXtaNy87AAsm0UMRA==
X-ME-Sender: <xms:RVbBaV8CFObCYNdUbijAZXpI1__QaBBvZzH06o7S0Ad9MOjCHcH6KA>
    <xme:RVbBafv7zVpP4lH53-zXOsmMjgkWlKOKe_gr4fi0CszbLUVPQNTeUTOYsHQCcZW2s
    1jMBeosL4jJ7lPJwE79qSYmx49h4S2hgGLUVdaMFqhbGqk9ftvZZA>
X-ME-Received: <xmr:RVbBaQrCxOOI3aNK2BhtPxjxpchgUsfOsYW_d9Tp6r4AgbPAiQy3DL2m94j0olKK5x9nkI-qLOlWwyeJSQrxsyMPMP6m7q5EkLxLDNTnVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RVbBaUnjLXatq92M3QPmHVVhMn4xN0S-gA1zmUy3TwnVMKxOLB9OOw>
    <xmx:RVbBaczZz0q7AvNWLtsWF_uAsSpjTddJvxVx5AZ48kS7ghec5w42cw>
    <xmx:RVbBaUnv1OW2QVO5lMlFyh-M0XEIu2CxBUBY82pfcoxtJDLTmpxvyw>
    <xmx:RVbBadcqhuvOavadDEcraeKVjW_40K519Fk2DqnF4E-fqRYzcUQtKw>
    <xmx:RVbBaRWsjE7AhrJWGr5eVlw9Eh7pVH6A799lg_5tzZXb24CnuEd4r0RO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:03:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d8f3fe26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Mar 2026 15:03:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Mar 2026 16:03:00 +0100
Subject: [PATCH v2 09/12] builtin/fsck: stop using `the_repository` with
 loose objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-pks-fsck-without-the-repository-v2-9-e8dc79bca651@pks.im>
References: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
In-Reply-To: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

We depend on `the_repository` when performing consistency checks for
loose objects. Refactor this to use a context-provided repository
instead that is injected via the `struct for_each_loose_cb`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index be9dbba2da..e8bdec7cd0 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -711,27 +711,28 @@ static void process_refs(struct repository *repo, struct snapshot *snap)
 	}
 }
 
-struct for_each_loose_cb
-{
+struct for_each_loose_cb {
+	struct repository *repo;
 	struct progress *progress;
 };
 
 static int fsck_loose(const struct object_id *oid, const char *path,
-		      void *data UNUSED)
+		      void *cb_data)
 {
+	struct for_each_loose_cb *data = cb_data;
 	struct object *obj;
 	enum object_type type = OBJ_NONE;
 	unsigned long size;
 	void *contents = NULL;
 	int eaten;
 	struct object_info oi = OBJECT_INFO_INIT;
-	struct object_id real_oid = *null_oid(the_hash_algo);
+	struct object_id real_oid = *null_oid(data->repo->hash_algo);
 	int err = 0;
 
 	oi.sizep = &size;
 	oi.typep = &type;
 
-	if (read_loose_object(the_repository, path, oid, &real_oid, &contents, &oi) < 0) {
+	if (read_loose_object(data->repo, path, oid, &real_oid, &contents, &oi) < 0) {
 		if (contents && !oideq(&real_oid, oid))
 			err = error(_("%s: hash-path mismatch, found at: %s"),
 				    oid_to_hex(&real_oid), path);
@@ -748,7 +749,7 @@ static int fsck_loose(const struct object_id *oid, const char *path,
 	if (!contents && type != OBJ_BLOB)
 		BUG("read_loose_object streamed a non-blob");
 
-	obj = parse_object_buffer(the_repository, oid, type, size,
+	obj = parse_object_buffer(data->repo, oid, type, size,
 				  contents, &eaten);
 
 	if (!obj) {
@@ -790,6 +791,7 @@ static void fsck_source(struct repository *repo, struct odb_source *source)
 {
 	struct progress *progress = NULL;
 	struct for_each_loose_cb cb_data = {
+		.repo = source->odb->repo,
 		.progress = progress,
 	};
 

-- 
2.53.0.1118.gaef5881109.dirty

