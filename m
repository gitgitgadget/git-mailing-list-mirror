Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC921C549A
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736001323; cv=none; b=KgWFIkBuChfbdKjnuW5gIpHlRZVy6PrlM0sbH0Iqilj9hLdapjpVSMNeLLMF2u1Y3fYph4JcxecOOxv+im4gnMCMROYqbNXxhPcHX9c2VmtCoocjJQ8INjtyEFQp0c0U+MeZ5p396F0juU+eV9dq4ZQrQTphIv55SBJPR5j6Gd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736001323; c=relaxed/simple;
	bh=LOf6ApXLoLIfBa0HZnSN2sD5wDPqEY3S+gxs/gV4l2c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=abG/ospUnVWdivQ3xxI2fOIrnoEh4LyAxt7aAZw9MKgLlJBqtmRQmC2ex5exGv6O7syGN0rdoIj5bCSiZUYVVwWrUBSps5atqYkulm634XEq8gwFaWPJFddRWPRsGKjK6C8vrv39kVM6gAbWQ1WpQJB17cTfsOt0xPVqWW25EGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bD1ftQXd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rBz3vtzW; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bD1ftQXd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rBz3vtzW"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F19F114018C;
	Sat,  4 Jan 2025 09:35:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sat, 04 Jan 2025 09:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736001319; x=1736087719; bh=8Zgqw7kvDB
	mBozUDk4vA38aGhj68gTP1aAQv80TATOA=; b=bD1ftQXdvSSMVSBwxcMRNASTyh
	0hHS0zWGxxahggULex8St7mRJZO1hYUgehjuwZrNhSuMZGbA7SGxW9aCdvdtnG/U
	pxC4vjFD4FKvipbrUtRUUmWlD3wae4kau+0oXqQoi1rWUL1P4lqVJj5VLnr99SvY
	BbvJUqe27wY3ay6q1ERTaqG8Tw+xKSZC9CAFimW/dOFji0gofWmFrDzv+VKN+iYg
	lip7sW7VY+xgt4hwyGUKu15KgU5lCqlX8IeeL6GYznQn0M4xqUQNqLe4sSieE5sm
	Ho50gcntVNAXY9ziNDlw7TrBBq/UTWjFAq79q3dNcvG7Q7k1ymeRTG4YVIAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736001319; x=1736087719; bh=8Zgqw7kvDBmBozUDk4vA38aGhj68gTP1aAQ
	v80TATOA=; b=rBz3vtzWO0PI3gq8y+YcZc1L7YH7lSiVKjawGbTUWfY2vwXZsSh
	XdRtY2IMJcXwXIeD+KgDxtHc/GqIMMKi9L8l8nZkIF7J1QWh/ssZ4eQF5py+sAQZ
	8Mq9uHBRcHxpeBo72TkhpGqaullwbU9qhBI6doAJyF/yISnBhzd+dKlgBaJTcw8K
	nZ+qN+aEpq+s50nwKeCdUJsJvYwBzutHY+7vbT4S20whfGAubwmqHeMeiQ0IGcd9
	EAhV6sN7pYHK/RwwtUT8eaU9NX1hyPrmhe1+3dnro7tnEngAdy92Op5mPzfEcwSu
	+KRSNe7xqvilP6PFabOYCleKydbWZYmHVwg==
X-ME-Sender: <xms:J0d5Zx1ziVH3eQ46jwbx0JxQz9yztb5bNIt2s5mvWhIU4QM3zEUtRQ>
    <xme:J0d5Z4EtpMH8JRtYJy6BMOXBhIt7YqUfqEB7BDQ-m1mOaQgMPo6gZyEKQT6sy0an-
    wxSJhnkLRn-8EtzMA>
X-ME-Received: <xmr:J0d5Zx6eFbyTidUUef4jzjmxYT_q3RkZ27kDj51RUqs920opMA4tVKcUsfWfhFiSZS4D_L8S0xsNONxnZFZkV0OigCWqzVVlBd0I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefiedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:J0d5Z-2yzo0iQlOMeYBATJy98YMJ6hBStxf-Opw9w0ZWMkKMh27A5g>
    <xmx:J0d5Z0Hhgsotc1rY2FTWNiWxcA3yStcozYptpPzMq1P39mX_DC0J4w>
    <xmx:J0d5Z__q7FZVafEcmw4tgW-YGpHLRqQfFmRGm8M0x1xa3_WftkayAQ>
    <xmx:J0d5Zxm6shXy5oW-geShtqtwjVpxpztIXBU-7EIHe2hDoBcHg2Jebg>
    <xmx:J0d5Z5NAYAtW1SSXr4_n08k9ip4JC5cjM-M-O7myN5_8Z1wCDcW5EESA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Jan 2025 09:35:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 0/2] object-name: fix resolution of object names
 containing curly braces
In-Reply-To: <pull.1844.v2.git.1735949870.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Sat, 04 Jan 2025 00:17:48
	+0000")
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
	<pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>
Date: Sat, 04 Jan 2025 06:35:17 -0800
Message-ID: <xmqqed1i4pga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * Added a second patch for another bug discovered by the same reporter,
>    where branch:path/to/file/named/major-gaffed is interpreted as a request
>    for a commit (namely affed) rather than a blob. (At least, assuming
>    commit affed exists)
>
> The second patch has some backward compatibility concerns. People used to be
> able to do e.g. git show ${garbage}-g${hash}. I tightened it to
> ${valid_refname}-${number}-g${hash}, but do we want to allow e.g.
> ${valid_refname}-g${hash} (allowing the count to be omitted) or maybe even
> allow a subset of invalid refnames?

My take on it is that it is an absolute no-no if we require that
${valid_refname} exists locally, and it is still iffy if we checked
${valid_refname} with check_format() (because the definition of
validity can change over time, and we would not know the rules that
were valid back when the reference to the commit was written).

Otherwise a tightened rule would make "${garbage}-g${hash}" less
useful to copy-and-paste from a text file to command line.

In general what would we do if a string can be interpreted in
multiple ways in _different_ parts of the object-name codepaths.  We
all know that "affed" would trigger the "ambiguous object name"
error if there are more than one object whose object name begins
with "affed", but if "${garbage}-gaffed" can be interpreted as the
name of an object whose object name begins with "affed" and also can
be interpreted as the name of another object that sits at a path
that ends with "-gaffed" in some tree object, regardless of how the
leading part "${garbage}" looks like, it would be desirable if we
declared such a string as "ambiguous" the same way.
