Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA05819D89E
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001484; cv=none; b=dCKFbUD+1CtnynB8dXOQ1iHr/gtwYuR1CcXsXiVTgkVp0m9Sxw5wdHwYhrU83uPDx6NO788jOeWQy4KjX8T9FbEMVoTerzQypv2aYAt2LBf2d8+7jESHGgAEy4uyBKz4ZQKp4znN0ZsSErJkWCnwSf60TvQ9IKtiNKQpVPOx6q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001484; c=relaxed/simple;
	bh=G2uMiBGMyoEnrxl2DXizl4Q0fb6F9Pd1zXQdXZmVRfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nDlFOm9Lh9lBBiQXioOIBO4FqJpQ/oMKZp3z9nP4297oA5/czCHwSDSO34lvYJXp9HVr8sSmrrsriZb8GYkS9t9h0V1QIepNsiGRWYjtR1M2DCdwTdY6CUQ09UOyMkjtNtuj+T4MBZWtgrZmeAUBgaJZCMO0L7GUHIT9faiLtow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k8xAkrNE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tXBC/VHP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k8xAkrNE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tXBC/VHP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C720EC0257
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 19:58:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 19:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775001482;
	 x=1775087882; bh=VhV7gP33iWOvMXATnJf8xGP1kvXNMjgUOTSmUylrXlU=; b=
	k8xAkrNEP2YCGVDFjE6170n3kJzKrDS+hnVuUV58LB72vgczQ/XYmwHnca940zlt
	oXrU9thm3QnYR6RBDlh/1KhxI8Zq2HsiQwM0iyPuDUneI3QnqHL80dg5zjXIDarC
	dqp8byiwOj83Q4uhzTUlqeLYfTXMp8A394lROT+Wk/SARaPl4+iC61F6fe7KYUKs
	dKJmQcZZdOcNwtaIJoKhC2P9Dpd94XzvDIaBnE3uahYgZMBOd2iDXy/PNaxT2OdK
	JSz6OENfLl4Y58PL6P5JC3Xaw4evWEQWkfIfU8I34f3yCfakgx+4+4orZVFRuONy
	nlXI5I2wJ8X5cpMj0cZEtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775001482; x=
	1775087882; bh=VhV7gP33iWOvMXATnJf8xGP1kvXNMjgUOTSmUylrXlU=; b=t
	XBC/VHPC0crQ/V3TH3rbXui762Iq1B2tnxgDMXFNB33u/qXGxsF/9ffuBH+pxLff
	dHzBGoFgpBQBZdqwIelesUM170xdKOAWJAyEF1yMcPmdEGMVncz0dgwoeVV3qlbL
	49pml5aKXrN8ZyRUZmJsk2WiFFL9x/ILxKuxco9Wq3qd+AY7ScLzZ6evaWrDJVoS
	aJxD24+jL0Eywp8ivXohCDlTkzI9ttTn3By0xeHGGpMjxJZyKsG/aFiUNfJe1oWU
	/95s4Z+Xtl/XwCHKA40Q3UkM+CvQkT4P/npiBluNqVp+CQVhLSZrbGH5EhihfDCm
	thQZe7Rkbmkf/ZYGgyFjg==
X-ME-Sender: <xms:iV_MaRvkAWxQroWL1Dea0zuLGzc9j9sH6k8b0HAWtqIC6D1LCsaU6g>
    <xme:iV_MaRZ2QgmdIdBAG_yEmbDuQv3Ad44S7hNulS6bODmCqMAAjxb7XhA5CCPhNKu8p
    9Pj1WhtDrkZ-VugyKQm0wIGTacMrYBxJK6z0TEWGqPOn24KInf1jRo>
X-ME-Received: <xmr:iV_MaaZ2zhMty6EjauF4feImYY8kZEvU5lA7JFZ8WNKFD7ni3UXCPvc7_Gq6b6aoGMcu2bsminmBhk8w1xo1JxhYj39il5u4-gy1d9KKvrc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:iV_MadUp_6rJd4--Qi2zPCOxlPNyJ1H_fTS0cQ_lEGfCiHwNNzHbPg>
    <xmx:iV_MaR0ju_Uk-KCcH01kll1AOpifmHTrq5K3TcSeCyCTt9Sg2zMYfA>
    <xmx:iV_MaUbuoAhG0X0dCNq-ZaxckwgqtnZMNH7dvbanHF_l356CTXc1Cw>
    <xmx:iV_MaUphH67GqwMNU5BhqcDCHepn5Rba9Rp5GZl2IMKPgSPuX5R_cA>
    <xmx:il_MaYeYlZ_8GMDd8pnFxWSUwQUtqoP9eI0tVCuHjYxjhRip5nOrkOr5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 31 Mar 2026 19:58:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b2b51ae3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 31 Mar 2026 23:58:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Apr 2026 01:57:48 +0200
Subject: [PATCH 3/6] odb: rename `odb_write_object()` flags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-pks-odb-cleanups-v1-3-89adba9ada68@pks.im>
References: <20260401-pks-odb-cleanups-v1-0-89adba9ada68@pks.im>
In-Reply-To: <20260401-pks-odb-cleanups-v1-0-89adba9ada68@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Rename `odb_write_object()` flags to be properly prefixed with the
function name.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 cache-tree.c  | 2 +-
 object-file.c | 4 ++--
 odb.h         | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 60bcc07c3b..60059edfb0 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -456,7 +456,7 @@ static int update_one(struct cache_tree *it,
 		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
 				 OBJ_TREE, &it->oid);
 	} else if (odb_write_object_ext(the_repository->objects, buffer.buf, buffer.len, OBJ_TREE,
-					&it->oid, NULL, flags & WRITE_TREE_SILENT ? WRITE_OBJECT_SILENT : 0)) {
+					&it->oid, NULL, flags & WRITE_TREE_SILENT ? ODB_WRITE_OBJECT_SILENT : 0)) {
 		strbuf_release(&buffer);
 		return -1;
 	}
diff --git a/object-file.c b/object-file.c
index 4f77ce0982..db1a420ab6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -909,7 +909,7 @@ static int start_loose_object_common(struct odb_source *source,
 
 	fd = create_tmpfile(source->odb->repo, tmp_file, filename);
 	if (fd < 0) {
-		if (flags & WRITE_OBJECT_SILENT)
+		if (flags & ODB_WRITE_OBJECT_SILENT)
 			return -1;
 		else if (errno == EACCES)
 			return error(_("insufficient permission for adding "
@@ -1042,7 +1042,7 @@ static int write_loose_object(struct odb_source *source,
 		utb.actime = mtime;
 		utb.modtime = mtime;
 		if (utime(tmp_file.buf, &utb) < 0 &&
-		    !(flags & WRITE_OBJECT_SILENT))
+		    !(flags & ODB_WRITE_OBJECT_SILENT))
 			warning_errno(_("failed utime() on %s"), tmp_file.buf);
 	}
 
diff --git a/odb.h b/odb.h
index 09affaf6a5..083c25609e 100644
--- a/odb.h
+++ b/odb.h
@@ -568,12 +568,12 @@ enum {
 	 * changes that so that the object will be written as a loose object
 	 * and persisted.
 	 */
-	WRITE_OBJECT_PERSIST = (1 << 0),
+	ODB_WRITE_OBJECT_PERSIST = (1 << 0),
 
 	/*
 	 * Do not print an error in case something goes wrong.
 	 */
-	WRITE_OBJECT_SILENT = (1 << 1),
+	ODB_WRITE_OBJECT_SILENT = (1 << 1),
 };
 
 /*

-- 
2.53.0.1185.g05d4b7b318.dirty

