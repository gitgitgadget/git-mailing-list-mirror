Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FD93469E6
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007290; cv=none; b=Nv5mgxlNs52FbuyzKfpwl90OyFbXoBufpDoEyR68g37ewXOSk+gq/YVEUMqnUO8K/Ddf4gT19mYtvkNFUkgyvjiC9TosBfrByEhw6Kw4Le+GGGkyiswfWXEi8NWcrFsTHyn2yddP6/nVlgXEkeVef/aL0emj16l+1SaQIlwTZic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007290; c=relaxed/simple;
	bh=ODlMVGo0NUCHTSeBBeH8YDBPARncgnQKQYpI/Nryixs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q4seh8VFf5Xl+7kNZ8SZgWvGepumXkXnlJ8AgPofmBN8p2VqptSVfumxUZzOC5vhl90Dsg/QcXjmEB6Lq+A5UNVdu6Dq/Aw9iYu3FpAvRwxbGjPYuVq8y0nVRz+dBGDGjZq5oNptXTBz8Ekek7H+qKsBQJ+diy85ngrQ1nq1oL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G7nZ/pQ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=00dt6YDb; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G7nZ/pQ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="00dt6YDb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A0EB5EC00FF
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 07:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774007288;
	 x=1774093688; bh=8l7qu6AC97Onj7j9h6yGdCF3XvBKI8ZtJKYZDaMUInc=; b=
	G7nZ/pQ/9o7gemQNbvwq2BS9JAI5SvLlEMGRAQW9kNnheeB+i/NWEvH1Kn8xmV2K
	r+tyySk/H4vgItdljgR4XjKfLbRVZsxI3NRP4gkKnc5LSMYFVU8HQtApomucuHFj
	45ItG0IVUY3STznU42AkPQu25Pzuy9TBAtPz1xUqkbwVG4y78Obiuxq3pvFKQq8v
	ZaDYSjvUWjV+x8HOvPM/a32/tbrWOA/dyXRwGr5vur3V2RaArjf1UhKu4mlCuJmR
	qFF0S/EhwPRMCzfkpedgh4Imoks9uee+GdIV3PlsVrBUpAwv84BZoAkCwaFdiYzt
	FyYSEe5aD6EAIkQU8UaNmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774007288; x=
	1774093688; bh=8l7qu6AC97Onj7j9h6yGdCF3XvBKI8ZtJKYZDaMUInc=; b=0
	0dt6YDb/5CV1pX2L0/2MdgxEGwFY3xDU/leVzsmgl245kE5pqJFcXTn6ZgTuRyFc
	YuoRluCDboVnEmXz3m8ZCbXcpcHhlwu1hoCNkztsjNozvc7wgafVjkEss/zvgIdc
	whp6JL3JuxiY03mE8daOiZUbxPqxCdzS0lNBwxpsVF5O7yqMfeaMtWxALskNGPwj
	YB/GLuEgnExIUiXWvc5+y+TmlGN7cW81+2Q+IwKtjBH7HptxvdwtcI1XfeuBQeDQ
	A1JxdXyX1ndhPaBznWV2kke/hbDQ6axxryFYHsqUpxFzSj/rzDMc37tNVqXQbEDi
	JaCMV1vXzmHaL0apM0V8A==
X-ME-Sender: <xms:-DO9aXi44RH_X5g0EDJDuaWPaDBjI1v20S7_mtWnw4H0pdAYkdeL0w>
    <xme:-DO9aa9vFy4WJRvpYq0Eft9ASRii3IssR1Gp6vMeJ9ZwyzRDFW3HFOgiVmSnTeDAd
    rWKA_k6mZc4_yKfCtnHY1VVr8RRLKcnK4XUh_KrCRmq53OQOYEV>
