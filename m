Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DCA3242B8
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351766; cv=none; b=ollfH4/KMzDJhBUJgKp13RDUw49SIPJzfRWnXSDG5vVUe+O0X0F6i7hnQb9OyHryK1edpNEjenmB63RZsOj4EZwqWEroQdn0BcwXKoh0ilnFUY1Zc699u7KfzaLQkKsJGqLY3FxMqP6rLMsgAaZw+HYolFnvpFLBsV4FOKLPbNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351766; c=relaxed/simple;
	bh=VCm4vpDJOh5clJe3CHbLt4meRZG96OWuf9sjrdijzMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKGLXUEGiwCY6SyHN+MpoNFMy0E5dCGVpf/k4qGf1Rdg1sHtJfzkFeKobKuUkKgc8wS2C/n9EM3dwoISAx3Fx+0wKIfl4hjAwTMZbImmUMNEulpJci7Slor3UFVQgmwWs7I/Ac36EU+vfY8ya6v1VjZtyKnV2cvEHtDkSf7n1I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z5yKbFbR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DAzBBP7i; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z5yKbFbR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DAzBBP7i"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E773EC0067
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:22:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 21 May 2026 04:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351764;
	 x=1779438164; bh=wPwM9AVOYHIcx1YH6oWcYoeBUzdE0DIusnDmUQOvHtc=; b=
	Z5yKbFbRDQy8go3tYVCqWyV58StaKf3sL9+5NE2BBMWewrNDCkHhrMG4pNAsu9/Y
	Orf4nsv0agqlea0F3HdOY2gEDOTNm2C90YrIK0uXSdW5ejJr+UAMSHvtLxbPmAfp
	p+UVKuXPk/vDN1lScKrvZIL6nYjtqBFbFXTPs/6mKmivsiznAcHHxcCl2B9pSHeq
	edgqjKYl4HmQnY3qReNnZonKvwj2h/+X9tHNU8EJgAykUCNqLSqQRk0NhrPsc8LV
	tJRxW4LhaPxEEnYejEsrdu1G6d48+wRLfFu6hmTjjEciKeDMjcpojfPufYMUYW8f
	e7U+hOKRVingFAqOQyK1jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351764; x=
	1779438164; bh=wPwM9AVOYHIcx1YH6oWcYoeBUzdE0DIusnDmUQOvHtc=; b=D
	AzBBP7iBlhT+76yHWOWaF0CeeDXw9Mzk+kE4CrD5AcIZ1rnDD4AeEH2BiZPPx3hi
	ZvEB44TLQ8jD3u4PhlvTcC71mzPv5sITu7pbqexQDV9KBoltkMIyGi/y7IHG/+JH
	JYW2xBxvq9h3lzVSewSisICg9gskODKm9Ub3LrVrp7lDmXO/KI68P6jFErh83R8l
	xeDyuKVTVNarXbAitTW8LrxhNx99/UFDrp8vrCj4GtNYWl+9QJHSiPTmXxbE1GzF
	dE4FHpwekxDhzwFgHJSp9fiKWOS1XqvJSh6gFKFcLCaI4LW6Dfk97jpwNCPNdeA0
	xNUmqRdIuwnxj3Ar5rDkA==
X-ME-Sender: <xms:08AOaoEYFwhx5UqztBuFRobTKA6y30-MPhMnFvEHoZ_T7GuChoHeLA>
    <xme:08AOaoRpZU0ZH48tNo7XkPyxLO30gB7N8c4bCc4kmKmrOF2TsrOM68t3sARPnbzVy
    X29LOAVdJYr_IquzP1JYPsZmaMY7KLVZvCnIf8heY5pcAtiJGG-GQ>
X-ME-Received: <xmr:08AOanzwzErMlODDB76M39cB3wmXonrXg9Y8y8q4GP9-T4oFvlohk4SZ5zOBO0udGbc4ldb-NPNKX3xgKt7GVzcjKknhC4Kr2UDaIXx62Gc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:08AOavNNF5wA2UqVhHBMhOImBmC128h_T3soDHhJTt4pGivPeMuUQA>
    <xmx:1MAOauN3HZ3AyO7e2J-Lj_TxcqEQjgveRY7IPWAuDG4Jy6z-1T77Rw>
    <xmx:1MAOapTqMIAAPN8hkmqUWypvDQeMGTdAvZMN6VrwyNU5kEQaZ4YmyQ>
    <xmx:1MAOaoDiAy8gWF2hgUayASzB_3bwzMJEwoBt-nEay0BrnaI5ETmzow>
    <xmx:1MAOaiUAl6Rryh-4kpNp6TBQo9Y17aZJWBu_iv0Tmf-6cwiXRXwZAD3J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:22:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea644de3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:22:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:25 +0200
Subject: [PATCH 05/18] odb/source-loose: wire up `close()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-5-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Wire up a new `close()` callback for the loose source and call it from
the "files" source via the generic `odb_source_close()` interface. The
callback itself is a no-op as the loose source has no resources that
need to be released on close.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 1 +
 odb/source-loose.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/odb/source-files.c b/odb/source-files.c
index 10832e81e4..59e3a70d80 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -36,6 +36,7 @@ static void odb_source_files_free(struct odb_source *source)
 static void odb_source_files_close(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
+	odb_source_close(&files->loose->base);
 	packfile_store_close(files->packed);
 }
 
diff --git a/odb/source-loose.c b/odb/source-loose.c
index e0fe0d513d..65c1076659 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -21,6 +21,11 @@ static void odb_source_loose_reprepare(struct odb_source *source)
 	odb_source_loose_clear_cache(loose);
 }
 
+static void odb_source_loose_close(struct odb_source *source UNUSED)
+{
+	/* Nothing to do. */
+}
+
 static void odb_source_loose_reparent(const char *name UNUSED,
 				      const char *old_cwd,
 				      const char *new_cwd,
@@ -53,6 +58,7 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 	loose->files = files;
 
 	loose->base.free = odb_source_loose_free;
+	loose->base.close = odb_source_loose_close;
 	loose->base.reprepare = odb_source_loose_reprepare;
 
 	if (!is_absolute_path(loose->base.path))

-- 
2.54.0.926.g75ba10bac6.dirty

