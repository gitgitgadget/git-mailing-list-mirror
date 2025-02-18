Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508C02376FD
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870526; cv=none; b=Yl5BBDOnpG7tbFWgIma+Vqz1rC3NOJbBlDWtWOAy8F2iQd0QzFAc+aHtPo9vs08V9XbSDvlshQJb+iD3hJGZwI7ckDcmENEqPYyC/9gBIRDPz9CvxiSUkB9NhR/JnHaeQ4t4x/rEB/He7Yp7QjBKu4f0XwWi6PI5PJvrvS7lEc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870526; c=relaxed/simple;
	bh=/yVzPhWEBziJyVkJqP8Z3sT0tSLjdJLbmwOVelZhZlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QBmDH6XVhKrXCgTd/KrbF+osTjW4qdcoyGJFF78gOPprb3VlMfApHF/I896SF5FwugeMkZroAaoxhYfZsg9R0VWmwEH+k/UhkX7DM5zNlzwF8F2e7MQvaWfHbsDNjKyApfo4PfwTc4tbVVHj4nMREi/8vBZyt46gCObemmd8Yis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=azrK6CwM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MITz5KMP; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="azrK6CwM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MITz5KMP"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C7951140267;
	Tue, 18 Feb 2025 04:22:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 18 Feb 2025 04:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739870524;
	 x=1739956924; bh=/GFct0E/i9JcpkwO8YWoGFAbaAEiA0R/ej9ikI2BAAE=; b=
	azrK6CwM7HxllVyUolCVntmS8jt3MPPbCRBCILg00Wi93Ws8UZk8bn0lDO4iOCng
	yi7cZ15ANPwnwmOJaj4MBs6CqrPilrwfY+5Z6IAZcjCCKjPaQk/rWjBymEJ+/cOu
	v+AyQtiYFqlrJ/JXskcfl4zcIdEqwul5yTeUL4Lc6Lao53flfBWoBo7XJqBhHtBa
	hFV2kBNH+vphIeWkxuTC8ReGqVpLcs325iJCEmPYyWct4uKFhR3j22uv/qN2MT4v
	xZ06BfW/LnACUIU2jHYc4CYIxvtTEJyfx4Cqj6+8ZZTrzMQ58fUFuMmUDZkz4GDp
	IDWlWGX70UEMJY+Vu01Y6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739870524; x=
	1739956924; bh=/GFct0E/i9JcpkwO8YWoGFAbaAEiA0R/ej9ikI2BAAE=; b=M
	ITz5KMPojpkP93oSjzGumLNBJKlNdUZOMUBmY1sghFo6EpFxfuBgZUipvOLlzhvL
	JDb9Rnk51tn2Gow0zbNoSHb3JBJcYBfXkd3EnirEO/dEYiTS2j5zgerD6s2kF4j7
	6dvOlFlAmOlU78/CEiNhdXEYk3/eU+axNm2HEQMVi+F9GvK/ErKTOefS62atchPL
	L9B4z5EJx++Plydl/jdgpBKjy3yJC5fMxz8VEHxzOTBoJxtUfv+72pk1GHfT5ZF5
	Abq18NzHqLTINboOJL4/1CFZjd3QnMQDWua85mP9IdU+ljYMOHikQl8IeENdvC0+
	NF2YjD5EbdXYXso8u7bxw==
X-ME-Sender: <xms:PFG0ZxfyCf7KahfaGV-BC-zvcFrfPCfhtWnX7_qvaIl6ktdXPqvMBQ>
    <xme:PFG0Z_PZ5oAAtLhnpPSoIawobUzSNJRD9p3G-wqCeU691TUuV4eW4r0S-Nb6szBOL
    Cw-289o4joS8zow5w>
X-ME-Received: <xmr:PFG0Z6h2f-dSfs1sgS8NZlGiBiP-m3po9qtmxjCJ225IaFXOs5shwm3JwQFaj3JrGb76b5bcXUJa4D5K9_DgMJsf5R913V7YoervEBD4ErkGcwyp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegv
    thhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehjie
    htsehkuggsghdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PFG0Z6_ho22Wz3vPO0a-T4bgKWxquLps10bfgsUIzuCqwWjGcVFglw>
    <xmx:PFG0Z9sVIvezh9z65Cj__UAGQSP4peQC-BmJeUD-v5fyfMolvB2LwA>
    <xmx:PFG0Z5Gs8GnKR6ahq2T2AUjRLHyEuGxzCGQ5tQLP3bk5H9e2iFCwxA>
    <xmx:PFG0Z0NRzZwDLehyI67TT3_ZyNr1NoIr2mjLux5Wk4auAyUAngfBlw>
    <xmx:PFG0ZxgLRJI6nD3pT_mJSDLoNEliy4k5n1rATfcXW1Xzhd9A5apkVnBL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 04:22:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ba2e0b38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 09:22:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 10:20:48 +0100
Subject: [PATCH v6 12/18] reftable/stack: stop using `sleep_millisec()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pks-reftable-drop-git-compat-util-v6-12-8c1f39fb4c02@pks.im>
References: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
In-Reply-To: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
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
index 08893fd454f..6dac015b473 100644
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
2.48.1.666.gff9fcf71b7.dirty

