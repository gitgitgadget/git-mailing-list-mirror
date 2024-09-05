Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B031991B8
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530941; cv=none; b=Lljk9CqMBhxhYml3qsmU+8kTmUNVerXD4pHUsJlgOinorklrNUoF3wQxp7d9qiKGXfWvvvgG3t41NSQomj8dOMpcG3/6uCMEXJJSwa5bwiFYu2W8V18eyyl5bzVm2REoY8uvqtKCBWve0bsp7QtZvKV3yFkvr5b3eSqRnHvXtVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530941; c=relaxed/simple;
	bh=YKNGebA9jp/NpJS2wMCJeJrVLU9GQyK/nY4Eub3yMF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jh14PiUWcNipTcPgQRm4nHWRygs5186hZphuauTP/ZRWZXinzqelPsh8myAa+egL1m1+yaHnEcQtnITJU7PC/Wm6CQTyq+kdcKgyeQcRx5jEV6BdIJU+1OoGyRaaARTw7/zOYKN/LthqVKZyZfjikNp3pMdBFJ6UMalHN1XT1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ky7Xv4j/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lx3poeN7; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ky7Xv4j/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lx3poeN7"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 370C71380359;
	Thu,  5 Sep 2024 06:08:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Sep 2024 06:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530939; x=1725617339; bh=3PSaNP5gKj
	DUZvLPOpCjWQQNepInVNVeiBWq3w9WNBg=; b=Ky7Xv4j/Z7ltfP9o6nv6Cxkx+G
	RNKag+bqC3mopvK399XHKnhQOjMcOeFiCPTZmmw2rbLZ9dZ7kHgbccDGmUyWOERj
	vxLTb+WhdCR0JAKoyaQ4C3xO/oiL58t+DWBlzJOjUvQwr7QY8OwWnmiq9rWdy/6a
	XMUCbw/xxqG9/YfOc8If72KH0taayU1UXcZG2pL0wLiowRUn+3vbD1GAmKQkZKVs
	keFqW1K4N/ZFPCVIQsdsquiLyOorzUmcVnnOkiu0pks1sBhXsp0Fcefw2eaRBf0w
	UE1yIOxyikfxEWzc1mPS/i0mlahLIiNgEr4oq9JGUppx0ewozGRGdEIJtezA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530939; x=1725617339; bh=3PSaNP5gKjDUZvLPOpCjWQQNepIn
	VNVeiBWq3w9WNBg=; b=lx3poeN76jUQl9bbN1gq33FYr5JzckyYsxp/hFT0BmyL
	1CkXaDKxTP0F2WaeRHLyokVEuvLNN5AFlRS6wWJhd6E8po8C+uLN4xM5ECJiz4C0
	w5MdM/PMT17pzy6tR+82gOi2WgGjaeji4bWmLWRnGlRKRLW0Qy2KxbnFC4fg/kCn
	H74BFHN6d2Lup0L10pQwy8cC0qjDQyAiF690KVL5sMWB6Vxo7Yx2l94Hnt2Co0nx
	s7hAfr7/jOASyfSO7wu68+JuF1m+bTfoMMymEFmNKW8q6BHTdhUjsAk0UuivH6jY
	Ebw1RlU4Lx2MPUe4VvhHMzmXS0dxVNZ54oOgPt9YIw==
X-ME-Sender: <xms:O4PZZkOLhNrw1mN1Z9tWzUnB1eFXxlb8vGYuob5otkETRJAJTmR9dQ>
    <xme:O4PZZq-ZR-PlyAYwE9Gk3nzvUeb0alOSFP9ESuAjcf0qea1Kd8UX91xtrxcBWyphi
    _Y8u53ujCMRNa5iqg>
X-ME-Received: <xmr:O4PZZrQBRIBiVU06Rc2PQ4w52YE_g5OwZjUcFpkCgWe4KN4F1K10bm_YyRv03eoJh5Ybkh0YOzz3Z2Q-TWLQTgrMrxinD4oPVA8ooW4RxwKeP2Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrd
    gtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:O4PZZsvdT6XLrPYEDMKX0NKRCEGrv5WOa86zSuqb4qZJRKOBfTsEng>
    <xmx:O4PZZseVreFIjv2zyx21ceUojlm1SwPb3-ePMQ0OYlm2Uq857Ds4zQ>
    <xmx:O4PZZg0s1DFu83sVr8o_Cyi-b3qYeFi49Gmshe1zO_OR5_3HvSocpQ>
    <xmx:O4PZZg8BhCtAMNon7KQ0WULuO6NPRi3szqjF8li5wTnTnqoH-Cn2ew>
    <xmx:O4PZZkRHh2qz80NIpXyLoM6A6d_EyB118TWbfBmvD017HWzpcOdI0aC->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:08:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1fa9dc0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:08:46 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:08:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 07/22] builtin/submodule--helper: fix leaking refs on
 push-check
Message-ID: <3cbd6fe808eb934407c031faeece08459531c487.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

In the push-check subcommand of the submodule helper we acquire a list
of local refs, but never free that list. Fix this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c    | 2 ++
 t/t5531-deep-submodule-push.sh | 1 +
 2 files changed, 3 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 85fb23dee84..642a0edabf0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2958,7 +2958,9 @@ static int push_check(int argc, const char **argv, const char *prefix UNUSED)
 				    rs->src);
 			}
 		}
+
 		refspec_clear(&refspec);
+		free_refs(local_refs);
 	}
 	free(head);
 
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index f3fff557447..135823630a3 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -8,6 +8,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.46.0.519.g2e7b89e038.dirty

