Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE216184539
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687664; cv=none; b=I/MF0Nrp1E52tA/3vmcRj+J2WcEjOuSLrjVYuEvpgtDERjQy6j1BQdyturzXbAXm+MYU2biAWEd0TOIlnEio32MW9B259xyqMqluVhsCbRMJt9IP/g7pwXL1a7vlFPZ9luIp9EB2P5JqAHdyoHYJsR+U8O6Nuv5AZXy+xmDw1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687664; c=relaxed/simple;
	bh=KLNIVwFdWGyRA+MbOm7ddbmdg0XUywu6bVTyMRvGCiU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmI7rdZvgkqBICKH738rrzpqFFUPWypDtiSJpFzeZDUU4F0K4t9yaDk/oR54Hs8EkYLKto3yveLq3/j2croT5l7eFAdAa9FITdBWwy72NzVhRJkGxRRZieWGf/M20uPkrn7RClFQ6Hr5T12K+9A2IqxmB9u1Un0fY7f3JTW4l2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D39Nuc3O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QH1VQmSY; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D39Nuc3O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QH1VQmSY"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 27F34114025A
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:14:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 30 Sep 2024 05:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687662; x=1727774062; bh=wBwQs4VjYZ
	zmdyAnfcbkyGtaYDRla6Iw5bFzJezhD7A=; b=D39Nuc3O3MmY5jOtaVt8pYdK/a
	Q76Ezp15BLyD32oXYUHY5nfhVJlE6Gd5wh+EeTh9RTbUaAP8S2Obn4a/aVW0YQOc
	4DfXJJhsK1LCvZ3cCW4GJoXWtQ0q0vIKuwM50kAUsJXUi1SAHiqrifyhtRZYQMO5
	ysiHyAZxRT66TTDiKhj0uKxWSgCXNy1aTEnpKqRfMIVHeGgpAi2BYbzKJocOXW92
	Cf9jU7+LqHasAsaVU62TUpQJbx/ql2gfd4Umc0H4Nyqn0fCRJ0x8B5zfncxCqLfa
	H/QdSvDH5RqrHxEp8sO5W9LoS+vUKflOQyqp4MejwGw/WkbE6fPvBcCwx9Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687662; x=1727774062; bh=wBwQs4VjYZzmdyAnfcbkyGtaYDRl
	a6Iw5bFzJezhD7A=; b=QH1VQmSYvny+xjUxyWAGi+79tSfEmkAgpgZkcrr9UOe0
	FoAIWCFzCi6zd4bwyN2YO28kdn9nrNJKKkzw+Bpc22vXEU4scdcvCqWVlcIq9rbO
	PwXL2+3/rVDodw64SeCYu6v54hQjt/pQwutcOc51dSoO/s+MfA/A1R3FV9YPU8XC
	lcUudV9ZaolAx0n2BKTGyrtC/zYMNyQ0r4Go/KwSkVITxpqPROEuVmVEhlfXV+SU
	8Uj+x/rznXYXH0C1DY4dT2c3wqjiRGiiOvOrcnrQk+TXIAA0s7DuuucXmSSfKtth
	e3XpidHKD9E8PoKk4Q7MmZso11bKehNmZ+0Dpfo/8g==
X-ME-Sender: <xms:7mv6ZmRyLN8NhkS_aArh6fwojGTvmWLN96gTr2VOWXY0uYbkybX_fg>
    <xme:7mv6Zryo2GgOjaHPvtea81pm-O-hxTlDoqOxQ3w0JEs9mb_XWYkU10OQuGHPrDz_Q
    Ju0Iwird4v-LkyKhg>
X-ME-Received: <xmr:7mv6Zj0YidiJe3ngy-S4UgiEYDRGxuW_dXOGzsEhC7iYEXq6vTwPEIANlbnhcVr4BW5Bvi-yFzApjhEgKvS5aslU-mP5AYvi-JjnHTAAmq35Wug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7mv6ZiCMReH998YG7XxDQ4YgzKVXqlZ4SmEYjXMkMqWr8WF7NPMedQ>
    <xmx:7mv6ZvgtRZCjEjUjEi64ZDCyyckcusDZsSep2cVb2EIw3_lFt_VmUw>
    <xmx:7mv6Zur-R4YdufF7k2DbbsX-xCavSmvk1B3LpAvNl9EPkgVwBx4h7w>
    <xmx:7mv6ZihXAzpsDrl7eIHPhLEIpaXPxFTbKqHIqDi-ZpcyiFwAp1B5BA>
    <xmx:7mv6Znb79XeeCy15xQYzHife_EGPewcxf-nYBr4gksNlcl_a5ADexscC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:14:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f638509c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:13:35 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:14:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 21/23] t/helper: fix leaks in proc-receive helper
Message-ID: <f9822f681e76fb14b71a0a60ac8fda11f0a5bb02.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

Fix trivial leaks in the proc-receive helpe.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-proc-receive.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index 29361c7aab..3703f734f3 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -196,5 +196,12 @@ int cmd__proc_receive(int argc, const char **argv)
 	packet_flush(1);
 	sigchain_pop(SIGPIPE);
 
+	while (commands) {
+		struct command *next = commands->next;
+		free(commands);
+		commands = next;
+	}
+	string_list_clear(&push_options, 0);
+
 	return 0;
 }
-- 
2.46.2.852.g229c0bf0e5.dirty

