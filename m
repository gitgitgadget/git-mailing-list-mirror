Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1AA35A925
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092961; cv=none; b=dpBVzw6wn8N+X6zhVWHyu6B3xdyA0L9Zx3ishAcenuVU83PeA6TOrA6P0yZgT0kMHIF1Qx5ltvYiHNv3sbOTSLUmKjPlPy3B9NpzSxE7nlk+g8A8JtSOfZchUdLjXpePTmz7ZMDdv30UCcX3fPXcDCPxNhD/8SO8+1n9Uuung+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092961; c=relaxed/simple;
	bh=nCXl3wG8ldydOmVDC9Qoh5LRu55afLBI6N7eS3TF98A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PIOantaKSBIR22vAwo8B7Cfgt0Plpt1lmQ6/5bNc0X2fooFnXxQba3HQtkKFvnPsGYoYOeAxcrHflC9FLT6szRpzDEr/3rJ6+K7Vyx7yJNGRfaMSnR00VQQGavsL0y9RDdAUOMecXpCXNKdqmqcXc8m7flHrqzlkXtr5pDRsG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ikcyNvbA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nu6kRCTz; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ikcyNvbA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nu6kRCTz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C22041D000BB;
	Mon, 13 Apr 2026 11:09:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 13 Apr 2026 11:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776092958; x=1776179358; bh=3iUm5KwLuw
	B7S4gnuio4zqSWieQwkB1NhVKmPfs6uao=; b=ikcyNvbA9cizcemypC97QR7YEq
	er1KrmD2ko643JRLRgnYFMRj6yhGUCAminAVRyY1IeOX6023JcTyon/Ee29mnQFK
	0+wZ3jimQh7ruVj4cl9wa4ZDwj8GpTO/kG6tsJ2FTZBHB0p7YMlg9O80lU3FclVs
	IWE6UqgKDHMd+mJ0PtxZtq/U0Yqzbvi7kX8ggC5fuFWGyd6xW+bDIgV8oszX7UI9
	xeXybI/LmjuEx8p/UZdNsV34ap9yIbff2JosIi4KvPTIhod7TnmcvJq3IJ5Tr5Bg
	puUnQZKPbMQfArhxuO/6ZnluQzOXAzeVt6ts0gV1U7e951VsDuP4b+R9fvjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776092958; x=1776179358; bh=3iUm5KwLuwB7S4gnuio4zqSWieQwkB1NhVK
	mPfs6uao=; b=Nu6kRCTz2YZk1y9NkNALNmAMYDFHs0g6IYEpCj3rCt9ogeeh9bu
	yYxTR1G9a+8EDgX0Kk06umhvFRfrMm8+kFiKcnEjD0Y1sfoO0nrF9rGE8Qm/4Yiv
	ebeconlNCL4JAtXWhHSwwVDr5HmWWJiGQY/njS+iUlvgD31ArT7sq3H5wFhWax9V
	KbP26bd0IGonNNCvi0MnmSQH6B2mq8W3aBPTUanRI2SiPqO4Hu2+n1W95HTbrHet
	Q5yWU/CWQIthxNHuRaV9zesgvQm/fGkS1ekmsjdoS6ZdWzDypHTTFnzPLTn9y6hh
	hCGQE4TuxAkTTmvo3BAmDU8PdFeZJY01K/g==
X-ME-Sender: <xms:HgfdaQvriZ7OotNcMoBLJ45wz-qmZM1gkNVmlJpLKn-XuPqYwBpY_A>
    <xme:HgfdaRI3epkje-PB4wNCDuRfTDZ-jaEIbicsJEjUf5hQ1ElXIQ-MQgGuQ25Ejur5p
    uKAlMhavjSVlzgW0LUu3fnCBoio5xGUpAcyzOg9PcjJdIoqPFhX_A>
X-ME-Received: <xmr:HgfdaVn53s_0E_bBMhD_6RJ5_sSS6oWPNluEViHmh3fGhTexThmlZKamrrdZfNcV8xssDRUZRf22rmRCq_lBal6pI5KEc33GKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtofdttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffge
    fgfeeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhgvshhh
    ihhguhhrghgrohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpdhrtghpth
    htohepqhhuvghnthhinhdrsggvrhhnvghtsegslhhuvgifihhnrdgthhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HgfdaaKQ78U2N1P1UQ0vHfSNvPZb69vV9pJLh0iR2u2XTBJVUC5SfQ>
    <xmx:HgfdaS7wv7pATaXnf2nMBS6U6zpvRlG_NP4OTl1BPR29-bcU9JSrBA>
    <xmx:HgfdaW22GtO2dBQI8-6lEs2SSk7_N6lxjhDkkx1Wo80a2AUNFAUOUg>
    <xmx:HgfdaQcRyqJ-iaIfAd-IR64KRnwcXa-SC_yi_Zg35u5H4swHt3a4IQ>
    <xmx:HgfdaStj6l5bwWhb0iIGjKvZgIyDTwexSbKc6cbc8h1nU0ABvMImXPH9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 11:09:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org,  ben.knoble@gmail.com,  mroik@delayed.space,
  quentin.bernet@bluewin.ch
Subject: Re: [PATCH v4] stash: infer "push" when command line starts with an
 option
In-Reply-To: <20260412195204.4636-1-deveshigurgaon@gmail.com> (Deveshi
	Dwivedi's message of "Sun, 12 Apr 2026 19:52:04 +0000")
References: <20260404143640.6679-1-deveshigurgaon@gmail.com>
	<20260412195204.4636-1-deveshigurgaon@gmail.com>
Date: Mon, 13 Apr 2026 08:09:16 -0700
Message-ID: <xmqqeckilwwz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Deveshi Dwivedi <deveshigurgaon@gmail.com> writes:

> When "git stash" is run without the "push" subcommand, the command
> tries to assume "push" but rejects any non-option arguments (i.e.,
> pathspecs without "--") to avoid treating a misspelled subcommand
> name as a pathspec.

I think "run without the 'push' subcommand" above should be "run
without any subcommand (on the command line)".  "git stash pop
-- paths" is run without the "push" subcommand, and obviously we do
not want it to assume "push".

> A command line that begins with an option cannot be naming a "git
> stash" subcommand, so unconditionally assume "push" in that case and
> allow pathspec arguments to follow without requiring "--".  This is
> simpler and more robust than checking a specific list of options,
> and remains correct even if push or other subcommands gain new
> options in the future.

Good.

> Note that this does not check for negated options, so "git stash
> --no-staged [<pathspec>]" is still rejected.  Handling negated
> options would require teaching the inference logic about them
> explicitly.

That is unexpected, and unfortunate.  I would have expected, since
we are now sending any thing that is not unrecognised to "push", it
would largely be the matter of removing special casing code about
push_assumed from push_stash() and adding some to its caller, which
is cmd_stash().  It would first look at its table of subcommands and
if it finds a hit, calls the handler.  If not, and if there is no
argument or if the first argument begins with a dash "if (argv[1] &&
argv[1][0] == '-')", then unshift "push" into the argv[] array, and
call push_stash(), which would complain if the command line (with
"push" prepended) does not make sense to it.  If the above two
conditions were not met, cmd_stash() would not call push_stash() but
complain that it did not get a valid command.  Or something like that.

That way, there is nothing that makes "--no-something" any more
special than "--something", no?




