Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7830825A2DE
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766441129; cv=none; b=UJacxY3UBpV8BbJEbwr7GxvCvxxRxGcBNrnhLueL/ZlL8VSZZBEbLy4NeF9q77wmN5GOw3tj31cXlcE5xOkd9ReqIyvkMc2XJkQT//c9OZDMiXgdixoU/Mo0dVlL4fCNbrG2xb5iGEf0mJ/QIXHmKb/aVM76u3//Uem3dYGXV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766441129; c=relaxed/simple;
	bh=9bCDAQs4r4OCa6UpFpZ3ahUjEvw1+XgpxkRQ5unl4Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcbOWPm4dLOyBCWEXjFrb1sLdn1uPUJBoLP9z1ETyYpehsVOyW+x2UAfWI7RsCqynG7flCDRD0cuf9FdWAUL1qFZ0NoHWbNECwdMdDuBmH/AXnIA+gwEurv+jv/YDeE0xQaZWdD6d5XeWNCOvZtXcmidq7jeeP6q3Iu9qmm+z8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Cefw5/f3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sgxBHAxj; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Cefw5/f3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sgxBHAxj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE6677A0073;
	Mon, 22 Dec 2025 17:05:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 22 Dec 2025 17:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766441126;
	 x=1766527526; bh=ZmEz4u3TKDb50j23to+KxQHi4UMflvQ7UTVcozmKD6o=; b=
	Cefw5/f3am7ZoizyjxYy47B9KdOYfgKHxhSJQLJlFjWh9Viq7SN23x+NIwrlhMPo
	JPmbSNx5qxjVLOfyBWmp24klOyBsQlluikPVFwYyJwB+oYaXFPKmBH9aWtswhvLx
	jZWafNH5w+uegiPdEhVT6dNJj6LBUNLp8hJl8pn/QmQPYh6lPvAe51p87LtuG2jV
	LLCKWp17G7ojNDLM0N1652Ny1Yp/UTWQLbRQ8RNbEHqoW5ZWUYMPxO7hiJnZcHhs
	oBUrfsiUvGmY+lWZMAoDRQ7ZfrNDbctA/bDR79OqMqMhnhfRYPyvtIk5Q4cCcKTS
	fHzyhBGckuIXFKuYTZJCIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766441126; x=
	1766527526; bh=ZmEz4u3TKDb50j23to+KxQHi4UMflvQ7UTVcozmKD6o=; b=s
	gxBHAxjc7r+oB2wcd4prDMVgWP9v/XQpzjyIFrzJRg68EbLr5JIAGzvdLCvCNplc
	XbJUyWbvWLy+4jvt0sQNEg8SZk3QqDJsPnGfvs8MFY6YpawVRScQzqU2XUvp9jss
	rx7MVp86TiMCXpFTrLXBs7wehHWy93HRnLc1Ab6IR3uo4NyDIWN5mGOdvZaRrM6E
	e4UcBSdl29neIWOY0SYwuD0RthGvG2WhN2ZMx89jfjoLXin225spPaT1thgNl2W3
	X67EGqcEzitDEDebgev+t0C2WjHOHB1qANou2h+kMQycdD+XbGMrwO3C8QAxZZW1
	1zpzT3qb5Jc1F5hROUdkg==
X-ME-Sender: <xms:psBJaU5PKHJIzTbBPq389anBRx2x1jtrLMmzjprS2gLjWEcv8GXfbG0>
    <xme:psBJacy-fq3Dul1wK8HbJrjWiRKvIXVAFcr7H69f_z84N6U5EpXLiUkgqcy_BDFWP
    EVws6evX-QHhBm6wVhoeJcKNB7sxE8fzUjeH95Ddyv1oEP9E9QPXw>
X-ME-Received: <xmr:psBJabwXhS0PG28l1stz_RBG-djGd9JcpZA2eSW-gIipyNNu7NKv0nPM1zuT9n8b-Nd3LXXENF5zJ1o8Q0cB5Yd1jFAMIAuTkUbBr6aqAy_Wys53eNnqX90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehkedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedt
    udduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:psBJaUwt72NZHRkYTnAWrYb-a8tpSGe5Wv9IPO5Odm3z-Jlcc--Avw>
    <xmx:psBJaVZOrk4CSl5VtFAuKKB6xtCkVbPGUCi9lizZzOLpH-eJjcTRSA>
    <xmx:psBJaVX43OnJqf2ICf3BZoa68DSLmXQOwn8Yhd0COsu--dCHh0ZiZw>
    <xmx:psBJaThixxRL_wLQIeI3gX_sE1irLycvlNwfma3u9iyjYxQkQh2hTA>
    <xmx:psBJaYCmAhy_qL0PigfxuILFLiOX7UNVejJV5c9pwX0lDQJBifzWkx27>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Dec 2025 17:05:25 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 2/2] t3650: add more regression tests for failure conditions
Date: Mon, 22 Dec 2025 23:04:43 +0100
Message-ID: <replay_regression_tests.141@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
In-Reply-To: <CV_replay_die_descr.13f@msgid.xyz>
References: <CV_replay_die_descr.13f@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

There isn’t much test coverage for basic failure conditions. Let’s add
a few more since these are simple to write and remove if they become
obsolete.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 t/t3650-replay-basics.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index bfe8e01da49..c543d55857b 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -67,6 +67,33 @@ test_expect_success '--advance with invalid commit-ish' '
 	test_cmp expect actual
 '
 
+test_expect_success 'option --onto or --advance is mandatory' '
+	cat >expect <<-\EOF &&
+	error: option --onto or --advance is mandatory
+	EOF
+	# First line is the error; rest is Usage
+	test_must_fail git replay topic1..topic2 >&1 2>&1 |
+		head -1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'no base or negative ref gives no-replaying down to root error' '
+	cat >expect <<-\EOF &&
+	fatal: replaying down to root commit is not supported yet!
+	EOF
+	test_must_fail git replay --onto=topic1 topic2 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'options --advance and --contained cannot be used together' '
+	cat >expect <<-EOF &&
+	fatal: options ${SQ}--advance${SQ} and ${SQ}--contained${SQ} cannot be used together
+	EOF
+	test_must_fail git replay --advance=main --contained \
+		topic1..topic2 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'using replay to rebase two branches, one on top of other' '
 	git replay --onto main topic1..topic2 >result &&
 
-- 
2.52.0.10.g08704017180

