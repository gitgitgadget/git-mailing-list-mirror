Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8893F3546E0
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820740; cv=none; b=Efv/WP+JjEOAJAxstCLihexfT3fn/3x+Kd3O98Uq1zRbiYXnnEvt2fwEDALf7UfSiyXNzU39HZ2sVc92sJ5MV7PWS7FUKP6p5u7MqnWOAIGFxJMYHht7oD0vnJpY9sC54Y7nahzzknh3bKro4xaIlQoduOluyxsfO/iohN3iVDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820740; c=relaxed/simple;
	bh=sU1KGexVpjGzOQJPFqV7lDWme679r8KgGE2bA+8V8Bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ta39tFmKFuxv7UN1Ho6vxE1+k+/bp/PbBnmFYAc8MPPXUT/6O4uDpTwnJtKxaSw+zXPTmtWJeeeFOwPg7sd/9vpuMMvZuBanLEk/kWCn4K2bXQVvok5hwAExj2r8b24YOEhwPVlrxv1uMx2dpnuSOippo+44AHa4rcO+eP9S1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pe7lVfPy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y29KNxsx; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pe7lVfPy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y29KNxsx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D1AC3EC01C9;
	Thu, 30 Oct 2025 06:38:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 06:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761820737;
	 x=1761907137; bh=7dLLSGqV84JUxhLMgbHCcIw5l6B1oHni29Nf6CjmuTI=; b=
	Pe7lVfPyse0zpV9JHjQoPW3wBuz/FStZzHzHLcplCQpdAz8xX6hFI4/J/WJ5DaUH
	c1LUAzpxpjDYINixwvPrNm7Ag9RHtezLTyurPN6vxRgX07a1c5XnxxmbWN6Vdtk3
	B68WMipWz7QFO6Yunu7Kvphigz8ZQpC3g98C4vQeMXf8x1jOoNlgHhY/U9UKq/pJ
	+apoNs7MfFrgUzuRjjqUo5a2TO62vCQFllDdBk6pEYGU3OP1hs4BAzfByapOyl1E
	PV+UEcZpjiwXt8Wm/Fnm0GQH1cJqk/65glIdBH6uUH2XbyoAAooR2YRb5oxlw713
	x5CFKQ2XXXodeatT0dM7Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761820737; x=
	1761907137; bh=7dLLSGqV84JUxhLMgbHCcIw5l6B1oHni29Nf6CjmuTI=; b=y
	29KNxsxSbYIgsNXy7wJ/1zuerLW5GaLa4d4YjN/B8TPr2ywLH1jNbLxex0pT1Aq+
	iznBQW6UB7kFADSkB8qqs2oYMIH+7fRNTAWF3X7sw5lJ0DpjVy6uxMbP4HSyJ9Gv
	Mn+jD7LXl+FkM5oaKFw4DYbPBm3mPx1hr61fLuHCYJrE2WkjSe1NtZUIyAvPEYSg
	8LYte01xMhzZOBLvhlFDNKMoGvPZdkk4t5FGjbG3pVbDmTBPcHLNuznTvDCUzhUb
	qKIrfoB7diGodRVqh8xD+TeCafoq7wLbxv23irKFnq4gHZhjO/7JmhW9f9JnJE/0
	Y5B19aMWW3A+Bo2XD9pvQ==
X-ME-Sender: <xms:QUADaVlytWORrzTyqproOgST47GJED6nZ_mj5ddu6OyDdKSr4JKH5w>
    <xme:QUADaX1mOHQ67J4aJelj2D_UslAcnSyRbZ2jRhleSuI4IEllPr0ZSSugzAJemUNxE
    S5rpklFOfggT6wa19D9HxsWMlqx87qp9SyKmraUCeImkalnctLB>
