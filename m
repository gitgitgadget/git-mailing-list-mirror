Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCB0192580
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223241; cv=none; b=GqMIu87t5Hn0Fg871kIUbUmzlz3rLdwM7x92trrLLIwWcCeMN/PGY6cl18c5sW88kR4UC7Fi4sh9vqaItmf8syJdnch5NHrqf7UdXmmu5OhBCDqps0WzGwWamfkqEcug6w07Ote0zNmwGXGtGPDmcuSP+6ANpLf1oemfHW0CSJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223241; c=relaxed/simple;
	bh=QPoXrd3C0u9RzzflGJa9UM04MzcIbISkc4dLqpSkTrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnhfZdWb8MG+EaZiDdCM6fk71deylu+anuCX+ez/W7DQ78baJzl1t2FXtSy6jXDCNxWi1ofWDsbUsK3SZlFZNZaFcPREUJIYazX0jcyNm5p8eoyURiIu7hUNENuzEA8ggfe5BFEMTNf2E/pUmHbIK/qXAKlxHyTAQfntE0Dwumk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=afGGfL2z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rGl8iugV; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="afGGfL2z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rGl8iugV"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 57F84138FF84;
	Wed, 21 Aug 2024 02:53:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 21 Aug 2024 02:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724223237; x=1724309637; bh=xnsnmlaGov
	LIeaVmKsiqfL26eJc2/RxElpyE8+aed+U=; b=afGGfL2zA59tdjAaob1J8JBp4k
	l12+0KJbflKDdT52YBhQBHprdJDuDPtXhwNvNV0MMXzOVd5zNRus05S5vZ5h7DOK
	ABYx5mXWLSjclfXr9Ck8tZyB6i3egYTiLdmzgdyS7GpKK1FWL1kzJ1t6T5SPWaI+
	IqIb8JXyqsQ8RxUz5MveFsv7hofPpaBnq6tAOIYgItPKWvFawdUxwnjofZ0opEN5
	cig+i9czJf8I2i/eaIieS8VeGo1j2EswDAZuhQvZ10PL0/fVY45Gy6paz8QSkSo2
	avROnsShpV+B5Jm0To1fjYqSSN33oNVzpJ+b3UShdA3Hfx83MtCndr8K19GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724223237; x=1724309637; bh=xnsnmlaGovLIeaVmKsiqfL26eJc2
	/RxElpyE8+aed+U=; b=rGl8iugVCINam8mxKByntT0Y32DvIlr5YbhAAyvvM78e
	Uo1Gn5fAo5rXRcJMh7qLhUIZ+ObcahrAh6aqtvGazyN/2CvsTNAxyRMzyE1tc3Pn
	qWjJjlQS5D/xI/DZHEWdYluXkaNlJGrDIrmeECv5S6u9FBGigHOjz4cRrSZTYRDv
	bwxPk965ucElqaMvOPx8SAytS/jKLLN1K/wTxWDGCwZ2Kwndhea8AOrO9iFk4N8B
	AkYEXTuL/vTLWJgxAxy1KraSpZddssvLjU7NotFdFHcUdE1b4i9hhqG7+3QMvqC1
	qodpZNm+lrKoPCI39qvqDrZ7v6j7lvJfXYsungU12A==
X-ME-Sender: <xms:BY_FZsKSUcL6ze4fWKRu7Wpg8eXu42ozKFuHAPsqFtMojX3IMtM0iQ>
    <xme:BY_FZsLkY9V7HATzCzJl380fVWPLi-ENOCdvZlcHDjt0MLRvigHgkn4jjyvqoe1yx
    TCowWMzfN5qXaKPqw>
X-ME-Received: <xmr:BY_FZssKR7Gl6RCb1E_yDXvuS9GGSUjJU2ejYyAlzqjOi-a2ui1noTw3NVRmDoEAtTkbCkdUalF3pHptwvonaWo5qmAjL3egBaMSEupOMyPldA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddujedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehmuhiiihhmuhiihhhisehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BY_FZpZm-ZA8zKEG_mDHC4TF3b4fzBQogTO_WJUpaH3LTZm-GU3_lA>
    <xmx:BY_FZjY2566ZNY-wPgWddNzjgBMU2_T036G9xHtqOXV3jQIdiS9gBA>
    <xmx:BY_FZlA11YGg8GqoDQjdz5jlWHJj87zCc-YDFeQ820OrGBMnrxbcYQ>
    <xmx:BY_FZpYkC84MRhrHHOei6HAOpVAWt49yTVlcJk9VPpQCs7L1m7EgDA>
    <xmx:BY_FZvH00HJQR6bI-XZm3UM_w1RzGSdJQmbehLP-kkPrU5LTRQIuIwdH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 02:53:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cfcf50ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Aug 2024 06:53:22 +0000 (UTC)
Date: Wed, 21 Aug 2024 08:53:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Yukai Chou <muzimuzhi@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2] doc: add --show-names for git config
Message-ID: <ZsWO-K4UFXsG7QNY@tanuki>
References: <CAEg0tHRL9+tqY0k2GiGzhc-VgMVsHqppLRFHbc=M33R6AoLXEg@mail.gmail.com>
 <xmqqcym4fqhp.fsf@gitster.g>
 <CAEg0tHQDT7LesB2kiQD4rXwcUs5ZhOH+YWdn990tfGdrnYdgZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg0tHQDT7LesB2kiQD4rXwcUs5ZhOH+YWdn990tfGdrnYdgZg@mail.gmail.com>

On Tue, Aug 20, 2024 at 02:27:56AM +0800, Yukai Chou wrote:
> 4e513890 (builtin/config: introduce "get" subcommand,
> 2024-05-06) introduced "--show-names" option that is used to
> give the name of the configuration variable to each output entry
> in addition to the value.  It however forgot to document it,
> even though the option is used in a few examples.
> 
> Document it.
> 
> Signed-off-by: Yukai Chou <muzimuzhi@gmail.com>
> ---
> Thanks for your review and suggestions Junio. I must have stayed up
> too late yesterday, so what the commit message was sent was not the
> final version.
> 
>  Documentation/git-config.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 65c645d461..16323c4ed0 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -268,6 +268,9 @@ Valid `<type>`'s include:
>   all queried config options with the scope of that value
>   (worktree, local, global, system, command).
> 
> +--show-names::
> + Output also the names of config variables for `list` or `get`.
> +

This looks sensible. I'd probably drop the "also" here, which reads a
bit awkward. Do we also want to spell out how names and values are
separated from each other?

Patrick
