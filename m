Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCAB12FF9C
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793778; cv=none; b=kNe4SDfCsISzU8V/lAlwPNYrDwA3ICvHs1PDhAoFPeV9PR1XhsjYHIqMlIipGHosnoLYvF5HqM/1xWLC6Ah29VlYAuPeM6G2MRFDwmp9WbNJNkf5qXLjrAKli1xRlHxQ69/PyexiAeFnR1PT8KYe7DHSeqtMTe3k0RfxkpGycew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793778; c=relaxed/simple;
	bh=c8tANOf9HIEw1abt3DzbHAjptNxoa/bBKDv+2He5HR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIipdWg1+euigSH4CK8lT50wMW0cuJQaLj9+wLq9t1Lfl7vMNkceGNtopl0JfjIB9ocmtEkzowDN6dgEx6xzqiIXgv+/Kh03+IbNtiOmC0lfNspAl6Aa20tDWycbEeaQIzB4akUfI5qKKp3j4lPZ2Hj5EI0nkM+n8sOXUh06EhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HheuNnwy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MZJUnoZd; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HheuNnwy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MZJUnoZd"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id E9C44138CC82;
	Fri, 16 Aug 2024 03:04:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 16 Aug 2024 03:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723791895; x=1723878295; bh=kcJo0CT7C/
	Jqmmeji/44BTOS2+aNomauX9klbJ9awEE=; b=HheuNnwyGBd8uWqzz7ceQm14n/
	s8lx9z6chjJUjK5rk7hOM4J6qsuf8DjEMDurXPkwZVnNrcTWqxSD6d+uR53Z6LfT
	FsBeRrlcr4acRvfLI+wcF0koH0ynyHqUE2Z0AhJXpbJCH+gLOG9vn1VCAOtkCLTb
	T4geQ9TcMG5jiE+DSir+g6T/4qrsNayVlAwrM7Fgn0OO+KjOCJjaSA72G+0mHs+P
	ZWxfEbxwgNfTZr9/HzKN8HbiP4aoU3yE6SZhsng4pp3GaxLgtsqp+vEuMoqSkrtH
	rm6I7QUrQ4Ssz1aIPhladxDyblB9z6vzuuRI+FHjC52DTbZN0zTof5PznnCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723791895; x=1723878295; bh=kcJo0CT7C/Jqmmeji/44BTOS2+aN
	omauX9klbJ9awEE=; b=MZJUnoZdhCuT0WhBa0KAe9+3YdqQzNdpbmtVkBQd2wrY
	wj8mGfumk+qZRrDXcdyun2DHC786cs2rmyaSTv9xWzlfF2fGK16lAQx899EDA/0A
	2eJnlRgtxq1HQvGO9ZYcq5e7SHC6k3Aq4gtLRuFCoON7zFDrzv5qrbwwVd+hSgZY
	xLsWaX3D883jjcebfXe3YsCcnCw9ZjIYUcTQGmt/lXkZwsOjm6PPIq/4ub8pd1Xq
	pf/zeaORxnT+L1o78obsoLHGLj2ghrrFa3eMg28bGruUJmuq6YkxBKKe41dbqu/r
	bgVABw9jM/8z/I90MVTrdLy4KwWblFSbsMrSnHYbAw==
X-ME-Sender: <xms:F_q-ZlGqULmYWK-C6Z02n0alzmH04xyYPPAAJE0iiat3wVvWg748PA>
    <xme:F_q-ZqVm_-gohAwoZRGzTRoxiWLsEY7h-WL5oal1GiVmlqc9XwFbq5JCvVmPpg_NC
    jr6L3EcZWG3c2sZkA>
X-ME-Received: <xmr:F_q-ZnJKc1hsyDsIpoxgDyyVzb4gyDp9G90bsEaRFHMy2n7UULN3biE-VkBfu8agQxCM8lrbkRbjFm_Qo8m6A8YRmsihjg2wpExcdzsY8GWyFj0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrshgs
    vggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehsthgvrggumhhonh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhn
    vghlmhdrohhrghdruhhkpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtgho
    mhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:F_q-ZrGK9P-nx1X-ajLLUdTuMdPif8RQiQ3FnvZ32X2a2l5n4cVejQ>
    <xmx:F_q-ZrXXKUWsOboKGnvstG2ljxH7ZEpv9hj9KtScfXzyb_iiW-etIg>
    <xmx:F_q-ZmMSYFzZnI9t6By7NadCy1vUICq3yUQ6AqsAGlikq1RRXa0-6g>
    <xmx:F_q-Zq1XTuVmB2Rv4pk2bax3dgGkHfZ-sbROlZmnHVLaHZhseqi0Mg>
    <xmx:F_q-ZnqzMQ-ylAWtTJqjz8kfbJ80s6OCIk7R6E2zMcfB7IYFJu_IrDPL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 03:04:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 34102776 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 07:04:32 +0000 (UTC)
Date: Fri, 16 Aug 2024 09:04:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH v5 6/9] Makefile: do not use sparse on third-party sources
Message-ID: <88ea94ce16c365f4b6b634a274632db134c9eba1.1723791831.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723791831.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723791831.git.ps@pks.im>

We have several third-party sources in our codebase that we have
imported from upstream projects. These sources are mostly excluded from
our static analysis, for example when running Coccinelle.

Do the same for our "sparse" target by filtering them out.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5384bf8104..377ea7e144 100644
--- a/Makefile
+++ b/Makefile
@@ -3251,7 +3251,8 @@ t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
 check-sha1:: t/helper/test-tool$X
 	t/helper/test-sha1.sh
 
-SP_OBJ = $(patsubst %.o,%.sp,$(OBJECTS))
+SP_SRC = $(filter-out $(THIRD_PARTY_SOURCES),$(patsubst %.o,%.c,$(OBJECTS)))
+SP_OBJ = $(patsubst %.c,%.sp,$(SP_SRC))
 
 $(SP_OBJ): %.sp: %.c %.o $(GENERATED_H)
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
-- 
2.46.0.46.g406f326d27.dirty

