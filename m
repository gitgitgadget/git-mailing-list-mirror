Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B12D73A7
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040940; cv=none; b=aDhKBISyDqqsCYB1KHjTtaDvRTyaa7umLbnIXuTT4qdrQexxqpHLrSIMSjw0c2aM61P62y0MD1FNYrxkIiVcK+AQnPh4dN5p+DUhIaEB1P6NLQLj81+W38dYmBc/m5GFnl59ce+pA7pS8bIvj3fKYdbigj+UjgmfpospFlHa3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040940; c=relaxed/simple;
	bh=547FGJ9dj5qca1Ur2AovH24ciDwqApBdzx5/QkFXHmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7cy/+w+v37ntWMJygYaNRBxAVT7pKJ1QClhnRzs5n6uiX9whrP6bhSbhEy5/f1jx0ncdLsrencc7ThT8hj0XMAelmetn+pU7iYe6llsnQ/yYcMe6JiPsnF46Tgskz1Cx5TJgJJeiBJEufmv2HNHFtGwmVe3TowjRTtjXelGrEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W3vedk9K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=onqmr1EP; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W3vedk9K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="onqmr1EP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id F0A991D000A4;
	Thu, 18 Dec 2025 01:55:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 18 Dec 2025 01:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766040937;
	 x=1766127337; bh=5o/QQPH4yOGz57JRIHC/c6qoPqezyKVoczjeQsv9uJg=; b=
	W3vedk9KiK5QjWahc3qfo387YyenE3Y4mo3GwEfDYfWV+cBy5Sk5yNLp1wTzDTL+
	k4VuR9QSJ/mXqvUpg52qxK38IM3urGDZ91SrD/H5C2lXgzb/lmxek98iJxhcLaeS
	naJi9W6yIekJXHYAZF+edcz178wuPCCy9DXWh9CgMbP3dLHG7ZpipN5k9WcKqR5O
	QLeCcd79QXqfyYAn7TqOgifY+BpD4bvMDGa3viRf37sd9oFMw9ZzOXjd3RebEzTm
	2RYdIQ8yDyAmfEOJFRFpvmtG1xbGSmeq0HUy62P98cPyAQ5jbBlFncUbL+YRMdET
	tUlHh9UmOBuC36ls3vKi8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766040937; x=
	1766127337; bh=5o/QQPH4yOGz57JRIHC/c6qoPqezyKVoczjeQsv9uJg=; b=o
	nqmr1EPVVZIYcK8PIxdAi2PnEBrWcQkJLexzqrD/ZJlFXU6R1G3kl/H/enWJFwtr
	EQlnaenp9/cRCrA3VS+n89YazC5i+WmUYuqV5h1B7epuUdLkb25pK8b8VbX2l/cO
	/oMoE9aFY4fI1TE+25av9QfrrrtuFPlEhHcOBRkyIhmv+x1ZDktC4eVQGIeiDmYb
	kSSTdQ79DTGo2+PPBBUKg5udHSiKSIpgZ7a1nUCwUttWvVAiSXwYb5/YjGDA9cQ9
	HlX/Di0Qr2CXkMv9+JD08cBLqAakZaaij/f4UOR93+3kfxzr5ruluYhsNWWxpJ1S
	ULH9tdx7UlrEyENS7W9ng==
X-ME-Sender: <xms:aaVDaXrntY6MU41mHBj1zd-4gVPZVgokEgXwdKSUfAE1DaB1Xda0Ig>
    <xme:aaVDaXrKdjpaUu59Rvrs3c7fx2UDeYoT6YQyR_I9CFJ61gn2ix7oUDPmhl9snrDsd
    ct7J-dWIC7KPrm2QG4hoo6_RaQZ2RgoCBWE7cNK1BgG0aDjTxDlZTk>
