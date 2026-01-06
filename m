Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477E307AD5
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767682517; cv=none; b=ssGoKIoj7RYEJuhJMu+eT0RKK2ZsYJhPINwr9kFuspqs5DWduTFwupho4bniEDsJwbN5UwukOhSKNV6qdB2Tdc1XpGSWB4CWgAAHqzP8fMuRlpfadTp/b+hg1IW3DW9AcHNqgg+jIiArLAfoTPAfKeEo7tuhlBXacAlo2ludipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767682517; c=relaxed/simple;
	bh=LTcc1ZYSfVu44uuujd+q9WTO5WpzYQITgTtrSHMhslE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxQ7h2hmpz91W8chZEIGxI8a9ihJZyIb9h4zTB6oZE7dzsJes/dQPYk6eRpyrdzncsWB5UN8AnLYHz1w+6HW3tyxniBJ9YEjUkBCvUjfrxjhALy3j0jfiHxCEF60B7t+aBkMvP62iTjZfeoDgOxGWydonpWuUx4V1c4dnRDJ0bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qi2XG2ua; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EkcV06jE; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qi2XG2ua";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EkcV06jE"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B53477A00EC;
	Tue,  6 Jan 2026 01:55:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 06 Jan 2026 01:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767682513;
	 x=1767768913; bh=AJFUidmJn5Pzuw137DUyOubc9KP9V1fUXLTPuX2eT54=; b=
	Qi2XG2uaIikJWG5FfI6gC4C5Mi+hF4BYW2aPUAdJa5/TO2H0AE2ufvGyl725CthA
	m8qrN8jKD3pwZ97JVD9K33s2kLk37WkNuHJOuaDq1AyOHrNj5pM+X8GMg5f7jifJ
	3Bn6nJtDQGjSkiKnphxwZ/pz2lT3yvpuVyiGeLr3tACWGDLVZf696PFzu63BdiEr
	gqhy0PYtnzuykqfFUtq4shla47RAu3x4L3vHfMS1MLPLaANRLPnlQz6itjkeeUyo
	EEMJkDwbJKw5oaKRsxqiyVDU0iabQzDprwvSPbJ7uNZxnSSf3ieK/c/iodLtzUfk
	E9Ns1GllMTNSvyLp5JfdMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767682513; x=
	1767768913; bh=AJFUidmJn5Pzuw137DUyOubc9KP9V1fUXLTPuX2eT54=; b=E
	kcV06jEebjz5QRUV2d47P9TmUA6e+QBlsYG5WGQKv0CuB+1BuoPi+gERgyeeikhe
	CmWXXDpwI8HCZMRu0i+NXmycOtWtBcoIkbtNd9g7gA3WethjkPzbShes49KkTOpa
	ugMbMfqf1HOBWWx3AunFSUMS+oj3JQA1AQgjvDxdN9yNa2kZXMnWIkIzrdloREqn
	4CP/e00+hXmp0DZ5YTF9pj65OdM2MTgBCt6XfPuXhNtURoCRFCjKTLKFNzYbW11/
	rt57IyOy0DRTFyU4+ij8grsor1LY4GLbtJSRE2l04tykOxlXtQN5glOLUXPDLefF
	cIclDaVSfxiUbLKGGS+0w==
X-ME-Sender: <xms:0bFcaa9lnZNIw1NAeGB3cB8kWvdQe3nhaQp9fevSiLnl5jbabwRnHw>
    <xme:0bFcaRls4N3_hejtjCC5yuxFo2MFwqtCOxPVelQ8st4Wd8kIaiyxx8mXlFneBaQ-k
    qwCN0VKUInyqnVslEfzAEpcZKqIAxmpDFVcWlGcLYW0eQNg5qdN-w>
X-ME-Received: <xmr:0bFcaYUPyxHRHeledVZ8eYmOtWgy0x2tTk_kae8h2rxRMFOFCe12aVjuPjw1PeECBkJNzzJxGVpwhfqf7vD0HmIRWmT4yGaVxkYUyoI_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:0bFcaeFDpC0FIpitAxa51sINZzMp4Pn-9Pp-JYwLpJ5sehVI_pi7BA>
    <xmx:0bFcacfJbuqJdi0hhBO8VF6ngH0M87o-fovoZd1q6t5OHxiGMpfLxA>
    <xmx:0bFcaXIN5fMRyePysPAUEoDPb8ZiVCmU3RWCy6-R94DxyNNZGH4voQ>
    <xmx:0bFcaZFt7DncuBln5O8kkLOwalBjW4uzSGlJBviu_Qp-bgGEk8fnvA>
    <xmx:0bFcacLvArT1e-UH_1xTMjK9GUWqbyDNTede4pqV760Es-KO0IgJjXlm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 01:55:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 618ab449 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 06:55:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 Jan 2026 07:55:00 +0100
Subject: [PATCH v3 4/7] packfile: always populate pack-specific info when
 reading object info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-b4-pks-odb-read-object-info-improvements-v3-4-b5e02fae1fb0@pks.im>
References: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
In-Reply-To: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.3

When reading object information via `packed_object_info()` we may not
populate the object info's packfile-specific fields. This leads to
inconsistent object info depending on whether the info was populated via
`packfile_store_read_object_info()` or `packed_object_info()`.

Fix this inconsistency so that we can always assume the pack info to be
populated when reading object info from a pack.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/packfile.c b/packfile.c
index cc797b2b6a..f7c33a2f77 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1657,6 +1657,20 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	}
 
 	oi->whence = OI_PACKED;
+	oi->u.packed.offset = obj_offset;
+	oi->u.packed.pack = p;
+
+	switch (type) {
+	case OBJ_REF_DELTA:
+		oi->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
+		break;
+	case OBJ_OFS_DELTA:
+		oi->u.packed.type = PACKED_OBJECT_TYPE_OFS_DELTA;
+		break;
+	default:
+		oi->u.packed.type = PACKED_OBJECT_TYPE_FULL;
+		break;
+	}
 
 out:
 	unuse_pack(&w_curs);
@@ -2156,23 +2170,6 @@ int packfile_store_read_object_info(struct packfile_store *store,
 		return -1;
 	}
 
-	if (oi->whence == OI_PACKED) {
-		oi->u.packed.offset = e.offset;
-		oi->u.packed.pack = e.p;
-
-		switch (rtype) {
-		case OBJ_REF_DELTA:
-			oi->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
-			break;
-		case OBJ_OFS_DELTA:
-			oi->u.packed.type = PACKED_OBJECT_TYPE_OFS_DELTA;
-			break;
-		default:
-			oi->u.packed.type = PACKED_OBJECT_TYPE_FULL;
-			break;
-		}
-	}
-
 	return 0;
 }
 

-- 
2.52.0.508.g883dcfc63e.dirty

