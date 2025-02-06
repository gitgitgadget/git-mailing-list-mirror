Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0335225A44
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828351; cv=none; b=mRcp8cT1CyeQBeouSn9WlAgMcgi+nnBgSRCV4YyKA4LCzEJ+Uyq6iLNccm+D+fT/fDzCxLL0UY4OSsQDJYsaSiWPwQ7sK19zt+0aAc2hE137NK4qkBWp4dZB++g78jCPbDM76v7fFrPM3XNA8aZ4/wRcHSnRdQh5a0o5SygEIxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828351; c=relaxed/simple;
	bh=pec/R90NLvALy9Gbnjmrz/7P3RrBUqxoAtOfzWm3SF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/U2+VTBnATuWpIA1PV3dG8nI6xDWjuk6kLXh6B09tknIVXNJ8ZJR/bxnHIxvt8Qi6di8FX5KSnngJq6DGLdfvd8OPlt6V1G+CkVr4FiTX1TuLokU7tqvJqM+0VWzTM6Qw0yUTgLgsiGAWLqkEHnxHAj0y7sSQ98NmBFkO+Ylpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RfgygElS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NiOMMJbJ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RfgygElS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NiOMMJbJ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id E579F13801F6;
	Thu,  6 Feb 2025 02:52:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 06 Feb 2025 02:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828348;
	 x=1738914748; bh=lDC0UHBOoKIXw58CdUlY3qbgPWOqWxkPRrpmO7ofue4=; b=
	RfgygElScafAjfs1KySdd4Enr+dgywMSqBb84SQZxsu7yxil/WEYF+uxXp3q1LQE
	rUDcGzRuARj2pKFE/U5jNR/YiJRoEzewC02rwc9U8Z0dlCrBHrCDNioZG03iboSx
	dgX3UhVOMjCykK4pLX+UZDO96XqrR+l19QQeN4CXjlEPxmXebNf0K9F/3sdAUnMb
	aVurUpVRqIMib6Bwr8tI4S2Pbg3Ch3odTFd4ZzSd2X0pVO3c3keAcLu/F22Zuuu+
	5uP45e3zYSmQ1fRG9KNk1ZgexKXgAuQ8pbDGEQ14ZD3Ll/pTGCqbfo4J6g1S5acJ
	sm0BhFQyBRAvkjqeDuPsTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828348; x=
	1738914748; bh=lDC0UHBOoKIXw58CdUlY3qbgPWOqWxkPRrpmO7ofue4=; b=N
	iOMMJbJw8gJoa/DVYfdW9YwxABfnp3mnLN+5jXw/1i7hjgI9Y95igYBg+6bVuzsB
	XDGxGJnlwho6oFDt+8Kjyt4KjJS0SipoBVGeANEf+9nORQVFkQhtKVlCUx+HwMLP
	7RJQAZHTo4H+eBfmJuVi3NETvNXAXF1Rmvhc0KY9xlxPz+uD32Bkvh838Il5ra44
	aNFgyjEDcIV37iq+/98tUXJOfJ4hykSfJRllqQTgHK8Q1kVXZCx8Nbpt04ZLuVWM
	Ohh46eBo42osFHu3I7IU66gD4ygJojnWKKBt0/ETTIYDpv5Cy1VFJCqikbXD1oQQ
	PGwXRJNfQi8e7TEFJA5fw==
X-ME-Sender: <xms:PGqkZ1h409Jb2TmIxc_gHdwdPI5T-g75IsidPwaEcj7zy2HLOW3Mwg>
    <xme:PGqkZ6BpP0vPqSPE-UfxE-AeEWV7qEuT0BEUbKVlg2hxTJm9sOWhKyORnmsL2mvdB
    SjTSo2AprW5JShQOA>
X-ME-Received: <xmr:PGqkZ1ERxhkX4MW1UZbZbXiSHqhhNL8jgwaSITxsErz8FNpZXMSJfpeY41JFwkDN3lxS6li8Vgcy4XcPgEGSXhnfrCKrFmMckLNYIm6omX3h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvug
    ifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:PGqkZ6SRc2a8HrAXDLwi6hcpG3kW9DCSwwBvDAUA6S1WqpOSY3j-Bg>
    <xmx:PGqkZywfgislzYX5bn_CvO1rZy9cnaNH_TBf43d9mdmK8_thbJtDrQ>
    <xmx:PGqkZw5q39P1UFaQccoSAOKNHPt-e823ruyrq3dS3tp_LgkkNX5sCA>
    <xmx:PGqkZ3xN7kpG6up8HN3EtmaB6xHVnj__WqrElCaI3cItQ2DUoZJkEA>
    <xmx:PGqkZ5qR6zfnN-8COv-cJzUdLjLKvORB25GVuGMpC51MPs0KMCzlxuRG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 02:52:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d7c2cd57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 07:52:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:52:14 +0100
Subject: [PATCH v4 12/18] reftable/stack: stop using `sleep_millisec()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-pks-reftable-drop-git-compat-util-v4-12-603d276d5f95@pks.im>
References: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
In-Reply-To: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
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

