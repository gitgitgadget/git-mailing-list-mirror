Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047DA2D24B4
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988584; cv=none; b=tegpReIXQIKEYIGHFcRysgwdbdLnfo0hgbzFmKmtUhXDv/kuY0D9XV5evIPos1Uqgj4Ulm/1IgMy7rppM01gpu+aG7wGT5dRoI+pHTExqgmHdj+No0jZjJzFx5pXdW9UFoEVnIs7I6VzFA5LQ63OIT8251YdN1kqauPwAAa1qrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988584; c=relaxed/simple;
	bh=xfj/btovupJhIcZYmUG9A0qHWbFTK7gIDWJ77M9brQQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UN5jxWN2il4mJ8ThyFpBIM9wtryiH4ss/pr9AGapfEIG82wVaoJ/OcZHeeQB5vPDRC7F8FlDEdke2HCBEFGe2EYctjq1zfVPByYvUleCo3LY8Ga/WShEZpl/ik5ncl75lFhrESMGWEmU7qsr2D9i12CT/OTSP9HW/UHc2SqmRq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=WbjLWXXP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VeZyC5qZ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="WbjLWXXP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VeZyC5qZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DE2397A007C;
	Mon, 20 Oct 2025 15:29:40 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Mon, 20 Oct 2025 15:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760988580;
	 x=1761074980; bh=GZ/usdgS30NXSYSLvEVuZfBnYrGEUz4pFGL/MnZSVcM=; b=
	WbjLWXXPLyFjMPICQkVQ6pGh/hIj7J3uIjr/4KujarJzhSYaU9QThTPf2SzSp9wA
	k7HV9WinqH2t4N6ntIdN0GEr7XRT+gmU3AbBFqrjhVlxreWK080b5Qkj9HCQj1my
	nGh0qQBAmIkpRmqINiJ0hcZLlnBTBpS6prr8BanHE6SNCjKaosT/FOmVcUzqsTJM
	ymwhIRNE/XKiMMzoHt6Wbk/823ISmJ3RRA6yDkmaXmamCGG8KF9HHs8Bggm7UjAg
	Rk3V3KpVmFFV42fpv4IbnlwuyYarCBD7aqZ42P4zk/o8ENqbnbtG6qkK40INvzX0
	wVLt4QPp7gPpByTWWe2EAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760988580; x=
	1761074980; bh=GZ/usdgS30NXSYSLvEVuZfBnYrGEUz4pFGL/MnZSVcM=; b=V
	eZyC5qZqJVasW+/KRR0gRGL8m/DnrjkM1BNTW4o8+cezSD8pF/u4e84K4Q1G1V7l
	1OAAThPN6V1e9JGvTpKegBfO33AzXDYPgTMwmfoEmXYmQfs5OlUewJ5s77MWpN7Q
	xK/LMoB5QVE+uDBazgiROUfichpZxGwQoSpj5YQKsB9hqNmSMJyM5Tcwt8GqAmdX
	uHz27y/qiNXxTOWoS6/TSxPA+FQDNVyAbOlUkh+mRw4HmQpwPySv949ec4B/axoL
	kNUtHN7ixD2BUxRC0KucrYShzOadHhUTox3SeUtALgnU59aL6FrzKBXW0vLYGJcb
	SaTPd6tCeT6FtcLL1OU+g==
X-ME-Sender: <xms:pI32aDLLEZdmznzMUzPywQgydUPGRtk5qjKxQ27qpzeG6862ojVbEg>
    <xme:pI32aB9EydhGrKoxSYXIV02t6fxisCPZZWWi2iQ3yf_9_SXRFRDZl8de6-bdTJ6EA
    Lw2jIKqIlHPamPHL935310WzvX4BsZdRLAak42MqlbW1b6G__NQQkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfluhhlihgrucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhn
    shdrtggrqeenucggtffrrghtthgvrhhnpefgveekudeviedvveeuhefhvdetgefgffdufe
    eguddtkeegtdeltdevhfdtuddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvhhnshdrtggrpdhnsggprhgtphhtthhope
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pI32aHlb_sUaX2XdYH9eHHgmQoSF9HjJhi9CdtMpQQ7CJ7aBrH1Jdg>
    <xmx:pI32aCks0v3Wa6DQPBeZA2TWgJ9nRQHHtD1-OmOzTkVJMIxEXVb-GA>
    <xmx:pI32aAsfV5TEr5bYwTYkWQE1vBxBkx9V6Nj-Pt-0Wp0Ok4GQx9jr6w>
    <xmx:pI32aNmasaH-uxaBCO-YXZNrtar3-PzaNiML1sC7_MUkzBmXUvIodA>
    <xmx:pI32aJBe8mr-bryQut12wTkpcKdo3bs5VjIrm0Gh7QmnS9uZNrW3NsQb>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 814F87800DA; Mon, 20 Oct 2025 15:29:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApwonadHW4qB
