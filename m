Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A0191F93
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162757; cv=none; b=uwgbmPwzutpmNly5EYewkXG1bLoaORAtvHD+55N6PA0zxy31njKZd/UubTIlxqiRpD4Qf8fNXpBlhK83wt5ozd9lKZxbUoFn5RU4RHHdFxLBMYkKX9A1yGDQyZ2ZXbFfkTwu4opLm1JA6QBPgRm08rL4JnU2Vy4M7uR+am6JV2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162757; c=relaxed/simple;
	bh=j0WEXaLLA5C/GnIjUA3mAXwSU5Wd8l4cEdYJOGhcOJE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdRJGZdV0LguSULRByIOLcUiIba4LJZquiDXUP2kULfzfXAPbLk00PHOcmSorLM+9Wgi864Igv4knKxhb2kTlxKsXBKC2CvedEYPPe5UuPNQvYCOuhkGdRn1GGEYjATMvaqXKZsZeVcfCSUsJXJ0Iz/84N2XkR3P9GJdxLkE9bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pJfaFSqU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k43BORYb; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pJfaFSqU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k43BORYb"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D9DD2114BEE1
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 20 Aug 2024 10:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162754; x=1724249154; bh=FKLhRoExGG
	zleaqPxBTINQGg8KhL27hmoPCsao7mJk8=; b=pJfaFSqUPdUPS5400mHy749vmO
	HfUlwcyCiecntQKgv+702fX+SoLqFadt95P3A2cUnYoun+4BVFFmC7PRbHsRnUoR
	bM8qRXdmqOr28Qg2oqZcBNfDi1udF7ahQkuwWNVOlAFGs+7rON5IfTUK/IE8f5AY
	jsxr5qysgxV3xKT+mOQMojiPyCKAUp5rYYMT6rUq8Q8jc746jClrWDMqrREUPJEY
	DQW3kEc3q8WiOI0uHvHwawrDe0FuYArZobb2hIXRv+ndsbVUDiRbPEHtfPYEYrEx
	s0fS6QyskqbcXCh7hcUkwm45c3QhDSiH4K0NHLyOZpK4VCcG9r88IlaThZ8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162754; x=1724249154; bh=FKLhRoExGGzleaqPxBTINQGg8KhL
	27hmoPCsao7mJk8=; b=k43BORYbIfrFR0VEt1Gk76zTluDFUxfmJs/27UnnTVHX
	6HY4Su+GM6DAiE6azAGP8X+xiFDVQWIubvvprFBcfsj2HePbSM8yFkCfsCz2XK0w
	NuXcS5limv7sWy+SDpTKj48rXbvjyhM+FDEfMyMcAuOVGYTTa0t4t0s+3SSOHWSG
	fQXffiNaqMh3nXsZXML5tWRN8ws07lwEc9APYk3vejn3R8IIt6Rl/ic1xXsODRbP
	iQeC96qT+SYOqdyCJZYdTK8qKpqZGlDNk7U3AO6Vqt1UnCL0SM2kCtmqmGt8BHQq
	Hx195+vAgThVwabPAzpEttggAFNAjuplCeQVQTbnKg==
X-ME-Sender: <xms:wqLEZuEg4hd7D1G-zCsb_wkL279YUZZK_i50BO2fuI9OA_2hDe3CPA>
    <xme:wqLEZvVBNArqNDRoomCLjoJDAHxXZXyaxBAjdtFQ7gk56tc2dlXlk44Nn8_JGlh4u
    yQ8LmdEeZPP7QCZbA>
X-ME-Received: <xmr:wqLEZoKLvoZHcJZW_AXvYLOjOFF9ke1nCIEqv2y-I0qB9gsSW-EJquHDIxCxMOral24xHK2d8xvOHCapgU95nu1di0ErzG7Ccl8cn7Qq-s7HZPEfTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wqLEZoGeMy3jGzj0pUa-yNB-iSTiGumnOPIjXOy9Ri9LUJWMoMhSMg>
    <xmx:wqLEZkUnkthsB7wWOSf43OoLTs97BubOAviYBk5NwdSG8wM0tOdcKA>
    <xmx:wqLEZrNSBRDnns3AbXILxgXCWppop620d8BW81FXnmzvXEW8tez-TA>
    <xmx:wqLEZr2ZMoQhT1kjEhDgzAlLEWmbCF3qsmqNjmoE1QH-T8UpPBb7kw>
    <xmx:wqLEZveYFQZWaKRJu3ehmsFl8FoomQ7000yL5ZuVuWzCmqW-ztFHGL4h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fd3b0c82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:05:22 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 17/20] remote: fix leaking peer ref when expanding refmap
Message-ID: <773fe580d750e94e34499f385701794eefbc9c27.1724159575.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

When expanding remote refs via the refspec in `get_expanded_map()`, we
first copy the remote ref and then override its peer ref with the
expanded name. This may cause a memory leak though in case the peer ref
is already set, as this field is being copied by `copy_ref()`, as well.

Fix the leak by freeing the peer ref before we re-assign the field.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote.c                           | 2 ++
 t/t5536-fetch-conflicts.sh         | 1 +
 t/t5553-set-upstream.sh            | 1 +
 t/t5703-upload-pack-ref-in-want.sh | 1 +
 t/t6050-replace.sh                 | 1 +
 5 files changed, 6 insertions(+)

diff --git a/remote.c b/remote.c
index 892a47086db..6b50cafbbd3 100644
--- a/remote.c
+++ b/remote.c
@@ -2062,6 +2062,8 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 		    !ignore_symref_update(expn_name, &scratch)) {
 			struct ref *cpy = copy_ref(ref);
 
+			if (cpy->peer_ref)
+				free_one_ref(cpy->peer_ref);
 			cpy->peer_ref = alloc_ref(expn_name);
 			if (refspec->force)
 				cpy->peer_ref->force = 1;
diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
index 23bf6961700..2dcbe790523 100755
--- a/t/t5536-fetch-conflicts.sh
+++ b/t/t5536-fetch-conflicts.sh
@@ -2,6 +2,7 @@
 
 test_description='fetch handles conflicting refspecs correctly'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 D=$(pwd)
diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
index 70e3376d31b..33e919a17e1 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -4,6 +4,7 @@ test_description='"git fetch/pull --set-upstream" basic tests.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_config () {
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 191097171bc..f75fae52c83 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -2,6 +2,7 @@
 
 test_description='upload-pack ref-in-want'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 get_actual_refs () {
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c6e9b33e44e..d7702fc7562 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -7,6 +7,7 @@ test_description='Tests replace refs functionality'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
-- 
2.46.0.164.g477ce5ccd6.dirty

