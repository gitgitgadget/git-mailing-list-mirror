Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0736126E710
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047729; cv=none; b=uSB/+hK5xlohC7ix+vAsTlsYomvWpejpw1q5Bco3pXskFOrd6O9IG0/AsfEA4EezLfhkPx2LkeYLoVkllAqE+R33L8nwgayFhQ4a8xTp7vEvZPE6yFb6scyzwDm2DtCfa53LrlkQyxbuN89HaR/qkZLiM2waPECVs/0m+3e7gkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047729; c=relaxed/simple;
	bh=a1+5gaOgw3oiZM8vwfKatdjuqkK4xQne2WX/a/ZCaGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tnu7AeoGP7fLluJpO/eEZ3XjMe0PWHKDe70q1h1AN774G7UY58Uvw1q1vGUJ4BEJyf6LZtvZVu9XzC10qkXGV7RGvqDoxpnnGMeal9PPD48n3gMR4VTKvvu+BnL9C8ijhGFT4BO5tSLfy2xEvfGhLDewo57+jC34Sv+oV4SYIvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nkHUf3ww; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SKBVD0rF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nkHUf3ww";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SKBVD0rF"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 37013EC046B
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 03:55:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 09 Jul 2025 03:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752047727;
	 x=1752134127; bh=Z9PP432Cs1cgs6Xv8OXJMxrMiccOItg+acSzrsxlzRE=; b=
	nkHUf3wwcfQ5VCA3kUOmfFEgwtKdCd5wHL4gq9Kg7FvKRDpgGjSBTftjM37E7woU
	/Ep+V/tA1LHCgt2if2siqKrLuY63VA2SPuKyz5PU+7GGvd86H2g181zP4Chm49VW
	h1s14yN1ukYvIv2CdC/Rn+ycD4ZjGzYf05Gdhzp4xmpQD5tOi6j7/NSsMxwqTNhd
	TVoMT2YbblItAIgg3B5kIh2GP4sxljn1HW5T0iCA3NFyrVtNnLx8SIrL7VcYLQ5T
	mX5ocjEVIc+b/1pkJK3RA7g9svaxd8gS17lSJ1yZi7RbY4Swvz7zZNSeQgzgWtu5
	L2enzl+WZPLd7FiPvUJudw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752047727; x=
	1752134127; bh=Z9PP432Cs1cgs6Xv8OXJMxrMiccOItg+acSzrsxlzRE=; b=S
	KBVD0rF93InkSUL/uZva/5aSwaUaV73sw3J4R4BSocMK8p7fGtkpIWGzynGVG7w+
	z9anuJEA2OSba0i9NP+Vng6AWUHQPs54/7D4wIyOFBBo20l9FMQ1v8ym4EblRdqc
	OcVx3t53D0ImqIgGvAuj/qLYnwabP8MXNxR7DX3+GNlm/78vrl2G97+zNs1Rm50/
	7niKRxmwOqV80ykIKeYXnak3d0VVJvC5cpCJiO1vuD6gCj/vtySFkrBrUQ21hVp7
	5Tfe5zA7ibDIyJ8g1PETG4GfRubk7z6j4m7yXkz0EjLZtwrSD+NmI7vDR2NvAgff
	D6sx8hLO25rx1g2AK1Gjw==
X-ME-Sender: <xms:byBuaIVGi-cJXDSl3wP5quELjYikce51g_4YcIKZeh1EY0JVfQ2mPA>
    <xme:byBuaOnvZoxewXmgttI9s-kLEXoWZlH-xGF-ccXLyXd_ZbLR8IMsVjq0FOcPrVWD4
    N3X3iCMwT31jVmJng>
X-ME-Received: <xmr:byBuaFz9oOQQP2-WxwDEA1yv6gG_4hZo2AekNS3Fk6tffM00rk8WVbWhvUg17IomJwlI6R8ny-kxGN4CHAGx9tESFssST054Frkmt3waZ-s_jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:byBuaJh9IfY4TcQzA0VtP6S-wFmndQh1QZK5BUpeb0uDp0w-QAIdqA>
    <xmx:byBuaKX24zwvkC3iAfQirBUvj07zTNdqhise5qLSBvbwo0-uIW3M2g>
    <xmx:byBuaL1Lw0HE1eOXZ8kxzlT9twVKP2TJL6CwGbJ7ynLObUCgvCLe4w>
    <xmx:byBuaAGtAgdVmBiVdhv95bjbTntVKER_kvakNoeoD7l3IVKWByV45w>
    <xmx:byBuaIc4h3z_89Hm3iI78h2zi6TDhn47PCpsRMNzeXWl9t10f4Cf2gyd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 03:55:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a7768604 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 07:55:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 09:54:51 +0200
Subject: [PATCH 3/8] midx: stop using linked list when closing MIDX
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-b4-pks-midx-via-odb-alternate-v1-3-f31150d21331@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When calling `close_midx()` we not only close the multi-pack index for
one object source, but instead we iterate through the whole linked list
of MIDXs to close all of them. This linked list is about to go away in
favor of using the new per-source pointer to its respective MIDX.

Refactor the function to iterate through sources instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     | 11 ++++++-----
 packfile.c | 10 +++++-----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/midx.c b/midx.c
index a91231bfcdf..416b3e8b54f 100644
--- a/midx.c
+++ b/midx.c
@@ -401,7 +401,6 @@ void close_midx(struct multi_pack_index *m)
 	if (!m)
 		return;
 
-	close_midx(m->next);
 	close_midx(m->base_midx);
 
 	munmap((unsigned char *)m->data, m->data_len);
@@ -835,11 +834,13 @@ void clear_midx_file(struct repository *r)
 
 	get_midx_filename(r->hash_algo, &midx, r->objects->sources->path);
 
-	if (r->objects && r->objects->multi_pack_index) {
-		close_midx(r->objects->multi_pack_index);
-		r->objects->multi_pack_index = NULL;
-		for (struct odb_source *source = r->objects->sources; source; source = source->next)
+	if (r->objects) {
+		for (struct odb_source *source = r->objects->sources; source; source = source->next) {
+			if (source->multi_pack_index)
+				close_midx(source->multi_pack_index);
 			source->multi_pack_index = NULL;
+		}
+		r->objects->multi_pack_index = NULL;
 	}
 
 	if (remove_path(midx.buf))
diff --git a/packfile.c b/packfile.c
index b43dd2fe6cb..546c161d0c1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -369,12 +369,12 @@ void close_object_store(struct object_database *o)
 		else
 			close_pack(p);
 
-	if (o->multi_pack_index) {
-		close_midx(o->multi_pack_index);
-		o->multi_pack_index = NULL;
-		for (struct odb_source *source = o->sources; source; source = source->next)
-			source->multi_pack_index = NULL;
+	for (struct odb_source *source = o->sources; source; source = source->next) {
+		if (source->multi_pack_index)
+			close_midx(source->multi_pack_index);
+		source->multi_pack_index = NULL;
 	}
+	o->multi_pack_index = NULL;
 
 	close_commit_graph(o);
 }

-- 
2.50.1.327.g047016eb4a.dirty

