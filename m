Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8802DC779
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991849; cv=none; b=sioOLt/c+6Bfqs67LsIyL1pRMwCgwyv6AD3I5nEfojR0t1Ijiy1TPwFGW1kY/N7gt0GnrQXCQ7uJy/HzsOZ7hiE8EC4A8v4RQDKF7xYjhdAQVSZhLURyxug9BLpcUSFWcuz3nPA8cxX6sw9Uk8EpOOPzltWKTEt8QuFP2qfskPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991849; c=relaxed/simple;
	bh=KHB3xRgkyaaRjnXFZw4aU3ZCrmmwljsHsbcfswktHhM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FExi16nvo6XRIUWmw1bgmsP6aZXVSGTRdqXS31Cl610HI19IBRB/++HonhYcXne4JN4SeBWXL/pZgb4PJMvX+QzeDrx1w066bmq53nZWPOLH6Qiw+YkbeZUaVb7II6ssSvfuu2vl2Dj0iO4ri1xWDAtlfmjBQEV07XfIBwyOHIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=S2tGNIaU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vzEZpSKY; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="S2tGNIaU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vzEZpSKY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DB6411D00172;
	Mon, 20 Oct 2025 16:24:04 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Mon, 20 Oct 2025 16:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760991844;
	 x=1761078244; bh=D+0r0YD/cuze9CQZsuHSd001uQBuf2y0ZR36tglIal4=; b=
	S2tGNIaUGzLiKpbryV9jujkwkME0xHe7UpI4EcyJ/7aaJDhxPAH6O5fc0L3UgDqJ
	+IDCIoKDt0nCCUWTc1c4CFLUhDnx6NCFjf7sHc6gkMZPKiNIt1rV6qVvP8ve7uHy
	DagKOcaNY+XROkV7e7fwGlK1fjwV+bTwxAWuU2Yj+FqRUVKbrxytaRgg1malTpCD
	gwtAhyb5mnDCmm/D/GnHe4iwlRrDlJf13BKQpnE9OO3boDqp/ZB8ByTRRoBHN8BT
	H4JL1FGD9m3foOifA7kaUDBkUJkZxQta8QE+yLQ/GGxBxCCJLanGhVBkoNan23sz
	zCECC7aMi9MA2/Upoh4zwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760991844; x=
	1761078244; bh=D+0r0YD/cuze9CQZsuHSd001uQBuf2y0ZR36tglIal4=; b=v
	zEZpSKYMcdK0blf0WUb3Jvk33qJE4Xf0Z5i36XoH7+VogO4AH6yZoW0wUdB5+g2O
	cYVqlLMXKn74H5qD70gzAr2ROngOxT2GIUFPpxuCS+2WbR7MozJwdS5LLZU5AiAW
	kZHD6auGmm54pGA7+z3ziHwURoabkx40VC+MYks4rBS+UNVjxT2U9vIRZ0Yd8zM4
	Jt56yWjemBaZi24qaRPrpguy1o0UM9k5ADliGtD918Zh+9bY/IiJXymG7hXh6qJ6
	ydYVP/a/yvdZhJnTZ3DgQiskpC8Tz14NNOrQbkqqoYLmGuOts+xDu3Pj8+TM5Cwv
	7rn6Hmq0AQfFY0FgPUuCg==
X-ME-Sender: <xms:ZJr2aAxNKK7W5dCTPkhJghoA7TG23BhHnZmBLca_JicDBE_Mu5_80g>
    <xme:ZJr2aPFpAKeM0RTwTyM6EmSQG2LxmfbDSkQB39BeOSQl8OoWwvnahpWqLlk3vXn0w
    KPNb0n2DAiPD3jdWuvT-1MmzSphmlUaBdOmGbm9m8EV_RDFle_3sWk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfluhhlihgrucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhn
    shdrtggrqeenucggtffrrghtthgvrhhnpefgveekudeviedvveeuhefhvdetgefgffdufe
    eguddtkeegtdeltdevhfdtuddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvhhnshdrtggrpdhnsggprhgtphhtthhope
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZJr2aAO1MJ-owKsAZYEY_KbJvqT3UMap_cYL8cQEL4OZ_d6SUdkDpg>
    <xmx:ZJr2aOtH7OvbHYI10JvbIFk9BJNtX1A7zPgYz9lO92335pW3iFs0fA>
    <xmx:ZJr2aKU8PT0VVexe67iMVTAtfoLFvvS6JLjli60y9OrRWo_ZDynTGw>
    <xmx:ZJr2aGuRPCBm1UVc4dzRCHYG6qEdFXMReGyClq6cf_620nRa-aYmHg>
    <xmx:ZJr2aAoz05skvqIliv_uq04mogtx9OFFKU4GlbPJ1z8p_KCTuTJEnN4q>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7224378016F; Mon, 20 Oct 2025 16:24:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKajl7pqOL4V
