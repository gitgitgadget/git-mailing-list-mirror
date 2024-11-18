Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7381AA1E7
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944047; cv=none; b=AA99Tng4MosF3N4bQdRvsaDTHp16FYC1/TpSprsMi/QZnEbwzrTjAAqwlh/9D1QxWXqKuH9J7lMGgr/tLa3eBOz3V81uNHWHFOx/mP59Sq/vWEddyrF3PqUkqB3IXCmX2ulCTjE6NNUz4Q8bL7re9AZLM3+ixGplu36IhMqR0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944047; c=relaxed/simple;
	bh=rFIgtVtM1ybnTuv8XbacorfnynVstSBD4mYi543Okxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuAZcl+/h1XzqzkV9dCLIzQ7kKC6yb06D4t3/g6abWcGwpLHQLrQeltGSq8yyvr/rQryKDKLiZsQFlTzOIR6K2unYKAJco+iXcdRKhxKiguHbChTDW+UrpUDK0rAGe/7VxMVRfIMc+jhE/jgfAjQgWUznEAvWOtVu2oiEicPhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uA07gT25; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jC1a42sZ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uA07gT25";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jC1a42sZ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 34D001140230;
	Mon, 18 Nov 2024 10:34:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 18 Nov 2024 10:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731944044; x=1732030444; bh=2rBgOxFgHt
	Y3wZiTsXmtxtg2LgI740Pve9nxzhIh90s=; b=uA07gT258dnT8wIao3eeuzLdpL
	Ds2OiCJAcJqKl1/3XRfe4jcYScHiPqtgdYPlvOOIj9eEHVcZ0BDT+U/Ok58uR++T
	CBxbfut1wKi7LDgVVXkyolv5hbuorxMRPrHkwsL5dZReUTKcCc+2IecOy7kdMQY/
	OHxloEsRKGNNvBLJnDrd32wS2dkbHXrCHoLo4VtlSgN9v4BV8ZqNYKlOzPhmwtNk
	Nb8b1Bq0j5QAeiJL1YQNjjC5yxrA6R1vc1rEc+HMTL1T/HXVQmQy2q+65stedy4c
	KGLybvzxq+CVzPJG5VeriI4p88hA7rIDL0BirOCrKtaRrRgjRjyfj0s/K7Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731944044; x=1732030444; bh=2rBgOxFgHtY3wZiTsXmtxtg2LgI740Pve9n
	xzhIh90s=; b=jC1a42sZ1fdjwN9YpHDlCuePS27rV91ghwxnM5BAU+yyTJTkvUQ
	GmtjkyLV9yf2BQUglRsx2+IszRnGfUYTHYylnIfW7mQNXTw9lA70w5CjEciE0qaE
	zY1SvecOYGUxqwwO/0XJgLRksscTvDwdOxqt3RrwdjHhnh/3CjUPyFSRf4p5TJLm
	Qgw01GgvNbpZSWbrsUokLEz/NG6Px18OPInC4y2alqzR/a3AW6zuIb91fHJyErU5
	yer/RTClUD5UCPOk4oYBufRicRpoBhsxHJtYWeTMubD8eIFBXgVws9pwmGBpZKym
	l+fhm4oUqGmco0tjSXK6XrEApABMAspfRVA==
X-ME-Sender: <xms:a147Z4LNsE0roViryb3h1Y2-ciGwLNyOGM9l7NhVyIJJKOGbXp4raQ>
    <xme:a147Z4JouGRPvVCrkHETwOwdtOaQrDXJUVzm3DqMHG3CDwBYchdpYMU7UMUkOfCtM
    3HoQSUxzyIaHaKv0w>
X-ME-Received: <xmr:a147Z4ujoZvlseNWiHK6peumIGGvR1c2wKIY6d1HadkZcUCEjxs29bd1a8RPXJNBz7oSJAvUFT3Rny0Pees34zqjZ2SCxtvoU_eSo1JZik0qpl4n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegv
    thhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:bF47Z1bwyA92LbWQL4jP7-BYCvpf1OeNjc3PHCp97CRPziFV2ol1-A>
    <xmx:bF47Z_ZcB6DrqS4QlCY_eu4kCkHwbUVOKByjz6WNk0Iimin-b5uBuQ>
    <xmx:bF47ZxA1Vkjqjn4j4nedxFKRXIgaSPl4MTizFsybQH6TUMv3nZQAWw>
    <xmx:bF47Z1aJvn23jQNpNEVcAMkmmLPyCqSIREiNPfJvndOQOvbQ7moj1A>
    <xmx:bF47Z0OX1KUyMNekaBj3whgBhYbMys7mtvDp0Oe-4VDvflrbUbw1xxCO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 10:34:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 14441072 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 15:33:14 +0000 (UTC)
Date: Mon, 18 Nov 2024 16:33:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 1/7] reftable/system: move "dir.h" to its only user
Message-ID: <2b7d4e2852977659752f98b782784eaa6780bbdb.1731943954.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im>
 <cover.1731943954.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731943954.git.ps@pks.im>

We still include "dir.h" in "reftable/system.h" even though it is not
used by anything but by a single unit test. Move it over into that unit
test so that we don't accidentally use any functionality provided by it
in the reftable codebase.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/system.h               | 1 -
 t/unit-tests/t-reftable-stack.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/system.h b/reftable/system.h
index 5ec85833434..8564213475e 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -15,7 +15,6 @@ license that can be found in the LICENSE file or at
 #include "lockfile.h"
 #include "tempfile.h"
 #include "hash.h" /* hash ID, sizes.*/
-#include "dir.h" /* remove_dir_recursively, for tests.*/
 
 int hash_size(uint32_t id);
 
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 72f6747064f..1b4363a58fc 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -8,6 +8,7 @@ license that can be found in the LICENSE file or at
 
 #include "test-lib.h"
 #include "lib-reftable.h"
+#include "dir.h"
 #include "reftable/merged.h"
 #include "reftable/reader.h"
 #include "reftable/reftable-error.h"
-- 
2.47.0.274.g962d0b743d.dirty

