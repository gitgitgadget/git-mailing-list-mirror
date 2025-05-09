Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9523C1D7E41
	for <git@vger.kernel.org>; Fri,  9 May 2025 06:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771608; cv=none; b=UuwcS6xCftlggXE1W68P4jsm3shsIkuS52MOnL/HBrMHk4b8rYCaXfcup2dp5l5QwQ3xW3yRPfKDFSOrerwRxMYavZq14K4mNZyU71noqlzM2wwOF8f/PeZ3ZDPFSP01BxfCekaEEeQu4osZJfB7Dom/Z6f5PIqdEmFJMul/An4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771608; c=relaxed/simple;
	bh=b2K/rRLGuLYAQ/0NMLnvrdvNZDRaemtq1BYXoPRztHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9f4JUogDIOV3LMRh0CwLNDRdJk6DHaTs2K8RD9GJhptNKUMyrOywDdVzxEmo3vXPdED2N3IMNZ6gj1g4HNZrLBlQ9GI/9h5YNvAKG4+dN49HlLVBEERapjEfYo4GQ4PKKfpxcuIdmx5Hf9bCo8yEdUcoi7v1BQKvuyWZv/JFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NrRwswQq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T0Y8l5CX; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NrRwswQq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T0Y8l5CX"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 082AA114019C;
	Fri,  9 May 2025 02:20:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 May 2025 02:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746771604; x=1746858004; bh=9KUbolVCZo
	RgHHeQW0TXaYArnwOp96lv/MCNh2nprzs=; b=NrRwswQqg8k5EqzUdabuHPm2Hq
	Zjgy+Pbeaz6sGxXh/j/pLl15zXE+HXAdQydDHKJkTSM32bIyvTlzkQKY09jtxDkT
	NUB5L1HTPzlypikgFfFt867tgZZiWMWHswa+jBDPjbk0Qdq9u/FhzLFNzZfcFqk5
	RCXpAAR28xIMVMsjRxfKJrdjk0M+Mh+t7HeQAv6aKBpUztAY2/ZKlL0q//fya2Kl
	2olrBdLI9/0A4pLqklinFVzWudpeA5OWhw4vIrxDpQ5Yu5NQvVpCKN/ikbvSg+WO
	F4oqhQ6mgLNlQ/D3umiNueSBAsl8/cJ+p/bhtGUPaK73WDe3gPgoqERIUcSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746771604; x=1746858004; bh=9KUbolVCZoRgHHeQW0TXaYArnwOp96lv/MC
	Nh2nprzs=; b=T0Y8l5CXkLT7xlk8xa0muAkeDXpcFwV4pU1qt70Mo/Cmopn553p
	jnwvXsPyn6b7O8cyd1XdlMjUvYCmpLuWPOcU2b1ynGzRX9rcRbXRHXSJL5v0h+bc
	1rY0IQIDbWVRIkZJlW+jgJEV/eH1TJb3YGS8C3GQLUlLKN+Ta6epHz9RppaUQWlP
	haQ02Am2LQxVr4bL+KTm7XoHRcZhTGIwgyx7EvPxlCUpqzKa3MMfKjc9xaxdrbpd
	dyCCwWT0pxN6Q8Xq3p7ZGMSZ98xfipXZBzG8pNYC+LpysrCPHkMlE2z7naFviM95
	2BJ1cmrrfWXjSjuuqTJMk80IckgV8CIQCMg==
X-ME-Sender: <xms:k54daELYnRJKx9anZf_FtWwp0_JQKGytQEjGzIqpEsjAAIAAlrl_Uw>
    <xme:k54daEJ8Tp6U0inzchL3c4f69l6aJH02wetakuMZ8EnXmLDzm4g2RsldqAOL92QnU
    JFKu2QWlDNppX9cwg>
