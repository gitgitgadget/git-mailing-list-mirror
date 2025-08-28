Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F0923C507
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756424663; cv=none; b=WVubIFlBhh3zzI8HqrJGkzpuAm3jD9f+v6KFaGo1rrtzY1zmqP46MIP7OUUH85RBRNWepotmWR3ugsQnhplQvON6YOysQ1cBoQ1NE3khgpWuUM3Tje3o5N88oajymNtNaweOlZOpPwQxmQC/WZK/e+UNjcaVofz5yUmBqjqYKUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756424663; c=relaxed/simple;
	bh=+eHE71D0hZjFPdaFsAyP0lFyNn+ut1eNVl5/0waiY9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P80DI4otjJc3p2CkQTQGOXD9u30qITWdnwRvDVFXZB3CWwl43OG+riVhoS/6qdv6lAhqG7q+W7Tc2IESDKL8PkIfAGBIxaHpc+XM8edCrGpat/l9F+mMDSkHbCvZ4kdNhaq1SDJz8thqN4HJs+/DsQbuaY+o3M+XBhUaeaYD/+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0aFg0HBz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WfCrB814; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0aFg0HBz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WfCrB814"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 295CA7A01B0;
	Thu, 28 Aug 2025 19:44:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 28 Aug 2025 19:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756424657; x=1756511057; bh=jtgBh4POh8
	nsusIEKhuKrU+ypX89QHySy6vdanUIBb0=; b=0aFg0HBzJrdDFGPukSc9cIu9DY
	sKDJCUswRv/M5Y/h49ipuq8kFTbf3HeWztNOecRN+CT0eBYzoy5DIjMJzTfZud5g
	4/u+rGztknYnpt3Kxrmn7guDmuPZmFPfoZMzpWB+JuBadpNRgz/Le5eZg//OUX9o
	HO9imvsieZ2cjsQkT5hiFDgS+bRTk/sIx35fJqPWDB+3FI2DqGvXF2hVsjPHMQJP
	PFrQ6j0GL+7w5RAcEZNqlUKUhqVWch57CACo7nXDUhy7WpmSlm3hTq5qRVvNfgk6
	1cwQt2WnDaRTAKrK67zpBw7j4rolE3F8z/OvvE1mpCpJhjC9LaN/tbIhMxDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756424657; x=1756511057; bh=jtgBh4POh8nsusIEKhuKrU+ypX89QHySy6v
	danUIBb0=; b=WfCrB8141YTLiIx04g1fhtWxRRnbmZTO9rsdh+UsiNIanSyj+EI
	+TZ+dWKw0upxSoHGou8nXTGlhShHNNqiOc9m0Kkz8CtQbmiFFmy8HvUnORNFNy0U
	LndhVF9UFtzrN8Z8Ajl0nh9+GP773mO8w7E9ZuI3TPHIvD4IWIqzOef6Yy1RQd1R
	XeokzZ/uv4XyHgF+YRjpGKULn7Wpz4cVn86Y//Fmx6ZcjA8Xh2IEHls8lXleSIHa
	ztqUaiTJtQcXg6V0McwtxBQ+vi+Loi7ehJP0v/f4ypx4T1ffEwDpFhyExc96N1iy
	NA5YKCmLE/1rMbwNmeTVNkfzlAt5oGIAA0A==
X-ME-Sender: <xms:0emwaMq0RzNQcBL2mhfp0Eap5GASxcTetiFFTUU2DeQ27AVpF-R14w>
    <xme:0emwaOIIQLuTGp6Gtk8opItCsPxnngbA37J90lwHqChq8VyCeCAcgzIDDa59r-yzV
    9KvBXXvaa8my_Qagw>
X-ME-Received: <xmr:0emwaHr-N_Qbuvj2JrHB7a-dHucYavXmpxnz7sCF4x_wgggNMhPl3Umx8w7jLU2jywUMrK-CUSYVhVVUX-6b8GAq11e1iPKJi8MgAYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0emwaOyyBuSUhKGYD3vYzEgQzzWZNoxOeOHKuJfix66cGSERF4cJ-Q>
    <xmx:0emwaDOQJrmkgGdgKEaxwUCfCsSLdXP6hXhrSWWXUqCkzkJRl8kMOQ>
    <xmx:0emwaL5_Nvpk34_V7QFpVgKE4MEhgZCaIQVOBAbxrNUE1z3Rc12xYQ>
    <xmx:0emwaElZkv6H-39SGrHza1oAcyWWVKwdeK9SGRlyrHD3x2p1tfpDMw>
    <xmx:0emwaGJTLb3U4GRftwOndmKoa_nHhzUDbUORMNr_5B0oiM3SgIFNAX29>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 19:44:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/5] doc: git-checkout: clarify intro
In-Reply-To: <f440d0e4-0754-49a0-9677-980f60a5dbf5@app.fastmail.com> (Julia
	Evans's message of "Thu, 28 Aug 2025 18:34:23 -0400")
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
	<a6125a0128937392af283033e63d2b04776caf2c.1756148933.git.gitgitgadget@gmail.com>
	<CALnO6CCvD-uoan=-VW+OmfCk5cLgNm=zENAejL9vX2czahMGxg@mail.gmail.com>
	<f440d0e4-0754-49a0-9677-980f60a5dbf5@app.fastmail.com>
Date: Thu, 28 Aug 2025 16:44:16 -0700
Message-ID: <xmqqa53jqaen.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>> I think we've dropped the bit about the default interpretation of "git
>> checkout <something>". Maybe
>>
>>     When you run `git checkout <something>`, Git tries to guess whether
>>     `<something>` is intended to be a branch, a commit, or a set of file(s),
>>     and then switches branches, switches commits, or restores the files.
>>
>>     By default, Git interprets `<something>` as a _<tree-ish>_.
>>     [explain what choosing a tree-ish means for the user?]
>>
>>     [Your notes on disambiguation as before]
>
> Thanks, will fix. Though I don't think it's accurate that
> Git will treat <something> as a <tree-ish> in this context, since
> `git checkout <tree>` is not valid. Will find a different wording.
> (I get "fatal: Cannot switch branch to a non-commit")

True.  "git checkout foo" is disambiguated by seeing if 'foo' can be
interpreted as a commit-ish, and if not, if there is a path 'foo' in
the working tree.  Otherwise we'd get an ambiguity error.  A commit-ish
that is nameed by giving a branch name and other commit-ish then trigger
a bit different codepaths (the former results in checking out a branch,
the latter detached HEAD).

