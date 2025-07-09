Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53309272E5E
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047726; cv=none; b=d9IhGKEsR5Fi+keRqcCYZtxbO/pqzNG7mQKNMDHowZQzGlJgqJFyAoOfflfVQlgAo9HWivmyevBJziqzZguRUIqCwReBj2IjXrDNoVT0T5qd2HofHPos/qux+DnWuvW+TPPUyvUsJTBajLjNzXSvN/DhcmxO2sVLEaXmKNNmlvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047726; c=relaxed/simple;
	bh=+tgrsFkNvPExeEjGpf6fH/OOsWS/QaIi1ae0X7UkV+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TEdXAli7Z3zFJJSEOwg3Vsk24P7K0xrLKlmW7oieP2Gjpztc8Tl4UijLMCx4PYsgALxU6EMOAeQvLMxmQDBNtfDQpfmMJWr+E/V+rRXEv7csYBbg5Vc43ne8+e1a8soi3F1bnRkiG2tfQ/KMDpmTWS9u/nF2qB4JqgDSQUz/NP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QvJyUr8q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Aw4SPdaN; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QvJyUr8q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aw4SPdaN"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 72EB514002D7
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 03:55:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 09 Jul 2025 03:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752047723;
	 x=1752134123; bh=URmcgpram4Yt2YOsxGvODftwwQta6zscjG9W2IcmQDQ=; b=
	QvJyUr8qlpzK4jkjjwNsWCjy286weRdJ9KS9/Z/fXf6CW9hmIzCQ7+F/Lb1/Dk71
	yLxOnvNjC8A5gPLMzkJPsZ/XfPLdzj/6VtPq/HJviMWljLVwhdn3NSsUD7qo9lKn
	9iBw/a4kRy3V/TpgVfTMkPs+O9sVaa8OZt/1Q4uxbcd4/W9O0f3wNF99Alx774mm
	mixQ742cvoOzjz6kE/g5ffRPrNhBzVMmgBesOgCL0RqdWv2b5A8clAv8EILES3Vg
	xI9BlVA+6H9gydHJQ0gX6t+qefmOpE19wjEdb5hmNESdJ7BOxVAP201VpX6QZv3Y
	ZyBd7gKoFqnCD0mAyXaunQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752047723; x=
	1752134123; bh=URmcgpram4Yt2YOsxGvODftwwQta6zscjG9W2IcmQDQ=; b=A
	w4SPdaNMBuhhWyN90GFbqQV6P6NGWWZ88af6Ew49pihSKgod+pnwwlZARLjMQIjR
	NwJ+X9OrfuAcPfNjk43vG+bRU1YzEQ7beIkvGywhyYH93PQ6Fvxkfsv2q1JvxK/S
	RXnmqg5R4MgG5z6EGZ6nGkuHGlnDUa5L60xloM0dPz/4hyL2RtKcx8BBTlHa9JiC
	Z1O67QxBcjhVosqjlCjt4a/on9fuhRIBPRJ/n0YwnPngdQTkguBuO5wTO0/HtiG4
	UzWm7zxProE1cAjt4yZJKDQT98h/EliiZ3qB0QFD/MqCwS68ckTp8pdmqRhkmLgx
	8TzhiTa8vGnZTNtbQSVIA==
X-ME-Sender: <xms:ayBuaPBrAuOdKJJo4ZlSE8r83UWCl3rGe5pTbBDVNVZ6j34QNWkoXA>
    <xme:ayBuaHgAZPJ-6WkOsCRSG6botaUc_Cuf5HiNpdO9oBMCO_MWX6GspIIxP5RpnQ3zG
    _Qj_JX-JItIhXhYwA>
X-ME-Received: <xmr:ayBuaD-EFfRdaFjsqicCz9jirmQl3ihMhAp2czt9vqR5EjGgJs1DGtRofgDqKL2ZyQY3kuVKHJrT-Z5gGdDZ_mfILDY3TXkDJ96a8jDCC_3SRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:ayBuaD_eMm-ykgpThVs4WezUPCIulXh53trtmm7epLeD8IPVHZ2Zhg>
    <xmx:ayBuaMAnFFLaRoycBFoTGpNKUAF_eDDrlsZGke5unvk1TRUvqBsdgQ>
    <xmx:ayBuaDx2SkKbnDGmjBqAnBoO9k6qONp41G-OEHUS1Yys8bYjvtjX5w>
    <xmx:ayBuaBTf0f_060e7dTtGVbvlrt6r-9Ya9M_ci0nZGANfjC1wcdawaA>
    <xmx:ayBuaFsXy6tvLStUTWsBSE85kKeBIKRZRT4yPMRWhxk84j5U7tU-E-vM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 03:55:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0a26b4d1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 07:55:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 09:54:50 +0200
Subject: [PATCH 2/8] packfile: refactor `prepare_packed_git_one()` to work
 on sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-b4-pks-midx-via-odb-alternate-v1-2-f31150d21331@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In the preceding commit we have refactored how we load multi-pack
indices so that we take take the source as input for which we want to
load the MIDX. As part of this refactoring we started to store a pointer
to the MIDX in `struct odb_source` itself.

Refactor loading of packfiles in the same way: instead of passing in the
object directory, we now pass in the source for which we want to load
packfiles. This allows us to simplify the code because we don't have to
search for a corresponding MIDX anymore, but we can instead directly use
the MIDX that we have already prepared beforehand.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/packfile.c b/packfile.c
index 16efc2fdca3..b43dd2fe6cb 100644
--- a/packfile.c
+++ b/packfile.c
@@ -935,22 +935,17 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
 }
 
-static void prepare_packed_git_one(struct repository *r, char *objdir, int local)
+static void prepare_packed_git_one(struct odb_source *source, int local)
 {
-	struct prepare_pack_data data;
 	struct string_list garbage = STRING_LIST_INIT_DUP;
+	struct prepare_pack_data data = {
+		.m = source->multi_pack_index,
+		.r = source->odb->repo,
+		.garbage = &garbage,
+		.local = local,
+	};
 
-	data.m = r->objects->multi_pack_index;
-
-	/* look for the multi-pack-index for this object directory */
-	while (data.m && strcmp(data.m->object_dir, objdir))
-		data.m = data.m->next;
-
-	data.r = r;
-	data.garbage = &garbage;
-	data.local = local;
-
-	for_each_file_in_pack_dir(objdir, prepare_pack, &data);
+	for_each_file_in_pack_dir(source->path, prepare_pack, &data);
 
 	report_pack_garbage(data.garbage);
 	string_list_clear(data.garbage, 0);
@@ -1040,7 +1035,7 @@ static void prepare_packed_git(struct repository *r)
 	for (source = r->objects->sources; source; source = source->next) {
 		int local = (source == r->objects->sources);
 		prepare_multi_pack_index_one(source, local);
-		prepare_packed_git_one(r, source->path, local);
+		prepare_packed_git_one(source, local);
 	}
 	rearrange_packed_git(r);
 

-- 
2.50.1.327.g047016eb4a.dirty

