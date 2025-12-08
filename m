Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B771DD9AD
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765178958; cv=none; b=uycPzrJ6dwnlmUT+HzyfftxSi7gO58drQZ4TOt0hNSYNUcG7kSUG/9UqkIrxCikAVaap7vALASwkYH2860njHnZCmJbgaHOBnI0PJLddaDMHPNRyWsVYaqWuKelJn4kLg8ni+El652m8O2IIixtWUk/W9uz2m6SZYaROpzepPmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765178958; c=relaxed/simple;
	bh=t+7P5R9TnNVwJ7DKJTO3M/heR/I0hPctJ6AtIOHiilU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Fv4jOAc73yIc36YcF+7FlWpJ52xQHbNikGRsARoPkrK0MqRMjBxOE5P58Ra14pgYRC0MOd50VzH7RgsQCWoI9AGsivO9gvBXEVfq6wp2vLaNbqtEOZG5LVYdGl/Ax6xQLJzUwBMAOUluVhN5kzQDJalhRAQ7OqWXcDoUXpRKI9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QlHxqmdi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RN0ze7NV; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QlHxqmdi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RN0ze7NV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 42CC414000D7;
	Mon,  8 Dec 2025 02:29:13 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 08 Dec 2025 02:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765178953;
	 x=1765265353; bh=t+7P5R9TnNVwJ7DKJTO3M/heR/I0hPctJ6AtIOHiilU=; b=
	QlHxqmdiMqG0wNKpV2f8MqQz05FY4HHtnSCfT8fLgPd2II+v5qje0drfpuUyw8Ul
	YxAu1hFpQELV3/o8IZ6XquUjBLLEwZDqXwC+bekMD5ViyeycD8MQn1s5t61sjWsu
	lT7VwdwHYBkqkKflXtAvk0fn1gyFY1DYHOwdgb7dQFSdn0bkSoo43pBCukRE++X4
	82AafYbafZ9lFRq+rvvPCMjYEfqCo/nb78pQYYwUyevMMtAbOwBEZeaGbWgsNcH1
	RoiHJK7BXXaqLIJUbIj3ZqqcfHdL+kwCQjZEVQ6QVhyGaFNmAJKYmxUNbUHzqHl7
	DNZfZucyz10vlTN5vB6rtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765178953; x=
	1765265353; bh=t+7P5R9TnNVwJ7DKJTO3M/heR/I0hPctJ6AtIOHiilU=; b=R
	N0ze7NVqf29d5odSJVjTcOMILclDxmT/TUl+Hd6SuJnQ41G7HY3+uacb1wwyrdM3
	o9p84mt7apzx+ys7Qn8DFAUOasZHMbtQwO5B8RHz+ykhIFaLxuTc5ax+7PCfI9Un
	JcSWQIb0dJo2sWyG0RSWPz0zl9aJrpxB/A2X2rJlVC146FygyUb8fmFBQekzuhsH
	en1L/Zyx1n096PQR8qtG8sj3uKoHQ+MjZX/lv2OOXHrvhNbNrzQ3Bmw6B3Q6cf8U
	g3iqZCaKJqgrKrfNZCDaMi2XJb1yJXzVH9ly2+Z+qlEqwboaiwHhRe2DpWy9Slw9
	3T7Mil5e+B7qonNc3MAHg==
X-ME-Sender: <xms:SX42adNYpKORSdN_t-Y6Cuc1iGkWXXD28AdFiT4qSe9EwsmIhioBTes>
    <xme:SX42aaw32gwyoZMtI6h2GFc6zXO9ldbvvb4Ii18FBfx0qjKCvfaixW2dA01rAFFLY
    Yc2VZY2F2zUDDP2VYQ8r-Ttd1D6Zw3eaC4Uawc9RWelzWMMrmxAKnk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SX42aW468JaTWvcien6t92a5VARxCXJ5s3NrIbtX8G1yMmnDuo2VCA>
    <xmx:SX42aZMkHT4WSWo3rnHctAAD_tU5jWJj-_q4nFF2YmlbXz4HtOfy4g>
    <xmx:SX42actzPjlR-aWaaD_lnfISXOq1JnQ9RgXGEhgkO-6syjIT5gRO_Q>
    <xmx:SX42aUbO89OI_JNnx0bGbdT43LhWNLlnGmbJYTtH4vnCCNV6FJ1tkA>
    <xmx:SX42aaAu0tiSu6loVcAgP6K89ymqv7rjlTzjs2Uva9XTsBxJkQdVDfmQ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 08C6E1EA0066; Mon,  8 Dec 2025 02:29:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_-Iu8LU1e_w
Date: Mon, 08 Dec 2025 08:28:52 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Christian Couder" <christian.couder@gmail.com>,
 "Elijah Newren" <newren@gmail.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>
Message-Id: <d2a72ba5-ac7c-490f-9f2c-6cf849e65180@app.fastmail.com>
In-Reply-To: <xmqq1pl6lzt6.fsf@gitster.g>
References: <CV_replay_conflict.101@msgid.xyz> <xmqq1pl6lzt6.fsf@gitster.g>
Subject: Re: [PATCH 0/3] doc: replay: improvements like "mention no output on
 conflicts"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Dec 7, 2025, at 22:58, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>>[snip]
>> base-commit: bdc5341ff65278a3cc80b2e8a02a2f02aa1fac06
>
> All looked sensible.
>
> The second one looked a bit sketchy, but that was the phrase used by
> the log message for c4611130 (replay: add --contained to rebase
> contained branches, 2023-11-24).

How should `--contained` be documented?
