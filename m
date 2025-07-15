Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426F92D9EC6
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578989; cv=none; b=a160FBW7tOMaLD6unBaiUskx6MkCweZQEGzy17z0XKLWFSSI8SWrlM6KaqCUH2Sswvaf16Ovr+o9K6VCQnFIlLHgmFl8INPOzN7tlhiYmjRv3LwcaLVRgU2SPpVB82ClKn7rcmgCnbqx3ztIDVx7EU6EsJ1WdFwPKPwczh/9kWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578989; c=relaxed/simple;
	bh=8FtIGUGeai7cXp39cPuTwANwaxzTolyLOqhDG+667cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iYY2obLmrMsGkCqlJqBV+WiWuMd0ZP/zM7jVpBFcWq491vCIShyGIbuUmFT/XxDDg/3KS9CbsIOiRDeMLXm1V3bhBRhuJtrnhP4UJzSveCzHAxtiOoGagXTOGX3rH4wVAc00zTUEd1TZqB7vOXhsnWM36Jz1/cZIVpZu9RGwW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HFzTANR5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gOjskOUX; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HFzTANR5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gOjskOUX"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7C71C14002D9;
	Tue, 15 Jul 2025 07:29:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 15 Jul 2025 07:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752578987;
	 x=1752665387; bh=yRPjUDFZjc051ncSk2ezc81LadD/+qaWTnzVFWpMBAA=; b=
	HFzTANR5jkIMfsxyG2FesEd2kY2q0ho8bX4ekWR9BkPDWWXLy5rRvki/tOxFJXND
	ucSZClr7SZ2gQIE0GjQflgTrDGhJGUS8NFq9zRFvhdWJmzbHXoU+tdZuMpMlVFh+
	RLiq7wFOLIaxulLIDg+1zFevFC0E0bVmUUnjLlVx20UyhlzqIjMObQit66rn9Mto
	nMdzxRvC60YeIOgCuTJZgxgsndclwtmfOFETyGV4md+46JUOYl63rrza4TYAU/Ep
	U6AfUtQyLxxVuofmPOqR3Ea9O/m073nlF6ist0IsS5ceDpgF0AUCCPw2+oj6y1k2
	C+cUY4rCM02W4SjDyMk3uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752578987; x=
	1752665387; bh=yRPjUDFZjc051ncSk2ezc81LadD/+qaWTnzVFWpMBAA=; b=g
	OjskOUXcyBDKGPwpOrfHAsPML9CXGy/dzjbHo/PNIuWWiPGU6QnnJfUt2v69G+j0
	g9iLO0byvTwkUNEpnp4VYd3uqJc5Umoef8QSEGcCMvhaLAtIiWJd9WPitqJL/djd
	AoqpVPvl6g8Cxk3nooHq42qv4toENSwdg41A8+jmLWGFrSc07nKav7NYtaiIuD7I
	qp81fZpVA6LcbByyRirvr7zNuZQwsce5i+G7K1mCVslDk3dDgF/I6tt5kWW8QP9H
	QvuteEg/Zn9p5aiwfivwDMyL/monu1Htk5fFCWJBlkAKrMK/4MZoaYYP0xrmHmt+
	bSSEy4ZWHlLEdATuDzXAQ==
X-ME-Sender: <xms:qzt2aJglhTwgTCNLB8jD7h_xMUJe-MZFbHqkVS38sDLxTBSn0rjWNA>
    <xme:qzt2aImfgUo_kATFchW47PVwL3FuxQ8dED3s6GFkPwUEUTx4lNxnxuca4kV7Fyyiv
    KXYauhWWv5ZPPIxOQ>
X-ME-Received: <xmr:qzt2aFoR8ucaxdBYFmQa1kKpomxpGwZefUl8n7_SGQbmE0lTCDhorNB9CiT1Mv2XFs-LXreq9-5JSclBeayJoGHfa3l2bZvjlTsBsu0kGNnILg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:qzt2aBF14fXT7K-WNl3imZhKD_yrOS5rXY7Gq0loNXJrJ3yDCEIOZg>
    <xmx:qzt2aBxsbjgDR5HyjHzZo3wpEtgHQoICdNm8i4ydnHqA771p_VMbkw>
    <xmx:qzt2aGpD4LVGaQ2lWiPxQcexne-St_KPyzkeBMWUcnrkApsNujmXmQ>
    <xmx:qzt2aLjW8hmJL7AcuzkCny_hcXc0us39BAwQKSV0nCpx1fV1Wv7taA>
    <xmx:qzt2aInn4Sn0JzJnzD1kjwNSdWKr1biWlDpkPm-oDSHg3QLuZZh8BYnh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 07:29:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e0d2082 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 11:29:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Jul 2025 13:29:22 +0200
Subject: [PATCH v2 5/7] packfile: stop using linked MIDX list in
 `find_pack_entry()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-b4-pks-midx-via-odb-alternate-v2-5-b0ca0b4b516e@pks.im>
References: <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
In-Reply-To: <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Refactor `find_pack_entry()` so that we stop using the linked list of
multi-pack indices. Note that there is no need to explicitly prepare
alternates, and neither do we have to use `get_multi_pack_index()`,
because `prepare_packed_git()` already takes care of populating all data
structures for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/packfile.c b/packfile.c
index d0f38a02035..2d19c53ea96 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2074,16 +2074,15 @@ static int fill_pack_entry(const struct object_id *oid,
 int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e)
 {
 	struct list_head *pos;
-	struct multi_pack_index *m;
 
 	prepare_packed_git(r);
-	if (!r->objects->packed_git && !r->objects->multi_pack_index)
-		return 0;
 
-	for (m = r->objects->multi_pack_index; m; m = m->next) {
-		if (fill_midx_entry(r, oid, e, m))
+	for (struct odb_source *source = r->objects->sources; source; source = source->next)
+		if (source->midx && fill_midx_entry(r, oid, e, source->midx))
 			return 1;
-	}
+
+	if (!r->objects->packed_git)
+		return 0;
 
 	list_for_each(pos, &r->objects->packed_git_mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);

-- 
2.50.1.404.ge9779f6434.dirty

