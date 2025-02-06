Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C89225776
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828348; cv=none; b=eJkM2wa4qY41nKXoeKbVqJXatoibFt02w1Bl7WCopBOn6d84U6ZgeN2duuzExUavX0I0YxXM/ZQ9JHZDGykT932OpvW39Oc+taLaLElbTcxcWFonbQfj9Yw3KuuOD6sKQA/u3O0BdAst+FtgkZBjvYcvYDoCTNBVGm7MGuyJEhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828348; c=relaxed/simple;
	bh=PwtwJgqncRkQ+/QmJZLIt67toje4FcAFM/hKDh3beEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CP23I+zfcYmwA2vzckM8qzMGmLu92kCN9XxlNyDoJBVxJasQEgGP3TaIODbr/nAz5HWphj3tfbpuVIbayXmKNY1vrzQ9HpUUzX9DPRW9BGj6pxnnsm1yo0cC3xWJ6QT0jwNwQQ/ILYqmQ2JTlZTlFRCtbjv3Kxg1UxLtLozsdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YH/DRTnV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EkY2KzXg; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YH/DRTnV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EkY2KzXg"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 16AAE1140105;
	Thu,  6 Feb 2025 02:52:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 06 Feb 2025 02:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828346;
	 x=1738914746; bh=WfB8amsHkYCbCUYxXEFCoq/KZGT+ysKHg7ZmZqXzx94=; b=
	YH/DRTnVEbpZHA4e3RV0GkOjawATqLp+IyenTgsKa5SEJC9O7r2rCcKeNzzLXtJS
	yEAj6B2WW+F/Tj3a/K+INcEC0nifay1j+tSzh10Vdqmx0j6jni9+JqANiGc+O4Uz
	XtEzESHQjoy4J6vF3ZVb1k3UKCcIRQBypFZgctlC18+2+a0hqXlqU2uxx16oJkgx
	HYpozPtoT3wN3xfL/JELJR4vDVNRBbdiPulKAS8stZNw9BPZgYyqDXsmY5xphBX2
	NwxLFJonGbVmoJesp9McygA7qH5mq9MyP2FK4SnciyZ3yQZpXzfKrAIDjl5C3LhN
	qDzMjOnIsIFL+SIp4xs2iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828346; x=
	1738914746; bh=WfB8amsHkYCbCUYxXEFCoq/KZGT+ysKHg7ZmZqXzx94=; b=E
	kY2KzXgPZpvWWq20Vk/u8CEqCCim0QfRE8sHhpx+nO8Eiocp6FM/CJmPh/GFWkmh
	9fAldPU58uuDt/7nMgqFZgs7AsWCGdulHTYo+5hQs82aA6Sz6Hsihjlwfh4vIQhy
	noKYJScAd2gApFNsUyjSLXIx3TuhRmuxNQnRkfWYPQMLpzPO8D3XCB2SBuw54qYM
	Rlg74R59MYk8dIqvS+htg94+hwISn4gA0WIVX6lgQhr7xClLv/zCjWJYEwSlbZGz
	cQj0NobQ6i7lUeYV8CWL4DCgv/3oeKe4982byaSqcxu9uN1iIHxQbfP7NpGPHii7
	ArW9HNIzzBvoWL0wymYqA==
X-ME-Sender: <xms:OWqkZwTaFv8xAitFGv11dNDG_rUZiu2YPZhxHdWplOM6xS-5W-yWIg>
    <xme:OWqkZ9yHQODr3A0085mWGUaYYpXIYqs0pf_2hOhXHpHTvGqFv6Tw089fPy_8B0q8z
    sAelBIykaBOC60CsQ>
X-ME-Received: <xmr:OWqkZ93YuXOaFzYm4jqZve4zJajkVa3goDxMZJUHyb9GfjG1brFiytWgA6lIBivrULKxru4td8Y8bX8Ilb6Wp5OkyWaJcA7Mo2jST28u4oyF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:OWqkZ0BQlxXWY7Hr3_xp0lKXNT5eoEmfYaHb5IqNiupKYFS48wskZQ>
    <xmx:OWqkZ5hvytqGzVPUO2B1gcN7YNnBopk9VbSuRUrO9aPX3Hfq6Zz_OA>
    <xmx:OWqkZwqwejl6FAeaH12MzL2OUvU_z0TmmwyQQ0JJhnU4HFXujGzUxw>
    <xmx:OWqkZ8iBOxsKC7h7ZcOhg_TpolWtnRHBCIpo6AdGVKWcPPBKAGcMuQ>
    <xmx:OmqkZ3bNwZoBGmuZ156a19M570knllukZOtVoDo4P6AC4FWuejGhRKL_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 02:52:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2ff1c02f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 07:52:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:52:12 +0100
Subject: [PATCH v4 10/18] reftable/reader: stop using `ARRAY_SIZE()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-pks-reftable-drop-git-compat-util-v4-10-603d276d5f95@pks.im>
References: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
In-Reply-To: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

We have a single user of the `ARRAY_SIZE()` macro in the reftable
reader. Drop its use to reduce our dependence on the Git codebase.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index bf07a0a586..c3a3674665 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -849,7 +849,7 @@ int reftable_reader_print_blocks(const char *tablename)
 	printf("header:\n");
 	printf("  block_size: %d\n", r->block_size);
 
-	for (i = 0; i < ARRAY_SIZE(sections); i++) {
+	for (i = 0; i < sizeof(sections) / sizeof(*sections); i++) {
 		err = table_iter_seek_start(&ti, sections[i].type, 0);
 		if (err < 0)
 			goto done;

-- 
2.48.1.538.gc4cfc42d60.dirty

