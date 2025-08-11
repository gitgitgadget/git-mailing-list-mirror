Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AE9311C3E
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940864; cv=none; b=lUej5AwDuhouffmIUCSVekqMKe0dezML4MPScNSZtoos5Ew1eljPdpf5LYsmBH8TCyM4MEf+LetJqqkcLG4AhMHqDHVHeISYDbqWHLXQrs/H7sIn5tmx3JRFQo2/0pnrz0zZaglMVHS5cUmYTmO5ph38s9qqq3mqlkSiVmTQ8+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940864; c=relaxed/simple;
	bh=exMkM8scp8SgBv0OCnAHAYK8sUpcBw78q/tn+OYtibA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uxuLRfxnb2gvlCQbFmlKxJRDvohxB75fRUsBKSwPMzw6UQUoBSvCzaH+x8S69YPfVFjk84TZT0QlC7mR/ygInnl+s8Yv0uvw+VF4ikpGoCZClaalNFMyCVMMxEohxuBTB4T77eJaNTo9iYTz4ms3kdbS3c31rhK0XLOl2JnzovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=A5P/DwOg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eYaBFalg; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="A5P/DwOg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eYaBFalg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 259F27A010F;
	Mon, 11 Aug 2025 15:34:21 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Mon, 11 Aug 2025 15:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754940860;
	 x=1755027260; bh=nmd23dxleLBdILNLoh1D79Jqs1daACuLlSNdcHkQxy0=; b=
	A5P/DwOgvPF7GLI489sF1A3Eugv1KE00f4nxze8AkgtDuvpCeu+2gz6p3K4lj0/J
	c4YYZ1o3r5e9GQCYn4kFtXKXfUiO32St4UZOdb4tYZUiKBFSImdXjHkHlzFDOvRL
	g93aNKgcppCv1uoCBrM0keGTT3UVKF76y3mgX2ReYmMc5CwG+paEnS3X4uRfhz8H
	XILKNpjgCNAeioP+phEsmuSfaBYeh1tOXQTWcsXR6H4xg5A1SsyXriA22fFJRzw7
	8D0yLoQYmm72d53gHdCf6SqOww5L4Y4a2uWTjb5pY+DHBj+pI1DDMlyIyjqMrZsd
	n6X9yet1aeW/GoP7OI+0pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754940860; x=
	1755027260; bh=nmd23dxleLBdILNLoh1D79Jqs1daACuLlSNdcHkQxy0=; b=e
	YaBFalgh+z7kZNhZy1av0AccjtV3KQD+1aGtd55egCJfUYuSX7ulKRU+GDLD0/Oz
	Wr+sfCxm3z5vacTObL6SfUU28UAqBqakMhTyByoSxpf1QMhBzN8U8TuFY2yT4IxE
	KZjb3njLksnAy2e8mHBfeEFaWoh5UQb3RxaU/nViaechL/Smim7qdlArLpiaBn01
	MA/lLPXK7RWJtnXG5HVUj0LjDhABmnmju1UHmn3mCMpjoBh18B7EuazpctQXBVda
	qvis85Bv6+rJqDpXgNcj4rjS2inp2bKt7KFjY7xShA+1+54c9uKs22P80fJ6JYCK
	3DmOYSCSaqwZSd/1AUwUQ==
X-ME-Sender: <xms:vEWaaLQMei1PglyoeZFFQ4ifJ-7p4XyiNnw3RnBjsGTPw5UoJOQPxw>
    <xme:vEWaaMw8RxqAVI82s7jrWHXJLBO97Z7Z8Cq0Kk32QwpmNW1p3lMJVHIF_8ATeaMaS
    kkqZzCiQhHnQ7O9cW0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeffedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:vEWaaFZNatL53EOM-UdydT8dBD3j8bvNXgonfEMzXtM0oS2cGm3IfA>
    <xmx:vEWaaDStZ2LfEST-nJ7R90NYg4UX4hn4Lbvo2RvfCclD8b2ilA0t3Q>
    <xmx:vEWaaE74QtrFFs45_gStPYIyFurwE733fmT5-wUQlWdJJKonCtBjFw>
    <xmx:vEWaaAzXVBOyJXRQ2ekBPBsPNe3lcGcOlm4ZOf_a3l7JPue-auDWVA>
    <xmx:vEWaaFbTXZOoNW1RroRFNP0FCrWo3y1YEpLLgAXZjkFgVtbmcYknYVqs>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9865E7840B1; Mon, 11 Aug 2025 15:34:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T08f282b3dd0e28a1
Date: Mon, 11 Aug 2025 15:34:00 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Patrick Steinhardt" <ps@pks.im>, "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <2c9d7fe5-4026-4143-9c56-f5c56f4634f3@app.fastmail.com>
In-Reply-To: <aJmt1fv66bO_ZMpI@pks.im>
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
 <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
 <105a65e6e7121ac6a9a8a1d0b4f3217495a9f5e7.1754702057.git.gitgitgadget@gmail.com>
 <aJmt1fv66bO_ZMpI@pks.im>
Subject: Re: [PATCH v4 5/5] doc: git-rebase: update discussion of internals
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Would it make sense to convert this into a bulleted list to further
> highlight this multi-step process?

I like this idea. I think we can combine this with Phillip's point about
"--reapply-cherry-picks" to expand the list a little more and remove the
paragraph at the end about how duplicate commits are skipped. ("If the upstream
branch already contains a change you have made...") I think probably the diagram
can be removed too, I'm not sure how much value it's adding.

1. Make a list of all commits in the current branch that are not in
   `<upstream>`. This is the same set of commits that would be shown by `git log
   <upstream>..HEAD`. You can use `--fork-point` or `--root` to change how this
   list of commits is constructed.
2. Check whether any of those commits are duplicates of commits already
   in `<upstream>`, remove them from the list, and print out a warning about
   each removed commit. You can use `--reapply-cherry-picks` to include
   duplicate commits.
3. Check out `<upstream>` (or `<newbase>` if the `--onto` option was
   supplied) with the equivalent of `git checkout --detach <upstream>`.
4. Replay the commits, one by one, in order. This is similar to running
   `git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
   are handled.
5. Update your branch to point to the final commit with the equivalent
   of `git switch -C <branch>`.

I imagine actually #1 and #2 happen concurrently, but I split them up because
it felt unwieldy to explain them both the same point.

>
>>  [NOTE]
>> +`ORIG_HEAD` is set to point at the tip of the branch before the rebase.
>>  `ORIG_HEAD` is not guaranteed to still point to the previous branch tip
>>  at the end of the rebase if other commands that write that pseudo-ref
>>  (e.g. `git reset`) are used during the rebase. The previous branch tip,
>>  however, is accessible using the reflog of the current branch
>>  (i.e. `@{1}`, see linkgit:gitrevisions[7]).
>
> This information feels somewhat contradictory. Should we maybe say
> something like this:
>
>     When starting the rebase, `ORIG_HEAD` is set to point to at the tip
>     of the to-be-rebased branch. As `ORIG_HEAD` may be modified by
>     various operations during the rebase, it is not guaranteed to still
>     point to this branch at the end of the rebase. The previous branch
>     tip, however, is accessible using the reflog of the current branch
>     (i.e. `@{1}`, see linkgit:gitrevisions[7]).
>
> Note that I'm also dropping the reference to "pseudo-ref". ORIG_HEAD is
> not a pseudo-ref, as we have clarified in 6fd8037564
> (Documentation/glossary: redefine pseudorefs as special refs,
> 2024-05-15).

I like that! Also very happy to remove the word "pseudo-ref".

- Julia
