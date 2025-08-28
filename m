Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137FB3128AD
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387638; cv=none; b=UcNQp3owjkfXzp9iUp/5CuD0vnBUQDtTVax3WLrm8/SjD36b/xdb5LLbC9KpxywjfCv2GVqQfnYZjORQwv5Y7zEHYc/a4paddI8PV3V+kIqo9iTzPT7H+1tOIoV6nH79KlF9iyjUOUC/wyqycC5k/0WAidV2ytyAkVc8dqCN8JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387638; c=relaxed/simple;
	bh=O4Cb4hNCFhccqGcZf6oSZdG3/X+gtG6nGgMYc/EC7Ik=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iO+dNoHdEdCeGyoYbNapS3jo4FE2hp+Pz4mqQr6TnxWRmskyxkHo940jBo7qGELUhE9QYembbQ+zVnh0UxFjnaulzeXeCYoEwM6PFrzs7k9KweL1EjTqsus0x2Y6sHGFQmRmPHLLqGELiK3WfyX9A43wOm1BvfMAnPm0c4R0sOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=s6hs8dZu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RSRZ0kay; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="s6hs8dZu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RSRZ0kay"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 323D9EC0040;
	Thu, 28 Aug 2025 09:27:15 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Thu, 28 Aug 2025 09:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756387635;
	 x=1756474035; bh=Om7/nS5j/4u5/fHokBHwupwejgXCqWIWQMpjWLSJ+nE=; b=
	s6hs8dZul7BP+p/JPLSfnXD+gdIYa9/NXvPgZHUSNjV2ylnojOZUG0Lqq3ybuc1R
	xPS5e3nI9tmY02Y8mLr6PwmJzcYCWlWQCC+gWVis6AlX0SpzfZfu8ChWVMxe0CIy
	qGS1ZXScd8D28GZ6jvrJ9dPM0QsKg6AqnYud7oShTKeDzU1FxqBvEhJsoSgBek/F
	1OTloZb64l9LKh0u+x1Ln5dk2sFZefbJ6NXm3Ry/Lz7oSMEUTHbaBeG5FL2rKdFC
	TZjafGt04EL/lptlzF430EdmWEB9pyILJJX2dtvkMkX4JMq2RsApUrB2GKEWACLd
	A0dhKV3zsPKuJQjYc+OhNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756387635; x=
	1756474035; bh=Om7/nS5j/4u5/fHokBHwupwejgXCqWIWQMpjWLSJ+nE=; b=R
	SRZ0kayC4cNYT/t/muiilTWKndWfCtBazn6k9Ea3sQ62QoesiVFpGGxrkOKUGRE6
	q5mJsmtAVWfHlGQab8/d0OU1l1/yrJAOgM9C70g9hawdFJhJZaf7lMlb64NkOy7P
	P8kBkeL8xTN9ngkViS4pSuac678dYq+rIMnvRZbh05q/olE8IJe5XuCZ51G9cLrI
	VmXzOcAdPmNblQWZ81WyvEwnH+CBy2GJVrY/tPAdkhA/me5r2uebKOuJyiMi736q
	23aikOxbebLzrJ3eGNUy+lHmUfhLv9jxWIJSbtcu6mYMJjWkfc0LAIgPc+Lxs7f9
	YZbDoMpg9fc0HPoA72n5Q==
X-ME-Sender: <xms:MlmwaP0VpcyhMhbxsYAHuwd799IOChUWF7krx2MRwmAhv_DbIUoByQ>
    <xme:MlmwaOHGPWegqX8Izni7v9CSmW6Q_5pRU7r4cjxv00JWepkyUNpqIGxHqbDS5KML-
    8hjm3fQNfa12t_JoEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfluhhlihgrucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhn
    shdrtggrqeenucggtffrrghtthgvrhhnpefgveekudeviedvveeuhefhvdetgefgffdufe
    eguddtkeegtdeltdevhfdtuddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvhhnshdrtggrpdhnsggprhgtphhtthhope
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:M1mwaJe20b0buwpSLVdMUQZsH3WwbUNDsgp0mtsqU0Vspkin9eGPQg>
    <xmx:M1mwaOHj6-tFKyosrzLPXVC98KCM5FxZ04xXMdm9AQ1GtKYQIS0Zng>
    <xmx:M1mwaPetKZ6RFX8uhkpeOcQPIIsrbrFK0VjKTC7h1yrHdt01sVKKcQ>
    <xmx:M1mwaAEGkskPLReV35lSnCaJZYC23nzHR230sm970WHdKu_MyjeLDQ>
    <xmx:M1mwaK9pp7sKiU1wPvLPu5480Y4DaFxPe6Ch2KD208xuiWsa51A_d9GR>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E32007840CC; Thu, 28 Aug 2025 09:27:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2lJ7FwKEGVZ
