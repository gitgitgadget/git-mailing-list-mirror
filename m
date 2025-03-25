Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5A92586CE
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908470; cv=none; b=ScIxg8WJx3B+OmW2rpG0cPwI+8OCVG0k7vdmZu+B16sPHZs+wAWzlqov1xasFXX38HSsUbbBDiHBhIdU3C2A03oeR9W09UBPQZfr8Kyfb3j3JSp6UGaeefRgCjiQBprWfZekTwaR3lGXttW75aGbud5gBQw5xXvdEvLNjhDjBps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908470; c=relaxed/simple;
	bh=kKgvJiD5iH1IYiP1JXsWCfXPuHkS/ptohqpHvpbx2tI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ag4pdKd6602wTI6tFlnrG9RCG+wJ321BNIDuDpRJVI5b17RcxJLC3xIxet01U/GlFjnmY5dFjgGTo0Aj90sykDxptwNPHQJBqMuTj6CEHdGXbhC4m/pc7gZgi3AdiSwi0xuApvpGvSK4TZ61hNqYB3iWZZTpRCc+kOaq762mKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GKqjELyQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Doik7E+v; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GKqjELyQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Doik7E+v"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C40F113838C3;
	Tue, 25 Mar 2025 09:14:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 25 Mar 2025 09:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908466;
	 x=1742994866; bh=REpbEfss2O2yYYKccRFcgbK1nvTKhdXojvppgXjTFuc=; b=
	GKqjELyQmpVlJgMEe4ClS8vChOibLyyG/EakMrIetb44Cvb/dZfb7ssbluz86obb
	LsgdbLYaTT9YDsgn9qhjJxn7MzrGJmGpq+AdTecyBxpESV1a63pTqwecK4uOHzBs
	ViRW6MArOFudGJjJOKKj4oIz0GN5my2uvkf/hEVs5ihUrn4M9h89bfZ6Qab61PlF
	aF6kMTdXys/UM1M//9Qp9wDtYUxZYiYJbKSu1OzYrWKqRXFRU0DyY6HIdmLgxtTE
	Vna2NFEqN6KQCtvciW8rjKuzmuirS8G5lSLvwC48d7zcZf0JVp5E5uyuyCJ82ngC
	jMNu7fbRFQ0F0gGXN+srdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908466; x=
	1742994866; bh=REpbEfss2O2yYYKccRFcgbK1nvTKhdXojvppgXjTFuc=; b=D
	oik7E+vDidLUFJbiBCdrN0Uhy97S4kLhBBdZyq9TWRK+BXiVJ9RWSQYGjWlMtdhh
	/4j5dUmy51fLGQly/2P6hsWDPP4EbkCwvrl0zrRHYvTMn6/S8y8TvfFpeuuAM+xs
	Em1W2dIta/RMS20XrsqXVJrVDNUnmaOpJf1xY3fqs+UlEpUPycQdDQgUqHM97sjO
	CJQEkOBNKoWQvwbRYLE5EmIPAz59agsNn24xgZUEJdbh9t6lrLzLPiYx+kkZqocQ
	Xl4XiNiw6DZbOSNHupm3L/7olBKctuoQ3S79z8pJP02UxmcS3rIpCMf//vP3ZKdU
	Kz5hKym7q0INeR0DG6xvQ==
X-ME-Sender: <xms:MqziZ5JQGutycn39wD8v0oNGgKBPconEQOQSoGRhXMVhL1MUJSUa7A>
    <xme:MqziZ1KWJenAeCFUQivdQ7hjcI0cwSwXWbuqYOBU37Mmqy3ZKTcUaNLik0DhhRjxq
    ecwXynSKdZw6P2XXw>
X-ME-Received: <xmr:MqziZxsFB7HrlEM560CN0AHGaFH0uAhdkkjCZUoGwH_ArIVNx0gQvDncwMi86jbWdqhIz8seAS3S29LSqkVOef62m9i3YKhnPRYDue3mQ3gOiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehjohhh
    rghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:MqziZ6baWhLe9Yobouh0xJidnxkx6zrf2kD6RF9e29yp0W7XF_FaEQ>
    <xmx:MqziZwYBbDJdSPyzZ_NnzPX9eVxtbIujtjb918ipa3A2hh1M5FdSUg>
    <xmx:MqziZ-BvVifvczwJ1QGn9HiGlUWTbE-CY9l8-iOXteVKTNEdvbMsXw>
    <xmx:MqziZ-Zzbj1jrWU06VKNpCCX6gJund8Bddwm8NtnjMajLeAO1q966Q>
    <xmx:MqziZ_wq8nIKWBf1JIRyDsm_wl93J6LhykyrM_nCEmtKp-eCyRKpXdB0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7d6ff17d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Mar 2025 14:14:21 +0100
Subject: [PATCH v2 03/20] t: adapt character translation helpers to not use
 Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-pks-t-perlless-v2-3-4b87b8072670@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
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

