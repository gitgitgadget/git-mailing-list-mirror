Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36013475D
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030815; cv=none; b=Ktofd/y4gtvHwXzPob7CKkcECUpbvDgNyzYzITB+2Tn0dqqN836aju/B/yHL0CwIyqXTlUtZgQRJIfRUpoPawNOi0oPP+jh/N+vB0vtDIx4MW3UbNLIUwi+QfpwGm2q3JgwYcJL7650LyZEoTI8DhRU1uaZAUrZr6rS71Ytk9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030815; c=relaxed/simple;
	bh=6RZ5zA8hQQTZRZL6Ipgkp8/mEC0c87QlgS40SCxcMsc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cwJos1YlghBayLaiEq1UlnGJRnvgykofEeC4v2emnMXuUO+to0QxvdRIz/2ZZheBjfHJfHMYRNAp1FZjDooflUck6PS0/8cawqVZKdkBjnBW1S0pkM+gE5f1znWIZbhBuLe+T2ht4K+4ATAv/Y2yqQbfyg0t0sZrBzBGEd24xYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=OAWGZYyV; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="OAWGZYyV"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708030808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4RaBNgAuWHbDMU7rDW+cthQiAXGCBYO9jdzG09ZoC4=;
	b=OAWGZYyVxrmlQNGgfj8sZIyiiiNpZWl3c13CWA/YalcCN8+MMZnX8+CMSrKcwdG0laFP2+
	Dk3e6PrRlbugxkUXh2mfB6WY0ksBmyddQe1jnEPAmco+cwcE+O94NyVKowykeybuN0Bn7T
	dBd/dY0GlT5/qxHozi3x6M8j9oA3rkNRxZj/VnQOcWbodQ8/BQlxdjrwPUkgdVMCPDjDbe
	QGJNYJ+2WM7y4z57fEtopm+owtd9Pfv6J4bSsA2v7uN7YI8Mv2IbVHaDMELVQgfohAYnYR
	HEmGYz5m/PtXfXxh3c/EhPClYAPl36CVW2ju/DdX6u9byCWp3AoS4PmDkEnTXA==
Date: Thu, 15 Feb 2024 22:00:08 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org, Kyle
 Lippincott <spectral@google.com>
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
In-Reply-To: <xmqqedddo3ym.fsf@gitster.g>
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <f9ec6d31-7158-4381-9701-06fcb33f2e83@app.fastmail.com>
 <xmqqedddo3ym.fsf@gitster.g>
Message-ID: <dbe76244979ab5747e74837b925c71af@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-02-15 21:41, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
>> (If I read this part correctly.)
>> 
>>> --m::
>>> ---move::
>>> -	Move/rename a branch, together with its config and reflog.
>>> +-m [<oldbranch>] <newbranch>::
>>> +--move [<oldbranch>] <newbranch>::
>>> +	Rename an existing branch <oldbranch>, which if not specified 
>>> defaults
>>> +	to the current branch, to <newbranch>.  The configuration variables
>> 
>> I had to read the first sentence a few times in order to understand 
>> what
>> the “which” part was saying (which seems to come from [1] by Junio). 
>> How
>> about letting it trail the sentence?
>> 
>>   « Rename an existing branch `<oldbranch>` to `<newbranch>`, with
>>     `<oldbranch>` defaulting to the current branch if not specified.
> 
> Yeah, insertion of "if not specified" in the middle made the
> resulting text unnecessarily hard to follow, and moving it to the
> end is a fine fix.  But I think we can just drop it (in other words,
> we already said "defaulting to" and that should be sufficient).

This is what seems most readable to me:

     Rename an existing branch `<oldbranch>` to `<newbranch>`;  if left
     unspecified, `<oldbranch>` defaults to the current branch.

>>> +	for the <oldbranch> branch and its reflog are also renamed 
>>> appropriately
>>> +	to be used with <newbranch>.  Renaming fails if branch <newbranch>
>>> +	already exists, but you can use `-M` or `--move --force` to 
>>> overwrite
>>> +	the files in existing branch <newbranch> while renaming.
>> 
>> “the files” refers to the branch configuration and the reflog? People
>> who read the man pages might not know that the reflogs are implemented
>> as files and get tripped up. Maybe “to overwrite” could be left
>> unstated?
> 
> Yeah, "overwrite the files in existing branch" can be mislead in
> other ways, including "in a similar way that 'checkout -f <other>'
> can overwrite the files with local modifications in the working tree
> with the <other> branch we are switching to".  We'd be better off
> not mentioning files at all [*].
> 
>     ... but you can use ... to clobber an existing `<newbranch>`.
> 
> would be sufficient.  If the verb "clobber" is unfamiliar to some
> readers, "overwrite" is also fine.  The most important part from the
> end-user's point of view is that whatever data associated with the
> name <newbranch> is now gone, and replaced by what was associated
> with the name <oldbranch>.  How we stored such data associated with
> each branch is immaterial.
> 
> 	Side note: Especially because we are not married to the
> 	files backend that stores one file per branch under
> 	.git/logs/refs/heads/ and .git/refs/heads/ directories
> 	forever.  With reftable backend, there is no such files
> 	specific to <newbranch> to be overwritten.

To me, using "clobber" actually doesn't make it more clear.  How
about wording it this way:

     Renaming fails if branch `<newbranch>` already exists, but `-M`
     or `--move --force` can be used to overwrite the contents of the
     existing branch `<newbranch>` while renaming.

To me, "overwriting an existing branch" means something like
"deleting an existing branch first, before doing anything else".
Just like in case of overwriting an existing file, which gets
deleted first, which most users are familiar with.

On the other hand, "overwriting the contents of an existing
branch", at least to me, means that the branch isn't deleted first,
but the new branch is "layered" onto it instead, overwriting some
or all of its contents.

Additionally, "its contents" removes the direct link between the
files and the branches, which should make the description future
proof.

> Another thing.  The existence of a <newbranch> is not the only case
> we fail "git branch -m [<oldbranch>] <newbranch>", but the mention
> of this particular safety valve is to tell readers that forcing with
> `-M` is how to override the safety.  We want to be absolutely clear
> that we are not trying to exhaustively enumerate failure modes [*]
> to our readers, and I am not sure if we succeeded in the proposed
> text.
> 
> 	Side note: In other words, there are other ways the command
> 	can fail, and `-M` may not be a way to "fix" these failures.
> 
>> This patch also drops this part. Shouldn’t this be noted?
>> 
>>   « , and a reflog entry is created to remember the branch renaming.
>> 
>> Right now it looks like (reads like) the reflog is moved and an entry 
>> is
>> not made about it.
> 
> True.  This was missing in my "or something like that" illustration
> and the patch copies without checking the original.  It should be
> resurrected.

Already brought this back for the v2.  It was omitted in the v1 by
an honest mistake.

> Thanks, both for writing and carefully reading.  Removal of
> <newbranch> and <oldbranch> from the OPTIONS enumaration is really
> good, too.

I'm glad that you're happy with the improvements so far. :)
