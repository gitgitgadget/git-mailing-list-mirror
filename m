Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A471922E5
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162766; cv=none; b=rA6f9KQF83SdPLgq96p7wtUvLSyJS57m7+l8zfHFMyn5Rc9bp+ErJTRw9l3hhKXNqzD8NXhl5xUI/mdN9GMyrrdF+v5jy34i7kplLbFX2f/KclkemexNegFHEKJFeYBNC9F9stUCoPPkzFXl4wgrxkwP2GO6XHeb3wqbE7yv69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162766; c=relaxed/simple;
	bh=zwg0kB4Rcsb8XD2nW8KQ2yJ+gZvuwV/Z3iVedjkkw2c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hV+q2x7lrCFWRVIsXSg7qwO8bE7epRgRl6HEbqwhPyaTKFLX5oaCVn0fjwI2HrCHD2qdyPWpLmKaQyQZfMhTIdtRqNbCsTvvAkHNxWD6OXNubuUlELMdhdIf46f1VtllEBlfvryz+3woBE2I0XazAVZmrdKaeIx3xAd7khdtiMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bw1i+sPg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OByAkbkS; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bw1i+sPg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OByAkbkS"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id D5427138FC5F
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:06:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 20 Aug 2024 10:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162764; x=1724249164; bh=Fx58xHcaAV
	XHT+2XgotGrdn2miPfx3kVxV8MC6HNayM=; b=Bw1i+sPgQnaIBLkYdf06TYHxtD
	eU0eGIflxdhX4kPeRcHqBY+9RokEIVTr3MngY0N2XVKeRuGYkn98uMFbNJ/OaEMO
	c13l1NB2/gW/CkMTr3kMnP1P0JJ5u8O5fA7GZYM3t8RQ8PsyqtZ7pJ58dFw3S8Fy
	EEQGX6rZAZmB2zCHHEIsBazlSQQmxTtCXHhpdZAGMVT/pMO2aWVgJBq2/3Wz3h6C
	8w4UjIg3e/6WQW4vZ8qX3LKBIYAnA6Roilvg3rho9NvqXzDEq6DVcJj/zfs2mJ8I
	uLHpgYM2qdzuMlesIgiCacj1zw9X050sO0t8HaoIV/L9Aewo1d9xsmUoWqFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162764; x=1724249164; bh=Fx58xHcaAVXHT+2XgotGrdn2miPf
	x3kVxV8MC6HNayM=; b=OByAkbkSoUp1HwEc5trYELCPiNAMY5Mz7npv/klEg7qN
	gKD2+KgYgXOmpS+OtKhiT9UlnUBHsbnDqsVV0vylra0cnbSwFRPxKUtn722DK8VV
	GKDu1hTRod55BTcY7TmIeNLtfN3p8U6Rv8afcvxoCrB1ib5MCaeb2v9Fvyxi5Guj
	D7oLZPXr4QehNEKV8eRNLIgscGJhSUbuXsGI5vJ9cyXaw+ihafGsWsekg2ydG6E+
	S53ZHE5S/PYmTUDPVyY3EXoy9hUmaUtddLe+uXfTntYPtEnYtIWoUEf6Fo6ozfq1
	Zr3xwDcfF0l3BzgoNvhy/xhUSHt+KYx5MXTFHNTG3Q==
X-ME-Sender: <xms:zKLEZpkVvSCoRUrWvx9K7CgH-npyM7mNJ5WdjKKae289eb1EuG9NCg>
    <xme:zKLEZk3E67BMpAVTFqROhUQRmIEyudzsYZYzl5rei6wChPLuaMG_SaAHRBTLIhLF7
    X357A7FNAmRUVyvRA>
X-ME-Received: <xmr:zKLEZvoaHNuevIQWnzlvvlipeMM3_SszGRKM4Oy276fWXdgyD2v74_Ob94leG957bpe6v1CGhIDdP-_gS7d3vY2rUGNTzUWVDyVPK8su_te1clTRjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zKLEZpmEj3qRZjDYukciVdOi_pyqAgAzVCtyCNnS5LshltnN-KJCTg>
    <xmx:zKLEZn2vjEdaxRCRVGKkQlOuTUkzubObCUBE6o5lB3Vm3q3mq8ompQ>
    <xmx:zKLEZouis4rQjBsZqPnkl3wjyJRPCuEI9L6wzEUgOkKyF6GEmzsihA>
    <xmx:zKLEZrWoRkcMgjkGGEfJq-vyNuH0twJbgorBp96mq2zdDVEeYsVT6Q>
    <xmx:zKLEZg8qTzw5g7eraVQCLN73GeHarTRlpDpeyAzG8OjdjLLr4QkjtB-H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:06:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 36d54ccc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:05:32 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:06:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 20/20] transport: fix leaking negotiation tips
Message-ID: <e8f479deeb209e79a121ce58c9ec610c458aadad.1724159575.git.ps@pks.im>
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

We do not free negotiation tips in the transport's smart options. Fix
this by freeing them on disconnect.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5510-fetch.sh | 1 +
 transport.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 3b3991ab867..0890b9f61c5 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -5,6 +5,7 @@ test_description='Per branch config variables affects "git fetch".
 
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bundle.sh
 
diff --git a/transport.c b/transport.c
index da639d3bff0..0f20fc56e40 100644
--- a/transport.c
+++ b/transport.c
@@ -947,6 +947,10 @@ static int disconnect_git(struct transport *transport)
 		finish_connect(data->conn);
 	}
 
+	if (data->options.negotiation_tips) {
+		oid_array_clear(data->options.negotiation_tips);
+		free(data->options.negotiation_tips);
+	}
 	list_objects_filter_release(&data->options.filter_options);
 	oid_array_clear(&data->extra_have);
 	oid_array_clear(&data->shallow);
-- 
2.46.0.164.g477ce5ccd6.dirty

