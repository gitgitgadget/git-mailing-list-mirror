Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC77234677B
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840399; cv=none; b=nlZgaKVxPjgKt7bjnkj1Xfro4i7Y38xjwAvQNa6SFuhjmfOFIe9ROu8+h0NCHyxUrQ4VvqJmYSpZLvr2n89D1LfEzTXOkM6oYmKxh7mNo19EMlqZwfbR5zDo6ls7gtwYYgV7X/wDdv9w6dHKM8DJqNR7uLn2ZSIt929grcAdAGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840399; c=relaxed/simple;
	bh=do7I6J+w4w5oD6oZxNVaRho6xEku/fwm2YFH2vHskSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD19az8qi1JYwQ8qA10/qZKX4XKIHgaBP0DQvSn7aS1kUahQbhDZTfOkWqxSaQpNjqNJGtYC5N07a520D1MzIdLxioHqHwnDP1wq4xwh9v8RScn8ArYWtHCvWL2h92nj0/sk6ZOUacgcot6A1Q7nsm7nQ+fKYm6mjvp5VCgssVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OL2OPmyj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T2WvzWRw; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OL2OPmyj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T2WvzWRw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 048F7EC0569;
	Mon, 23 Feb 2026 04:53:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Feb 2026 04:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771840397; x=1771926797; bh=edURVilcVb
	kcVFEvAiIHiQ5naE8IrcVUrWiZquYcCOc=; b=OL2OPmyjUkQ9LeJIFBGfq5mD68
	/BhUzYSA5ht/9umIFFTv7giDf+APZJxGRWtFxZ1ddhP117sxnk6N9A/MPAM+aZYJ
	/TnNPZp48YhvGT4uhL/FuVYf6W6QkzkMc9y0cY6mTEYTo/mxsiMKdNLQG90lLMT1
	QfgUp63cAD7IyaKOiHv+6bc5ivbjNBAx4D6GAQEiLxBs2wAuskRnrv+DoloZppB8
	IPyxqU+2Vr6nVZLooZQQQ5PXID7lQOaNjkwuPACo/wWLQkCrCpJEBK9MBoIE9SiU
	bwIKhXDTVyc5HX4o96Ah4ZwIaf41h4XrH7s6AwFUxURKKKOVioQXZD+kJLIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771840397; x=1771926797; bh=edURVilcVbkcVFEvAiIHiQ5naE8IrcVUrWi
	ZquYcCOc=; b=T2WvzWRwBZzFEHYV+EKivsjMTxxmq6XHrxOVarny+GOTtmmNyw7
	lNzhZWWr3g/vytLFtJP9eMgDkFU55oOmL0y0DV9joe+sudultOzZSXp7f/U6ew0a
	GFiAYyoaiOv7xay12T02htHwEwqne2kGsMez38BBuR/CSgccbVYeXDPOWSecDNQq
	vfJdWqQBTTwLucA+yMHcmCVwG2WlC+YlW/rla7iwKSf+PfyJV9io+EbbEfP2MuQK
	qBZmNdiGHyhmAimWbRvzLl29cnZ9MFooSagSQUDsiO7f0+4bE6Lyml1v1U21j0/G
	YNxH/6XsNbXs3mFi8VjY48g8x7cN8Xi5V1A==
X-ME-Sender: <xms:jCOcaVvjJlPjx3WF_jBMPWgQjAuxCaxQOY0bPbcs9KLlBsQzgEtqeg>
    <xme:jCOcaV6HiIsI4hM5sIkwt54sT7q9XpW5Ior9GBMKs7OkHOfCQmOxoCMqpe3dw11X7
    BtGZliO2zSncK9cIBiET90Sita8tAf-I-IOMniVBWhYN1-0tSLPFC8>
X-ME-Received: <xmr:jCOcaWIf5pUQjX00oONOr4_GcNkFUPoqHNm0_-8aqC5KuE-0GXI1VuZzXYqTA6EEZut1mkFy9P4_rVnCGfQke_4LP3ST3qkJIN3JF9rhTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeiledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpefhhfffveefffevieeifeelueejueekuefgte
    fhkeeggeetkefggeefueffuddtgfenucffohhmrghinhepsghighhfihhlvghthhhrvghs
    hhholhgurdhnohifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jCOcaV7sT2biApBiAQGCt6cY0MeXinNveUCeJ259gi56NpuQZtL8Vg>
    <xmx:jCOcaZyTbTPxEK3-hj04GlRV5FZVlnEU0yMOYCHxsTT2ekRw3du0gA>
    <xmx:jCOcaZaCp74q2spuJh5t2UVVV2TVhhPtTUTaLPK8NZndzluyBX7F_g>
    <xmx:jCOcabRnwJDGP_Kyw4_yX1KCENFOwLDPysx7fE3u3Fa71vqyN6TdQw>
    <xmx:jSOcaSkbKaXV_wvxMSEdVVpJTBwKDt-izABpfImNeM50CXK53JPuvfw_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 04:53:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fea18664 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 09:53:15 +0000 (UTC)