Date: Thu, 28 Aug 2025 09:26:54 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <80fba886-4693-4f31-b64f-438391edc3da@app.fastmail.com>
In-Reply-To: <xmqqiki9hfg2.fsf@gitster.g>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
 <b641874627b3898831c3965616e936bd4ee310df.1756148933.git.gitgitgadget@gmail.com>
 <xmqqiki9hfg2.fsf@gitster.g>
Subject: Re: [PATCH 5/5] doc: git-checkout: clarify restoring files section
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Aug 26, 2025, at 6:43 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
>> index b343d292b30b..9f2b86ac5368 100644
>> --- a/Documentation/git-checkout.adoc
>> +++ b/Documentation/git-checkout.adoc
>> @@ -82,20 +82,21 @@ Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
>>  `git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...`::
>>  `git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]`::
>>  
>> -	Overwrite the contents of the files that match the pathspec.
>> -	When the _<tree-ish>_ (most often a commit) is not given,
>> -	overwrite working tree with the contents in the index.
>> -	When the _<tree-ish>_ is given, overwrite both the index and
>> -	the working tree with the contents at the _<tree-ish>_.
>> +	Restore another version of the file(s) that match the pathspec.
>
> The same comment about "files and directories from a different
> version" applies here.
>
> Also, I am not so sure about the claim that the verb "restore" is
> better understood than "overwrite" due to the presence of "git
> restore".  If you are working on, say, an older maintenance track,
> and want to borrow what is in a few files from the development
> branch, you may say "git restore --source=develop files..." go grab
> them down to your current working tree.  But at least to me,
> "restore" has a connotation to get back what you used to have, but
> the contents in these files you are grabbing had not existed on the
> older maintenance track you are working on, ever, and "restore" had
> always made me go "Huh?".
>
> I am not suggesting to change the command name "restore"; I am
> suggesting the operation that command does using a verb that is
> different from "restore" (in an ancient thread, we tried to explain
> "checkout" without using "checkout" as the primary verb to describe
> what it does, it is the same thing).
>
>>  +
>> -The index may contain unmerged entries because of a previous failed merge.
>> -By default, if you try to check out such an entry from the index, the
>> -checkout operation will fail and nothing will be checked out.
>> -Using `-f` will ignore these unmerged entries.  The contents from a
>
>> +If you specify a commit or tree to restore from (for example `git
>> +checkout main file.txt`), this will restore the version of the file(s)
>> +from that commit or tree. This overwrites the file in the working
>> +directory and stages the file's contents.
>
> OK.  I suspect the most common is to "restore" from HEAD, and the
> "Huh?"ness of using the verb "restore" goes away.  It clearly is
> getting you back to where you were back when your working tree was
> in sync with HEAD.  Perhaps use "git checkout HEAD file.txt" for the
> example?
>
>> +If you do not specify where to restore from (for example `git checkout
>> +file.txt`), this will replace the file(s) with the version from the index.
>
> That is a very negative way to state it.  It is not "do not specify
> where".  If you do not give tree, you are actively specifying that
> you want things from the index.
>
>> +If you check out a file with an unresolved merge
>> +conflict, the checkout operation will fail and no changes will be made.
>
> This is confusing in a way different from the original.  During a
> conflicted merge, you will see a few stages until they are resolved.
>
>  (1) The working tree file has conflict markers and text from
>      multiple variants.  The index has higher-stage cache entry for
>      such a path.
>
>  (2) The user edits the working tree file to resolve the conflicts.
>      Once all the conflict markers are removed, some people may say
>      "the merge conflict has been resolved".  To Git, the path is
>      still unmerged.
>
>  (3) The user tells the index what the resolution is, with commands
>      like "git add", "git rm", and the like.  The higher-stage cache
>      entries in the index for the path are moved and replaced with a
>      single stage-0 entry.  To Git, the path is now merged.
>
> So, "a file with an unresolved merge conflict" would not mean what
> you wanted to say for those who consider that dealing with the
> working tree files is enough to declare victory and consider the
> conflict has been resolved.
>
>> +Using `-f` will ignore the merge conflict.  The contents from a
>
> This changes the meaning to most people from what the original
> meant.  If you have a file F with merge conflicts in the earlier
> part but the later part merged cleanly, does "git checkout -f F"
> ignore the conflicted part and overwrite the rest of the file
> somehow?
>
> If you wanted to avoid the term "unmerged cache entries", you can
> say "unmerged paths".
>
> Taking all of the above into consideration, perhaps...
>
>     When you are in the middle of a conflicted merge (or
>     cherry-pick, "stash pop", etc.) and haven't told Git what the
>     resolution for these conflicted paths are with "git add" and
>     friends, using "git checkout" to check out such an unmerged path
>     out of the index would fail and the command exits with non-zero
>     exit status.
>
>     When the `-f` option is given, these unmerged paths are left
>     untouched, instead of triggering an error.  For all other
>     (i.e. merged) paths that match the <pathspec>, the working tree
>     files are overwritten by the version recorded in the index.
>
> or something along that line, but with a readability enhancement
> like you have been doing in your series ;-).

Thanks, this section of the man page is not easy and this is very
useful feedback. Will work on improving all of these points.
