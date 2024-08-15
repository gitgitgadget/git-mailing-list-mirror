Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDE417BEAA
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723715479; cv=none; b=CVZDX+b96CFYv3TNBuezS1p98Yj6WE+qxQ81GFzRy9T4iBB03+wlxm19LXZRhsz/pI/Jms9OTfNOx/Y9fO7hlHHV0l9KX+CwH+dSKppOPsKppSvvPHjJ7elmiU6UZUos/82wwavid5amVPa0bcy3zdqlOifsYDoYgPrlIaHxbf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723715479; c=relaxed/simple;
	bh=reWIXwvKqt8SSHBreWy5epIQPEeh9tjkjhrRoEtY7XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD0W5lLnMPK57nh7TWSc+7wTqGHg8AB0Ualjdg74quuVE2JTjoGsFSyVga/eWYHoGD0MZ+/p5jZFpf7X5QsaI6HdG7l1Hss3c3w0E6l8aucEGsBcHzH+1Vic9jjG78V59MPc7yk8L76V/Lk4DZw6YTWlgrF7e2KHYIHtGwJxv2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R+6RYbCw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dgFO0JTT; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R+6RYbCw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dgFO0JTT"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id CA8261390074;
	Thu, 15 Aug 2024 05:40:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 15 Aug 2024 05:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723714845; x=1723801245; bh=reWIXwvKqt
	8SSHBreWy5epIQPEeh9tjkjhrRoEtY7XE=; b=R+6RYbCwK1AsCCo2wBWYhzhne3
	cg0qsO27C2I0wJ6FaSHix9JiwmAip6Xm0D2DVw2EukSCJZ+x4bXKf9xyUKX34f8T
	Qy5GV+KIk8fBrMpW2jN7DxkbJVvpgfWiXxCdxZwzh6WEhCgqtaf6Zu806CuUwwO3
	TiTpFIohvW2jSfy6+uk7Y7xjh6KgjEtClszczt2nd6xfwuU3nCoi9QM0ORFcR6kr
	zWr7N0dj0hZATF9RQiqeXMtJwgBaa+EykjaJTlfLmDhmuarcphi5zY4qMJst1oWM
	W88iw/eRdpGAWhcybkBXJINhG/ZHEZSICdLNGhjneSFGr5zsTQl+VXnz608g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723714845; x=1723801245; bh=reWIXwvKqt8SSHBreWy5epIQPEeh
	9tjkjhrRoEtY7XE=; b=dgFO0JTTb90WlAiprWZJYIzpP0ZYcAjpdabVyEuLVPer
	jkZ0SV9olqEGJ7rXRDOXAc5vCpAJPR8YnbkD3/oRFvt7OFAp4ZUSFAhPTvxUtKrD
	GktJ5ChHa4Vu8Jcfz4K0iTvmJZTm1oLnvjXRF5qzAdZTfDs0yrkkiSpfYYIAl8eI
	LHscIpLmlNZKkBwKbt4RmShUys9JK/7MlgqlRFW/3DrzNuSbSA04yIdh/Frv+K64
	YjBWUGP4n7kN6ekNHCj8kOzzBwU8QjF8Bkgg0WSimFAdY7HTUyAonzBnuN7hafE4
	cHwUKpf3FbLwmwqNrZrlaAf2civQgNEU3sziRMbzJQ==
X-ME-Sender: <xms:Hc29ZpL0VLBcfCM5vXsJtAWPgNlS_SyCX3-qcjLBQCYsmQS1-2KDAQ>
    <xme:Hc29ZlJqdcKZAHrWWYYUHro3ZHJGOWgV8tS11s18G97R07edTEi7DWDcoE-0yBM_J
    S6bBud1ijkSbEtj-Q>
X-ME-Received: <xmr:Hc29ZhtJfGBzTM4Rtq9J1aLgHwHgji0BE711q5PenGA_67dBG5_vyr5Mlmz_V3C_ixPDVxqiDSRWF2o9fZ9NWHpuGzy1fagmFZGMHCZHGRaxIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthht
    oheptghhrghnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Hc29ZqbOYNKKZq5D0B-1gZRUst1YhpmW_MdGmchIYjD-HgVF6I0C1Q>
    <xmx:Hc29ZgblLD52BuuVjXWU2E68N37EmZIPaC7SwAxH7L6uZT_eRusEuQ>
    <xmx:Hc29ZuCDT6W3m1vUzGE-6NZu2Z9M1i4nwGv3k8JbZ7Hm8f0-J9G9iw>
    <xmx:Hc29Zub3cxhcjSeu1Q0xGXgrIXwTD2MVSrqAtPDLuOhIh-NtcVp8WQ>
    <xmx:Hc29ZoGFMMe4NQbdgObfECtARm4DOvaVQQ9sR0Bkrzxn4cgCMxHDi4KU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:40:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 12b872c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:40:22 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:40:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 02/10] t-reftable-block: release used block reader
Message-ID: <Zr3NGugrgjrJlPUO@tanuki>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240814121122.4642-3-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814121122.4642-3-chandrapratap3519@gmail.com>

On Wed, Aug 14, 2024 at 05:33:10PM +0530, Chandra Pratap wrote:
> Used block readers must be released using block_reader_release() to
> prevent the occurence of a memory leak. Make test_block_read_write()
> conform to this statement.

Interesting. Didn't the old tests run with the leak checker enabled?

Patrick
