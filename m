Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8791170A11
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759870921; cv=none; b=lR0Yn17sVUiE2ZJ+BPoAgWxipHrFQGoQlZ0zYJanzwLimVuyVdmX00UT3QdqNX61XNGbg1mif+jqs/8otAia/kQupvd5UXveIG5qiRN3PIVhFOywtHUwkmqT668dsj/1XadCNlRIZv07Uh6+ommX9vB82SHSdx7rWw09dilj4pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759870921; c=relaxed/simple;
	bh=Kw6/Kf1H23EwYFv1N1h8njTOn3KRKPVu+T0I/ts5RYo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iN4qsyInPP/DhyRkG6RFDh4HWHS3OSR+tCxFullDjPkeLE5dRCXEAYkpwqUYhU79Ov3+Hd8wTMHyTn5Uk2n8PjSwvH8HUUWerVuA5yxzQtM1CwYkDB50zxbLyvYPw/khaRs1DLKjscMxfowdCSAZTcjnE0uIZdeDEjPHPwuOeZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=EurQzzIJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UrWtA70R; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="EurQzzIJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UrWtA70R"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CC404EC0136;
	Tue,  7 Oct 2025 17:01:58 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 07 Oct 2025 17:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759870918;
	 x=1759957318; bh=Z6Rq/j8qkWF76umDoS6I7t2r9KXVjnNVjVjqsCUUgjU=; b=
	EurQzzIJ4Af8GFE781nOx0xzoCDWa6+aw4G8Sqeu/barJI4wXrvRxzgcN+IIa4il
	068SIa3gkkbpzbB3ReulKEelg1v7jD7pbJqCEMu6mW2jJwevyL0BeqfsOH3vb5MO
	a5URdoYIfMwU2Waq8WiTKGaC9FjKs8fvkxU1h85eyKcXRw74IMg88u1pxmu7nuv9
	8d7Kw671eC6+dnOlDM8BxlSYCTAoKT2OyY1XMGtnzgJ8h8UXE1vxhJASXQ+3zJi8
	PQqpMkZUHhbcLrwJIvw97wcz2LCW3wplHysyI1c54Z7yzDNhKBrL6JBR1xYPvtBo
	toh8MSZlf5j/kzzxXZAf2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759870918; x=
	1759957318; bh=Z6Rq/j8qkWF76umDoS6I7t2r9KXVjnNVjVjqsCUUgjU=; b=U
	rWtA70RS2cGXwHWdSnoEUcxZNnpwTIbCSM3n2d23mCepXe7kYA3Ku78E9KM9O1Bx
	YI8AAliw8Zjxz2GeZPaddBGQs10BBjEPfGZlOSZhT4HP1CXVTh2NghUANcYQfK/P
	9KL5s3vklFT/EigXBBw8wO3YUcfkQcW5AQsS/PL9Y77+VWNor15P418hTVqucjT1
	19I8yvFYwlqlDL8DmZL/+KNfoSocke6a76PQ9VWXmwSj+M3yAvNQdqBNo0666Y3t
	R+jYlDFHtIo63uUCMOYkzas9+lS2cuorkyxHeu8oYSLMpMMVHK7MnMc33yD//880
	pUVDiCRJhcGVsIVMJOjKw==