X-ME-Received: <xmr:k54daEuMRqudvSFY5eLehcezzt-IuvO1AJ1Lwc37TE54La6Q2FaoNB00oE7rYuw8muxPkZZgImTJPUXm8fE84YIXCTMkHAwYIxqMj63s7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledukeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopeehtddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghn
X-ME-Proxy: <xmx:k54daBaKHPN85Y830L5OBG1C1lOEO3SyCQ6qor_piPdx8WVy4BNj0g>
    <xmx:k54daLZTwsOkVSO7FoU_QrVNvEzyG0EyM4k3THD0ckvHBmSx6wW2wA>
    <xmx:k54daNDEoXEcz7r7tI6SKmzWnknWEeRxlVXa6xlph7TcF5USrqSijw>
    <xmx:k54daBY-EftIjDwb8hBmu_DqKra4mNV9h-UZqnYIER4sZJWwKpEMsg>
    <xmx:lJ4daH0O9TZFLg3ZOE1KxAx-g2dkIYFw5CKxT2c0fyrlnaQ6PKbbIrtL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 02:20:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84a32fda (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 06:20:01 +0000 (UTC)
Date: Fri, 9 May 2025 08:19:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v2] parse-options: fix xstrdup leak in parse_options_step
 parse-options:984
Message-ID: <aB2ejA1tCK9DR1Nq@pks.im>
References: <pull.1954.git.git.1746585203.gitgitgadget@gmail.com>
 <pull.1954.v2.git.git.1746624294017.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1954.v2.git.git.1746624294017.gitgitgadget@gmail.com>

On Wed, May 07, 2025 at 01:24:53PM +0000, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> 
> Most Git commands use parse_options to parse options, but parse_options
> causes a memory leak when it encounters unknown short options. The leak
> occurs at line 984 in parse-options.c, where git allocates some spaces

Again, no need to quote the exact line number.

> to store the unknown short options and will never release those spaces.
> 
> To address this issue, users can be allowed to provide a custom function
> to allocate memory for unknown options. For example, users can use
> strvec_push to allocate memory for unknown options and later call
> strvec_clear at the end of the Git command to release the memory, thereby
> avoiding the memory leak.

So does that mean that _every_ user of the "parse-options" interfaces
now has to explicitly plug this memory leak when facing unknown options?
That sounds rather undesirable, as there are so many users out there.

> This commit allows users to provide a custom allocation function for
> unknown options via the strdup_fn field in the last struct option. For
> convenience, this commit also introduces a new macro, OPT_UNKNOWN, which
> behaves like OPT_END but takes an additional argument for the allocation
> function. parse_options could get the custom allocation function in struct
> parse_opt_ctx_t by using set_strdup_fn. A simple example to use
> OPT_UNKNOWN is put into t/helper/test-free-unknown-options.c

Hm. Is there any other usecase for the `strdup_fn` field that you can
think about in the future? Otherwise it feels a bit overengineered from
my perspective.

I unfortuntaely don't think the proposed solution works well. To really
plug the memory leak everywhere, we would have to convert every single
user of `parse_options()` to pass `OPTION_UNKNOWN()` instead of
`OPTION_END()`, pass a strvec and clear that strvec at the end. It just
doesn't quite feel like it's worth it to plug a single, bounded memory
leak.

The most important problem that we're facing is that the allocated
string has a lifetime longer than `parse_options()`, because it really
only becomes relevant in the case where `PARSE_OPT_KEEP_UNKNOWN_OPT` is
enabled. If so, the _caller_ of `parse_options()` will want to process
the modified `argv`, and thus they have to be the ones responsible for
freeing potentially-allocated memory once it's unused.

But that'd require us to keep some state. You solve this via the extra
strvec, but that doesn't really look like a great solution to me. An
alternative would be to expose the `parse_options_ctx` and let the
caller eventually call `parse_options_clear()` or something like that.
This would also require us to modify every caller, but the benefit would
be that we now have a single place where we can always allocate memory
in without having to worry about its lifetime.

All of that starts to become kind of involved though. So unless others
disagree with my analysis I just don't think this edge case really is
worth the complexity.

Thanks!

Patrick