Date: Mon, 20 Oct 2025 16:23:44 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <a6d94c76-c9fe-4688-8eea-3bbab2b5dc07@app.fastmail.com>
In-Reply-To: <xmqqy0p8x12c.fsf@gitster.g>
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
 <597ea0f5ce24967974358e18603265b14322ba54.1760731558.git.gitgitgadget@gmail.com>
 <xmqqy0p8x12c.fsf@gitster.g>
Subject: Re: [PATCH 3/4] doc: git-reset: clarify `git reset [mode]`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Oct 18, 2025, at 12:53 AM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +`--soft`::
>> +	Leaves your working directory unchanged. The index is left unchanged,
>
> Why not "leave your working tree files and the index unchanged"?

The reason I say "working directory" instead of "working tree" is that
I've seen a few comments from users saying that they don't know
what "working tree" means. I'm still not sure what the reason for
calling it a "working tree" is.

The reason for keeping them separate sentences is just for symmetry with
the other commands, and also because (like I mentioned in the commit
message) "leaving X and Y unchanged" makes it sound like leaving X and
Y unchanged is a "neutral operation", while actually leaving the index
unchanged while updating HEAD is actually a fairly weird thing to do.

>> +	so everything in your current commit will be staged.
>
> Hmph, if a reader still has the "stage the changes" mental model,
> then this would be true only when you are resetting to HEAD~1 (this
> is one of the reasons why I am hesitant to overuse the verb
> "stage").  If you are going to HEAD~5, such a reader would say that
> the changes made by the past 5 commits are staged, not just the
> commit you are on before resetting.

That's fair. I'll try to think about whether there's a better way to say
this.

Previously it said "This leaves all your changed files
"Changes to be committed", as git status would put it.", which has the
same issue ("changed files" since when exactly?).
Maybe I can fix this by being more explicit about which changes
exactly will show up as "staged" in `git status`.

>> +	For example, if you have no staged changes, you can use
>> +	`git reset --soft HEAD~5; git commit`
>> +	to combine the last 5 commits into 1 commit.
>
> Another thing that may be worth mentioning is that you can do this
> even with local changes in the working tree, because you do not give
> "-a" to the final "git commit".

Maybe! I'm not sure if we want to encourage doing complex Git operations
with unstaged changes though. I feel like it often leads to suffering
and I think people who want to do that can already infer that it's
possible.

>>  `--hard`::
>> -	Resets the index and working tree. Any changes to tracked files in the
>> -	working tree since _<commit>_ are discarded.  Any untracked files or
>> -	directories in the way of writing any tracked files are simply deleted.
>> +	Overwrites all files and directories with the version from _<commit>_,
>> +	and may overwrite untracked files.
>> +	Updates the index to match the new HEAD, so nothing will be staged.
>
> One thing that may be worth saying is that the paths in the working
> tree that are tracked in the index that are not in <commit> will
> disappear.

Interesting, I don't think I knew that. Would this be a more accurate
description of what `git reset --hard` does, conceptually?
I want to make sure I understand how it works.

1. List every file that's either in the target commit or in the index
2. For each file, make it match the target commit
    (overwriting untracked files if necessary)

>>  `--merge`::
>> +	Mainly exists for backwards compatibility: `git merge --abort` is the
>> +	usual way to abort a merge. See linkgit:git-merge[1] for the differences.
>
> There are operations that are not "git merge" that can leave the
> index in an unmerged state, and you do not want to use "git merge
> --abort" to get out of such a state, I would imagine.  So I have a
> feeling that we are better off without these two lines.

Do you mean `git reset` and `git cherry-pick`, or are there other operations
that can leave the operation in an unmerged state?
My mental model is that if there's a merge conflict, the best way to deal with it
is to use the appropriate `--abort` command (depending on how you got there),
because the command-specific `--abort` will know how to do things like
restore autostashed changes. But I agree that just saying "use `git merge --abort`
is not a complete description.

>>  	Resets the index and updates the files in the working tree that are
>>  	different between _<commit>_ and `HEAD`, but keeps those which are
>>  	different between the index and working tree (i.e. which have changes
>>  	which have not been added).
>>  	If a file that is different between _<commit>_ and the index has
>>  	unstaged changes, reset is aborted.
>> -+
>> -In other words, `--merge` does something like a `git read-tree -u -m <commit>`,
>> -but carries forward unmerged index entries.
>
> I do not mind losing this.  Unlike the time back when these two
> lines were written, nobody knows (and more importantly, nobody has
> to know) what "read-tree -u -m" does, these days.

Thanks, it's useful for me to know more about the context at the time
this was written.
