Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2E28E8
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735909962; cv=none; b=liutIHXLxqpi5yHqwXUnmaBzav7ZYihHZF1zQMJLwLirMsdMchcthk0mOD0M8UiQKfYSN/0gQNfLJBHcGU0aWrn9XBr3JFL94ZB6kHTSfxEBUEiB8BbKCmRBI3S0DEIaBYzlAymq2JeNOOXdGIpu41N0ybM/1GgJ8ES9iRBG2cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735909962; c=relaxed/simple;
	bh=/DfaTzLG3cfFetXwpn30D8nrZ5kGlsvq9O6EcxV6euo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJ4FPF2g8efafKJRT/Xws75fRYyAeLPbHbvlHEW1qLghmuuH+TodGhUJu3NmMbmKwlYIVQ9NJ3iNIpJi/qQgpJgVDTijf7+57A0P93EDLL8lkH/d8l0GAcZcAMw8k5AGa9IfGqKA83edXY5gnq+My8pzJ2P6LdNv6hsH2N86Plg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gumuM5Rc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I8HwYelW; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gumuM5Rc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I8HwYelW"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BF300138017B;
	Fri,  3 Jan 2025 08:12:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 03 Jan 2025 08:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735909959; x=1735996359; bh=laQGdVYmjp
	TzGvaDrGZLCQJK8JLDvWG96rDAvfTlB4c=; b=gumuM5RcdDbEE0OSe2KRpX73JW
	zWyKwsxQl7StKubBMGifkhvcFgwyL9OsM0qc4DxvYucwjK6PznFp3hYGVlp8B7YW
	eVRUBESJqQAi4SN/i6xlib7hnVGHaA8Y7mgfB263xTf84L2rFfgRDUgE+jctHqdV
	rmtJ3UDwHnZS349PyOEK2q3swULfFANrbpE+j3nNPALHk4O+6o5yXYbIlbg/lHQq
	GahjP7yoIaMyZXYMr7VDz3tT16Ozeuz7Ao66kyIWbhTB5cO1nC2vG66kDs1S7cEf
	f6mlgXcCYW0HkOfzLNgUbKF3Q5xEOnoPUzj9aN3AxcJOYUJHO984Ouj0zWpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735909959; x=1735996359; bh=laQGdVYmjpTzGvaDrGZLCQJK8JLDvWG96rD
	AvfTlB4c=; b=I8HwYelWmRBO/Fwl3bcNKUX8B2lrpFngeGy70yZzxuSYZ/eP/4l
	sKKasIc+dshLmw0d8NoTwEl6cMY9wALT3UbP6fHopYlJX+WBnw0M6vAlaW2EpFM1
	slRCR0caYBItodTa2J+C0A2/dTdNE2gVBxExuu6hmsr4AyWzhNgymLKU/TpW4268
	jPT6zns4u9yPGBrTbxefvEBTqZtw+B3WYY7Vdyedo8Yn5vkTynt71M+oATAjTCV5
	jWJm1NufEZ7RYYzM5vTvJF/5Yh1No/PpOHhiFiFCBx7BuE0goIw7xkXGtEN6hFYs
	1ndbCdy89IwomdaV293NnIqg6S+rRInXeoA==
X-ME-Sender: <xms:R-J3ZwmkMZA5sv72fy8DcrhfqbZWe2yZAsmiZ3tLL6-ZnrUIDZrZrg>
    <xme:R-J3Z_0JxUzbdWCygSgWTd2NZJyYWWV0rkkn-mcPh2V7I6aReHR0sJDlTcoWELhn0
    kFwulvESAeVopOZFw>
X-ME-Received: <xmr:R-J3Z-rmekkGkbxGSxLhzCArlgFISXKAFdej6qyfVSpYc8D4R3yzUJeb9sVbjFNSswl6hbG-sYjdOlnHGyFdM9MYSIq3ZTvFpbjzs7OVTf2CuJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprh
    gtphhtthhopehmrghtthgvohgsrghgnhholhhinhhivddttdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:R-J3Z8n5ZcXqUn88Cz5wUf15umGr_mL-g-H0AFqPubibAXOQ3j9FWg>
    <xmx:R-J3Z-20ZXoS5eFiqRG0eb_K6BwJzWWGNtzCSNKNPsQHwZalYL1vZg>
    <xmx:R-J3ZzuTPU83vn_CxUYfZFzjWZViyK0nek72yzCqHQPdr_uzhoNHHA>
    <xmx:R-J3Z6VDgGYAX4zvw69kolemhQtods1vx0xn3CjfEtNVjfeVAycH9A>
    <xmx:R-J3ZxTCVnc7ysxMAtYc0zJ9B4hjjN76hlsZdiC77NarDHGBCO6wnmbI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 08:12:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5012c26b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 13:12:37 +0000 (UTC)
Date: Fri, 3 Jan 2025 14:12:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Matteo Bagnolini <matteobagnolini2003@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johncai86@gmail.com
Subject: Re: [PATCH v2] t7110: replace `test -f` with `test_path_is_*` helpers
Message-ID: <Z3fiREGwXdILl-M1@pks.im>
References: <Z3fM1bT2Z_0GoD4w@pks.im>
 <20250103130035.79376-1-matteobagnolini2003@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103130035.79376-1-matteobagnolini2003@gmail.com>

On Fri, Jan 03, 2025 at 02:00:35PM +0100, Matteo Bagnolini wrote:
> From: matteobagnolini <matteobagnolini2003@gmail.com>
> 
> `test -f` and `! test -f` do not provide clear error messages when they fail.
> To enhance debuggability, use `test_path_is_file` and `test_path_is_missing`,
> which instead provide more informative error messages.
> 
> Note that `! test -f` checks if a path is not a file, while
> `test_path_is_missing` verifies that a path does not exist. In this specific
> case the tests are meant to check the absence of the path, making
> `test_path_is_missing` a valid replacement.

Thanks, this version looks good to me.

Patrick
