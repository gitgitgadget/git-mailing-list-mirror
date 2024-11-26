Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CA413C3F6
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732611388; cv=none; b=ZDILN918eoHc9WrGrrGh3xRbQLlD+5rDeAH3+zNOfw1hPy0WtPjuMLwjGIziN5p9SGJmebMZjY+MZ05huiZZbHWBhBK1uAI2J9P6Po9pK5N4qrEdIdVh8jOyXTkW6PteCtnp3DVpiJcj175/wRDoC57oCr/CoDv8znlvAakptvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732611388; c=relaxed/simple;
	bh=JKGjjgePe3WzuwpFCt8fnEMgyjHoCcIR6GPxGy990A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTMKmSg2qNJps9eoOW4YKzTXW5B6X3wgONLp4j2nKYLHX067wRTBFAZoAeHHvq7hCEX/21wrWtYkEjVKSmA0bH1deI/ywdzC3UYqCbSfJlNQ9JDFTST6Pqcwv/hi/xSQ/vKe3rb27Gjy+LS8G8+fa6wRB9U9z9S39fwSBQo5pXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oWu7at44; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0fKgl+VK; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oWu7at44";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0fKgl+VK"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 2CA8A138082A;
	Tue, 26 Nov 2024 03:56:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 26 Nov 2024 03:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732611386; x=1732697786; bh=k6tqRZDAmm
	4d1JQ7s2XHmYUKa6nz+cJ8tErogOSxeOQ=; b=oWu7at44IrCGyr5Zo/GB/X7lvV
	XvteTr0fpHB7Wg21arMvnhtiyC4l0NtBBXq1Qs1UWhjyQvtAP+1DOj5YNYUSSWJM
	RyU4unLD/uyW95PdwJY8d4n70tc9ScM5bNt/9RFhLtHPhdvfKCeapnOs90oYti4U
	KzkY0KHZC19NLrGe/KUgIJ+v+/ubbQ0YN24l35fGWluFzfdYCcPSXPymctpyBb8R
	TGTDUng93pGoAnEFFQNH7sES6vfuhNiSzSdlibWPikxuA14dkb3Qo9+BMPQ6A0zE
	ROqlMHywsgkAx4efUk8IwH6pM6FmjiiWlUsAmtj+hjCc02L6MWz07z/4QXsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732611386; x=1732697786; bh=k6tqRZDAmm4d1JQ7s2XHmYUKa6nz+cJ8tEr
	ogOSxeOQ=; b=0fKgl+VKusdIWbd9WzCE+s5QMl41G3Iw2cFYz7bprahV1OEkj16
	0V1y2tLqP8UXyXyavDIe3WOtClcJLQw7ukj9FMK6vTwxo32MrMWwWjYZurcsaYb4
	Dmef5MXmHk/d0DMHm5/8WnSJfzk8KKbIQBj7qAKS6xpQRajypzorC8Eo/iFsV/T7
	1MNKWI0PV8iWTvNB8muhk6bCiJ3RkMjLMsiid7bRSJOLHGfrl2g0d7MJ7eYc0+Fn
	OwAMWzdR/0Z2vAn5XB8gcrhs1+TEWVFlgMQW8cAZYnvG+OESQQ+wI0peMXaknRTU
	u+v4+roVlrT79yCX4+N7LZuXe5OSF45nfRQ==
X-ME-Sender: <xms:Oo1FZxENDuGFPgdOSdP_NsGHpeeRYbfjmQGjE2rhxYcfUww2CzMsew>
    <xme:Oo1FZ2XyWoSXO-zjHtjxqe_6OUMXM6RcEfI7xSyTuyfXGQM1y8SZh0aBmxQlmcP9R
    gVLIkEKpFgVVs4DCg>
X-ME-Received: <xmr:Oo1FZzJL_BKQmE0ejLyryYpXdKbhpxpmBf3ADzucowBlIlFhbs3GrH0ayS4m9KYW-YR1LlbIBE1-JJRK9iQR6MamgtWPorLnJtMGu_fdToRHgCGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Oo1FZ3Fc9rPr8QDOiNyI6-Yy-E1XnxvUmUQRslKyDaxRi6DB0ztKNA>
    <xmx:Oo1FZ3WmYmkRVCkem2SD8XOenoJ6ndUpWNqffLcA7Y9zZ1r2dN5tBQ>
    <xmx:Oo1FZyOaUOsxq3Pp309tYbLnaz2hm92W-JaEvc6X7xltxEE0akgfNw>
    <xmx:Oo1FZ22kroBL_xLmHjh4hjlTkSN66VqauHuwUtwyJydrPKNjPXWpnQ>
    <xmx:Oo1FZyQB106qtt94QDQ1wr1hPZw7LSzml2BiRetkI--MNw8SIwpivIRW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 03:56:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ba67fedb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 08:55:19 +0000 (UTC)
Date: Tue, 26 Nov 2024 09:56:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com
Subject: Re: [PATCH] builtin: pass repository to sub commands
Message-ID: <Z0WNKV5prRE2Hupw@pks.im>
References: <20241125-374-add-repository-to-subsubcommands-v1-1-637a5e22ba48@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125-374-add-repository-to-subsubcommands-v1-1-637a5e22ba48@gmail.com>

On Mon, Nov 25, 2024 at 03:55:30PM +0100, Karthik Nayak wrote:
> In 9b1cb5070f (builtin: add a repository parameter for builtin
> functions, 2024-09-13) the repository was passed down to all builtin
> commands. This allowed the repository to be passed down to lower layers
> without depending on the global `the_repository` variable.
> 
> Continue this work by also passing down the repository parameter from
> the command to sub-commands. This will help pass down the repository to
> other subsystems and cleanup usage of global variables like
> 'the_repository' and 'the_hash_algo'.

One alternative could be to instead pass a caller-provided structure to
the subcommands. Right now that isn't really needed because we tend to
make use of not only `the_repository` as a global variable, but also
because we track all kinds of other variables globally.

So if the code were refactored to instead accept an arbitrary `void *`
pointer, callers could provide a custom structure and pass that along to
its subcommands. In many cases we may end up just passing the repo
directly, but I'm sure there are others where this direction would buy
us additional flexibility and allow us to get rid of even more global
state.

Patrick
