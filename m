Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B143208983
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624790; cv=none; b=eQtsbNkKySTVfBPqKwLEQr011ED0MBM9rhWBcZyUZhEBjJ6Dn/glvNmzMaGvwG3c5h+ATorJ7lNAH4vO9kGxLcFGNytT1LvfEvp6swRoQpJ2H5NPWmxRG5RQ8JOv2EWaHnd4XO0lkHwe6ndFg5OFM5PiGSiig07JYy17BM3065c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624790; c=relaxed/simple;
	bh=yJC1w/xycMqIXIducOqTn3Hsjcbnzx6lmv2R9/ALpkg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMgUcT5b81OdKbRyId/g1Kpkkih4hR54PyG48G9eSH3WRaNGKfM92Wkt9PAWA/yEis3sJopMREMk+4hgfw+HFzh3FrSjAB6oiGPr+21xNo/+fBj8Cf4yjGNcGMu6fK1pNrypHpb1vepjirpBBNRNqRSefNh2rxKrxrUeWdhpGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AZL4OBG3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AWaAlkM/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AZL4OBG3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AWaAlkM/"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D206511400E9
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:33:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 11 Oct 2024 01:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624787; x=1728711187; bh=+k26Sr0L5q
	DX5MYZuttPVSscffqxxNce/ZnwAcLyhjc=; b=AZL4OBG3479cwJk80Pn81ubliS
	6sjAwTSiZhTTFjq2SJ6d8gwI/jGCUfhBrudSx2+q7TTdyE8BpE20uF1zBc3x1V9w
	L/AiZCeLRlMnxSqYxSsSmZnnZJJviPN8alrRwErh3aImDtZfIOMaOs+5owdvL/Ep
	P+s+RgWgMaTwK9q45XlHwjmEbghiZs9ImQbYW6HigWDTwFW/txgDHt0t89tLJp6s
	SK8pmz33eTSq4QNASo+v11QGW/ZlaEJ3X+WvGc8D4vIqS9Xob9d5rAWi2qXE6rE0
	AMp1Pz14Rj8awtIUITlo9pFcdAKo2O2Z5EB9UQmMvN+4cJFAyoUtR02nJTHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624787; x=1728711187; bh=+k26Sr0L5qDX5MYZuttPVSscffqx
	xNce/ZnwAcLyhjc=; b=AWaAlkM/R6ci+STpCs6wi3MrWI4gw7psQDRfjAOb463j
	ZfUyCwA8xQ8ADgstRJUgBcPLmAt89T5XiDT9IVp3R3nO4hKsa4VmQCdRjUe7UvkK
	YDD+EfBkcgClPo+xSBIcLFuBDxIBO+NBLJhu/GCa0MCxuyihcNlEM3g3Q/R6a7TR
	fsDBuvB14Z4u7RHFTXUrXG6Sg4XEmYo2TI3myZ0SUY+GsGxrcTScK+trog/DrbJJ
	KBjjJGAmPoG8KVq5JROgXSAS3XVQ2pBbOCN9oVEX6lYid8IZ0X69CLR0yZ5tAqno
	gyJDqEsX3w158f4g4my0VZGsTuzcn1bVj/mpr70faw==
X-ME-Sender: <xms:k7gIZ6JOXcuARM1rcgvqGoGRX_8guQe9ogC8bXZwmDX8hUtOs3G1sA>
    <xme:k7gIZyIjrqww0ZpQirvFwgKpEYaVt3llhkUpQRa6eJQUsbCXcSaHNXfnIW1YEFDba
    8bPzEYJ5p74VN-v-g>
X-ME-Received: <xmr:k7gIZ6vZbdBnZYDvpfuhq7o6pEiDUBAW9iUOAzA-26RXmqMxxpR5qMRrlFjnhT6NzSUGGdqQj7r8iKuBJEsdMvemlN_FG1sFi3KHV9-AXCr_ehg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:k7gIZ_a73KjykvShFlmDQ8bENVkW5VrQNBVRYXuJDjEm2rd6b-GuPA>
    <xmx:k7gIZxbQ5g0aU3iNv_l3tZDOzJ25T8BRC6JC6ALy5MGGlTzuIaFUow>
    <xmx:k7gIZ7D5aLP1RUNUjqnDmtJgICLXWM4ZtU2vmhKPTKow6XPgq0TMjQ>
    <xmx:k7gIZ3YB5PR-kP5JO2T6GjyUj-96-DwZaHvIexQk1yKwdaBIta5a9g>
    <xmx:k7gIZwwQF-11wkLbX_vc7rW8lmQiJap7sw3KBHVhy7GFv1pDabGAjCA7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:33:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5b2ccd20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:32:00 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:33:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 18/21] t/helper: fix leaking buffer in "dump-untracked-cache"
Message-ID: <71fd1c76b8a9daa338b2669abe0b7fbe19484abf.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

We never release the local `struct strbuf base` buffer, thus leaking
memory. Fix this leak.

This leak is exposed by t7063, but plugging it alone does not make the
whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-dump-untracked-cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index 4f010d53249..b2e70837a90 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -68,5 +68,7 @@ int cmd__dump_untracked_cache(int ac UNUSED, const char **av UNUSED)
 	printf("flags %08x\n", uc->dir_flags);
 	if (uc->root)
 		dump(uc->root, &base);
+
+	strbuf_release(&base);
 	return 0;
 }
-- 
2.47.0.dirty

