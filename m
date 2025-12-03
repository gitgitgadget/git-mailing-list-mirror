Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586802E413
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764785724; cv=none; b=JA3KEcgfIeI2yWAsaCLwQgm+vM6eKWldg9rMRy9JvsWt0+AI5GUh/xJbgj9f3C3W8CS33LpL9ZdSscH1ABHbVd3tLY/17rjSRjCPY9EWt8FdFy9FI/oDGGLahM6KqvkKtE2yhIfDrNF9jJAU6z0x+iGDraGQZPEkiPTDndH2i80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764785724; c=relaxed/simple;
	bh=mBRzCjUEC7IAQGhPkPFGeMYqyCmScfGhAnCtHAWUNNs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tg4wHj5ZtfxFrld+F/cXZ7X1MKGaWflWiTnXmiSB5EMUetX3rZndrsdSiEp43xfWZkrqMlPC5yRhRVVG3/TXy1ZzYFDTe8gcyF6zA/CHfwLk0i1lqzv+FGUwplmZ2fmSLlLAOjXXXPOny6Bax6SVClpn4HfNRmFON2xidIdJHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=lTffzxAL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gCQs2FGx; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="lTffzxAL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gCQs2FGx"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 66ACF140006C;
	Wed,  3 Dec 2025 13:15:21 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Wed, 03 Dec 2025 13:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764785721;
	 x=1764872121; bh=41236dfT8/03XRlxawspGyAX6NeYcJPyvIe1fqrCFTA=; b=
	lTffzxALkmXtxh++78Li5WRMa1LmmD6isf2bVSnveQ4EQblFV7lUoIcoAkCr/vK7
	8Ya2ONnxgjyL/uH43dG45nWTZYeDAXddpiUIQIa4E1xUoUVrCMRaMEUAzKFiefT9
	OnM9UZIfnbmM+e66aWEA47wTSIPYUJBVLgOLZtzTUpMJMTmNezASeMgnSx9m4ItX
	awzdM2sj0XgWhWteB6j4CBrXx9NFWY9U7Hdkl2W7zyqy2ex6KKHIimktTxcNezKJ
	V9r3B7BCZJgDviOwtEAuutW/ffQ6jyJGO9GGwX44CdG7HgQ0irFWnpGL0o3JPe3K
	NmPxRo1JKnQoz9iw75VQbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764785721; x=
	1764872121; bh=41236dfT8/03XRlxawspGyAX6NeYcJPyvIe1fqrCFTA=; b=g
	CQs2FGxpb3qket39Ps4Gdrq8WJJapOWzc4eukgGSZkayj2aXVpH3kbVwnvMe0Zt2
	kuGVGlSrk2s/09YQ4ppW3SaM20UjTqCJkS26L7K6IS+eA0Ugeop0Jj1W86RdPoSM
	I5CzZlN1g6dZnY5eI0J7Yj1aZDOKzy/1ssWhNTDJ/EWUAPkxOuSkUwb6Jvhxj6Bt
	RFHQLuqk8r+IkpRBc/dPeetwSggHHecLAQM4TO2Farvsvon2wDvVoPB1Qp6aC5zk
	IdMO20N+G8BiRLwkIq2g2+Edm4eRTbEeFroEdUGYgI+Ag+UaRKdxNtfe2rkFQtt0
	9mjxPoTxAWQvWDW0fztBg==
X-ME-Sender: <xms:OX4waR7DMZpAEboMV7Voha4AD7jURNJgrZa1BLILpTpHtRb0hTdKYQ>
    <xme:OX4waZvbsxtMqtGrf5gJi6akGmvFO4-zNCfDE4fz1R1H80ktnAtj4Baf61hOVVgOR
    VNIW75nMtxCzVUDG9f-eaocusTNcsW-7c9F7gtv6AOJplq-ljmuv7f->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhirgcu
    gfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnhepgf
    evkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirgesjh
    hvnhhsrdgtrgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:OX4waeg52oBNrKfBt5vADV5ngObgDFtlJuRWe8zg2ggVH-_Ywoh2Hg>
    <xmx:OX4wac0l8Vc15SED_NqQEeFjZFV0YzGHPVFH3fAHAOHrK-AuQROd1A>
    <xmx:OX4waQh84GXlF8sNylnT-Mbv0ExBcKfYaickXHaEr5CsE_OpjExPww>
    <xmx:OX4waUdN-qXwarX4RBVTp0Czg5VdjxEg5_6yQH6Mo1p5cYXLGArrpg>
    <xmx:OX4waTmeRBSm-xAQI0V2ZHchdxtHFMbUe3cFewkeDBBjS3cNpgkN2oMB>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 347F178006C; Wed,  3 Dec 2025 13:15:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApwonadHW4qB
Date: Wed, 03 Dec 2025 13:15:01 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <b09c955f-06d1-4dcd-949d-cc723a9604ac@app.fastmail.com>
In-Reply-To: <4871df7e-4ab4-45ea-83bd-9a49e4d60561@app.fastmail.com>
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
 <6b5459b7ab478de33d17f9518906396f8a01e0d6.1760731558.git.gitgitgadget@gmail.com>
 <xmqqecr1xiqc.fsf@gitster.g>
 <4871df7e-4ab4-45ea-83bd-9a49e4d60561@app.fastmail.com>
