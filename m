Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530BA3346BF
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651472; cv=none; b=ioXkLACjPKLDkGC9thJAKDsKpcvgzwagDSJrv9evbxARSX2G5bkONetgDt52je7At9kvHxQWe4tosTaxKNJrnrKTov6WfdNJtRExopRC8WlMSId8ex7G5K0zkzenRVrMFD/0RDp3I3lr2nao5XIZM7bPlV3kQXd70s39X+awP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651472; c=relaxed/simple;
	bh=8Qo1NcsTNvqAGgqDB4jbf81cgsuQcdCfUUhydbegm4k=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nwpVc8SajWsniHuor8hpc5fry8c533Z9594hqA5T2VMjA+WAYv3ROvFnwRxTc2If6TPaWQsFBcyADtBZmegTZeZ2k4xOwMZ5pNt70Tm3HMpMJC19u2wqRdnqQfGC99D0pRg9Q2JkMj4MxJBFNQDolhIgRb5Bbp1+uFDvyB0Df2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=T2V8JMew; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X2jWnWfX; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="T2V8JMew";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X2jWnWfX"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 91B327A003E;
	Thu, 16 Oct 2025 17:51:09 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 17:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760651469;
	 x=1760737869; bh=P92qBqfghR9jPyj9DfFIAKJXR4oVihJ1HFYmmZibz1Q=; b=
	T2V8JMewlIh4eGJHGzjbzCJRnR9BrIuXMqoKi2BSi0VGlEGPpejMXqcVTek9ZDqm
	ehthR+L+hYg30EW0LPrSiHopRU3LpDIr2Hq0MNFsikkvs62E4xbZ/SIA24DPKehl
	yID4fClF+NP2teFAne3+4zgSiqAMI7C8yJS0f1fp+PbZaHAE3xUAGC1OvBCtwkEo
	87aS/pdqSzUWx/7O+/KQvp2U/88ABNWtwssJTQvr9/GScVfiC/HR0kCTsu40gIIB
	z/rq19konZl09KIEzcpL1q4BuWWZ32LnjMjb3jCMS2CXMqH7DUgWlBeqDUVpzv0D
	Jf/PQccDqicuyKiV5aGa3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760651469; x=1760737869; bh=P
	92qBqfghR9jPyj9DfFIAKJXR4oVihJ1HFYmmZibz1Q=; b=X2jWnWfXCcTDW0obj
	TfzWvdyKJTpXnNBUl3bYDzCzovMxrzKMQ0CRhAw6n1kACNShwuzKZ4ApXiQk5Xzp
	GtHurtHuODVYvs6ceWJDcdOuAvrmzzX1hU3yA4Nqv7YgE5FfkT5sjm4XKFRHRXmT
	BH2tSKRaKtHddRyASdXl9PMyxYJTMOy9zDDNGmX8v6u01I+pl6BD8rShQ1YgYTgQ
	zF0LNvY221DnULjy5/DQcQdfD4Xql67lOXspKJt3iqUvad9O4FxY4fQqhsj4Vx/W
	u7FrBw9Zvc06VfTJ502OqNdciY3cg0uHkf6WbuCgaxxQHKGNNxgjrcU10+n7LFIV
	zQgEA==
X-ME-Sender: <xms:zWjxaDFqw4iXaSyi_XC_hhj0B3CB6EZpjzbBpMynqo4md-EhmTUfsrs>
    <xme:zWjxaLIQVwtfBgc8UVVfpl_BgRfsOn6QUeKPPFtuasHceIpEA4S5oimYCKTnRkShk
    fNnnO_zhYijpAU48fr0gHdfWitqAGP9ejf7L9kTBs1ZNKRh73viWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepkeehudefhfefheeltdfhjeetteffkefftefgleevhfffleffuedv
    vefgfeevieeknecuffhomhgrihhnpehsvggvnhdrlhgtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zWjxaJy_8LkT6PizTxoi8GrBTfxVeJ-F_CU7nL6LwbUOl-xtXscm9Q>
    <xmx:zWjxaHMGUoufWDUKDxWrQjqw06ZRFu9y_tBMVpMSFbdkQdmyUA5wQQ>
    <xmx:zWjxaK6Ogpks3vJgbAv65OuC36fCKEkwvWWXz0yyYiRc-VpoTe2bvA>
    <xmx:zWjxaIP_xrLldRViPI29y8mgFzIrmVy322UfP7-GCazIbLKCowmwzw>
    <xmx:zWjxaG5FKb64Wh8AwECbZF2S3ZtjmRrs3LkHc9RwcLTnNZKrtUQd1mni>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2A5591EA0062; Thu, 16 Oct 2025 17:51:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9fdyvUqFqiR
Date: Thu, 16 Oct 2025 23:50:48 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <b06f2539-c2d9-4a14-b08e-686367f52154@app.fastmail.com>
In-Reply-To: <xmqqfrblvzn5.fsf@gitster.g>
References: <xmqqfrblvzn5.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Oct 2025, #05; Tue, 14)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 15, 2025, at 01:20, Junio C Hamano wrote:
> [Discarded]
>
> These have been kept outside 'seen' for some time, and were removed
> for now, until they get resubmit in a shape that plays well with
> other topics in 'seen'.
>
> * lc/rebase-trailer (2025-08-03) 2 commits
>  . rebase: support --trailer
>  . trailer: append trailers in-process and drop the fork to `interpret-trailers`
>
>  Has been expecting a reroll for way too long.
>  cf. <198826af571.62b85cb31711042.2415806544948206668@linux.beauty>
>  cf. <xmqqiki7qasu.fsf@gitster.g>
>  cf. <1995bf77c93.3eeb42b4972717.3783775021840050008@linux.beauty>
>  source: <20250803150059.402017-1-me@linux.beauty>

This is back now.

<20251014122452.1851103-1-me@linux.beauty>
