Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3EA25B67B
	for <git@vger.kernel.org>; Mon, 12 May 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041610; cv=none; b=NgD1uhl7MfeAt81lOUNWrbncYrjBCRv87ivk9YevLwO1i9cmQl3v4efbqDNgrxgcZhTIMshDC+/i01vIq86oRFgqzzUGQ974Qn4S7j6EpyKYq4+PwFRa3+1IenW2FGUHcIaPH0lQbUkucPm4a2q6DMpzdiwNN7cCyzYAnwDcW7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041610; c=relaxed/simple;
	bh=GKlMjsg9FeZ7y1elMnRfMVA4gyVNwfKFeTHHSABFeSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S1R6ccdbV/m0QFeLuWXq0k9N49TqM4ug9H+5Knbxe6H0/LbOze+xp2feRR/T9fxUTLuNH+Qwgcc4Q4fnw8q6z4cp0g0Oe5MZeVdn7DWT4mgvz+SPThm9at00QUeoBg/hnfFw2gMK8AP9W47Llekfpv3vX4qRW5VeT+iqovEuMuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=prIwv61Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g9HVa825; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="prIwv61Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9HVa825"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8369E2540114;
	Mon, 12 May 2025 05:20:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 12 May 2025 05:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747041607;
	 x=1747128007; bh=zmP4AU887160BKLXCFCgprqZkEMSprnKpyJNmwYSvrI=; b=
	prIwv61QnXKVTctRS+AdYcDq12NTP0zzEKoBkLuLKVCuufaussul5i/OBY2rW2Uh
	YyVqigyLzlSL7fxDvD0fBOQ4bzPX7ibuKNWH0rmwv1AqvDzKfKZYFXjc9VM6E+d4
	M8OxP+8YDkDtUkOTF6BH9EvlQfZNASJ4fSGPPaLsAWgkOHAWyiszoRnDmtwrk4J0
	a6Jxjcw3+wADdRrcWbWq9id67B0XPjgpIrjKNBA6RzZlhYii30/H0ZHAqlDmeIy8
	p4HlBe6/6qYyOQy3rtH0qU74fSvaEvxm8qUt5Y9KOBVUx6IHgQtWo7vhV75ehReB
	Y4tuFd7t61Zdrb6Ri4ZIsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747041607; x=
	1747128007; bh=zmP4AU887160BKLXCFCgprqZkEMSprnKpyJNmwYSvrI=; b=g
	9HVa825OKsq859q+fSefyerpB3P0Ui8O7UYp9AjDWutmNBHl897eM6zogevfD/2s
	QnI+0lGKJ4og6wR6Fpz8ZcUwFBIk6sZygIEYIsoWUX2oZlRfn69eOhsJ87a7v9nA
	CBCGbhsiowYqim5FjadxAubi0ZEVb1zb65FN4eFYfhclP+nc9QI3hFil8ZbJo6IF
	JlwcEx/7AUBQNWIxo3KnhrdJIIwnY49VJ1x71CYIJQlG2AbH/JuYUlrhUOSLq7Su
	iRftF9e7BL7ZowGTLfVQSRNK/41mePo5AQmmN/4Q3ghi/ij8rq7Ef1jBMXAZWF7j
	ahNfWY8DqbKS9gHzwfL8w==
X-ME-Sender: <xms:R70haEXLHxJkyzMRkUJojedvm_LjNP2UIS-bkXlvaVfcLLbG492Jtw>
    <xme:R70haImmu8l0m9RH6mUpCFtvzc9JaFQqi18BZ5VVgUTv6-iz1ZgP__bnAPp3z4N_e
    -veOVnU9mWAB6snVw>
X-ME-Received: <xmr:R70haIZWMcigzN51qSwPGEztX0LD5g4uQuT164dHFfUYugC7AyjkB3QJc0pkWupNCcTfaPvPYfX19MZesVYG3Me68JNfvNfv6hxc1wmgug0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtsehmrghtthhhihgvuhdqmhhohidrfhhrpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:R70haDWnKc3yrchKgAPGgwF2ifIF3xAJkASG5DO9xYxp2dVWbdsvRQ>
    <xmx:R70haOmTFR4467-h5ujNCIg9BRuiE73OUzxLHHN7GnoKSHybQEbbOA>
    <xmx:R70haIfsxRu6hPEOEEqNeKOP9sd-WMlVaVOLmAgE3XqEKC58r0fwTQ>
    <xmx:R70haAGR2DbUZYKj-UWUQ_H9S4OChyc1bKfoTi6kitBgz_BDCH_fSw>
    <xmx:R70haNn2htdnwt3dHT9AMhdMP00L0jvSMvQVgHQzNn_wQioc2B5lFqtu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 05:20:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 09091c9f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 09:20:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 May 2025 11:19:52 +0200
Subject: [PATCH v3 02/11] contrib: remove "examples" directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-pks-contrib-spring-cleanup-v3-2-32e151b0bfb0@pks.im>
References: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
In-Reply-To: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
 Todd Zullinger <tmz@pobox.com>, Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.2

The "examples" directory used to contain scripted versions of some of
our builtins. These have all been removed in 49eb8d39c78 (Remove
contrib/examples/*, 2018-03-25), but we left a note in the directory to
make it discoverable that there used to be examples.

It is unlikely that anybody still looks at these examples more than 7
years after they have been removed. Remove the note and its directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/examples/README | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/contrib/examples/README b/contrib/examples/README
deleted file mode 100644
index 18bc60b021b..00000000000
--- a/contrib/examples/README
+++ /dev/null
@@ -1,20 +0,0 @@
-This directory used to contain scripted implementations of builtins
-that have since been rewritten in C.
-
-They have now been removed, but can be retrieved from an older commit
-that removed them from this directory.
-
-They're interesting for their reference value to any aspiring plumbing
-users who want to learn how pieces can be fit together, but in many
-cases have drifted enough from the actual implementations Git uses to
-be instructive.
-
-Other things that can be useful:
-
- * Some commands such as git-gc wrap other commands, and what they're
-   doing behind the scenes can be seen by running them under
-   GIT_TRACE=1
-
- * Doing `git log` on paths matching '*--helper.c' will show
-   incremental effort in the direction of moving existing shell
-   scripts to C.

-- 
2.49.0.1101.gccaa498523.dirty

