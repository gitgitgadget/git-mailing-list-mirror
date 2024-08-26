Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0414185260
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656946; cv=none; b=Cu4Vxkhig9TrHPRgVKrPBPGRL9p+J9vxjS4U5QMwHEhtY3oMbUuYxe2g7yL2kBVZatUDnIgoAOeK8n9LuOOMD7ZGAUGbyEGI3XXbzXW91Dchz4kPqbkaWWrn8Bby2R/42nQxl6/KfIHAAC+ocjmgMlbhYnx4b7Euecm66E4rroo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656946; c=relaxed/simple;
	bh=oCzHUbJZjB/7h+xij+ttc6xq03EWvleoF25to/4y1c8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOnMf+kmLmmuUDLQF7q18Ro+nFSB3zVVUYObnkrlWNcmRBocC3rAme44qUNG48WtCrgN8ldNbQ+OsLbocpr+vKwDXwFM+5kikCsgvhxw1SyMt8p5AxMRv/bc74GX7l08OWEsieoAWi/AyPZwgDRUuma7PVLP/E+3hQQepwKc9Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ounq9lUW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YAszxHyC; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ounq9lUW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YAszxHyC"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0CE841390824
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 26 Aug 2024 03:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656944; x=1724743344; bh=1a+L1OvDrA
	vfKi+wUJKusYg7DwsLhyjZx8uYERLJEyk=; b=Ounq9lUWpV2KRhAvGadZnqWtWN
	9b5dQBacs1TqHu/nnBbUaklraVjPUkRyfk+Ec84NMer2bnndYux1SsycGAHpia3u
	YiBWpLoHFusr6jDQJMxMq8W6N1BDfoYZ+19vKTA38bt31b8kY9kwPun0xoIaoq/b
	EtncWrYF73t1yTXb3EIIafQeGdXG1aGdRFGYT46LrGRF9ltaB3id5nJlJ1+jFntQ
	Tb0HwNAxE8mwnjcfrtCYNmlRMIBKKhLt/ocVZgnGedlkCYqiKgi6+PIt5RuHdL1I
	Fa2EX8+cZVvzw78O2zRw7JQNIBesPi7SqGZghd9VEUwhURFEraOWjMwcAxeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656944; x=1724743344; bh=1a+L1OvDrAvfKi+wUJKusYg7DwsL
	hyjZx8uYERLJEyk=; b=YAszxHyCJCzRep90KQ0FmU6JzNXEInsbnlkT1E7V92Ql
	S2P030jojkw1dI4TTNUU3giuZLpq/ahSDi+p3uhOiJmzsMLiLVfBnbl8wRBsKmQW
	loJ9+Gaq0SVRr/qxAKf+sKyJ30uEJ+/U2+v1TdaR4pHclOhAdRH+wbYisFHbDbWS
	TEFme0SYYETxAOSfEBk7uzSn+J05OQsUbK/3Dv5vX5hUGQnhNsw8TzWRL04AnNWm
	V6gtyAmF7y//WP2pycoorY9ShjJ+zDgyY89B3OdtzGJXEm0ve8nlkOfi4EMJTvjd
	K469+bTGv85qpvCsA2lMGdZmKvBrQKLVaM1JNOnxkA==
X-ME-Sender: <xms:Ly3MZjiYG59e6enPNTqw9upHvMRYjrxOtk7v8zgcYAHWHTiIRITprQ>
    <xme:Ly3MZgA8GLXMRLffRXgTqvb4EF2Yftxf6DdJxMgmvF-02xkE5gj2zcg9ogF-n9YJE
    AUcEupwmfbdDq-H7A>
X-ME-Received: <xmr:Ly3MZjHkmSia37U5Hf1GlJccbwA6LevtXLL6CfH0Qde3qCucnAtHhcV3taVg-1giq-VmpUKGBgfsOBcFhF0ScFwT7426suu0KXQ5uNhM-EfdVhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ly3MZgSbmayOc0rZiiiDSRM10V48pB8MQ7lrBgtU4fg67_7V7NgBSg>
    <xmx:Ly3MZgxdoBoaGGVcLicgE0Ry7Bu1yUHDD0GdLXQxezDT-a-N87kVCA>
    <xmx:Ly3MZm4C1xlPwzZAJgRtzHRQqBKBlCIeshYrjE3yuz-J1P9dLc0ctQ>
    <xmx:Ly3MZlxuwEAjszE2Imb8a4QXqulEQ65y13HzJoF3RQo2f49Lg4BlTQ>
    <xmx:MC3MZtqC_6W0j4s1DXf3sDC6DG6UcnEP_1_ikNJPNYSlmpToOI0jED1i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f6a1bfae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:22:21 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:22:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 15/22] negotiator/skipping: fix leaking commit entries
Message-ID: <920db3a2912c609d4ac1fca2fc6b137513c8eceb.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

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
2.46.0.164.g477ce5ccd6.dirty

