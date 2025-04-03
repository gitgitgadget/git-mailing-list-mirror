Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AFA19CD1B
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656765; cv=none; b=by3nFKSUa8EImQThAaJtjHWBf5lQHBp13bup5ovUQ4n4yZBxFMx/gUFsUab1ZvVkey97VxrLQGB9OnHGOdSpEuwWx/AmEA8D3dFMHm+l9RHRIgMBcZl7MaMLQfepU6S2glNANK+Q4zFRkmK549gO6Y/GS6JorpRNVxur43ImHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656765; c=relaxed/simple;
	bh=bX+EIVV2dyXbwCpz4J1QpZYmz8TXaIz5PburBbaH9a4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WqwKDSjuKtOpqlFHCB38a6Hq1+zacM6Pe1ZYgWWISz5IAMJM+aBdoGGum9vmGjHxDp0r5+BnqFUiEloiukJS5rxAWtNsImO3OBaNmuHppNczChFtmENbmlhkKxA3o1B01AxUf2t89WKGuXHTend981bTXF3io+P38iIvK/r4a7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gbjQUNYO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=drDubwC4; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gbjQUNYO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="drDubwC4"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3871725401FF;
	Thu,  3 Apr 2025 01:06:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 03 Apr 2025 01:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743656762;
	 x=1743743162; bh=RhhCgopLSpzY7fvCHEguovLXTGNiA7CbbcoRgnjEuxs=; b=
	gbjQUNYOIKLUdNs4X41NtPw3TAq/SdDAP3adgSeK1wB7xqxUjsF+YOcNgB3qtICt
	PEpEAAYXdsFnPFaYAlyhnwfzQeC8hMRN4lRx2CWlyFzuA975M8RmDRKO7W9zZs7O
	JEyYVCKCkZu82yMYtu5RAnPU3XBkSbQ03w5rZIRFO/baJy31M2JusFzz/5CvY29l
	1qs816szE9SL6gJwGxQDiBCN9cOJCuzG9GxC96PMyQJBBg/pAu/4yhZcENxHinUz
	2+++YmpnGwG2rMNza1LAa0BpCkSQi0ugd772dLv5Cu0luNMpPjT00pvdtaqh2hOq
	a0sUjr4sGCdd+vfGmOkZVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743656762; x=
	1743743162; bh=RhhCgopLSpzY7fvCHEguovLXTGNiA7CbbcoRgnjEuxs=; b=d
	rDubwC42B2jGApEFKIIt8rsRazEvmRv0JD8Ro0rqhmGDK1pM25IhuwWTZDnseA8N
	Au0Loz/S7phyoFgNFxoDpgZeYuw1f+vwlVJZIVRXAmuVDCbJpepCcsLZ/HoBT/oH
	fj6LE13ZInaGw5Wbh1ki8rdhpdQ5wQ132s6muMThx+9rwgU1ElwkQ6DCjgOpE1di
	fM37/pLInYQkgtJtFpFg+Vn6X3bDuafBLUANfJjg6bHjnsn8TUef9KNZvb3kOLhe
	4fC0IM+OwlQL5Eas9UBX1lEndzB3j+5U0lp3seu+y4wpR7vaAPX/5t/XOZrtjSSq
	T2YFvk2h7v14Vrii8or+A==
X-ME-Sender: <xms:ORfuZ2Ea4nzqyn-SDtzuX5X-pOpFLEdM-MKXXp-zUcOiNySmoY4vrw>
    <xme:ORfuZ3V9Wgfy6EPvfntivurqfnhFxflNFj-6XCZh1PXiS-qxLFRwwpMJfcmdynxkF
    ioFK5zn41L8o7GrLA>
X-ME-Received: <xmr:ORfuZwLheoOFLbcKyP6q-7puEtOp2A0CpOp3o0wLAnrEGZgS11UfXQF-A6Lu4sEe9xvRioDT9pCDWHwpH3sJpY1rpZG1Ujv2KHkTWi8NZZI20rI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:ORfuZwEGNdCiriJOSrQ_EpU1gZAz3ZZZArQOlD91GpA-OLyO0mtwTw>
    <xmx:ORfuZ8U4KO2AO4cH3N0RRaYAgzTFneOO-IRH6SzKIFaOj6MSJ2RhFw>
    <xmx:ORfuZzPGo8mWHFMy4pMFx3hOKlgwwZ3ekinwLKLjB-A_KLM6qHYA_w>
    <xmx:ORfuZz3HbmIpZWFWqQRqBz36C9utSND0tXPdJDfivyAfeAIwu-7Q3Q>
    <xmx:OhfuZzq63ISRjBMvMGSpER7g9ZSlI5V7sOGx9mPJFKbUagz6ZbJhBTpk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:06:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 469c50cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:05:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Apr 2025 07:05:54 +0200
Subject: [PATCH v4 03/20] t: adapt character translation helpers to not use
 Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-pks-t-perlless-v4-3-be20ac3db39a@pks.im>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
In-Reply-To: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
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
2.49.0.604.gff1f9ca942.dirty

