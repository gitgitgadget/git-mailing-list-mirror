Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C9275AE1
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601554; cv=none; b=sMW97TkZzw475FvfTG0LbJ0/khwX9PgNFHvn/b5nMV0DhVSCpOl5OH2fsae8GKy55/ROKQfDwR++PHqrzr9Q40bd+Z9pUv+zIsmjjuWs/wlV+mmVqd2RNY83FG2sPWM7rBVYElHCM/jfw3chdmHuQCHMiQO3Ronbrq5WAOUIx0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601554; c=relaxed/simple;
	bh=PVmgjO6VoUU/BnGwjNDD5DYfU0SaJozsahSQOGs4vI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQxkFtqCONSVcQDdA0swsmTqDbKdOwUoWiaNTzxmC50rYIaD+7aRXLydYG+sg8XfqEelB6xliymOqKc+GvpA2UOymWIaDmT657I4HQyi1gOP+QotfUhxSq/wMnwuLRiBYgYN04VjFfXTkWJH7RSGXB3jSA8BXlKfytZdoennUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i1285+Fs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NQumibbk; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i1285+Fs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NQumibbk"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 57D3E7A028A;
	Tue, 19 Aug 2025 07:05:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 19 Aug 2025 07:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755601551;
	 x=1755687951; bh=ut1TrefNr7ZKOW+S3Zsct95IWXqWG3krp4PKdT87fpw=; b=
	i1285+Fsi5JmOxpvUNadYbFCHbAOguRik2XYUzZgYLsVJsjgflqtlyisUhiYJ6qe
	TYczdYZ8hjngXfn1b9ObE6jzlXNqZQn4+8hy+XjU0Sr2v3KFov+CYQVnfW3amiOE
	ivpFW94vD/Y+dyip2GWFsSSnTjrjMn0nSgG4d+KaTEKCb9IPcuWZndrYHq4pLKO7
	T1HIWdN2Fldqi2S7EOUuS2jxbnZyShsEYiinGhCLb4xt8BRKrDRx+Z/c5OYcUlTt
	jzIY3IClUqDgx4mXXOVrqyPP8uJxXOCxmMVWJ5JtsDhOrwLa7sLEWnMDugOO8i2l
	QVmYOhPeQ1CYIdQNvtMbAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755601551; x=
	1755687951; bh=ut1TrefNr7ZKOW+S3Zsct95IWXqWG3krp4PKdT87fpw=; b=N
	QumibbkVlCIKsyAidwkSqvqv4lUiA6pAnu/6Cj93223qjrFWvKUWnTPDbhKKmwPI
	oFSbiZh4cyYcAeyo3GG2FMV5OCY3bnkzQBUFI3F2t3bLMc6u8CA0Gqte4MrvqGei
	c/bXhiKT1ggpTfV3qMT0UPEfUM1Y1DYSTYE8rZV90foTa93Nk0BhrYxH0eaPKcAz
	lCU3d6Cc4hM3rSb2NSlb384VxBPYcwMDYIAUpU1VPE7eoz5cP7EZCJdkRjYU11Ct
	eHu72FBeOB5OgAByteaqgapZWgoBIPOm6KHJ1Kform62FNHzSi4kqN9isZwMdy5w
	kGqxz8lGLfVb/S71zsmQA==
X-ME-Sender: <xms:jlqkaOMsoxGOXLBDBdp4WuCp4dNzjhgjeXC8CzlHOxFsbHa1GCBs3g>
    <xme:jlqkaGZEUwV4yKcjoPYuoDItAa6fq7o2f-PLBVtA0CKGZYczGV9fv0koCs3j2ue31
    a1yod2guJXDNZQq9A>
X-ME-Received: <xmr:jlqkaE0RhuSfAdOHo_w6pldaKgBT76JzxzhTQ-JOLfi8lQP1T9EWoGDRvNgJ0CzEq-fq2bWIQsacJpSUXk92NvnA3XbQaxc8xf2Uf1JJwTbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetheffvddtleettdetueeukedugeettedutdegueeukeetheefueevvdeitddtveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrughivgiiqddvtddtieesrhguuddtrdguvgdprhgt
    phhtthhopegsvghrnhgusehpvghtrhhovhhithhstghhrdhprhhivhdrrghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jlqkaEefhwGkzn_bJatjFkeewPT48VBXRf9_q6PHKtltoE2z1nGbcw>
    <xmx:jlqkaNGBeQIjTJNcpyzMzxwKQgnHnQRvG2WRvyMYmCJkNCG0Bh5IZg>
    <xmx:jlqkaN2eHMbKS2D_xumx889TJYB7DMy95LKz-U8orqc8bQ8drTLlUw>
    <xmx:jlqkaFlcR7CbETxKSts8n_Z6Mvq8D7JSUisAT6b7qUHnR5p2BK6Cbg>
    <xmx:j1qkaJ1qv76Zr1wUeFGAbLBgr7XmG4-UytQBnCtMZxrbfZnX3SxJIxSs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 07:05:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 757c4658 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 19 Aug 2025 11:05:48 +0000 (UTC)
Date: Tue, 19 Aug 2025 13:05:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc: "R. Diez" <rdiez-2006@rd10.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: Graphical tool to merge and reorder commits
Message-ID: <aKRaiaym7KsJ2Ojg@pks.im>
References: <4398af77-3183-4ac5-9a25-aca6289d8c8f@rd10.de>
 <xmqqplcsiimq.fsf@gitster.g>
 <aKQws631-giQS5Qr@pks.im>
 <aeb06554-77b5-4f07-a659-7b6825d6f3e4@rd10.de>
 <260a97ce-2ab0-4920-9cea-078369c42f74@petrovitsch.priv.at>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <260a97ce-2ab0-4920-9cea-078369c42f74@petrovitsch.priv.at>

On Tue, Aug 19, 2025 at 11:51:42AM +0200, Bernd Petrovitsch wrote:
> On 19.08.25 10:35, R. Diez wrote:
> [...]
> > I guess some "git history squash" command would be useful too.
> > 
> > This is what frequently happens to me:
> > - I commit some code changes because the current project builds and tests fine.
> > - I start the "compile all projects" process, which takes about 1 hour.
> > - In the meantime, I commit other unrelated changes.
> > - After an hour, I realise that a silly mistake in the first commit makes compilation fail for some project.
> >    I fix that and I trigger a "compile all projects" again, which takes 1 hour again.
> > - In the meantime, I commit yet another unrelated change.
> > - After yet another hour, the build process notifies me that I made yet another little mistake, and yet another project fails now.
> > 
> > The commit history looks like this:
> > 
> > - A - B - fixA1 - C - fixA2 - D - E
> > 
> > I only do a "git push" when the 1-hour compilation process succeeds. Before the "git push", I want to reorganise that into:
> > 
> > - A+fixA1+fixA2 - B - C - D - E
> > 
> > I know I can work with branches, but branches make everything more complicated. A linear history is easier, especially when you are working alone. Besides, it is not often that I make such silly mistakes. ;-)
> 
> - `git rebase -i HEAD~11` (or so;-)
> - move fixA1 and fixA2 under A and change "pick" to "fixup" for fixA1 and fixA2
> - save and exit the editor
> 
> And done.

It's not really that this isn't doable. It's just not all that obvious
for people who aren't experts, and it's not a straight-forward thing to
do. I think the Git project could certainly use better tooling to make
common workflows obvious and easy.

Anyway, the patch series is out now and can be found at [1].

Patrick

[1]: https://lore.kernel.org/git/20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im/T/#t