X-ME-Received: <xmr:QUADaQr_PXc4s6v4BT0ssVsV2ZrS2xQYOFhuyKBZIt9BhlINpW43Q9sONktLMhnh-V8vj2J6tMkftNKBiHMe5TTNIaj5lFgZn1M9k4ZYpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeifeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:QUADaUeh4Bo-RTUjuB3JGXKGh_W51xQtOu6mIA_XFtM0FWSTJVltiQ>
    <xmx:QUADafqqPy_nBS930AMMGQkk0UrDKRSGySkWB-wkyAR0qdkxcIj2ew>
    <xmx:QUADaVG2xgpxAz1xXVEOFbE8sq8FszQy64rAyYO4iPXEO1bVQ_VMwg>
    <xmx:QUADaft5__Z2WIzxG_fzKiqIz2SWMqnbrHa_-FEJH4FDTsj_Z2bkTg>
    <xmx:QUADacKVaNJYO1wM-eVTDVOFoOwJKu2eIUhzdfwNO_6f0B2B2QVSVvgi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 06:38:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ce3949c3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 10:38:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Oct 2025 11:38:41 +0100
Subject: [PATCH v2 4/8] packfile: fix approximation of object counts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-pks-packfiles-store-drop-list-v2-4-84654f080cc0@pks.im>
References: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>
In-Reply-To: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.3

When approximating the number of objects in a repository we only take
into account two data sources, the multi-pack index and the packfile
indices, as both of these data structures allow us to easily figure out
how many objects they contain.

But the way we currently approximate the number of objects is broken in
presence of a multi-pack index. This is due to two separate reasons:

  - We have recently introduced initial infrastructure for incremental
    multi-pack indices. Starting with that series, `num_objects` only
    counts the number of objects of a specific layer of the MIDX chain,
    so we do not take into account objects from parent layers.

    This issue is fixed by adding `num_objects_in_base`, which contains
    the sum of all objects in previous layers.

  - When using the multi-pack index we may count objects contained in
    packfiles twice: once via the multi-pack index, but then we again
    count them via the packfile itself.

    This issue is fixed by skipping any packfiles that have an MIDX.

Overall, given that we _always_ count the packs, we can only end up
overestimating the number of objects, and the overestimation is limited
to a factor of two at most.

The consequences of those issues are very limited though, as we only
approximate object counts in a small number of cases:

  - When writing a commit-graph we use the approximate object count to
    display the upper limit of a progress display.

  - In `repo_find_unique_abbrev_r()` we use it to specify a lower limit
    of how many hex digits we want to abbreviate to. Given that we use
    power-of-two here to derive the lower limit we may end up with an
    abbreviated hash that is one digit longer than required.

  - In `estimate_repack_memory()` we may end up overestimating how much
    memory a repack needs to pack objects. Conseuqently, we may end up
    dropping some packfiles from a repack.

None of these are really game-changing. But it's nice to fix those
issues regardless.

While at it, convert the code to use `repo_for_each_pack()`.
Furthermore, use `odb_prepare_alternates()` instead of explicitly
preparing the packfile store. We really only want to prepare the object
database sources, and `get_multi_pack_index()` already knows to prepare
the packfile store for us.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 6aa2ca8ac9e..b07509b69bd 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1143,16 +1143,16 @@ unsigned long repo_approximate_object_count(struct repository *r)
 		unsigned long count = 0;
 		struct packed_git *p;
 
-		packfile_store_prepare(r->objects->packfiles);
+		odb_prepare_alternates(r->objects);
 
 		for (source = r->objects->sources; source; source = source->next) {
 			struct multi_pack_index *m = get_multi_pack_index(source);
 			if (m)
-				count += m->num_objects;
+				count += m->num_objects + m->num_objects_in_base;
 		}
 
-		for (p = r->objects->packfiles->packs; p; p = p->next) {
-			if (open_pack_index(p))
+		repo_for_each_pack(r, p) {
+			if (p->multi_pack_index || open_pack_index(p))
 				continue;
 			count += p->num_objects;
 		}

-- 
2.51.2.997.g839fc31de9.dirty

