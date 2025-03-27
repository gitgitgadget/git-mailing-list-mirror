Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C6E20CCCD
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071834; cv=none; b=XKb0xWwgZbKSlGSYQvMmgszDCrS8R3K8AsgX/KtcuM1Kv5nucnl7gX8wIeJ1+quzDijd9hUVNwX3GlmxMgZ7y58x0RHnC3TuuFfVRpPUPyRY1rylU+8QEWViS5XZ0dFpBQp9WVUHMt+waV5TM7IorDslRgi83Ojn0yJbLFe015o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071834; c=relaxed/simple;
	bh=kKgvJiD5iH1IYiP1JXsWCfXPuHkS/ptohqpHvpbx2tI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KWYS3nEKIMRKYQwNtiqarJiZtURSeFr0et2sLKgW3OwtOf6PXX7VR8Y+75KReS0GzXR+2lHEOmOz1yrBt58iZyIsRUrjdXq48tgOOAU2NnXdYHGSHO4gbYZ36U8kDylRXv7rHs4IzWr72FpnqbBZFx230g2HLyJKi6IGWEOrFfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Emx0Uk2E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MOimLlvF; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Emx0Uk2E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MOimLlvF"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D94BD1140141;
	Thu, 27 Mar 2025 06:37:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 27 Mar 2025 06:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071831;
	 x=1743158231; bh=REpbEfss2O2yYYKccRFcgbK1nvTKhdXojvppgXjTFuc=; b=
	Emx0Uk2ENDxE3T+QyTM/caQOzcAx16TkOjtDVCyYlttevHhvnWl0i3hldYXuY6LH
	2BqgNxM2ivKEkuHWxci5darbrgPNRK8ibUE8DBSzJY0LlsKnii8M5lVmnxaDqYdR
	oN3WEwZla5h44ijema+QcvNUsnCPscexdTn0NOu5EcE5AynOelpbji7pvqqaovt/
	sx+bVdTQAjGP1FEPd6R0FQ5qHtMW7Pzzr7vu6uI6gOTMn7nzfYr1GuQ0lOaUj0mC
	A3dONCqPMhoH6Xoh7SOHeZVx6d1+55UxeeiUoMlI3TSNkw+LCAjtCKQBUUIfqjrW
	QbC3R+KJSFoY/Oz3SS10Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071831; x=
	1743158231; bh=REpbEfss2O2yYYKccRFcgbK1nvTKhdXojvppgXjTFuc=; b=M
	OimLlvF02dcaz3OwtJTHTTc5CHc+oLl7O3U8kcDv8b37ZBA1H4/0d1cT70qx3rWM
	f8IpcX7HlzTJ/mTdzj5ugMKIu4gTyeR0uWRcvwbdqWQMVAZf7IubaTtqc4dOS+bJ
	3WS6DBx4qjR1fpFoQJ44SNmj9uZm1aR9rvcC4S5NT8BfRW/0PVtnEJ98+KZ5Wm9o
	eo0ZEo3ZA8iWuGdi0XE4aAlCcNfYNipnB/XjsiC3I8zv2NkU/yRTWIY2wsNSF7UJ
	s6DX6ed7h64IwSj75Vvipa+Cn/oOhhg2CsgCFNLdHwdapwkCrJBcdSYI2y8e1jBW
	8suYy9zqMXtq+zLts1Ipg==
X-ME-Sender: <xms:VyrlZ0ThyQo-kNwMAD7PDTG5r5WJ_ORE5FijfaXG4ducmWaYgVYsiw>
    <xme:VyrlZxwe_uJo53RbdI5PJ41Ej_ZeKbCbyL4dWQBcazUMtDQD4Wvx9Kq9GAXRoEMwj
    E8BehkZ_MzMF2FEug>
X-ME-Received: <xmr:VyrlZx1ScPYyCmszjAfsVv0zLnHtlknhY-fzxWTbROG9qk3dMarS3oVA30cB_cC6UvfmpfFLNWou7fTbzoNrYE5XvWasGGiFbwswHVV4gdom5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:VyrlZ4BwOPV_Ig3FAwAnzB5luJMtRrBja9L6XQ63InYxsMgsAiPs2w>
    <xmx:VyrlZ9iqXhCVH5HINOEClAoNT_h_soQhKdffa8MViGkRvCwwKHUqLQ>
    <xmx:VyrlZ0pq01X3qtJtE4ztpYvdJIH2m1_P7ghBk8E-pWEdRAMJcz9szA>
    <xmx:VyrlZwhPWBfVtbQSCHMB1sh1JRslT3aaqFwx2l6cU4DCi_VwJ7IkPA>
    <xmx:VyrlZ7b5zGDRkufYdYV3UVhvpU-KlrgAxzvFJqpBIqwDsqahaDDF5Jb1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ea383a96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:37:01 +0100
Subject: [PATCH v3 03/20] t: adapt character translation helpers to not use
 Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-pks-t-perlless-v3-3-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

We have a couple of helper functions that translate characters, e.g.
from LF to NUL or NUL to 'Q' and vice versa. These helpers use Perl
scripts, but they can be trivially adapted to instead use tr(1).

Note that one specialty here is the handling of NUL characters in tr(1),
which historically wasn't implemented correctly on all platforms. But
quoting tr(1p):

    It was considered that automatically stripping NUL characters from
    the input was not correct functionality.  However, the removal of -n
    in a later proposal does not remove the requirement that tr
    correctly process NUL characters in its input stream.

So when tr(1) is implemented following the POSIX standard then it is
expected to handle the transliteration of NUL just fine.

Refactor the helpers accordingly, which allows a bunch of tests to pass
when Perl is not available.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib-functions.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 79377bc0fc2..377f08a1428 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -88,15 +88,15 @@ test_decode_color () {
 }
 
 lf_to_nul () {
-	perl -pe 'y/\012/\000/'
+	tr '\012' '\000'
 }
 
 nul_to_q () {
-	perl -pe 'y/\000/Q/'
+	tr '\000' 'Q'
 }
 
 q_to_nul () {
-	perl -pe 'y/Q/\000/'
+	tr 'Q' '\000'
 }
 
 q_to_cr () {

-- 
2.49.0.472.ge94155a9ec.dirty

