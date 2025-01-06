Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663B1DC9BC
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177438; cv=none; b=LXpKfyZ342Rau12CzZeyms2zy7qVFBBVLl2GEu3AqcKQTfo3GdAiwIMp3DI8ewl/Cif2cgIQBsz+eI7X+CIYrUoVpknvKqwcMncLWq8QBziM9OLCrKbNoHhci6/9+eBbLAWX7d91cycvjbZ5DV/7mBrj8cBfXqazRmJSkuiKAMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177438; c=relaxed/simple;
	bh=J38Mo29l6IDLMufdwOa+Rn4LNimHuit0pZPlUYSRY1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jbxo0vdiHTY6vYMkOnb4PAcPMj+79PgS75uC+VAF4w08s+ZDkTZ9GeWKZjC0Grnn5E0TzjR58ROlh5/QyouGDRKGx8L/rwfo50w8eTXySdIrPGiOhz/kcoIZa+Emp8IdKaU+NfXCPRbLupdXcsaI9v+h7OAqPEJNBuk8cFps3pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CtrFOwYw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OeIANhNr; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CtrFOwYw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OeIANhNr"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D032B114013F;
	Mon,  6 Jan 2025 10:30:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 06 Jan 2025 10:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736177434;
	 x=1736263834; bh=4nLooMGEJdtgaL3nj4HxSn1Z2n4iK2aBympryX1xpRs=; b=
	CtrFOwYwBHvJzZN4LmhCZ/Ib4KnqyLZWac/is1ENuDq2WMmkFJfr0Ws1YlofOQFC
	Sn8er1aFs4WCjtjDm10W/w/UhrGJRVXJcfFwut4713t279u65aNLau1dDVFCuaPB
	UhqtFEttp/j66YHlz5D/b8ER+ByDDj75gB6/UC/1ufC4Py4cCQA4MqqQxWvPaViU
	yRthwaPMnhoAGKPvO3VZmvPfhd64/3XthgdJgSlHYqawf3gDJIytr9u5WxZUXt6J
	RzyeBsH/q0/7MqhsLIw8k4HU3K5DWtttyBBtZh1RJchc/Xkgm6T5ZuaSfll4PClg
	9tcmqCJ2nbgJd0oEifl9sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736177434; x=
	1736263834; bh=4nLooMGEJdtgaL3nj4HxSn1Z2n4iK2aBympryX1xpRs=; b=O
	eIANhNrz6Tewc9p4wIz2gqRBAuhs7Ee5rJYrio0siPInzx6oJFQqzw/bTO9OQTKe
	uPxe1qrYXtelma0rk+f9RLja11Z8K85+YzqE2Pf2DkydieEbloHjlsgVOMzthYgP
	v+ryK/RHcE0jGsrIvnvK9JKj5kRbmxoQozh76clCiWX1u1ygBd0+ViE8Zg19Pb2X
	TDZxP2IZtcfqT+pOpMDbkvYDXC9RmKHx0xD2yawujYqmD373lnlpP0RWcIYc1Ufq
	lQRvTLQCTOMlsyLeCstemEE3bbkQfM6UMVTOVSU+UJIdl1nZkhKgYxLCODP0sfqd
	Qoz0dk6UhCeqvssR+NnSw==
X-ME-Sender: <xms:Gvd7Z57-yuNHD2ABDMQqVCLoboQwRW5VgdW8fTznn92GDQVXZL3RPw>
    <xme:Gvd7Z255zmN3fAXQozMTy_5mTsumZ02sDKlxIBMRUBnoCYbq7mC5jQ7ty8K8Z9j5n
    v9NiJ6vHhmxdg0cFA>
