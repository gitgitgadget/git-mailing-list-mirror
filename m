Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA8A13AA2F
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881238; cv=none; b=fwNrlIBZnzuqjrVJH8VKaKjZF2EH+mw8kF0ghqvnpedfz/pDC8aTirXAjE0mAfq0AUR7wiY1G4puwnp8CL4tUyScNfI22mA53M/ipTG/jDsDWReYxI7zIUssb04bD/bAmNNBfdGmygMoovlAxHbh5XhhAKgUBBhIPzMJLAv+9xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881238; c=relaxed/simple;
	bh=MIW+PGqoijRheS+0lNbSE9nyThp0cP9QASgEeZ7DnxQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=at5BMpkGQkvHmQA6K6JFE3Au+n9GEaaB4cVmsnjTElQEYdFYPBWcTOemMbuzj8GXZxSjNyXHcJPSu8JbbqJKOiJnBKoChHakwxR2FcD7FPDTK6fb/wlcOqzUFURz9ymgCm5Zt0zEvoAn9LRCZIaYutmFVGXi3+7rDLmYpGN/pJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hgXetlcC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qe97cxpR; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hgXetlcC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qe97cxpR"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 20CDB1140221;
	Thu, 13 Mar 2025 11:53:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 13 Mar 2025 11:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741881236; x=1741967636; bh=ohlqkXWSzX
	Ks+RYrOj9CC2fAC+UOEy17oAwQMOWlENk=; b=hgXetlcCbhnut6K7IJSMIRKWGj
	F8763Gnzkais90PR8TcNsV0A8QRvAq2Of0Cjr8Ol9byWoYidCcaXEMZzja6UeRn4
	puv5ozVw3ifoQAbk/WPvemY+3KqF4sGZsn0Qv6vMidezH7t1wrKq6eVjbwAWEfp3
	l+AR9CkdFKnCRv15A14MmTaXPggviGNtLrTGnduXEqOeRYn1C5BISjdkMnv5kBfS
	Y1WP43No7X+7H0/9fers0X9jtIaqnkAZgplVid/7na66MqBIOpePoaR/bzpOF+xK
	VOkTY/OpJ0l0lpN7uwzjs3iwalfDs6mM1jVRDhsjWWhbx+PkO6jFJK3DxTXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741881236; x=1741967636; bh=ohlqkXWSzXKs+RYrOj9CC2fAC+UOEy17oAw
	QMOWlENk=; b=qe97cxpRonfT91eWPhktTRjktuebOLb+Jmj4kqB57h6Qtg6Rm2p
	98lsp3FeXqTW/aDNjhICbX6WMkh8/QkU+C2n+y3o+KFLjEP9hcmpN5lCPbT9gBC1
	86My5crUe6L2KBodM4K58DnflAWa4axZy1bfoBBEGUD2r6b5thErZX7rOznj4+wb
	aPmpLm6eDWFYH+VqloqKDgxcGN9spq4wg1Q/xLqojcnOr+2uB8XZqQxUVpImSJoo
	TB57+zLWnbI5oIrGJqi2sXTzdA7jm1aE3/SH79XjGHYruPkUbN6w3/H6I9EY/eXL
	Jb1Dcqlvw+p8HtFUyfwYvyin7OnGxYwPDhQ==
X-ME-Sender: <xms:k__SZ5QFQh-aZL8Hsku3ASH3GWDjhJeUMJgC7Qo-Al8pzCfuDLkB8g>
    <xme:k__SZyx0hWSC5NATvPEwuJBvmMdPtnzTtVdBPzgEeouwJ_zzPalR6kB3Bb5Aw4eJR
    haDT86vxSoKSxcehQ>
X-ME-Received: <xmr:k__SZ-1WIutdBQmrQ_wZIFTm2I-pAs3hgYqHK9Fyd5QVjn3tUGwwTlfKTywmKsIx0SKuCncGq_61YE6EjkARm6Yqvhzl4UDj8rM6OyU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehithhoughorh
    hovhestggrrdhisghmrdgtohhmpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghn
    ugihrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:k__SZxBdF-XScx97qe3IybK5rlwtJPiI2m4d8d8rsST83OLrzoqRPw>
    <xmx:k__SZyjEkm8F4jW-AT1C4jdx-ARlX_kh_hq0kDyXSCG-UouE_ETL4A>
    <xmx:k__SZ1oRgGM8PYrxN9bVoHRrlOQN0HVqkkqiKrO8XLzxDz8QgD6BPA>
    <xmx:k__SZ9jQs-rRCXlM82LLnnNg1YFzKOeFKkF-ifKO2Y4nKpmlr4fo0A>
    <xmx:lP_SZ9X3SyYpeG1vpefe0Fzd0UnvSNK3UdkmFwdRn4pK8QcXQFQP1bNb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 11:53:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Igor Todorovski
 <itodorov@ca.ibm.com>,  Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 8/9] fetch: avoid ls-refs only to ask for HEAD symref
 update
In-Reply-To: <20250309032016.GH2334191@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 8 Mar 2025 22:20:16 -0500")
References: <20250309030101.GA2334064@coredump.intra.peff.net>
	<20250309032016.GH2334191@coredump.intra.peff.net>
Date: Thu, 13 Mar 2025 08:53:53 -0700
Message-ID: <xmqq4izxq63y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> When we fetch from a configured remote, we may try to update the local
> refs/remotes/<origin>/HEAD, and so we ask the server to advertise its
> HEAD to us.

Yes.  

I _think_ flipping the remote-tracking HEAD should be tied to the
case where we are fetching to update the remote-tracking branches.

> But if we aren't otherwise asking about any refs at all, then we know
> this HEAD update can never happen! To consider a new value for HEAD,
> the set_head() function uses guess_remote_head(). And even if it sees an
> explicit symref value for HEAD, it will only report that as a match if
> we also saw that remote ref advertised, and it mapped to a local
> tracking ref via get_fetch_map().
>
> In other words, a fetch like this:
>
>   git fetch origin $exact_oid:refs/heads/foo
>
> can never update HEAD, because we will never have fetched (nor even see
> the advertisement for) the ref that HEAD points to.

Good observation, and I actually think it would be counter-intuitive
if remote HEAD gets updated by a fetch that does not even update the
remote-tracking branches.

My preference is to keep the rule simple.

    If you fetch using the configured fetch refspec, i.e. "git fetch
    [<remote>]" without any refspec command line arguments, that is
    an operation to maintain your remote-tracking branches for that
    remote up-to-date, hence we also try to flip remote-tracking
    HEAD (if you told us to) during such a fetch.

If you are doing a single-object fetch (perhaps as a lazy-fill from
promisor remote), I do not think I want to see anything else happen
than that the single-object comes here.

Thanks.
