Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4BF2D7804
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764955; cv=none; b=I8ePxlQij7c4IXiI/meeuIvkjWuiivCjwG7La+t5b1EiEm+Pdfr/eYOnAC6PrV73737ry5hcC/0sfDzJf7mZWy9ZDszVfZw8/O9I9K0RATbLSr9TTupJ+nayyznoBqtVbi9/JRrxEcBhbQEqlvVzjHrGZkV2hhNjAgtP9KHzxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764955; c=relaxed/simple;
	bh=XRFF387hbdATr0kMO2UZzEf2nRBHw2uWc7qQ0bUlnHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KgHVnhk/rAXPxPEmMI5huR+zpS0k7CaRNFsFIdkxdvKKepWvcAe0B2+fs+NQdBUAhS04GKMlcuZmtmEv+Hd2wzEzaTOpYf1w1a5PaQew2hQHl4nnlAjC3qV5z5soDhcHc9y/kX+BmImdpK7IH++R6Oo0Fgz/Akqhi2JYK/L5+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=slp6TEEv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wdjq8M2S; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="slp6TEEv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wdjq8M2S"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 72C367A0095;
	Thu,  9 Apr 2026 16:02:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 09 Apr 2026 16:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775764953; x=1775851353; bh=Lq1+BuqZc7
	NnmtcC8r/6/9yQznUQKI77Er6mujKlobM=; b=slp6TEEva8pmcv+adfdR/a4Zla
	rYJEVFXhMzOrtHGKtpL5oJEkYnJtYnQ+yXx4oiL8+BSi3UTNih2B5rqIqg8nTtZS
	7HSYJ8R9CA2UzuhvTijD5DNYM3YxlULo3u86XC2hluO+OJXcPXRjQ7ta96AKe2ox
	Bz3pq+VkUNd89xnZvIU8I3B46uOEDNMImPS0w7SQDU4enayV3siw4HZ6u2UkMNXX
	ZqLLPlGqh2fQBGnVvv8sVzK5OIQJFt6wWsDkA+CTla+LySYa91sGU3qEwQO4qgzK
	qXahWEFzNpmxQ5tWwye68Bu4GMU/De63o/uq0GLT3wIoRtrw3i0XoQpecvQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775764953; x=1775851353; bh=Lq1+BuqZc7NnmtcC8r/6/9yQznUQKI77Er6
	mujKlobM=; b=Wdjq8M2SS709/IiJYGjaNRL40cVRIcjE3Vehq1yE7sC+vr394FP
	BH9VpcLOs6gREfbgNd6WTs8e2IS6XxoDei9tK/qiVcgiUeaz6iBUfBY2Sz7cJqUs
	z+rf4EBjc4/kAaW4rtawzLXqe0K7i82/eaiYNaP2ul5q4sZ/RIDfZ14UHaX4BLPY
	2146LOknr5NRA2CjV19hALk1KvuNrXbmpWqtV7si9VR/t+mGWfjAtZ2yTzIp4xyf
	NgAiEVYnK93Y07wjdmeHP1HwV3a80eBofAEDCsfRGtDhzxqzewFNZ7x1v13zHyhG
	MxkdFb7XUExPrjphiGHtwAncvaNcp9KiaVA==
X-ME-Sender: <xms:2AXYacBCbdKes5_EnpzSHJLoS5TS5bfeuwqn_qBwI2hZDvYouVR6Ow>
    <xme:2AXYaSMt78IzP6I2rmT9qou4TDev6K89K95RMbPqzC1we_8n8NfOxVyP4rANMBtQq
    4Yw4ycaNB7KigW4pQJkOmzwvZHmQzBJSzzuOpWtpJD9bkJfH7Zrog>
X-ME-Received: <xmr:2AXYaZYEayH_eeGFH7T8Pbna44i4p9zXOf1asPSdt3zn-6_7VT_ibFHcz2BKOR5wff_nPGC_g4D-U319kqveAMp8Q2LB7Xzb_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopeihohgrnhhnrdhvrghlvghrihestggvrgdrfh
    hrpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2QXYaZsn5ZIHZJnMS4V-8wpoAXHU-V51gwA9ULijeHv03xoJkl7DpQ>
    <xmx:2QXYaTPugMBqxKFSTG7KbZkm-RekpTgijuQLQ-b-fPYGwyHK-YOA1w>
    <xmx:2QXYaY5cGy34hDtzalzZ0ilCGZLw3XFZmdvseDAYqP7GrBZVG9MgLw>
    <xmx:2QXYaRRzvk4gixE5U5gdQPSfUVJCZR0TCftmrRY5gToDSVsFxKEcJQ>
    <xmx:2QXYaUEhbEtTY1m08ugS7Klel2kjy7W1yxfQCkqL7LtvumwxXk6N_w4X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 16:02:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "VALERI Yoann via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Yoann Valeri
 <yoann.valeri@cea.fr>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/2] branch: add 'branch.namePrefix' config param
In-Reply-To: <80d1ffde9d3d55d0ff2b28219e2484fb12d543d9.1775731390.git.gitgitgadget@gmail.com>
	(VALERI Yoann via GitGitGadget's message of "Thu, 09 Apr 2026 10:43:10
	+0000")
References: <pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
	<pull.2202.v4.git.git.1775731390.gitgitgadget@gmail.com>
	<80d1ffde9d3d55d0ff2b28219e2484fb12d543d9.1775731390.git.gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 13:02:31 -0700
Message-ID: <xmqqqzonsy08.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"VALERI Yoann via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_success 'create branch with config prefix' '
> +	test_config branch.autosetupmerge false &&
> +	test_config branch.namePrefix blob &&
> +	git branch -- -with-prefix &&
> +	test_ref_exists refs/heads/blob-with-prefix &&

Another thing I noticed.

Wouldn't you rather want to have a mechanism where the user does not
have to prefix the end-user supplied value ("with-prefix" in this
case) without leading dash?  From the look of what you are trying to
configure with the variable, the desire seems to be to allow the
user to make many branches that share the same prefix, so
conceptually, among blob-master, blob-maint, blob-feature branches
that would result in "git branch $name" where name is taken from the
vocabulary (master, maint, feature), the responsibility to supply
the word-separating hyphen belongs to either the prefix side (i.e.,
"blob-") or the mechanism that does prefising (i.e., the prefix
configuration @{current} comes up with a prefix string "blob", and
with the end-user supplied value of "with-prefix", the mechanism
that pastes these two strings makes the result "blob-with-prefix",
supplying the hyphen between "blob" and "with-prefix".

I said that I am negative in my previous message, simply because I
didn't get the intended use case at all, but even if there were a
good use case explained in future messages to make me change my
mind, I doubt that a design that requires the hyphen in front of
"with-prefix" the end-user is supposed to supply is a good thing to
have.

Thanks.
