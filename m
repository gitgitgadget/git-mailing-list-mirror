Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997A2F4A
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 08:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763278; cv=none; b=RDnAeOylUOCMWyJzHtN+XMPhobEz1LdBPf83lhLcjRmKTNtYkArXAd8AoOa7X4C6mxx+Jc9MYgo056lQevoHQNc/2/kihbSNhBfw/g4C/cSFwZy9Zhuh4AxuP86RewFAY273V/Qydjhcu17PWW+0l0FMNT5ui6zQn+exjneIo3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763278; c=relaxed/simple;
	bh=8Q5Baq4HLglVHFyIxcJFxLu5DmMhnuu8/7sq2SjAXDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuKjrcLeD3/MR6H7VoG5NVIjTfJHsBon4l8SlOC/FXYjGaxGqu+g3WbSeqUAkOEAdW2EZAYP0Dky7/sobNdQTkW8cFbuFKcwlWQOh318zYMz4xZI2H0klP3qNJ8AIVA25qu67oNM453sDny7pBxBpORg8Y0kCcHifbrU6ysrMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LwaH6xpt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bbtHhvdm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LwaH6xpt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bbtHhvdm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E460E14000B7;
	Thu, 21 Aug 2025 04:01:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 21 Aug 2025 04:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755763275; x=1755849675; bh=vsXtAfLd17
	wYhKSLgqojVCpi7BSrzim/h8W4h+QVS0c=; b=LwaH6xpt9el71/ABxBo5cFIJtV
	HZgY7Azz/dvznDvWnSCsLbFeYQyYHOTm+rPU+RmOKlcOq9aWyq39FCHJwt6BocI2
	/lq0G2QBajVl0NclZw3SwBYIyWk1wxYe9yAZYu0jL5UHfwYM+iYK4C8ZVXBvjEfu
	a806sQSeByfjEKCKUfdtLTibFD6BERv1b+Yu451xQThPnheEFVNgCCDazr/pTozy
	TPAEZvfYAE6ZmqurKucLXmeH3p3RjyQbRSzQIIl+BCv2V92dO6r/oaGTH7CtAmgJ
	t+E7QqCnNneCWmO9FfzZ0afDG8jBzeWbf86pZyQ46h2lGqxq/1JIOLLc0Msg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755763275; x=1755849675; bh=vsXtAfLd17wYhKSLgqojVCpi7BSrzim/h8W
	4h+QVS0c=; b=bbtHhvdmpGQmJZq6Kl73I3bDhNVu41yf28xDWedgAXsXhyZi1yq
	PIRzbVn+lnulTKSRlcCnHp28V190RjIm4IvabjJiEKNzhHYMhmZlYyEESSF0F6V2
	U52T5pl/MnXkevJMl/3VEMMYaYanxHaNsnwM6iqlOkzOAHjLJuI3w+6fFqNHSQEk
	Yih2CpDsDSyBGqbxYM3+M7Ja2ctA5j47bVMXI0CVboWc7AmjsL50jOfNRB4M1byN
	/UqXWXnQn5m67LIpjDZpuyb7RjqjN8iEOyiVT2xeQ2joBfzX4mVO/NTNNZWMoBZU
	KrlkwaOSHYlKjvIkC9LwWNYxHPDDzWcE2kQ==
X-ME-Sender: <xms:S9KmaJ2QTwtBWDNQdgbwKpDZhPZoLlZh_vn3LCzli50WnwQredcw_w>
    <xme:S9KmaGDCeUCqJmlxQutXFdlJOr6LNmniXkMqTQD9FX_Z--sx2L1S-gXxLj64Laojv
    __hARwA_9mA9O6QOA>
X-ME-Received: <xmr:S9KmaHCiZ665lt_ms2lk_Wwn_J0aMaDwI7GJMKIkf0XKpC3pIMvsOHBELOSHlrcSdYsZcQEE8wzHx-Rl2XILL2rx5nSplXm26WZqRgnqug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeek
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtg
    homhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehn
    vgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:S9KmaHnUOtaaNTMN5dcuI51Y-XyP_vy57npel6ESx3hv1m5Osqqf1A>
    <xmx:S9KmaHh5J-0BAEka-4XfNjWn_njMpdzA-oVdgbF6ZommEFIJVnehEg>
    <xmx:S9KmaBhrfvU1Q6Fz9tNmDbJ_x2weAI-6ujk1Rgtj5Bcv1CtYBWiHBA>
    <xmx:S9KmaJsc8UKZWJMTMllOOhkzCU-lmNganYMql2v8SzEVlFlwC4ejFw>
    <xmx:S9KmaF7YMoicmwLBoO8IRFYIwMnau07gemkjHDW4meXbU4q1eA7GX37o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 04:01:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c2eec211 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 08:01:13 +0000 (UTC)
Date: Thu, 21 Aug 2025 10:01:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, me@ttaylorr.com, newren@gmail.com,
	peff@peff.net, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/3] path-walk: fix setup of pending objects
Message-ID: <aKbSRQJCPh3Lsew8@pks.im>
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
 <0dc4a6323e66598070b403d286ee1918e6a9b791.1755715196.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dc4a6323e66598070b403d286ee1918e6a9b791.1755715196.git.gitgitgadget@gmail.com>

On Wed, Aug 20, 2025 at 06:39:55PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> The previous change established a buggy instance of 'git repack -adf
> --path-walk' when there exist paths that are tracked in the index and
> that is the only instance of those paths in the history of the
> repository. This change fixes that bug.
> 
> The core problem here is that the "maybe_interesting" member of 'struct
> type_and_oid_list' is not initialized to '1'. This member was added in
> 6333e7ae0b (path-walk: mark trees and blobs as UNINTERESTING,
> 2024-12-20) in a way to help when creating packfiles for a small commit
> range using the sparse path algorithm (enabled by pack.useSparse=true).
> 
> The idea here is that the list is marked as "maybe_interesting" if an
> object is added that does not have the UNINITERSTING flag on it. Later,

s/UNINITERSTING/UNINTERESTING/

> this is checked again in case all objects in the list were marked
> UNINTERESTING after that point in time. In this case, the algorithm
> skips the list as there is no reason to visit it.
> 
> This leads to the problem where the "maybe_interesting" member was not
> appropriately initialized when the list is created from pending objects.
> This is the fix for now.
> 
> To help avoid this from happening in the future, a follow-up change will
> make initializing lists use a shared method instead of allowing for an
> update to this initialization process to miss some existing copies.

Yeah, I wanted to say that this feels quite fragile to me and very easy
to miss. Does this mechanism buy us a lot of performance in the first
place? Because if not we might as well just remove it entirely.

But if the answer is "yes" then adding APIs around it feels like a good
alternative.

Patrick
