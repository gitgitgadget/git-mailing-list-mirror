Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A566156230
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351218; cv=none; b=dveBtGcdtF4uStrLDMewrr27aw2l0i74M0DVyHwgsDuvHuA8fYG2BnAclpy96/O8/sS6U7pTsGVxAksB0oYUby5yJxdtQfNo1yTPvW3VTO+EFvBNfYOJArMSJ37sRAGgLkDVKDD1W2fwvyRsgkohX//iLZMhcWk1Urb9Jvv3gaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351218; c=relaxed/simple;
	bh=eE+V8n7sVcyh95gUJ75HmZN7nxtmVvdIOL1aOVnN4oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMaSmVw+l/w5IzanhQ+a0j4/QU8Gq4nVGlNBqfr6USpztWxEHJUP9JRIsdDa9dZVPicg0JXp1LafSeqKG5cm/q3PEvqw25vSyiAkEAfUYD2SPWGCoLuNyg+fRjBDOrszDBXmJEM9MvkKyMlIPHLeEBUHCzJIStI04x58tFoGFD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VD9U88g1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jzv59YIO; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VD9U88g1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jzv59YIO"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC68B1140252;
	Thu, 26 Sep 2024 07:46:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 26 Sep 2024 07:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351215; x=1727437615; bh=QmPkWzLTXQ
	9o3eZQlN9lt1gQRgVa1Fr0E68IvoiC3zQ=; b=VD9U88g1626TMVgNk3+Iki533P
	GFZ1E6Tqp/70RHCTx9lHUVP3UK/dLpmIRCi5aSOp6nFE93PUVl9RZxTt3N2BVyMh
	YeL4op7jYm6+5TtC9lMH62aH0wkym9+Puqqyd6OiWHxMHyofJ4TGuv+bljJXx5Db
	6r7K3IxddYs68P4dnB3sWhfp3Caq7gHB2RJ1i7g3l7S2h+R/KF5XcOMC0u4ZrqTU
	x/Jpw02JEaeRZumvnsghi4FXMoEbX+0HF9f+R13DwvctX7wFCXH/33C2dweqaMFZ
	HDdw2f/6i15XNz9WfmPMJ5pMzRIg2knmGw32f6jP1ZDwcg1pwwCyTLjOArEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351215; x=1727437615; bh=QmPkWzLTXQ9o3eZQlN9lt1gQRgVa
	1Fr0E68IvoiC3zQ=; b=jzv59YIOqhqzkJZPq2dvuU4emXsacWbdIvYBqMR28Dzq
	H931qwo7ZCBF/0X+usZU2Xf/pzYWX2MQqsngDtOCXRXDJHMgHbp+xSWrNXNv12c9
	ICAH2iaST3HHB+3SLIufs0xscA+SMidbDs6k5ZZ8yR0OLphddfgBo3utMwsYcNKc
	3sy/fzF903lnrnhPXcUxLnHzzXcmw0Yq9p9jSMf0JuUbr3Jd+sKG/xgMgwHbSNut
	G25DESRDxC2ex2S3A9Wc+XS945jmxBkdjuyp3UXyzQY9BtSeua7eoQ0ySwslfFip
	M6yDurpJQkTTIZFlhe/bVkvDqssVBxG1at44hqGDGg==
X-ME-Sender: <xms:r0n1Zv5lNa7CXhBwjDUrYda9mDbYAnZ41MbFvTCKca6EYIa3DGWoPQ>
    <xme:r0n1Zk69fLh9Scl_gg4ukFjv4ocsiS-_Tv2pCIwFqPP5bKSaS61LhymHAkILCWYtU
    yoYQNKN1GkdBtlN-Q>
X-ME-Received: <xmr:r0n1ZmcGeb5h5ycoMHItxEgoWWq8z-D1tttCo2yXQQP4_-xPTsr3MINeaTs67AIVJd0cbstEjRGwmolhVFfK3k6K4TL1aijbiVXVMSd99SnQIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:r0n1ZgKwH1NxN6YMdaTPO9a0FdPspvtvhTu89-_zqD80sa1qWfsPNA>
    <xmx:r0n1ZjKBuxYoG6d7D-qbVF7tTvf5rvHYKnarjQJdzngdF5jKmS5S6A>
    <xmx:r0n1ZpyK5xr6EiN8dcJr_naxo__Xf5dHcSQR8YOF5VJBHbafv0ec8g>
    <xmx:r0n1ZvK9i_0lU24f3ZNrSaLbG_ZkuUvy4M8IrgHYu4ZpfWSauNx5Ng>
    <xmx:r0n1Zr0nJBmaQXryC2d8v34E5nW5Ze5XfodMxlpYPfAWeV2FQMxc4mYu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d5c0c7dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:46:16 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 17/23] submodule: fix leaking submodule ODB paths
Message-ID: <35f5de5467f97dad04ae53e6de08b5efc6e2cf41.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

In `add_submodule_odb_by_path()` we add a path into a global string
list. The list is initialized with `NODUP`, which means that we do not
pass ownership of strings to the list. But we use `xstrdup()` when we
insert a path, with the consequence that the string will never get
free'd.

Plug the leak by marking the list as `DUP`. There is only a single
callsite where we insert paths anyway, and as explained above that
callsite was mishandling the allocation.

This leak is exposed by t7814, but plugging it does not make the whole
test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 0e67984d77..a07debc227 100644
--- a/submodule.c
+++ b/submodule.c
@@ -175,11 +175,11 @@ void stage_updated_gitmodules(struct index_state *istate)
 		die(_("staging updated .gitmodules failed"));
 }
 
-static struct string_list added_submodule_odb_paths = STRING_LIST_INIT_NODUP;
+static struct string_list added_submodule_odb_paths = STRING_LIST_INIT_DUP;
 
 void add_submodule_odb_by_path(const char *path)
 {
-	string_list_insert(&added_submodule_odb_paths, xstrdup(path));
+	string_list_insert(&added_submodule_odb_paths, path);
 }
 
 int register_all_submodule_odb_as_alternates(void)
-- 
2.46.2.852.g229c0bf0e5.dirty

