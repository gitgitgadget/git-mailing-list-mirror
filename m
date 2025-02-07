Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED37D1E00BF
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929138; cv=none; b=bqsOxX/aABjUNuPywtmZpqC712s+8aZn12n2vBU7R5l3Q/OJUI9I9W4cfUGcIgR3VrSBu7TwoXtPta/GljHKq9HbChRn8rigN80pja4++t0z6D2lrHsfIc/Bw1WhtQEMbhZgjJQLsO109cMkIiGdNs8T9xxGZn7rdkD+QJp+Meo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929138; c=relaxed/simple;
	bh=pec/R90NLvALy9Gbnjmrz/7P3RrBUqxoAtOfzWm3SF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FB1PZyMDJoU7S9/2tcVn0fSPslp7KJND+eKfbTbwy5Ok66B8kReejEXVdHLENZMwsl/3UvvWc36ysE3TvQ52/aGbGxKRrew/ELJEyb0+PNH4FkX83QBNuepdm/tarTt7ajfhmhdk35481tj/6qNGC0kGz3KQ/tYM4jU8tt5NZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kxF/Y2oI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WFi45AP/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kxF/Y2oI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WFi45AP/"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 45FFF13801CD;
	Fri,  7 Feb 2025 06:52:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 07 Feb 2025 06:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738929136;
	 x=1739015536; bh=lDC0UHBOoKIXw58CdUlY3qbgPWOqWxkPRrpmO7ofue4=; b=
	kxF/Y2oI6+msHOyTxlzdPCvASwxH37VYuXPC7OCMrWC/tHcFvrLsy5UoUXYbpuF+
	qnR8rwobv9NIsNocX01a2e0rkKStMULxFYvGQAw7dngGHavBXU4wuv0glzHWACi4
	vJEKsC9wgAfYxluw+DDIduiWTbmYvm4k0j1CYgWYqYd4D5nTyqaYIIqav2hLFlZg
	wYC7O/fhEY6sjbXzC1HTmGYilwSQKsdRCuif3dXSBVH6IhmBtgqXDnVCD0j+UPBz
	ymqoXAc+BWrTdw7bdbnKMq+VbbNGMj1j9XPquQTxqylFQ0YzaBsOeaQWo4xucjPo
	rZ7zLCuGg1NaW/uXBR+FnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738929136; x=
	1739015536; bh=lDC0UHBOoKIXw58CdUlY3qbgPWOqWxkPRrpmO7ofue4=; b=W
	Fi45AP/cYHKtpnWSPdYn/dzOIJ9wqmcD5DCa0+AoXeJY4jvtnkukXlkF7aga8eQJ
	oFjUZVcRBzssfQGCvDkQu8z8t4fN36G6U1sxbfPNMCGBB59kbZiA65TABI8P8mTP
	rauZeM+wH8LQg1Pvj+vK3LtAneXUvFs/U5FzsjAb70hRd805jk+zPX2RRHaKOQ6U
	Ss39xe0nh5d2oIe8peQgN7hqssgqemn+/upnHYgi5yWlb33rzlklkzPr8Kxf/bhQ
	hoJf5XZkj6Gs5gRCwISdhMdzwzas+RhbYeDSgRaX4B2/gRjjhlXpoAV+uB+Vusub
	40GdT6ngYE1pQ8DiBWDhA==
X-ME-Sender: <xms:8POlZw-0Ts1ln_OfN3BhruXuadStpkvkWxkhcI0O_m0ovcingldKZQ>
    <xme:8POlZ4tAEmhLEp3Bx9qhuQ4r3PxUKmfnEIaNG2cEQ5hMQyoyYs0AoUAoFYK-IOvnu
    ae7XT2uie25CECKDQ>
X-ME-Received: <xmr:8POlZ2C1Rrc7pLYNpBt39kg-sUR2Wo8kYpRWiiZI64SiBqaoJSA3noD2CEvqszSb516zrmrheRH39Yf-VyW-G_Y5SskCMhcivjE_doDEjJnCdQWH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:8POlZwfmckmGsFAoyZTNkF_Av3erbtMArvD7RflNp2DD9la1EGvA_g>
    <xmx:8POlZ1P_Td1J7CXqLVi1Tfp_lyuKH9wdHEz3FRCG6EqEommF92DP_w>
    <xmx:8POlZ6nkBCmfGgfGUikZXHE6ALyIjtMqnpomEd8dks6CeYGkRa81Gw>
    <xmx:8POlZ3vD7qiatedm76Sei-fuYDDyVmQsD7Cs6rRg0RA9EkqubbLsPQ>
    <xmx:8POlZ40oAz1EXi6RumBUXOEnJEzQyd4KQ6CUvQNQ9_z_OmibAuzT641B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:52:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9c742320 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:52:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:52:07 +0100
Subject: [PATCH v5 12/18] reftable/stack: stop using `sleep_millisec()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-pks-reftable-drop-git-compat-util-v5-12-ba2adc79110f@pks.im>
References: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
In-Reply-To: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

Refactor our use of `sleep_millisec()` by open-coding it with poll(3p),
which is the current implementation of this function. Ideally, we'd use
a more direct way to sleep, but there is no equivalent to sleep(3p) that
would accept milliseconds as input.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index e22577ec77..7b0b10cd38 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -524,7 +524,7 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 		fd = -1;
 
 		delay = delay + (delay * reftable_rand()) / UINT32_MAX + 1;
-		sleep_millisec(delay);
+		poll(NULL, 0, delay);
 	}
 
 out:

-- 
2.48.1.538.gc4cfc42d60.dirty

