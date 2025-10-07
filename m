Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A0A2DEA67
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840606; cv=none; b=Xs782jgYfxiBwst8p+7QnFuW4Kl0sM26fCucfmSbWSw64zuBXMcDI632TIgrShg3pRRM7ocYu0tqe1ASPdkRDIflIHZG2jtFwR10maURP7Rl1SyG0T5TJQxEKeSzugungWiBz2u6tFHSFfASZ/EhPJ4WWMgF/xB6JOZ5Vs0UiKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840606; c=relaxed/simple;
	bh=yECt0Ug7dz28sDWiSGb/1Vnxu932COIlUQFKeRQBlHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cSbN+XXltM+ltB4FQ98cZFL7/NHaDNqRPAhW1P4P+VP4umCfoceBBPXY97b+6qmNS/DiJZ8k6MugxjTBasmtgy8P3N2kUuZIAuRHIhaH/0tsqaTYoze5wQFqhagmHYVjglteGEdkDKl8tS+Y9vkPjh3Ez1vc/wvk/s+gjgrbYwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hEzboxz9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ASm4M/DQ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hEzboxz9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ASm4M/DQ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D8A6E1400366;
	Tue,  7 Oct 2025 08:36:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 07 Oct 2025 08:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759840603;
	 x=1759927003; bh=nfokACacmTG5IMgQeWDJPg0hQYDwyCzfV4djFLjh0t0=; b=
	hEzboxz9MvXO4l7sV0Zj2EGLDWeTKK3//gT1hORZUH6AExp0rmnTIKlaRWizRHNY
	LlNS92oYHK/as7lXGMvcRmoOrOrYFP0XZMwadUIviHTDi0slZtD8KvQSEKCSI5KV
	kS7tjBjuWdSWcSoCfoLOguCB7/p4t6Z94QcB4mJrOrvPnS+gMyL75oVzJD4DgC/z
	R0m9Gd4myFwrNuoim++YgV6OS/9AbuQHAX+bfc8uyxWpLgwbTP7qGqc9xtsVm9cR
	08jfHKyFufo3xM8jmRkHQktW1WGNmN2NCdSwBE1WqwfM8+L9f+OOJGsSH6yTSyl1
	CvqKEvjECHBX0uXVMeNiAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759840603; x=
	1759927003; bh=nfokACacmTG5IMgQeWDJPg0hQYDwyCzfV4djFLjh0t0=; b=A
	Sm4M/DQBsWQMoBadEo/2JDVSBWEaNImZQYzIKzziA46LfR5djkxRZay987K+p268
	J/nPyWhB1K4l1DEErHAHvZGyzM3PCLzrdEEY38y0qxGoycqYA/F0YPJKfrk8IeFj
	28YaUVN9q7dBXH2nWlPaQyvt61R8bc7YYr+ct6X0T/PEIG9EGhwArIWzhhlp2eh/
	MSUcfhapVXyAm85zPj9uUCKDyqvtpI9xoS9IrVA+M6NL0c69wPXIbcJeZWcI22qD
	Jilo5v25DSq6QmT7ZkIM+juAbPvi5EPTh5E/ouvE5f39eNz1ZNjVaMIbr5tnOaip
	I/BU+b4W7W/AHTh+ZL1rw==
X-ME-Sender: <xms:WwnlaG7wMz4z439HzDqSdxZwNSpnm1LZdXqB5f_o_u-Y3rPRyEfSDA>
    <xme:WwnlaG7ztpJ_xMXR_Vv2TUjqVe71FTws83dMjF0FoZod-Cgfp1w3VyiBNr81aZ_4r
    6HAqSt4spda0hBjWv0W131sFpQj7xQOKZ0gNuqeoZf3XIbqCseN>
X-ME-Received: <xmr:WwnlaKeH7BF17lBYVvbzCpIoPqDY19cKchipmARf_ntsjibgcBDyTq3RRXUG-Zgg-apuHXgkTZJjU4hTxUyBUuQODVjnj2Pm1VDESiAWykg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphht
    thhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WwnlaCDaqdzvyTNk44UdCGOz3EbCVkUGJ-io1fz-7oV6l1kscnSArQ>
    <xmx:WwnlaF_VCxGCoo_MXisWTXAUEYLMrIHUekT28awO44bpDiHBRAGRLA>
    <xmx:WwnlaFKB50fRUXwmpZdoIdhQr0oRGRDWv1AnqjnvIITATfNczux73g>
    <xmx:WwnlaGjPRHexH44NIkw9E_PjxN6NBmCmkvHhF4OPhIoQsF5PLL7dWQ>
    <xmx:WwnlaBr5rGcOnpJN9xmMAYecCPeQE9Iw3g-WaYfHoISumgiDylsh1ZHA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 08:36:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 657f2402 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 12:36:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 14:36:29 +0200
Subject: [PATCH 1/6] ci: deduplicate calls to `apt-get update`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-b4-pks-ci-rust-v1-1-394502abe7ea@pks.im>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
In-Reply-To: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

When installing dependencies we first check for the distribution that is
in use and then we check for the specific job. In the first step we
already install all dependencies required to build and test Git, whereas
the second step installs a couple of additional dependencies that are
only required to perform job-specific tasks.

In both steps we use `apt-get update` to update our repository sources.
This is unecessary though: all platforms that use Aptitude would have
already executed this command in the distro-specific step anyway.

Drop the redundant calls.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 0d3aa496fc..645d035250 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -120,21 +120,17 @@ esac
 
 case "$jobname" in
 ClangFormat)
-	sudo apt-get -q update
 	sudo apt-get -q -y install clang-format
 	;;
 StaticAnalysis)
-	sudo apt-get -q update
 	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
 		libexpat-dev gettext make
 	;;
 sparse)
-	sudo apt-get -q update -q
 	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
 		libexpat-dev gettext zlib1g-dev sparse
 	;;
 Documentation)
-	sudo apt-get -q update
 	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make
 
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||

-- 
2.51.0.764.g787ff6f08a.dirty

