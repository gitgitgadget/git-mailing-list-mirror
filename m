Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DE7390218
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258431; cv=none; b=WbCsN1qn6h0i1xuKUgmp6Om3AlvJFax2uGrBQzu/LQ+3g094Ujntr9iWY1O6YLMWksG6GHAfm5mPZ9durP+bzAwrkbgbNhpT9IgyJO/+Hxztcmdd582iYkEhvKpeTY71Pwjt/VE66hrW1IkwndgVuamVcu4Rsex/SLwlLc6onuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258431; c=relaxed/simple;
	bh=szcnxfo8q9aLdaWi90uJfx/R6EkuxTEKWziHRX1dnyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bym4fkP14f4SBJiPOKcZrL8znha+172fTb2tWAdTbeBxA1nyzKPs5wZkdCTf3EckadSxJ8jv4dscgcN/X6ru+k74SlBbNFBh/4cyxU7fOZ8Mx4Bz5opaKKlSeFLlXaMEhD9v3gkZydU/2irZ09SYixiv4ft9q7r4Cn6RP3IJC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GN9p0Cil; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mLdEPQfs; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GN9p0Cil";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mLdEPQfs"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BADE3EC01D7;
	Wed, 15 Apr 2026 09:07:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 15 Apr 2026 09:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776258426;
	 x=1776344826; bh=/Ez5O9tWl0/Rhe4Saz9TFIzKJd780EhKv/f5xDwHXq0=; b=
	GN9p0Cilimc09Gw9fcG2K73ngSE4FE5CI3mcClk46LpmqEwWAXmSTgrjr5TzQR+b
	Px6yW5kz9uJcqzGFmmNt5UlmBlb5QpRepBnMSovidzRrSZMF778NCZc47Lem4lYw
	r+VK9F64KlFYB8RpjeuWZCD3dqtaKeUNTUi+EdortsR+G54LO+1hxv82OHH8+UZk
	k8tApv4DOwHAZq2u/ujIZ48OkvNc2dqmDIEGcJE7s9YClUcD08NThflGKlVuBGa9
	qXyivFCeHWcMd9pNt4JsayxDfAnh9+kKpqCpgfQkCpg/D3J5Ji42dTT+mxcxC4Dy
	WbtvM1PS4mOSw2yN9EGPIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776258426; x=
	1776344826; bh=/Ez5O9tWl0/Rhe4Saz9TFIzKJd780EhKv/f5xDwHXq0=; b=m
	LdEPQfslJKvgw8qECpo72CsYoy5Ob/DmoGMoR+3Za0frCky6rosQf4pwJ0mWUAZT
	Domer47+ZJTDPQ2Tq0rKZzZ2zQSCsLuQombT6yIng++RSfCtQIuIz/+KDzS8XFkS
	IeV7Y0lODJyHJFKCBqePic0g2WqeetPeBeE95rUY7RWSAZLYrc9P64KoHCxUauhd
	G0fBrajy8Q/sMwGGaBfL/En3Tbrx4qvPcsJXk6ue+bvCiadKsF5Hno58dffuh5xd
	Iv8ULugP5q8hYRY7DLsp766bzeiqCcjVeqDvQkihJ3SDbcGADtrDZ/qAUerDXKnp
	Dhzhi2K7np1yUAB3YYO0w==
X-ME-Sender: <xms:eo3faWKI8Uv--amUHIFyl5s0gZrvHcMRLNNo5i9fMbEDSHzUzI9xow>
    <xme:eo3faVkVib7vQ3pcoBLfXzxpeVQMg1D-tofzUbFnNhub8r2tP5BDMR7DasaL6R7gD
    x8wwap8fSLgiitH3tkEfjgKPdxaOE2DI9N42jhQ5Krr0Ih8Vi6h3A>
X-ME-Received: <xmr:eo3faUEVFlqo7FFbyqOUmjq3qDefWeQFXxyt1qtvN80s4_kUvrSfEfcTdfUVDSNOmhht1D2W7doqKoyzOwEVDT6Fm6sB1wKR_Xhz7EdWCAU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eo3faVH2NRGzpNVLWvkULGeiXtyfnCYzeFieCBtmmgZt6yaX9i-sng>
    <xmx:eo3faRMiVIroyllTSUuDu7acPYXZ1oiDMCuoeoWE7U_7dp6xoAiMRQ>
    <xmx:eo3faUEVhWrGVoL8bUAaUMGRgkUs2WETA-kIi_vBjnHxmBgXt_0Eqg>
    <xmx:eo3faYN8gU-rTqpUdoLckiHBksWbL3ayHFtldzeUolrTe_cGbiTiVg>
    <xmx:eo3faUX43xcllcy6PFtH8b2Y43HfhJZyJuvk6fBwxLGJc4G582RyMzko>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 09:07:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 01e88e98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Apr 2026 13:07:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Apr 2026 15:06:44 +0200
Subject: [PATCH v2 11/12] t9902: fix use of `read` with `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-b4-pks-tests-with-set-e-v2-11-4e4904a96f15@pks.im>
References: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
In-Reply-To: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.1

In t9902 we're using the `read` builtin to read some values into a
variable. This is done by using `-d ""`, which cause us to read until
the end of the heredoc. There is a gotcha though: when the delimiter
isn't found at all, then the read builtin will return an error. This
hasn't been an issue until now as we didn't run with `set -e`, but
that'll change in a subsequent commit.

Prepare for this change by silencing the error.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9902-completion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2f9a597ec7..e3a7df7691 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -590,7 +590,7 @@ test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
 	__gitcomp "$invalid_variable_name"
 '
 
-read -r -d "" refs <<-\EOF
+read -r -d "" refs <<-\EOF || :
 main
 maint
 next

-- 
2.54.0.rc2.529.gd9106f7525.dirty

