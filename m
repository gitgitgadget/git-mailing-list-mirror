Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8982940D
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020325; cv=none; b=njtmewcFAhm+vuYGr3cX0Rwwg1vhRYaFXMOuIwOah7j1BRk7nnTqQdmfLqJam18fotLdi25Nrm8b2GEKqeZd/O4lUK6SFyyV4rsfUGryR0dYIgrVXTfspHPIDcSghJqvrrh9a3cMZNBisO0u0V2P4NzGleZpLTd6F7XC0uBzvME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020325; c=relaxed/simple;
	bh=jxLFP4QVLbiCCCgjnsAkyc77nUgV87YiUrra8NcgxvE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bK8ZRI1wFE1nIcAXLhJkjWgLlT/ydOsu9YP6crXujnukjFSTCICe4i2yMMkdTEc2xWgEWBMilT8vKNmBe0W+rgFVt06CpnGhZhn0ba5/V+9fQjQDdjWdMbyZnt4BbR3swpMMVjUnlRNZV/32bqXjng9utRzWc54wcaTRrGkY3m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=pvfTWhuG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vPfIo7sW; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="pvfTWhuG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vPfIo7sW"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id C223F1D0008A;
	Thu,  9 Oct 2025 10:32:01 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 09 Oct 2025 10:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760020321;
	 x=1760106721; bh=Pplmzq1J7PZdznRCfy0kJi+e1eHshJ/0cM3w2pBw18A=; b=
	pvfTWhuGp6LIMioNTzu6bE+yDI2o9WWADrSzvJhk/KZSdUCOwZVXksPRUMsmSn8G
	C3q50rPHC0Rl2YSeHncMNtSfLbwrhyXDc7T9H5LppKVhBNBGoobVGR2xfQP+l54J
	mBDrgil9zjbtSYHEhVm5Epbsjw4r0bKH59V/9OVydQr9B8TDR808xwpxUg/nVehm
	EFcn1DcTrvRO0fISnBAbF1KrQMNO2qn45rn3Ghf8K+w1L3mP3mX5voBYzvwuQkmy
	d0s3ZF5ZsZpvrJrCtPq6lF3N2i8G1aecZkm7xnRUP0XNk5Q8hVEDrUTOUxhOUAeG
	Ms7/5wld13PqYl8bYzLlIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760020321; x=
	1760106721; bh=Pplmzq1J7PZdznRCfy0kJi+e1eHshJ/0cM3w2pBw18A=; b=v
	PfIo7sWx+boE1eCZMm51x9bRW0MEKK/v+Ow0EKe++NjOEBnCYO6698Avp2dvDAr+
	o5mxJWgMosXHlObQvEz+bj1YvwWP551CYDF87HXC26X8mBztQ9v4SNKiKT6Zqk4F
	r6mvkIbUIFK2w8iD3i1xu0rLMwK4W2DD4MBEHnqg1FSSb0uato7F1TIO29SzZVBI
	09ccdT0U/q8oBaYs/ncuDlFrVknC1breVUWTIndJQEi3Xblz61erHVpXYqoa7gT/
	Yp4o8EIqHp9hyGuItfVrRGv1d8p0cV5L7bS0MV+8a0aruUHF9YX9M2RbRyOofBxl
	MXtNqn7BUhp+YxCKMyaQg==
X-ME-Sender: <xms:YMfnaNbPQO253oD-iw81c5d37tt0mLsUSX0_OBUMWYnuGsN-3lqE_7Y>
    <xme:YMfnaPOVKUhWJ-8eUg9dgzMeiz27cNEp_TWZP-TAC4X8p7nvfU7EZ-8XxdLRhnMrM
    N3DttgsHfW61iOJW_AqCuiuInnEUA-_I6-KQ4QNSdoQIPy3A6PQog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeigedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfef
    gfffvdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoh
    epjheitheskhgusghgrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghk
    khdrnhgrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YMfnaAA4EBaUD7y1lLx0G_cyosXM3UFJS6rzUTUoLzFAXdnrn7L9dw>
    <xmx:YMfnaN8lzuX9NCg0DBZ4JVU0BLMfaNUDeDh-PnE2sF9IAwzaB3s2zw>
    <xmx:YMfnaHGNS-JiW59LhEr1gK3rvo2aYQjZVY0eIbyuUCgO-KpJjvA48A>
    <xmx:YMfnaLOll7i_y7xjhmkYCB5D1HzPEMgp56lqLMtKYDRjLpJJ3Zkjdg>
    <xmx:YcfnaO1kTxCXV4MKkDihAvwyycoN0ki0bWCB0DcSKg2kQGRx32j2swBk>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CEE661EA0062; Thu,  9 Oct 2025 10:32:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: And9clSpnOi7
