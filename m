Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A1198A33
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530946; cv=none; b=KfDpEeWPHBxQVBOBNeSSGBxzrqm6gbzzmin2vED3y6z8siHyZn6p/u39L2QKK/gMn+vrEdd58PqLBf1gOS+8qJyGB9s8AxKFEdnNrZ17XYTgZQqXFQohWdoVaqjoeoB9miO3Y1tYSlUqW2U17H8YJGqjGUiE0LA/+RfWPpAQFTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530946; c=relaxed/simple;
	bh=GVAqibZzTpMcbZ9XGxRDO2nb3C44a6bWeOKJjV5QgAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqOFmRvD2C9eiV2im2JNk8Lxzh8d/K1J3vteqxx8tQqw1JC5BWGNezw/9BuMU1dGpwxTrOK46BIplbv9YBwY+7RLXtPf9X30T6t85ia4F3EGbzCJfe7UL6Gi5nGPbc938KF9ZhaEGStNP3SORVzV+ljCd4H+Ctb5X1OI0b2Vil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TuRyuHnQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s4EYRHma; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TuRyuHnQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s4EYRHma"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 58F141380348;
	Thu,  5 Sep 2024 06:09:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 05 Sep 2024 06:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530944; x=1725617344; bh=oIs7KZuDCP
	xyYGV6zg7T/9yxfRFPsHn1Y6vd7hOuero=; b=TuRyuHnQwIYaEILk95IDIj9jtw
	MII5ekShZ/fbyo26XlXJZtoaBwTJySrKPwMpUYJsNiHnega8vvsVkCJwKbzoOuGR
	Nvylm1psrfy/Eozgv2RzxbHF23RBQV+cgSlRAK2thzfCUxDnLPY+OQhvg2Fj9JgB
	jYaiyDo2Ng/NPpPut/QF4G2c945hY+3byVFbC5I9JrCbo+KHnV9i1mHLjI7l5/U3
	RXwkLlOe5/Cgo7GERGu3yAEJBOSNYIP8Yx6Fq8Xe0tGkb23Mwuame6UzY78WFYi2
	mO3ztwSYoSQRpP0HVtbCjfmXTIC8FqUHTVoo1pdVYB1xmaRwtztCMBdxig4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530944; x=1725617344; bh=oIs7KZuDCPxyYGV6zg7T/9yxfRFP
	sHn1Y6vd7hOuero=; b=s4EYRHmayRIdW3uaEaS6khpqKpyl5mWoauIcf/gdYRz0
	06kmBqBnOmcRb7STYGnkfbPXQ735xp69Z6WRofFOGZKhKrywQrZhCDkld1aylyeB
	B+gbHtxATFFtznHMUzBIffBvq/WFfRjRJ13d9F/truMFzLwPJGNF9pjLyhuTXT1T
	k3aVA1bKdO1H2P2+Lx9igM8A9e/7NKxRnYJ60HtvPoFALfeib34y8XuhW7k/Sh86
	HU5aWSZbwuRXZ1aE3dFpDqE/W02fGX+PPbCwPa0nsOaUvsjgBBI6hVSO3wdDhDDc
	gkjYs8wsYxnlY6/A2d+Cqp0J01sEnReiL2O0riCoDA==
X-ME-Sender: <xms:QIPZZsYPxpvaPKoTD5dr4a5ZNlEDn-bMKdi2P6WrVDXUXCuytiXWJA>
    <xme:QIPZZna3_suOo5pYr_xQyQl-5MKspDQ9yKLNrv35Xsrlg_O_dgmVzj273YucrrK2S
    oVvbXNfII225vTjQg>
X-ME-Received: <xmr:QIPZZm95cCBEJAbQO8W9QhUbw0DaFrHJ-t1w_1VqyrArvJydEHurhAX2ubFpIhXHV3_QGG3XwDl7s4BLlW2L7O441hRohQGediB_aeUDolkXuKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrggu
    mhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopegt
    rghlvhhinhifrghnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:QIPZZmraNFZGs02kTX4dQS2Qr6R1eSWGVtyL46V_mqHtdn7FNliNjg>
    <xmx:QIPZZnr_t7I6PggvqWhSxH60cFvr9wI9y9wwJ3AzN9deie0w2RMauA>
    <xmx:QIPZZkT_PTnY2VoPyDAOmV4gjw5djhkIzYqcrlB39ThR3ZOcHUW2dg>
    <xmx:QIPZZnpZCtDmWeSC4_xNoRZuQZuupRM3ExJxQzWMoX079sbJMl1EcQ>
    <xmx:QIPZZofyjiruFMJQE9yPhSGyGFBsthjwgOc213asdWNgw-mmeocZpGTL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:09:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 24ba5407 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:08:52 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:09:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 09/22] remote: fix leak in reachability check of a
 remote-tracking ref
Message-ID: <bb845fc9ff14f2bba8443ad6ab6ab243e8542e47.1725530720.git.ps@pks.im>
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

In `check_if_includes_upstream()` we retrieve the local ref
corresponding to a remote-tracking ref we want to check reachability
for. We never free that local ref and thus cause a memory leak. Fix
this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote.c            | 1 +
 t/t5533-push-cas.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/remote.c b/remote.c
index 240311619ab..bff54046b2c 100644
--- a/remote.c
+++ b/remote.c
@@ -2774,6 +2774,7 @@ static void check_if_includes_upstream(struct ref *remote)
 
 	if (is_reachable_in_reflog(local->name, remote) <= 0)
 		remote->unreachable = 1;
+	free_one_ref(local);
 }
 
 static void apply_cas(struct push_cas_option *cas,
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index cba26a872dd..6365d99777e 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -5,6 +5,7 @@ test_description='compare & swap push force/delete safety'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 setup_srcdst_basic () {
-- 
2.46.0.519.g2e7b89e038.dirty