Date: Mon, 20 Oct 2025 15:29:00 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <4871df7e-4ab4-45ea-83bd-9a49e4d60561@app.fastmail.com>
In-Reply-To: <xmqqecr1xiqc.fsf@gitster.g>
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
 <6b5459b7ab478de33d17f9518906396f8a01e0d6.1760731558.git.gitgitgadget@gmail.com>
 <xmqqecr1xiqc.fsf@gitster.g>
Subject: Re: [PATCH 2/4] doc: git-reset: clarify intro
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 17, 2025, at 6:32 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Julia Evans <julia@jvns.ca>
>>
>> From user feedback, there were several points of confusion:
>>
>> - What "tree-ish", "entries", "working tree", "HEAD", and "index" mean
>>   ("I have no clue what the index is", "I've been using git for 20 years
>>   and still don't know what a tree-ish is"). Avoid using these terms
>>   where it makes sense.
>> - What "optionally modifying index and working tree to match" means
>>   ("to match what?" "optionally based on what?")
>>   Remove this from the intro, we can say it later when giving more
>>   details.
>> - One user suggested that "The <tree-ish>/<commit> defaults to HEAD
>>   in all forms." should be repeated later on, since it's easy to miss.
>>   Instead say that HEAD is the default in each case later.
>>
>> Another issue is that `git reset` consistently describes the action
>> it does as "Reset ...", commands should not use their name to describe
>> themselves, and that the word "mode" is used to mean several different
>> things on this page.
>>
>> Address these by being more clear about two use cases for `git reset`
>> ("to undo operations" and "to update staged files"), and explaining what
>> the conditions are for each case instead of forcing the user to figure
>> out the pattern is in first form vs the other 3 forms.
>>
>> Signed-off-by: Julia Evans <julia@jvns.ca>
>> ---
>>  Documentation/git-reset.adoc | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
>> index 9843682e81..876187dc83 100644
>> --- a/Documentation/git-reset.adoc
>> +++ b/Documentation/git-reset.adoc
>> @@ -3,7 +3,7 @@ git-reset(1)
>>  
>>  NAME
>>  ----
>> -git-reset - Reset current HEAD to the specified state
>> +git-reset - Set HEAD to point at the specified commit
>
> The command has dual-purpose, and it is a bit disturbing that the
> other one is not even mentioned in the original or in the updated
> text.  "The other three forms" is about resetting the index without
> moving HEAD at all.  Would this work better, I wonder?
>
>     Reset HEAD or index back to a known state

That's true, though I think we should avoid using "Reset"
to explain what `git reset` does. Perhaps

    Set HEAD or the index to a previous state

>> +`git reset [<mode>] <commit>` changes which commit HEAD points to.
>> +This makes it possible to undo various Git operations, for example
>> +commit, merge, rebase, and pull.
>
> Good.  These are prime examples of when resetting to a known state
> is useful.
>
>> +However, when you specify files or directories or pass `--patch`,
>> +`git reset` will instead update the staged version of the specified
>> +files without updating HEAD.
>
> I see no however here.
>
> Other forms are not about flipping HEAD to any state we used to have
> before.  Instead, they are about populating index entries from the
> state taken from an arbitrary tree-ish.
>
> You can view them as enhanced variants of "git reset --mixed HEAD"
> (read it as "unstage all changes").  They are enhanced in the sense
> that unlike "git reset --mixed HEAD", the treeish the index entries
> are taken from does not have to be HEAD, and also in the sense that
> unlike "git reset --mixed HEAD", you can limit the index entries to
> be affected to a subset of paths.  I am not sure it would make it
> easier to understand to explain them in terms of "reset --mixed HEAD"
> but I am reasonably sure that it would appear confusing until a
> reader realizes that the command has two very disinct mode, one that
> is primarily about HEAD, the other that is primarily about index.
>
>>  `git reset [<mode>] [<commit>]`::
>>  	This form resets the current branch head to _<commit>_ and

I agree that "git reset has two very distinct modes' is important.
Here's an idea for how to communicate that.
It doesn't fully capture all of the nuances of `git reset`'s command
line syntax, but maybe that's not the job of the intro sentence anyway.

I don't love the use of "things" in "two things" but it would be weird to
say "modes" because we already use "mode" to mean something else,
and I haven't thought of something better yet.

`git reset` does two things:

1. `git reset [<mode>] <commit>` changes which commit HEAD points to.
   This makes it possible to undo various Git operations, for example
   commit, merge, rebase, and pull.
2. When you specify files or directories or pass `--patch`, it updates
   the staged version of the specified files.
