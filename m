Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608F625DD07
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741726136; cv=none; b=T2IUB56InVqViGQAYHD6k1SWMQmGzBrlDn+SbW3Yb4+oaqlXawHGWGOS6XLxr8h2+ft6GmqSrLfRqbc1ZMRktnRk+bXZ7kgPRKqX22jwxO2Cw8v66QJY4KL5JsABwAPdo165uC9SAd3Zua6xKvRX6RDP7c5ICouedulPx106WgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741726136; c=relaxed/simple;
	bh=GNoGDi12sfln7aMIy3tAJaozzYwbYbnLUTwFY3YreZI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=stEG+UCpU95E+up5mTII/uPxv/gIUFTx+5EYT80p42WbBxG4olovwQcIjZL502FE8rIRyiDA7F0kzrFHF6YXbc/Uy9k0c9YhXROiMBtsvQvhBJBVqbg+S/Dja5rpVqIzCLp8T+nm3glUf8UPvNDhg0DJZdvXnTc+z40fK7Gpip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ln3Pg4Qi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AEh0ncco; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ln3Pg4Qi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AEh0ncco"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C55E11401C6;
	Tue, 11 Mar 2025 16:48:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 11 Mar 2025 16:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741726133; x=1741812533; bh=hApCkJG0yd
	aa8bHrceeFUy0n2l80tbq1O5r9lzabWZg=; b=ln3Pg4QiIc9AP7yrjDaGKXgUdo
	qoz9apdG5Gx+I/gdrzyYprikIoYRuAGkkfvn8AhlMBO/57v+4/z2U0K8oXsxpifj
	Y+XSGL105L3639usG7l4Wt+phOZCOUwuFZAAXFwbApKUR+kC8n6jG89o4QQY2e8q
	jP9LBumfkaAUgu7JrrF/Dn9nOPkS2MdQTAtaLWn7AkEwT1IY2UQ+0TABzedSqJ00
	oRckKhdaQUi1hHB+cK6U3RuqUirb5gL5T+r+LEijkLhXSZY7z2LIrK1E/rBsGN2r
	Gl6mta4r7fVLzmi2Sr7HIM/85l1PDcJnB5LG81HZsxblpCVVMcBlE4t+kPbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741726133; x=1741812533; bh=hApCkJG0ydaa8bHrceeFUy0n2l80tbq1O5r
	9lzabWZg=; b=AEh0nccoQ2z/AKb9TEuuU1Z7o0+5j6zELGqUpet8wYV8GbI5a9E
	pNnjW3mhtABKYyBb1wo0Hr6IodX0856ylW5LSg4zRzqWNMy9KvXgIK3lNnowEsep
	j1SLU69JcJtXhhX8AdaNbtAvrQ9DlxIt3UUhx1o7M4JS3iepTvNN66nr84dWdBAr
	yVxeTjjV6l2Z35FRsm5C6fJq7hvnh8wFKo/OMZyvV6omvy6WYV+JXoV5cZMhhKqe
	AkwGr2FEJgF3LP3s817UWgZsi/Z699iQ+fAI+SCVrsUft96hGmvfeLivkkQeUO/p
	vgIfdL/hleRp2sSIcWB+Rz/c1TSRXWJhVgg==
X-ME-Sender: <xms:tKHQZ6y5-QUYlbfv-8ggPcV2uqQmGM7EJIB3bFRiT6_3VD9p1nsyYg>
    <xme:tKHQZ2SyqoIW2HdqLZHEJ_gPNbjtq0xR6ZuE2-4PsrvGQfZFQQy-WYbJN6LnqFiY4
    ar8hlrVsfCjg75a5w>
X-ME-Received: <xmr:tKHQZ8UkhCLgbYTcYEdiyO3cyD2C74nIvY9of5J_THadviaCoAoEJyNZjbMdoCof-sF_LPkDjnQS42q1QeVcw0AFYk4_yHbf4nA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdefvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehs
    uhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghr
    ihgughgvrdgtohhm
X-ME-Proxy: <xmx:tKHQZwgSzGsVNukUIXLIzivG5ZoOVOCfuiYZxAawEAjb6ttX-kWikA>
    <xmx:tKHQZ8ChugmWebT47cEhed1boMyEkJLKac4NdhxjX10CsXU4rB6Vtg>
    <xmx:tKHQZxL7r-8lmgrs1rYszmpsDtd-Dr2YUcTbnBF0857Spuq-g_EGeg>
    <xmx:tKHQZzCktawKQFDLzVbDHAjOXLBowFT2qJTKZotCgK-DxZsV-hhoSg>
    <xmx:taHQZ1L2Yv4jvOz_Pp5yAa8XNeWCXUhokM5CbVe7U2Gv4lsTOwwsnMDh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 16:48:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Karthik
 Nayak <karthik.188@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] promisor-remote: fix segfault when remote URL is
 missing
In-Reply-To: <20250311152413.1059343-1-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 11 Mar 2025 16:24:13 +0100")
References: <20250310074053.1886097-1-christian.couder@gmail.com>
	<20250311152413.1059343-1-christian.couder@gmail.com>
Date: Tue, 11 Mar 2025 13:48:50 -0700
Message-ID: <xmqqmsdr2szx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> +	GIT_NO_LAZY_FETCH=0 test_must_fail git clone -c remote.lop.promisor=true \

This one triggers test-lint violation.

diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 23203814d6..4c5c3c7656 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -257,7 +257,7 @@ test_expect_success "clone with 'KnownUrl' and url not advertised" '
 	# It should fail because the client will reject the LOP
 	# as URLs are different, and the server cannot lazy fetch as
 	# the LOP URL is missing.
-	GIT_NO_LAZY_FETCH=0 test_must_fail git clone -c remote.lop.promisor=true \
+	test_must_fail env GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
 		-c remote.lop.url="file://$(pwd)/lop" \
 		-c promisor.acceptfromserver=KnownUrl \
