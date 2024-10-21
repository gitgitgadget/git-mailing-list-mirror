Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488641E3DE4
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502913; cv=none; b=rK4khNX2OrifXqzGfnZrmheXA0H2OMGjGX8ZQkAR5w6Rf1lYmNFslpnAmrA1c/1dljY5JSUnoWNSyTYyHQOIJYGp+ubVgJpXHF4iframc31hg+Dk+G1v41PTM6/CG7mRt6+ERXuQtdE5v4m5wuAkID+4NW/jKvK1m/3KDLDg4DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502913; c=relaxed/simple;
	bh=gNZl+4gCIU2d0oioYOi0nu863rLS4G3Rx86+Au9vmEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWLSSY3A2mhBuPNY+MDXbEseJJjlsvHfXXOlucJ8z3Cm9nvaf+P1Llp0Xgf3jIxah9zHvOb7EWPKdhOgDEov0vqRYcbTQlAd9ozhRL3BNYOc9OFLi+T6M0stS3cIy0ZbbWK5kFK5ooqpHaD+8KO4/2KOVJeEnhJHTJItXFDYkBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e73GgdNV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jfif1JGn; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e73GgdNV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jfif1JGn"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A1EA1380588;
	Mon, 21 Oct 2024 05:28:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 21 Oct 2024 05:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502910; x=1729589310; bh=BuGZL20xje
	mPMgSa3Kn1EgXHfPDYVe4kkBhahgCwzuA=; b=e73GgdNVcaqumNXCUEK7u+ABRc
	uxL7CywgHX/il5Y32UgilOUk7jlW60BHhtKzSc0HfNZZGUin2OXyAJYyZ+uuVUWe
	Cl4QCfytA/BwVGVvTjxhE7lMkp/WdQ7ot7A1uzxUpeDQpIYoLykgzDBwkEv9T6OZ
	+qTlsUyB8bt750cXNc0SEDgXelr+xdSTaPE2wze968xCx22DKPnbAIHrNL0OrTob
	+S+nKGndcppAbhzp9iRK9tkxGBmp3/K60aXRdpgld6oc7NVQB+989O39/eOrHMwo
	yOJPQ11XQf/wECScTBbe28B8gtyN7DZ500RHEKI4lojfsoYcjB0ubycSdrYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502910; x=1729589310; bh=BuGZL20xjemPMgSa3Kn1EgXHfPDY
	Ve4kkBhahgCwzuA=; b=Jfif1JGnLCaYwUOayePyieoHfGGNQsvU+zJbjMdc+59G
	EW8NBa2jCxBqT0HCGEEPlkzxxIqQwWvlew4R8mKUedBOw1DxBL4v8XKQjvfN6hrl
	xWkL2IuJ2MbALEjrPmY0bU0POd+JwA9pE5H3nrs0kSO9UCQDO45CTvvq/LPLo3ip
	nmkRLZGlsbY9n9sdIMAjkjfgsAul5CEqgT1Zeq162NskUzYfKRdj/CtyYF9etVE4
	ui7UksoSRuR81LUVlF+Bfd5PHwTOmlkLlqGsZws5J4dH1PQUHrVF3J1QM03wQsE1
	2UdomzlbwYrT/VaT3IRP3MqHcRBhVcFQNf9NT1/4gA==
X-ME-Sender: <xms:vh4WZwwBpkAzl1Qpk-NwFsmc_maXDy2tIcoe3d3hk4CBZT7xuf-7Aw>
    <xme:vh4WZ0RWpVInnnFXWsV6vMzU_W8J974szSqOrdVTKV2MqpknVLgF03Dt1Mek-8L-R
    LpcuQ5UZcFu1BbBeA>
X-ME-Received: <xmr:vh4WZyUr9zF4svLETipYXmT2WFlYjgM3JcaJF954aZhj-JRJ2C7trS-sykKDUgzbNu8fFAKrwzECSzG8_60ofB3bfFCpqyQBoerCnXLsOnin>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepthhoohhnsehi
    ohhttghlrdgtohhm
X-ME-Proxy: <xmx:vh4WZ-gIAHjvo4eBa0a6zsealc2lQ278iOsLkWd4VbLa_VAxCIeFhw>
    <xmx:vh4WZyD_J8LCK8Wp8-TvDmVRKuGdZwvvj1xH_05JYC0ddZmBVIzrlw>
    <xmx:vh4WZ_L8pAym87WEAld8QsjIGz-Af3iw29OUC6KKzehiv3fD3ML8mw>
    <xmx:vh4WZ5CwNht2Wa1UqVm1MuJi9uvJ65nC8NueKlRIxAvP6AtAMfn6jA>
    <xmx:vh4WZ9NOAd16xLYTEl96c0Kc-sHJxk5AxboFRTSpc63x8ZHdZtAOipDd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 451d2153 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:27:02 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 08/22] upload-pack: fix leaking URI protocols
Message-ID: <0d503e40194c5d1912c7dd8a23f685546c490027.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

We don't clear `struct upload_pack::uri_protocols`, which causes a
memory leak. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5702-protocol-v2.sh | 1 +
 upload-pack.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 1ef540f73d3..ed55a2f7f95 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -7,6 +7,7 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test protocol v2 with 'git://' transport
diff --git a/upload-pack.c b/upload-pack.c
index 6d6e0f9f980..b4a59c3518b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -166,6 +166,7 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	object_array_clear(&data->extra_edge_obj);
 	list_objects_filter_release(&data->filter_options);
 	string_list_clear(&data->allowed_filters, 0);
+	string_list_clear(&data->uri_protocols, 0);
 
 	free((char *)data->pack_objects_hook);
 }
-- 
2.47.0.72.gef8ce8f3d4.dirty

