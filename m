Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078230EF74
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863509; cv=none; b=qWBLNYRy3H+PSmye1avCytf4pRslLF3h+vEz9a4zDTTjRAYbpuvZVTW2nambAs9ExW5hI0N489WAzYZFZrHl1iWZ/mJjA8jNZRQRPz+NKM2/6HtBmZTATdZgRVETmOTPCYdl5LGiorR91329O6g+3DiZy5l+M3zz05pMj+C1+RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863509; c=relaxed/simple;
	bh=LRV/UcqfdQlIsUbgLST0J9VD47ct4czzSOMRE1WkqGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UmM0gQG7kxKzel9ycSaVSlJlV/MZZQa8dNC0NJGAnrl1GGMP2TtZlG/nLsfUb6ygRT15yZf4o/Ytrs2ifCfia7SyeTL1gbZJRlbXhaCrzudFDu0kLGsk/dSMOgHC+J17XvbGqWtCT+oiy9chsu5AtQna2UErCGI6Y2ZtZgReeZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NyNYaZDs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qGFgV5Qn; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NyNYaZDs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qGFgV5Qn"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 972A9EC05A3
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 23 Feb 2026 11:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771863505;
	 x=1771949905; bh=VVAEvnHHJGbNIS8RoloeK/WB8Sbmer4l0lNvVQcr+Rc=; b=
	NyNYaZDsBOTBU3pAUkaGYwrUgQVDquGSn5Pg29g7WEHT62bF2aH/Viy42IcL2izl
	Ymh39wdYod9RUP50MILX6IH9HrTn70zq66UWpriGk1aus2kfegVJO5QhUdPLsv3Y
	t/8yZ77MiMQmdKR0FPKu1hwBV4VRJikIGl+oIx2LFyYECwD00MFjZoAkbEP4pGwN
	eGL8Anye0fu5uOsVF+s9pLAYtuENIkk2YzcEdjtl5Ols274xIUDw+v6R91ypsNgl
	Mj+blChBULW8ssVfnEGoGe4blCWSqHIdRnN6n32x17+xHJSLLB+CKUffyedxws51
	o36OnYl5wvPSvNYs4iLyKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771863505; x=
	1771949905; bh=VVAEvnHHJGbNIS8RoloeK/WB8Sbmer4l0lNvVQcr+Rc=; b=q
	GFgV5QnaBK7pQ5qDbn6pWQUYDxGqM4ili1pZuP+1JPgSqagFLe4ZhTnWj41QEqZE
	SKKTNKHy9axwAIWZlxHnAbiI/P0Ce8mVCQiZLmNkMzHAeJ4Cb0jtOrQJaWbzLhE+
	A/myqF/NanKrRQW/HaKHRF2v1pW0gIh/VWB6+dU5g/Ex2u9NyJp9cWeZLZ/0VHIs
	8Vf6Gu8AzAk5MBAWo1ZqaDCsVwiXlj3avtyQGD/C3FgcsUmtky3QBv58EDNnNKHC
	Rdf5/1N8TUdGpwbDCGMmL8ZHBiZxvaFcQWUjQi4BA+g8iCT32uYCj0kVqNu3O8N9
	2n/HmNrPiijCzKFu+JZyg==
X-ME-Sender: <xms:0X2caQ4n8VbdEbZsoglQucu5tgfnsW3iIFJyDd8_TojWEL6ewzUCSQ>
    <xme:0X2caY1JTHkiOXzdd2qrgB4AHrf5M5xtmjVvJO8_sp7imf6t5BtVgd0HTEbCwdaLx
    M9StRF_VJ7cHbpdVpPO3VDA1K5HXsZD0C3UlnvdilRK5kekX6GsBg>
X-ME-Received: <xmr:0X2caVFqrr9syuB_UtaBstT0lNOQfDTQos7Xn0fspaC-oo9CXXpcFgaO6TtaWY6TpncZes790naiiSnanR2qgHy916qQ0es2v6BqpujxFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:0X2caaSL6fl7XRFkT0sZxxIVvfWVX0r7Qk2-s6IIdC4Sxb-DwylRVQ>
    <xmx:0X2caUDCOtAvHkB7px3CMs3KSo1SaNnzrY376r-fvR1wjhumC0wM2Q>
    <xmx:0X2caS0iNcjmmTFykipCyiNUqsLYM8ldEVFp89f321HlB5tdZXSJVA>
    <xmx:0X2caaUEz5FXfLw7Iy8bJa5cq4u-U95BqkB8wFcnRrpZFtZYq9_FpQ>
    <xmx:0X2caRYMqG_y4E9b-1GFneT4llizoEURh2GxJMd3cfSHK2m4XDNI4Tku>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca589b69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:18:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:17:58 +0100
Subject: [PATCH 07/17] odb/source: make `reprepare()` function pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-b4-pks-odb-source-pluggable-v1-7-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c              |  7 ++-----
 odb/source-files.c |  8 ++++++++
 odb/source.h       | 17 +++++++++++++++++
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/odb.c b/odb.c
index 86f7cf70a8..2cf6a53dc3 100644
--- a/odb.c
+++ b/odb.c
@@ -1119,11 +1119,8 @@ void odb_reprepare(struct object_database *o)
 	o->loaded_alternates = 0;
 	odb_prepare_alternates(o);
 
-	for (source = o->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		odb_source_loose_reprepare(source);
-		packfile_store_reprepare(files->packed);
-	}
+	for (source = o->sources; source; source = source->next)
+		odb_source_reprepare(source);
 
 	o->approximate_object_count_valid = 0;
 
diff --git a/odb/source-files.c b/odb/source-files.c
index 65d7805c5a..d0f7ee072e 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -28,6 +28,13 @@ static void odb_source_files_free(struct odb_source *source)
 	free(files);
 }
 
+static void odb_source_files_reprepare(struct odb_source *source)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	odb_source_loose_reprepare(&files->base);
+	packfile_store_reprepare(files->packed);
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -40,6 +47,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->packed = packfile_store_new(&files->base);
 
 	files->base.free = odb_source_files_free;
+	files->base.reprepare = odb_source_files_reprepare;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index f84da59ef0..2f8132f9e1 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -58,6 +58,13 @@ struct odb_source {
 	 * all associated resources. The function will never be called with a NULL pointer.
 	 */
 	void (*free)(struct odb_source *source);
+
+	/*
+	 * This callback is expected to clear underlying caches of the object
+	 * database source. The function is called when the repository has for
+	 * example just been repacked so that new objects will become visible.
+	 */
+	void (*reprepare)(struct odb_source *source);
 };
 
 /*
@@ -97,4 +104,14 @@ void odb_source_free(struct odb_source *source);
  */
 void odb_source_release(struct odb_source *source);
 
+/*
+ * Reprepare the object database source and clear any caches. Depending on the
+ * backend used this may have the effect that concurrently-written objects
+ * become visible.
+ */
+static inline void odb_source_reprepare(struct odb_source *source)
+{
+	source->reprepare(source);
+}
+
 #endif

-- 
2.53.0.536.g309c995771.dirty