Date: Thu, 09 Oct 2025 16:31:40 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Johannes Sixt" <j6t@kdbg.org>
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>, git@vger.kernel.org
Message-Id: <aae39545-461a-44f0-b01f-bb40b53b1858@app.fastmail.com>
In-Reply-To: <3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com>
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
 <d17060d9b72.1759952528.git.code@khaugsbakk.name>
 <3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com>
Subject: Re: [PATCH] doc: warn against --committer-date-is-author-date
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025, at 15:46, Phillip Wood wrote:
> On 08/10/2025 20:45, kristofferhaugsbakk@fastmail.com wrote:
>>[snip]
>>
>> =E2=9D=A6
>
> What's this?

A thematic break.

>
>> The genesis of this option is 3f01ad66 (am: Add --committer-date-is-
>> author-date option, 2009-01-22). The commit message doesn=E2=80=99t g=
ive us an
>> example of a use case, but the thread starter does:[1]
>>
>>[snip quote]
>>
>> So the motivation was to treat git-am(1) as an import command that
>> creates the same commit IDs given the same base and committer.
>
> That seems like a reasonable thing for "git am" to do. I'd be interest=
ed
> to know what the rationale was for adding it to "git rebase". In
> retrospect I feel it was a mistake to port this option over to the
> sequencer just to match what the am based rebase did.

There isn=E2=80=99t any more discussion on the patch:

https://lore.kernel.org/git/1237399558-27289-3-git-send-email-barra_cuda=
@katamail.com/

>> [1]: https://lore.kernel.org/git/46d6db660901221441q60eb90bdge601a7a2=
50c3a247@mail.gmail.com/
>>
>>      I thought about marking it as deprecated but eventually found ou=
t why it
>>      was added. And it wasn=E2=80=99t for some (still unknown) dedica=
tion or
>>      not-explained *want* to keep the committer date and author date =
in synch
>>      just-because (as I thought[1]).
>
> We should maybe think about deprecating it for "git rebase" though as =
it
> is a lot less clear that it is sensible there. If you're rebasing a
> branch then there is a very high likely hood that the upstream committ=
er
> dates of the commits the branch is being rebased onto will be newer th=
at
> the author dates of the commits in your branch.

That makes sense. If there is no use case then it should be deprecated.

I could mark it as such in the next version.

Anyone else have an opinion on this?

>
> I've left a couple of comments below
>> diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
>> index 221070de481..c36ae679cfb 100644
>> --- a/Documentation/git-am.adoc
>> +++ b/Documentation/git-am.adoc
>> @@ -156,11 +156,18 @@ Valid <action> for the `--whitespace` option ar=
e:
>>   	See also linkgit:githooks[5].
>>
>>   --committer-date-is-author-date::
>> -	By default the command records the date from the e-mail
>> -	message as the commit author date, and uses the time of
>> -	commit creation as the committer date. This allows the
>> -	user to lie about the committer date by using the same
>> -	value as the author date.
>> +	NOTE: The history walking machinery assumes that commits have
>> +	strictly increasing commit timestamps, with some tolerance for
>> +	clock skew (see linkgit:git-rev-list[1]).
>
> Is there a particuaar section of the rev-list man page you had in mind
> here? I had a quick look and I couldn't see anything about clock skew.

No, I just thought linking to the =E2=80=9Chistory walking command=E2=80=
=9D was apropos.
I=E2=80=99ll remove it in the next version.

>
>>  You should only use
>> +	this option to lie about the committer date when applying
>
> s/lie/override/ ?

I=E2=80=99ll make that change.

>>[snip]
>> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase=
.adoc
>> index 956d3048f5a..336ee90f7e3 100644
>> --- a/Documentation/git-rebase.adoc
>> +++ b/Documentation/git-rebase.adoc
>> @@ -504,9 +504,17 @@ merge backend;;
>>   See also INCOMPATIBLE OPTIONS below.
>>
>>   --committer-date-is-author-date::
>> -	Instead of using the current time as the committer date, use
>> -	the author date of the commit being rebased as the committer
>> -	date. This option implies `--force-rebase`.
>> +	NOTE: The history walking machinery assumes that commits have
>> +	strictly increasing commit timestamps, with some tolerance for
>> +	clock skew (see linkgit:git-rev-list[1]). You should only use
>> +	this option to lie about the committer date when applying
>> +	commits on top of a base which commit is older (in terms of the
>
> The comments above apply here as well. In addition s/applying
> commits/rebasing commits/ for this command I think.

Okay, thanks.

>
>> +	commit date) than the oldest commit you are applying (in
>> +	terms of the author date).
>
> We should also warn against using this option when rearranging commits
> with "git rebase -i" as well.

Okay but what does that mean? Should this =E2=80=9Cnote=E2=80=9D call ou=
t `-i`
specifically? And if so why is that?

> Thanks for working on this, it is a very good idea to add a warning to
> the documentation for this option. I'm going to be off the list for the
> next 10 days or so, I'll look at any re-roll when I return.

Thanks for the review!