X-ME-Sender: <xms:xn_laGCS_iCdCaeoK42WCEmhLuKW5OANrzDPXUr20MT-Ye7gWSElgg>
    <xme:xn_laLVm9c8CbYEsIAhiz9ECOsGzrnrBP5MgUW6OX3vD-zeb43z9Y3X9FLPF8k1nn
    QhaLEtEaBzfN5E-cS81VUc5uPOG_L6YqBZfhdoyOP7THI9P9WCGKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epfeeiieeggedtfeekjefgvdetjeffhfevuedutdetvdejgfegveffhfelgedvvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xn_laLcEnNdWpOADCa8MVvmv2x9w6lVjKtweZ7YfJRwDmfzuVW3iAA>
    <xmx:xn_laI_vKO20PGNLanNWj5uYoEOo1fuNXOURZ2zLSKhRaQq1pC5Qtw>
    <xmx:xn_laHn13QWns25tJB-MsI76F7FKNhMqPPJu8zh6FzmsgzU3G9lVig>
    <xmx:xn_laK-7KS5Wj2pTHmE9f9bqpmzmA_jtG0__TLSFpZUJnU1EoW1IsQ>
    <xmx:xn_laM9ekrIlrRqgBRmqt1XP96sb5ySj9gUQg1C876Ig5DTqvTuwyDN9>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 76C9778016E; Tue,  7 Oct 2025 17:01:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Arp_fDZwitDF
Date: Tue, 07 Oct 2025 17:01:38 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <74f8a51f-f62d-4f85-89b0-f701338c7550@app.fastmail.com>
In-Reply-To: 
 <CALnO6CDpduG3UNMAPCBx8+du1k8Af6A-=kxhRuzooyQn8mZhzg@mail.gmail.com>
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
 <c7f09c2bd32baf9e1dda355656bba811484e90a0.1758656702.git.gitgitgadget@gmail.com>
 <CALnO6CDpduG3UNMAPCBx8+du1k8Af6A-=kxhRuzooyQn8mZhzg@mail.gmail.com>
Subject: Re: [PATCH 4/4] doc: git-pull: clarify how to exit a conflicted merge
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Sep 24, 2025, at 4:29 PM, D. Ben Knoble wrote:
> On Tue, Sep 23, 2025 at 3:48=E2=80=AFPM Julia Evans via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Julia Evans <julia@jvns.ca>
>>
>> From user feedback:
>>
>> - One user is confused about why `git reset --merge`
>>   (why not just `git reset`?). Handle this by mentioning
>>   `git merge --abort` and `git reset --abort` instead, which have a
>>   more obvious meaning.
>
> "git reset --merge" _can_ be helpful when merging, but won't fully
> abort a rebase. Great.
>
>> --- a/Documentation/git-pull.adoc
>> +++ b/Documentation/git-pull.adoc
>> @@ -30,15 +30,9 @@ branch. There are 4 main options for integrating t=
he remote branch:
>>  You can also set the configuration options `pull.rebase`, `pull.squa=
sh`,
>>  or `pull.ff` with your preferred behaviour.
>>
>> -In Git 1.7.0 or later, to cancel a conflicting merge, use
>> -`git reset --merge`.  *Warning*: In older versions of Git, running '=
git pull'
>> -with uncommitted changes is discouraged: while possible, it leaves y=
ou
>> -in a state that may be hard to back out of in the case of a conflict.
>> -
>> -If any of the remote changes overlap with local uncommitted changes,
>> -the merge will be automatically canceled and the work tree untouched.
>> -It is generally best to get any local changes in working order before
>> -pulling or stash them away with linkgit:git-stash[1].
>> +If there's a merge conflict during the merge or rebase that you don't
>> +want to handle, you can safely abort it with `git merge --abort` or =
`git
>> +--rebase abort`.
>
> This information is also mentioned in the advice given by conflicts
> (and git status), so while I originally wondered if we need to say "to
> know which to use, run=E2=80=A6", I now think we can trust users to kn=
ow
> whether they asked for a merge or rebase and read the advice/git
> status output when they don't.
>
> Hah, just kidding. Nobody* reads that output. But I still don't think
> it's worth muddying here, because the same folks are unlikely to see
> the help here, right? Or maybe we say "Information in `git status`
> will summarize these options for you." ?

I think it's a nice way to reiterate that `git pull` is running a merge =
or
rebase under the hood, but if folks feel strongly that this isn't releva=
nt
I'd be happy to remove the `git merge --abort` / `git rebase --abort` no=
te.
