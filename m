Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DB1383A5
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738048634; cv=none; b=bXg+BgqzPS1AMkueDwf1Bp2bPJwCA6UbyXy1Q/MMMcuJbrFFYPspuL4dpavVs+fJiTd3Qmu0i8HcGeiB2KY3GSgjUYrN4ax2DvB2bWkwb62aBXvuPTlvM+eey34ttrbE4585NUAxOSy6F40ZmaLy0OohGq6geQYARDzQ3rewXe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738048634; c=relaxed/simple;
	bh=P0Zv/cOtibFmu99VufAHHa4uC5VriDCVCiwCMUiMIGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMCKyb/H8/flpPP4mIPbE2imKNxVPL2IUYK9a8y6KKkHTJRsfv0c/P3iUWB6YEhrcmMmPSE6pvCBW5gZmVXxZVht32i/CIpNW4zmqdIqqQQ4jEPLgNNlhSzeK//cTEqQWnc9X49cxeKWnUTnK74AyxPGMizpHFKrWUrd5p/Md4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hPGssMzP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MuRRvXNW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hPGssMzP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MuRRvXNW"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 998B41140241;
	Tue, 28 Jan 2025 02:17:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 28 Jan 2025 02:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738048630; x=1738135030; bh=U86OlkA9IZ
	7bjsO5xIPZYNzqLlJE3KFbzqDEn+kIVi0=; b=hPGssMzPKVtxVHD6V4yvRWPjqL
	UYIpxt8oc1xG3Ef0BDnFcWvA9UgHJkWPUxdBUhc/G6dAaDA54qqc/+eQhLs2QP8T
	NpdO1zvUiQQWZOMb3U6tc6ukJwKPVjsHDUYphTzVoywqq2kSJQqPMYjc6qsu1qBG
	8Yye4R5ytUzplqrsE24QMGqAKOwWNYYErkD4xaELK75KKYKcO7iJSpu0BUTGT18u
	aGMp7MQg1UPgskHL0I+m8t0UBFBRkctnP63LhezQIU7pdkR+X+lQA2NUreT9Y+LY
	VIZN3Ix8YykZuSOfjPNdQQLsp8tvtjhrAAsi7UQ2nKIgrcZirOkPxtItyeqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738048630; x=1738135030; bh=U86OlkA9IZ7bjsO5xIPZYNzqLlJE3KFbzqD
	En+kIVi0=; b=MuRRvXNWJbKav1Udw0CCJkcdwKUpX8JfdWlJ6X2bpJCBMLHS1Qq
	gqbKLecnK+2qqxstN/+r/XN0tgylNqLfKlvV8lErlYYA5bmwmRIOOkXr8pW8QofR
	iUDdx+epCJL3PSMzt0fUFPtlasJuAUZ7cEHovEKbbJt+Xh6qsTLgxij3kKQH2Y/0
	pauyM9wRXxNoj1UTUwdc2yqjTgyagBswbw7FTH9/6xxG6fnaigJMxU1kapiY6oQ2
	ynFm61p7Q2YNU5QS2+7ICe2UN2LupbYK9XlWhW8YDGdH+E0xnVlBofHl3chQ9nmP
	hm6xxRAqo5JrlPY++/88TCqlZsTUVencoOg==
X-ME-Sender: <xms:doSYZ1fCytPRa1ImsYGi2avohYkR4RGzcle_oZFypfkA-SLyn_rMsA>
    <xme:doSYZzMFGTqCThTdDJKjX6VIL1F6vvA93K9B3TDsA0DvsPAqZVCSPGPeDyWrk86uX
    1i5FVea0m0ZnJENWg>
X-ME-Received: <xmr:doSYZ-hgtzPmPvwae3r7QJBOMoux5h8bIc4P8F5rA19oo40MYrjgzdGDC4GRhVOWTdnb6z2PJs2FdZNVyPg0xwTN5YYnuUYQofx1jaZgZSY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeiiohhtthgvlhgs
    rghrthesthdqohhnlhhinhgvrdguvgdprhgtphhtthhopehjohhhrghnnhgvshdrshgthh
    hinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:doSYZ-8e6JDbXnDqd9a3ci_upyZPBXhq-YNRsGjt1yQ02UQGoqD1gg>
    <xmx:doSYZxuqN0EDqGJkgnx-4ilCGl-Sn7vWuFR6qoAnQklLt6FZc-EbqA>
    <xmx:doSYZ9FLUoMDnzqidibtfYYLYLw8eSE4H_4lKbk6GJn2AzdYvk9G2Q>
    <xmx:doSYZ4OfcW-KVXQk-88qmuoEialVr16HRkmaQ9XsIAD1QtFwaw-yTg>
    <xmx:doSYZ7J7mK8Retwb2JPO9g-S6OyqTiUVs4wgySdRU-qOEfu6ZY-AbZL0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 02:17:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f25d2ff5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 07:17:07 +0000 (UTC)
Date: Tue, 28 Jan 2025 08:17:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, Christian Reich <Zottelbart@t-online.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] reftable: ignore file-in-use errors when unlink(3p)
 fails on Windows
Message-ID: <Z5iEcjJpUI3spSrB@pks.im>
References: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
 <6acb9e8a-7014-4605-b8af-59c4584e9fe6@kdbg.org>
 <Z5ShoLCWREAsWZVh@pks.im>
 <267314c0-3aba-4f69-9f41-89392391290f@kdbg.org>
 <Z5c6VlsdNXwYkUsv@pks.im>
 <b9b548e0-e42e-4854-92f2-337a26f692ac@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b548e0-e42e-4854-92f2-337a26f692ac@kdbg.org>

On Tue, Jan 28, 2025 at 07:52:48AM +0100, Johannes Sixt wrote:
> Am 27.01.25 um 08:48 schrieb Patrick Steinhardt:
> > On Sat, Jan 25, 2025 at 03:28:28PM +0100, Johannes Sixt wrote:
> >> Am 25.01.25 um 09:32 schrieb Patrick Steinhardt:
> > I have a feeling that there's a misunderstanding here, either on my side
> > or on yours. It's the rest of Git that wants to have POSIX behaviour for
> > `unlink()`, not the reftable library.
> 
> Yes and no. Yes, we expect to be able to delete a file that was opened
> by some *other* Git process (e.g., packfiles during gc), but, no, we do
> not delete files that have been opened in the current process and are
> still open.
> 
> For this reason, I am arguing to remove the interactive part of
> mingw_unlink() and use the cooperative strategy I mentioned above. That
> gives us POSIX-like behavior for concurrent Git processes.
> 
> The interactive question is only useful when the user has control over
> an uncooperative process that keeps a file open for an extended time and
> can find that processes, which is either obvious or extremely difficult.
> As I said, I haven't seen the question since a long, long time now, but
> I am also the first to admit that my way of using Git is rather narrow.

That would be a much wider change compared to what I'm proposing though.
I don't quite feel comfortable with pushing for such a change as I don't
have enough of a stake in Windows to be able to judge whether it would
be sensible or not.

If Dscho confirms your take I'm happy to do so. But otherwise I'd prefer
to continue with the more limited scope, as I know that the behaviour is
unexpected and unnecessary in the reftable library.

Patrick
