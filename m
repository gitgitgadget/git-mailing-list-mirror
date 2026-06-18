Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD0D3AEF4F
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 06:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765695; cv=none; b=eAR4l4xR4zkXp8qkcdtDhyJSYSubECG7nqmF8wUAIo0EIVPkdGXuXa4pN4KezKsUsvwsSYuwbuGY/mqBeyQt04OUxUTARPbC3HsEDyqXXeeIG/JXmcxgBXr2D7kfOZnWZ7XfhfjDAxMsZ66Ky+w+SCgVdZvDs4ofX7P0LJD0GPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765695; c=relaxed/simple;
	bh=8F5UGkIyK6hrNULg24dlywRKKMWYc3+FdNXrmMLArgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ky+WwXGr7IHTSLr2rAdfKdVzeXuXgB+aJ5KW9G92Xhy2LvIv/PdLb4H702CCZOkLBYBCu1Y6kbx/BAhZ6TfCoRsMdSbO/RzGxAXqP7+yrtezmppEqyUc0jgN6XIQ9K4kfZx/rqjj/FCNPgmTQC5MsHRNvrCpykQfod8C4R/U2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WTknaCnM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EPfELtux; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WTknaCnM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EPfELtux"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 39D4D7A017B;
	Thu, 18 Jun 2026 02:54:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 18 Jun 2026 02:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781765694;
	 x=1781852094; bh=pArr7Py6EEMX8npIFiKMPscwWp9n5Qnwv9VHfpm2jMY=; b=
	WTknaCnMnFcWyrmimsW35jgzJzBMMh442u8PVZvW/W5IboUNi9KYvwv1QHz2DZSr
	CtJOR6x0x8U8D4qWkRdv5av5imfD1WdhgDlYvziDazViK6pDcOVFE/fjM+nIhzlR
	ROE8jJL+xGPegnvFZ74EMUDbUXO7bhqAMPjXUclQvV9hUX7YJjWjqPOczQIfnJga
	jONdxVWpkRmC0ELbX0CpwRvXUwGpZTqvmE734c0WwCD5pGiwxLfC1UpfBOjWkGDq
	QUF/H6OF7ayxwcPzeqBTmUiOgdX+afGhwsPqO6LnDy7ZFrWzS3SiklE58E5dbdhe
	tpE/dupn23uRufYQcNaZVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781765694; x=
	1781852094; bh=pArr7Py6EEMX8npIFiKMPscwWp9n5Qnwv9VHfpm2jMY=; b=E
	PfELtuxLuSbGiZyoBKK5bOGdKvaLne3ODz+YriJ61indOSIoclEO3YQ07220ivMN
	TiQ1XAP6VT288fey7BGqtXhXqYVDr3hFIQuY5Nn0ZzC6ELRn69FYTJ7uhj836Hak
	xCL7z2hhbbMAtyghGzW89k87i7eUevYx/SvCtV5UJUFFnqEkZd4Y7LLIk33Q2LpT
	fDpjPHDdLjjKlWarfgS6x1nyp2zYqU1oaLjBkvXwjsSwKtvuHjyYP2txATRSmpJZ
	ebnH0MwESfQyPIEFLOdFXqbxV+SoHMPekHaMXI+F5ten1wTSPESvKXC72frxIZ3Z
	CUqQ5eEZssZHK//zjxtoA==
X-ME-Sender: <xms:PpYzapf5x4SOleh3jezwShixD3gQ71r_y-sUpdjVFj0CCcNebl_5fg>
    <xme:PpYzauOvxZ9kB8IDveosVQUzqtxXOaTjA20oRmuxBD-lfQnlcxrEMIRJooAdVYToP
    88p_SMFzX21DFCpVDLyKn9bupRDR9QBRYW2qWzESCWZXD_-IKL95q4>
X-ME-Received: <xmr:PpYzanjjXxAOUMlF7sZkRvhBg6yrStH9rzORw9GC4R7ulcjYKA7jLJdpM4_zgQxLpSOa_DiwS-VbyKJq_LuPgAC2CpoSGIEE2SLzJRQncA>
X-ME-Proxy-Cause: dmFkZTE8U2oIhrn30tzzveFnINo071jbEKwvBkrWrifW314KctlwJPCAU6eYOarY8qNCuI
    yB91OXMFgVt42H56SJ1zFR2awvv0NR3Uw2Ey2ey1Dotem1ub8EXVs2lQ51zg6P1uAADePM
    bXI0pM2X4Ea8L5x6oMip6HqR0+VRBawWQZ/rbUfAx6x9F0UwlIB42JokwJAueCmvAeCb5T
    pmBpW0SXtDa9au44wMtKP66Ct18N+bqYMWi+U2XoEZ+Wp1pW0DGJijOS7MoV3700KqJmRo
    J/sROzcytu3p8poCGFPqTEYc4w12jhGP24ZwAJqDyH+L0eYUOchvxOtiHBKOdzQzFyNGGf
    SBiadA4NIsZFasnabgWlHIan0dQl4LNyAacw24KcuvA41Mb1Ovq//VJzVFmJOmCnlzNQQY
    Aw2RZtyoLsP6epHgGkcyUQx7eLKRKZdTtjoV4lQAYrCVyOiHGSDZGs5m8Dl0kH/G93jsx8
    dl308/BowIanT13FDm/JrLriJB2viDtbB2o0XKhOa/wBQywBNdH1RBxcEtoT01d1NdistV
    q1jl2Pb83jx48l2fBOb3Icka3+vf96HRBNS25Sh1QxB7dfwQGCgAMachAwWGJfMLg8tWgh
    9fwaexA7Crt7m/AZ9zpZthdJjy/fuB7M6UEGJgYG1qOGFV3yoas98w0fkRiw
X-ME-Proxy: <xmx:PpYzah248brzy-nEvHWDMJjaRqJpUHNjD28by8Rw0sX2HXlhEt66pA>
    <xmx:PpYzahioUlIzV6ChWG4E8bLHMAC938OI1VYs86tOYravYS9Lw9mOzw>
    <xmx:PpYzahdw7WTPwizbeP5RLJGiEYlaBgPVkszr-YgUDbpSKpgg2OHPoA>
    <xmx:PpYzakl37BrgdNkV2mnEMrA-oaJb8EYV_ZLcAXEesBZ7-c0W7H96Vw>
    <xmx:PpYzakk6XgEzehk3xpP_Q_D2WreMuu6AJ28pGEAeTyBXRz2Fo248UN7y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 02:54:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 62c3e4a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 06:54:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Jun 2026 08:54:35 +0200
Subject: [PATCH v3 6/8] repository: free main reference database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-6-2a5669e8f486@pks.im>
References: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im>
In-Reply-To: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

While we release worktree and submodule reference databases when
clearing a repository, we don't ever release the main reference
database. This memory leak went unnoticed because its pointer is
kept alive by the "chdir_notify" subsystem.

Fix the memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/repository.c b/repository.c
index 187dd471c4..e2b5c6712b 100644
--- a/repository.c
+++ b/repository.c
@@ -421,6 +421,11 @@ void repo_clear(struct repository *repo)
 		FREE_AND_NULL(repo->remote_state);
 	}
 
+	if (repo->refs_private) {
+		ref_store_release(repo->refs_private);
+		FREE_AND_NULL(repo->refs_private);
+	}
+
 	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e)
 		ref_store_release(e->value);
 	strmap_clear(&repo->submodule_ref_stores, 1);

-- 
2.55.0.rc0.786.g65d90a0328.dirty

