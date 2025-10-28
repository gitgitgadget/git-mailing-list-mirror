Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9768230499B
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649742; cv=none; b=keC/D4hfPA9uvCr9+Bq6QRGnDzId09NqZy9FnbIb11JiqogzMqU+toAXBgl/o9RaPvUjgRe3GuES6G8cM35d45GV904B0mGPfb5flMse2IPIam0GcdVuyh5AHQ9z0vOmC1v0BYck3ZTvHYb4N19eLP10VxjEvJJ0okaWyHdCvvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649742; c=relaxed/simple;
	bh=Pxm+WE9WSSouV+5/bJ+Xr8Fnoma1AzhGEKLoaoaoogU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L2y1ocLX6P/R4xKzFwBblr7l/zyhus4fY9GxvzsysIcCrfRKAIE8/8z7mt4BQ2vUwHCnn9eIEnubzzP2ZRnZ5xcNkgkaAZThHaPNq1Q+wOMF7m3RcTqpHV/4zarqKFXdp68kbVB7jQbC1pZkbYmzWKtfFKqcX/Z2I+h/VtL1xuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kw/T6CYv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LMRQkRlR; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kw/T6CYv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LMRQkRlR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC38A140036A;
	Tue, 28 Oct 2025 07:08:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 28 Oct 2025 07:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761649739;
	 x=1761736139; bh=qvX4xsX1j9qU7XoNA8YB1+8Zq29eo2UM36jVdqVPWXw=; b=
	kw/T6CYvEXCv5LtLKyeDekjMt+2R2RWUXbW7BTLe93c63ddnj+Hfeurnte0mGbHP
	KKw9l0ii5ZElZXZGQPJF2jBEsbhW61CUHYqFyuuj0bTrmw7q/bQ+fmck4rd9Gbkv
	/ocCinvlzbQbm0oZ1fOFep654W0V9t/FlQFwiidohFVY8p5Og3v5yhgZ5tX1cyp1
	TJ2NmGqpd+Qh5V+azk4pP+jz0YMkSGFhDh7/zqfPTjPxgjfVXDI7KPEZU1eq1fcS
	ZhzBCn93uWj/2xpKYVPtIjVQAOfZ1ooy7gdbsbbjC0pbu/EgM4RO1aDp6y3wNFc1
	faJ2zDhssfewyi1HDxQnjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761649739; x=
	1761736139; bh=qvX4xsX1j9qU7XoNA8YB1+8Zq29eo2UM36jVdqVPWXw=; b=L
	MRQkRlRY2HWrIUgyIGW89CbdZ1rtLky5sEfljD208cTTb/LVRLRmufkQzaB42oup
	Yc5pzpJvBwdBGYbpS3UVAoJ3JSG9KUy/H3+sL6qVE6HMXoeo3LlDj2faR9sF/KM0
	3A6AXIhxWH2v7WHMndGcaekT7Aon6k9Qizpxy0BflR32l/WC8z9cz7QhM0zcyYDr
	Sm3qtS+iKdGIE6uB/C1uOXDkizJIBPLgHqiqgqae9M5TCn7ac3Bu5zSfWAcL9uhr
	O0ZLxTDQtSo/iBaqVJzDPlAr73ZWGEuY84BdhldxKkdJXhEFRsiUIi+fLgbN2KPE
	9eCH7kf2EocvwZG+wSmHw==
X-ME-Sender: <xms:S6QAaSE4-W8wuECM8-nirqLLZOjj27ptSfp2rwoKX-Kg3WC--KnTyA>
    <xme:S6QAaayDyKNjyYE8eLiBwcmnVZzPqUcNyHlAD9tPjudcG3mELqn_ZyPWjxcWQY39c
    sYAEJHReiZXHVuxht9WKwlzlTqZxWRqFVZVz3DDBP4biYd3IxAp>
X-ME-Received: <xmr:S6QAaZiguqEHsHbXJxhDz4WBb14BsLTdr0b7ySeJ_qSP3kDJD4nsEiKruKD0-BeBsVbNo417oNUgLOeRGWgNzKoWmj1gI5HzJnn41JC8wQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:S6QAaVx0qU3_fDcc6lioguMC1Li25um05G68kPrmrMPLOzmfQkKsJA>
    <xmx:S6QAacKu4saEpSBPtwnfqRuLGjhG2y25UZNvdG16cKu0M0D8De61_w>
    <xmx:S6QAacQ18LjJ_2yinNi26itvCpFwwhCa1ArKtYh07ObTgTHebI0JNg>
    <xmx:S6QAaUoGGIXOFKouyj9GpRJNhO5AOqQX0ns4Y4lB61Qcz8Kl2vTeJg>
    <xmx:S6QAaSrHpkNxo-kaNHwkHgfsnGC13B-ZrEMwrwhA2PFbQOeC7QH2iAff>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 07:08:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ff7c7892 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 28 Oct 2025 11:08:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Oct 2025 12:08:37 +0100
Subject: [PATCH 7/8] packfile: always add packfiles to MRU when adding a
 pack
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-pks-packfiles-store-drop-list-v1-7-1a3b82030a7a@pks.im>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
In-Reply-To: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

When adding a packfile to it store we add it both to the list and map of
packfiles, but we don't append it to the most-recently-used list of
packs. We do know to add the packfile to the MRU list as soon as we
access any of its objects, but in between we're being inconistent. It
doesn't help that there are some subsystems that _do_ add the packfile
to the MRU after having added it, which only adds to the confusion.

Refactor the code so that we unconditionally add packfiles to the MRU
when adding them to a packfile store.

Note that this does not allow us to drop `packfile_store_prepare_mru()`
just yet: while the MRU list is already populated with all packs now,
the order in which we add these packs is indeterministic for most of the
part. So by first calling `sort_pack()` on the other packfile list and
then re-preparing the MRU list we inherit its sorting.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     | 2 --
 packfile.c | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 8022be9a45e..24e1e721754 100644
--- a/midx.c
+++ b/midx.c
@@ -462,8 +462,6 @@ int prepare_midx_pack(struct multi_pack_index *m,
 		    m->pack_names[pack_int_id]);
 	p = packfile_store_load_pack(r->objects->packfiles,
 				     pack_name.buf, m->source->local);
-	if (p)
-		packfile_list_append(&m->source->odb->packfiles->mru, p);
 	strbuf_release(&pack_name);
 
 	if (!p) {
diff --git a/packfile.c b/packfile.c
index f8158c1aa52..79d2b27c42c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -871,6 +871,7 @@ void packfile_store_add_pack(struct packfile_store *store,
 		pack_open_fds++;
 
 	packfile_list_prepend(&store->packs, pack);
+	packfile_list_append(&store->mru, pack);
 
 	strmap_put(&store->packs_by_path, pack->pack_name, pack);
 }

-- 
2.51.2.997.g839fc31de9.dirty