X-ME-Received: <xmr:-DO9acsyyOGYJXTvcFKzLgknw8-ct--AGaHIFWBqmQrUpnJBNVACUpz8LP5A4eBKRlp5Y0ab-Q-HMYJNYZpkKwAVP5mjK91P_cWkH3YT0IND>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:-DO9aZaDeUXOuzO2UUAlbeVlw4PfnXLOlTjFcSjvQ019PjffE8lNrQ>
    <xmx:-DO9aUrAYsTkvBBLFNRhtoGKq_vLMtWf3hwTAKgtuga6xALVyUthVQ>
    <xmx:-DO9aW9IsYhb9LQN4xo3C0mbh38unpmq_rrrMb1LOeeJtKvpNgEjKA>
    <xmx:-DO9ab-a4pEXI1CXZlU6XITAqonNaiBAJSM80wNiIoBh-WhlfjoYlg>
    <xmx:-DO9aYjkzdhiUqjqdAtY-czI1m5WPiNaUrHZNSPG0m24YmH35tFuTOR1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b572368d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Mar 2026 11:48:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 12:47:14 +0100
Subject: [PATCH 09/14] builtin/fsck: stop using `the_repository` when
 checking reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-fsck-without-the-repository-v1-9-6594f997926b@pks.im>
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
In-Reply-To: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

We implicitly rely on `the_repository` when checking reflogs. Refactor
this to instead inject the repository via the callback payload.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 63cd58e58b..ea441b072e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -467,13 +467,14 @@ static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
 
 static int default_refs;
 
-static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
-	timestamp_t timestamp)
+static void fsck_handle_reflog_oid(struct repository *repo,
+				   const char *refname, struct object_id *oid,
+				   timestamp_t timestamp)
 {
 	struct object *obj;
 
 	if (!is_null_oid(oid)) {
-		obj = lookup_object(the_repository, oid);
+		obj = lookup_object(repo, oid);
 		if (obj && (obj->flags & HAS_OBJ)) {
 			if (timestamp)
 				fsck_put_object_name(&fsck_walk_options, oid,
@@ -481,7 +482,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 						     refname, timestamp);
 			obj->flags |= USED;
 			mark_object_reachable(obj);
-		} else if (!is_promisor_object(the_repository, oid)) {
+		} else if (!is_promisor_object(repo, oid)) {
 			error(_("%s: invalid reflog entry %s"),
 			      refname, oid_to_hex(oid));
 			errors_found |= ERROR_REACHABLE;
@@ -493,8 +494,10 @@ static int fsck_handle_reflog_ent(const char *refname,
 				  struct object_id *ooid, struct object_id *noid,
 				  const char *email UNUSED,
 				  timestamp_t timestamp, int tz UNUSED,
-				  const char *message UNUSED, void *cb_data UNUSED)
+				  const char *message UNUSED, void *cb_data)
 {
+	struct repository *repo = cb_data;
+
 	if (now && timestamp > now)
 		return 0;
 
@@ -502,19 +505,20 @@ static int fsck_handle_reflog_ent(const char *refname,
 		fprintf_ln(stderr, _("Checking reflog %s->%s"),
 			   oid_to_hex(ooid), oid_to_hex(noid));
 
-	fsck_handle_reflog_oid(refname, ooid, 0);
-	fsck_handle_reflog_oid(refname, noid, timestamp);
+	fsck_handle_reflog_oid(repo, refname, ooid, 0);
+	fsck_handle_reflog_oid(repo, refname, noid, timestamp);
 	return 0;
 }
 
 static int fsck_handle_reflog(const char *logname, void *cb_data)
 {
 	struct strbuf refname = STRBUF_INIT;
+	struct worktree *wt = cb_data;
 
-	strbuf_worktree_ref(cb_data, &refname, logname);
-	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+	strbuf_worktree_ref(wt, &refname, logname);
+	refs_for_each_reflog_ent(get_main_ref_store(wt->repo),
 				 refname.buf, fsck_handle_reflog_ent,
-				 NULL);
+				 wt->repo);
 	strbuf_release(&refname);
 	return 0;
 }

-- 
2.53.0.1055.ga2ffed1127.dirty