X-ME-Received: <xmr:Gvd7ZwfgykyGCb4UB2R9z9KGiF3tYhlJZKudJrrHDRB-YKlkgsN34EDLnfJY16QwJwFeAhYYN5Kpattt5niyTcYceGOZgxVP7j3e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtsghovghgihesfi
    gvsgdruggvpdhrtghpthhtohepjhhuughgvgdrphgrtghkhhgrmhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Gvd7ZyIZ_9SHYFI7D-jKIwb2eacD4qHdCAOTIQP7R50QfPOZkCNKbQ>
    <xmx:Gvd7Z9IDzsQRLW-1tQbWuPVGOsZ2OASsDqzZWZb0DlBrNx_YfhM-gw>
    <xmx:Gvd7Z7zopAXj9uoUmgVxbASs1j2wKWkH2MFHpGxGEJqPo2WVA-PKUA>
    <xmx:Gvd7Z5KRPZiFGzxVC37lj9R2oTjB2bUwkaf8VxKw9licQj1E--_gBw>
    <xmx:Gvd7Z6EAZeoA28W4qLRM6jEOrDu4ki4_LZiRD0tlKkuDFT5s3zksMmwM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 10:30:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Chris Packham <judge.packham@gmail.com>,  GIT <git@vger.kernel.org>
Subject: Re: Testing for existence of a remote branch from a script
In-Reply-To: <20250106065121.GA8844@tb-raspi4> ("Torsten =?utf-8?Q?B=C3=B6?=
 =?utf-8?Q?gershausen=22's?=
	message of "Mon, 6 Jan 2025 07:51:21 +0100")
References: <CAFOYHZDQs-mftqLQn5HiFgBWcFN6Z-WDscJt=zVLRyGTo36=HQ@mail.gmail.com>
	<20250106065121.GA8844@tb-raspi4>
Date: Mon, 06 Jan 2025 07:30:32 -0800
Message-ID: <xmqqsepw0xk7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Torsten Bögershausen <tboegi@web.de> writes:

>> changes are fetched from one branch (e.g. 'foo') but are pushed to a
>> different one ('foo_incoming'). Our CI system runs to test the changes
>> and when they pass 'foo_incoming' is merged (fast-forward most of the
>> time) into 'foo'.
>> ...
>> Is there a better way of checking for the existence of a remote branch?
>
> I may have missed something, would that work:
> git fetch -p
> git branch -r

Or "git ls-remote origin refs/heads/foo-incoming" and see if it
yields anything?

The "workflow" makes me wonder how it would be bootstrapped, though.

When you add a new branch, "bar", to be pre-reviewed before getting
merged at the server side, you want people to push to
"bar-incoming".  Before the very initial update to "bar-incoming"
that pushes into "bar-incoming" and creates it, there wouldn't be
"bar-incoming" on the remote side, would there?  So "see if
foo-incoming exists and change the behaviour on the client end
accordingly" may not be a strategy to pursue.

If we wanted to support the "workflow" natively, the way we would do
so would be to introduce a protocol capability that allows the
server side to advertise:

    If you want to update branch B, you are not allowed to do so
    directly.  Instead, you are expected to push your changes to
    update 'refs/for/B'

and then "git push" on the client end would notice the capability
and turns "git push origin B" (or, more likely, the user is on local
branch B that is to build on the remote branch B from 'origin', and
"git push" with no arguments would do the right thing) into such an
update.

I am not suggesting that we jump to the above immediately.  But the
reason why I am bringing it up is because The "how would I see if
they have foo-incoming?" smells like seeking a way to implement such
a custom capability advertisement outside Git.

A few random thoughts.

 - Would it be useful if we introduced the ability to advertise
   "custom capabilities" from the receiving end of the connection,
   that does not affect how the rest of Git behaves at all?  It
   would be sort of the reverse of --server-option, which is a
   mechanism to let the client to tell the other side out of band
   information that the rest of Git is oblivious.

   The other side of course needs a way to inspect what capabilities
   are advertised.  For "--server-option", I do not think our server
   end does anything special, but other implementations can act on
   them.  This new thing can start the same way.

 - If this is a poor-man's custom capability advertisement, perhaps
   the server end can create a ref "refs/capabilities/incoming"
   (whose value does not really matter) and your client side can see
   if there is such a ref with "ls-remote"?  That may be a more
   robust thing to do instead, perhaps, as you do not need to worry
   about "What about a new branch 'bar'?" bootstrapping issues.