Date: Mon, 23 Feb 2026 10:53:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: do not loop infinitely when processing packs
Message-ID: <aZwjiBfHg4tdauJu@pks.im>
References: <20260222183710.2963424-1-sandals@crustytoothpaste.net>
 <aZwTPfmyrFp-QAPq@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZwTPfmyrFp-QAPq@pks.im>

On Mon, Feb 23, 2026 at 09:43:41AM +0100, Patrick Steinhardt wrote:
> On Sun, Feb 22, 2026 at 06:37:10PM +0000, brian m. carlson wrote:
> > When we iterate over our packfiles in the fsck code, we do so twice.
> > The first time, we count the number of objects in all of the packs
> > together and later on, we iterate a second time, processing each pack
> > and verifying its integrity.
> > 
> > This would normally work fine, but if we have two packs and we're
> > processing the second, the verification process will open the pack to
> > read from it, which will place it at the beginning of the most recently
> > used list.  Since this same list is used for iteration, the pack we most
> > recently processed before this will then be behind the current pack in
> > the linked list, so when we next process the list, we will go back to
> > the first pack again and then loop forever.  This also makes our
> > progress indicator loop up to many thousands of percent, which is not
> > only nonsensical, but a clear indication that something has gone wrong.
> > 
> > Solve this by skipping our MRU updates when we're iterating over
> > packfiles, which avoids the reordering that causes problems.
> 
> Right, this makes sense. We know that we cannot modify the list of packs
> in case we're iterating through them, so `repo_for_each_pack()` should
> indeed skip the MRU updates.
> 
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > I realize that t1050 may seem like a bizarre place to put this test.
> > However, I was debugging my sha256-interop branch and why the final test
> > calling `git fsck` was failing, so I placed a `git fsck` earlier in the
> > test to double-check and discovered the problem.  Since we already have
> > a natural testcase here, I thought I'd just place the test where we
> > already know it will trigger the problem.
> 
> Makes me wonder though why none of the tests t1450-fsck exhibit this
> pattern. I cannot imagine that there is no test there that doesn't have
> multiple packs. *goes checking* We actually might not, but when trying
> to come up with a minimum reproducer I failed at first.
> 
> This is because ultimately the root cause seems to be a bit more
> complex: we don't only care about there being multiple packfiles. We
> also care about "core.bigFileThreshold".
> 
> Typically, we don't execute `find_pack_entry()` at all when verifying
> packfiles as we iterate through objects in packfile order. We thus don't
> have to look up objects via their object ID, but instead we do so by
> using their packfile offset. And this mechanism will not end up in
> `find_pack_entry()`, and thus we wouldn't update the MRU.
> 
> But there's an exception: when the size of the object that is to be
> checked exceeds "core.bigFileThreshold" we won't read it directly, but
> we'll instead use `stream_object_signature()`, which eventually ends up
> calling `odb_read_stream_open()`. And that of course _will_ call
> `find_pack_entry()`, as we're now in the mode where we search by object
> ID, not by offset. And consequently, we'll update the MRU in this call
> path.
> 
> With that knowledge it's kind of easy to reproduce the issue: we simply
> need two packfiles, and each of them must contain at least one blob that
> is larger than "core.bigFileThreshold".
> 
> Now I agree that the below proposed fix would be a good change to make
> the code more solid while we still have `repo_for_each_pack()` (I plan
> to eventually get rid of it). But arguably, the above logic is kind of
> broken regardless of this: we are asked to verify objects in the current
> pack, but we may end up verifying the object via a different pack. So if
> the same object were to exist in multiple packs, we might end up only
> verifying one of its instances.
> 
> I've got a couple patches in the making that'll fix this.

I've sent out the patches via [1]. Thanks!

Patrick

[1]: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