X-ME-Received: <xmr:aaVDaR3IPkcXHIx2_Wf4nt-1zKTWjLKH25O1XB6X15spRk6QomF5DkEK2TkQhU0VzaFKI0ALqDmfKzSIANtmCdxC-_5p5V_GjyByS5QxSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:aaVDaWCLG4bqwgfvs1Bgdj64t-KXkPhPr63x7zDFCQkPMOD_pP6vHA>
    <xmx:aaVDaZcVOX_kjutDDdL1RHH8liRMc2UWgjLD6dkhadHwkRrjrR8qjQ>
    <xmx:aaVDabjGf-v_RcDo3AEAgUpksZb83d_izWZxFPwZFMD_WBYRGZ7eyg>
    <xmx:aaVDaRqfJa_2eHv-34K0IXilUpwTf16XucoLRGHf2IeZ41_sxIhLoQ>
    <xmx:aaVDaRZKjYVSXE3GrPbRAJTrxvnarkRzje_6Hxf5xlq3PFskIpM1j16V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:55:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8ddcdb9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:55:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 07:55:23 +0100
Subject: [PATCH v2 04/10] packfile: refactor misleading code when unusing
 pack windows
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-pack-store-via-source-v2-4-62849007ce21@pks.im>
References: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
In-Reply-To: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

The function `unuse_one_window()` is responsible for unmapping one of
the packfile windows, which is done when we have exceeded the allowed
number of window.

The function receives a `struct packed_git` as input, which serves as an
additional packfile that should be considered to be closed. If not
given, we seemingly skip that and instead go through all of the
repository's packfiles. The conditional that checks whether we have a
packfile though does not make much sense anymore, as we dereference the
packfile regardless of whether or not it is a `NULL` pointer to derive
the repository's packfile store.

The function was originally introduced via f0e17e86e1 (pack: move
release_pack_memory(), 2017-08-18), and here we indeed had a caller that
passed a `NULL` pointer. That caller was later removed via 9827d4c185
(packfile: drop release_pack_memory(), 2019-08-12), so starting with
that commit we always pass a `struct packed_git`. In 9c5ce06d74
(packfile: use `repository` from `packed_git` directly, 2024-12-03) we
then inadvertently started to rely on the fact that the pointer is never
`NULL` because we use it now to identify the repository.

Arguably, it didn't really make sense in the first place that the caller
provides a packfile, as the selected window would have been overridden
anyway by the subsequent loop over all packfiles if there was an older
window. So the overall logic is quite misleading overall. The only case
where it _could_ make a difference is when there were two packfiles with
the same `last_used` value, but that case doesn't ever happen because
the `pack_used_ctr` is strictly increasing.

Refactor the code so that we instead pass in the object database to
help make the code less misleading.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/packfile.c b/packfile.c
index 191344eb1c..3700612465 100644
--- a/packfile.c
+++ b/packfile.c
@@ -355,16 +355,15 @@ static void scan_windows(struct packed_git *p,
 	}
 }
 
-static int unuse_one_window(struct packed_git *current)
+static int unuse_one_window(struct object_database *odb)
 {
 	struct packfile_list_entry *e;
 	struct packed_git *lru_p = NULL;
 	struct pack_window *lru_w = NULL, *lru_l = NULL;
 
-	if (current)
-		scan_windows(current, &lru_p, &lru_w, &lru_l);
-	for (e = current->repo->objects->packfiles->packs.head; e; e = e->next)
+	for (e = odb->packfiles->packs.head; e; e = e->next)
 		scan_windows(e->pack, &lru_p, &lru_w, &lru_l);
+
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
 		pack_mapped -= lru_w->len;
@@ -740,8 +739,8 @@ unsigned char *use_pack(struct packed_git *p,
 			win->len = (size_t)len;
 			pack_mapped += win->len;
 
-			while (settings->packed_git_limit < pack_mapped
-				&& unuse_one_window(p))
+			while (settings->packed_git_limit < pack_mapped &&
+			       unuse_one_window(p->repo->objects))
 				; /* nothing */
 			win->base = xmmap_gently(NULL, win->len,
 				PROT_READ, MAP_PRIVATE,

-- 
2.52.0.351.gbe84eed79e.dirty

