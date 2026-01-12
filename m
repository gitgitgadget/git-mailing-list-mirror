Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270330EF6C
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208476; cv=none; b=jpYzhbYhP5mG70Wkxs+90wrHDCm5UhBohcdFWXg18bmDT2t44VAohzq2pUlGhIZBNMyOTh70mhV5ySS8QhoW/J5MUl9BS8jGxBlfAUx1F1btIJCE7VN1tUomiXut4Oj6O2vgY6yqHb9qOtWAaOXJdCMA1UhNGIW5xljApG48K2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208476; c=relaxed/simple;
	bh=/C8lU5cI9SFiIhmcyYvXSyUbHuB84jjLWo9Or+udTnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YCgbeVNVSwDY0qatf1Dm5+TwxoAPtjaC5T4qAUwRrhDy8FlCA8XVcNaPTUGPaJoAzY88/69WnKRP68MxNJO5OzLNJG5eBK3dmd1orLB6umccDrRXoSfEa5VvbS/8pXZhKku0RPrPSsHCblpqIflzaFyosEwvtobmLY8kFloqBCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BuGSLHHV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JQT5hOfI; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BuGSLHHV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JQT5hOfI"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 51B0C7A0023;
	Mon, 12 Jan 2026 04:01:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 12 Jan 2026 04:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208472;
	 x=1768294872; bh=BR093gGUKPJXRAQ+znjT+0GeLJtj+bMW6BO7tmwgHyg=; b=
	BuGSLHHV0ZShAhj8ZKTt8R/LNqK3pt8gzgaWLmV7jYbO3BQNiXaWvRXLjpPBGY3x
	zgzGoplgFnW9F2wW8itp0Oq0FGSt4CYwgt3X2WL3UCzk7nGYt7jTKWOFMqHp259J
	JHnKZsDmkqo+EouECNW7G3VZ60BvsXDmJZQILi+nIhKTM7gMXwLU5h9DZrj36546
	WgiG3Ix22J32/SBdWZHF2Hvfve6m292fY0ZBpwXPXEqGmFhUpT+0vtTTx6AcHC9A
	QpgsFcCcA6eOJJgkSla/cxH9nEI9J5GpmuwGn0DE2dxQxMKQEtFHT7gEjUEAjlbX
	9mKb7dKI0t3ajHoW3fbyBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208472; x=
	1768294872; bh=BR093gGUKPJXRAQ+znjT+0GeLJtj+bMW6BO7tmwgHyg=; b=J
	QT5hOfIX9wQCerz/+tXUTjm3iAPlU/umIo97/YoLUUlG3hWKecfKB3tZYChKvR8c
	0CWGzdLw9JClJSfFoeoq5JQ2N1HLwyjKwebyDb7Er3jrTRAE185lDUz4IaProWo+
	aoEVPx7k1V6Sg2anBkun964TFbWePiMzeBvwtdmiJ2QpstjSiIL4HZylsIrD8OYa
	kr/cRY63wkb4Y6Ljbxse+EFPsUGl/sd40/mpsY1hsdSz79qpO1JCBSp9J3ZTILVL
	x/DOi/ykySx8Rg/fB97ehIBVTJOUlYIt/97r2qT2x8+A+s+KjaQHycK12hFa5D2l
	FdpsYASpY+gQGQP249S1Q==
X-ME-Sender: <xms:WLhkaYogO1Bj_4GuTts8Bg3ntrq-VCNXravkkBRKgyoNUDvCGi2EYw>
    <xme:WLhkaSUYEusxvLQ9C7MQk70wtl71KCrxwGVKbiTM4QO9nLbS86C6MLmAMk8m8R0xa
    _ChgG73WPwTIz7cczr4N38Mcqt6bnrGq2hcKUeNLvxLi5Kko7CaUQ>
X-ME-Received: <xmr:WLhkaXDgRPmtkxEDoV7402WGgSXfYq9vKp3HIZcvuEB46K5_r_ZSKg1OpYDW7zfUw2WG_Kc2x1Ja1v1slZgtvUckyqxCW7Pq4qy3UFTk1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    eprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:WLhkaW2fJe-0WU-6ogqbaFTxr5tlta3x3bZ5CYebyUsQl_SlprUP8g>
    <xmx:WLhkaZ2eMoUaKf6yZuTMO3od4vep2s1bXD71OCW3lDGMfFeogDCXxw>
    <xmx:WLhkabC1-h7m2iKz6EtfTPKfJMg6te8DeBJJR_wR7p-NUhzJCvV0_A>
    <xmx:WLhkaY7yQ5xtmdhZs1kQANvGsGLZA_Pg1kYkzQugicaro3LtfjCHBg>
    <xmx:WLhkaaIMxGdodk_5m2AUiu_IU6s6LN9pdB_NkZ5ghhR_qfzqlD9EqV2m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:01:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aba597e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:01:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:00:46 +0100
Subject: [PATCH v5 6/7] packfile: skip unpacking object header for disk
 size requests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260112-b4-pks-odb-read-object-info-improvements-v5-6-9a6124e95bf2@pks.im>
References: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
In-Reply-To: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

While most of the object info requests for a packed object require us to
unpack its headers, reading its disk size doesn't. We still unpack the
object header in that case though, which is unnecessary work.

Skip reading the header if only the disk size is requested. This leads
to a small speedup when reading disk size, only. The following benchmark
was done in the Git repository:

    Benchmark 1: ./git rev-list --disk-usage HEAD (rev = HEAD~)
      Time (mean ± σ):     105.2 ms ±   0.6 ms    [User: 91.4 ms, System: 13.3 ms]
      Range (min … max):   103.7 ms … 106.0 ms    27 runs

    Benchmark 2: ./git rev-list --disk-usage HEAD (rev = HEAD)
      Time (mean ± σ):      96.7 ms ±   0.4 ms    [User: 86.2 ms, System: 10.0 ms]
      Range (min … max):    96.2 ms …  98.1 ms    30 runs

    Summary
      ./git rev-list --disk-usage HEAD (rev = HEAD) ran
        1.09 ± 0.01 times faster than ./git rev-list --disk-usage HEAD (rev = HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index 8c6ef45a67..a2ba237ce7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1586,7 +1586,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	struct pack_window *w_curs = NULL;
 	unsigned long size;
 	off_t curpos = obj_offset;
-	enum object_type type;
+	enum object_type type = OBJ_NONE;
 	int ret;
 
 	/*
@@ -1598,7 +1598,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 						      &type);
 		if (!*oi->contentp)
 			type = OBJ_BAD;
-	} else {
+	} else if (oi->sizep || oi->typep || oi->delta_base_oid) {
 		type = unpack_object_header(p, &w_curs, &curpos, &size);
 	}
 
@@ -1662,6 +1662,9 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	oi->u.packed.pack = p;
 
 	switch (type) {
+	case OBJ_NONE:
+		oi->u.packed.type = PACKED_OBJECT_TYPE_UNKNOWN;
+		break;
 	case OBJ_REF_DELTA:
 		oi->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
 		break;

-- 
2.52.0.590.g1f87b77810.dirty