Subject: Re: [PATCH 2/4] doc: git-reset: clarify intro
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I was hoping to be able to finish this, but I don't have funding to
work on the Git docs (I imagine like everyone else who works on them! :) )
and the time I budgeted to do this work has run out for now.

It's been really interesting to get to dig into the Git documentation
and I really appreciate all of the reviews & encouragement along the way.

all the best,
Julia

On Mon, Oct 20, 2025, at 3:29 PM, Julia Evans wrote:
> On Fri, Oct 17, 2025, at 6:32 PM, Junio C Hamano wrote:
>> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Julia Evans <julia@jvns.ca>
>>>
>>> From user feedback, there were several points of confusion:
>>>
>>> - What "tree-ish", "entries", "working tree", "HEAD", and "index" mean
>>>   ("I have no clue what the index is", "I've been using git for 20 years
>>>   and still don't know what a tree-ish is"). Avoid using these terms
>>>   where it makes sense.
>>> - What "optionally modifying index and working tree to match" means
>>>   ("to match what?" "optionally based on what?")
>>>   Remove this from the intro, we can say it later when giving more
>>>   details.
>>> - One user suggested that "The <tree-ish>/<commit> defaults to HEAD
>>>   in all forms." should be repeated later on, since it's easy to miss.
>>>   Instead say that HEAD is the default in each case later.
>>>
>>> Another issue is that `git reset` consistently describes the action
>>> it does as "Reset ...", commands should not use their name to describe
>>> themselves, and that the word "mode" is used to mean several different
>>> things on this page.
>>>
>>> Address these by being more clear about two use cases for `git reset`
>>> ("to undo operations" and "to update staged files"), and explaining what
>>> the conditions are for each case instead of forcing the user to figure
>>> out the pattern is in first form vs the other 3 forms.
>>>
>>> Signed-off-by: Julia Evans <julia@jvns.ca>
>>> ---
>>>  Documentation/git-reset.adoc | 13 ++++++++-----
>>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
>>> index 9843682e81..876187dc83 100644
>>> --- a/Documentation/git-reset.adoc
>>> +++ b/Documentation/git-reset.adoc
>>> @@ -3,7 +3,7 @@ git-reset(1)
>>>  
>>>  NAME
>>>  ----
>>> -git-reset - Reset current HEAD to the specified state
>>> +git-reset - Set HEAD to point at the specified commit
>>
>> The command has dual-purpose, and it is a bit disturbing that the
>> other one is not even mentioned in the original or in the updated
>> text.  "The other three forms" is about resetting the index without
>> moving HEAD at all.  Would this work better, I wonder?
>>
>>     Reset HEAD or index back to a known state
>
> That's true, though I think we should avoid using "Reset"
> to explain what `git reset` does. Perhaps
>
>     Set HEAD or the index to a previous state
>
>>> +`git reset [<mode>] <commit>` changes which commit HEAD points to.
>>> +This makes it possible to undo various Git operations, for example
>>> +commit, merge, rebase, and pull.
>>
>> Good.  These are prime examples of when resetting to a known state
>> is useful.
>>
>>> +However, when you specify files or directories or pass `--patch`,
>>> +`git reset` will instead update the staged version of the specified
>>> +files without updating HEAD.
>>
>> I see no however here.
>>
>> Other forms are not about flipping HEAD to any state we used to have
>> before.  Instead, they are about populating index entries from the
>> state taken from an arbitrary tree-ish.
>>
>> You can view them as enhanced variants of "git reset --mixed HEAD"
>> (read it as "unstage all changes").  They are enhanced in the sense
>> that unlike "git reset --mixed HEAD", the treeish the index entries
>> are taken from does not have to be HEAD, and also in the sense that
>> unlike "git reset --mixed HEAD", you can limit the index entries to
>> be affected to a subset of paths.  I am not sure it would make it
>> easier to understand to explain them in terms of "reset --mixed HEAD"
>> but I am reasonably sure that it would appear confusing until a
>> reader realizes that the command has two very disinct mode, one that
>> is primarily about HEAD, the other that is primarily about index.
>>
>>>  `git reset [<mode>] [<commit>]`::
>>>  	This form resets the current branch head to _<commit>_ and
>
> I agree that "git reset has two very distinct modes' is important.
> Here's an idea for how to communicate that.
> It doesn't fully capture all of the nuances of `git reset`'s command
> line syntax, but maybe that's not the job of the intro sentence anyway.
>
> I don't love the use of "things" in "two things" but it would be weird to
> say "modes" because we already use "mode" to mean something else,
> and I haven't thought of something better yet.
>
> `git reset` does two things:
>
> 1. `git reset [<mode>] <commit>` changes which commit HEAD points to.
>    This makes it possible to undo various Git operations, for example
>    commit, merge, rebase, and pull.
> 2. When you specify files or directories or pass `--patch`, it updates
>    the staged version of the specified files.
