Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4809B23814A
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008719; cv=none; b=FCctRmUYld0xrWeX0lDVDNXjd3Hv2Hk4yrM/4K9ma0uhcqvco5BwvhjzRuax4N59tPGQ82MgoYbJnrIDj/wJKR6hrUnJo9N0xLd/wrJu/+Hhfa08fHzeB5tLu0bonMP0euh8HyKROdl1PnDFO/vg2KGGS1RlxV5KzEjL9Xtdy/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008719; c=relaxed/simple;
	bh=X2rvscZuZT2bPJgO7qRmnypaMrpx0DzlonZ6YMU1bSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NWLyYtZ2zQLItNb3RKF5qsiwD1xG6vONKcekkSk8EZuAn3fCG70AayU61dNScev5ksHXXXq5zj/47NGwK+N/hBA2kHNfc/AJQ+p2emhqD1tAn6gbKwsRfy18/dPJ+qtuZVARwbW8KzDe6If8ajA47vCauy+ShUxoCXi00ipijrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hd1/vKbn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=drMBzZBZ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hd1/vKbn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="drMBzZBZ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 397F725401F4;
	Wed, 30 Apr 2025 06:25:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 30 Apr 2025 06:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746008715;
	 x=1746095115; bh=cslH9NHgn0WLIsCOYm2hK7lG+0QInTHK5uyrhycegMk=; b=
	Hd1/vKbnpFHfpcnKzrvoSSLnlYtvHn/PonpfcxD4MDcmHRj6DFUhDvcclQFap9//
	3Q7AJGrs3SBbg8XQgZ54xbqrVY57rN0OL4SfN9xzxaSwOv8/maD+P1En5sTiNqwp
	7VxNbP2gfWxP1mGqMCFWucwAi0bBKhVKE6e60tfRPnxFTRx8zy0J7YaiDuxOVa94
	NAZzLsKwfwo95bqpixtD7yIHDZzl3Dpa+p7v9j0QzuIgofZBnP7884juDSh5cBjs
	RN4hWoQmAGxN5JebKqcmIiSoUXQSJ6OsvzvYh63LRKC+N6dbyK3yEgdvWrOCeR0D
	3pzBjAA7wBy1zvGxKRC8/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746008715; x=
	1746095115; bh=cslH9NHgn0WLIsCOYm2hK7lG+0QInTHK5uyrhycegMk=; b=d
	rMBzZBZOtaDHqbLnxJhtmqK97avnIRmWcBdsAnVIfj0wJxH1miUnHVWZMFUxfxe1
	1IR72Zp+r7uuaIlsRXJNnvlo7hq0TVD/o0n5vy+pwEmErLPYadsAa4B4R3+tshTr
	330jgjBX6WgAwO3GX3ve/XCFDgAYDGy1rdUdr6Ym1SuvoytZ9Nz7Z5H4A3zs+MBv
	QDSt6Xk5DUr+gCaaedGh04LHGRM+eddTYB2yHcK7SeBNdvgDFhLqltvJwpCRUxsx
	YsxyfdOy3wF3PDs3Velv4KpfNPPGJjj1VhXfr2c/hnXVWGNwoZf1HxO5QcUrXnjl
	NR5ZKAjyUj8MpZ5ZzgOng==
X-ME-Sender: <xms:ivoRaIDtcRJau3hP0BCD9fXWI-fTdWMmzVOxLJrfG2DMsdZUvhC6yg>
    <xme:ivoRaKg72W-uCAkwSrzl7eh8UVBewBUFeSqFFZwVKMBAGIejexfN_ATiPheL_NjH-
    x9z8Qs0RiyPnq3G8A>
X-ME-Received: <xmr:ivoRaLmuV3EjzRQyoz8xsCG9ZcqWyDQ3sQdrTMkls1-nMMhwglGhzBSy6WbCz1Okzd6U0QmYICFgP8PMVcxrSfqrDuNcq-5Iw_vFnzEi63-ZdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeigeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ivoRaOwGv87be85XYCx6ed5HpOFOJ_5kCPm2oGW9hOkZEnmevbS6Aw>
    <xmx:ivoRaNS-Ye3nv_nKWf4x9f5iYjK-dvoo7KTaupN6G_t5jYaLip6upA>
    <xmx:ivoRaJZUZyhGeSkTd1OmB4DGiTtA4iUivjsyvUky-DOCdSKpATtlzw>
    <xmx:ivoRaGRZ44pDkzpoa1yD3nsWa16qOvr1Xgs6GpSs2zyCo75Y8PQgSg>
    <xmx:i_oRaEubVk5wp0UrwSqEhzVGO7rnerufx56vJtZhi6J8o7WTUtwhGvLb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 06:25:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 53d2c8b0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Apr 2025 10:25:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 30 Apr 2025 12:25:05 +0200
Subject: [PATCH v2 1/8] builtin/gc: fix indentation of `cmd_gc()`
 parameters
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-pks-maintenance-missing-tasks-v2-1-2580b7b8ca3a@pks.im>
References: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
In-Reply-To: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
X-Mailer: b4 0.14.2

The parameters of `cmd_gc()` aren't indented properly. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index d5c75be2522..a73ec22fb18 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -724,9 +724,9 @@ static void gc_before_repack(struct maintenance_run_opts *opts,
 }
 
 int cmd_gc(int argc,
-const char **argv,
-const char *prefix,
-struct repository *repo UNUSED)
+	   const char **argv,
+	   const char *prefix,
+	   struct repository *repo UNUSED)
 {
 	int aggressive = 0;
 	int quiet = 0;

-- 
2.49.0.987.g0cc8ee98dc.dirty

