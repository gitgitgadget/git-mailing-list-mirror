Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C3C199246
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530965; cv=none; b=EWsYdYVgILR/X70AYpMya8kF43ScUtLnK7X4UYdOkJdJGhofrAdZlYB606IAHfywEPCo5kwhQZhn/vLbXQrPJ6OTFVRix0ardijKx6RmXdeWqiU8TxOjm6Ri1EJGDIgM+gsKPQnrLrvFbZj17YO+Kkmur4yy1lStnSFnwT59Nfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530965; c=relaxed/simple;
	bh=eraQUAUR48ZkU20xsJ++2AoC1B+6Eus536H6aVawGB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmPinsyUsHc5cK5G1Vqn5s8u8/06m41sEGfuTh6rqmRIQbC7rdhSqh6cFPYR142ai9zHCPuupElB63pIyXKNBlHvwsIp7FYs+L9kRZs8SD+4Gllq714YOCC6tW2JaJHQZEWHdntoat7+lnojk1j26GpuN2GrRo/JG2mtv9O3Jf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KT4AhIL1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z1kypia7; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KT4AhIL1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z1kypia7"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD81A11400DB;
	Thu,  5 Sep 2024 06:09:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 05 Sep 2024 06:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530963; x=1725617363; bh=XFShJbJ5du
	UoNmgFcv7Z3cbPKeHX+PtCL0kcsHu+ujE=; b=KT4AhIL1tkzSJoBrxF6tBjymZW
	dbP+j05VMPJmQQ1iUCc1BVOgQGyqYGuJMmZmZcRs1dyuO1aPazV8RbOyMP3zJQJt
	JMwJSNTQfOaUJcJb2syaCB+0rPdEXk46Kb0q+DR3Mw7Z4sqET3FV+jHtfzvgKOAW
	Sz2yydxl0FF2tF2qfJW8bYmYQ5zjQxVWF0rTjLXv16poggjGmOcpfh61pUxkMVOL
	EKSeT/RcNGP0IztiVgnqyICU5mLH6XlE2HCgz2ppSbCovyZ8ULYaOx+H00aPitGt
	8uDrt97F1V3FC28gg5kHb4HvFeH/a331S2NUO3R1+oNLn0tyOBmqi70VHJ/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530963; x=1725617363; bh=XFShJbJ5duUoNmgFcv7Z3cbPKeHX
	+PtCL0kcsHu+ujE=; b=Z1kypia7NK1AYGRVz7MKzUDmBNgs+fi9P7HX7MM5gDEe
	9IlNKjdrAjSIl6CRoBN1krtfe90vkRW9n7bgyoCSnmiEiPF3L/N1ejD+dEyAfJXh
	+e3nMcUHpFwhpiHkE37pjNc6aiK3VAkgyZrr84RlTn42776eKslclv3DOrDd3wO1
	1f2ChXHgDVB4klMV4Umf+G03ltPSyjHZpYg3WQzeTqQIHRey8pXsudESatAAqt5g
	9Ywb0SEU0tAvGbG75C6ccvh4G749apQqM4MZ9rXZy/Jy5k5aIUtaxSK/idtX4X/6
	avg9tXmdsXKXV53NICEN3wdWJDO0OpjOirJ6cDiyQg==
X-ME-Sender: <xms:U4PZZpZmogkKJadX6OU6fkUvEK_P1s3mm2U_hSpZAJR0U4ImqGsP1Q>
    <xme:U4PZZgaOjvCe7ewJW6d6RYDdn4RUQJPiIMLn4oWBhPQFfmacRAV7V3wJVwl_a4wq3
    ddnUjcOmCyyoKio2w>
X-ME-Received: <xmr:U4PZZr80NJkhOpXW-OLCRQwYUAL9Vn4nZihZbCXCN3KsdzhGagovQxKbXTUf2CpSI4t6n7sTMtAVEUT9TdN-gc2KpSetrJqqqyMODf8D4qVX5ZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepnhgvfihrvghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:U4PZZnp7lak9nGeLbtzRbYVqOBVRNy68xCrZ8___UX77GaudlJLY-w>
    <xmx:U4PZZkrzUF6WeuSudXVKJdZn6zK1uxO21hynHq72ahJrffcq1IpOTg>
    <xmx:U4PZZtSuKth3uJ6ZmAZ7mpZiFaxgRH-VrvkCtsb2zPt3BSc3EAtlEw>
    <xmx:U4PZZsp5TNmyT8J8VwjPzJny3D9s-uLm2neY7i2cKW1eaw0yePOsEQ>
    <xmx:U4PZZledbh5sVkjUZknwmU0_1cIQDmtdJyWdoSgxQy_OuGBk9pGCIM3Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:09:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d57d9d9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:09:10 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:09:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 15/22] negotiator/skipping: fix leaking commit entries
Message-ID: <66ed1151449aad1d39d0d6fc10844e7938ea9209.1725530720.git.ps@pks.im>
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

When releasing the skipping negotiator we free its priority queue, but
not the contained entries. Fix this to plug a memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 negotiator/skipping.c                | 7 +++++--
 t/t5552-skipping-fetch-negotiator.sh | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index f65d47858b4..b738fe4faef 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -247,8 +247,11 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
 
 static void release(struct fetch_negotiator *n)
 {
-	clear_prio_queue(&((struct data *)n->data)->rev_list);
-	FREE_AND_NULL(n->data);
+	struct data *data = n->data;
+	for (int i = 0; i < data->rev_list.nr; i++)
+		free(data->rev_list.array[i].data);
+	clear_prio_queue(&data->rev_list);
+	FREE_AND_NULL(data);
 }
 
 void skipping_negotiator_init(struct fetch_negotiator *negotiator)
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index b55a9f65e6b..4f2e5ae8dfa 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test skipping fetch negotiator'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'fetch.negotiationalgorithm config' '
-- 
2.46.0.519.g2e7b89e038.dirty

