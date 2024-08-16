Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A40653373
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793775; cv=none; b=YZIY+yUXmEQY+Ou+MR0qQbz+ayiNJjaY68VSKXSkVlf5oc9M7Xt4qZG+4GI27DckNtVkrqhJVJOzQFABLTSlC7hH8E/+8t9jueW6HZEzQlUlMZSjYLxx2LXWvv+UBTofaFgXlQj2WG/56t8opTWOO08eOryJMNirtb3TpiMjt6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793775; c=relaxed/simple;
	bh=9JYxltfo8+D8cVL4HYSdBPc3yMzObAj7FvUNwkQXbW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rExWAZTkEuIGFZUUwM03TRwLAoSP8TLt6t93E5jpu/Ssc2dtM228AYq/IwI8e6boskdWghFWnbIt0LTUjwT9/h5tm0PZZOT/Bz6sSrNZi9USBDhLBmHemTjg6Bigtbf0ECRY7xWJrWoINAGkFNf/t7lES4qV/ddoYAIfrS2MNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ihSQXBtB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B2nmJ18C; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ihSQXBtB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B2nmJ18C"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5E6FC1151BE8;
	Fri, 16 Aug 2024 03:04:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 16 Aug 2024 03:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723791888; x=1723878288; bh=Uq3uJU5vO1
	TwN5ESL0+PCfabpEoF4QGgM3ojDg50j2g=; b=ihSQXBtBT2tN7/e3aB7x7YLpn4
	wqx1opBFdq1xnBe9Knq9n1TOrwN1HgHSG/u8fZT977rdwJavw3eLs+iVkdXZS7v2
	YF4FBFtmmiWadshVcD+v5rBJF6Ih6SYBzwEDB0nyZivkIcKyBC5K6nJBJlHWH37u
	8jyG2ou39AvMs1IxrQfqPBp5Q24q/A5KMm/EGijyC9cgFjSQUzfaPPyf+T5x4Lrt
	l4P4LhfhiMK2QfZU2cLE8O5iM80Hakg296R2jBpimVKV5VtviRA7ZmudG5hKdIjx
	u3gz0uACN6X10gU9chOlhlLdaVmj2ZrIN7zn6a5YpL4XRTavLGFpZHW6szdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723791888; x=1723878288; bh=Uq3uJU5vO1TwN5ESL0+PCfabpEoF
	4QGgM3ojDg50j2g=; b=B2nmJ18C6ufOVCUYbpV9ikr22Ex+gDkDV7FOnM4N0L45
	5duw2S4beF4w7V/M9YW2y3rIeVi9+H6fW3U0Cx0TKitqGs6x+DWNeVivx/107xVJ
	O77m8mQ1fo3kp8r5qCFWIPYYXwbEwsw4jIR83FjQ/Ki6CVyJvSMwbP/w3oHCXjmC
	Juy3r3gkZIGBZ6btRqWdnb33NcAhE/sGR0BRb2NmljG0MZXVAzs0WhXpFXgEq5Ob
	VXnqddZNIDGNnEU5wtFRBW0RDSORdJ805plqZUG9+fyA7FYQmyrP1l6hhw0sX/RM
	uHKCh3NpkzhCjvSxFmHlO77XYeTctJT1hknfO1s/cg==
X-ME-Sender: <xms:EPq-ZvPIWQPWvrrZYgOhevrRKvB2kBo8XHvm1n0pO-mQQafyF_Z6kQ>
    <xme:EPq-Zp_9vlm7u51Vw9nMUHfm7bWhlnNBkyDWZlLwFzGV9gwg829haJzUSpvqY4ThA
    YiyXOCAaQh8tL3w9g>
X-ME-Received: <xmr:EPq-ZuQuI3a1Jbw6yUr39U-ovfhFFi5WA6snI-XEx6AB-PFHdH1IO7TCMAvAJ-s4y8ABaSum3IaV3y9l3_gi7d_uOtra0MVZYxPbn3SoTsCzJI4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmsh
    honhdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphh
    hilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpd
    hrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehr
    shgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomh
X-ME-Proxy: <xmx:EPq-Zjs7LyCcPhLs_fpoBaAFMArVv7d7sjdqp-Ytaz9JKhMYAZnLtg>
    <xmx:EPq-Znf--iP4Ix9gEie6cwIgtazOHaLtkFZQpu1QMC3VfMnoqqCNcQ>
    <xmx:EPq-Zv3eFxv9BpP4mkQ8QvwQU2IW1dcKfFM2oQjEFZMeCAZo3a1kuA>
    <xmx:EPq-Zj_RWmXAdwiU149Ee7fTCbT_XWZ830sjIELtrbkhlA_qO_p8-g>
    <xmx:EPq-ZmyYSzwB3h1lTGFMCo_RDyUnu16WHgQEpTaXJ0wHyLv_9lvk98DO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 03:04:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 36125928 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 07:04:24 +0000 (UTC)
Date: Fri, 16 Aug 2024 09:04:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH v5 4/9] Makefile: fix sparse dependency on GENERATED_H
Message-ID: <b6199c88dd7f07d63ea1a9bed730c875b3748814.1723791831.git.ps@pks.im>
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

The "check" Makefile target is essentially an alias around the "sparse"
target. The one difference though is that it will tell users to instead
run the "test" target in case they do not have sparse(1) installed, as
chances are high that they wanted to execute the test suite rather than
doing semantic checks.

But even though the "check" target ultimately just ends up executing
`make sparse`, it still depends on our generated headers. This does not
make any sense though: they are irrelevant for the "test" target advice,
and if these headers are required for the "sparse" target they must be
declared as a dependency on the aliased target, not the alias.

But even moving the dependency to the "sparse" target is wrong, as
concurrent builds may then end up generating the headers and running
sparse concurrently. Instead, we make them a dependency of the specific
objects. While that is overly broad, it does ensure correct ordering.
The alternative, specifying which file depends on what generated header
explicitly, feels rather unmaintainable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 674b0ac4e1..0736d3c88e 100644
--- a/Makefile
+++ b/Makefile
@@ -3253,7 +3253,7 @@ check-sha1:: t/helper/test-tool$X
 
 SP_OBJ = $(patsubst %.o,%.sp,$(OBJECTS))
 
-$(SP_OBJ): %.sp: %.c %.o
+$(SP_OBJ): %.sp: %.c %.o $(GENERATED_H)
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
 		-Wsparse-error \
 		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $< && \
@@ -3294,7 +3294,7 @@ style:
 	git clang-format --style file --diff --extensions c,h
 
 .PHONY: check
-check: $(GENERATED_H)
+check:
 	@if sparse; \
 	then \
 		echo >&2 "Use 'make sparse' instead"; \
-- 
2.46.0.46.g406f326d27.dirty

